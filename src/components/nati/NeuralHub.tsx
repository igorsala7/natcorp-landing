import { useRef } from 'react'
import { useReducedMotion } from 'motion/react'
import { useSmilPause } from '@/hooks/useSmilPause'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { groups, modulesByGroup } from '@/content/modulePages'
import { cn } from '@/lib/utils'

/**
 * A NATI no centro do sistema: os módulos no anel de fora, as sete frentes no anel
 * de dentro e o dado fluindo de todos eles para ela. Os pulsos são animações SMIL do
 * próprio SVG e são desligados com prefers-reduced-motion.
 *
 * O desenho é dividido em três camadas: a base parada (anéis, ligações), a camada em
 * movimento (pulsos, ondas, anel girando) numa layer própria do compositor, e os nós e
 * nomes por cima. Assim o que se mexe a cada quadro é só um punhado de círculos, e a
 * camada em movimento pausa quando sai da tela.
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
  const motionSvg = useRef<SVGSVGElement>(null)
  useSmilPause(motionSvg)
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
      {/* camada 1: a base parada (anéis, ligações, brilho do núcleo) */}
      <svg viewBox={`0 0 ${SIZE} ${SIZE}`} className="block h-auto w-full overflow-visible" aria-hidden focusable="false">
        <defs>
          <radialGradient id="nh-core" cx="0.5" cy="0.5" r="0.5">
            <stop offset="0" stopColor="#C95788" stopOpacity="0.85" />
            <stop offset="0.55" stopColor="#9A408A" stopOpacity="0.35" />
            <stop offset="1" stopColor="#511C76" stopOpacity="0" />
          </radialGradient>
        </defs>
        <circle cx={C} cy={C} r={R_MODULE} fill="none" stroke="#FFFFFF" strokeOpacity="0.09" strokeWidth="1" />
        <circle cx={C} cy={C} r={R_FRONT} fill="none" stroke="#FFFFFF" strokeOpacity="0.12" strokeWidth="1" strokeDasharray="3 7" />
        {reduced && <circle cx={C} cy={C} r={R_MODULE + 30} fill="none" stroke="#E4A9C4" strokeOpacity="0.25" strokeWidth="1" strokeDasharray="1 14" strokeLinecap="round" />}
        <circle cx={C} cy={C} r={150} fill="url(#nh-core)" />
        {fronts.map((f) => (
          <g key={f.id}>
            {f.modules.map((mo) => (
              <line key={mo.slug} x1={mo.pos.x} y1={mo.pos.y} x2={f.pos.x} y2={f.pos.y} stroke="#FFFFFF" strokeOpacity="0.14" strokeWidth="1" />
            ))}
            <line x1={f.pos.x} y1={f.pos.y} x2={C} y2={C} stroke="#E4A9C4" strokeOpacity="0.38" strokeWidth="1.6" />
          </g>
        ))}
      </svg>

      {/* camada 2: o que se mexe (anel girando, ondas do núcleo, pulsos), numa layer própria */}
      {!reduced && (
        <svg
          ref={motionSvg}
          viewBox={`0 0 ${SIZE} ${SIZE}`}
          className="absolute inset-0 h-full w-full overflow-visible will-change-transform"
          aria-hidden
          focusable="false"
        >
          <defs>
            <radialGradient id="nh-spark" cx="0.5" cy="0.5" r="0.5">
              <stop offset="0" stopColor="#FFFFFF" stopOpacity="1" />
              <stop offset="0.35" stopColor="#E4A9C4" stopOpacity="0.9" />
              <stop offset="1" stopColor="#E4A9C4" stopOpacity="0" />
            </radialGradient>
          </defs>
          <circle cx={C} cy={C} r={R_MODULE + 30} fill="none" stroke="#E4A9C4" strokeOpacity="0.25" strokeWidth="1" strokeDasharray="1 14" strokeLinecap="round">
            <animateTransform attributeName="transform" type="rotate" from={`0 ${C} ${C}`} to={`360 ${C} ${C}`} dur="90s" repeatCount="indefinite" />
          </circle>
          {[0, 1.2].map((delay) => (
            <circle key={delay} cx={C} cy={C} r={70} fill="none" stroke="#E4A9C4" strokeWidth="1.5">
              <animate attributeName="r" from="70" to="190" dur="2.6s" begin={`${delay}s`} repeatCount="indefinite" />
              <animate attributeName="stroke-opacity" from="0.55" to="0" dur="2.6s" begin={`${delay}s`} repeatCount="indefinite" />
            </circle>
          ))}
          {fronts.map((f, fi) => (
            <g key={f.id}>
              {f.modules.map((mo, j) => {
                const pulse = offsets[fi] + j + 1
                return (
                  <circle key={mo.slug} r="3.2" fill="#FFFFFF" opacity="0.95">
                    <animateMotion dur={`${2.4 + (pulse % 5) * 0.35}s`} begin={`${(pulse * 0.37) % 3}s`} repeatCount="indefinite" path={`M ${mo.pos.x} ${mo.pos.y} L ${f.pos.x} ${f.pos.y}`} />
                  </circle>
                )
              })}
              <circle r="8" fill="url(#nh-spark)">
                <animateMotion dur="1.8s" begin={`${(f.deg / 360) * 1.8}s`} repeatCount="indefinite" path={`M ${f.pos.x} ${f.pos.y} L ${C} ${C}`} />
              </circle>
            </g>
          ))}
        </svg>
      )}

      {/* camada 3: módulos, frentes e nomes, por cima dos pulsos */}
      <svg viewBox={`0 0 ${SIZE} ${SIZE}`} className="absolute inset-0 h-full w-full overflow-visible" aria-hidden focusable="false">
        <defs>
          <radialGradient id="nh-node" cx="0.35" cy="0.3" r="0.8">
            <stop offset="0" stopColor="#B27BE0" />
            <stop offset="1" stopColor="#511C76" />
          </radialGradient>
          <radialGradient id="nh-halo" cx="0.5" cy="0.5" r="0.5">
            <stop offset="0" stopColor="#C95788" stopOpacity="0.55" />
            <stop offset="0.5" stopColor="#C95788" stopOpacity="0.18" />
            <stop offset="1" stopColor="#C95788" stopOpacity="0" />
          </radialGradient>
        </defs>

        {/* módulos */}
        {fronts.flatMap((f) =>
          f.modules.map((mo) => (
            <g key={mo.slug}>
              <circle cx={mo.pos.x} cy={mo.pos.y} r="16" fill="url(#nh-halo)" />
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
              <circle cx={f.pos.x} cy={f.pos.y} r="46" fill="url(#nh-halo)" />
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
