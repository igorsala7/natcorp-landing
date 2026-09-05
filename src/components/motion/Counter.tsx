import { useEffect, useRef } from 'react'
import { animate, useInView, useReducedMotion } from 'motion/react'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

interface CounterProps {
  value: number
  prefix?: string
  suffix?: string
  decimals?: number
  duration?: number
  className?: string
}

const format = (n: number, decimals: number) =>
  n.toLocaleString('pt-BR', { minimumFractionDigits: decimals, maximumFractionDigits: decimals })

/** Número que conta de 0 até `value` ao entrar na viewport (escreve direto no DOM, sem re-render por frame). */
export function Counter({ value, prefix = '', suffix = '', decimals = 0, duration = 1.6, className }: CounterProps) {
  const ref = useRef<HTMLSpanElement>(null)
  const numRef = useRef<HTMLSpanElement>(null)
  const inView = useInView(ref, { once: true, margin: '0px 0px -10% 0px' })
  const reduced = useReducedMotion()

  useEffect(() => {
    const el = numRef.current
    if (!inView || !el || reduced) return
    const controls = animate(0, value, {
      duration,
      ease: EASE,
      onUpdate: (v) => {
        el.textContent = format(v, decimals)
      },
    })
    return () => controls.stop()
  }, [inView, value, duration, decimals, reduced])

  return (
    <span ref={ref} className={cn('tabular', className)}>
      {prefix}
      <span ref={numRef}>{format(reduced ? value : 0, decimals)}</span>
      {suffix}
    </span>
  )
}
