import { useEffect, useState } from 'react'
import { AnimatePresence, m, useReducedMotion } from 'motion/react'
import { ArrowRight, Sparkles } from 'lucide-react'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { TypedText } from '@/components/motion/TypedText'
import { insights, type Insight } from '@/content/nati'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

/**
 * A NATI analisando em tempo real: um insight por vez, digitado, com os módulos
 * envolvidos, um gráfico pequeno e a ação sugerida. Troca sozinha e obedece ao toque.
 */
export function InsightStream({ className, interval = 7000 }: { className?: string; interval?: number }) {
  const reduced = useReducedMotion()
  const [i, setI] = useState(0)
  const [paused, setPaused] = useState(false)
  const current = insights[i]

  useEffect(() => {
    if (paused || reduced) return
    const t = window.setInterval(() => setI((v) => (v + 1) % insights.length), interval)
    return () => window.clearInterval(t)
  }, [paused, reduced, interval])

  return (
    <div className={cn('flex flex-col overflow-hidden rounded-3xl border border-white/12 bg-brand-blue/70 text-white shadow-glow backdrop-blur-sm', className)}>
      <div className="flex items-center justify-between gap-3 border-b border-white/10 px-4 py-3 sm:px-5">
        <span className="flex items-center gap-2.5">
          <NatiAvatar ring className="h-8 w-8" />
          <span className="text-[13px] font-bold">NATI · análise contínua</span>
        </span>
        <span className="flex items-center gap-2 text-[11px] font-semibold uppercase tracking-[0.12em] text-white/60">
          <span className="relative flex h-2 w-2">
            <span className="absolute inline-flex h-full w-full animate-ping rounded-full bg-emerald-400 opacity-60" />
            <span className="relative inline-flex h-2 w-2 rounded-full bg-emerald-400" />
          </span>
          31 módulos lidos
        </span>
      </div>

      <div className="relative min-h-[300px] flex-1 px-4 py-4 sm:min-h-[320px] sm:px-5">
        <AnimatePresence mode="wait" initial={false}>
          <m.div key={current.id} initial={{ opacity: 0, y: 12 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -8 }} transition={{ duration: 0.4, ease: EASE }} aria-live="polite">
            <ul className="flex flex-wrap gap-1.5" aria-label="Módulos cruzados nesta análise">
              {current.modules.map((mo) => (
                <li key={mo} className="rounded-md border border-[#E4A9C4]/35 bg-[#E4A9C4]/10 px-2 py-0.5 text-[11px] font-semibold text-[#F3C9DA]">
                  {mo}
                </li>
              ))}
            </ul>
            <p className="mt-3 text-[15px] leading-relaxed text-white/90 sm:text-[15.5px]">
              <TypedText key={current.id} text={current.text} speed={12} delay={150} />
            </p>
            <MiniChart insight={current} />
            <div className="mt-3 flex flex-wrap items-center justify-between gap-2">
              <span className="flex items-center gap-1.5 text-[11.5px] text-white/55">
                <Sparkles className="h-3.5 w-3.5 text-[#E4A9C4]" aria-hidden />
                análise · diagnóstico · atenção · sugestão
              </span>
              <span className="inline-flex items-center gap-1.5 rounded-lg bg-white px-3 py-1.5 text-[12px] font-bold text-brand-purple">
                {current.action}
                <ArrowRight className="h-3.5 w-3.5" aria-hidden />
              </span>
            </div>
          </m.div>
        </AnimatePresence>
      </div>

      <div className="flex items-center justify-between gap-3 border-t border-white/10 px-4 py-3 sm:px-5">
        <div role="tablist" aria-label="Análises de exemplo" className="flex items-center gap-1.5">
          {insights.map((ins, k) => (
            <button
              key={ins.id}
              type="button"
              role="tab"
              aria-selected={k === i}
              aria-label={`Análise ${k + 1}`}
              onClick={() => {
                setPaused(true)
                setI(k)
              }}
              className={cn('h-1.5 rounded-full transition-all duration-500', k === i ? 'w-7 bg-[#E4A9C4]' : 'w-2.5 bg-white/25 hover:bg-white/50')}
            />
          ))}
        </div>
        <span className="text-[11px] text-white/45">cenário ilustrativo</span>
      </div>
    </div>
  )
}

function MiniChart({ insight }: { insight: Insight }) {
  const { values, labels = [], unit, kind } = insight.chart
  const max = Math.max(...values)
  const min = Math.min(...values)
  const W = 320
  const H = 74
  if (kind === 'line') {
    const pts = values.map((v, k) => {
      const x = 10 + (k * (W - 20)) / (values.length - 1)
      const y = 8 + ((max - v) / (max - min || 1)) * (H - 30)
      return `${x},${y}`
    })
    return (
      <figure className="mt-3">
        <svg viewBox={`0 0 ${W} ${H}`} className="h-auto w-full" role="img" aria-label={`Evolução: ${values.map((v, k) => `${labels[k] ?? ''} ${v}${unit ?? ''}`).join(', ')}`}>
          <polyline points={pts.join(' ')} fill="none" stroke="#E4A9C4" strokeWidth="2.5" strokeLinejoin="round" strokeLinecap="round" />
          {pts.map((p, k) => {
            const [x, y] = p.split(',').map(Number)
            return <circle key={k} cx={x} cy={y} r={k === pts.length - 1 ? 4.5 : 2.5} fill={k === pts.length - 1 ? '#FFFFFF' : '#E4A9C4'} />
          })}
          {labels.map((l, k) => (
            <text key={l} x={10 + (k * (W - 20)) / (values.length - 1)} y={H - 4} textAnchor="middle" fontSize="9" fill="#FFFFFF" fillOpacity="0.55" fontFamily="Manrope, system-ui, sans-serif">
              {l}
            </text>
          ))}
        </svg>
      </figure>
    )
  }
  const bw = (W - 10 * (values.length + 1)) / values.length
  return (
    <figure className="mt-3">
      <svg viewBox={`0 0 ${W} ${H}`} className="h-auto w-full" role="img" aria-label={`${values.map((v, k) => `${labels[k] ?? ''} ${v}${unit ?? ''}`).join(', ')}`}>
        {values.map((v, k) => {
          const h = Math.max(4, (v / max) * (H - 26))
          const x = 10 + k * (bw + 10)
          const last = k === values.length - 1
          return (
            <g key={k}>
              <rect x={x} y={H - 16 - h} width={bw} height={h} rx="3" fill={last ? '#E4A9C4' : '#FFFFFF'} fillOpacity={last ? 1 : 0.28} />
              <text x={x + bw / 2} y={H - 4} textAnchor="middle" fontSize="9" fill="#FFFFFF" fillOpacity="0.55" fontFamily="Manrope, system-ui, sans-serif">
                {labels[k] ?? ''}
              </text>
            </g>
          )
        })}
      </svg>
    </figure>
  )
}
