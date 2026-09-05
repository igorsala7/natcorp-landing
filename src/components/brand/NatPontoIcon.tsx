import type { SVGProps } from 'react'
import { cn } from '@/lib/utils'
import { useBrandGradientId } from '@/hooks/useBrandGradientId'

/** Ícone do app NatPonto: losango em degradê rosa com um relógio. */
export function NatPontoIcon({ className, ...rest }: SVGProps<SVGSVGElement>) {
  const id = useBrandGradientId()
  const ticks = Array.from({ length: 12 }, (_, i) => {
    const a = (i * Math.PI) / 6
    const r1 = 22
    const r2 = i % 3 === 0 ? 17 : 19
    return [60 + r1 * Math.sin(a), 60 - r1 * Math.cos(a), 60 + r2 * Math.sin(a), 60 - r2 * Math.cos(a)]
  })
  return (
    <svg viewBox="0 0 120 120" className={cn('block', className)} aria-hidden focusable="false" {...rest}>
      <defs>
        <linearGradient id={id} x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#EC9DBF" />
          <stop offset="1" stopColor="#B24A8C" />
        </linearGradient>
      </defs>
      <rect x="24" y="24" width="72" height="72" rx="14" fill={`url(#${id})`} transform="rotate(45 60 60)" />
      {ticks.map(([x1, y1, x2, y2], i) => (
        <line key={i} x1={x1} y1={y1} x2={x2} y2={y2} stroke="#fff" strokeWidth={i % 3 === 0 ? 2.4 : 1.6} strokeLinecap="round" opacity={0.95} />
      ))}
      <path d="M60 60 V44" stroke="#fff" strokeWidth="3.2" strokeLinecap="round" />
      <path d="M60 60 H73" stroke="#fff" strokeWidth="3.2" strokeLinecap="round" />
      <circle cx="60" cy="60" r="2.4" fill="#fff" />
    </svg>
  )
}
