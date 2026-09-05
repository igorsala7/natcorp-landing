import { useRef } from 'react'
import type { HTMLAttributes, PointerEvent } from 'react'
import { m, useMotionTemplate, useMotionValue } from 'motion/react'
import { cn } from '@/lib/utils'

interface SpotlightCardProps extends HTMLAttributes<HTMLDivElement> {
  /** Cor do foco de luz que segue o cursor. */
  color?: string
  size?: number
}

/** Cartão com um foco de luz suave que acompanha o cursor (hover). */
export function SpotlightCard({
  children,
  className,
  color = 'rgba(201, 87, 136, 0.16)',
  size = 380,
  ...rest
}: SpotlightCardProps) {
  const ref = useRef<HTMLDivElement>(null)
  const mx = useMotionValue(-9999)
  const my = useMotionValue(-9999)
  const background = useMotionTemplate`radial-gradient(${size}px circle at ${mx}px ${my}px, ${color}, transparent 65%)`

  function onMove(e: PointerEvent<HTMLDivElement>) {
    if (!ref.current) return
    const r = ref.current.getBoundingClientRect()
    mx.set(e.clientX - r.left)
    my.set(e.clientY - r.top)
  }
  function onLeave() {
    mx.set(-9999)
    my.set(-9999)
  }

  return (
    <div
      ref={ref}
      onPointerMove={onMove}
      onPointerLeave={onLeave}
      className={cn('group/spot relative overflow-hidden', className)}
      {...rest}
    >
      <m.div
        aria-hidden
        className="pointer-events-none absolute inset-0 opacity-0 transition-opacity duration-500 group-hover/spot:opacity-100"
        style={{ background }}
      />
      <div className="relative h-full">{children}</div>
    </div>
  )
}
