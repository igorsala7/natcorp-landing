import { useId } from 'react'
import { m, useReducedMotion } from 'motion/react'
import { MODULES, SYMBOL_BOX } from '@/components/brand/logo-paths'
import { moduleIcons } from '@/content/modulePages/icons'
import { effectivation } from '@/content/hiringJourney'
import { EASE, viewportOnce } from '@/lib/motion'
import { cn } from '@/lib/utils'
import {
  BAND_W,
  BAND_X,
  CHIP_FONT,
  CHIP_H,
  CHIP_TEXT_X,
  COL_W,
  HEADER_H,
  HEADER_Y,
  LOOP_D,
  NODE_FONT,
  NODE_FONT_2L,
  NODE_H,
  NODE_PITCH,
  NODE_TEXT_X,
  NODES_Y,
  RAIL_X0,
  RAIL_X1,
  RAIL_Y,
  RETURN_ARC_D,
  RETURN_Y,
  VB_W,
  buildColumns,
  buildPlatformBand,
  colCenter,
  colX,
  estimateTextWidth,
  gapCenter,
} from './integration-layout'

/**
 * Figura de fechamento da jornada: as quatro fases em sequência, os módulos que atuam em cada uma,
 * o arco de retorno (o offboarding devolve a vaga ao headcount) e, na base, a camada de plataforma
 * que sustenta todas as etapas. Desenhada para fundo escuro (Section tone="dark").
 */

const GROUND = '#2C1A63'
const PINK = '#C95788'
const HIGHLIGHT = '#E4A9C4'
const PLUM = '#9A408A'
const WHITE = '#FFFFFF'

const RETURN_LABEL = 'Offboarding devolve a vaga ao headcount'
const BAND_LABEL = 'SUSTENTAM TODAS AS ETAPAS'
const CAPTION_1 = 'Uma base de dados.'
const CAPTION_2 = 'Zero redigitação.'

const COLUMNS = buildColumns()
const BAND = buildPlatformBand()
const VB_H = BAND.y + BAND.h + 16
const CENTER_X = VB_W / 2
/** Índice do intervalo entre colunas em que a efetivação acontece (fase 2 para fase 3). */
const EFFECTIVATION_GAP = 1
/** Conectores que recebem pulsos: as três colunas com mais módulos. */
const PULSE_COLUMNS = new Set(
  [...COLUMNS].sort((a, b) => b.entries.length - a.entries.length || a.index - b.index).slice(0, 3).map((c) => c.index),
)

const railVariants = {
  hidden: { opacity: 0 },
  visible: { opacity: 1, transition: { duration: 0.8, ease: EASE, delay: 0.2 } },
}
const headerVariants = {
  hidden: { opacity: 0, y: -8 },
  visible: (col: number) => ({ opacity: 1, y: 0, transition: { duration: 0.5, ease: EASE, delay: col * 0.14 } }),
}
const nodeVariants = {
  hidden: { opacity: 0, y: 12 },
  visible: ({ col, row }: { col: number; row: number }) => ({
    opacity: 1,
    y: 0,
    transition: { duration: 0.55, ease: EASE, delay: 0.15 + col * 0.14 + row * 0.05 },
  }),
}
const connectorVariants = {
  hidden: { opacity: 0 },
  visible: { opacity: 1, transition: { duration: 0.6, ease: EASE, delay: 0.7 } },
}
const bandVariants = {
  hidden: { opacity: 0, y: 10 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.6, ease: EASE, delay: 0.75 } },
}

export function IntegrationDiagram({ className }: { className?: string }) {
  const reduced = useReducedMotion()
  const uid = useId().replace(/[^a-zA-Z0-9]/g, '')
  const id = (suffix: string) => `idg-${uid}-${suffix}`
  const animate = !reduced

  const symbolScale = 44 / SYMBOL_BOX
  const symbolY = BAND.y + 20
  const bandLabelW = estimateTextWidth(BAND_LABEL, 12, 600, 0.14)

  return (
    <div className={cn('relative', className)}>
      <m.div
        className="overflow-x-auto overflow-y-hidden rounded-2xl focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#E4A9C4]"
        role="group"
        aria-label="Diagrama dos módulos se integrando. Em telas estreitas, rola na horizontal."
        tabIndex={0}
        initial={animate ? 'hidden' : false}
        whileInView="visible"
        viewport={viewportOnce}
      >
        <svg
          viewBox={`0 0 ${VB_W} ${VB_H}`}
          width="100%"
          role="img"
          aria-labelledby={`${id('title')} ${id('desc')}`}
          focusable="false"
          className="block h-auto w-full min-w-[960px] font-sans"
          style={{ fontFamily: 'inherit' }}
        >
          <title id={id('title')}>Diagrama: como os módulos da Natcorp se integram em um único fluxo, da vaga à promoção</title>
          <desc id={id('desc')}>
            Quatro fases em sequência, da esquerda para a direita, cada uma com os módulos que atuam nela. Um arco de retorno liga o fim da
            última fase ao início da primeira, porque o offboarding devolve a vaga ao headcount. Na base, os módulos de plataforma sustentam
            todas as etapas a partir de uma única base de dados.
          </desc>

          <defs>
            <marker id={id('arrow')} viewBox="0 0 10 10" refX="9" refY="5" markerWidth="9" markerHeight="9" markerUnits="userSpaceOnUse" orient="auto">
              <path d="M0.5,0.8 L9.4,5 L0.5,9.2 Z" fill={WHITE} fillOpacity="0.6" />
            </marker>
            <marker id={id('arrow-pink')} viewBox="0 0 10 10" refX="9" refY="5" markerWidth="9" markerHeight="9" markerUnits="userSpaceOnUse" orient="auto">
              <path d="M0.5,0.8 L9.4,5 L0.5,9.2 Z" fill={HIGHLIGHT} />
            </marker>
            <radialGradient id={id('core')} cx="0.5" cy="0.5" r="0.5">
              <stop offset="0" stopColor={PINK} stopOpacity="0.5" />
              <stop offset="0.55" stopColor={PLUM} stopOpacity="0.22" />
              <stop offset="1" stopColor={PLUM} stopOpacity="0" />
            </radialGradient>
          </defs>

          {/* Trilho principal, arco de retorno e o ponto que percorre o ciclo */}
          <m.g variants={animate ? railVariants : undefined}>
            <text x={CENTER_X} y={RETURN_Y - 9} textAnchor="middle" fontSize="12.5" fontWeight="600" fill={WHITE} fillOpacity="0.7">
              {RETURN_LABEL}
            </text>
            <line x1={RAIL_X0} y1={RAIL_Y} x2={RAIL_X1} y2={RAIL_Y} stroke={WHITE} strokeOpacity="0.35" strokeWidth="3" strokeLinecap="round" />
            <path
              d={RETURN_ARC_D}
              fill="none"
              stroke={WHITE}
              strokeOpacity="0.35"
              strokeWidth="3"
              strokeLinecap="round"
              strokeLinejoin="round"
              markerEnd={`url(#${id('arrow')})`}
            />
            {COLUMNS.slice(0, -1).map((c, i) => {
              const pink = i === EFFECTIVATION_GAP
              return (
                <line
                  key={c.index}
                  x1={colX(i) + COL_W}
                  y1={RAIL_Y}
                  x2={colX(i + 1)}
                  y2={RAIL_Y}
                  stroke={pink ? HIGHLIGHT : WHITE}
                  strokeOpacity={pink ? 0.9 : 0.35}
                  strokeWidth="3"
                  markerEnd={`url(#${id(pink ? 'arrow-pink' : 'arrow')})`}
                />
              )
            })}
            {animate && (
              <g>
                <circle r="9" fill={HIGHLIGHT} opacity="0.22" />
                <circle r="4" fill={HIGHLIGHT} />
                <animateMotion dur="10s" repeatCount="indefinite" path={LOOP_D} />
              </g>
            )}

            {/* O momento da efetivação, entre a fase 2 e a fase 3 */}
            <g>
              <text x={gapCenter(EFFECTIVATION_GAP)} y={HEADER_Y - 10} textAnchor="middle" fontSize="12.5" fontWeight="600" fill={HIGHLIGHT}>
                {effectivation.title}
              </text>
              <line
                x1={gapCenter(EFFECTIVATION_GAP)}
                y1={HEADER_Y - 5}
                x2={gapCenter(EFFECTIVATION_GAP)}
                y2={RAIL_Y - 11}
                stroke={HIGHLIGHT}
                strokeOpacity="0.45"
                strokeWidth="1"
              />
              {animate && (
                <circle cx={gapCenter(EFFECTIVATION_GAP)} cy={RAIL_Y} r="7" fill="none" stroke={HIGHLIGHT} strokeWidth="1.5">
                  <animate attributeName="r" from="7" to="17" dur="2.6s" repeatCount="indefinite" />
                  <animate attributeName="stroke-opacity" from="0.7" to="0" dur="2.6s" repeatCount="indefinite" />
                </circle>
              )}
              <rect
                x="-5.5"
                y="-5.5"
                width="11"
                height="11"
                rx="2.5"
                fill={PINK}
                stroke={HIGHLIGHT}
                strokeWidth="1.5"
                transform={`translate(${gapCenter(EFFECTIVATION_GAP)} ${RAIL_Y}) rotate(45)`}
              />
            </g>
          </m.g>

          {/* Cabeçalhos das fases (opacos: o ponto passa por trás, como por uma estação) */}
          {COLUMNS.map((c) => (
            <m.g key={c.phase.n} custom={c.index} variants={animate ? headerVariants : undefined}>
              <rect x={c.x} y={HEADER_Y} width={COL_W} height={HEADER_H} rx="14" fill={GROUND} />
              <rect x={c.x} y={HEADER_Y} width={COL_W} height={HEADER_H} rx="14" fill={WHITE} fillOpacity="0.09" stroke={WHITE} strokeOpacity="0.22" />
              <text x={c.x + 16} y={HEADER_Y + 24} fontSize="12" fontWeight="700" letterSpacing="0.12em" fill={HIGHLIGHT}>
                {`FASE ${c.phase.n}`}
              </text>
              <text x={c.x + COL_W - 16} y={HEADER_Y + 24} textAnchor="end" fontSize="12" fontWeight="600" fill={WHITE} fillOpacity="0.65">
                {c.phase.range}
              </text>
              <text x={c.x + 16} y={HEADER_Y + 48} fontSize="16" fontWeight="800" fill={WHITE}>
                {c.phase.title}
              </text>
            </m.g>
          ))}

          {/* Módulos de cada fase */}
          {COLUMNS.map((c) =>
            c.nodes.map((node, row) => {
              const y = NODES_Y + row * NODE_PITCH
              if (node.kind === 'overflow') {
                return (
                  <m.g key={`${c.phase.n}-more`} custom={{ col: c.index, row }} variants={animate ? nodeVariants : undefined}>
                    <title>{node.hidden.map((e) => e.name).join(', ')}</title>
                    <rect x={c.x} y={y} width={COL_W} height={NODE_H} rx="12" fill="none" stroke={WHITE} strokeOpacity="0.28" strokeDasharray="4 4" />
                    <text x={c.x + COL_W / 2} y={y + NODE_H / 2 + 5} textAnchor="middle" fontSize="13" fontWeight="600" fill={WHITE} fillOpacity="0.75">
                      {`+${node.count} ${node.count === 1 ? 'módulo' : 'módulos'}`}
                    </text>
                  </m.g>
                )
              }
              const Icon = moduleIcons[node.entry.icon]
              const twoLines = node.lines.length > 1
              return (
                <m.g key={`${c.phase.n}-${node.entry.slug}`} custom={{ col: c.index, row }} variants={animate ? nodeVariants : undefined}>
                  <rect x={c.x} y={y} width={COL_W} height={NODE_H} rx="12" fill={WHITE} fillOpacity="0.06" stroke={WHITE} strokeOpacity="0.18" />
                  <rect x={c.x + 8} y={y + 8} width="28" height="28" rx="8" fill={WHITE} fillOpacity="0.1" />
                  <Icon x={c.x + 14.5} y={y + 14.5} size={15} strokeWidth={1.8} color={WHITE} aria-hidden focusable="false" />
                  {twoLines ? (
                    node.lines.map((line, li) => (
                      <text key={li} x={c.x + NODE_TEXT_X} y={y + 19 + li * 15} fontSize={NODE_FONT_2L} fontWeight="700" fill={WHITE}>
                        {line}
                      </text>
                    ))
                  ) : (
                    <text x={c.x + NODE_TEXT_X} y={y + NODE_H / 2 + 5} fontSize={NODE_FONT} fontWeight="700" fill={WHITE}>
                      {node.lines[0]}
                    </text>
                  )}
                </m.g>
              )
            }),
          )}

          {/* Conectores da plataforma para cada fase, com pulsos subindo */}
          <m.g variants={animate ? connectorVariants : undefined}>
            {COLUMNS.map((c) => {
              const x = colCenter(c.index)
              const top = c.bottom + 8
              const pulse = animate && PULSE_COLUMNS.has(c.index)
              const begin = `${(c.index * 0.9).toFixed(1)}s`
              return (
                <g key={c.phase.n}>
                  <line x1={x} y1={top} x2={x} y2={BAND.y} stroke={WHITE} strokeOpacity="0.25" strokeWidth="1.5" />
                  <circle cx={x} cy={top} r="2.5" fill={WHITE} fillOpacity="0.35" />
                  {pulse && (
                    <circle r="3" fill={HIGHLIGHT}>
                      <animateMotion dur="2.8s" begin={begin} repeatCount="indefinite" path={`M ${x},${BAND.y} L ${x},${top}`} />
                      <animate attributeName="opacity" values="0;1;1;0" keyTimes="0;0.15;0.8;1" dur="2.8s" begin={begin} repeatCount="indefinite" />
                    </circle>
                  )}
                </g>
              )
            })}
          </m.g>

          {/* Faixa de plataforma */}
          <m.g variants={animate ? bandVariants : undefined}>
            <rect x={BAND_X} y={BAND.y} width={BAND_W} height={BAND.h} rx="18" fill={WHITE} fillOpacity="0.05" stroke={WHITE} strokeOpacity="0.15" />
            <rect x={CENTER_X - bandLabelW / 2 - 14} y={BAND.y - 9} width={bandLabelW + 28} height="18" fill={GROUND} />
            <text x={CENTER_X} y={BAND.y + 4.5} textAnchor="middle" fontSize="12" fontWeight="600" letterSpacing="0.14em" fill={WHITE} fillOpacity="0.7">
              {BAND_LABEL}
            </text>

            {BAND.chips.map((chip) => {
              const Icon = moduleIcons[chip.entry.icon]
              return (
                <g key={chip.entry.slug}>
                  <rect x={chip.x} y={chip.y} width={chip.w} height={CHIP_H} rx={CHIP_H / 2} fill={WHITE} fillOpacity="0.08" stroke={WHITE} strokeOpacity="0.15" />
                  <Icon x={chip.x + 11} y={chip.y + 8} size={14} strokeWidth={1.8} color={HIGHLIGHT} aria-hidden focusable="false" />
                  <text x={chip.x + CHIP_TEXT_X} y={chip.y + CHIP_H / 2 + 4.5} fontSize={CHIP_FONT} fontWeight="600" fill={WHITE} fillOpacity="0.92">
                    {chip.entry.name}
                  </text>
                </g>
              )
            })}

            {/* Símbolo Natcorp no centro da faixa */}
            <circle cx={CENTER_X} cy={symbolY + 22} r="42" fill={`url(#${id('core')})`} />
            <g transform={`translate(${CENTER_X - 22} ${symbolY}) scale(${symbolScale})`}>
              {MODULES.map((d, i) => (
                <path key={i} d={d} fill={WHITE} />
              ))}
            </g>
            <text x={CENTER_X} y={BAND.y + 86} textAnchor="middle" fontSize="13" fontWeight="700" fill={WHITE} fillOpacity="0.92">
              {CAPTION_1}
            </text>
            <text x={CENTER_X} y={BAND.y + 104} textAnchor="middle" fontSize="13" fontWeight="600" fill={HIGHLIGHT}>
              {CAPTION_2}
            </text>
          </m.g>
        </svg>
      </m.div>

      {/* Conteúdo do diagrama para leitores de tela */}
      <ul className="sr-only">
        {COLUMNS.map((c) => (
          <li key={c.phase.n}>
            {`Fase ${c.phase.n}, ${c.phase.title} (${c.phase.range}): ${c.entries.map((e) => e.name).join(', ')}.`}
          </li>
        ))}
        <li>{`Entre a fase ${COLUMNS[EFFECTIVATION_GAP].phase.n} e a fase ${COLUMNS[EFFECTIVATION_GAP + 1].phase.n}: ${effectivation.title}.`}</li>
        <li>{`Sustentam todas as etapas: ${BAND.entries.map((e) => e.name).join(', ')}. ${CAPTION_1} ${CAPTION_2}`}</li>
        <li>{`${RETURN_LABEL}: o ciclo recomeça.`}</li>
      </ul>
    </div>
  )
}
