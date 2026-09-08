import { useEffect, useMemo, useRef, useState } from 'react'
import { Link } from 'react-router'
import { AlertTriangle, Check, Copy, Download, ExternalLink, ImageOff, Loader2, Plus, RefreshCw, Save, Trash2, Upload } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { PageTransition } from '@/components/motion/PageTransition'
import { useSeo } from '@/hooks/useSeo'
import {
  clientes as clientesIniciais,
  sistemas,
  urlEsperada,
  urlLogo,
  pastaDoCliente,
  type Ambiente,
  type Cliente,
  type SistemaKey,
} from '@/content/portais'

const AMBIENTES: Ambiente[] = ['prod', 'dev']

/** Servidor de desenvolvimento presente? É ele que grava o arquivo. */
const EM_DESENVOLVIMENTO = import.meta.env.DEV

/**
 * Parametrização dos portais por cliente.
 *
 * O QUE ESTA TELA NÃO FAZ: gravar. O site é estático — não existe servidor
 * para escrever em `src/content/portais.ts`. A tela edita em memória e monta o
 * conteúdo novo do arquivo para você copiar ou baixar; quem comita é uma
 * pessoa, e o deploy sai do commit. Prometer "salvar" aqui seria mentira, e a
 * pessoa só descobriria ao ver que nada mudou no ar.
 */
export default function PortalAdminPage() {
  useSeo({
    title: 'Portais — parametrização | Natcorp',
    description: 'Parametrização dos portais por cliente.',
    path: '/admin/portais',
    noindex: true,
  })

  const [clientes, setClientes] = useState<Cliente[]>(() => structuredClone(clientesIniciais))

  /* O disco manda sobre o arquivo: se alguém subiu um logotipo e ainda não
     comitou o portais.ts, o arquivo está lá e a tela precisa saber. Sem isto o
     logo ficaria órfão — presente na pasta, invisível aqui. */
  useEffect(() => {
    if (!EM_DESENVOLVIMENTO) return
    let vivo = true
    void Promise.all(
      clientesIniciais.map(async (c) => {
        try {
          const r = await fetch(`/__logos/${c.slug}`)
          const d = (await r.json()) as { arquivo?: string | null }
          return [c.slug, d.arquivo ?? null] as const
        } catch {
          return [c.slug, c.logo] as const
        }
      }),
    ).then((pares) => {
      if (!vivo) return
      const noDisco = new Map(pares)
      setClientes((atual) => atual.map((c) => ({ ...c, logo: noDisco.get(c.slug) ?? null })))
    })
    return () => {
      vivo = false
    }
  }, [])
  const [copiado, setCopiado] = useState(false)
  const [salvando, setSalvando] = useState(false)
  const [erroSalvar, setErroSalvar] = useState<string | null>(null)

  const alterar = (slug: string, mudanca: Partial<Cliente>) =>
    setClientes((atual) => atual.map((c) => (c.slug === slug ? { ...c, ...mudanca } : c)))

  const arquivo = useMemo(() => gerarArquivo(clientes), [clientes])
  const mudou = useMemo(() => JSON.stringify(clientes) !== JSON.stringify(clientesIniciais), [clientes])

  /* Grava src/content/portais.ts pelo servidor de desenvolvimento. Depois de
     escrever, o Vite recarrega o módulo: `clientesIniciais` passa a ser o que
     está no disco e o aviso de alterações se apaga sozinho. */
  const salvar = async () => {
    setSalvando(true)
    setErroSalvar(null)
    try {
      const r = await fetch('/__portais', {
        method: 'POST',
        headers: { 'content-type': 'text/plain;charset=utf-8' },
        body: arquivo,
      })
      const d = (await r.json()) as { ok?: boolean; erro?: string }
      if (!d.ok) throw new Error(d.erro ?? 'falha ao gravar')
    } catch (e) {
      setErroSalvar(e instanceof Error ? e.message : 'falha ao gravar')
    } finally {
      setSalvando(false)
    }
  }

  const copiar = async () => {
    try {
      await navigator.clipboard.writeText(arquivo)
      setCopiado(true)
      window.setTimeout(() => setCopiado(false), 2000)
    } catch {
      setCopiado(false)
    }
  }

  const baixar = () => {
    const blob = new Blob([arquivo], { type: 'text/plain;charset=utf-8' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = 'portais.ts'
    a.click()
    URL.revokeObjectURL(url)
  }

  return (
    <PageTransition>
      <div className="min-h-screen bg-brand-off-white pb-24">
        <header className="border-b border-brand-mist bg-white">
          <div className="mx-auto max-w-6xl px-5 py-8 sm:px-8">
            <h1 className="text-2xl font-extrabold tracking-brand text-brand-ink">Portais por cliente</h1>
            <p className="mt-2 max-w-2xl text-[13.5px] leading-relaxed text-brand-graphite">
              Cada cliente vira a página <code className="rounded bg-brand-off-white px-1 py-0.5 text-[12.5px]">/portais/&lt;slug&gt;</code>. As
              URLs seguem o padrão <code className="rounded bg-brand-off-white px-1 py-0.5 text-[12.5px]">apex/&lt;instância&gt;/f?p=&lt;PREFIXO&gt;_&lt;CODE&gt;</code> —
              mude o código ou a instância e use <strong>Regerar URLs</strong>. O logotipo é enviado pelo botão
              <strong> Subir</strong>, e cai na pasta do cliente.
            </p>
            <p className="mt-3 flex items-start gap-2 rounded-xl border border-amber-300 bg-amber-50 p-3 text-[13px] leading-relaxed text-amber-900">
              <AlertTriangle className="mt-0.5 h-4 w-4 shrink-0" aria-hidden />
              <span>
                O <strong>logotipo</strong> é gravado direto na pasta do cliente — mas só com{' '}
                <code className="rounded bg-amber-100 px-1">npm run dev</code> rodando, porque quem grava é o servidor de
                desenvolvimento. O <strong>resto</strong> não: copie ou baixe o arquivo no fim da página e comite{' '}
                <code className="rounded bg-amber-100 px-1">src/content/portais.ts</code>. Os dois precisam de commit para ir ao ar.
              </span>
            </p>
          </div>
        </header>

        <div className="mx-auto max-w-6xl space-y-4 px-5 py-8 sm:px-8">
          {clientes.map((c) => (
            <CartaoCliente
              key={c.slug}
              cliente={c}
              onAlterar={(m) => alterar(c.slug, m)}
              onRemover={() => setClientes((a) => a.filter((x) => x.slug !== c.slug))}
            />
          ))}

          <Button variant="outline" onClick={() => setClientes((a) => [...a, clienteNovo(a)])} className="w-full">
            <Plus className="h-4 w-4" aria-hidden />
            Adicionar cliente
          </Button>

          <section className="rounded-2xl border border-brand-mist bg-white p-5">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div>
                <h2 className="text-[15.5px] font-extrabold tracking-brand text-brand-ink">O arquivo</h2>
                <p className="mt-1 max-w-xl text-[13px] leading-relaxed text-brand-graphite">
                  {erroSalvar ? (
                    <span className="font-semibold text-red-600">{erroSalvar}</span>
                  ) : mudou ? (
                    <>
                      Há alterações não salvas.{' '}
                      {EM_DESENVOLVIMENTO
                        ? 'Salvar grava direto em src/content/portais.ts — falta só o commit.'
                        : 'Sem o servidor de desenvolvimento, copie ou baixe e substitua o arquivo à mão.'}
                    </>
                  ) : (
                    'Igual ao que está no arquivo.'
                  )}
                </p>
              </div>
              <div className="flex flex-wrap gap-2">
                <Button onClick={() => void salvar()} disabled={!EM_DESENVOLVIMENTO || salvando || !mudou}>
                  {salvando ? <Loader2 className="h-4 w-4 animate-spin" aria-hidden /> : <Save className="h-4 w-4" aria-hidden />}
                  {salvando ? 'Salvando' : 'Salvar no arquivo'}
                </Button>
                <Button variant="outline" onClick={copiar}>
                  {copiado ? <Check className="h-4 w-4" aria-hidden /> : <Copy className="h-4 w-4" aria-hidden />}
                  {copiado ? 'Copiado' : 'Copiar'}
                </Button>
                <Button onClick={baixar}>
                  <Download className="h-4 w-4" aria-hidden />
                  Baixar portais.ts
                </Button>
              </div>
            </div>
            <pre className="mt-4 max-h-80 overflow-auto rounded-xl bg-brand-ink p-4 text-[11.5px] leading-relaxed text-white/85">
              <code>{arquivo}</code>
            </pre>
          </section>
        </div>
      </div>
    </PageTransition>
  )
}

function CartaoCliente({
  cliente,
  onAlterar,
  onRemover,
}: {
  cliente: Cliente
  onAlterar: (m: Partial<Cliente>) => void
  onRemover: () => void
}) {
  const [aberto, setAberto] = useState(false)

  // URL fora do padrão não é erro: pode ser uma exceção deliberada. Mas
  // precisa aparecer, senão "Regerar URLs" a apagaria em silêncio.
  const divergentes = useMemo(
    () =>
      AMBIENTES.flatMap((amb) =>
        sistemas
          .filter((s) => cliente.urls[amb][s.key] !== urlEsperada(cliente, s, amb))
          .map((s) => `${amb}/${s.key}`),
      ),
    [cliente],
  )

  const regerar = () =>
    onAlterar({
      urls: Object.fromEntries(
        AMBIENTES.map((amb) => [
          amb,
          Object.fromEntries(sistemas.map((s) => [s.key, urlEsperada(cliente, s, amb)])) as Record<SistemaKey, string>,
        ]),
      ) as Cliente['urls'],
    })

  return (
    <section className="rounded-2xl border border-brand-mist bg-white p-5">
      <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-5">
        <Campo rotulo="Nome" valor={cliente.name} onChange={(v) => onAlterar({ name: v })} />
        <Campo rotulo="Slug (URL)" valor={cliente.slug} onChange={(v) => onAlterar({ slug: v })} />
        <Campo rotulo="Code (APEX)" valor={cliente.code} onChange={(v) => onAlterar({ code: v.toUpperCase() })} />
        <Campo rotulo="Instância" valor={cliente.apex} onChange={(v) => onAlterar({ apex: v })} />
        <div className="flex items-end gap-2">
          <label className="flex flex-1 cursor-pointer items-center gap-2 pb-2 text-[13px] font-semibold text-brand-graphite">
            <input
              type="checkbox"
              checked={cliente.active}
              onChange={(e) => onAlterar({ active: e.target.checked })}
              className="h-4 w-4 accent-brand-purple"
            />
            Ativo
          </label>
          <button
            onClick={onRemover}
            aria-label={`Remover ${cliente.name}`}
            className="mb-1 rounded-lg p-2 text-brand-gray transition-colors hover:bg-red-50 hover:text-red-600"
          >
            <Trash2 className="h-4 w-4" aria-hidden />
          </button>
        </div>
      </div>

      <div className="mt-4 flex flex-wrap items-center gap-x-4 gap-y-3">
        <ControleLogo cliente={cliente} onAlterar={onAlterar} />
        <span className="hidden h-8 w-px bg-brand-mist sm:block" aria-hidden />
        <Button variant="outline" size="sm" onClick={regerar}>
          <RefreshCw className="h-3.5 w-3.5" aria-hidden />
          Regerar URLs
        </Button>
        <button onClick={() => setAberto((v) => !v)} className="text-[13px] font-semibold text-brand-purple hover:underline">
          {aberto ? 'Esconder' : 'Ver'} as 12 URLs
        </button>
        <Link
          to={`/portais/${cliente.slug}`}
          className="inline-flex items-center gap-1 text-[13px] font-semibold text-brand-purple hover:underline"
        >
          Abrir portal
          <ExternalLink className="h-3.5 w-3.5" aria-hidden />
        </Link>
        {divergentes.length > 0 && (
          <span className="inline-flex items-center gap-1.5 rounded-full bg-amber-100 px-2.5 py-1 text-[12px] font-bold text-amber-900">
            <AlertTriangle className="h-3.5 w-3.5" aria-hidden />
            {divergentes.length} fora do padrão: {divergentes.join(', ')}
          </span>
        )}
      </div>

      {aberto && (
        <div className="mt-4 grid gap-4 lg:grid-cols-2">
          {AMBIENTES.map((amb) => (
            <div key={amb}>
              <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-brand-gray">
                {amb === 'prod' ? 'Produção' : 'Homologação'}
              </p>
              <div className="mt-2 space-y-2">
                {sistemas.map((s) => (
                  <label key={s.key} className="block">
                    <span className="text-[12px] font-semibold text-brand-graphite">{s.short}</span>
                    <Input
                      value={cliente.urls[amb][s.key]}
                      onChange={(e) =>
                        onAlterar({
                          urls: {
                            ...cliente.urls,
                            [amb]: { ...cliente.urls[amb], [s.key]: e.target.value },
                          },
                        })
                      }
                      className="mt-0.5 h-9 font-mono text-[11.5px]"
                    />
                  </label>
                ))}
              </div>
            </div>
          ))}
        </div>
      )}
    </section>
  )
}

/**
 * Subir, substituir e apagar o logotipo de um cliente.
 *
 * Só funciona com `npm run dev` rodando: quem grava é um plugin do servidor de
 * desenvolvimento (ver vite/plugin-logos.ts). No site publicado o controle
 * aparece desativado, com o motivo — em vez de um botão que falha em silêncio.
 */
function ControleLogo({ cliente, onAlterar }: { cliente: Cliente; onAlterar: (m: Partial<Cliente>) => void }) {
  const entrada = useRef<HTMLInputElement>(null)
  const [ocupado, setOcupado] = useState(false)
  const [erro, setErro] = useState<string | null>(null)
  /* Muda a cada gravação para furar o cache do navegador: o nome do arquivo
     continua o mesmo (logo.svg), então sem isto a imagem antiga permaneceria. */
  const [versao, setVersao] = useState(0)

  const src = urlLogo(cliente)

  const enviar = async (arquivo: File) => {
    setOcupado(true)
    setErro(null)
    try {
      const r = await fetch(`/__logos/${cliente.slug}`, {
        method: 'POST',
        headers: { 'content-type': arquivo.type },
        body: arquivo,
      })
      const d = (await r.json()) as { ok?: boolean; arquivo?: string; erro?: string }
      if (!d.ok) throw new Error(d.erro ?? 'falha ao gravar')
      onAlterar({ logo: d.arquivo ?? null })
      setVersao((v) => v + 1)
    } catch (e) {
      setErro(e instanceof Error ? e.message : 'falha ao gravar')
    } finally {
      setOcupado(false)
      if (entrada.current) entrada.current.value = ''
    }
  }

  const apagar = async () => {
    setOcupado(true)
    setErro(null)
    try {
      const r = await fetch(`/__logos/${cliente.slug}`, { method: 'DELETE' })
      const d = (await r.json()) as { ok?: boolean; erro?: string }
      if (!d.ok) throw new Error(d.erro ?? 'falha ao apagar')
      onAlterar({ logo: null })
      setVersao((v) => v + 1)
    } catch (e) {
      setErro(e instanceof Error ? e.message : 'falha ao apagar')
    } finally {
      setOcupado(false)
    }
  }

  return (
    <div>
      <div className="flex items-center gap-2">
        <span className="flex h-10 w-16 shrink-0 items-center justify-center overflow-hidden rounded-lg border border-brand-mist bg-white">
          {src ? (
            <img src={`${src}?v=${versao}`} alt={`Logo de ${cliente.name}`} className="max-h-8 w-auto object-contain" />
          ) : (
            <ImageOff className="h-4 w-4 text-brand-gray" aria-hidden />
          )}
        </span>

        <input
          ref={entrada}
          type="file"
          accept="image/svg+xml,image/png,image/jpeg,image/webp"
          className="hidden"
          onChange={(e) => {
            const f = e.target.files?.[0]
            if (f) void enviar(f)
          }}
        />

        <Button
          type="button"
          variant="outline"
          size="sm"
          disabled={!EM_DESENVOLVIMENTO || ocupado}
          onClick={() => entrada.current?.click()}
          title={`SVG, PNG, JPG ou WebP até 2 MB. Vai para ${pastaDoCliente(cliente.slug)}/ e substitui o anterior.`}
        >
          {ocupado ? <Loader2 className="h-3.5 w-3.5 animate-spin" aria-hidden /> : <Upload className="h-3.5 w-3.5" aria-hidden />}
          {cliente.logo ? 'Trocar' : 'Subir'}
        </Button>

        {cliente.logo && (
          <button
            type="button"
            onClick={() => void apagar()}
            disabled={!EM_DESENVOLVIMENTO || ocupado}
            aria-label={`Apagar o logotipo de ${cliente.name}`}
            className="rounded-lg p-2 text-brand-gray transition-colors hover:bg-red-50 hover:text-red-600 disabled:opacity-40"
          >
            <Trash2 className="h-4 w-4" aria-hidden />
          </button>
        )}
      </div>

      {(erro || !EM_DESENVOLVIMENTO) && (
        <p className="mt-1 max-w-[280px] text-[11.5px] leading-snug text-brand-gray">
          {erro ? (
            <span className="font-semibold text-red-600">{erro}</span>
          ) : (
            'Só com o servidor de desenvolvimento: o logotipo precisa ser comitado para ir ao ar.'
          )}
        </p>
      )}
    </div>
  )
}

function Campo({
  rotulo,
  valor,
  onChange,
  placeholder,
}: {
  rotulo: string
  valor: string
  onChange: (v: string) => void
  placeholder?: string
}) {
  return (
    <label className="block">
      <span className="text-[12px] font-bold text-brand-graphite">{rotulo}</span>
      <Input value={valor} placeholder={placeholder} onChange={(e) => onChange(e.target.value)} className="mt-1 h-10" />
    </label>
  )
}

function clienteNovo(existentes: Cliente[]): Cliente {
  let slug = 'novo-cliente'
  let n = 1
  while (existentes.some((c) => c.slug === slug)) slug = `novo-cliente-${++n}`
  const base: Cliente = {
    slug,
    name: 'Novo cliente',
    code: 'NOVO',
    apex: 'rh',
    logo: null,
    active: false,
    urls: { prod: {} as Record<SistemaKey, string>, dev: {} as Record<SistemaKey, string> },
  }
  for (const amb of AMBIENTES)
    for (const s of sistemas) base.urls[amb][s.key] = urlEsperada(base, s, amb)
  return base
}

/**
 * Monta o conteúdo de `src/content/portais.ts`.
 *
 * Só a parte dos dados é regerada — os tipos, os comentários e os utilitários
 * do arquivo continuam onde estão. Por isso a saída é o array `clientes`
 * inteiro, formatado do mesmo jeito que o arquivo já usa: o diff no git precisa
 * mostrar a linha que mudou, não o arquivo todo reformatado.
 */
function gerarArquivo(clientes: Cliente[]): string {
  const aspas = (v: string) => `'${v.replace(/\\/g, '\\\\').replace(/'/g, "\\'")}'`
  const bloco = (amb: Ambiente, c: Cliente) =>
    `      ${amb}: {\n` +
    sistemas.map((s) => `        ${s.key}: ${aspas(c.urls[amb][s.key])},`).join('\n') +
    `\n      },`

  const corpo = clientes
    .map(
      (c) =>
        `  {\n` +
        `    slug: ${aspas(c.slug)},\n` +
        `    name: ${aspas(c.name)},\n` +
        `    code: ${aspas(c.code)},\n` +
        `    apex: ${aspas(c.apex)},\n` +
        `    logo: ${c.logo === null ? 'null' : aspas(c.logo)},\n` +
        `    active: ${c.active},\n` +
        `    urls: {\n${AMBIENTES.map((a) => bloco(a, c)).join('\n')}\n    },\n` +
        `  },`,
    )
    .join('\n')

  return `export const clientes: Cliente[] = [\n${corpo}\n]\n`
}
