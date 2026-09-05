import type { ReactNode } from 'react'
import { useReducedMotion } from 'motion/react'
import { cn } from '@/lib/utils'

interface MarqueeProps {
  children: ReactNode
  /** Duração de uma volta completa, em segundos. */
  speed?: number
  reverse?: boolean
  pauseOnHover?: boolean
  className?: string
  itemClassName?: string
}

/** Faixa contínua. Com movimento reduzido, vira uma lista estática que quebra linha. */
export function Marquee({ children, speed = 60, reverse = false, pauseOnHover = true, className, itemClassName }: MarqueeProps) {
  const reduced = useReducedMotion()

  if (reduced) {
    return <div className={cn('flex flex-wrap justify-center gap-x-8 gap-y-3', className)}>{children}</div>
  }

  return (
    <div className={cn('mask-fade-x overflow-hidden', pauseOnHover && 'pause-on-hover', className)}>
      <div
        className="flex w-max animate-marquee"
        style={{ animationDuration: `${speed}s`, animationDirection: reverse ? 'reverse' : 'normal' }}
      >
        <div className={cn('flex shrink-0 items-center gap-x-8 pr-8', itemClassName)}>{children}</div>
        <div className={cn('flex shrink-0 items-center gap-x-8 pr-8', itemClassName)} aria-hidden>
          {children}
        </div>
      </div>
    </div>
  )
}
