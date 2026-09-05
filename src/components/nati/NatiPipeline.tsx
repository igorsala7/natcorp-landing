import { m, useReducedMotion } from 'motion/react'
import { Stagger, StaggerItem } from '@/components/motion/Reveal'
import { pipeline } from '@/content/nati'
import { cn } from '@/lib/utils'

/** Como uma resposta nasce: seis passos ligados por um trilho com um pulso percorrendo. */
export function NatiPipeline({ tone = 'dark', className }: { tone?: 'dark' | 'light'; className?: string }) {
  const dark = tone === 'dark'
  const reduced = useReducedMotion()
  return (
    <div className={cn('relative', className)}>
      <div className={cn('absolute left-0 right-0 top-[22px] hidden h-px lg:block', dark ? 'bg-white/15' : 'bg-brand-mist')} aria-hidden>
        {!reduced && (
          <m.span
            className="absolute -top-[3px] h-[7px] w-24 rounded-full bg-gradient-to-r from-transparent via-[#E4A9C4] to-transparent"
            animate={{ left: ['-6rem', '100%'] }}
            transition={{ duration: 4.5, repeat: Infinity, ease: 'linear' }}
          />
        )}
      </div>
      <Stagger className="grid grid-cols-2 gap-6 sm:grid-cols-3 lg:grid-cols-6" stagger={0.08}>
        {pipeline.map((s, i) => (
          <StaggerItem key={s.title} className="relative">
            <span
              className={cn(
                'relative z-10 flex h-11 w-11 items-center justify-center rounded-full border text-[12px] font-extrabold',
                dark ? 'border-[#E4A9C4]/50 bg-brand-blue text-white' : 'border-brand-purple/30 bg-white text-brand-purple',
              )}
            >
              {String(i + 1).padStart(2, '0')}
            </span>
            <p className={cn('mt-4 text-[15px] font-extrabold', dark ? 'text-white' : 'text-brand-ink')}>{s.title}</p>
            <p className={cn('mt-1 text-[13px] leading-snug', dark ? 'text-white/65' : 'text-brand-graphite')}>{s.text}</p>
          </StaggerItem>
        ))}
      </Stagger>
    </div>
  )
}
