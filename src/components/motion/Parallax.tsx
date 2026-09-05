import { useRef } from 'react'
import type { ReactNode } from 'react'
import { m, useReducedMotion, useScroll, useTransform } from 'motion/react'

interface ParallaxProps {
  children: ReactNode
  /** Deslocamento total em px (positivo = mais lento que a página). */
  distance?: number
  className?: string
}

/** Desloca o conteúdo em velocidade diferente da rolagem, criando profundidade. */
export function Parallax({ children, distance = 60, className }: ParallaxProps) {
  const ref = useRef<HTMLDivElement>(null)
  const reduced = useReducedMotion()
  const { scrollYProgress } = useScroll({ target: ref, offset: ['start end', 'end start'] })
  const y = useTransform(scrollYProgress, [0, 1], [distance, -distance])
  return (
    <m.div ref={ref} style={{ y: reduced ? 0 : y }} className={className}>
      {children}
    </m.div>
  )
}
