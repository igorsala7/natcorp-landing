import { useEffect, useMemo, useRef, useState } from 'react'
import { ArrowUpRight, ListTree, Printer, X } from 'lucide-react'
import { Blocks, ResetChecklist } from '@/components/docs/DocBlocks'
import { Logo } from '@/components/brand/Logo'
import { buildToc, parseMarkdown } from '@/lib/docMarkdown'
import { cn } from '@/lib/utils'

interface DocPageProps {
  /** O Markdown cru do documento. */
  source: string
  /** Rótulo curto ao lado do logotipo, no cabeçalho. */
  label: string
  /** Endereço do site, no rodapé e no logotipo. */
  siteUrl: string
  /** Nota de rodapé sobre a origem do documento. */
  note: React.ReactNode
}

/**
 * A moldura de leitura de um documento em Markdown.
 *
 * Vive fora da página de rota de propósito: a mesma peça monta `/hospedagem`
 * dentro do site e o arquivo `HOSPEDAGEM.html` autônomo, gerado por
 * `scripts/build-hospedagem.mjs`. Por isso não conhece o React Router nem o
 * `useSeo` — quem precisa disso é quem a usa.
 */
export function DocPage({ source, label, siteUrl, note }: DocPageProps) {
  /* O documento não muda enquanto a página está aberta: lê e monta uma vez só. */
  const blocks = useMemo(() => parseMarkdown(source), [source])
  const toc = useMemo(() => buildToc(blocks), [blocks])

  const [active, setActive] = useState<string>('')
  const [indexOpen, setIndexOpen] = useState(false)
  const contentRef = useRef<HTMLElement>(null)

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

  useEffect(() => {
    if (!indexOpen) return
    const onKey = (e: KeyboardEvent) => e.key === 'Escape' && setIndexOpen(false)
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [indexOpen])

  const indexList = (
    <nav aria-label="Índice do documento">
      <ul className="space-y-0.5">
        {toc.map((entry) => (
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
              {/* No índice o rótulo é texto puro: marcação de código e negrito só fariam ruído. */}
              <span>{entry.text.replace(/[`*]/g, '')}</span>
            </a>
          </li>
        ))}
      </ul>
    </nav>
  )

  return (
    <div className="doc-page min-h-screen bg-white">
      {/* ── Cabeçalho próprio: sem o menu de marketing, que aqui só atrapalha ── */}
      <header className="sticky top-0 z-30 bg-brand-blue text-white print:static">
        <div className="container flex h-16 items-center justify-between gap-4">
          <div className="flex min-w-0 items-center gap-4">
            <a href={siteUrl} className="flex-none" aria-label="Natcorp — site">
              <Logo variant="horizontal" tone="white" className="h-7 w-auto" />
            </a>
            <span className="hidden h-6 w-px bg-white/20 sm:block" />
            <p className="hidden truncate text-[13.5px] font-semibold text-white/75 sm:block">{label}</p>
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
              <p className="text-[13.5px] leading-relaxed text-brand-gray">{note}</p>
              <a href={siteUrl} className="mt-4 inline-flex items-center gap-1.5 text-[13.5px] font-bold text-brand-purple hover:text-brand-purple-hover" rel="noreferrer noopener">
                {siteUrl.replace(/^https?:\/\//, '')}
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
