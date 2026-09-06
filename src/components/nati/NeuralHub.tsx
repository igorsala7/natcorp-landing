import { useReducedMotion } from 'motion/react'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { groups, modulesByGroup } from '@/content/modulePages'
import { cn } from '@/lib/utils'

/**
 * A NATI no centro do sistema: os módulos no anel de fora, as sete frentes no anel
 * de dentro e o dado fluindo de todos eles para ela. Os pulsos são animações SMIL do
 * próprio SVG (leves) e são desligados com prefers-reduced-motion.
 */

const SIZE = 800
const C = SIZE / 2
const R_FRONT = 205
const R_MODULE = 335
const R_LABEL = 268

const polar = (r: number, deg: number) => {
  const a = ((deg - 90) * Math.PI) / 180
  return { x: C + r * Math.cos(a), y: C + r * Math.sin(a) }
}

interface NeuralHubProps {
  className?: string
  /** Mostra os nomes das frentes ao redor do anel de dentro. */
  labels?: boolean
}

export function NeuralHub({ className, labels = true }: NeuralHubProps) {
  const reduced = useReducedMotion()
  const step = 360 / groups.length

  const fronts = groups.map((g, i) => {
    const deg = i * step
    const mods = modulesByGroup(g.id)
    const span = step * 0.78
    const start = deg - span / 2
    const modules = mods.map((mo, j) => {
      const d = mods.length === 1 ? deg : start + (span * j) / (mods.length - 1)
      return { ...mo, pos: polar(R_MODULE, d) }
    })
    return { ...g, deg, pos: polar(R_FRONT, deg), label: polar(R_LABEL, deg), modules }
  })

  // índice global de cada módulo, para escalonar os pulsos de forma determinística
  const offsets = fronts.map((_, fi) => fronts.slice(0, fi).reduce((n, f) => n + f.modules.length, 0))

  return (
    <div
      className={cn('relative', className)}
      role="img"
      aria-label="A NATI no centro, ligada às sete frentes do RH e a todos os módulos do sistema, com os dados fluindo de todos eles para ela"
    >
      <svg viewBox={`0 0 ${SIZE} ${SIZE}`} className="block h-auto w-full overflow-visible" aria-hidden focusable="false">
        <defs>
          <radialGradient id="nh-core" cx="0.5" cy="0.5" r="0.5">
            <stop offset="0" stopColor="#C95788" stopOpacity="0.85" />
            <stop offset="0.55" stopColor="#9A408A" stopOpacity="0.35" />
            <stop offset="1" stopColor="#511C76" stopOpacity="0" />
          </radialGradient>
          <radialGradient id="nh-node" cx="0.35" cy="0.3" r="0.8">
            <stop offset="0" stopColor="#B27BE0" />
            <stop offset="1" stopColor="#511C76" />
          </radialGradient>
          <filter id="nh-glow" x="-50%" y="-50%" width="200%" height="200%">
            <feGaussianBlur stdDeviation="4" />
          </filter>
        </defs>

        {/* anéis */}
        <circle cx={C} cy={C} r={R_MODULE} fill="none" stroke="#FFFFFF" strokeOpacity="0.09" strokeWidth="1" />
        <circle cx={C} cy={C} r={R_FRONT} fill="none" stroke="#FFFFFF" strokeOpacity="0.12" strokeWidth="1" strokeDasharray="3 7" />
        <g>
          <circle cx={C} cy={C} r={R_MODULE + 30} fill="none" stroke="#E4A9C4" strokeOpacity="0.25" strokeWidth="1" strokeDasharray="1 14" strokeLinecap="round">
            {!reduced && <animateTransform attributeName="transform" type="rotate" from={`0 ${C} ${C}`} to={`360 ${C} ${C}`} dur="90s" repeatCount="indefinite" />}
          </circle>
        </g>

        {/* núcleo: brilho e ondas */}
        <circle cx={C} cy={C} r={150} fill="url(#nh-core)" />
        {!reduced &&
          [0, 1.2].map((delay) => (
            <circle key={delay} cx={C} cy={C} r={70} fill="none" stroke="#E4A9C4" strokeWidth="1.5">
              <animate attributeName="r" from="70" to="190" dur="2.6s" begin={`${delay}s`} repeatCount="indefinite" />
              <animate attributeName="stroke-opacity" from="0.55" to="0" dur="2.6s" begin={`${delay}s`} repeatCount="indefinite" />
            </circle>
          ))}

        {/* ligações e pulsos */}
        {fronts.map((f, fi) => (
          <g key={f.id}>
            {f.modules.map((mo, j) => {
              const pulse = offsets[fi] + j + 1
              const path = `M ${mo.pos.x} ${mo.pos.y} L ${f.pos.x} ${f.pos.y}`
              return (
                <g key={mo.slug}>
                  <line x1={mo.pos.x} y1={mo.pos.y} x2={f.pos.x} y2={f.pos.y} stroke="#FFFFFF" strokeOpacity="0.14" strokeWidth="1" />
                  {!reduced && (
                    <circle r="3.2" fill="#FFFFFF" opacity="0.95">
                      <animateMotion dur={`${2.4 + (pulse % 5) * 0.35}s`} begin={`${(pulse * 0.37) % 3}s`} repeatCount="indefinite" path={path} />
                    </circle>
                  )}
                </g>
              )
            })}
            <line x1={f.pos.x} y1={f.pos.y} x2={C} y2={C} stroke="#E4A9C4" strokeOpacity="0.38" strokeWidth="1.6" />
            {!reduced && (
              <circle r="4.5" fill="#E4A9C4" filter="url(#nh-glow)">
                <animateMotion dur="1.8s" begin={`${(f.deg / 360) * 1.8}s`} repeatCount="indefinite" path={`M ${f.pos.x} ${f.pos.y} L ${C} ${C}`} />
              </circle>
            )}
          </g>
        ))}

        {/* módulos */}
        {fronts.flatMap((f) =>
          f.modules.map((mo) => (
            <g key={mo.slug}>
              <circle cx={mo.pos.x} cy={mo.pos.y} r="9" fill="#C95788" opacity="0.35" filter="url(#nh-glow)" />
              <circle cx={mo.pos.x} cy={mo.pos.y} r="5.5" fill="#E4A9C4">
                <title>{mo.name}</title>
              </circle>
            </g>
          )),
        )}

        {/* frentes */}
        {fronts.map((f) => {
          const anchor = f.label.x < C - 20 ? 'end' : f.label.x > C + 20 ? 'start' : 'middle'
          const words = f.name.split(' ')
          const lines = words.length > 2 ? [words.slice(0, 2).join(' '), words.slice(2).join(' ')] : [f.name]
          return (
            <g key={f.id}>
              <circle cx={f.pos.x} cy={f.pos.y} r="30" fill="#C95788" opacity="0.28" filter="url(#nh-glow)" />
              <circle cx={f.pos.x} cy={f.pos.y} r="22" fill="url(#nh-node)" stroke="#E4A9C4" strokeOpacity="0.7" strokeWidth="1.5" />
              <text x={f.pos.x} y={f.pos.y + 5} textAnchor="middle" fontSize="14" fontWeight="800" fill="#FFFFFF" fontFamily="Manrope, system-ui, sans-serif">
                {f.modules.length}
              </text>
              {labels &&
                lines.map((ln, li) => (
                  <text
                    key={li}
                    x={f.label.x}
                    y={f.label.y + (li - (lines.length - 1) / 2) * 19 + 5}
                    textAnchor={anchor}
                    fontSize="17"
                    fontWeight="700"
                    fill="#FFFFFF"
                    fillOpacity="0.85"
                    fontFamily="Manrope, system-ui, sans-serif"
                  >
                    {ln}
                  </text>
                ))}
            </g>
          )
        })}
      </svg>

      {/* a NATI no centro */}
      <div className="pointer-events-none absolute left-1/2 top-1/2 w-[19%] -translate-x-1/2 -translate-y-1/2">
        <div className="absolute inset-[-14%] rounded-full bg-[#C95788]/30 blur-xl" aria-hidden />
        <NatiAvatar ring className="relative h-auto w-full drop-shadow-[0_10px_30px_rgba(201,87,136,0.45)]" />
      </div>
    </div>
  )
}
