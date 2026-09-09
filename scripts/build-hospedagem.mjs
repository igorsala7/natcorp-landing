/**
 * Gera HOSPEDAGEM.html: a documentação de publicação em UM arquivo só.
 *
 * Por que um arquivo único, e não uma página do site: a empresa de hospedagem
 * precisa ler a documentação ANTES de publicar o site. Uma página em
 * www.natcorp.com.br/hospedagem só existiria depois de o trabalho estar feito —
 * o documento não pode depender daquilo que ele mesmo ensina a fazer.
 *
 * Então tudo entra no HTML: React, o CSS compilado e os dois arquivos da fonte
 * Manrope em base64. O resultado abre com duplo clique, sem servidor, sem
 * internet e sem instalar nada; pode ir por e-mail, por WhatsApp ou numa pasta
 * de rede.
 *
 * A fonte precisa de tratamento à parte: `src/fonts.css` aponta para
 * `/fonts/*.woff2`, um caminho absoluto que o Vite não toca por ser da pasta
 * pública. Num arquivo aberto de `file://` esse caminho não existe, e a página
 * abriria com a tipografia errada. Por isso a troca por data URI aqui embaixo.
 */
import { readdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs'
import { resolve } from 'node:path'
import react from '@vitejs/plugin-react'
import { build } from 'vite'

const root = resolve(import.meta.dirname, '..')
const outDir = resolve(root, '.tmp-hospedagem')
const destino = resolve(root, 'HOSPEDAGEM.html')

await build({
  /*
   * `configFile: false` é obrigatório aqui.
   *
   * O vite.config.ts do site divide o bundle em pedaços de longa duração (react,
   * motion), o que é certo para um site com muitas páginas e errado para um
   * arquivo único: os pedaços viram `import` para arquivos que não existem mais
   * depois de embutir, e a página abre em branco. Então esta configuração é
   * autônoma, como o arquivo que ela gera.
   */
  configFile: false,
  root: resolve(root, 'src/standalone'),
  base: './',
  logLevel: 'warn',
  plugins: [react()],
  resolve: { alias: { '@': resolve(root, 'src') } },
  build: {
    outDir,
    emptyOutDir: true,
    target: 'es2022',
    // Um arquivo só: nada de dividir em pedaços nem de CSS à parte.
    cssCodeSplit: false,
    assetsInlineLimit: Number.MAX_SAFE_INTEGER,
    rollupOptions: { input: resolve(root, 'src/standalone/hospedagem.html') },
  },
})

/* Mais de um .js significa que voltou a haver divisão em pedaços: embutir um só
   deixaria a página em branco, e é melhor falhar aqui do que entregar assim. */
const emitidos = readdirSync(resolve(outDir, 'assets')).filter((f) => f.endsWith('.js'))
if (emitidos.length !== 1) throw new Error(`build-hospedagem: esperava 1 arquivo JavaScript, veio ${emitidos.length}: ${emitidos.join(', ')}`)

let html = readFileSync(resolve(outDir, 'hospedagem.html'), 'utf8')

/** Cada `url('/fonts/x.woff2')` vira o arquivo em base64, dentro do próprio CSS. */
function embutirFontes(css) {
  return css.replace(/url\(['"]?\/fonts\/([^'")]+)['"]?\)/g, (_, arquivo) => {
    const bytes = readFileSync(resolve(root, 'public/fonts', arquivo))
    return `url(data:font/woff2;base64,${bytes.toString('base64')})`
  })
}

const css = [...html.matchAll(/<link[^>]+href="\.\/([^"]+\.css)"[^>]*>/g)]
const js = [...html.matchAll(/<script[^>]+src="\.\/([^"]+\.js)"[^>]*><\/script>/g)]
if (!js.length) throw new Error('build-hospedagem: o build não emitiu JavaScript')

/**
 * Troca a tag pelo conteúdo, sem deixar o texto ser reinterpretado.
 *
 * `String.replace` com uma STRING de substituição trata `$&`, `` $` ``, `$'` e
 * `$1` como padrões — e o código minificado do React contém `$&` de verdade (é a
 * fuga de caracteres das chaves de lista). Passando uma FUNÇÃO, tudo vira texto
 * literal. Com string, o resultado era a tag original reaparecendo no meio do
 * bundle e a página abrindo em branco.
 */
const trocar = (alvo, conteudo) => {
  html = html.replace(alvo, () => conteudo)
}

for (const [tag, arquivo] of css) {
  const conteudo = embutirFontes(readFileSync(resolve(outDir, arquivo), 'utf8'))
  trocar(tag, `<style>\n${conteudo}\n</style>`)
}

for (const [tag, arquivo] of js) {
  const conteudo = readFileSync(resolve(outDir, arquivo), 'utf8')
  // Um `</script>` dentro do código fecharia a tag antes da hora.
  trocar(tag, `<script type="module">\n${conteudo.replace(/<\/script>/g, '<\\/script>')}\n</script>`)
}

/* O preload aponta para o arquivo que acabou de ser embutido: agora só sobra. */
html = html.replace(/<link[^>]+rel="modulepreload"[^>]*>\s*/g, '')

/*
 * Se sobrou algum caminho para arquivo externo, o "autônomo" é mentira — e a
 * hospedagem descobriria isso abrindo uma página quebrada.
 *
 * A conferência ignora o miolo de <script> e <style>: lá dentro há concatenação
 * de strings em JavaScript que se parece com atributo HTML e daria alarme falso.
 */
const soMarcacao = html.replace(/<script[\s\S]*?<\/script>/g, '').replace(/<style[\s\S]*?<\/style>/g, '')
const pendencias = [...soMarcacao.matchAll(/(?:src|href)="(?!data:|https?:|#|mailto:|tel:)([^"]+)"/g)].map((m) => m[1])
if (pendencias.length) throw new Error(`build-hospedagem: ainda depende de arquivo externo: ${[...new Set(pendencias)].join(', ')}`)

writeFileSync(destino, html)
rmSync(outDir, { recursive: true, force: true })

const kb = Math.round(Buffer.byteLength(html) / 1024)
console.log(`hospedagem: HOSPEDAGEM.html (${kb} kB, autônomo — abre com duplo clique)`)
