import { useReducedMotion } from 'motion/react'
import { Marquee } from '@/components/motion/Marquee'
import { moduleRegistry, type ModuleEntry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import { cn } from '@/lib/utils'
import { BaseLabel, ModuleCore } from './ModuleCore'

/**
 * O palco em telas estreitas: a base no alto e os módulos correndo em duas faixas
 * logo abaixo dela. Decorativo; os cartões das frentes trazem os links.
 */

const half = Math.ceil(moduleRegistry.length / 2)
const rows = [moduleRegistry.slice(0, half), moduleRegistry.slice(half)]

function Chip({ mod }: { mod: ModuleEntry }) {
  const Icon = moduleIcons[mod.icon]
  return (
    <span className="inline-flex h-9 shrink-0 items-center gap-2 whitespace-nowrap rounded-lg border border-brand-mist bg-white px-2.5 text-[12.5px] font-semibold leading-none text-brand-ink shadow-[0_1px_2px_rgba(27,18,56,0.04)]">
      <Icon className="h-3.5 w-3.5 shrink-0 text-brand-purple" strokeWidth={1.8} aria-hidden />
      {mod.name}
    </span>
  )
}

export function ModuleFieldCompact({ className }: { className?: string }) {
  const reduced = useReducedMotion() ?? false
  return (
    <div aria-hidden className={cn('relative overflow-hidden rounded-3xl border border-brand-mist bg-white pb-6 pt-7 shadow-soft', className)}>
      <div className="pointer-events-none absolute inset-0 bg-grid-45 opacity-80 [background-size:24px_24px] [mask-image:radial-gradient(80%_70%_at_50%_35%,#000_20%,transparent_100%)]" />
      <div className="pointer-events-none absolute left-1/2 top-[110px] h-[360px] w-[360px] -translate-x-1/2 -translate-y-1/2 rounded-full bg-[radial-gradient(circle,rgba(154,64,138,0.16),transparent_62%)] blur-2xl" />

      <div className="relative flex flex-col items-center">
        <ModuleCore size={188} reduced={reduced} />
        <BaseLabel className="-mt-1" />
        {/* a base alimenta as faixas: um fio tracejado desce até elas */}
        <span className="mt-3 h-6 w-px bg-[linear-gradient(180deg,rgba(81,28,118,0.45),rgba(81,28,118,0))]" />
      </div>

      <div
        className="relative mt-1 space-y-2.5"
        style={reduced ? undefined : { maskImage: 'linear-gradient(90deg, transparent, #000 14%, #000 86%, transparent)', WebkitMaskImage: 'linear-gradient(90deg, transparent, #000 14%, #000 86%, transparent)' }}
      >
        {rows.map((row, i) => (
          <Marquee key={i} speed={58 + i * 12} reverse={i === 1} pauseOnHover={false} className={reduced ? 'gap-x-2 gap-y-2 px-5' : undefined} itemClassName="gap-x-2.5 pr-2.5">
            {row.map((mod) => (
              <Chip key={mod.slug} mod={mod} />
            ))}
          </Marquee>
        ))}
      </div>
    </div>
  )
}
