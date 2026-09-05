import { m } from 'motion/react'
import { Link } from 'react-router'
import { Check, ShieldCheck } from 'lucide-react'
import { Eyebrow } from '@/components/sections/Section'
import { Reveal } from '@/components/motion/Reveal'
import { moduleIcons } from '@/content/modulePages/icons'
import { getModuleEntry, modulePath } from '@/content/modulePages'
import { effectivation } from '@/content/hiringJourney'
import { EASE, viewportOnce } from '@/lib/motion'

const lineVariants = {
  hidden: { pathLength: 0, opacity: 0 },
  visible: (i: number) => ({ pathLength: 1, opacity: 1, transition: { duration: 0.9, ease: EASE, delay: 0.25 + i * 0.12 } }),
}

const rowVariants = {
  hidden: { opacity: 0, x: 12 },
  visible: (i: number) => ({ opacity: 1, x: 0, transition: { duration: 0.55, ease: EASE, delay: 0.55 + i * 0.12 } }),
}

/** O momento em que a aprovação da admissão atualiza vários módulos de uma vez. */
export function EffectivationHub({ id }: { id: string }) {
  const { when, title, text, by, targets, base } = effectivation
  const targetEntries = targets.map((t) => ({ ...t, entry: getModuleEntry(t.slug) })).filter((t) => t.entry)
  const n = targetEntries.length
  const baseEntry = getModuleEntry(base.slug)
  const H = 100

  return (
    <section id={id} data-step={id} aria-labelledby={`${id}-title`} className="on-dark relative scroll-mt-28 overflow-hidden rounded-3xl bg-brand-blue p-6 text-white sm:p-8 lg:p-10">
      <div aria-hidden className="pointer-events-none absolute -right-24 -top-24 h-72 w-72 rounded-full bg-[radial-gradient(circle,rgba(201,87,136,0.35),transparent_70%)]" />
      <Reveal y={12} duration={0.5}>
        <Eyebrow tone="white">
          Efetivação automática · {when.day} · {when.date} · {when.time}
        </Eyebrow>
      </Reveal>
      <Reveal delay={0.08}>
        <h3 id={`${id}-title`} className="mt-4 text-2xl font-extrabold leading-tight sm:text-3xl">
          {title}
        </h3>
      </Reveal>
      <Reveal delay={0.16}>
        <p className="mt-3 max-w-2xl text-[15.5px] leading-relaxed text-white/80">{text}</p>
      </Reveal>

      <m.div
        className="mt-8 grid gap-4 sm:grid-cols-[200px_4rem_minmax(0,1fr)] sm:gap-0"
        initial="hidden"
        whileInView="visible"
        viewport={viewportOnce}
      >
        <m.div
          className="flex flex-col justify-center rounded-2xl border border-white/15 bg-white/[0.06] p-5"
          variants={{ hidden: { opacity: 0, scale: 0.96 }, visible: { opacity: 1, scale: 1, transition: { duration: 0.6, ease: EASE } } }}
        >
          <span className="flex h-10 w-10 items-center justify-center rounded-full bg-emerald-400 text-brand-blue">
            <Check className="h-5 w-5" strokeWidth={3} aria-hidden />
          </span>
          <p className="mt-4 text-[11px] font-semibold uppercase tracking-[0.14em] text-white/60">Admissão Digital</p>
          <p className="mt-1 text-lg font-extrabold leading-tight">Admissão confirmada</p>
          <p className="mt-2 text-[12.5px] text-white/70">{by} · {when.time}</p>
        </m.div>

        <div className="hidden sm:block" aria-hidden>
          <svg viewBox={`0 0 100 ${n * H}`} preserveAspectRatio="none" className="h-full w-full overflow-visible">
            {targetEntries.map((_, i) => {
              const y = i * H + H / 2
              const cy = (n * H) / 2
              return (
                <m.path
                  key={i}
                  d={`M0,${cy} C55,${cy} 45,${y} 100,${y}`}
                  fill="none"
                  stroke="rgba(255,255,255,0.45)"
                  strokeWidth={1.5}
                  vectorEffect="non-scaling-stroke"
                  custom={i}
                  variants={lineVariants}
                />
              )
            })}
          </svg>
        </div>

        <ol className="grid auto-rows-fr gap-2">
          {targetEntries.map((t, i) => {
            const Icon = moduleIcons[t.entry!.icon]
            return (
              <m.li key={t.slug} custom={i} variants={rowVariants}>
                <Link
                  to={modulePath(t.slug)}
                  className="group flex h-full items-center gap-3 rounded-xl border border-white/10 bg-white/[0.05] px-3.5 py-2.5 transition-colors duration-300 hover:border-white/30 hover:bg-white/10"
                >
                  <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-white/10 text-white">
                    <Icon className="h-4 w-4" strokeWidth={1.8} aria-hidden />
                  </span>
                  <span className="min-w-0">
                    <span className="block text-[13.5px] font-bold leading-tight">
                      {t.entry!.name}
                      {t.slug === 'ponto-eletronico' && <span className="font-medium text-white/70"> + NatPonto</span>}
                    </span>
                    <span className="block text-[12px] leading-snug text-white/70">{t.note}</span>
                  </span>
                </Link>
              </m.li>
            )
          })}
        </ol>
      </m.div>

      {baseEntry && (
        <Reveal delay={0.2} className="mt-6 flex flex-wrap items-center gap-3 rounded-2xl border border-white/10 px-4 py-3 text-[12.5px] text-white/80">
          <ShieldCheck className="h-4 w-4 shrink-0 text-emerald-300" aria-hidden />
          <span>
            <Link to={modulePath(base.slug)} className="font-bold text-white underline-offset-4 hover:underline">
              {baseEntry.name}
            </Link>
            : {base.note}
          </span>
        </Reveal>
      )}
    </section>
  )
}
