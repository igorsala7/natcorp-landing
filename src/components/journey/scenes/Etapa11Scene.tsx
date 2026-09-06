import { m, type MotionValue } from 'motion/react'
import { Check, FileCheck2, Send, ShieldCheck, Stethoscope } from 'lucide-react'
import { SceneStage, type StageContext } from './SceneStage'
import { useScenePhases, useSteel } from './hooks'
import { ActionButton, Backdrop, Caption, EventStack, Field, Figure, Ping, Room, Sign, UiCard, WindowRow, type SceneEvent } from './parts'

/**
 * Etapa 11, "O exame cai direto na agenda do médico": no ambulatório da fábrica, o Dr. Henrique registra o
 * exame admissional da Ana no módulo de Medicina Ocupacional. Cenário clínico em SVG (janela, relógio,
 * armário de medicamentos e a maca), as figuras 3D do médico e da Ana, e o card do exame com o ASO saindo
 * assinado e virando evento do eSocial.
 */
export function Etapa11Scene() {
  return (
    <SceneStage label="Dr. Henrique Sales, médico do trabalho, registra o exame admissional de Ana Ribeiro no ambulatório da Vale Verde: a guia veio do grupo de exposição da produção, ruído e umidade, com clínico e audiometria. O ASO sai com assinatura digital, apta, e gera o evento S-2220 para o eSocial.">
      {(ctx) => <Composition {...ctx} />}
    </SceneStage>
  )
}

/* Fases: 0 nada, 1 card do exame, 2 GHE conferido, 3 plano de exames, 4 ASO registrado, 5 eSocial. */
const PHASES = [0, 500, 1400, 2200, 3200, 4100]

const events: SceneEvent[] = [
  { phase: 2, icon: ShieldCheck, name: 'GHE da produção', role: 'Segurança do Trabalho', text: 'Ruído e umidade. O plano de exames vem do risco da função.' },
  { phase: 4, icon: FileCheck2, name: 'ASO assinado', role: 'Assinatura digital', text: 'Apta, com alerta de vencimento. Inapto não entra na folha.', tone: 'green' },
  { phase: 5, icon: Send, name: 'S-2220 gerado', role: 'eSocial', text: 'Evento de saúde gerado a partir do ASO.', tone: 'pink' },
]

function Composition({ reduced, on, far, mid, near }: StageContext) {
  const phase = useScenePhases(on, reduced, PHASES)
  return (
    <>
      <Clinic far={far} mid={mid} />
      <Figure who="henrique" x={28} y={58} height={470} on={on} reduced={reduced} near={near} />
      <Figure who="ana" x={496} y={98} height={430} flip from="right" delay={0.3} on={on} reduced={reduced} near={near} />
      <Ping x={140} y={262} active={phase === 4} reduced={reduced} />
      <UiCard x={224} y={52} width={254} product="Medicina Ocupacional" on={on} reduced={reduced}>
        <div className="mt-2.5 flex items-center justify-between gap-2">
          <p className="text-[15px] font-extrabold leading-snug text-brand-ink">Exame admissional</p>
          <span className="whitespace-nowrap rounded-full bg-brand-off-white px-2 py-0.5 text-[9.5px] font-semibold text-brand-graphite">Agenda</span>
        </div>
        <p className="mt-0.5 text-[10.5px] font-semibold text-brand-graphite">Dr. Henrique Sales · médico do trabalho</p>
        {/* o horário na agenda do médico */}
        <div className="mt-2.5 flex items-center gap-2.5 rounded-lg border border-brand-purple/20 bg-brand-purple/5 px-2.5 py-2">
          <span className="rounded-md bg-brand-purple px-2 py-1 text-[12.5px] font-extrabold tabular text-white">08:30</span>
          <span className="min-w-0">
            <span className="block truncate text-[12.5px] font-bold text-brand-ink">Ana Ribeiro</span>
            <span className="block truncate text-[10px] font-semibold text-brand-graphite">Supervisora de Produção</span>
          </span>
        </div>
        <p className="mt-1.5 flex items-center gap-1 text-[10px] font-semibold text-emerald-700">
          <Check className="h-3 w-3" strokeWidth={3} aria-hidden />
          Horário no Portal do Candidato
        </p>
        <div className="mt-2.5 space-y-2">
          <Field label="GHE · Produção" value="Ruído e umidade" tone={phase >= 2 ? 'ok' : 'default'} />
          <Field label="Plano de exames" value="Clínico e audiometria" tone={phase >= 3 ? 'ok' : 'default'} />
          <Field label="Resultado" value={phase >= 4 ? 'Apta' : 'Aguardando o exame'} tone={phase >= 4 ? 'ok' : 'default'} />
        </div>
        <ActionButton done={phase >= 4} idleLabel="Registrar ASO" doneLabel="ASO registrado" icon={Stethoscope} className="mt-3" />
      </UiCard>
      <EventStack x={680} y={72} width={256} title="Do GHE ao eSocial" items={events} shown={phase} reduced={reduced} />
      <Caption when="Dia 15 · Seg 21/09 · 08:30" where="Ambulatório · Vale Verde Alimentos" />
    </>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Cenário: o ambulatório da fábrica, em tons frios de clínica.
 * ---------------------------------------------------------------------------------------------- */

/* Ponteiros do relógio de parede às 08:30 (ângulo a partir do 12, sentido horário). */
const CLOCK = { cx: 648, cy: 86 }
const hand = (deg: number, r: number) => {
  const a = (deg * Math.PI) / 180
  return { x: CLOCK.cx + Math.sin(a) * r, y: CLOCK.cy - Math.cos(a) * r }
}
const HOUR = hand(255, 11)
const MINUTE = hand(180, 16)

/* Frascos e caixas nas prateleiras do armário: [x, largura, altura, cor]. */
const SHELF_ITEMS: [number, number, number, string][][] = [
  [
    [634, 8, 16, '#C95788'],
    [646, 10, 13, '#9A408A'],
    [660, 7, 16, '#E4A9C4'],
  ],
  [
    [634, 14, 10, '#D7D0E2'],
    [652, 8, 14, '#C95788'],
    [663, 6, 12, '#9A408A'],
  ],
  [
    [634, 9, 14, '#E4A9C4'],
    [647, 12, 9, '#D7D0E2'],
    [662, 7, 15, '#C95788'],
  ],
]

function Clinic({ far, mid }: { far: MotionValue<number>; mid: MotionValue<number> }) {
  const steel = useSteel()
  return (
    <Backdrop>
      {steel.defs}
      <defs>
        <linearGradient id="e11-glass" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#FFFFFF" stopOpacity="0.95" />
          <stop offset="1" stopColor="#E9E5F1" stopOpacity="0.7" />
        </linearGradient>
      </defs>
      <Room wall={['#F6F4FA', '#E6E3EE']} floor={['#E3DFEB', '#F4F2F7']} />

      {/* fundo: a janela atrás do médico, o friso da parede, o relógio, o armário de medicamentos e a placa */}
      <m.g style={{ x: far }}>
        <WindowRow xs={[18]} y={50} w={186} h={104} />
        <rect x="0" y="244" width="960" height="4" fill="#DAD4E4" />

        <g>
          <circle cx={CLOCK.cx} cy={CLOCK.cy} r="24" fill="#FFFFFF" stroke="#B9B1C8" strokeWidth="3" />
          {[0, 90, 180, 270].map((deg) => {
            const a = hand(deg, 19)
            const b = hand(deg, 15)
            return <line key={deg} x1={a.x} y1={a.y} x2={b.x} y2={b.y} stroke="#4A4460" strokeWidth="2" strokeLinecap="round" />
          })}
          <line x1={CLOCK.cx} y1={CLOCK.cy} x2={HOUR.x} y2={HOUR.y} stroke="#1B1238" strokeWidth="3" strokeLinecap="round" />
          <line x1={CLOCK.cx} y1={CLOCK.cy} x2={MINUTE.x} y2={MINUTE.y} stroke="#1B1238" strokeWidth="2" strokeLinecap="round" />
          <circle cx={CLOCK.cx} cy={CLOCK.cy} r="2.5" fill="#C95788" />
        </g>

        <g>
          <rect x="622" y="152" width="54" height="184" rx="6" fill="#EDE9F3" stroke="#CFC8DB" />
          <rect x="628" y="158" width="42" height="146" rx="4" fill="url(#e11-glass)" stroke="#D7D0E2" />
          {[200, 248, 296].map((y) => (
            <line key={y} x1="628" y1={y} x2="670" y2={y} stroke="#CFC8DB" strokeWidth="2" />
          ))}
          {SHELF_ITEMS.map((row, i) =>
            row.map(([x, w, h, color]) => <rect key={`${i}-${x}`} x={x} y={200 + i * 48 - h - 1} width={w} height={h} rx="2" fill={color} fillOpacity="0.8" />),
          )}
          <rect x="628" y="308" width="42" height="22" rx="3" fill="#D5CFE0" />
          <rect x="665" y="226" width="3" height="14" rx="1.5" fill="#9A408A" />
        </g>

        <Sign x={706} y={14} w={216} h={50} title="AMBULATÓRIO" />
      </m.g>

      {/* meio: o banquinho e a maca, no primeiro plano à direita */}
      <m.g style={{ x: mid }}>
        <g>
          <ellipse cx="655" cy="456" rx="16" ry="4" fill="#1B1238" fillOpacity="0.1" />
          <rect x="653" y="420" width="4" height="34" fill="#B9B1C8" />
          <ellipse cx="655" cy="452" rx="12" ry="4" fill="#B9B1C8" />
          <ellipse cx="655" cy="420" rx="20" ry="7" fill="#9A408A" fillOpacity="0.6" stroke="#8A3A7C" />
        </g>
        <g>
          <ellipse cx="815" cy="480" rx="140" ry="8" fill="#1B1238" fillOpacity="0.08" />
          <rect x="700" y="430" width="230" height="8" rx="3" fill={steel.fill} stroke="#A89FBA" />
          <rect x="712" y="438" width="10" height="34" rx="2" fill="#B9B1C8" />
          <rect x="908" y="438" width="10" height="34" rx="2" fill="#B9B1C8" />
          <circle cx="717" cy="474" r="6" fill="#4A4460" />
          <circle cx="913" cy="474" r="6" fill="#4A4460" />
          <rect x="692" y="398" width="246" height="34" rx="12" fill="#FFFFFF" stroke="#D7D0E2" />
          <rect x="780" y="402" width="150" height="6" rx="3" fill="#E9E5F1" />
          <rect x="702" y="388" width="66" height="26" rx="9" fill="#EFE8F7" stroke="#D7D0E2" />
        </g>
      </m.g>
    </Backdrop>
  )
}
