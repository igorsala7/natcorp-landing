import { Link } from 'react-router'
import { ArrowRight, Layers } from 'lucide-react'
import { Reveal } from '@/components/motion/Reveal'
import { moduleIcons } from '@/content/modulePages/icons'
import { getModuleEntry, modulePath } from '@/content/modulePages'
import { volume } from '@/content/hiringJourney'
import { cn } from '@/lib/utils'

interface VolumeAsideProps {
  /** Versão curta, para a visão prática (diagrama). */
  compact?: boolean
  className?: string
  /** Diferencia os ids entre as árvores desktop e mobile, que coexistem no DOM. */
  idSuffix?: string
}

/** Logo depois da efetivação: a mesma admissão, em série, quando a safra pede centenas de uma vez. */
export function VolumeAside({ compact = false, className, idSuffix = '' }: VolumeAsideProps) {
  const titleId = `volume${idSuffix}-title`
  const mods = volume.modules.map((slug) => ({ slug, entry: getModuleEntry(slug) })).filter((mod) => mod.entry)
  const chip =
    'inline-flex items-center gap-1.5 rounded-lg border bg-white px-2.5 py-1.5 text-[12.5px] font-semibold leading-none transition-colors duration-300'

  return (
    <Reveal delay={0.1} className={className}>
      <div role="note" aria-labelledby={titleId} className={cn('rounded-2xl border border-brand-mist bg-brand-off-white', compact ? 'p-4' : 'p-5 sm:p-6')}>
        <div className={cn('flex gap-4', compact ? 'items-start' : 'flex-col sm:flex-row sm:items-start')}>
          <span className={cn('flex shrink-0 items-center justify-center rounded-xl bg-white text-brand-purple shadow-soft', compact ? 'h-9 w-9' : 'h-11 w-11')}>
            <Layers className={compact ? 'h-4 w-4' : 'h-5 w-5'} strokeWidth={1.7} aria-hidden />
          </span>
          <div className="min-w-0 flex-1">
            <p className="text-[11px] font-bold uppercase tracking-[0.14em] text-brand-purple">Admissão em volume</p>
            <h4 id={titleId} className={cn('mt-1 font-extrabold leading-tight text-brand-ink', compact ? 'text-[15px]' : 'text-xl')}>
              {volume.title}
            </h4>
            <p className={cn('mt-2 leading-relaxed text-brand-graphite', compact ? 'text-[13px]' : 'text-[15px]')}>{volume.text}</p>
            <ul className="mt-3 flex flex-wrap gap-2" aria-label="Saiba mais">
              {mods.map(({ slug, entry }) => {
                const Icon = moduleIcons[entry!.icon]
                return (
                  <li key={slug}>
                    <Link to={modulePath(slug)} className={cn(chip, 'border-brand-mist text-brand-ink hover:border-brand-purple/40 hover:text-brand-purple')}>
                      <Icon className="h-3.5 w-3.5 text-brand-purple" strokeWidth={1.8} aria-hidden />
                      {entry!.name}
                    </Link>
                  </li>
                )
              })}
              <li>
                <Link to={volume.more.to} className={cn(chip, 'border-brand-purple/30 text-brand-purple hover:bg-brand-purple/5')}>
                  {volume.more.label}
                  <ArrowRight className="h-3.5 w-3.5" aria-hidden />
                </Link>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </Reveal>
  )
}
