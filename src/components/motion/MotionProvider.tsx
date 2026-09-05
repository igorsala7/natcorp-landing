import { LazyMotion, MotionConfig, domAnimation } from 'motion/react'
import type { ReactNode } from 'react'

/**
 * Carrega apenas o subconjunto de recursos de animação usado no site (menor bundle)
 * e respeita `prefers-reduced-motion` do usuário em todas as animações de transform.
 */
export function MotionProvider({ children }: { children: ReactNode }) {
  return (
    <LazyMotion features={domAnimation}>
      <MotionConfig reducedMotion="user">{children}</MotionConfig>
    </LazyMotion>
  )
}
