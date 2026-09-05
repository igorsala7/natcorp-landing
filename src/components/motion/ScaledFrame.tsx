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

/** Renderiza um layout de desktop em tamanho fixo e o reduz proporcionalmente para caber no contêiner. */
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
    <div ref={ref} className={cn('relative w-full overflow-hidden', className)} style={{ height: Math.round(height * scale) }}>
      <div style={{ width, height, transform: `scale(${scale})`, transformOrigin: 'top left' }}>{children}</div>
    </div>
  )
}
