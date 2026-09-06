import { useEffect, useRef } from 'react'
import { useReducedMotion } from 'motion/react'
import { cn } from '@/lib/utils'

/** Teto de pixels do canvas: fundos altos (seções inteiras) são desenhados em resolução menor e esticados. */
const MAX_PIXELS = 800_000
/** O campo anda a 24 quadros por segundo: é fundo, os pontos andam devagar, e cada quadro custa um envio ao compositor. */
const FRAME_MS = 1000 / 24

/**
 * Campo de pontos ligados por linhas finas, à deriva: o fundo "rede neural" das seções da NATI.
 * Canvas leve: resolução limitada, 30 qps, para de verdade fora da tela e com a aba escondida,
 * e vira um quadro parado com prefers-reduced-motion.
 */
export function NetworkField({ className, density = 1 }: { className?: string; density?: number }) {
  const ref = useRef<HTMLCanvasElement>(null)
  const reduced = useReducedMotion()

  useEffect(() => {
    const canvas = ref.current
    if (!canvas) return
    const ctx = canvas.getContext('2d')
    if (!ctx) return
    let raf = 0
    let running = true
    let visible = false
    let last = 0
    let w = 0
    let h = 0
    type Node = { x: number; y: number; vx: number; vy: number; r: number }
    let nodes: Node[] = []

    const seed = () => {
      const count = Math.round(((w * h) / 26000) * density)
      nodes = Array.from({ length: Math.min(90, Math.max(18, count)) }, () => ({
        x: Math.random() * w,
        y: Math.random() * h,
        // velocidade em px por segundo (o passo é corrigido pelo tempo entre quadros)
        vx: (Math.random() - 0.5) * 15,
        vy: (Math.random() - 0.5) * 15,
        r: 1 + Math.random() * 1.6,
      }))
    }

    const resize = () => {
      const rect = canvas.getBoundingClientRect()
      w = Math.max(1, rect.width)
      h = Math.max(1, rect.height)
      const dpr = Math.min(1.5, window.devicePixelRatio || 1)
      const scale = Math.min(dpr, Math.sqrt(MAX_PIXELS / (w * h)))
      canvas.width = Math.max(1, Math.round(w * scale))
      canvas.height = Math.max(1, Math.round(h * scale))
      ctx.setTransform(scale, 0, 0, scale, 0, 0)
      seed()
      draw()
    }

    const draw = () => {
      ctx.clearRect(0, 0, w, h)
      const link = 130
      ctx.lineWidth = 1
      for (let i = 0; i < nodes.length; i++) {
        const a = nodes[i]
        for (let j = i + 1; j < nodes.length; j++) {
          const b = nodes[j]
          const dx = a.x - b.x
          const dy = a.y - b.y
          if (Math.abs(dx) > link || Math.abs(dy) > link) continue
          const d = Math.hypot(dx, dy)
          if (d < link) {
            ctx.strokeStyle = `rgba(228,169,196,${(1 - d / link) * 0.28})`
            ctx.beginPath()
            ctx.moveTo(a.x, a.y)
            ctx.lineTo(b.x, b.y)
            ctx.stroke()
          }
        }
      }
      ctx.fillStyle = 'rgba(228,169,196,0.75)'
      for (const n of nodes) {
        ctx.beginPath()
        ctx.arc(n.x, n.y, n.r, 0, Math.PI * 2)
        ctx.fill()
      }
    }

    const step = (dt: number) => {
      const k = dt / 1000
      for (const n of nodes) {
        n.x += n.vx * k
        n.y += n.vy * k
        if (n.x < -10) n.x = w + 10
        if (n.x > w + 10) n.x = -10
        if (n.y < -10) n.y = h + 10
        if (n.y > h + 10) n.y = -10
      }
    }

    const tick = (t: number) => {
      raf = 0
      if (!running || !visible || document.hidden) return
      raf = window.requestAnimationFrame(tick)
      if (t - last < FRAME_MS - 1) return
      const dt = Math.min(80, last ? t - last : FRAME_MS)
      last = t
      step(dt)
      draw()
    }

    const start = () => {
      if (raf || !running || reduced || !visible || document.hidden) return
      last = 0
      raf = window.requestAnimationFrame(tick)
    }

    const ro = new ResizeObserver(resize)
    ro.observe(canvas)
    const io = new IntersectionObserver(
      (entries) => {
        visible = entries.some((e) => e.isIntersecting)
        if (visible) start()
      },
      { rootMargin: '120px 0px' },
    )
    io.observe(canvas)
    document.addEventListener('visibilitychange', start)
    resize()

    return () => {
      running = false
      if (raf) window.cancelAnimationFrame(raf)
      ro.disconnect()
      io.disconnect()
      document.removeEventListener('visibilitychange', start)
    }
  }, [reduced, density])

  return <canvas ref={ref} className={cn('pointer-events-none absolute inset-0 h-full w-full', className)} aria-hidden />
}
