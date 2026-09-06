import { m, type MotionValue } from 'motion/react'
import { FileCheck2, MessageSquareWarning, ShieldCheck } from 'lucide-react'
import { cn } from '@/lib/utils'
import { SceneStage, type StageContext } from './SceneStage'
import { useScenePhases } from './hooks'
import { ActionButton, Backdrop, Caption, EventStack, FarBlock, Field, Figure, People, Ping, Room, Sign, UiCard, WindowRow } from './parts'

/**
 * Etapa 10, "Beatriz confere tudo em uma tela": no RH da Vale Verde, Beatriz abre a admissão da Ana no
 * GED e confere dados e documentos lado a lado. O comprovante de endereço volta como pendência pelo
 * portal e é refeito em seis minutos. Escritório em SVG (parede de vidro com a fábrica ao fundo, mesa com
 * o notebook, paralaxe), a figura 3D da Beatriz e o card do GED validando documento por documento.
 */
export function Etapa10Scene() {
  return (
    <SceneStage label="Beatriz Lima, analista de admissão, no escritório do RH da Vale Verde com a parede de vidro para a fábrica, confere a admissão de Ana Ribeiro no GED: RG e CPF, carteira de trabalho digital e a certidão do dependente são validados; o comprovante de endereço, ilegível, volta como pendência pelo portal com um comentário e Ana envia a nova foto em seis minutos. Documentos validados, com trilha de auditoria conforme a LGPD.">
      {(ctx) => <Composition {...ctx} />}
    </SceneStage>
  )
}

/* Fases: 0 nada, 1 card do GED, 2 RG e CPF, 3 endereço ilegível (pendência devolvida), 4 carteira e dependente, 5 endereço refeito, 6 validados, 7 auditoria. */
const PHASES = [0, 450, 1150, 1800, 2450, 3100, 3750, 4350]

const trail = [
  { phase: 3, icon: MessageSquareWarning, name: 'Portal do Candidato', role: 'Pendência devolvida', text: 'Comprovante ilegível. Comentário e prazo enviados para Ana.', tone: 'pink' as const },
  { phase: 5, initials: 'AR', name: 'Ana Ribeiro', role: 'No intervalo, pelo celular', text: 'Nova foto em seis minutos. O documento novo entra no lugar do antigo.' },
  { phase: 7, icon: ShieldCheck, name: 'GED', role: 'Trilha de auditoria', text: 'Quem viu e alterou o quê, com acesso por perfil, conforme a LGPD.', tone: 'green' as const },
]

function Composition({ reduced, on, far, mid, near }: StageContext) {
  const phase = useScenePhases(on, reduced, PHASES)
  const addressTone = phase >= 5 ? 'ok' : phase >= 3 ? 'warn' : 'default'
  const addressValue = phase >= 5 ? 'Nova foto recebida · 6 min' : phase >= 3 ? 'Ilegível · devolvido com comentário' : 'Aguardando conferência'
  const pending = phase >= 5 ? 0 : phase >= 4 ? 1 : phase >= 2 ? 3 : 4
  return (
    <>
      <HrOffice far={far} mid={mid} />
      <Figure who="beatriz" x={40} y={58} height={470} on={on} reduced={reduced} near={near} />
      <Ping x={142} y={224} active={phase === 6} reduced={reduced} />
      <UiCard x={330} y={54} width={292} product="GED" tag="Admissão Digital" on={on} reduced={reduced}>
        <p className="mt-2.5 text-[15px] font-extrabold leading-snug text-brand-ink">Admissão de Ana Ribeiro</p>
        <p className="text-[11.5px] font-semibold text-brand-graphite">Dados e documentos lado a lado</p>
        <div className="mt-3 space-y-2">
          <Field label="RG e CPF" value={phase >= 2 ? 'Conferidos com o cadastro' : 'Aguardando conferência'} tone={phase >= 2 ? 'ok' : 'default'} />
          <Field label="Comprovante de endereço" value={addressValue} tone={addressTone} icon={addressTone === 'warn' ? MessageSquareWarning : undefined} />
          <Field label="Carteira de trabalho digital" value={phase >= 4 ? 'Conferida' : 'Aguardando conferência'} tone={phase >= 4 ? 'ok' : 'default'} />
          <Field label="Dependente" value={phase >= 4 ? 'Certidão de nascimento conferida' : 'Aguardando conferência'} tone={phase >= 4 ? 'ok' : 'default'} />
        </div>
        <div className="mt-3 flex items-center justify-between rounded-lg bg-brand-off-white px-2.5 py-1.5">
          <span className="text-[10px] font-bold uppercase tracking-[0.14em] text-brand-graphite">Pendências</span>
          <span className={cn('rounded-full px-2 py-0.5 text-[11px] font-extrabold tabular-nums transition-colors duration-500', pending === 0 ? 'bg-emerald-700 text-white' : 'bg-brand-plum text-white')}>{pending}</span>
        </div>
        <ActionButton done={phase >= 6} idleLabel="Validar documentos" doneLabel="Documentos validados" icon={FileCheck2} className="mt-2.5" />
      </UiCard>
      <EventStack x={684} y={172} width={252} title="Pelo portal, com histórico" items={trail} shown={phase} reduced={reduced} />
      <Caption when="Dia 11 · Qui 17/09 · 09:20" where="RH · Vale Verde Alimentos" />
    </>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Cenário: o escritório do RH, com a parede de vidro para a fábrica, em duas profundidades.
 * ---------------------------------------------------------------------------------------------- */

const PANELS = [196, 400, 604, 808]
const PANEL_Y = 80
const PANEL_W = 150
const PANEL_H = 170

function HrOffice({ far, mid }: { far: MotionValue<number>; mid: MotionValue<number> }) {
  return (
    <Backdrop>
      <defs>
        <clipPath id="e10-glass">
          {PANELS.map((x) => (
            <rect key={x} x={x} y={PANEL_Y} width={PANEL_W} height={PANEL_H} rx="6" />
          ))}
        </clipPath>
        <linearGradient id="e10-reflex" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#FFFFFF" stopOpacity="0.45" />
          <stop offset="0.5" stopColor="#FFFFFF" stopOpacity="0.05" />
          <stop offset="1" stopColor="#FFFFFF" stopOpacity="0.3" />
        </linearGradient>
        <linearGradient id="e10-screen" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#2C1A63" />
          <stop offset="1" stopColor="#511C76" />
        </linearGradient>
        <linearGradient id="e10-desk" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#F4F2F7" />
          <stop offset="1" stopColor="#DDD6E7" />
        </linearGradient>
      </defs>
      <Room wall={['#F7F4FB', '#E7E1F0']} />

      {/* fundo: a parede de vidro com a fábrica desfocada atrás, a placa do RH e o relógio (paralaxe lenta) */}
      <m.g style={{ x: far }}>
        <WindowRow xs={PANELS} y={PANEL_Y} w={PANEL_W} h={PANEL_H} />
        <g clipPath="url(#e10-glass)">
          <rect x="180" y="150" width="800" height="100" fill="#DDD6E7" />
          <FarBlock x={196} y={168} w={130} h={82} rows={2} />
          <FarBlock x={430} y={160} w={120} h={90} rows={2} />
          <FarBlock x={820} y={166} w={140} h={84} rows={2} />
          <People
            spots={[
              { x: 300, y: 152, h: 98, w: 40 },
              { x: 560, y: 158, h: 92, w: 38 },
              { x: 640, y: 150, h: 100, w: 40 },
              { x: 760, y: 156, h: 94, w: 38 },
            ]}
            blur={2.2}
          />
          {PANELS.map((x) => (
            <polygon key={x} points={`${x + 20},${PANEL_Y} ${x + 70},${PANEL_Y} ${x + 130},${PANEL_Y + PANEL_H} ${x + 80},${PANEL_Y + PANEL_H}`} fill="url(#e10-reflex)" />
          ))}
        </g>
        {PANELS.map((x) => (
          <rect key={x} x={x} y={PANEL_Y} width={PANEL_W} height={PANEL_H} rx="6" fill="none" stroke="#C9C0D8" strokeWidth="3" />
        ))}
        <rect x="180" y={PANEL_Y + PANEL_H} width="790" height="8" rx="3" fill="#C9C0D8" />
        <Sign x={716} y={10} w={168} title="RH" subtitle="VALE VERDE" />
        <circle cx="476" cy="30" r="15" fill="#F4F2F7" stroke="#C9C0D8" strokeWidth="2" />
        <line x1="476" y1="30" x2="476" y2="20" stroke="#511C76" strokeWidth="2" strokeLinecap="round" />
        <line x1="476" y1="30" x2="467" y2="26" stroke="#511C76" strokeWidth="2" strokeLinecap="round" />
        <circle cx="476" cy="30" r="1.6" fill="#C95788" />
      </m.g>

      {/* meio: a mesa com o notebook, a cadeira, o rodapé e a planta (paralaxe média) */}
      <m.g style={{ x: mid }}>
        <rect x="0" y="330" width="960" height="6" fill="#D9D2E3" />
        <ellipse cx="256" cy="402" rx="90" ry="8" fill="#1B1238" fillOpacity="0.08" />
        <rect x="232" y="246" width="50" height="64" rx="12" fill="#9A408A" fillOpacity="0.4" />
        <rect x="188" y="292" width="136" height="12" rx="4" fill="url(#e10-desk)" stroke="#CFC6DC" />
        <rect x="196" y="304" width="8" height="92" rx="3" fill="#B9B1C8" />
        <rect x="308" y="304" width="8" height="92" rx="3" fill="#B9B1C8" />
        <rect x="228" y="236" width="72" height="52" rx="5" fill="#4A4460" />
        <rect x="232" y="240" width="64" height="44" rx="3" fill="url(#e10-screen)" />
        <rect x="238" y="248" width="30" height="4" rx="2" fill="#FFFFFF" fillOpacity="0.7" />
        <rect x="238" y="256" width="52" height="3" rx="1.5" fill="#FFFFFF" fillOpacity="0.35" />
        <rect x="238" y="262" width="44" height="3" rx="1.5" fill="#FFFFFF" fillOpacity="0.35" />
        <rect x="238" y="268" width="50" height="3" rx="1.5" fill="#FFFFFF" fillOpacity="0.35" />
        <rect x="238" y="276" width="20" height="4" rx="2" fill="#C95788" />
        <rect x="220" y="288" width="88" height="6" rx="3" fill="#B9B1C8" />
        <rect x="198" y="276" width="14" height="16" rx="3" fill="#F4F2F7" stroke="#C9BFD9" />
        <path d="M212 280 a4 4 0 0 1 0 8" fill="none" stroke="#C9BFD9" strokeWidth="2" />

        <rect x="632" y="346" width="48" height="10" rx="4" fill="#B4A8C7" />
        <rect x="636" y="352" width="40" height="46" rx="8" fill="#9A408A" fillOpacity="0.8" />
        <path d="M656 352 V 272" stroke="#5E9E74" strokeWidth="3" strokeLinecap="round" />
        <ellipse cx="640" cy="296" rx="24" ry="10" fill="#6FAE81" transform="rotate(-32 640 296)" />
        <ellipse cx="672" cy="304" rx="24" ry="10" fill="#5E9E74" transform="rotate(28 672 304)" />
        <ellipse cx="650" cy="266" rx="22" ry="9" fill="#5E9E74" transform="rotate(-70 650 266)" />
        <ellipse cx="668" cy="330" rx="20" ry="9" fill="#6FAE81" transform="rotate(20 668 330)" />
        <ellipse cx="642" cy="330" rx="20" ry="9" fill="#5E9E74" transform="rotate(-20 642 330)" />
        <ellipse cx="560" cy="418" rx="330" ry="12" fill="#1B1238" fillOpacity="0.05" />
      </m.g>
    </Backdrop>
  )
}
