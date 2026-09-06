import { m, type MotionValue } from 'motion/react'
import { BadgeCheck, Check } from 'lucide-react'
import { EASE } from '@/lib/motion'
import { SceneStage, STAGE_H, STAGE_W, type StageContext } from './SceneStage'
import { useScenePhases } from './hooks'
import { ActionButton, Backdrop, Caption, FarBlock, Field, Figure, People, Ping, Room, Sign, UiCard, WindowRow } from './parts'

/**
 * Etapa 13, "Código, data, confirmar. Ana faz parte da empresa.": Beatriz informa o código da candidata
 * e a data de admissão na Admissão Digital e confirma. Uma única confirmação atualiza folha, ponto,
 * benefícios, eSocial, headcount, portais e os outros sistemas ao mesmo tempo: os módulos aparecem em
 * leque ao lado do card, ligados a ele por linhas que se desenham. Escritório do RH em SVG, com a luz da
 * manhã, e a figura 3D da Beatriz.
 */
export function Etapa13Scene() {
  return (
    <SceneStage label="Beatriz Lima, analista de admissão, no escritório do RH da Vale Verde pela manhã, abre a Admissão Digital, informa o código de candidata de Ana Ribeiro e a data de admissão, 28 de setembro, e confirma. A matrícula é gerada e uma única confirmação cria o cadastro em Folha de Pagamento, Ponto Eletrônico, Gestão de Benefícios, eSocial, headcount e Portais, e avisa catraca, ERP e e-mail corporativo. Ana faz parte da empresa.">
      {(ctx) => <Composition {...ctx} />}
    </SceneStage>
  )
}

/* Fases: 0 nada, 1 card da admissão, 2 código informado, 3 data informada, 4 confirmada (matrícula e integrações), 5 Ana faz parte da empresa. */
const PHASES = [0, 450, 1150, 1850, 2600, 3900]

/** Os sete lugares atualizados pela confirmação, em leque à direita do card. */
const PLACES = [
  { x: 690, y: 84, name: 'Folha de Pagamento', note: 'cadastro criado' },
  { x: 736, y: 136, name: 'Ponto Eletrônico', note: 'cadastro criado' },
  { x: 750, y: 188, name: 'Gestão de Benefícios', note: 'cadastro criado' },
  { x: 756, y: 240, name: 'eSocial', note: 'evento de admissão' },
  { x: 750, y: 292, name: 'Headcount', note: 'posição ocupada' },
  { x: 736, y: 344, name: 'Portais', note: 'cadastro criado' },
  { x: 690, y: 396, name: 'Outros sistemas', note: 'catraca, ERP e e-mail' },
]
const CHIP_H = 40
const HUB = { x: 622, y: 236 }
const STAGGER = 0.14

function Composition({ reduced, on, far, mid, near }: StageContext) {
  const phase = useScenePhases(on, reduced, PHASES)
  const confirmed = phase >= 4
  return (
    <>
      <HrOffice far={far} mid={mid} />
      <Links active={confirmed} reduced={reduced} />
      <Figure who="beatriz" x={40} y={58} height={470} on={on} reduced={reduced} near={near} />
      <Ping x={142} y={224} active={phase === 4} reduced={reduced} />
      <UiCard x={330} y={54} width={292} product="Admissão Digital" tag="Efetivação" on={on} reduced={reduced}>
        <p className="mt-2.5 text-[15px] font-extrabold leading-snug text-brand-ink">Efetivar a admissão</p>
        <p className="text-[11.5px] font-semibold text-brand-graphite">Código, data, confirmar. Só isso.</p>
        <div className="mt-3 space-y-2">
          <Field label="Código da candidata" value={phase >= 2 ? '4172 · Ana Ribeiro' : 'Informar'} tone={phase >= 2 ? 'ok' : 'default'} />
          <Field label="Data de admissão" value={phase >= 3 ? '28/09/2026 · segunda-feira' : 'Informar'} tone={phase >= 3 ? 'ok' : 'default'} />
          <Field label="Cargo" value="Supervisora de Produção · Linha 2" />
          <Field label="Matrícula" value={confirmed ? 'Gerada automaticamente' : 'Gerada na confirmação'} tone={confirmed ? 'ok' : 'default'} />
        </div>
        <ActionButton done={confirmed} idleLabel="Confirmar efetivação" doneLabel="Admissão efetivada" icon={BadgeCheck} className="mt-3" />
        <p className="mt-2 text-center text-[10.5px] font-semibold leading-snug text-brand-graphite">Nenhum dado digitado de novo: tudo veio do processo seletivo, do portal, dos benefícios e do exame.</p>
      </UiCard>

      <p className="absolute text-[10px] font-bold uppercase tracking-[0.16em] text-brand-graphite" style={{ left: 690, top: 58 }}>
        Uma confirmação, sete lugares
      </p>
      {PLACES.map((p, i) => (
        <Chip key={p.name} {...p} index={i} shown={confirmed} reduced={reduced} />
      ))}

      <m.div
        className="absolute flex items-center gap-2.5 rounded-xl border border-brand-mist bg-white/95 p-2.5 shadow-soft backdrop-blur"
        style={{ left: 684, top: 456, width: 252 }}
        initial={reduced ? false : { opacity: 0, y: 12 }}
        animate={phase >= 5 ? { opacity: 1, y: 0 } : undefined}
        transition={{ duration: 0.5, ease: EASE }}
      >
        <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-brand-plum text-[10px] font-extrabold text-white">AR</span>
        <span className="min-w-0">
          <span className="block text-[12px] font-bold leading-tight text-brand-ink">Ana faz parte da empresa</span>
          <span className="block text-[10px] font-semibold uppercase tracking-[0.1em] text-brand-graphite">Admissão em 28/09 · Sorocaba</span>
        </span>
      </m.div>

      <Caption when="Dia 16 · Ter 22/09 · 09:40" where="RH · Vale Verde Alimentos" />
    </>
  )
}

/* ------------------------------------------------------------------------------------------------
 * A explosão de integrações: linhas que se desenham do card até cada módulo, e os módulos em leque.
 * ---------------------------------------------------------------------------------------------- */

function linkPath(x: number, y: number) {
  const ty = y + CHIP_H / 2
  const cx = HUB.x + (x - HUB.x) * 0.55
  return `M${HUB.x} ${HUB.y} C ${cx} ${HUB.y}, ${cx} ${ty}, ${x} ${ty}`
}

function Links({ active, reduced }: { active: boolean; reduced: boolean }) {
  return (
    <svg viewBox={`0 0 ${STAGE_W} ${STAGE_H}`} width={STAGE_W} height={STAGE_H} className="pointer-events-none absolute inset-0" aria-hidden focusable="false">
      {PLACES.map((p, i) =>
        reduced ? (
          <path key={p.name} d={linkPath(p.x, p.y)} fill="none" stroke="#C95788" strokeWidth="2" strokeLinecap="round" />
        ) : (
          <m.path
            key={p.name}
            d={linkPath(p.x, p.y)}
            fill="none"
            stroke="#C95788"
            strokeWidth="2"
            strokeLinecap="round"
            initial={{ pathLength: 0, opacity: 0 }}
            animate={active ? { pathLength: 1, opacity: 1 } : undefined}
            transition={{ duration: 0.55, ease: 'easeOut', delay: i * STAGGER }}
          />
        ),
      )}
      <m.circle cx={HUB.x} cy={HUB.y} r="6" fill="#C95788" stroke="#FFFFFF" strokeWidth="2" initial={reduced ? false : { opacity: 0 }} animate={active ? { opacity: 1 } : undefined} transition={{ duration: 0.4, ease: EASE }} />
    </svg>
  )
}

function Chip({ x, y, name, note, index, shown, reduced }: { x: number; y: number; name: string; note: string; index: number; shown: boolean; reduced: boolean }) {
  return (
    <m.div
      className="absolute flex items-center gap-2 rounded-full border border-brand-mist bg-white/95 py-1.5 pl-2 pr-3.5 shadow-soft backdrop-blur"
      style={{ left: x, top: y, height: CHIP_H }}
      initial={reduced ? false : { opacity: 0, scale: 0.6, x: -14 }}
      animate={shown ? { opacity: 1, scale: 1, x: 0 } : undefined}
      transition={{ duration: 0.45, ease: EASE, delay: reduced ? 0 : 0.25 + index * STAGGER }}
    >
      <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-emerald-500 text-white">
        <Check className="h-3 w-3" strokeWidth={3.5} aria-hidden />
      </span>
      <span className="whitespace-nowrap">
        <span className="block text-[11.5px] font-bold leading-tight text-brand-ink">{name}</span>
        <span className="block text-[9.5px] font-semibold uppercase tracking-[0.1em] text-brand-graphite">{note}</span>
      </span>
    </m.div>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Cenário: o escritório do RH pela manhã, com a parede de vidro para a fábrica, em duas profundidades.
 * ---------------------------------------------------------------------------------------------- */

const PANELS = [180, 460, 740]
const PANEL_Y = 84
const PANEL_W = 190
const PANEL_H = 166

function HrOffice({ far, mid }: { far: MotionValue<number>; mid: MotionValue<number> }) {
  return (
    <Backdrop>
      <defs>
        <clipPath id="e13-glass">
          {PANELS.map((x) => (
            <rect key={x} x={x} y={PANEL_Y} width={PANEL_W} height={PANEL_H} rx="6" />
          ))}
        </clipPath>
        <linearGradient id="e13-reflex" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#FFFFFF" stopOpacity="0.5" />
          <stop offset="0.5" stopColor="#FFFFFF" stopOpacity="0.05" />
          <stop offset="1" stopColor="#FFFFFF" stopOpacity="0.3" />
        </linearGradient>
        <radialGradient id="e13-sun" cx="0.5" cy="0.5" r="0.5">
          <stop offset="0" stopColor="#F9D28C" stopOpacity="0.32" />
          <stop offset="1" stopColor="#F9D28C" stopOpacity="0" />
        </radialGradient>
        <linearGradient id="e13-screen" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#2C1A63" />
          <stop offset="1" stopColor="#511C76" />
        </linearGradient>
        <linearGradient id="e13-desk" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#F4F2F7" />
          <stop offset="1" stopColor="#DDD6E7" />
        </linearGradient>
      </defs>
      <Room wall={['#FBF8FC', '#E9E3F1']} floor={['#E8E3EF', '#F6F4F9']} />
      <circle cx="120" cy="0" r="520" fill="url(#e13-sun)" />

      {/* fundo: a parede de vidro com a fábrica desfocada atrás e a placa da Admissão (paralaxe lenta) */}
      <m.g style={{ x: far }}>
        <WindowRow xs={PANELS} y={PANEL_Y} w={PANEL_W} h={PANEL_H} />
        <g clipPath="url(#e13-glass)">
          <rect x="160" y="156" width="800" height="96" fill="#DDD6E7" />
          <FarBlock x={196} y={172} w={150} h={80} rows={2} />
          <FarBlock x={500} y={166} w={120} h={86} rows={2} />
          <FarBlock x={790} y={170} w={130} h={82} rows={2} />
          <People
            spots={[
              { x: 300, y: 160, h: 92, w: 38 },
              { x: 470, y: 156, h: 96, w: 40 },
              { x: 650, y: 162, h: 90, w: 38 },
              { x: 760, y: 154, h: 98, w: 40 },
            ]}
            blur={2.2}
          />
          {PANELS.map((x) => (
            <polygon key={x} points={`${x + 30},${PANEL_Y} ${x + 90},${PANEL_Y} ${x + 170},${PANEL_Y + PANEL_H} ${x + 110},${PANEL_Y + PANEL_H}`} fill="url(#e13-reflex)" />
          ))}
        </g>
        {PANELS.map((x) => (
          <g key={x}>
            <rect x={x} y={PANEL_Y} width={PANEL_W} height={PANEL_H} rx="6" fill="none" stroke="#C9C0D8" strokeWidth="3" />
            <line x1={x + PANEL_W / 2} y1={PANEL_Y} x2={x + PANEL_W / 2} y2={PANEL_Y + PANEL_H} stroke="#C9C0D8" strokeWidth="3" />
          </g>
        ))}
        <rect x="164" y={PANEL_Y + PANEL_H} width="782" height="8" rx="3" fill="#C9C0D8" />
        <Sign x={198} y={12} w={126} title="RH" subtitle="ADMISSÃO" />
      </m.g>

      {/* meio: a mesa com o monitor e a caneca, a cadeira, o rodapé e a planta (paralaxe média) */}
      <m.g style={{ x: mid }}>
        <rect x="0" y="330" width="960" height="6" fill="#D9D2E3" />
        <ellipse cx="250" cy="402" rx="86" ry="8" fill="#1B1238" fillOpacity="0.08" />
        <rect x="196" y="250" width="48" height="60" rx="12" fill="#C95788" fillOpacity="0.35" />
        <rect x="184" y="292" width="140" height="12" rx="4" fill="url(#e13-desk)" stroke="#CFC6DC" />
        <rect x="192" y="304" width="8" height="92" rx="3" fill="#B9B1C8" />
        <rect x="308" y="304" width="8" height="92" rx="3" fill="#B9B1C8" />
        <rect x="248" y="272" width="12" height="20" fill="#4A4460" />
        <rect x="236" y="286" width="36" height="6" rx="3" fill="#4A4460" />
        <rect x="216" y="220" width="76" height="54" rx="6" fill="#4A4460" />
        <rect x="220" y="224" width="68" height="46" rx="4" fill="url(#e13-screen)" />
        <rect x="226" y="232" width="28" height="4" rx="2" fill="#FFFFFF" fillOpacity="0.7" />
        <rect x="226" y="240" width="56" height="3" rx="1.5" fill="#FFFFFF" fillOpacity="0.35" />
        <rect x="226" y="246" width="48" height="3" rx="1.5" fill="#FFFFFF" fillOpacity="0.35" />
        <rect x="226" y="252" width="52" height="3" rx="1.5" fill="#FFFFFF" fillOpacity="0.35" />
        <rect x="226" y="260" width="22" height="4" rx="2" fill="#C95788" />
        <rect x="298" y="276" width="14" height="16" rx="3" fill="#F4F2F7" stroke="#C9BFD9" />
        <path d="M312 280 a4 4 0 0 1 0 8" fill="none" stroke="#C9BFD9" strokeWidth="2" />

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
