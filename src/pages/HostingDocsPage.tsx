import { useEffect, useMemo, useRef, useState } from 'react'
import { Link } from 'react-router'
import { ArrowUpRight, ListTree, Printer, X } from 'lucide-react'
import source from '../../HOSPEDAGEM.md?raw'
import { Blocks, ResetChecklist } from '@/components/docs/DocBlocks'
import { Logo } from '@/components/brand/Logo'
import { useSeo } from '@/hooks/useSeo'
import { buildToc, parseMarkdown } from '@/lib/docMarkdown'
import { siteConfig } from '@/content/site'
import { cn } from '@/lib/utils'

/**
 * Documentação técnica de publicação, para a empresa de hospedagem.
 *
 * A página lê `HOSPEDAGEM.md` na raiz do repositório — o mesmo arquivo que é
 * enviado por e-mail. Não há segunda cópia do texto para manter em dia: quem
 * corrige o `.md` corrige a página junto.
 *
 * Fora do menu, do sitemap e dos robôs (`noindex`): é material compartilhado por
 * link, e traz configuração de servidor que não interessa a buscador nenhum.
 */
export default function HostingDocsPage() {
  useSeo({
    title: 'Documentação técnica de publicação | Natcorp',
    description: 'Guia para a equipe de hospedagem publicar o site www.natcorp.com.br: requisitos, regras de servidor, configuração para Apache, Nginx e IIS, e checklist de validação.',
    path: '/hospedagem',
    noindex: true,
  })

  /* O documento não muda enquanto a página está aberta: lê e monta uma vez só. */
  const blocks = useMemo(() => parseMarkdown(source), [])
  const toc = useMemo(() => buildToc(blocks), [blocks])

  const [active, setActive] = useState<string>('')
  const [indexOpen, setIndexOpen] = useState(false)
  const contentRef = useRef<HTMLDivElement>(null)

  /*
   * Marca no índice onde a pessoa está.
   *
   * A faixa de observação é a metade de cima da tela: assim o item acende quando
   * o título chega perto do topo, e não quando aparece lá embaixo — que é onde a
   * leitura realmente está.
   */
  useEffect(() => {
    const headings = contentRef.current?.querySelectorAll<HTMLElement>('h2[id], h3[id]')
    if (!headings?.length) return

    const observer = new IntersectionObserver(
      (entries) => {
        const visible = entries.filter((e) => e.isIntersecting)
        if (visible.length) setActive(visible[0].target.id)
      },
      { rootMargin: '-80px 0px -55% 0px', threshold: 0 },
    )
    headings.forEach((h) => observer.observe(h))
    return () => observer.disconnect()
  }, [blocks])

  /* No celular o índice é uma folha por cima: fechar ao navegar é o esperado. */
  useEffect(() => {
    if (!indexOpen) return
    const onKey = (e: KeyboardEvent) => e.key === 'Escape' && setIndexOpen(false)
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [indexOpen])

  const indexList = (
    <nav aria-label="Índice do documento">
      <ul className="space-y-0.5">
        {toc.map((entry) => {
          /* No índice o rótulo é texto puro: marcação de código e negrito só fariam ruído. */
          const label = entry.text.replace(/[`*]/g, '')
          return (
            <li key={entry.id}>
              <a
                href={`#${entry.id}`}
                onClick={() => setIndexOpen(false)}
                className={cn(
                  'flex gap-2.5 rounded-lg py-1.5 pr-2 text-[13.5px] leading-snug transition-colors',
                  entry.level === 3 ? 'pl-5 text-[13px]' : 'pl-2.5 font-semibold',
                  active === entry.id ? 'bg-brand-purple/[0.07] text-brand-purple' : 'text-brand-graphite hover:bg-brand-off-white hover:text-brand-purple',
                )}
              >
                {entry.number && <span className="flex-none font-mono text-[11.5px] text-brand-gray">{entry.number}</span>}
                <span>{label}</span>
              </a>
            </li>
          )
        })}
      </ul>
    </nav>
  )

  return (
    <div className="doc-page min-h-screen bg-white">
      {/* ── Cabeçalho próprio: sem o menu de marketing, que aqui só atrapalha ── */}
      <header className="sticky top-0 z-30 bg-brand-blue text-white print:static">
        <div className="container flex h-16 items-center justify-between gap-4">
          <div className="flex min-w-0 items-center gap-4">
            <Link to="/" className="flex-none" aria-label="Natcorp — início">
              <Logo variant="horizontal" tone="white" className="h-7 w-auto" />
            </Link>
            <span className="hidden h-6 w-px bg-white/20 sm:block" />
            <p className="hidden truncate text-[13.5px] font-semibold text-white/75 sm:block">Documentação técnica de publicação</p>
          </div>
          <div className="flex flex-none items-center gap-1">
            <ResetChecklist />
            <button
              type="button"
              onClick={() => window.print()}
              className="inline-flex items-center gap-1.5 rounded-full px-3 py-2 text-[13px] font-semibold text-white/70 transition-colors hover:bg-white/10 hover:text-white print:hidden"
            >
              <Printer className="h-3.5 w-3.5" />
              <span className="hidden sm:inline">Imprimir / PDF</span>
            </button>
            <button
              type="button"
              onClick={() => setIndexOpen(true)}
              className="inline-flex items-center gap-1.5 rounded-full bg-white/10 px-3 py-2 text-[13px] font-semibold text-white transition-colors hover:bg-white/20 lg:hidden print:hidden"
            >
              <ListTree className="h-3.5 w-3.5" />
              Índice
            </button>
          </div>
        </div>
      </header>

      <div className="container">
        <div className="grid gap-10 lg:grid-cols-[16rem_minmax(0,1fr)] lg:gap-14">
          {/* ── Índice fixo, telas largas ── */}
          <aside className="hidden lg:block print:hidden">
            <div className="sticky top-[5.5rem] max-h-[calc(100vh-7rem)] overflow-y-auto py-12 pr-2">
              <p className="mb-3 pl-2.5 text-[11.5px] font-bold uppercase tracking-[0.14em] text-brand-gray">Neste documento</p>
              {indexList}
            </div>
          </aside>

          {/* ── Documento ── */}
          <main ref={contentRef} className="min-w-0 max-w-3xl py-12 lg:py-16">
            <Blocks blocks={blocks} />

            <footer className="mt-20 border-t border-brand-mist pt-8">
              <p className="text-[13.5px] leading-relaxed text-brand-gray">
                Documento mantido junto com o código do site. A versão em Markdown é o arquivo <code className="font-mono text-brand-graphite">HOSPEDAGEM.md</code>, na raiz do repositório — esta página é a
                leitura dele.
              </p>
              <a
                href={siteConfig.url}
                className="mt-4 inline-flex items-center gap-1.5 text-[13.5px] font-bold text-brand-purple hover:text-brand-purple-hover"
                rel="noreferrer noopener"
              >
                natcorp.com.br
                <ArrowUpRight className="h-3.5 w-3.5" />
              </a>
            </footer>
          </main>
        </div>
      </div>

      {/* ── Índice no celular ── */}
      {indexOpen && (
        <div className="fixed inset-0 z-50 lg:hidden print:hidden">
          <button type="button" aria-label="Fechar o índice" onClick={() => setIndexOpen(false)} className="absolute inset-0 bg-brand-ink/45" />
          <div className="absolute inset-y-0 right-0 flex w-[min(20rem,88vw)] flex-col bg-white shadow-lift">
            <div className="flex items-center justify-between border-b border-brand-mist px-5 py-4">
              <p className="text-[11.5px] font-bold uppercase tracking-[0.14em] text-brand-gray">Neste documento</p>
              <button type="button" onClick={() => setIndexOpen(false)} aria-label="Fechar" className="rounded-full p-1.5 text-brand-graphite hover:bg-brand-off-white">
                <X className="h-4 w-4" />
              </button>
            </div>
            <div className="flex-1 overflow-y-auto px-3 py-4">{indexList}</div>
          </div>
        </div>
      )}
    </div>
  )
}
