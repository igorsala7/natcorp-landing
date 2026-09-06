import { useEffect, useId } from 'react'
import { m, useReducedMotion } from 'motion/react'
import type { Target, Transition } from 'motion/react'
import nati from '@/assets/avatars/nati.png'
import { BrandGradient } from '@/components/brand/Logo'
import { MODULES, SYMBOL_BOX } from '@/components/brand/logo-paths'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'

/**
 * Motion da NATI, a Inteligência Artificial dentro do sistema, em três atos:
 * 1. O centro do símbolo acende em rosa, os quatro losangos se abrem e a NATI sobe no meio,
 *    com anéis finos saindo dela, como quem escuta.
 * 2. Uma pergunta chega pela direita. A NATI pensa, três módulos aparecem ao redor dela
 *    e um pulso rosa vai até cada um e volta, na mesma linguagem do raio da assinatura.
 * 3. A resposta sobe embaixo, com nomes, unidades e datas, e uma ação pronta para aprovar.
 *    Por fim, o nome: "Inteligência Artificial" e NATI.
 * Tudo em SVG (320 × 180). Com movimento reduzido, mostra o quadro final pronto.
 */

/** Duração total, para quem espera o fim. */
export const NATI_MOTION_MS = 5400

const FONT = 'Manrope, system-ui, sans-serif'

/* Centro da NATI e raio do disco do avatar. */
const A = { x: 160, y: 70 }
const R = 20
/* O símbolo começa com 18 unidades de largura e se abre até virar uma moldura leve atrás dela. */
const SYMBOL_SCALE = 18 / SYMBOL_BOX
const FRAME_SCALE = 8.4
const HALF = SYMBOL_BOX / 2

/* Linha do tempo, em segundos. */
const T = {
  spark: 0,
  glow: 0.15,
  part: 0.35,
  partDur: 0.9,
  rise: 0.5,
  riseDur: 0.75,
  rings: 0.75,
  ringStagger: 0.28,
  ringDur: 1.2,
  bubble: 1.15,
  bubbleDur: 0.6,
  dots: 1.7,
  dotsEnd: 3.4,
  chips: 2.3,
  chipStagger: 0.15,
  chipDur: 0.5,
  pulse: 2.55,
  pulseStagger: 0.12,
  pulseDur: 0.8,
  card: 3.55,
  cardDur: 0.7,
  rows: 3.8,
  rowStagger: 0.09,
  action: 4.1,
  label: 4.35,
  labelDur: 0.6,
  end: 5.1,
}

/* Para onde cada losango se abre (topo, direita, esquerda, base), em unidades do símbolo. */
const partTo = [
  { x: 0, y: -0.4 },
  { x: 0.4, y: 0 },
  { x: -0.4, y: 0 },
  { x: 0, y: 0.4 },
]

/* A pergunta, como mensagem de quem usa o sistema (alinhada à direita). */
const BUBBLE = { right: 306, y: 11, h: 21, w: 166, text: 'Quem tem férias vencendo em setembro?' }

/* Os módulos que a NATI consulta, ao redor dela. */
const CHIP_H = 22
const CHIPS = [
  { name: 'Folha de Pagamento', hint: 'Férias', cx: 64, cy: 74, w: 88 },
  { name: 'Ponto Eletrônico', hint: 'Afastamentos', cx: 239, cy: 56, w: 78 },
  { name: 'Administração de Pessoal', hint: 'Admissões', cx: 253, cy: 120, w: 106 },
]

/* A resposta. */
const CARD = { x: 14, y: 100, w: 156, h: 76 }
const TITLE = ['12 pessoas com férias', 'vencendo em setembro']
const ROWS = [
  { name: 'Ana Beatriz Souza', unit: 'Sorocaba', date: '18/09' },
  { name: 'Carlos Menezes', unit: 'Campinas', date: '22/09' },
  { name: 'Juliana Prado', unit: 'Sorocaba', date: '30/09' },
]
const ACTION = { text: 'Preparar avisos aos gestores', w: 100, h: 11 }

/* Ponto na borda de um retângulo (centro cx,cy; meia largura hw; meia altura hh) na direção de `from`. */
function rectEdge(cx: number, cy: number, hw: number, hh: number, from: { x: number; y: number }) {
  const dx = from.x - cx
  const dy = from.y - cy
  const k = Math.min(hw / Math.abs(dx || 1e-6), hh / Math.abs(dy || 1e-6))
  return { x: cx + dx * k, y: cy + dy * k }
}

/* Ponto na borda do disco da NATI, na direção de `to`. */
function discEdge(to: { x: number; y: number }, r: number) {
  const dx = to.x - A.x
  const dy = to.y - A.y
  const len = Math.hypot(dx, dy) || 1
  return { x: A.x + (dx / len) * r, y: A.y + (dy / len) * r }
}

interface NatiMotionProps {
  /** `white` para fundos escuros; `gradient` para fundos claros. */
  tone?: 'white' | 'gradient'
  /** Dispara a sequência. Para repetir, troque a `key` do componente. */
  play?: boolean
  className?: string
  onComplete?: () => void
}

export function NatiMotion({ tone = 'white', play = true, className, onComplete }: NatiMotionProps) {
  const reduced = useReducedMotion()
  const uid = useId().replace(/[^a-zA-Z0-9]/g, '')
  const gradId = `nm-grad-${uid}`
  const rayId = `nm-ray-${uid}`
  const discId = `nm-disc-${uid}`
  const clipId = `nm-clip-${uid}`
  const blurId = `nm-blur-${uid}`
  const shadowId = `nm-shadow-${uid}`

  useEffect(() => {
    if (!play || !onComplete) return
    const t = window.setTimeout(onComplete, reduced ? 0 : NATI_MOTION_MS)
    return () => window.clearTimeout(t)
  }, [play, reduced, onComplete])

  const on = play && !reduced

  /**
   * Cada elemento sai de `from` e vai para `to` (ou volta para `from` quando `play` é false, para o replay por `key`).
   * Com movimento reduzido, fica parado em `end` (por padrão, `to`): o quadro final.
   */
  const step = (from: Target, to: Target, transition: Transition, end: Target = to) =>
    reduced ? { initial: end, animate: end } : { initial: from, animate: on ? to : from, transition }

  const dark = tone === 'white'
  const ink = dark ? '#FFFFFF' : '#1B1238'
  const soft = dark ? 'rgba(255,255,255,0.72)' : '#4A4460'
  const pink = dark ? '#E4A9C4' : '#C95788'
  const line = dark ? 'rgba(255,255,255,0.22)' : 'rgba(81,28,118,0.22)'
  const symbolFill = dark ? '#FFFFFF' : `url(#${gradId})`
  const frameOpacity = dark ? 0.1 : 0.09
  const surface = dark
    ? { fill: 'rgba(255,255,255,0.1)', stroke: 'rgba(255,255,255,0.16)', filter: undefined }
    : { fill: '#FFFFFF', stroke: '#E9E5F1', filter: `url(#${shadowId})` }
  const bubbleFill = dark ? 'rgba(255,255,255,0.12)' : '#E9E5F1'
  const ray = dark ? { core: '#FFF1F6', mid: '#F5B4CC', glow: '#C95788' } : { core: '#C95788', mid: '#E4A9C4', glow: '#C95788' }

  const bubbleX = BUBBLE.right - BUBBLE.w
  const img = R * 2 * 1.18

  return (
    <svg
      viewBox="0 0 320 180"
      className={cn('block overflow-visible', className)}
      aria-hidden
      focusable="false"
    >
      <defs>
        <BrandGradient id={gradId} />
        {/* o raio: núcleo claro, rosa da marca no meio, esmaecendo nas bordas */}
        <radialGradient id={rayId} cx="0.5" cy="0.5" r="0.5">
          <stop offset="0" stopColor="#FFF1F6" />
          <stop offset="0.12" stopColor="#F5B4CC" />
          <stop offset="0.36" stopColor="#C95788" />
          <stop offset="0.7" stopColor="#C95788" stopOpacity="0.45" />
          <stop offset="1" stopColor="#C95788" stopOpacity="0" />
        </radialGradient>
        <linearGradient id={discId} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#FFFFFF" />
          <stop offset="1" stopColor="#F3E8F5" />
        </linearGradient>
        <clipPath id={clipId}>
          <circle cx={A.x} cy={A.y} r={R} />
        </clipPath>
        <filter id={blurId} x="-60%" y="-60%" width="220%" height="220%">
          <feGaussianBlur stdDeviation="1.1" />
        </filter>
        <filter id={`${blurId}-wide`} x="-100%" y="-100%" width="300%" height="300%">
          <feGaussianBlur stdDeviation="2.2" />
        </filter>
        <filter id={shadowId} x="-10%" y="-20%" width="120%" height="150%">
          <feDropShadow dx="0" dy="1.5" stdDeviation="2" floodColor="#2C1A63" floodOpacity="0.12" />
        </filter>
      </defs>

      {/* ato 1: o símbolo se abre e recua, virando uma moldura leve atrás da NATI */}
      <m.g
        style={{ transformOrigin: '0px 0px' }}
        {...step(
          { x: A.x, y: A.y, scale: SYMBOL_SCALE, opacity: 1 },
          { x: A.x, y: A.y, scale: FRAME_SCALE, opacity: frameOpacity },
          { duration: T.partDur, ease: EASE, delay: T.part },
        )}
      >
        <g transform={`translate(${-HALF} ${-HALF})`}>
          {MODULES.map((d, i) => (
            <m.path
              key={i}
              d={d}
              fill={symbolFill}
              {...step({ x: 0, y: 0 }, { x: partTo[i].x, y: partTo[i].y }, { duration: T.partDur, ease: EASE, delay: T.part })}
            />
          ))}
        </g>
      </m.g>

      {/* o ponto central acende e explode em luz rosa; o que sobra é o halo atrás dela */}
      <m.circle
        cx={A.x}
        cy={A.y}
        r={1}
        fill={`url(#${rayId})`}
        style={{ transformOrigin: `${A.x}px ${A.y}px` }}
        {...step(
          { scale: 0, opacity: 0 },
          { scale: [0, 36, 30], opacity: [0, 0.95, 0.32] },
          { duration: 0.95, ease: 'easeOut', delay: T.glow, times: [0, 0.5, 1] },
          { scale: 30, opacity: 0.32 },
        )}
      />
      <m.circle
        cx={A.x}
        cy={A.y}
        r={1.4}
        fill="#FFF1F6"
        {...step({ opacity: 0 }, { opacity: [0, 1, 1, 0] }, { duration: 0.6, ease: 'easeOut', delay: T.spark }, { opacity: 0 })}
      />

      {/* anéis que saem dela, como quem escuta */}
      {[0, 1, 2].map((i) => (
        <m.circle
          key={i}
          cx={A.x}
          cy={A.y}
          r={R + 2}
          fill="none"
          stroke="#E4A9C4"
          strokeWidth="0.7"
          style={{ transformOrigin: `${A.x}px ${A.y}px` }}
          {...step(
            { scale: 1, opacity: 0 },
            { scale: [1, 1.34, 2.7], opacity: [0, 0.55, 0] },
            { duration: T.ringDur, ease: 'easeOut', delay: T.rings + i * T.ringStagger, times: [0, 0.2, 1] },
            { scale: 1, opacity: 0 },
          )}
        />
      ))}

      {/* ato 2: ligações e pulsos até cada módulo */}
      {CHIPS.map((c, i) => {
        const to = rectEdge(c.cx, c.cy, c.w / 2, CHIP_H / 2, A)
        const from = discEdge(to, R + 3)
        const d = `M${from.x.toFixed(2)} ${from.y.toFixed(2)} L${to.x.toFixed(2)} ${to.y.toFixed(2)}`
        const at = T.pulse + i * T.pulseStagger
        const travel = {
          initial: { pathLength: 0.3, pathOffset: 0, opacity: 0 } as Target,
          to: { pathOffset: [0, 0.7, 0], opacity: [0, 1, 1, 1, 0] } as Target,
          transition: { duration: T.pulseDur, ease: 'easeInOut', delay: at } as Transition,
          end: { pathLength: 0.3, pathOffset: 0, opacity: 0 } as Target,
        }
        return (
          <g key={c.name}>
            <m.path
              d={d}
              stroke={line}
              strokeWidth="0.6"
              strokeLinecap="round"
              fill="none"
              {...step({ pathLength: 0, opacity: 0 }, { pathLength: 1, opacity: 1 }, { duration: T.chipDur, ease: EASE, delay: T.chips + i * T.chipStagger })}
            />
            {/* o pulso: clarão largo, rosa no meio, núcleo nítido por cima */}
            <g filter={`url(#${blurId}-wide)`} opacity="0.6">
              <m.path d={d} stroke={ray.glow} strokeWidth="3" strokeLinecap="round" fill="none" {...step(travel.initial, travel.to, travel.transition, travel.end)} />
            </g>
            <g filter={`url(#${blurId})`}>
              <m.path d={d} stroke={ray.mid} strokeWidth="1.5" strokeLinecap="round" fill="none" {...step(travel.initial, travel.to, travel.transition, travel.end)} />
            </g>
            <m.path d={d} stroke={ray.core} strokeWidth="0.7" strokeLinecap="round" fill="none" {...step(travel.initial, travel.to, travel.transition, travel.end)} />
          </g>
        )
      })}

      {/* a NATI sobe no centro, no disco claro com o anel rosa */}
      <m.g
        style={{ transformOrigin: `${A.x}px ${A.y}px` }}
        {...step({ opacity: 0, y: 10, scale: 0.6 }, { opacity: 1, y: 0, scale: 1 }, { duration: T.riseDur, ease: EASE, delay: T.rise })}
      >
        {/* anel de respiro, depois do fim */}
        <m.circle
          cx={A.x}
          cy={A.y}
          r={R + 4.5}
          fill="none"
          stroke="#E4A9C4"
          strokeWidth="0.5"
          style={{ transformOrigin: `${A.x}px ${A.y}px` }}
          {...step(
            { scale: 1, opacity: 0.3 },
            { scale: [1, 1.09, 1], opacity: [0.3, 0.1, 0.3] },
            { duration: 2.8, ease: 'easeInOut', delay: T.end, repeat: Infinity },
            { scale: 1, opacity: 0.3 },
          )}
        />
        <circle cx={A.x} cy={A.y} r={R} fill={`url(#${discId})`} />
        <image
          href={nati}
          x={A.x - img / 2}
          y={A.y - img / 2 + R * 2 * 0.07}
          width={img}
          height={img}
          preserveAspectRatio="xMidYMid slice"
          clipPath={`url(#${clipId})`}
        />
        <circle cx={A.x} cy={A.y} r={R + 0.9} fill="none" stroke="#E4A9C4" strokeWidth="1.3" />
      </m.g>

      {/* ela pensa: três pontos embaixo */}
      <m.g
        {...step(
          { opacity: 0 },
          { opacity: [0, 1, 1, 0] },
          { duration: T.dotsEnd - T.dots, ease: 'easeOut', delay: T.dots, times: [0, 0.1, 0.88, 1] },
          { opacity: 0 },
        )}
      >
        {[-5, 0, 5].map((dx, i) => (
          <m.circle
            key={dx}
            cx={A.x + dx}
            cy={A.y + R + 9}
            r={1.5}
            fill={pink}
            {...step(
              { opacity: 0.3 },
              { opacity: [0.3, 1, 0.3] },
              { duration: 0.55, ease: 'easeInOut', delay: T.dots + 0.1 + i * 0.16, repeat: 2, repeatDelay: 0.05 },
              { opacity: 0.3 },
            )}
          />
        ))}
      </m.g>

      {/* a pergunta chega pela direita */}
      <m.g {...step({ opacity: 0, x: 36 }, { opacity: 1, x: 0 }, { duration: T.bubbleDur, ease: EASE, delay: T.bubble })}>
        <rect x={bubbleX} y={BUBBLE.y} width={BUBBLE.w} height={BUBBLE.h} rx="7" fill={bubbleFill} />
        <text x={BUBBLE.right - 9} y={BUBBLE.y + BUBBLE.h / 2 + 2.6} textAnchor="end" fontFamily={FONT} fontSize="7.2" fontWeight="600" fill={ink}>
          {BUBBLE.text}
        </text>
      </m.g>

      {/* os módulos que ela consulta */}
      {CHIPS.map((c, i) => {
        const x = c.cx - c.w / 2
        const y = c.cy - CHIP_H / 2
        const arrive = T.pulse + i * T.pulseStagger + T.pulseDur * 0.45
        return (
          <m.g key={c.name} {...step({ opacity: 0, y: 6 }, { opacity: 1, y: 0 }, { duration: T.chipDur, ease: EASE, delay: T.chips + i * T.chipStagger })}>
            {/* o clarão de quando o pulso chega */}
            <m.rect
              x={x}
              y={y}
              width={c.w}
              height={CHIP_H}
              rx="6"
              fill="#C95788"
              filter={`url(#${blurId}-wide)`}
              {...step({ opacity: 0 }, { opacity: [0, 0.55, 0] }, { duration: 0.6, ease: 'easeOut', delay: arrive - 0.1 }, { opacity: 0 })}
            />
            <rect x={x} y={y} width={c.w} height={CHIP_H} rx="6" fill={surface.fill} stroke={surface.stroke} strokeWidth="0.5" filter={surface.filter} />
            {/* o losango do módulo: acende em rosa quando o pulso chega */}
            <g transform={`translate(${x + 5.5} ${c.cy - 3}) scale(1.5)`}>
              <m.path d={MODULES[0]} {...step({ fill: dark ? '#FFFFFF' : '#9A408A' }, { fill: '#C95788' }, { duration: 0.3, ease: 'easeOut', delay: arrive })} />
            </g>
            <text x={x + 15} y={c.cy - 1.2} fontFamily={FONT} fontSize="6.5" fontWeight="700" fill={ink}>
              {c.name}
            </text>
            <text x={x + 15} y={c.cy + 6.6} fontFamily={FONT} fontSize="5.5" fontWeight="600" fill={pink} letterSpacing="0.2">
              {c.hint}
            </text>
          </m.g>
        )
      })}

      {/* ato 3: a resposta */}
      <m.g {...step({ opacity: 0, y: 12 }, { opacity: 1, y: 0 }, { duration: T.cardDur, ease: EASE, delay: T.card })}>
        <rect x={CARD.x} y={CARD.y} width={CARD.w} height={CARD.h} rx="7" fill={surface.fill} stroke={surface.stroke} strokeWidth="0.5" filter={surface.filter} />
        {TITLE.map((line, i) => (
          <m.text
            key={line}
            x={CARD.x + 10}
            y={CARD.y + 13 + i * 9.5}
            fontFamily={FONT}
            fontSize="8"
            fontWeight="800"
            fill={ink}
            {...step({ opacity: 0, x: -4 }, { opacity: 1, x: 0 }, { duration: 0.5, ease: EASE, delay: T.card + 0.12 + i * 0.08 })}
          >
            {line}
          </m.text>
        ))}
        {ROWS.map((r, i) => (
          <m.text
            key={r.name}
            x={CARD.x + 10}
            y={CARD.y + 34 + i * 8.5}
            fontFamily={FONT}
            fontSize="6.5"
            fontWeight="500"
            fill={soft}
            {...step({ opacity: 0, x: -4 }, { opacity: 1, x: 0 }, { duration: 0.45, ease: EASE, delay: T.rows + i * T.rowStagger })}
          >
            <tspan fontWeight="700" fill={ink}>
              {r.name}
            </tspan>
            <tspan> · {r.unit} · </tspan>
            <tspan fontWeight="700" fill={pink}>
              {r.date}
            </tspan>
          </m.text>
        ))}
        <m.g {...step({ opacity: 0, y: 4 }, { opacity: 1, y: 0 }, { duration: 0.5, ease: EASE, delay: T.action })}>
          <rect x={CARD.x + 10} y={CARD.y + CARD.h - 8 - ACTION.h} width={ACTION.w} height={ACTION.h} rx={ACTION.h / 2} fill="#C95788" />
          <text x={CARD.x + 10 + ACTION.w / 2} y={CARD.y + CARD.h - 8 - ACTION.h / 2 + 2.2} textAnchor="middle" fontFamily={FONT} fontSize="6" fontWeight="700" fill="#FFFFFF">
            {ACTION.text}
          </text>
        </m.g>
      </m.g>

      {/* o nome, por último */}
      <m.text
        x={14}
        y={24}
        fontFamily={FONT}
        fontSize="5.6"
        fontWeight="800"
        letterSpacing="1.1"
        fill={pink}
        {...step({ opacity: 0, y: 5 }, { opacity: 1, y: 0 }, { duration: T.labelDur, ease: EASE, delay: T.label })}
      >
        INTELIGÊNCIA ARTIFICIAL
      </m.text>
      <m.text
        x={13}
        y={50}
        fontFamily={FONT}
        fontSize="25"
        fontWeight="800"
        letterSpacing="-0.4"
        fill={ink}
        {...step({ opacity: 0, y: 7 }, { opacity: 1, y: 0 }, { duration: T.labelDur, ease: EASE, delay: T.label + 0.1 })}
      >
        NATI
      </m.text>
    </svg>
  )
}
