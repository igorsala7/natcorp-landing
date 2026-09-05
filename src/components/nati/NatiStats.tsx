import { Counter } from '@/components/motion/Counter'
import { Stagger, StaggerItem } from '@/components/motion/Reveal'
import { natiStats } from '@/content/nati'
import { cn } from '@/lib/utils'

/** Os números da NATI em contadores. */
export function NatiStats({ tone = 'dark', className }: { tone?: 'dark' | 'light'; className?: string }) {
  const dark = tone === 'dark'
  return (
    <Stagger className={cn('grid grid-cols-2 gap-x-6 gap-y-8 lg:grid-cols-4', className)} stagger={0.08}>
      {natiStats.map((s) => (
        <StaggerItem key={s.label} className={cn('border-l-2 pl-4', dark ? 'border-[#E4A9C4]/60' : 'border-brand-pink')}>
          <p className={cn('text-3xl font-extrabold tracking-brand sm:text-4xl', dark ? 'text-white' : 'text-brand-purple')}>
            <Counter value={s.value} prefix={s.prefix} suffix={s.suffix} />
          </p>
          <p className={cn('mt-1.5 text-[13.5px] leading-snug', dark ? 'text-white/65' : 'text-brand-graphite')}>{s.label}</p>
        </StaggerItem>
      ))}
    </Stagger>
  )
}
