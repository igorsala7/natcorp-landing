import { useEffect, useRef, useState, type RefObject } from 'react'
import { AnimatePresence, m, useInView, useReducedMotion } from 'motion/react'
import { ArrowRight, Check, Clock3, ShieldAlert, Smartphone, Sparkles, UserCog, Users, Wrench } from 'lucide-react'
import { Logo } from '@/components/brand/Logo'
import { NatPontoIcon } from '@/components/brand/NatPontoIcon'
import { Counter } from '@/components/motion/Counter'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import { CastFigure } from '@/components/journey/Cast'
import { MedicineIndicators } from '@/components/mockups/analytics/MedicineIndicators'
import { ANALYTICS_SIZE } from '@/components/mockups/analytics/shell'
import { WhatsAppMockup } from '@/components/mockups/nati/WhatsAppMockup'
import { NATPONTO_SIZE } from '@/components/mockups/natponto/NatPontoFrame'
import { NatPontoPhone, type NatPontoScreen } from '@/components/mockups/natponto/screens'
import { InsightStream } from '@/components/nati/InsightStream'
import { castMember } from '@/content/hiringJourney'
import { analyticsSlide, antesDepois, diaNoRh, fechamento, jornadaResumo, natiCanais, portaisSlide } from '@/content/presentation'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { Big, Card, Chip, IconBox, Item, Rise, Slide, SlideLead, SlideTitle, Stagger, type SlideMeta } from '../Slide'
import { ModuleChip } from './module'

/**
 * Os slides que contam a história do RH: cada um mostra uma dor do dia a dia e o sistema
 * resolvendo, com telas reais e os personagens da jornada. Alguns passam sozinhos até alguém
 * tocar; a partir do toque, o apresentador comanda.
 */

/** Avança sozinho enquanto o slide está na tela e ninguém tocou; depois do toque, só manual. */
function useAutoAdvance(count: number, every: number, ref: RefObject<HTMLElement | null>) {
  const [i, setI] = useState(0)
  const [manual, setManual] = useState(false)
  const inView = useInView(ref, { amount: 0.5 })
  const reduced = useReducedMotion()
  useEffect(() => {
    if (manual || !inView || reduced) return
    const t = window.setInterval(() => setI((v) => (v + 1) % count), every)
    return () => window.clearInterval(t)
  }, [manual, inView, reduced, count, every])
  const pick = (n: number) => {
    setManual(true)
    setI(n)
  }
  return { i, pick, manual }
}

const swap = {
  initial: { opacity: 0, y: 10 },
  animate: { opacity: 1, y: 0 },
  exit: { opacity: 0, y: -8 },
  transition: { duration: 0.35, ease: EASE },
}

/* 01 · Um dia no seu RH: a linha do tempo das dores e a resposta de cada uma. */
export function DiaNoRhSlide(meta: SlideMeta) {
  const ref = useRef<HTMLDivElement>(null)
  const { i, pick } = useAutoAdvance(diaNoRh.moments.length, 5200, ref)
  const now = diaNoRh.moments[i]
  return (
    <Slide {...meta} tone="off">
      <div ref={ref} className="grid gap-[clamp(1.25rem,3vw,3.5rem)] lg:grid-cols-[0.95fr_1.1fr] lg:items-center">
        <div>
          <SlideTitle text={diaNoRh.title} />
          <SlideLead className="mt-3 max-w-[32rem]">{diaNoRh.lead}</SlideLead>
          <Stagger as="ol" className="mt-[clamp(1rem,3vh,1.75rem)] grid gap-1.5" delay={0.35} stagger={0.06} aria-label="Momentos do dia">
            {diaNoRh.moments.map((mo, n) => {
              const active = n === i
              return (
                <Item key={mo.time} as="li">
                  <button
                    type="button"
                    onClick={() => pick(n)}
                    aria-pressed={active}
                    className={cn(
                      'flex w-full items-center gap-3 rounded-xl border px-3 py-[0.55em] text-left text-[length:var(--dk-body)] transition-colors',
                      active ? 'border-brand-purple bg-brand-purple text-white shadow-soft' : 'border-brand-mist bg-white text-brand-ink hover:border-brand-purple/40',
                    )}
                  >
                    <span className={cn('w-[3.6em] shrink-0 text-[length:var(--dk-small)] font-extrabold tabular', active ? 'text-[#E4A9C4]' : 'text-brand-purple')}>{mo.time}</span>
                    <span className="min-w-0 flex-1 truncate font-semibold">{mo.title}</span>
                    <ArrowRight className={cn('h-[1em] w-[1em] shrink-0 transition-opacity', active ? 'opacity-100' : 'opacity-0')} aria-hidden />
                  </button>
                </Item>
              )
            })}
          </Stagger>
        </div>
        <Rise delay={0.3} className="min-w-0">
          <AnimatePresence mode="wait" initial={false}>
            <m.div key={now.time} {...swap} className="grid gap-3">
              <div className="rounded-2xl border border-dashed border-brand-gray/60 bg-white p-[var(--dk-card)]">
                <p className="flex items-center gap-2 text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.14em] text-brand-graphite">
                  <ShieldAlert className="h-[1.3em] w-[1.3em] text-brand-pink" strokeWidth={1.8} aria-hidden />
                  Hoje, às {now.time}
                </p>
                <p className="mt-2 text-[length:var(--dk-lead)] font-bold leading-snug text-brand-ink">{now.title}</p>
                <p className="mt-1.5 text-[length:var(--dk-body)] leading-relaxed text-brand-graphite">{now.pain}</p>
              </div>
              <div className="flex justify-center" aria-hidden>
                <span className="flex h-8 w-8 items-center justify-center rounded-full bg-brand-purple text-white shadow-soft">
                  <ArrowRight className="h-4 w-4 rotate-90" strokeWidth={2.2} />
                </span>
              </div>
              <Card accent className="p-[var(--dk-card)]">
                <p className="flex items-center gap-2 text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.14em] text-brand-purple">
                  <Logo variant="symbol" decorative className="h-[1.3em] w-[1.3em]" />
                  Com a Natcorp
                </p>
                <p className="mt-2 text-[length:var(--dk-body)] leading-relaxed text-brand-ink">{now.answer}</p>
                <div className="mt-3">
                  <Chip tone="purple">{now.module}</Chip>
                </div>
              </Card>
            </m.div>
          </AnimatePresence>
        </Rise>
      </div>
    </Slide>
  )
}

/* O fechamento da folha: 10.000 colaboradores em quatro minutos, com a auditoria da NATI. */
export function FechamentoSlide(meta: SlideMeta) {
  const ref = useRef<HTMLDivElement>(null)
  const inView = useInView(ref, { once: true, amount: 0.4 })
  const reduced = useReducedMotion()
  const run = inView || Boolean(reduced)
  return (
    <Slide {...meta} tone="dark">
      <div ref={ref} className="grid gap-[clamp(1.25rem,3vw,3.5rem)] lg:grid-cols-[1.05fr_1fr] lg:items-center">
        <div>
          <SlideTitle dark text={fechamento.title} />
          <SlideLead dark className="mt-4 max-w-[34rem]">
            {fechamento.lead}
          </SlideLead>
          <Stagger className="mt-[clamp(1rem,3vh,1.75rem)] grid grid-cols-3 gap-3 border-t border-white/10 pt-[clamp(0.75rem,2vh,1.25rem)]" delay={0.5}>
            {fechamento.numbers.map((n, k) => (
              <Item key={n.label}>
                <Big dark size="md" value={n.value} label={n.label} accent={k === 0 ? 'pink' : undefined} />
              </Item>
            ))}
          </Stagger>
        </div>
        <Rise delay={0.25} className="min-w-0">
          <Card dark className="p-[calc(var(--dk-card)*1.1)]">
            <div className="flex items-center justify-between gap-3">
              <p className="text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.14em] text-white/70">Fechamento · Novembro</p>
              <span className="flex items-center gap-1.5 text-[length:var(--dk-small)] font-semibold text-[#F3C9DA]">
                <Clock3 className="h-[1.1em] w-[1.1em]" strokeWidth={2} aria-hidden />
                cerca de 4 min
              </span>
            </div>
            <p className="mt-2 text-[length:var(--dk-big)] font-extrabold leading-none tracking-brand text-white tabular">
              <Counter value={10000} duration={2.8} />
            </p>
            <p className="mt-1 text-[length:var(--dk-small)] font-medium text-white/70">colaboradores calculados, por empresa, CNPJ e centro de custo</p>
            <div className="mt-3 h-[clamp(0.5rem,1.3vh,0.8rem)] overflow-hidden rounded-full bg-white/10" role="progressbar" aria-valuemin={0} aria-valuemax={100} aria-valuenow={run ? 100 : 0} aria-label="Cálculo da folha">
              <m.div className="h-full rounded-full bg-[linear-gradient(90deg,#E4A9C4,#C95788)]" initial={{ scaleX: 0 }} animate={{ scaleX: run ? 1 : 0 }} style={{ transformOrigin: 'left' }} transition={{ duration: 2.8, ease: 'linear', delay: 0.2 }} />
            </div>
            <ol className="mt-[clamp(0.75rem,2vh,1.25rem)] grid gap-2">
              {fechamento.steps.map((st, k) => (
                <m.li
                  key={st.label}
                  className="flex items-start gap-3"
                  initial={{ opacity: 0.35 }}
                  animate={{ opacity: run ? 1 : 0.35 }}
                  transition={{ duration: 0.4, delay: 0.3 + k * 0.7 }}
                >
                  <m.span
                    className="mt-[0.15em] flex h-[1.4em] w-[1.4em] shrink-0 items-center justify-center rounded-full bg-white/10 text-[length:var(--dk-small)] text-white"
                    animate={{ backgroundColor: run ? '#C95788' : 'rgba(255,255,255,0.1)' }}
                    transition={{ duration: 0.3, delay: 0.3 + k * 0.7 }}
                  >
                    <Check className="h-[0.7em] w-[0.7em]" strokeWidth={3} aria-hidden />
                  </m.span>
                  <span className="min-w-0 text-[length:var(--dk-small)] leading-snug text-white/75">
                    <strong className="text-[length:var(--dk-body)] font-bold text-white">{st.label}.</strong> {st.text}
                  </span>
                </m.li>
              ))}
            </ol>
          </Card>
        </Rise>
      </div>
    </Slide>
  )
}

/* A jornada de Ana em quatro fases, com o elenco. */
export function JornadaSlide(meta: SlideMeta) {
  const ref = useRef<HTMLDivElement>(null)
  const { i, pick } = useAutoAdvance(jornadaResumo.phases.length, 6000, ref)
  const phase = jornadaResumo.phases[i]
  return (
    <Slide {...meta} tone="white">
      <div ref={ref}>
        <div className="max-w-[52rem]">
          <SlideTitle text={jornadaResumo.title} />
          <SlideLead className="mt-3">{jornadaResumo.lead}</SlideLead>
        </div>

        {/* A linha do tempo: quatro fases, uma de cada vez. */}
        <Rise delay={0.3} className="mt-[clamp(0.9rem,3vh,1.9rem)]">
          <div className="relative flex items-start justify-between gap-1" role="tablist" aria-label="Fases da jornada">
            <span
              className="absolute top-[0.82em] h-px bg-brand-mist"
              style={{ left: `${50 / jornadaResumo.phases.length}%`, right: `${50 / jornadaResumo.phases.length}%` }}
              aria-hidden
            />
            {jornadaResumo.phases.map((ph, n) => {
              const active = n === i
              const done = n < i
              return (
                <button
                  key={ph.key}
                  type="button"
                  role="tab"
                  aria-selected={active}
                  onClick={() => pick(n)}
                  className="relative flex flex-1 flex-col items-center gap-1.5 rounded-lg px-1 text-center focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple"
                >
                  <span
                    className={cn(
                      'flex h-[1.8em] w-[1.8em] items-center justify-center rounded-full border-2 text-[length:var(--dk-small)] font-bold tabular transition-colors',
                      active ? 'border-brand-purple bg-brand-purple text-white' : done ? 'border-brand-purple/40 bg-white text-brand-purple' : 'border-brand-mist bg-white text-brand-gray',
                    )}
                  >
                    {n + 1}
                  </span>
                  <span className={cn('text-[length:var(--dk-body)] font-bold leading-tight', active ? 'text-brand-ink' : 'text-brand-graphite')}>{ph.label}</span>
                  <span className="text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.12em] text-brand-gray">{ph.when}</span>
                </button>
              )
            })}
          </div>
        </Rise>

        <div className="mt-[clamp(0.9rem,3vh,1.9rem)] grid gap-[clamp(1rem,2.5vw,3rem)] lg:grid-cols-[0.8fr_1.2fr] lg:items-center">
          <div className="flex min-h-[clamp(10rem,30vh,17rem)] items-end justify-center gap-[clamp(0.5rem,1.5vw,1.5rem)]" aria-hidden>
            <AnimatePresence mode="wait" initial={false}>
              {phase.who.map((who, k) => (
                <m.div
                  key={`${phase.key}-${who}`}
                  initial={{ opacity: 0, y: 16 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={{ opacity: 0, y: -10 }}
                  transition={{ duration: 0.4, ease: EASE, delay: k * 0.08 }}
                  className="flex flex-col items-center gap-2"
                >
                  <CastFigure who={who} alt="" className="h-[clamp(8.5rem,26vh,14rem)]" imgClassName="h-full w-auto drop-shadow-[0_12px_24px_rgba(27,18,56,0.18)]" />
                  <span className="text-[length:var(--dk-small)] font-semibold text-brand-graphite">{castMember(who).name.split(' ')[0]}</span>
                </m.div>
              ))}
            </AnimatePresence>
          </div>
          <AnimatePresence mode="wait" initial={false}>
            <m.div key={phase.key} {...swap}>
              <p className="max-w-[26rem] text-[length:var(--dk-mid)] font-extrabold leading-[1.1] tracking-brand text-brand-ink">{phase.headline}</p>
              <ul className="mt-[clamp(0.6rem,2vh,1.1rem)] space-y-[clamp(0.3rem,1vh,0.6rem)]">
                {phase.beats.map((b) => (
                  <li key={b} className="flex items-start gap-2.5 text-[length:var(--dk-lead)] font-medium leading-snug text-brand-graphite">
                    <Check className="mt-[0.3em] h-[0.9em] w-[0.9em] shrink-0 text-brand-pink" strokeWidth={3} aria-hidden />
                    {b}
                  </li>
                ))}
              </ul>
              <div className="mt-[clamp(0.7rem,2.2vh,1.25rem)] flex flex-wrap gap-2">
                {phase.modules.map((mo) => (
                  <ModuleChip key={mo.slug} slug={mo.slug} name={mo.name} />
                ))}
              </div>
            </m.div>
          </AnimatePresence>
        </div>

        <Rise delay={0.5} y={10} className="mt-[clamp(0.75rem,2.5vh,1.25rem)] flex items-start gap-2.5 border-t border-brand-mist pt-3 text-[length:var(--dk-small)] leading-snug text-brand-graphite">
          <Logo variant="symbol" decorative className="mt-[0.1em] h-[1.4em] w-[1.4em] shrink-0" />
          {jornadaResumo.hub}
        </Rise>
      </div>
    </Slide>
  )
}

const portalIcons = [Users, UserCog, Wrench]
const phoneScreens: NatPontoScreen[] = ['home', 'face', 'success']

/* Portais e NatPonto: cada pessoa entra pela sua porta. */
export function PortaisSlide(meta: SlideMeta) {
  const ref = useRef<HTMLDivElement>(null)
  const { i } = useAutoAdvance(phoneScreens.length, 2800, ref)
  return (
    <Slide {...meta} tone="off">
      <div ref={ref}>
        <div className="max-w-[54rem]">
          <SlideTitle text={portaisSlide.title} />
          <SlideLead className="mt-3">{portaisSlide.lead}</SlideLead>
        </div>
        <div className="mt-[clamp(1rem,3vh,1.75rem)] grid gap-[clamp(1rem,2.5vw,3rem)] lg:grid-cols-[1.5fr_0.8fr] lg:items-center">
          <div>
            <Stagger className="grid gap-2.5 sm:grid-cols-3" delay={0.3} stagger={0.08}>
              {portaisSlide.portals.map((p, k) => {
                const Icon = portalIcons[k]
                return (
                  <Item key={p.name}>
                    <Card className="flex h-full flex-col p-[calc(var(--dk-card)*0.9)]">
                      <IconBox>
                        <Icon strokeWidth={1.7} />
                      </IconBox>
                      <p className="mt-2.5 text-[length:var(--dk-body)] font-bold leading-tight text-brand-ink">{p.name}</p>
                      <p className="mt-0.5 text-[length:var(--dk-small)] font-semibold text-brand-purple">{p.who}</p>
                      <ul className="mt-2 space-y-1 text-[length:var(--dk-small)] leading-snug text-brand-graphite">
                        {p.items.map((it) => (
                          <li key={it} className="flex gap-2">
                            <Check className="mt-[0.2em] h-[1em] w-[1em] shrink-0 text-brand-pink" strokeWidth={2.5} aria-hidden />
                            {it}
                          </li>
                        ))}
                      </ul>
                    </Card>
                  </Item>
                )
              })}
            </Stagger>
            <Rise delay={0.6} className="mt-3 grid gap-3 sm:grid-cols-[1fr_auto] sm:items-center">
              <Card accent className="flex items-center gap-3 p-[calc(var(--dk-card)*0.85)]">
                <span className="flex h-[var(--dk-icon)] w-[var(--dk-icon)] shrink-0 items-center justify-center rounded-xl bg-brand-gradient text-white">
                  <NatPontoIcon className="h-[60%] w-[60%]" aria-hidden />
                </span>
                <p className="text-[length:var(--dk-small)] leading-snug text-brand-ink">
                  <strong className="text-[length:var(--dk-body)] font-bold">{portaisSlide.app.name}.</strong> {portaisSlide.app.text}
                </p>
              </Card>
              <Big size="md" value={portaisSlide.stat.value} label={portaisSlide.stat.label} accent="pink" className="sm:max-w-[13rem]" />
            </Rise>
          </div>
          <Rise delay={0.35} className="min-w-0">
            <div role="img" aria-label="App NatPonto trocando de tela: início, reconhecimento facial e marcação confirmada" className="relative mx-auto w-[min(220px,24vh)]">
              <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height}>
                <AnimatePresence mode="wait" initial={false}>
                  <m.div key={phoneScreens[i]} initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }} transition={{ duration: 0.3 }} className="absolute inset-0">
                    <NatPontoPhone screen={phoneScreens[i]} />
                  </m.div>
                </AnimatePresence>
              </ScaledFrame>
              <div className="mt-3 flex justify-center gap-1.5" aria-hidden>
                {phoneScreens.map((s, n) => (
                  <span key={s} className={cn('h-1.5 rounded-full transition-all', n === i ? 'w-5 bg-brand-purple' : 'w-1.5 bg-brand-gray/50')} />
                ))}
              </div>
            </div>
          </Rise>
        </div>
      </div>
    </Slide>
  )
}

/* A mesma rotina, antes e depois: um interruptor que muda todas as linhas. */
export function AntesDepoisSlide(meta: SlideMeta) {
  const ref = useRef<HTMLDivElement>(null)
  const inView = useInView(ref, { amount: 0.5 })
  const reduced = useReducedMotion()
  const [mode, setMode] = useState<'antes' | 'depois'>('antes')
  const [manual, setManual] = useState(false)
  /* Deixa o "hoje" na tela por alguns segundos e vira sozinho; a partir do toque, quem manda é o apresentador. */
  useEffect(() => {
    if (manual || !inView || reduced) return
    const t = window.setTimeout(() => setMode('depois'), 4500)
    return () => window.clearTimeout(t)
  }, [manual, inView, reduced])
  const choose = (m: 'antes' | 'depois') => {
    setManual(true)
    setMode(m)
  }
  const after = mode === 'depois'
  return (
    <Slide {...meta} tone="white">
      <div ref={ref}>
        <div className="flex flex-wrap items-end justify-between gap-4">
          <div className="max-w-[40rem]">
            <SlideTitle text={antesDepois.title} />
            <SlideLead className="mt-3">{antesDepois.lead}</SlideLead>
          </div>
          <Rise delay={0.3}>
            <div className="inline-flex rounded-full border border-brand-mist bg-brand-off-white p-1" role="group" aria-label="Alternar entre hoje e com a Natcorp">
              {(['antes', 'depois'] as const).map((k) => {
                const active = mode === k
                return (
                  <button
                    key={k}
                    type="button"
                    onClick={() => choose(k)}
                    aria-pressed={active}
                    className={cn(
                      'rounded-full px-[1.1em] py-[0.55em] text-[length:var(--dk-body)] font-bold transition-colors',
                      active ? (k === 'depois' ? 'bg-brand-purple text-white shadow-soft' : 'bg-brand-ink text-white shadow-soft') : 'text-brand-graphite hover:text-brand-ink',
                    )}
                  >
                    {k === 'antes' ? 'Hoje' : 'Com a Natcorp'}
                  </button>
                )
              })}
            </div>
          </Rise>
        </div>
        <Stagger as="ul" className="mt-[clamp(1rem,3vh,1.75rem)] grid gap-2.5 sm:grid-cols-2 lg:grid-cols-3" delay={0.35} stagger={0.06} aria-label="Rotinas do RH">
          {antesDepois.rows.map((r) => (
            <Item key={r.task} as="li">
              <div className={cn('flex h-full flex-col rounded-2xl border p-[calc(var(--dk-card)*0.9)] transition-colors duration-500', after ? 'border-brand-pink/40 bg-white shadow-soft' : 'border-dashed border-brand-gray/60 bg-brand-off-white')}>
                <p className="flex items-center gap-2 text-[length:var(--dk-body)] font-bold text-brand-ink">
                  {after ? <Sparkles className="h-[1em] w-[1em] text-brand-pink" strokeWidth={2} aria-hidden /> : <ShieldAlert className="h-[1em] w-[1em] text-brand-gray" strokeWidth={2} aria-hidden />}
                  {r.task}
                </p>
                <AnimatePresence mode="wait" initial={false}>
                  <m.p key={mode} {...swap} className={cn('mt-1.5 text-[length:var(--dk-small)] leading-relaxed', after ? 'text-brand-ink' : 'text-brand-graphite')}>
                    {after ? r.after : r.before}
                  </m.p>
                </AnimatePresence>
              </div>
            </Item>
          ))}
        </Stagger>
      </div>
    </Slide>
  )
}

/* A NATI nos canais do colaborador, e avisando o RH antes. */
export function NatiCanaisSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="dark">
      <div className="grid gap-[clamp(1.25rem,3vw,3.5rem)] lg:grid-cols-[0.9fr_1.2fr] lg:items-center">
        <div>
          <SlideTitle dark text={natiCanais.title} className="text-[length:calc(var(--dk-h2)*0.92)]" />
          <SlideLead dark className="mt-3 max-w-[32rem]">
            {natiCanais.lead}
          </SlideLead>
          <Stagger className="mt-[clamp(0.75rem,2.5vh,1.5rem)] grid gap-2" delay={0.4} stagger={0.07}>
            {natiCanais.bullets.map((b) => (
              <Item key={b} className="flex gap-3">
                <span className="mt-[0.2em] flex h-[1.3em] w-[1.3em] shrink-0 items-center justify-center rounded-full bg-[#E4A9C4]/20 text-[#F3C9DA]">
                  <Check className="h-[0.7em] w-[0.7em]" strokeWidth={3} aria-hidden />
                </span>
                <p className="text-[length:var(--dk-body)] leading-snug text-white/85">{b}</p>
              </Item>
            ))}
          </Stagger>
          <Rise delay={0.7} className="mt-[clamp(0.75rem,2.5vh,1.5rem)] flex flex-wrap gap-2">
            {['Portais', 'WhatsApp', 'Microsoft Teams', 'NatPonto'].map((c) => (
              <Chip key={c} dark tone="pink">
                <Smartphone className="h-[1em] w-[1em]" strokeWidth={2} aria-hidden />
                {c}
              </Chip>
            ))}
          </Rise>
        </div>
        <Rise delay={0.25} className="flex min-w-0 items-stretch justify-center gap-[clamp(0.75rem,2vw,1.5rem)]">
          <WhatsAppMockup className="w-[min(220px,24vh)] shrink-0 self-center text-[13px]" />
          <InsightStream interval={6000} className="hidden min-w-0 flex-1 text-[length:var(--dk-small)] lg:flex" />
        </Rise>
      </div>
    </Slide>
  )
}

/* People Analytics: o painel do sistema, com os dados de todos os módulos. */
export function AnalyticsSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="off">
      <div className="grid gap-[clamp(1rem,2.5vw,3rem)] lg:grid-cols-[0.8fr_1.4fr] lg:items-center">
        <div>
          <SlideTitle text={analyticsSlide.title} className="text-[length:calc(var(--dk-h2)*0.9)]" />
          <SlideLead className="mt-3">{analyticsSlide.lead}</SlideLead>
          <Stagger className="mt-[clamp(1rem,3vh,1.75rem)] grid grid-cols-3 gap-3 lg:grid-cols-1 lg:gap-[clamp(0.6rem,1.8vh,1rem)]" delay={0.45}>
            {analyticsSlide.numbers.map((n, k) => (
              <Item key={n.label}>
                <Big size="md" value={n.value} label={n.label} accent={k === 0 ? 'pink' : 'purple'} />
              </Item>
            ))}
          </Stagger>
        </div>
        <Rise delay={0.3} className="min-w-0">
          <div
            role="img"
            aria-label="Painel do Operador com os indicadores de Medicina Ocupacional: procedimentos, tipos de procedimento, unidades de atendimento e profissionais"
            className="overflow-hidden rounded-2xl border border-brand-mist bg-white shadow-lift"
          >
            <ScaledFrame width={ANALYTICS_SIZE.width} height={ANALYTICS_SIZE.height}>
              <MedicineIndicators />
            </ScaledFrame>
          </div>
          <p className="mt-2 text-center text-[length:var(--dk-small)] text-brand-graphite">Painel do Operador: indicadores de Medicina Ocupacional, prontos, com os dados dos módulos.</p>
        </Rise>
      </div>
    </Slide>
  )
}
