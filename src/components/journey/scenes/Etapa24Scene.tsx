import { m, type MotionValue } from 'motion/react'
import { BadgeCheck, Calculator, Coins, Network } from 'lucide-react'
import { EASE } from '@/lib/motion'
import { SceneStage, type StageContext } from './SceneStage'
import { useScenePhases, useSteel } from './hooks'
import { ActionButton, Backdrop, Caption, EventStack, FarBlock, Field, Figure, People, Ping, Room, SafetyStripe, Sign, UiCard, WindowRow, type SceneEvent } from './parts'

/**
 * Etapa 24, "Um ano depois, o mapa de sucessão aponta para Ana": na avaliação anual, Ana aparece
 * pronta para a Coordenação de Produção e Marcos abre a Requisição de Promoção. A fábrica um ano
 * depois, festiva sem exagero (bandeirinhas e confete nas cores da marca), Ana e Marcos diante da
 * Linha 2, o card de Carreira e Sucessão e a promoção efetivada sem redigitar.
 */
export function Etapa24Scene() {
  return (
    <SceneStage label="Um ano depois, na fábrica da Vale Verde em Sorocaba, Ana Ribeiro e Marcos Tavares diante da Linha 2, com a equipe atrás e bandeirinhas nas cores da Natcorp. No card de Carreira e Sucessão, o mapa de sucessão mostra Ana pronta para a Coordenação de Produção, a faixa do novo cargo e a política de mérito conferidas, e a promoção aprovada é efetivada em Cargos e Salários, na Folha de Pagamento e no organograma. No peito de Ana aparece o crachá de Coordenadora de Produção.">
      {(ctx) => <Composition {...ctx} />}
    </SceneStage>
  )
}

/* Fases: 0 nada, 1 mapa de sucessão, 2 Ana pronta, 3 faixa conferida, 4 promoção efetivada, 5 nova faixa, 6 folha, 7 organograma e crachá. */
const PHASES = [0, 500, 1400, 2200, 3000, 3900, 4700, 5500]

const events: SceneEvent[] = [
  { phase: 5, icon: Coins, name: 'Cargos e Salários', role: 'Nova faixa', text: 'Faixa do novo cargo e política de mérito conferidas. Dentro da política, efetivada.' },
  { phase: 6, icon: Calculator, name: 'Folha de Pagamento', role: 'Próximo fechamento', text: 'Mudança efetivada na folha, sem redigitar.', tone: 'pink' },
  { phase: 7, icon: Network, name: 'Organograma', role: 'Carreira e Sucessão', text: 'Ana assume a Coordenação de Produção. A jornada segue.', tone: 'green' },
]

function Composition({ reduced, on, far, mid, near }: StageContext) {
  const phase = useScenePhases(on, reduced, PHASES)
  return (
    <>
      <PlantFloor far={far} mid={mid} on={on} reduced={reduced} />
      <Figure who="marcos" x={14} y={90} height={438} on={on} reduced={reduced} near={near} delay={0.3} />
      <Figure who="ana" x={198} y={58} height={470} from="bottom" on={on} reduced={reduced} near={near} />
      <Ping x={165} y={262} active={phase === 4} reduced={reduced} />
      <Lanyard shown={phase >= 7} reduced={reduced} />
      <UiCard x={340} y={44} width={288} product="Carreira e Sucessão" on={on} reduced={reduced}>
        <p className="mt-2.5 text-[15px] font-extrabold leading-snug text-brand-ink">Coordenação de Produção</p>
        <div className="mt-1 flex items-center justify-between gap-2">
          <p className="text-[10.5px] font-semibold text-brand-graphite">Avaliação anual</p>
          <span className="shrink-0 whitespace-nowrap rounded-full bg-brand-off-white px-2 py-0.5 text-[9.5px] font-semibold text-brand-graphite">Mapa de sucessão</span>
        </div>
        <div className="mt-3 space-y-2">
          <Field label="Motivo" value="Coordenadora atual transferida" />
          <Field label={phase >= 2 ? 'Pronta · mapa de talentos' : 'Sucessora indicada'} value="Ana Ribeiro" tone={phase >= 2 ? 'ok' : 'default'} />
          <Field label="Faixa e política de mérito" value={phase >= 3 ? 'Dentro da política' : 'Conferindo em Cargos e Salários'} tone={phase >= 3 ? 'ok' : 'default'} />
          <Field label="Requisição de Promoção" value="Aberta por Marcos Tavares" />
        </div>
        <ActionButton done={phase >= 4} idleLabel="Aprovar promoção" doneLabel="Promoção efetivada" icon={BadgeCheck} className="mt-3" />
      </UiCard>
      <EventStack x={680} y={150} width={256} title="Efetivado sem redigitar" items={events} shown={phase} reduced={reduced} />
      <Caption when="Ano 1 · Set 2027" where="Vale Verde Alimentos · Sorocaba" />
    </>
  )
}

/** O crachá de Ana com o cargo novo, aparecendo na última fase. */
function Lanyard({ shown, reduced }: { shown: boolean; reduced: boolean }) {
  return (
    <m.div
      className="absolute w-[100px] rounded-lg border border-brand-mist bg-white px-2 py-1.5 text-center shadow-lift"
      style={{ left: 214, top: 224 }}
      initial={reduced ? false : { opacity: 0, scale: 0.6, y: 8 }}
      animate={shown ? { opacity: 1, scale: 1, y: 0 } : undefined}
      transition={{ duration: 0.5, ease: EASE }}
    >
      <span className="mx-auto mb-1 block h-1 w-8 rounded-full bg-brand-pink" />
      <p className="text-[9.5px] font-extrabold leading-tight text-brand-ink">Coordenadora de Produção</p>
    </m.div>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Cenário: a fábrica um ano depois, com a Linha 2 ao fundo, a equipe, bandeirinhas e confete.
 * ---------------------------------------------------------------------------------------------- */

const FLAG_COLORS = ['#C95788', '#511C76', '#E4A9C4', '#9A408A']
/* Duas curvas do varal de bandeirinhas: início, controle e fim de cada uma. */
const SWAGS: [number, number, number, number, number, number][] = [
  [0, 28, 240, 84, 480, 44],
  [480, 44, 720, 84, 960, 28],
]
const quad = (t: number, a: number, b: number, c: number) => (1 - t) * (1 - t) * a + 2 * (1 - t) * t * b + t * t * c
const FLAGS = SWAGS.flatMap(([x0, y0, x1, y1, x2, y2], s) =>
  Array.from({ length: 9 }, (_, i) => {
    const t = (i + 0.5) / 9
    return { x: Math.round(quad(t, x0, x1, x2)), y: Math.round(quad(t, y0, y1, y2)), color: FLAG_COLORS[(i + s) % FLAG_COLORS.length] }
  }),
)

/* Confete: posição, atraso, duração, cor e tamanho de cada ponto. Uma passagem só. */
const CONFETTI = [
  { x: 40, delay: 0.2, dur: 5.6, color: '#C95788', r: 4 },
  { x: 130, delay: 1.4, dur: 6.4, color: '#511C76', r: 3 },
  { x: 250, delay: 0.6, dur: 5.2, color: '#E4A9C4', r: 4.5 },
  { x: 330, delay: 2.2, dur: 6.0, color: '#9A408A', r: 3.5 },
  { x: 420, delay: 0.9, dur: 5.8, color: '#C95788', r: 3 },
  { x: 500, delay: 1.9, dur: 6.6, color: '#511C76', r: 4 },
  { x: 590, delay: 0.4, dur: 5.4, color: '#E4A9C4', r: 3.5 },
  { x: 660, delay: 2.6, dur: 6.2, color: '#9A408A', r: 4 },
  { x: 740, delay: 1.1, dur: 5.6, color: '#C95788', r: 3 },
  { x: 830, delay: 0.7, dur: 6.8, color: '#E4A9C4', r: 4.5 },
  { x: 900, delay: 1.7, dur: 5.9, color: '#511C76', r: 3.5 },
  { x: 950, delay: 2.9, dur: 6.3, color: '#9A408A', r: 3 },
]

function PlantFloor({ far, mid, on, reduced }: { far: MotionValue<number>; mid: MotionValue<number>; on: boolean; reduced: boolean }) {
  const steel = useSteel()
  return (
    <Backdrop>
      {steel.defs}
      <Room />

      {/* fundo: janelas altas, tubulação, a placa da linha e o varal de bandeirinhas (paralaxe lenta) */}
      <m.g style={{ x: far }}>
        <WindowRow />
        <rect x="0" y="24" width="960" height="7" rx="3.5" fill="#D3CDDE" />
        <rect x="0" y="36" width="960" height="3" rx="1.5" fill="#DDD8E6" />
        <FarBlock x={650} y={160} w={290} h={140} />
        <Sign x={756} y={60} title="LINHA 2" subtitle="EMBALAGEM" />
        <path d="M0 28Q240 84 480 44Q720 84 960 28" fill="none" stroke="#9A408A" strokeWidth="2" />
        {FLAGS.map((f) => (
          <polygon key={f.x} points={`${f.x - 9},${f.y} ${f.x + 9},${f.y} ${f.x},${f.y + 20}`} fill={f.color} />
        ))}
      </m.g>

      {/* meio: a equipe de touca e a linha de embalagem em inox, parada para a foto (paralaxe média) */}
      <m.g style={{ x: mid }}>
        <People
          spots={[
            { x: 450, y: 224, h: 112 },
            { x: 540, y: 234, h: 102, w: 42 },
            { x: 640, y: 228, h: 108 },
            { x: 890, y: 226, h: 110 },
          ]}
        />
        <rect x="380" y="250" width="580" height="86" rx="14" fill={steel.fill} stroke="#A89FBA" />
        <rect x="392" y="262" width="556" height="10" rx="5" fill="#FFFFFF" fillOpacity="0.5" />
        {[420, 560, 700, 840].map((x) => (
          <g key={x}>
            <rect x={x} y="200" width="60" height="52" rx="8" fill="#CFC8DB" stroke="#BDB5CC" />
            <circle cx={x + 30} cy="226" r="9" fill="#9A408A" fillOpacity="0.55" />
          </g>
        ))}
        <rect x="392" y="296" width="568" height="30" rx="6" fill="#4A4460" />
        {[0, 120, 240, 360, 480].map((x) => (
          <g key={x}>
            <rect x={400 + x} y="300" width="70" height="22" rx="4" fill="#F1E9F5" stroke="#D7C7E3" />
            <rect x={412 + x} y="306" width="22" height="10" rx="2" fill="#C95788" />
          </g>
        ))}
        {[430, 620, 810].map((x) => (
          <g key={x}>
            <rect x={x} y="336" width="14" height="60" rx="3" fill="#B9B1C8" />
            <rect x={x + 100} y="336" width="14" height="60" rx="3" fill="#B9B1C8" />
          </g>
        ))}
        <ellipse cx="670" cy="404" rx="300" ry="10" fill="#1B1238" fillOpacity="0.08" />
      </m.g>

      <Confetti on={on} reduced={reduced} />
      <SafetyStripe />
    </Backdrop>
  )
}

/** Pontos de confete descendo devagar, uma vez só. Desligado com movimento reduzido. */
function Confetti({ on, reduced }: { on: boolean; reduced: boolean }) {
  if (reduced) return null
  return (
    <g>
      {CONFETTI.map((p) => (
        <m.circle
          key={p.x}
          cx={p.x}
          cy={-16}
          r={p.r}
          fill={p.color}
          initial={{ x: 0, y: 0, opacity: 0 }}
          animate={on ? { x: [0, 14, -10, 8, 0], y: [0, 40, 300, 500, 580], opacity: [0, 1, 1, 1, 0] } : undefined}
          transition={{ duration: p.dur, delay: p.delay, ease: 'linear', times: [0, 0.08, 0.55, 0.85, 1] }}
        />
      ))}
    </g>
  )
}
