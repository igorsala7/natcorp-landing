import { useMemo, useState } from 'react'
import { Link } from 'react-router'
import { AlertTriangle, Check, Copy, Download, ExternalLink, Plus, RefreshCw, Trash2 } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { PageTransition } from '@/components/motion/PageTransition'
import { useSeo } from '@/hooks/useSeo'
import {
  clientes as clientesIniciais,
  sistemas,
  urlEsperada,
  type Ambiente,
  type Cliente,
  type SistemaKey,
} from '@/content/portais'

const AMBIENTES: Ambiente[] = ['prod', 'dev']

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
  const [copiado, setCopiado] = useState(false)

  const alterar = (slug: string, mudanca: Partial<Cliente>) =>
    setClientes((atual) => atual.map((c) => (c.slug === slug ? { ...c, ...mudanca } : c)))

  const arquivo = useMemo(() => gerarArquivo(clientes), [clientes])
  const mudou = useMemo(() => JSON.stringify(clientes) !== JSON.stringify(clientesIniciais), [clientes])

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
              mude o código ou a instância e use <strong>Regerar URLs</strong>.
            </p>
            <p className="mt-3 flex items-start gap-2 rounded-xl border border-amber-300 bg-amber-50 p-3 text-[13px] leading-relaxed text-amber-900">
              <AlertTriangle className="mt-0.5 h-4 w-4 shrink-0" aria-hidden />
              <span>
                Esta tela <strong>não grava no repositório</strong>: o site é estático. Edite aqui, copie ou baixe o
                arquivo no fim da página e comite <code className="rounded bg-amber-100 px-1">src/content/portais.ts</code>.
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
                <p className="mt-1 text-[13px] text-brand-graphite">
                  {mudou ? 'Há alterações não salvas.' : 'Igual ao que está no repositório.'} Substitua o conteúdo de{' '}
                  <code className="rounded bg-brand-off-white px-1">src/content/portais.ts</code>.
                </p>
              </div>
              <div className="flex gap-2">
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
      <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-6">
        <Campo rotulo="Nome" valor={cliente.name} onChange={(v) => onAlterar({ name: v })} />
        <Campo rotulo="Slug (URL)" valor={cliente.slug} onChange={(v) => onAlterar({ slug: v })} />
        <Campo rotulo="Code (APEX)" valor={cliente.code} onChange={(v) => onAlterar({ code: v.toUpperCase() })} />
        <Campo rotulo="Instância" valor={cliente.apex} onChange={(v) => onAlterar({ apex: v })} />
        <Campo
          rotulo="Logo (/public)"
          valor={cliente.logo ?? ''}
          placeholder="vazio = marca Natcorp"
          onChange={(v) => onAlterar({ logo: v.trim() === '' ? null : v.trim() })}
        />
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

      <div className="mt-4 flex flex-wrap items-center gap-3">
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
