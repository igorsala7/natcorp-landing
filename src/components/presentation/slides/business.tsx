import { m } from 'motion/react'
import { Check, Trophy, X } from 'lucide-react'
import { Logo } from '@/components/brand/Logo'
import { personas } from '@/content/personas'
import { cadeiras, comercial, comparativo, confianca, implantacao, resultados } from '@/content/presentation'
import { awards, comparison, results } from '@/content/recognition'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { Big, Card, Chip, IconBox, Item, Rise, Slide, SlideLead, SlideTitle, Stagger, type SlideMeta } from '../Slide'

/* 14 · Resultados: três números e o ganho por processo. */
export function ResultadosSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="off">
      <div className="max-w-[52rem]">
        <SlideTitle text={resultados.title} />
      </div>
      <div className="mt-[clamp(1rem,3.5vh,2.25rem)] grid gap-[clamp(1rem,2.5vw,3rem)] lg:grid-cols-[1fr_1fr] lg:items-center">
        <div>
          <Stagger className="grid grid-cols-3 gap-3" delay={0.3}>
            {results.map((r, i) => (
              <Item key={r.label}>
                <Big value={r.value.replace(/^até /, '')} kicker={r.value.startsWith('até ') ? 'até' : undefined} label={r.label} accent={i === 0 ? 'pink' : 'purple'} />
              </Item>
            ))}
          </Stagger>
          <Stagger className="mt-[clamp(1rem,3vh,1.75rem)] grid gap-2.5 sm:grid-cols-2" delay={0.5}>
            {[resultados.roi, resultados.roes].map((r, i) => (
              <Item key={r.title}>
                <Card accent={i === 1} className="h-full">
                  <p className={cn('text-[length:var(--dk-eyebrow)] font-extrabold uppercase tracking-[0.14em]', i === 1 ? 'text-brand-pink' : 'text-brand-purple')}>{r.title}</p>
                  <p className="mt-1.5 text-[length:var(--dk-small)] leading-snug text-brand-graphite">{r.text}</p>
                </Card>
              </Item>
            ))}
          </Stagger>
        </div>
        <Rise delay={0.35} className="min-w-0">
          <Card className="p-[calc(var(--dk-card)*1.15)]">
            <div className="flex items-baseline justify-between gap-3">
              <p className="text-[length:var(--dk-body)] font-bold text-brand-ink">Ganho por processo</p>
              <p className="text-[length:var(--dk-small)] text-brand-gray">com a Natcorp, frente à operação anterior</p>
            </div>
            <ul className="mt-[clamp(0.75rem,2vh,1.25rem)] space-y-[clamp(0.6rem,1.6vh,1rem)]" aria-label="Ganho por processo">
              {resultados.gains.map((g, i) => (
                <li key={g.label} className="grid grid-cols-[minmax(7rem,0.9fr)_2fr] items-center gap-3 sm:grid-cols-[minmax(9rem,0.8fr)_2fr]">
                  <span className="text-[length:var(--dk-small)] font-semibold leading-tight text-brand-ink">{g.label}</span>
                  <span className="flex items-center gap-3">
                    <span className="relative h-[clamp(0.5rem,1.3vh,0.8rem)] flex-1 overflow-hidden rounded-r-[4px] bg-brand-mist">
                      <m.span
                        className={cn('absolute inset-y-0 left-0 rounded-r-[4px]', i === 0 ? 'bg-brand-pink' : 'bg-brand-purple')}
                        style={{ width: `${g.pct}%`, transformOrigin: 'left' }}
                        initial={{ scaleX: 0 }}
                        whileInView={{ scaleX: 1 }}
                        viewport={{ once: true, amount: 0.5 }}
                        transition={{ duration: 0.9, ease: EASE, delay: 0.5 + i * 0.12 }}
                      />
                    </span>
                    <span className="w-[9.5rem] shrink-0 text-[length:var(--dk-small)] font-semibold tabular text-brand-ink">{g.note}</span>
                  </span>
                </li>
              ))}
            </ul>
            <p className="mt-[clamp(0.75rem,2vh,1.25rem)] border-t border-brand-mist pt-3 text-[length:var(--dk-small)] leading-snug text-brand-gray">{resultados.source}</p>
          </Card>
        </Rise>
      </div>
    </Slide>
  )
}

/* 15 · Para cada cadeira na mesa. */
export function CadeirasSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="white">
      <div className="max-w-[52rem]">
        <SlideTitle text={cadeiras.title} className="text-[length:calc(var(--dk-h2)*0.9)]" />
      </div>
      <Stagger className="mt-[clamp(0.75rem,3vh,2rem)] grid gap-2.5 sm:grid-cols-2 lg:grid-cols-3" delay={0.3} stagger={0.06}>
        {personas.map((p) => (
          <Item key={p.id}>
            <Card className="flex h-full flex-col p-[calc(var(--dk-card)*0.85)]">
              <div className="flex items-center gap-2.5">
                <IconBox className="h-[calc(var(--dk-icon)*0.8)] w-[calc(var(--dk-icon)*0.8)]">
                  <p.icon strokeWidth={1.7} />
                </IconBox>
                <p className="text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.12em] text-brand-purple">{p.role}</p>
              </div>
              <p className="mt-2.5 text-[length:var(--dk-body)] font-bold leading-snug text-brand-ink">{p.headline}</p>
              <ul className="mt-1.5 space-y-0.5 text-[length:var(--dk-small)] leading-snug text-brand-graphite">
                {p.points.map((pt) => (
                  <li key={pt} className="flex gap-2">
                    <Check className="mt-[0.2em] h-[1em] w-[1em] shrink-0 text-brand-pink" strokeWidth={2.5} aria-hidden />
                    {pt}
                  </li>
                ))}
              </ul>
            </Card>
          </Item>
        ))}
      </Stagger>
    </Slide>
  )
}

/* 16 · Natcorp x outros sistemas. */
export function ComparativoSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="white">
      <div className="grid gap-[clamp(1rem,2.5vw,3rem)] lg:grid-cols-[0.75fr_1.5fr] lg:items-center">
        <div>
          <SlideTitle text={comparativo.title} />
          <SlideLead className="mt-4 max-w-[26rem]">{comparativo.lead}</SlideLead>
          <Rise delay={0.4} className="mt-[clamp(1rem,3vh,1.75rem)]">
            <Big size="md" value="100%" label="do desenvolvimento é Natcorp, sem depender de terceiros" accent="pink" />
          </Rise>
        </div>
        <Rise delay={0.25} className="min-w-0">
          <div className="overflow-x-auto rounded-2xl border border-brand-mist shadow-soft">
            <table className="w-full min-w-[34rem] border-collapse text-left text-[length:var(--dk-small)]">
              <caption className="sr-only">Comparativo entre a Natcorp e outros sistemas de RH</caption>
              <thead>
                <tr className="bg-brand-gradient text-white">
                  <th scope="col" className="px-4 py-[0.7em] text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.12em]">
                    Característica
                  </th>
                  <th scope="col" className="px-4 py-[0.7em] text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.12em]">
                    <span className="inline-flex items-center gap-2">
                      <Logo variant="symbol" tone="white" decorative className="h-[1.1em] w-[1.1em]" />
                      Natcorp
                    </span>
                  </th>
                  <th scope="col" className="px-4 py-[0.7em] text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.12em] text-white/80">
                    Outros sistemas
                  </th>
                </tr>
              </thead>
              <tbody>
                {comparison.map((row, i) => (
                  <tr key={row.feature} className={i % 2 === 0 ? 'bg-white' : 'bg-brand-off-white/70'}>
                    <th scope="row" className="px-4 py-[0.6em] align-top font-semibold text-brand-ink">
                      {row.feature}
                    </th>
                    <td className="px-4 py-[0.6em] align-top text-brand-ink">
                      <span className="flex items-start gap-2">
                        <span className="mt-[0.1em] flex h-[1.25em] w-[1.25em] shrink-0 items-center justify-center rounded-full bg-emerald-100 text-emerald-700">
                          <Check className="h-[0.7em] w-[0.7em]" strokeWidth={3} aria-hidden />
                          <span className="sr-only">Sim:</span>
                        </span>
                        {row.natcorp}
                      </span>
                    </td>
                    <td className="px-4 py-[0.6em] align-top text-brand-graphite">
                      <span className="flex items-start gap-2">
                        <span className="mt-[0.1em] flex h-[1.25em] w-[1.25em] shrink-0 items-center justify-center rounded-full bg-brand-mist text-brand-graphite">
                          <X className="h-[0.7em] w-[0.7em]" strokeWidth={3} aria-hidden />
                          <span className="sr-only">Não:</span>
                        </span>
                        {row.others}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Rise>
      </div>
    </Slide>
  )
}

/* 17 · Modelo comercial. */
export function ComercialSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="off">
      <div className="max-w-[52rem]">
        <SlideTitle text={comercial.title} />
      </div>
      <Stagger className="mt-[clamp(1rem,3.5vh,2.25rem)] grid gap-3 lg:grid-cols-3" delay={0.3} stagger={0.08}>
        {comercial.pillars.map((p, i) => (
          <Item key={p.kicker}>
            <Card className="flex h-full flex-col">
              <p className="flex items-center gap-2 text-[length:var(--dk-eyebrow)] font-extrabold uppercase tracking-[0.14em] text-brand-purple">
                <span className="flex h-[1.9em] w-[1.9em] items-center justify-center rounded-full bg-brand-purple text-[0.9em] text-white tabular">{i + 1}</span>
                {p.kicker}
              </p>
              <p className="mt-3 text-[length:var(--dk-lead)] font-bold leading-snug text-brand-ink">{p.title}</p>
              <p className="mt-2 text-[length:var(--dk-small)] leading-relaxed text-brand-graphite">{p.text}</p>
            </Card>
          </Item>
        ))}
      </Stagger>
      <Rise delay={0.6} className="mt-[clamp(1rem,3vh,1.75rem)]">
        <p className="text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.14em] text-brand-graphite">O que vem incluído</p>
        <ul className="mt-2.5 grid gap-x-6 gap-y-1.5 sm:grid-cols-2 lg:grid-cols-3">
          {comercial.included.map((t) => (
            <li key={t} className="flex items-start gap-2 text-[length:var(--dk-body)] text-brand-ink">
              <span className="mt-[0.2em] flex h-[1.2em] w-[1.2em] shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                <Check className="h-[0.65em] w-[0.65em]" strokeWidth={3} aria-hidden />
              </span>
              {t}
            </li>
          ))}
        </ul>
      </Rise>
    </Slide>
  )
}

/* 18 · Implantação e acompanhamento. */
export function ImplantacaoSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="white">
      <div className="max-w-[54rem]">
        <SlideTitle text={implantacao.title} />
      </div>
      <Stagger className="relative mt-[clamp(1.25rem,4vh,2.5rem)] grid gap-3 lg:grid-cols-5 lg:gap-2.5" delay={0.3} stagger={0.1}>
        <span className="pointer-events-none absolute left-[10%] right-[10%] top-[calc(var(--dk-icon)/2)] hidden h-px bg-brand-mist lg:block" aria-hidden />
        {implantacao.steps.map((s, i) => (
          <Item key={s.title} className="relative flex gap-3 lg:flex-col lg:gap-0">
            <span className="relative z-10 flex h-[var(--dk-icon)] w-[var(--dk-icon)] shrink-0 items-center justify-center rounded-full bg-brand-purple text-[length:var(--dk-body)] font-extrabold tabular text-white shadow-soft">{i + 1}</span>
            <div className="lg:mt-3">
              <p className="text-[length:var(--dk-body)] font-bold text-brand-ink">{s.title}</p>
              <p className="mt-1 text-[length:var(--dk-small)] leading-snug text-brand-graphite">{s.text}</p>
            </div>
          </Item>
        ))}
      </Stagger>
      <div className="mt-[clamp(1.25rem,4vh,2.5rem)] grid gap-3 lg:grid-cols-[1.1fr_1fr] lg:items-stretch">
        <Rise delay={0.7} className="min-w-0">
          <p className="text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.14em] text-brand-graphite">Serviços que acompanham o sistema</p>
          <div className="mt-2.5 flex flex-wrap gap-2">
            {implantacao.services.map((s) => (
              <Chip key={s} tone="purple">
                {s}
              </Chip>
            ))}
          </div>
        </Rise>
        <Rise delay={0.8} className="min-w-0">
          <Card accent className="flex h-full items-center gap-4">
            <Logo variant="symbol" decorative className="h-[var(--dk-icon)] w-[var(--dk-icon)] shrink-0" />
            <p className="text-[length:var(--dk-body)] leading-snug text-brand-ink">
              <strong className="font-bold">Proximidade.</strong> {implantacao.proximity}
            </p>
          </Card>
        </Rise>
      </div>
    </Slide>
  )
}

/* 19 · Quem confia: reconhecimentos e clientes (fundo Azul Profundo). */
export function ConfiancaSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="dark">
      <div className="grid gap-[clamp(1.25rem,3vw,3.5rem)] lg:grid-cols-[0.9fr_1.1fr] lg:items-center">
        <div>
          <SlideTitle dark text={confianca.title} />
          <Stagger className="mt-[clamp(1rem,3vh,1.75rem)] grid grid-cols-2 gap-4" delay={0.3}>
            <Item>
              <Big dark size="md" value={500} suffix=" mil+" label="colaboradores administrados no sistema" accent="pink" />
            </Item>
            <Item>
              <Big dark size="md" value={35} suffix=" anos" label="de história e de especialização em RH" />
            </Item>
          </Stagger>
          <Stagger className="mt-[clamp(1rem,3vh,1.75rem)] grid gap-2 sm:grid-cols-2" delay={0.5} stagger={0.06}>
            {awards.map((a) => (
              <Item key={a.title} className="flex gap-3">
                <IconBox dark>
                  <Trophy strokeWidth={1.7} />
                </IconBox>
                <div className="min-w-0">
                  <p className="text-[length:var(--dk-small)] font-bold leading-tight text-white">{a.title}</p>
                  <p className="mt-0.5 text-[length:var(--dk-small)] leading-snug text-white/65">{a.org}</p>
                </div>
              </Item>
            ))}
          </Stagger>
        </div>
        <Rise delay={0.35} className="min-w-0">
          <p className="text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.14em] text-white/60">Alguns dos clientes</p>
          <Stagger className="mt-3 flex flex-wrap gap-2" delay={0.5} stagger={0.035}>
            {confianca.clients.map((c) => (
              <Item key={c}>
                <Chip dark>{c}</Chip>
              </Item>
            ))}
          </Stagger>
          <p className="mt-4 text-[length:var(--dk-small)] leading-snug text-white/55">Clientes e reconhecimentos citados no material oficial da Natcorp. Pioneira no uso de inteligência artificial para o RH. Parceira Oracle.</p>
        </Rise>
      </div>
    </Slide>
  )
}
