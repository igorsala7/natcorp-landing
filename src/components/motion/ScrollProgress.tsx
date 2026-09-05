import { m, useScroll, useSpring } from 'motion/react'

/** Barra fina no topo indicando o progresso de leitura. */
export function ScrollProgress() {
  const { scrollYProgress } = useScroll()
  const scaleX = useSpring(scrollYProgress, { stiffness: 140, damping: 30, mass: 0.3 })
  return (
    <m.div
      aria-hidden
      className="pointer-events-none fixed inset-x-0 top-0 z-[70] h-[3px] origin-left bg-brand-gradient"
      style={{ scaleX }}
    />
  )
}
