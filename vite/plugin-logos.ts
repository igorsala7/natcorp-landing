import { existsSync, mkdirSync, readdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs'
import path from 'node:path'
import type { Plugin } from 'vite'

/**
 * Grava e apaga os logotipos dos clientes a partir da tela /admin/portais.
 *
 * SÓ EXISTE EM DESENVOLVIMENTO (`apply: 'serve'`). O site publicado é estático:
 * não há servidor para receber upload, e é por isso que o botão some no build.
 * Isso não é limitação a contornar — é o desenho certo. O logotipo precisa ser
 * COMITADO para chegar ao ar; gravar direto no servidor de produção criaria um
 * arquivo que o próximo deploy apagaria, sem aviso.
 *
 * O laço fica: sobe aqui → o arquivo aparece em `git status` → você comita.
 * O mesmo que já vale para o `portais.ts` que a tela gera.
 */

const PASTA = 'public/sistema/portais/arquivos/logos'
const ROTA = '/__logos'
const ROTA_DADOS = '/__portais'
const ARQUIVO_DADOS = 'src/content/portais.ts'

/** Só o que o quadro do hero sabe exibir. */
const TIPOS: Record<string, string> = {
  'image/svg+xml': 'svg',
  'image/png': 'png',
  'image/jpeg': 'jpg',
  'image/webp': 'webp',
}

const LIMITE_BYTES = 2 * 1024 * 1024

/** O slug vem da URL e vira caminho: sem esta trava, `../../` sairia da pasta. */
const SLUG_VALIDO = /^[a-z0-9-]{1,40}$/

const responder = (res: import('node:http').ServerResponse, status: number, corpo: unknown) => {
  res.statusCode = status
  res.setHeader('content-type', 'application/json; charset=utf-8')
  res.end(JSON.stringify(corpo))
}

/** Apaga o que houver, para que subir um logo novo SUBSTITUA o anterior mesmo
 *  quando a extensão muda (logo.png no lugar de logo.svg). O .gitkeep fica. */
function limparPasta(dir: string) {
  if (!existsSync(dir)) return
  for (const nome of readdirSync(dir)) {
    if (nome === '.gitkeep') continue
    rmSync(path.join(dir, nome), { force: true })
  }
}

export function logosPortais(): Plugin {
  return {
    name: 'natcorp-logos-portais',
    apply: 'serve',
    configureServer(server) {
      /**
       * Grava o array `clientes` dentro de src/content/portais.ts.
       *
       * Substitui SÓ esse bloco: tipos, `sistemas`, `copy` e os utilitários do
       * arquivo continuam onde estão. Reescrever o arquivo inteiro faria o diff
       * do git perder o sentido — a mudança real sumiria no meio.
       */
      server.middlewares.use(ROTA_DADOS, (req, res) => {
        if (req.method !== 'POST') return responder(res, 405, { ok: false, erro: 'método não suportado' })

        const pedacos: Buffer[] = []
        let total = 0
        req.on('data', (c: Buffer) => {
          total += c.length
          if (total > LIMITE_BYTES) {
            responder(res, 413, { ok: false, erro: 'conteúdo acima de 2 MB' })
            req.destroy()
            return
          }
          pedacos.push(c)
        })
        req.on('end', () => {
          if (res.writableEnded) return
          try {
            const bloco = Buffer.concat(pedacos).toString('utf8')
            const marca = 'export const clientes: Cliente[] = ['
            if (!bloco.startsWith(marca)) {
              return responder(res, 400, { ok: false, erro: 'conteúdo não começa pelo array de clientes' })
            }

            const caminho = path.resolve(server.config.root, ARQUIVO_DADOS)
            const atual = readFileSync(caminho, 'utf8')
            const ini = atual.indexOf(marca)
            if (ini < 0) return responder(res, 500, { ok: false, erro: 'array de clientes não encontrado no arquivo' })

            // fecha no colchete que casa com o de abertura, e não no primeiro `]`
            let prof = 0
            let fim = -1
            for (let i = ini + marca.length - 1; i < atual.length; i++) {
              const ch = atual[i]
              if (ch === '[') prof++
              else if (ch === ']') {
                prof--
                if (prof === 0) {
                  fim = i + 1
                  break
                }
              }
            }
            if (fim < 0) return responder(res, 500, { ok: false, erro: 'não achei o fim do array' })

            writeFileSync(caminho, atual.slice(0, ini) + bloco.trimEnd() + atual.slice(fim))
            responder(res, 200, { ok: true })
          } catch (e) {
            responder(res, 500, { ok: false, erro: String(e) })
          }
        })
      })

      server.middlewares.use(ROTA, (req, res) => {
        const slug = decodeURIComponent((req.url ?? '/').split('?')[0]).replace(/^\//, '')
        if (!SLUG_VALIDO.test(slug)) return responder(res, 400, { ok: false, erro: 'slug inválido' })

        const dir = path.resolve(server.config.root, PASTA, slug)
        // Cinto e suspensório: mesmo com o slug validado, confere que o caminho
        // resolvido continua dentro da pasta de logotipos.
        const raiz = path.resolve(server.config.root, PASTA)
        if (!dir.startsWith(raiz + path.sep)) return responder(res, 400, { ok: false, erro: 'caminho fora da pasta' })

        if (req.method === 'GET') {
          // Quem tem logotipo é quem tem arquivo na pasta. Sem isto, subir um
          // logo e recarregar a tela antes de comitar o portais.ts deixaria o
          // arquivo órfão: presente no disco e invisível na tela.
          const arquivo = existsSync(dir)
            ? (readdirSync(dir).find((n) => n !== '.gitkeep') ?? null)
            : null
          return responder(res, 200, { ok: true, arquivo })
        }

        if (req.method === 'DELETE') {
          limparPasta(dir)
          return responder(res, 200, { ok: true })
        }

        if (req.method !== 'POST') return responder(res, 405, { ok: false, erro: 'método não suportado' })

        const tipo = String(req.headers['content-type'] ?? '').split(';')[0].trim()
        const ext = TIPOS[tipo]
        if (!ext) return responder(res, 415, { ok: false, erro: `tipo não aceito: ${tipo || 'desconhecido'}` })

        const pedacos: Buffer[] = []
        let total = 0
        req.on('data', (c: Buffer) => {
          total += c.length
          if (total > LIMITE_BYTES) {
            responder(res, 413, { ok: false, erro: 'arquivo acima de 2 MB' })
            req.destroy()
            return
          }
          pedacos.push(c)
        })
        req.on('end', () => {
          if (res.writableEnded) return
          try {
            mkdirSync(dir, { recursive: true })
            limparPasta(dir)
            const arquivo = `logo.${ext}`
            writeFileSync(path.join(dir, arquivo), Buffer.concat(pedacos))
            responder(res, 200, { ok: true, arquivo })
          } catch (e) {
            responder(res, 500, { ok: false, erro: String(e) })
          }
        })
      })
    },
  }
}
