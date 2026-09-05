import { useRef } from 'react'
import type { PointerEvent, ReactNode } from 'react'
import { m, useMotionValue, useReducedMotion, useSpring } from 'motion/react'
import { cn } from '@/lib/utils'
import { useIsFinePointer } from '@/hooks/useMediaQuery'

interface MagneticProps {
  children: ReactNode
  strength?: number
  className?: string
}

/** Atrai levemente o conteúdo em direção ao cursor (somente mouse/trackpad). */
export function Magnetic({ children, strength = 0.22, className }: MagneticProps) {
  const ref = useRef<HTMLDivElement>(null)
  const x = useMotionValue(0)
  const y = useMotionValue(0)
  const sx = useSpring(x, { stiffness: 220, damping: 18, mass: 0.35 })
  const sy = useSpring(y, { stiffness: 220, damping: 18, mass: 0.35 })
  const fine = useIsFinePointer()
  const reduced = useReducedMotion()
  const enabled = fine && !reduced

  function onMove(e: PointerEvent<HTMLDivElement>) {
    if (!enabled || !ref.current) return
    const r = ref.current.getBoundingClientRect()
    x.set((e.clientX - (r.left + r.width / 2)) * strength)
    y.set((e.clientY - (r.top + r.height / 2)) * strength)
  }
  function onLeave() {
    x.set(0)
    y.set(0)
  }

  return (
    <m.div
      ref={ref}
      onPointerMove={onMove}
      onPointerLeave={onLeave}
      style={{ x: sx, y: sy }}
      className={cn('inline-block', className)}
    >
      {children}
    </m.div>
  )
}
