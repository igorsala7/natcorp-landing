import { Fragment, useRef, type ReactNode } from 'react'
import { m, useReducedMotion } from 'motion/react'
import { Logo, LogoOutline } from '@/components/brand/Logo'
import { useNodeRects, type NodeRect } from '@/components/journey/useNodeRects'
import { useIsDesktop } from '@/hooks/useMediaQuery'
import { operatorMeta } from '@/content/structures'
import type { ServiceFlow } from '@/content/structures/types'
import { EASE, viewportOnce } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { useSmilPause } from '@/hooks/useSmilPause'
import { ModuleChip } from './ModuleChip'
import { operatorsIn } from './operators'
import { OperatorLegend } from './ResponsibilityMap'

/**
 * O fluxo do centro de serviços compartilhados: o que entra pelos portais (à esquerda, por origem),
 * o centro que opera tudo na mesma base (no meio) e o que sai pronto (à direita).
 * Desenhado para fundo escuro. Em telas largas, os conectores são medidos entre os cartões;
 * no celular, as três partes se empilham com conectores verticais.
 */

const WHITE = '#FFFFFF'
const HIGHLIGHT = '#E4A9C4'
const PINK = '#C95788'

const fmt = (n: number) => n.toFixed(1)

interface ServiceCenterDiagramProps {
  flow: ServiceFlow
  className?: string
}

export function ServiceCenterDiagram({ flow, className }: ServiceCenterDiagramProps) {
  const reduced = useReducedMotion()
  const desktop = useIsDesktop()
  const animate = !reduced
  const operators = operatorsIn(flow.inputs)

  return (
    <div role="group" aria-label="O fluxo do centro de serviços: entradas, centro e saídas" className={cn('relative', className)}>
      <p className="sr-only">As entradas alimentam o centro de serviços; do centro saem os resultados prontos, por empresa.</p>
      {desktop ? <WideFlow flow={flow} animate={animate} /> : <StackedFlow flow={flow} animate={animate} />}
      <div className="mt-8 flex flex-col gap-3 border-t border-white/10 pt-5 sm:flex-row sm:items-center sm:justify-between sm:gap-8">
        <OperatorLegend operators={operators} tone="dark" />
        <p className="text-[13px] leading-snug text-white/70 sm:max-w-md sm:text-right">
          As requisições nascem nos portais, o centro opera tudo na mesma base e o resultado sai pronto, por empresa.
        </p>
      </div>
    </div>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Peças compartilhadas
 * ---------------------------------------------------------------------------------------------- */

function ColumnHead({ children, align = 'left' }: { children: ReactNode; align?: 'left' | 'center' }) {
  return (
    <p className={cn('text-[12px] font-bold uppercase tracking-[0.16em] text-[#E4A9C4]', align === 'center' && 'text-center')}>
      {children}
    </p>
  )
}

function InputCard({ group }: { group: ServiceFlow['inputs'][number] }) {
  const meta = operatorMeta[group.operator]
  return (
    <div className="h-full rounded-2xl border border-white/10 bg-white/[0.05] p-4 xl:p-5">
      <div className="flex items-start gap-2.5">
        <span aria-hidden className="mt-1.5 h-2.5 w-2.5 shrink-0 rounded-full ring-2 ring-white/60" style={{ backgroundColor: meta.color }} />
        <div className="min-w-0">
          <h3 className="text-[15px] font-extrabold leading-snug text-white">{group.from}</h3>
          <p className="mt-0.5 text-[11.5px] font-semibold uppercase tracking-[0.12em] text-white/60">{meta.label}</p>
        </div>
      </div>
      <ul className="mt-3 space-y-1.5">
        {group.items.map((item) => (
          <li key={item} className="flex items-start gap-2 text-[13.5px] leading-snug text-white/85">
            <span aria-hidden className="mt-[9px] h-px w-2.5 shrink-0 bg-[#E4A9C4]/70" />
            {item}
          </li>
        ))}
      </ul>
    </div>
  )
}

function CenterCard({ center }: { center: ServiceFlow['center'] }) {
  return (
    <div className="relative overflow-hidden rounded-3xl border border-white/20 bg-brand-gradient p-6 shadow-glow xl:p-7">
      <LogoOutline className="pointer-events-none absolute -right-[18%] -top-[28%] h-[130%] w-auto text-white/[0.14]" />
      <div className="relative">
        <span className="flex h-12 w-12 items-center justify-center rounded-2xl bg-white/15">
          <Logo variant="symbol" tone="white" decorative className="h-6 w-6" />
        </span>
        <p className="mt-4 text-[11px] font-bold uppercase tracking-[0.16em] text-[#E4A9C4]">Um só time, na mesma base</p>
        <h3 className="mt-2 text-[22px] font-extrabold leading-tight tracking-brand text-white xl:text-2xl">{center.title}</h3>
        <p className="mt-3 text-[14.5px] leading-relaxed text-white/85">{center.text}</p>
        <ul className="mt-4 flex flex-wrap gap-1.5" aria-label="Módulos que o centro opera">
          {center.modules.map((s) => (
            <li key={s}>
              <ModuleChip slug={s} tone="dark" size="sm" />
            </li>
          ))}
        </ul>
      </div>
    </div>
  )
}

function OutputCard({ output }: { output: ServiceFlow['outputs'][number] }) {
  return (
    <div className="h-full rounded-2xl border border-[#E4A9C4]/25 bg-white/[0.06] p-3.5 xl:px-4">
      <h3 className="text-[14px] font-bold leading-snug text-white">{output.title}</h3>
      <ul className="mt-2 flex flex-wrap gap-1.5">
        {output.modules.map((s) => (
          <li key={s}>
            <ModuleChip slug={s} tone="dark" size="sm" />
          </li>
        ))}
      </ul>
    </div>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Telas largas: três colunas e conectores medidos entre os cartões
 * ---------------------------------------------------------------------------------------------- */

function WideFlow({ flow, animate }: { flow: ServiceFlow; animate: boolean }) {
  const n = flow.inputs.length
  const k = flow.outputs.length
  const { containerRef, setNodeRef, rects } = useNodeRects<HTMLElement>(n + 1 + k)
  const enter = (dir: 'left' | 'right' | 'center', i: number) =>
    animate
      ? {
          initial: dir === 'center' ? { opacity: 0, scale: 0.96 } : { opacity: 0, x: dir === 'left' ? -14 : 14 },
          whileInView: { opacity: 1, x: 0, scale: 1 },
          viewport: viewportOnce,
          transition: { duration: 0.6, ease: EASE, delay: dir === 'center' ? 0.15 : 0.1 + i * 0.06 },
        }
      : {}

  return (
    <div ref={containerRef} className="relative isolate">
      <Connectors rects={rects} n={n} k={k} animate={animate} />
      <div className="grid grid-cols-[minmax(0,1fr)_minmax(0,1.15fr)_minmax(0,1fr)] gap-x-14 gap-y-4 xl:gap-x-20">
        <ColumnHead>Entradas · pelos portais</ColumnHead>
        <ColumnHead align="center">Centro de serviços</ColumnHead>
        <ColumnHead>Saídas · por empresa</ColumnHead>

        <ol className="relative z-10 flex flex-col gap-4 self-center" aria-label="Entradas">
          {flow.inputs.map((g, i) => (
            <m.li key={g.from} ref={setNodeRef(i)} {...enter('left', i)}>
              <InputCard group={g} />
            </m.li>
          ))}
        </ol>

        <m.div ref={setNodeRef(n)} className="relative z-10 self-center" {...enter('center', 0)}>
          <CenterCard center={flow.center} />
        </m.div>

        <ol className="relative z-10 flex flex-col gap-2.5 self-center" aria-label="Saídas">
          {flow.outputs.map((o, j) => (
            <m.li key={o.title} ref={setNodeRef(n + 1 + j)} {...enter('right', j)}>
              <OutputCard output={o} />
            </m.li>
          ))}
        </ol>
      </div>
    </div>
  )
}

/** Curva horizontal de um ponto a outro, com saída e chegada na horizontal. */
function curve(x1: number, y1: number, x2: number, y2: number) {
  const k = Math.max(12, (x2 - x1) / 2)
  return `M${fmt(x1)},${fmt(y1)} C${fmt(x1 + k)},${fmt(y1)} ${fmt(x2 - k)},${fmt(y2)} ${fmt(x2)},${fmt(y2)}`
}

function Connectors({ rects, n, k, animate }: { rects: (NodeRect | null)[]; n: number; k: number; animate: boolean }) {
  const svgRef = useRef<SVGSVGElement>(null)
  useSmilPause(svgRef)
  const ready = rects.length === n + 1 + k && rects.every((r) => r && r.w > 0 && r.h > 0)
  if (!ready) return null
  const boxes = rects as NodeRect[]
  const c = boxes[n]

  const inputs = boxes.slice(0, n).map((a, i) => ({
    d: curve(a.x + a.w, a.y + a.h / 2, c.x, c.y + (c.h * (i + 1)) / (n + 1)),
    end: [c.x, c.y + (c.h * (i + 1)) / (n + 1)] as const,
  }))
  const outputs = boxes.slice(n + 1).map((b, j) => ({
    d: curve(c.x + c.w, c.y + (c.h * (j + 1)) / (k + 1), b.x, b.y + b.h / 2),
    end: [b.x, b.y + b.h / 2] as const,
  }))
  /* Pulsos: em todas as entradas e em algumas saídas, para o desenho não ficar carregado. */
  const pulsed = new Set([0, Math.floor((k - 1) / 2), k - 1])

  const draw = (delay: number) =>
    animate
      ? {
          initial: { pathLength: 0, opacity: 0 },
          whileInView: { pathLength: 1, opacity: 1 },
          viewport: viewportOnce,
          transition: { duration: 0.9, ease: EASE, delay },
        }
      : {}

  return (
    <svg ref={svgRef} aria-hidden className="pointer-events-none absolute inset-0 z-0 h-full w-full overflow-visible">
      {inputs.map((p, i) => (
        <Fragment key={`in-${i}`}>
          <m.path d={p.d} fill="none" stroke={WHITE} strokeOpacity={0.4} strokeWidth={1.5} strokeLinecap="round" {...draw(0.3 + i * 0.12)} />
          <m.circle cx={p.end[0]} cy={p.end[1]} r={3} fill={WHITE} fillOpacity={0.8} {...(animate ? { initial: { opacity: 0 }, whileInView: { opacity: 1 }, viewport: viewportOnce, transition: { delay: 1.1 + i * 0.12 } } : {})} />
          {animate && (
            <g opacity={0}>
              <circle r={7} fill={PINK} fillOpacity={0.2} />
              <circle r={3} fill={HIGHLIGHT} />
              <animateMotion dur="3.2s" begin={`${(1.2 + i * 0.5).toFixed(1)}s`} repeatCount="indefinite" path={p.d} />
              <animate attributeName="opacity" values="0;1;1;0" keyTimes="0;0.1;0.85;1" dur="3.2s" begin={`${(1.2 + i * 0.5).toFixed(1)}s`} repeatCount="indefinite" />
            </g>
          )}
        </Fragment>
      ))}
      {outputs.map((p, j) => (
        <Fragment key={`out-${j}`}>
          <m.path d={p.d} fill="none" stroke={HIGHLIGHT} strokeOpacity={0.7} strokeWidth={1.5} strokeLinecap="round" {...draw(0.7 + j * 0.06)} />
          <m.circle cx={p.end[0]} cy={p.end[1]} r={3} fill={HIGHLIGHT} {...(animate ? { initial: { opacity: 0 }, whileInView: { opacity: 1 }, viewport: viewportOnce, transition: { delay: 1.5 + j * 0.06 } } : {})} />
          {animate && pulsed.has(j) && (
            <g opacity={0}>
              <circle r={7} fill={HIGHLIGHT} fillOpacity={0.2} />
              <circle r={3} fill={WHITE} />
              <animateMotion dur="3s" begin={`${(2.4 + j * 0.3).toFixed(1)}s`} repeatCount="indefinite" path={p.d} />
              <animate attributeName="opacity" values="0;1;1;0" keyTimes="0;0.1;0.85;1" dur="3s" begin={`${(2.4 + j * 0.3).toFixed(1)}s`} repeatCount="indefinite" />
            </g>
          )}
        </Fragment>
      ))}
    </svg>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Celular e tablet: entradas, centro e saídas empilhados, com conectores verticais
 * ---------------------------------------------------------------------------------------------- */

function VerticalConnector({ animate, tone = 'white' }: { animate: boolean; tone?: 'white' | 'highlight' }) {
  const color = tone === 'highlight' ? HIGHLIGHT : WHITE
  const draw = animate
    ? { initial: { pathLength: 0, opacity: 0 }, whileInView: { pathLength: 1, opacity: 1 }, viewport: viewportOnce, transition: { duration: 0.7, ease: EASE, delay: 0.15 } }
    : {}
  return (
    <div className="flex justify-center py-1" aria-hidden>
      <svg width="24" height="52" viewBox="0 0 24 52" className="overflow-visible">
        <m.path d="M12,2 L12,42" fill="none" stroke={color} strokeOpacity={tone === 'highlight' ? 0.8 : 0.45} strokeWidth={1.5} strokeLinecap="round" {...draw} />
        <m.path d="M6,38 L12,45 L18,38" fill="none" stroke={color} strokeOpacity={tone === 'highlight' ? 0.9 : 0.6} strokeWidth={1.5} strokeLinecap="round" strokeLinejoin="round" {...(animate ? { initial: { opacity: 0 }, whileInView: { opacity: 1 }, viewport: viewportOnce, transition: { delay: 0.8 } } : {})} />
        {animate && (
          <g opacity={0}>
            <circle r={3} fill={HIGHLIGHT} />
            <animateMotion dur="2.4s" begin="1s" repeatCount="indefinite" path="M12,2 L12,42" />
            <animate attributeName="opacity" values="0;1;1;0" keyTimes="0;0.15;0.85;1" dur="2.4s" begin="1s" repeatCount="indefinite" />
          </g>
        )}
      </svg>
    </div>
  )
}

function StackedFlow({ flow, animate }: { flow: ServiceFlow; animate: boolean }) {
  const enter = (i: number) =>
    animate ? { initial: { opacity: 0, y: 12 }, whileInView: { opacity: 1, y: 0 }, viewport: viewportOnce, transition: { duration: 0.5, ease: EASE, delay: 0.05 + i * 0.05 } } : {}
  return (
    <div className="flex flex-col">
      <ColumnHead>Entradas · pelos portais</ColumnHead>
      <ol className="mt-3 grid gap-3 sm:grid-cols-2" aria-label="Entradas">
        {flow.inputs.map((g, i) => (
          <m.li key={g.from} {...enter(i)}>
            <InputCard group={g} />
          </m.li>
        ))}
      </ol>

      <VerticalConnector animate={animate} />

      <ColumnHead align="center">Centro de serviços</ColumnHead>
      <m.div className="mt-3" {...enter(0)}>
        <CenterCard center={flow.center} />
      </m.div>

      <VerticalConnector animate={animate} tone="highlight" />

      <ColumnHead>Saídas · por empresa</ColumnHead>
      <ol className="mt-3 grid gap-2.5 sm:grid-cols-2" aria-label="Saídas">
        {flow.outputs.map((o, j) => (
          <m.li key={o.title} {...enter(j)}>
            <OutputCard output={o} />
          </m.li>
        ))}
      </ol>
    </div>
  )
}
