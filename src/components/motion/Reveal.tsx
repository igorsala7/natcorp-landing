import { m } from 'motion/react'
import type { HTMLMotionProps, Variants } from 'motion/react'
import { DUR, EASE, fadeUp, staggerContainer, viewportOnce } from '@/lib/motion'

interface RevealProps extends HTMLMotionProps<'div'> {
  delay?: number
  y?: number
  duration?: number
  /** Ativa a animação uma única vez ao entrar na viewport (padrão) */
  once?: boolean
}

/** Bloco que sobe e aparece ao entrar na viewport. */
export function Reveal({ children, delay = 0, y = 24, duration = DUR.slow, once = true, ...rest }: RevealProps) {
  return (
    <m.div
      initial={{ opacity: 0, y }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ ...viewportOnce, once }}
      transition={{ duration, ease: EASE, delay }}
      {...rest}
    >
      {children}
    </m.div>
  )
}

interface StaggerProps extends HTMLMotionProps<'div'> {
  stagger?: number
  delay?: number
}

/** Contêiner que orquestra a entrada escalonada dos filhos `StaggerItem`. */
export function Stagger({ children, stagger = 0.08, delay = 0, ...rest }: StaggerProps) {
  return (
    <m.div
      variants={staggerContainer(stagger, delay)}
      initial="hidden"
      whileInView="visible"
      viewport={viewportOnce}
      {...rest}
    >
      {children}
    </m.div>
  )
}

interface StaggerItemProps extends HTMLMotionProps<'div'> {
  variants?: Variants
}

export function StaggerItem({ children, variants = fadeUp, ...rest }: StaggerItemProps) {
  return (
    <m.div variants={variants} {...rest}>
      {children}
    </m.div>
  )
}
