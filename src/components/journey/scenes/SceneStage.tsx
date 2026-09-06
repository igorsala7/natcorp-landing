import { useEffect, useRef, useState, type ReactNode } from 'react'
import { useInView, useReducedMotion, useScroll, useTransform, type MotionValue } from 'motion/react'
import { cn } from '@/lib/utils'

/** Dimensões de desenho do palco. Tudo dentro é posicionado em pixels desse sistema e escalado ao contêiner. */
export const STAGE_W = 960
export const STAGE_H = 540
/** Em telas estreitas o palco mostra só os 640px da esquerda, para as figuras e cards continuarem legíveis. */
const NARROW_W = 640

export interface StageContext {
  reduced: boolean
  /** O palco entrou na tela (dispara a sequência da cena). */
  on: boolean
  /** Deslocamentos de paralaxe ligados à rolagem: fundo, meio e primeiro plano. */
  far: MotionValue<number>
  mid: MotionValue<number>
  near: MotionValue<number>
}

interface SceneStageProps {
  /** Descrição completa da cena para leitores de tela (a arte é decorativa). */
  label: string
  className?: string
  children: (ctx: StageContext) => ReactNode
}

/**
 * Palco de uma cena montada por camadas: cenário em SVG, figura 3D recortada e cards da interface,
 * com paralaxe na rolagem e uma sequência de entrada quando aparece na tela.
 */
export function SceneStage({ label, className, children }: SceneStageProps) {
  const ref = useRef<HTMLElement>(null)
  const [width, setWidth] = useState(STAGE_W)
  const reduced = !!useReducedMotion()
  const on = useInView(ref, { once: true, amount: 0.3 })
  const { scrollYProgress } = useScroll({ target: ref, offset: ['start end', 'end start'] })
  const far = useTransform(scrollYProgress, [0, 1], reduced ? [0, 0] : [22, -22])
  const mid = useTransform(scrollYProgress, [0, 1], reduced ? [0, 0] : [40, -40])
  const near = useTransform(scrollYProgress, [0, 1], reduced ? [0, 0] : [10, -10])

  useEffect(() => {
    const el = ref.current
    if (!el) return
    const ro = new ResizeObserver(([entry]) => setWidth(entry.contentRect.width))
    ro.observe(el)
    return () => ro.disconnect()
  }, [])

  const narrow = width < 600
  const designW = narrow ? NARROW_W : STAGE_W
  const scale = width / designW

  return (
    <figure
      ref={ref}
      role="img"
      aria-label={label}
      className={cn('relative w-full overflow-hidden rounded-3xl border border-brand-mist bg-brand-off-white shadow-soft', className)}
      style={{ aspectRatio: `${designW} / ${STAGE_H}` }}
    >
      <div aria-hidden className="absolute left-0 top-0 origin-top-left" style={{ width: STAGE_W, height: STAGE_H, transform: `scale(${scale})` }}>
        {children({ reduced, on, far, mid, near })}
      </div>
    </figure>
  )
}
