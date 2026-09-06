import { useRef } from 'react'
import { m, useInView } from 'motion/react'
import { Activity, Cable, Calculator, Cloud, DatabaseBackup, FileUp, Layers, Lock, ShieldCheck, Workflow } from 'lucide-react'
import { CloudMotion } from '@/components/brand/motion/CloudMotion'
import { NatiBubble, NatiChatWindow, UserBubble } from '@/components/mockups/nati/NatiChatWindow'
import { capabilities, insights, natiStats } from '@/content/nati'
import { conexoes, natiSlide, seguranca } from '@/content/presentation'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { Big, Card, Chip, IconBox, Item, Rise, Slide, SlideLead, SlideTitle, Stagger, type SlideMeta } from '../Slide'

const insight = insights[0]

/* 11 · NATI: capacidades, uma conversa real e os números (fundo Azul Profundo). */
export function NatiSlide(meta: SlideMeta) {
  const values = insight.chart.values
  const max = Math.max(...values)
  const stats = natiStats.filter((s) => s.value !== 7)
  return (
    <Slide {...meta} tone="dark">
      <div className="grid gap-[clamp(1.25rem,3vw,3.5rem)] lg:grid-cols-[1.05fr_1fr] lg:items-center">
        <div>
          <SlideTitle dark text={natiSlide.title} className="text-[length:calc(var(--dk-h2)*0.9)]" />
          <SlideLead dark className="mt-3 max-w-[34rem]">
            {natiSlide.lead}
          </SlideLead>
          <Stagger className="mt-[clamp(0.75rem,2.5vh,1.5rem)] grid gap-1.5" delay={0.4} stagger={0.06}>
            {capabilities.map((c) => (
              <Item key={c.id} className="flex gap-3">
                <span className="mt-[0.5em] h-1.5 w-1.5 shrink-0 rounded-full bg-[#E4A9C4]" aria-hidden />
                <p className="text-[length:var(--dk-small)] leading-snug text-white/75">
                  <strong className="text-[length:var(--dk-body)] font-bold text-white">{c.name}.</strong> {c.text}
                </p>
              </Item>
            ))}
          </Stagger>
          <Stagger className="mt-[clamp(0.75rem,3vh,1.75rem)] grid grid-cols-3 gap-3 border-t border-white/10 pt-[clamp(0.75rem,2vh,1.25rem)]" delay={0.6}>
            {stats.map((s, i) => (
              <Item key={s.label}>
                <Big dark size="md" value={s.value} prefix={s.prefix} suffix={s.suffix} label={s.label} accent={i === 0 ? 'pink' : undefined} />
              </Item>
            ))}
          </Stagger>
        </div>
        <Rise delay={0.25} className="min-w-0">
          <NatiChatWindow bare className="mx-auto w-full max-w-[32rem] text-[length:var(--dk-small)]" bodyClassName="p-3.5">
            <m.div
              className="space-y-3"
              variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.5, delayChildren: 0.5 } } }}
              initial="hidden"
              whileInView="visible"
              viewport={{ once: true, amount: 0.2 }}
            >
              <UserBubble time="09:12">{natiSlide.question}</UserBubble>
              <NatiBubble>
                <p className="pr-5">{insight.text}</p>
                <div className="mt-3 rounded-lg border border-brand-mist bg-brand-off-white/60 p-2.5" role="img" aria-label={`Horas extras por mês: ${values.map((v, i) => `${insight.chart.labels?.[i]} ${v} h`).join(', ')}`}>
                  <div className="flex items-center justify-between text-[11px] font-semibold text-brand-graphite">
                    <span>Horas extras · Unidade Barueri</span>
                    <span className="tabular text-brand-ink">{max} h em ago</span>
                  </div>
                  <div className="mt-2 flex h-12 items-end gap-1.5">
                    {values.map((v, i) => {
                      const last = i === values.length - 1
                      return (
                        <m.div
                          key={i}
                          className={cn('flex-1 rounded-t-[4px]', last ? 'bg-brand-pink' : 'bg-brand-purple/80')}
                          style={{ height: `${(v / max) * 100}%`, transformOrigin: 'bottom' }}
                          variants={{ hidden: { scaleY: 0 }, visible: { scaleY: 1, transition: { duration: 0.6, ease: EASE, delay: 0.2 + i * 0.05 } } }}
                        />
                      )
                    })}
                  </div>
                  <div className="mt-1 flex gap-1.5 text-[10px] text-brand-gray">
                    {insight.chart.labels?.map((l) => (
                      <span key={l} className="flex-1 text-center">
                        {l}
                      </span>
                    ))}
                  </div>
                </div>
                <p className="mt-3 inline-flex items-center rounded-md bg-brand-purple px-2.5 py-1 text-[11.5px] font-semibold text-white">{insight.action}</p>
              </NatiBubble>
            </m.div>
          </NatiChatWindow>
        </Rise>
      </div>
    </Slide>
  )
}

const securityIcons = [Cloud, Layers, DatabaseBackup, Lock, Activity, ShieldCheck]

/* 12 · Segurança e infraestrutura: seis compromissos e a nuvem se desenhando. */
export function SegurancaSlide(meta: SlideMeta) {
  const ref = useRef<HTMLDivElement>(null)
  const inView = useInView(ref, { once: true, amount: 0.35 })
  return (
    <Slide {...meta} tone="white">
      <div className="max-w-[52rem]">
        <SlideTitle text={seguranca.title} />
        <SlideLead className="mt-3">{seguranca.lead}</SlideLead>
      </div>
      <div ref={ref} className="mt-[clamp(0.75rem,2.5vh,1.75rem)] grid gap-[clamp(1rem,2.5vw,3rem)] lg:grid-cols-[1.1fr_1fr] lg:items-center">
        <Stagger className="grid gap-2.5 sm:grid-cols-2" delay={0.3} stagger={0.06}>
          {seguranca.items.map((it, i) => {
            const Icon = securityIcons[i]
            return (
              <Item key={it.title}>
                <Card className="flex h-full gap-3">
                  <IconBox>
                    <Icon strokeWidth={1.7} />
                  </IconBox>
                  <div className="min-w-0">
                    <p className="text-[length:var(--dk-body)] font-bold leading-tight text-brand-ink">{it.title}</p>
                    <p className="mt-1 text-[length:var(--dk-small)] leading-snug text-brand-graphite">{it.text}</p>
                  </div>
                </Card>
              </Item>
            )
          })}
        </Stagger>
        <Rise delay={0.2} className="min-w-0">
          <CloudMotion tone="gradient" play={inView} className="mx-auto w-full max-w-[36rem]" />
        </Rise>
      </div>
    </Slide>
  )
}

const pathIcons = [Cable, Workflow, FileUp, Calculator]

/* 13 · Conexões e performance. */
export function ConexoesSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="off">
      <div className="max-w-[54rem]">
        <SlideTitle text={conexoes.title} />
      </div>
      <div className="mt-[clamp(1rem,3.5vh,2.25rem)] grid gap-[clamp(1rem,2.5vw,3rem)] lg:grid-cols-[1.25fr_0.85fr] lg:items-center">
        <Stagger className="grid gap-2.5 sm:grid-cols-2" delay={0.3} stagger={0.06}>
          {conexoes.paths.map((p, i) => {
            const Icon = pathIcons[i]
            return (
              <Item key={p.title}>
                <Card className="flex h-full gap-3">
                  <IconBox>
                    <Icon strokeWidth={1.7} />
                  </IconBox>
                  <div className="min-w-0">
                    <p className="text-[length:var(--dk-body)] font-bold leading-tight text-brand-ink">{p.title}</p>
                    <p className="mt-1 text-[length:var(--dk-small)] leading-snug text-brand-graphite">{p.text}</p>
                  </div>
                </Card>
              </Item>
            )
          })}
        </Stagger>
        <div>
          <Stagger className="grid grid-cols-3 gap-3 lg:grid-cols-1 lg:gap-[clamp(0.75rem,2vh,1.25rem)]" delay={0.45}>
            {conexoes.numbers.map((n, i) => (
              <Item key={n.label}>
                <Big size="md" value={n.value} label={n.label} accent={i === 0 ? 'pink' : 'purple'} />
              </Item>
            ))}
          </Stagger>
          <Rise delay={0.7} y={8} className="mt-[clamp(0.75rem,2.5vh,1.5rem)] flex flex-wrap items-center gap-2">
            <span className="text-[length:var(--dk-small)] font-semibold text-brand-graphite">Onde o sistema está:</span>
            {conexoes.platforms.map((p) => (
              <Chip key={p} tone="purple">
                {p}
              </Chip>
            ))}
          </Rise>
        </div>
      </div>
    </Slide>
  )
}
