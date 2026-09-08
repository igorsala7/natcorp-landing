import { useEffect, useRef, useState } from 'react'
import type { ReactNode } from 'react'
import { cn } from '@/lib/utils'

interface ScaledFrameProps {
  /** Largura e altura de desenho do conteúdo (px). */
  width: number
  height: number
  children: ReactNode
  className?: string
}

/**
 * Renderiza um layout em tamanho fixo e o reduz proporcionalmente para caber no contêiner.
 * O conteúdo é posicionado de forma absoluta para não influenciar a largura do layout (grids e flex).
 */
export function ScaledFrame({ width, height, children, className }: ScaledFrameProps) {
  const ref = useRef<HTMLDivElement>(null)
  const [scale, setScale] = useState(1)

  useEffect(() => {
    const el = ref.current
    if (!el) return
    const ro = new ResizeObserver(([entry]) => {
      setScale(Math.min(1, entry.contentRect.width / width))
    })
    ro.observe(el)
    return () => ro.disconnect()
  }, [width])

  return (
    <div ref={ref} className={cn('relative w-full min-w-0 overflow-hidden', className)} style={{ height: Math.round(height * scale) }}>
      <div className="absolute left-0 top-0" style={{ width, height, transform: `scale(${scale})`, transformOrigin: 'top left' }}>
        {children}
      </div>
    </div>
  )
}

/**
 * Reduz um layout de largura fixa para caber no contêiner, medindo a altura real do conteúdo.
 * Útil para mockups fluidos (como o Painel do Operador) cuja altura muda com o breakpoint.
 */
export function FitFrame({ width, children, className }: { width: number; children: ReactNode; className?: string }) {
  const outer = useRef<HTMLDivElement>(null)
  const inner = useRef<HTMLDivElement>(null)
  const [scale, setScale] = useState(1)
  const [height, setHeight] = useState(0)

  useEffect(() => {
    const box = outer.current
    const content = inner.current
    if (!box || !content) return
    const ro = new ResizeObserver(() => {
      setScale(Math.min(1, box.clientWidth / width))
      setHeight(content.offsetHeight)
    })
    ro.observe(box)
    ro.observe(content)
    return () => ro.disconnect()
  }, [width])

  return (
    <div ref={outer} className={cn('relative w-full min-w-0 overflow-hidden', className)} style={{ height: Math.round(height * scale) }}>
      <div ref={inner} className="absolute left-0 top-0" style={{ width, transform: `scale(${scale})`, transformOrigin: 'top left' }}>
        {children}
      </div>
    </div>
  )
}
