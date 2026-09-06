import { m, type MotionValue } from 'motion/react'
import { Award, CalendarCheck, ShieldCheck, UserCheck } from 'lucide-react'
import { EASE } from '@/lib/motion'
import { SceneStage, type StageContext } from './SceneStage'
import { useScenePhases } from './hooks'
import { ActionButton, Backdrop, Caption, EventStack, Field, Figure, People, Ping, Room, UiCard, WindowRow, type SceneEvent } from './parts'

/**
 * Etapa 18, "A trilha do cargo já estava agendada": Ana entra na sala de treinamento às nove e a
 * matrícula na trilha de entrada já tinha sido feita pelo sistema na confirmação da admissão.
 * Sala clara com a tela na parede, fileiras de mesas e a instrutora ao fundo; o card de
 * Treinamento e Desenvolvimento registra presença, certificado e os próximos treinamentos.
 */
export function Etapa18Scene() {
  return (
    <SceneStage label="Ana Ribeiro entra na sala de treinamento da Vale Verde às nove da manhã, com o celular na mão. A matrícula na trilha de entrada do cargo foi feita pelo sistema quando a admissão foi confirmada: integração de segurança, uso e conservação de EPIs, boas práticas de fabricação e, nas próximas semanas, liderança de primeiro nível. O Treinamento e Desenvolvimento registra presença, carga horária, prova e certificado no perfil dela, e a validade das NRs passa a ser acompanhada pelo SESMT.">
      {(ctx) => <Composition {...ctx} />}
    </SceneStage>
  )
}

/* Fases: 0 nada, 1 card da trilha, 2 presença registrada, 3 certificado no perfil, 4 validade da NR, 5 próximos treinamentos. */
const PHASES = [0, 500, 1500, 2400, 3300, 4200]

const events: SceneEvent[] = [
  { phase: 3, icon: Award, name: 'Certificado registrado', role: 'Perfil da pessoa', text: 'Presença, carga horária, prova e certificado registrados.' },
  { phase: 4, icon: ShieldCheck, name: 'Validade da NR', role: 'SESMT · Segurança do Trabalho', text: 'Sem a habilitação em dia, a mudança de cargo fica pendente.', tone: 'pink' },
  { phase: 5, icon: CalendarCheck, name: 'Próximos treinamentos', role: 'Trilha de entrada', text: 'Boas práticas de fabricação e liderança de primeiro nível.', tone: 'green' },
]

function Composition({ reduced, on, far, mid, near }: StageContext) {
  const phase = useScenePhases(on, reduced, PHASES)
  const concluded = phase >= 3 ? 1 : 0
  const pct = phase >= 4 ? 37 : phase >= 3 ? 25 : phase >= 2 ? 12 : 0
  return (
    <>
      <TrainingRoom far={far} mid={mid} />
      <Figure who="ana" x={90} y={58} height={470} on={on} reduced={reduced} near={near} />
      <Ping x={207} y={182} active={phase === 2} reduced={reduced} />
      <UiCard x={300} y={40} width={330} product="Treinamento e Desenvolvimento" on={on} reduced={reduced}>
        <p className="mt-2.5 text-[15px] font-extrabold leading-snug text-brand-ink">Supervisora de Produção</p>
        <div className="mt-1 flex items-center justify-between gap-2">
          <p className="text-[10.5px] font-semibold text-brand-graphite">Matrícula automática na admissão</p>
          <span className="shrink-0 whitespace-nowrap rounded-full bg-brand-off-white px-2 py-0.5 text-[9.5px] font-semibold text-brand-graphite">Trilha do cargo</span>
        </div>
        <div className="mt-3 space-y-2">
          <Field
            label={phase >= 3 ? 'Concluído · certificado' : phase >= 2 ? 'Presença registrada' : 'Hoje · 09:00'}
            value="Integração de segurança"
            tone={phase >= 2 ? 'ok' : 'default'}
          />
          <Field label={phase >= 4 ? 'Presença registrada' : 'Trilha de entrada'} value="Uso e conservação de EPIs" tone={phase >= 4 ? 'ok' : 'default'} />
          <Field label="Agendado" value="Boas práticas de fabricação" />
          <Field label="Próximas semanas" value="Liderança de primeiro nível" />
        </div>
        <div className="mt-3">
          <div className="flex items-center justify-between text-[9.5px] font-semibold uppercase tracking-[0.12em] text-brand-graphite">
            <span>Trilha de entrada</span>
            <span>{concluded} de 4 concluídos</span>
          </div>
          <div className="mt-1.5 h-2 overflow-hidden rounded-full bg-brand-mist">
            <m.div
              className="h-full w-full rounded-full bg-brand-purple"
              initial={reduced ? false : { x: '-100%' }}
              animate={{ x: `${pct - 100}%` }}
              transition={{ duration: 0.8, ease: EASE }}
            />
          </div>
        </div>
        <ActionButton done={phase >= 2} idleLabel="Registrar presença" doneLabel="Presença registrada" icon={UserCheck} className="mt-3" />
      </UiCard>
      <EventStack x={670} y={180} width={270} title="Registrado no sistema" items={events} shown={phase} reduced={reduced} />
      <Caption when="Dia 22 · Seg 28/09 · 09:00" where="Sala de treinamento · Vale Verde Alimentos" />
    </>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Cenário: a sala de treinamento, clara, com a tela na parede e as fileiras de mesas.
 * ---------------------------------------------------------------------------------------------- */

function TrainingRoom({ far, mid }: { far: MotionValue<number>; mid: MotionValue<number> }) {
  return (
    <Backdrop>
      <defs>
        <linearGradient id="e18-slide" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#FFFFFF" />
          <stop offset="1" stopColor="#F1EDF6" />
        </linearGradient>
        <linearGradient id="e18-glow" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#FFFFFF" stopOpacity="0.6" />
          <stop offset="1" stopColor="#FFFFFF" stopOpacity="0" />
        </linearGradient>
      </defs>
      <Room />

      {/* fundo: janelas de um lado, luminárias e a tela com um slide abstrato (paralaxe lenta) */}
      <m.g style={{ x: far }}>
        <WindowRow xs={[24, 190]} />
        <rect x="0" y="16" width="960" height="5" rx="2.5" fill="#D3CDDE" />
        {[400, 600, 800].map((x) => (
          <rect key={x} x={x} y="24" width="110" height="7" rx="3.5" fill="#FFFFFF" stroke="#DDD8E6" />
        ))}

        <rect x="696" y="32" width="240" height="138" rx="10" fill="#1B1238" />
        <rect x="704" y="40" width="224" height="122" rx="6" fill="url(#e18-slide)" />
        <path d="M704 46a6 6 0 0 1 6-6h212a6 6 0 0 1 6 6v18H704z" fill="#511C76" />
        <rect x="716" y="50" width="80" height="8" rx="4" fill="#FFFFFF" fillOpacity="0.9" />
        <circle cx="914" cy="54" r="4" fill="#C95788" />
        {[76, 90, 104].map((y, i) => (
          <rect key={y} x="716" y={y} width={[112, 96, 76][i]} height="7" rx="3.5" fill="#D7D0E2" />
        ))}
        <circle cx="860" cy="92" r="12" fill="#C95788" fillOpacity="0.85" />
        <rect x="882" y="80" width="26" height="26" rx="7" fill="#9A408A" fillOpacity="0.8" />
        {[124, 138].map((y, i) => (
          <g key={y}>
            <circle cx="721" cy={y + 3.5} r="2.5" fill="#C95788" />
            <rect x="730" y={y} width={i === 0 ? 92 : 70} height="7" rx="3.5" fill="#E4DCEC" />
          </g>
        ))}
        <polygon points="880,150 894,126 908,150" fill="#511C76" fillOpacity="0.75" />
        <polygon points="704,170 928,170 960,336 672,336" fill="url(#e18-glow)" />
      </m.g>

      {/* meio: a instrutora perto da tela e as fileiras de mesas e cadeiras (paralaxe média) */}
      <m.g style={{ x: mid }}>
        <People spots={[{ x: 566, y: 214, h: 122 }]} hair="#3B2E4A" coat="#F1ECF6" />
        {[240, 400, 736].map((x) => (
          <Table key={x} x={x} y={286} w={128} legs={44} />
        ))}
        {[270, 470, 670].map((x) => (
          <Table key={x} x={x} y={356} w={150} legs={64} />
        ))}
        <ellipse cx="560" cy="430" rx="330" ry="9" fill="#1B1238" fillOpacity="0.06" />
      </m.g>
    </Backdrop>
  )
}

/** Uma mesa de treinamento com dois encostos de cadeira atrás. */
function Table({ x, y, w, legs }: { x: number; y: number; w: number; legs: number }) {
  const cw = Math.round(w * 0.24)
  return (
    <g>
      {[x + w * 0.16, x + w * 0.6].map((cx) => (
        <rect key={cx} x={cx} y={y - 22} width={cw} height="26" rx="7" fill="#CBC4D8" stroke="#B9B1C8" />
      ))}
      <rect x={x} y={y} width={w} height="9" rx="4" fill="#E6E1EE" stroke="#C9C2D6" />
      <rect x={x + 8} y={y + 9} width="6" height={legs} rx="2" fill="#B9B1C8" />
      <rect x={x + w - 14} y={y + 9} width="6" height={legs} rx="2" fill="#B9B1C8" />
    </g>
  )
}
