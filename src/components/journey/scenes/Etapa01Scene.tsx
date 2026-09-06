import { m, type MotionValue } from 'motion/react'
import { Send } from 'lucide-react'
import { SceneStage, type StageContext } from './SceneStage'
import { useScenePhases, useSteel } from './hooks'
import { ActionButton, Backdrop, Caption, EventStack, FarBlock, Field, Figure, People, Ping, Room, SafetyStripe, Sign, UiCard, WindowRow } from './parts'

/**
 * Etapa 1, "Uma linha nova, uma vaga nova": Marcos atravessa a fábrica e abre a Requisição de Vaga no
 * Portal do Gestor. Cenário da fábrica em SVG (paralaxe e esteira em movimento), a figura 3D do Marcos
 * e os cards da interface entrando em sequência, com as aprovações chegando.
 */
export function Etapa01Scene() {
  return (
    <SceneStage label="Marcos Tavares, gerente de produção, atravessa a fábrica da Vale Verde em Sorocaba e abre a Requisição de Vaga no Portal do Gestor: Supervisora de Produção para a Linha 2 de embalagem, com o salário dentro da faixa de Cargos e Salários. A Controladoria e a Diretoria aprovam pelo celular e a vaga nasce no headcount.">
      {(ctx) => <Composition {...ctx} />}
    </SceneStage>
  )
}

/* Fases: 0 nada, 1 card da requisição, 2 enviada, 3 Controladoria, 4 Diretoria, 5 headcount. */
const PHASES = [0, 500, 1500, 2300, 3100, 3900]

const approvals = [
  { phase: 3, initials: 'CN', name: 'Cláudia Nunes', role: 'Controladoria', text: 'Previsto e realizado do centro de custo conferidos. Aprovado.' },
  { phase: 4, initials: 'DO', name: 'Diretoria de Operações', role: 'pelo celular', text: 'Aprovado na alçada final.' },
  { phase: 5, initials: 'HC', name: 'Headcount', role: 'Administração de Pessoal', text: 'Vaga criada. Posição aberta na Linha 2.', tone: 'pink' as const },
]

function Composition({ reduced, on, far, mid, near }: StageContext) {
  const phase = useScenePhases(on, reduced, PHASES)
  return (
    <>
      <Factory far={far} mid={mid} reduced={reduced} />
      <Figure who="marcos" x={64} y={58} height={470} on={on} reduced={reduced} near={near} />
      <Ping x={192} y={272} active={phase === 2} reduced={reduced} />
      <UiCard x={330} y={54} width={292} product="Portal do Gestor" tag="Requisição de Vaga" on={on} reduced={reduced}>
        <p className="mt-2.5 text-[15px] font-extrabold leading-snug text-brand-ink">Nova vaga para a Linha 2</p>
        <div className="mt-3 space-y-2">
          <Field label="Cargo" value="Supervisora de Produção" />
          <Field label="Centro de custo" value="Embalagem · Linha 2 · Sorocaba" />
          <Field label="Motivo" value="Aumento de quadro" />
          <Field label="Salário" value="Dentro da faixa · Cargos e Salários" tone="ok" />
        </div>
        <ActionButton done={phase >= 2} idleLabel="Enviar para aprovação" doneLabel="Enviada para aprovação" icon={Send} className="mt-3" />
      </UiCard>
      <EventStack x={680} y={150} width={256} title="Workflow de aprovação" items={approvals} shown={phase} reduced={reduced} />
      <Caption when="Dia 1 · Seg 07/09 · 08:40" where="Vale Verde Alimentos · Sorocaba" />
    </>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Cenário: a fábrica de alimentos, em três profundidades.
 * ---------------------------------------------------------------------------------------------- */

const BOXES = [0, 120, 240, 360, 480, 600, 720]

function Factory({ far, mid, reduced }: { far: MotionValue<number>; mid: MotionValue<number>; reduced: boolean }) {
  const steel = useSteel()
  return (
    <Backdrop>
      {steel.defs}
      <defs>
        <clipPath id="e01-belt">
          <rect x="392" y="296" width="568" height="30" />
        </clipPath>
      </defs>
      <Room />

      {/* fundo: janelas altas, tubulação e a placa da linha (paralaxe lenta) */}
      <m.g style={{ x: far }}>
        <WindowRow />
        <rect x="0" y="24" width="960" height="7" rx="3.5" fill="#D3CDDE" />
        <rect x="0" y="36" width="960" height="3" rx="1.5" fill="#DDD8E6" />
        {[120, 330, 560, 800].map((x) => (
          <rect key={x} x={x - 5} y="20" width="10" height="15" rx="2" fill="#C3BBD2" />
        ))}
        <FarBlock x={640} y={150} w={300} h={150} />
        <Sign x={756} y={60} title="LINHA 2" subtitle="EMBALAGEM" />
      </m.g>

      {/* meio: a linha de embalagem em inox, a esteira andando e as pessoas de touca (paralaxe média) */}
      <m.g style={{ x: mid }}>
        <People
          spots={[
            { x: 470, y: 224, h: 112 },
            { x: 700, y: 232, h: 104, w: 44 },
            { x: 880, y: 228, h: 108 },
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
        <g clipPath="url(#e01-belt)">
          <m.g animate={reduced ? undefined : { x: [0, -120] }} transition={{ duration: 2.6, ease: 'linear', repeat: Infinity }}>
            {BOXES.map((x) => (
              <g key={x}>
                <rect x={400 + x} y="300" width="70" height="22" rx="4" fill="#F1E9F5" stroke="#D7C7E3" />
                <rect x={412 + x} y="306" width="22" height="10" rx="2" fill="#C95788" />
              </g>
            ))}
          </m.g>
        </g>
        {[430, 620, 810].map((x) => (
          <g key={x}>
            <rect x={x} y="336" width="14" height="60" rx="3" fill="#B9B1C8" />
            <rect x={x + 100} y="336" width="14" height="60" rx="3" fill="#B9B1C8" />
          </g>
        ))}
        <ellipse cx="670" cy="404" rx="300" ry="10" fill="#1B1238" fillOpacity="0.08" />
      </m.g>

      <SafetyStripe />
    </Backdrop>
  )
}
