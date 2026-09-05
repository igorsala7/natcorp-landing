import type { Transition, Variants } from 'motion/react'

/** Curva da marca: saída rápida e assentamento suave (easeOutQuint aproximado). */
export const EASE = [0.22, 1, 0.36, 1] as const
/** Para transições de cena (entrada e saída simétricas). */
export const EASE_IN_OUT = [0.65, 0, 0.35, 1] as const

export const DUR = { fast: 0.18, base: 0.32, slow: 0.7, scene: 0.9 } as const

export const spring = { type: 'spring', stiffness: 260, damping: 26, mass: 0.8 } satisfies Transition

export const fadeUp: Variants = {
  hidden: { opacity: 0, y: 24 },
  visible: { opacity: 1, y: 0, transition: { duration: DUR.slow, ease: EASE } },
}

export const fadeIn: Variants = {
  hidden: { opacity: 0 },
  visible: { opacity: 1, transition: { duration: DUR.slow, ease: EASE } },
}

export const scaleIn: Variants = {
  hidden: { opacity: 0, scale: 0.96, y: 16 },
  visible: { opacity: 1, scale: 1, y: 0, transition: { duration: DUR.scene, ease: EASE } },
}

export const staggerContainer = (stagger = 0.08, delay = 0): Variants => ({
  hidden: {},
  visible: { transition: { staggerChildren: stagger, delayChildren: delay } },
})

export const viewportOnce = { once: true, margin: '0px 0px -12% 0px' } as const
