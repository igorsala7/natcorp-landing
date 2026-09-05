import { Link } from 'react-router'
import { m } from 'motion/react'
import { ArrowLeft, ArrowRight, ArrowUpRight } from 'lucide-react'
import { Stagger, StaggerItem } from '@/components/motion/Reveal'
import { modulePath, type ModuleEntry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import type { ModuleBenefit, ModuleFeature, ModuleFlowStep, ModulePersona } from '@/content/modulePages/types'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

export function BenefitsGrid({ items }: { items: ModuleBenefit[] }) {
  const cols = items.length >= 4 ? 'lg:grid-cols-4' : 'lg:grid-cols-3'
  return (
    <Stagger className={cn('mt-12 grid gap-4 sm:grid-cols-2', cols)}>
      {items.map((b) => (
        <StaggerItem
          key={b.title}
          className="group rounded-2xl border border-brand-mist bg-white p-6 transition-[border-color,box-shadow,transform] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
        >
          <span className="block h-2 w-2 rotate-45 rounded-[1px] bg-brand-pink" aria-hidden />
          <h3 className="mt-5 text-lg font-bold leading-snug text-brand-ink">{b.title}</h3>
          <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{b.text}</p>
        </StaggerItem>
      ))}
    </Stagger>
  )
}

export function FeaturesGrid({ items, className }: { items: ModuleFeature[]; className?: string }) {
  return (
    <Stagger className={cn('mt-12 grid gap-4 md:grid-cols-2 lg:grid-cols-3', className)} stagger={0.06}>
      {items.map((f) => {
        const FIcon = moduleIcons[f.icon]
        return (
          <StaggerItem
            key={f.title}
            className="group rounded-2xl border border-brand-mist bg-white p-6 transition-[border-color,box-shadow,transform] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
          >
            <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
              <FIcon className="h-5 w-5" strokeWidth={1.6} />
            </span>
            <h3 className="mt-4 text-lg font-bold leading-snug text-brand-ink">{f.title}</h3>
            <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{f.text}</p>
          </StaggerItem>
        )
      })}
    </Stagger>
  )
}

const stepCols: Record<number, string> = {
  3: 'lg:grid-cols-3',
  4: 'lg:grid-cols-4',
  5: 'lg:grid-cols-5',
  6: 'lg:grid-cols-6',
}

export function FlowSteps({ steps }: { steps: ModuleFlowStep[] }) {
  const n = Math.min(Math.max(steps.length, 3), 6)
  return (
    <ol className={cn('relative mt-12 grid gap-8 md:grid-cols-3', stepCols[n])}>
      <m.span
        aria-hidden
        className="absolute left-5 right-5 top-5 hidden h-px bg-brand-mist lg:block"
        style={{ transformOrigin: 'left' }}
        initial={{ scaleX: 0 }}
        whileInView={{ scaleX: 1 }}
        viewport={viewportOnce}
        transition={{ duration: 1.2, ease: EASE, delay: 0.2 }}
      />
      {steps.map((s, i) => (
        <m.li
          key={s.title}
          className="relative"
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={viewportOnce}
          transition={{ duration: 0.6, ease: EASE, delay: 0.15 + i * 0.12 }}
        >
          <span className="relative z-10 flex h-10 w-10 items-center justify-center rounded-full bg-brand-purple text-sm font-extrabold tabular text-white shadow-[0_0_0_6px_#fff]">
            {i + 1}
          </span>
          <h3 className="mt-4 text-lg font-bold leading-snug text-brand-ink">{s.title}</h3>
          <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{s.text}</p>
        </m.li>
      ))}
    </ol>
  )
}

export function PersonasGrid({ items }: { items: ModulePersona[] }) {
  return (
    <Stagger className="mt-12 grid gap-4 md:grid-cols-3">
      {items.map((p) => (
        <StaggerItem key={p.role} className="rounded-2xl border border-brand-mist bg-white p-6 shadow-soft">
          <p className="text-[12px] font-semibold uppercase tracking-[0.14em] text-brand-purple">{p.role}</p>
          <p className="mt-3 text-[15px] leading-relaxed text-brand-graphite">{p.text}</p>
        </StaggerItem>
      ))}
    </Stagger>
  )
}

/** Cartões de módulos relacionados, para fundo escuro. */
export function RelatedModules({ items, className }: { items: ModuleEntry[]; className?: string }) {
  return (
    <Stagger className={cn('mt-7 grid gap-3 sm:grid-cols-2', className)} delay={0.2}>
      {items.map((r) => {
        const RIcon = moduleIcons[r.icon]
        return (
          <StaggerItem key={r.slug}>
            <Link
              to={modulePath(r.slug)}
              className="group flex h-full items-start gap-3 rounded-xl border border-white/15 bg-white/[0.06] p-4 text-left transition-[background-color,border-color] duration-300 hover:border-white/40 hover:bg-white/[0.12]"
            >
              <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-white/10 text-[#E4A9C4]">
                <RIcon className="h-4.5 w-4.5" strokeWidth={1.6} />
              </span>
              <span className="min-w-0 flex-1">
                <span className="flex items-center gap-2 font-bold">
                  {r.name}
                  <ArrowUpRight className="h-4 w-4 text-white/50 transition-transform duration-300 group-hover:translate-x-0.5 group-hover:text-white" aria-hidden />
                </span>
                <span className="mt-0.5 block text-[13px] leading-snug text-white/65">{r.short}</span>
              </span>
            </Link>
          </StaggerItem>
        )
      })}
    </Stagger>
  )
}

export function PrevNext({ entry, direction }: { entry: ModuleEntry; direction: 'prev' | 'next' }) {
  const Icon = moduleIcons[entry.icon]
  const isNext = direction === 'next'
  return (
    <Link
      to={modulePath(entry.slug)}
      className={cn(
        'group flex items-center gap-4 rounded-2xl border border-brand-mist p-4 transition-[border-color,background-color] duration-300 hover:border-brand-purple/30 hover:bg-brand-off-white',
        isNext && 'sm:flex-row-reverse sm:text-right',
      )}
    >
      <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-brand-off-white text-brand-purple transition-colors group-hover:bg-white">
        {isNext ? <ArrowRight className="h-5 w-5" /> : <ArrowLeft className="h-5 w-5" />}
      </span>
      <span className="min-w-0 flex-1">
        <span className="block text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">{isNext ? 'Próximo módulo' : 'Módulo anterior'}</span>
        <span className={cn('mt-0.5 flex items-center gap-2 font-bold text-brand-ink', isNext && 'sm:justify-end')}>
          <Icon className="h-4 w-4 text-brand-purple" strokeWidth={1.6} aria-hidden />
          {entry.name}
        </span>
      </span>
    </Link>
  )
}
