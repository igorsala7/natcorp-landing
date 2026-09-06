import { m, type MotionValue } from 'motion/react'
import { Clock3, MapPinCheck, ScanFace, Send } from 'lucide-react'
import { NatPontoPhone, type NatPontoScreen } from '@/components/mockups/natponto/screens'
import { NATPONTO_SIZE } from '@/components/mockups/natponto/NatPontoFrame'
import { EASE } from '@/lib/motion'
import { SceneStage, type StageContext } from './SceneStage'
import { useScenePhases, useSteel } from './hooks'
import { ActionButton, Backdrop, Caption, EventStack, Field, Figure, People, Ping, Room, Sign, UiCard, type SceneEvent } from './parts'

/**
 * Etapa 16, "Na portaria, o rosto e o lugar": às 06:21, Ana abre o NatPonto pela primeira vez na portaria da
 * Vale Verde. Cenário da recepção ao amanhecer em SVG (portas de vidro, balcão, catraca), a figura 3D da Ana
 * com o celular, o app NatPonto reconhecendo o rosto e a marcação chegando ao Ponto Eletrônico.
 */
export function Etapa16Scene() {
  return (
    <SceneStage label="Às 06:21, na portaria da Vale Verde, Ana Ribeiro abre o NatPonto pela primeira vez: o app reconhece o rosto dela, confirma que está dentro do raio da unidade e registra a entrada. Em segundos a marcação está no Ponto Eletrônico, pronta para a apuração da jornada das 06:30 às 15:48.">
      {(ctx) => <Composition {...ctx} />}
    </SceneStage>
  )
}

/* Fases: 0 nada, 1 app aberto, 2 rosto reconhecido, 3 dentro do raio, 4 marcação registrada, 5 no Ponto Eletrônico, 6 folha. */
const PHASES = [0, 400, 1500, 2300, 3200, 4000, 4800]

const events: SceneEvent[] = [
  { phase: 2, icon: ScanFace, name: 'Rosto reconhecido', role: 'Reconhecimento facial', text: 'Primeiro acesso ao app.' },
  { phase: 3, icon: MapPinCheck, name: 'Dentro do raio da unidade', role: 'Geolocalização', text: 'Raio por unidade. Funciona sem internet e sincroniza depois.', tone: 'green' },
  { phase: 6, icon: Send, name: 'Eventos para a folha', role: 'Ponto Eletrônico', text: 'A apuração aplica escala, tolerâncias e regras do sindicato.', tone: 'pink' },
]

const PHONE_SCALE = 0.42

function Composition({ reduced, on, far, mid, near }: StageContext) {
  const phase = useScenePhases(on, reduced, PHASES)
  const screen: NatPontoScreen = phase >= 4 ? 'success' : 'face'
  return (
    <>
      <Lobby far={far} mid={mid} />
      <Figure who="ana" x={64} y={58} height={470} on={on} reduced={reduced} near={near} />
      <Phone x={208} y={96} screen={screen} on={on && phase >= 1} reduced={reduced} />
      <Ping x={275} y={232} active={phase === 4} reduced={reduced} />
      <UiCard x={356} y={84} width={270} product="Ponto Eletrônico" tag="Apuração" on={on} reduced={reduced} delay={0.7}>
        <p className="mt-2.5 text-[15px] font-extrabold leading-snug text-brand-ink">Marcação de entrada</p>
        <p className="mt-0.5 text-[10.5px] font-semibold text-brand-graphite">Ana Ribeiro · Supervisora de Produção</p>
        <div className="mt-3 space-y-2">
          <Field label="Entrada" value={phase >= 5 ? '06:21 · Seg 28/09' : 'Aguardando o NatPonto'} tone={phase >= 5 ? 'ok' : 'default'} />
          <Field label="Origem · NatPonto" value="Facial e geolocalização" tone={phase >= 5 ? 'ok' : 'default'} />
          <Field label="Comprovante" value="Código de verificação" tone={phase >= 5 ? 'ok' : 'default'} />
          <Field label="Jornada" value="06:30 às 15:48" icon={Clock3} />
        </div>
        <ActionButton done={phase >= 5} idleLabel="Aguardando marcação" doneLabel="Recebida em tempo real" icon={Clock3} className="mt-3" />
      </UiCard>
      <EventStack x={680} y={52} width={256} title="Em tempo real" items={events} shown={phase} reduced={reduced} />
      <Caption when="Dia 22 · Seg 28/09 · 06:21" where="Portaria · Vale Verde Alimentos" />
    </>
  )
}

/** O celular da Ana com o app NatPonto, desenhado em 320 × 690 e reduzido para caber no palco. */
function Phone({ x, y, screen, on, reduced }: { x: number; y: number; screen: NatPontoScreen; on: boolean; reduced: boolean }) {
  return (
    <m.div
      className="absolute"
      style={{ left: x, top: y, width: NATPONTO_SIZE.width * PHONE_SCALE, height: NATPONTO_SIZE.height * PHONE_SCALE }}
      initial={reduced ? false : { opacity: 0, y: 24 }}
      animate={on ? { opacity: 1, y: 0 } : undefined}
      transition={{ duration: 0.7, ease: EASE }}
    >
      <div style={{ width: NATPONTO_SIZE.width, height: NATPONTO_SIZE.height, transform: `scale(${PHONE_SCALE})`, transformOrigin: 'top left' }}>
        <NatPontoPhone screen={screen} />
      </div>
    </m.div>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Cenário: a portaria da fábrica ao amanhecer.
 * ---------------------------------------------------------------------------------------------- */

function Lobby({ far, mid }: { far: MotionValue<number>; mid: MotionValue<number> }) {
  const steel = useSteel()
  return (
    <Backdrop>
      {steel.defs}
      <defs>
        <linearGradient id="e16-dawn" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#FBE3EC" />
          <stop offset="0.55" stopColor="#EDD5EA" />
          <stop offset="1" stopColor="#CDBBE9" />
        </linearGradient>
        <radialGradient id="e16-sun" cx="0.5" cy="0.5" r="0.5">
          <stop offset="0" stopColor="#FFFFFF" stopOpacity="0.95" />
          <stop offset="0.4" stopColor="#FFF0F5" stopOpacity="0.7" />
          <stop offset="1" stopColor="#FFD6E4" stopOpacity="0" />
        </radialGradient>
        <linearGradient id="e16-spill" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#F4C6DA" stopOpacity="0.4" />
          <stop offset="1" stopColor="#F4C6DA" stopOpacity="0" />
        </linearGradient>
      </defs>
      <Room wall={['#F4F1F8', '#E7E2EE']} floor={['#E4DFEC', '#F4F2F7']} />

      {/* fundo: a parede de vidro com o amanhecer lá fora */}
      <m.g style={{ x: far }}>
        <rect x="0" y="34" width="480" height="302" fill="url(#e16-dawn)" />
        <circle cx="52" cy="232" r="72" fill="url(#e16-sun)" />
        <circle cx="52" cy="232" r="22" fill="#FFFFFF" fillOpacity="0.9" />
        <ellipse cx="120" cy="108" rx="62" ry="10" fill="#FFFFFF" fillOpacity="0.5" />
        <ellipse cx="410" cy="152" rx="46" ry="8" fill="#FFFFFF" fillOpacity="0.45" />
        {/* a silhueta da fábrica e das árvores, do lado de fora */}
        <g fill="#B4A3D6" fillOpacity="0.55">
          <rect x="0" y="288" width="480" height="48" />
          <rect x="24" y="262" width="96" height="30" rx="3" />
          <rect x="58" y="228" width="12" height="40" />
          <rect x="140" y="272" width="120" height="20" rx="3" />
          <circle cx="292" cy="280" r="14" />
          <circle cx="322" cy="284" r="11" />
          <rect x="372" y="266" width="86" height="26" rx="3" />
        </g>
        {/* caixilhos e as portas de vidro no vão do meio */}
        <rect x="0" y="34" width="480" height="302" fill="none" stroke="#B9B1C8" strokeWidth="6" />
        <line x1="160" y1="34" x2="160" y2="336" stroke="#B9B1C8" strokeWidth="6" />
        <line x1="320" y1="34" x2="320" y2="336" stroke="#B9B1C8" strokeWidth="6" />
        <line x1="0" y1="124" x2="480" y2="124" stroke="#B9B1C8" strokeWidth="4" />
        <line x1="240" y1="124" x2="240" y2="336" stroke="#B9B1C8" strokeWidth="4" />
        <rect x="226" y="208" width="5" height="40" rx="2.5" fill="#511C76" />
        <rect x="249" y="208" width="5" height="40" rx="2.5" fill="#511C76" />
        <rect x="0" y="22" width="480" height="14" fill="#C7C0D5" />
        <rect x="0" y="336" width="480" height="4" fill="#B9B1C8" />
      </m.g>

      {/* meio: a luz entrando pelo chão, o tapete, a catraca e o balcão da recepção com o guarda */}
      <m.g style={{ x: mid }}>
        <polygon points="160,338 320,338 400,440 60,440" fill="url(#e16-spill)" />
        <rect x="150" y="348" width="180" height="24" rx="6" fill="#4A4460" fillOpacity="0.16" />

        <g>
          <ellipse cx="534" cy="518" rx="110" ry="6" fill="#1B1238" fillOpacity="0.08" />
          <rect x="474" y="470" width="58" height="36" rx="5" fill="#FFFFFF" fillOpacity="0.55" stroke="#C7C0D5" />
          <rect x="536" y="470" width="58" height="36" rx="5" fill="#FFFFFF" fillOpacity="0.55" stroke="#C7C0D5" />
          <rect x="436" y="460" width="36" height="56" rx="6" fill={steel.fill} stroke="#A89FBA" />
          <rect x="596" y="460" width="36" height="56" rx="6" fill={steel.fill} stroke="#A89FBA" />
          <rect x="443" y="466" width="22" height="8" rx="3" fill="#511C76" />
          <rect x="603" y="466" width="22" height="8" rx="3" fill="#511C76" />
          <circle cx="454" cy="470" r="2" fill="#34D399" />
          <circle cx="614" cy="470" r="2" fill="#34D399" />
        </g>

        <People spots={[{ x: 776, y: 336, w: 48, h: 80 }]} coat="#3F3A57" hair="#2A2540" />
        <g>
          <ellipse cx="812" cy="494" rx="140" ry="7" fill="#1B1238" fillOpacity="0.08" />
          <rect x="880" y="372" width="34" height="24" rx="3" fill="#4A4460" />
          <rect x="884" y="376" width="26" height="16" rx="2" fill="#9A408A" fillOpacity="0.6" />
          <rect x="894" y="396" width="6" height="6" fill="#4A4460" />
          <rect x="686" y="410" width="252" height="76" rx="6" fill="#FFFFFF" stroke="#D7D0E2" />
          <rect x="680" y="398" width="264" height="14" rx="5" fill={steel.fill} stroke="#A89FBA" />
          <Sign x={724} y={418} w={176} h={60} title="VALE VERDE" subtitle="ALIMENTOS" />
        </g>
      </m.g>
    </Backdrop>
  )
}
