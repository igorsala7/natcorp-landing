import { useRef } from 'react'
import { useInView } from 'motion/react'
import { BarChart3, FileSpreadsheet, Hourglass, Keyboard, ShieldAlert, Sparkles, Unplug, Users } from 'lucide-react'
import { Logo } from '@/components/brand/Logo'
import { SystemMotion } from '@/components/brand/motion/SystemMotion'
import { moduleIcons } from '@/content/modulePages/icons'
import { categoryMeta } from '@/content/moduleCategories'
import { moduleGroups } from '@/content/modules'
import { custo, deckMeta, momento, plataforma, resposta } from '@/content/presentation'
import { Big, Card, Chip, IconBox, Item, Rise, Slide, SlideLead, SlideTitle, Stagger, type SlideMeta } from '../Slide'

/* 00 · Capa: branca, marca colorida, contorno no canto, promessa em ExtraBold e filete roxo na base. */
export function CoverSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="white" contour bare>
      <div className="flex h-full flex-col">
        <Rise y={0} duration={0.6}>
          <Logo variant="horizontal" className="h-[clamp(2rem,4.2vh,2.9rem)] w-auto" title="Natcorp" />
        </Rise>
        <div className="my-auto max-w-[58rem] pt-[4vh]">
          <Rise delay={0.15} y={10}>
            <p className="text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.16em] text-brand-purple">{deckMeta.edition}</p>
          </Rise>
          <SlideTitle as="h1" text="A [[transformação]] que seu RH precisa." delay={0.3} className="mt-4 max-w-[14ch]" />
          <SlideLead delay={0.8} className="mt-5 max-w-[42rem]">
            {deckMeta.subtitle}
          </SlideLead>
          <Stagger delay={1} className="mt-6 flex flex-wrap gap-2">
            {deckMeta.audience.map((a) => (
              <Item key={a}>
                <Chip>{a}</Chip>
              </Item>
            ))}
          </Stagger>
        </div>
        <Rise delay={1.3} y={8} className="hidden items-center gap-2 text-[length:var(--dk-small)] font-medium text-brand-gray sm:flex">
          <Keyboard className="h-[1.2em] w-[1.2em]" strokeWidth={1.7} aria-hidden />
          Use as setas para navegar · F para tela cheia · N para as notas
        </Rise>
      </div>
      <span className="absolute inset-x-0 bottom-0 h-[6px] bg-brand-purple" aria-hidden />
    </Slide>
  )
}

const shiftIcons = [BarChart3, Sparkles, Users]

/* 01 · O momento: por que agora (fundo Azul Profundo). */
export function MomentoSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="dark">
      <div className="grid gap-[clamp(1.5rem,3vw,4rem)] lg:grid-cols-[1.1fr_1fr] lg:items-center">
        <div>
          <SlideTitle dark text={momento.title} />
          <SlideLead dark className="mt-5 max-w-[36rem]">
            {momento.lead}
          </SlideLead>
        </div>
        <Stagger className="grid gap-3">
          {momento.shifts.map((s, i) => {
            const Icon = shiftIcons[i]
            return (
              <Item key={s.title}>
                <Card dark className="flex items-start gap-4">
                  <IconBox dark>
                    <Icon strokeWidth={1.7} />
                  </IconBox>
                  <div className="min-w-0">
                    <p className="text-[length:var(--dk-lead)] font-bold leading-snug">{s.title}</p>
                    <p className="mt-1 text-[length:var(--dk-body)] leading-relaxed text-white/72">{s.text}</p>
                  </div>
                </Card>
              </Item>
            )
          })}
        </Stagger>
      </div>
      <Rise delay={0.5} className="mt-[clamp(1.25rem,4vh,2.5rem)] border-l-[3px] border-[#E4A9C4] pl-5">
        <p className="max-w-[46rem] text-[length:var(--dk-lead)] font-bold leading-snug text-white">{momento.punch}</p>
      </Rise>
    </Slide>
  )
}

const painIcons = [Unplug, FileSpreadsheet, Hourglass]

/* 02 · O custo do RH operacional. */
export function CustoSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="white">
      <div className="grid gap-[clamp(1.5rem,3vw,4rem)] lg:grid-cols-[1.05fr_1fr] lg:items-center">
        <div>
          <SlideTitle text={custo.title} />
          <Stagger className="mt-[clamp(1.25rem,3.5vh,2.5rem)] space-y-[clamp(0.75rem,2vh,1.25rem)]" delay={0.3}>
            {custo.pains.map((p, i) => {
              const Icon = painIcons[i]
              return (
                <Item key={p.title} className="flex gap-4">
                  <IconBox>
                    <Icon strokeWidth={1.7} />
                  </IconBox>
                  <p className="text-[length:var(--dk-body)] leading-relaxed text-brand-graphite">
                    <strong className="font-bold text-brand-ink">{p.title}</strong> {p.text}
                  </p>
                </Item>
              )
            })}
          </Stagger>
        </div>
        <Rise delay={0.35} className="min-w-0">
          <div className="rounded-3xl border border-brand-mist bg-brand-off-white p-[var(--dk-card)]">
            <div className="flex items-center justify-between gap-3">
              <p className="text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.14em] text-brand-graphite">Hoje, na maioria das empresas</p>
              <Chip tone="pink">Cenário ilustrativo</Chip>
            </div>
            <Stagger className="mt-3 grid gap-2.5 sm:grid-cols-2" delay={0.5} stagger={0.1}>
              {custo.today.map((t) => (
                <Item key={t.title}>
                  <div className="rounded-xl border border-dashed border-brand-gray/50 bg-white p-[calc(var(--dk-card)*0.85)]">
                    <p className="text-[length:var(--dk-body)] font-bold text-brand-ink">{t.title}</p>
                    <p className="mt-0.5 font-mono text-[length:var(--dk-small)] text-brand-gray">{t.file}</p>
                    <p className="mt-2 inline-block rounded-md bg-brand-off-white px-2 py-1 text-[length:var(--dk-small)] font-semibold text-brand-purple">{t.badge}</p>
                  </div>
                </Item>
              ))}
            </Stagger>
            <p className="mt-3 flex items-start gap-2 text-[length:var(--dk-small)] leading-snug text-brand-graphite">
              <ShieldAlert className="mt-[0.15em] h-[1.2em] w-[1.2em] shrink-0 text-brand-pink" strokeWidth={1.8} aria-hidden />
              {custo.risk}
            </p>
          </div>
        </Rise>
      </div>
    </Slide>
  )
}

/* 03 · A resposta: assinatura negativa sobre gradiente e o motion "um sistema, uma experiência". */
export function RespostaSlide(meta: SlideMeta) {
  const ref = useRef<HTMLDivElement>(null)
  const inView = useInView(ref, { once: true, amount: 0.35 })
  return (
    <Slide {...meta} tone="gradient" contour>
      <div ref={ref} className="grid gap-[clamp(1.5rem,3vw,4rem)] lg:grid-cols-[1fr_1.05fr] lg:items-center">
        <div>
          <Rise y={0}>
            <Logo variant="horizontal" tone="white" className="h-[clamp(1.6rem,3.6vh,2.4rem)] w-auto" decorative />
          </Rise>
          <SlideTitle dark text={resposta.title} className="mt-[clamp(1rem,3vh,1.75rem)]" />
          <SlideLead dark className="mt-4 max-w-[36rem]">
            {resposta.lead}
          </SlideLead>
          <Stagger className="mt-[clamp(1.25rem,3.5vh,2.25rem)] grid grid-cols-3 gap-4" delay={0.5}>
            {resposta.numbers.map((n) => (
              <Item key={n.label}>
                <Big dark size="md" value={n.value} suffix={n.suffix} label={n.label} />
              </Item>
            ))}
          </Stagger>
        </div>
        <Rise delay={0.2} className="min-w-0">
          <SystemMotion tone="white" play={inView} className="mx-auto w-full max-w-[40rem]" />
        </Rise>
      </div>
    </Slide>
  )
}

/* 04 · A plataforma: as sete frentes em volta do símbolo. */
export function PlataformaSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="white">
      <div className="max-w-[52rem]">
        <SlideTitle text={plataforma.title} />
        <SlideLead className="mt-3">{plataforma.lead}</SlideLead>
      </div>
      <div className="mt-[clamp(1.25rem,3.5vh,2.5rem)] grid gap-[clamp(1rem,2.5vw,3rem)] lg:grid-cols-[auto_1fr] lg:items-center">
        <Rise delay={0.3} className="flex items-center gap-5 lg:flex-col lg:items-start">
          <Logo variant="symbol" decorative className="h-[clamp(5rem,16vh,9rem)] w-auto" />
          <ul className="space-y-1 text-[length:var(--dk-body)] font-semibold text-brand-ink">
            {['Um cadastro', 'Uma base de dados', 'Uma experiência'].map((t) => (
              <li key={t} className="flex items-center gap-2">
                <span className="h-1.5 w-1.5 rounded-full bg-brand-pink" aria-hidden />
                {t}
              </li>
            ))}
          </ul>
        </Rise>
        <Stagger className="grid gap-2.5 sm:grid-cols-2 lg:grid-cols-4" delay={0.35} stagger={0.06}>
          {moduleGroups.map((g, i) => {
            const Icon = moduleIcons[categoryMeta[g.id as keyof typeof categoryMeta].icon]
            return (
              <Item key={g.id} className={i === 6 ? 'lg:col-span-2' : undefined}>
                <Card className="flex h-full gap-3">
                  <IconBox>
                    <Icon strokeWidth={1.7} />
                  </IconBox>
                  <div className="min-w-0">
                    <p className="text-[length:var(--dk-body)] font-bold leading-tight text-brand-ink">{g.name}</p>
                    <p className="mt-1 text-[length:var(--dk-small)] leading-snug text-brand-graphite">{g.tagline}</p>
                    <p className="mt-2 text-[length:var(--dk-small)] font-semibold text-brand-purple">{g.modules.length} módulos</p>
                  </div>
                </Card>
              </Item>
            )
          })}
        </Stagger>
      </div>
    </Slide>
  )
}
