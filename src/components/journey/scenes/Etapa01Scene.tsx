import { useEffect, useState } from 'react'
import { m, type MotionValue } from 'motion/react'
import { Check, Clock, MapPin, Send } from 'lucide-react'
import { Logo } from '@/components/brand/Logo'
import { figures } from '@/content/journeyArt'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { SceneStage, STAGE_H, STAGE_W, type StageContext } from './SceneStage'

/**
 * Etapa 1, "Uma linha nova, uma vaga nova": Marcos atravessa a fábrica e abre a Requisição de Vaga no
 * Portal do Gestor. A cena é montada por camadas: fábrica em SVG (paralaxe e esteira em movimento),
 * a figura 3D do Marcos e os cards da interface entrando em sequência, com as aprovações chegando.
 */
export function Etapa01Scene() {
  return (
    <SceneStage label="Marcos Tavares, gerente de produção, atravessa a fábrica da Vale Verde em Sorocaba e abre a Requisição de Vaga no Portal do Gestor: Supervisora de Produção para a Linha 2 de embalagem, com o salário dentro da faixa de Cargos e Salários. A Controladoria e a Diretoria aprovam pelo celular e a vaga nasce no headcount.">
      {(ctx) => <Composition {...ctx} />}
    </SceneStage>
  )
}

/* A sequência da cena, em fases: 0 nada, 1 card da requisição, 2 enviada, 3 Controladoria, 4 Diretoria, 5 headcount. */
const LAST_PHASE = 5
const PHASE_MS = [0, 500, 1500, 2300, 3100, 3900]

function Composition({ reduced, on, far, mid, near }: StageContext) {
  const [phase, setPhase] = useState(reduced ? LAST_PHASE : 0)

  useEffect(() => {
    if (!on || reduced) return
    const timers = PHASE_MS.map((ms, i) => window.setTimeout(() => setPhase(i), ms))
    return () => timers.forEach((t) => window.clearTimeout(t))
  }, [on, reduced])

  const shown = reduced ? LAST_PHASE : phase

  return (
    <>
      <Factory far={far} mid={mid} reduced={reduced} />
      <Character on={on} reduced={reduced} near={near} pinging={shown === 2} />
      <RequestCard on={on} reduced={reduced} sent={shown >= 2} />
      <Approvals shown={shown} reduced={reduced} />
      <Caption />
    </>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Cenário: a fábrica de alimentos, em três profundidades.
 * ---------------------------------------------------------------------------------------------- */

const BOXES = [0, 120, 240, 360, 480, 600, 720]

function Factory({ far, mid, reduced }: { far: MotionValue<number>; mid: MotionValue<number>; reduced: boolean }) {
  return (
    <svg viewBox={`0 0 ${STAGE_W} ${STAGE_H}`} width={STAGE_W} height={STAGE_H} className="absolute inset-0" aria-hidden focusable="false">
      <defs>
        <linearGradient id="e01-wall" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#F8F5FB" />
          <stop offset="1" stopColor="#E9E5F1" />
        </linearGradient>
        <linearGradient id="e01-floor" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#E6E1EE" />
          <stop offset="1" stopColor="#F4F2F7" />
        </linearGradient>
        <linearGradient id="e01-steel" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#DAD5E4" />
          <stop offset="0.5" stopColor="#C7C0D5" />
          <stop offset="1" stopColor="#B3ABC4" />
        </linearGradient>
        <linearGradient id="e01-window" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#FFFFFF" />
          <stop offset="1" stopColor="#EFE8F7" />
        </linearGradient>
        <linearGradient id="e01-beam" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#FFFFFF" stopOpacity="0.55" />
          <stop offset="1" stopColor="#FFFFFF" stopOpacity="0" />
        </linearGradient>
        <radialGradient id="e01-glow" cx="0.5" cy="0.5" r="0.5">
          <stop offset="0" stopColor="#C95788" stopOpacity="0.16" />
          <stop offset="1" stopColor="#C95788" stopOpacity="0" />
        </radialGradient>
        <filter id="e01-blur" x="-20%" y="-20%" width="140%" height="140%">
          <feGaussianBlur stdDeviation="1.6" />
        </filter>
        <filter id="e01-blur-far" x="-20%" y="-20%" width="140%" height="140%">
          <feGaussianBlur stdDeviation="2.6" />
        </filter>
        <clipPath id="e01-belt">
          <rect x="392" y="296" width="568" height="30" />
        </clipPath>
      </defs>

      {/* parede e piso */}
      <rect width={STAGE_W} height={STAGE_H} fill="url(#e01-wall)" />
      <rect y="336" width={STAGE_W} height={STAGE_H - 336} fill="url(#e01-floor)" />
      <ellipse cx="640" cy="360" rx="420" ry="120" fill="url(#e01-glow)" />

      {/* fundo: janelas altas, tubulação e a placa da linha (paralaxe lenta) */}
      <m.g style={{ x: far }}>
        {[40, 210, 380, 550, 720, 890].map((x) => (
          <g key={x}>
            <rect x={x} y="52" width="130" height="86" rx="6" fill="url(#e01-window)" stroke="#D7D0E2" />
            <line x1={x + 65} y1="52" x2={x + 65} y2="138" stroke="#D7D0E2" />
            <line x1={x} y1="95" x2={x + 130} y2="95" stroke="#D7D0E2" />
            <polygon points={`${x + 10},138 ${x + 120},138 ${x + 190},336 ${x - 60},336`} fill="url(#e01-beam)" />
          </g>
        ))}
        <rect x="0" y="24" width={STAGE_W} height="7" rx="3.5" fill="#D3CDDE" />
        <rect x="0" y="36" width={STAGE_W} height="3" rx="1.5" fill="#DDD8E6" />
        {[120, 330, 560, 800].map((x) => (
          <rect key={x} x={x - 5} y="20" width="10" height="15" rx="2" fill="#C3BBD2" />
        ))}
        <g filter="url(#e01-blur-far)">
          <rect x="640" y="150" width="300" height="150" rx="10" fill="#D5CFE0" />
          <rect x="655" y="165" width="270" height="18" rx="4" fill="#C7C0D5" />
          <rect x="655" y="195" width="270" height="18" rx="4" fill="#C7C0D5" />
          <rect x="655" y="225" width="270" height="18" rx="4" fill="#C7C0D5" />
        </g>
        <g>
          <rect x="756" y="60" width="176" height="64" rx="12" fill="#511C76" />
          <text x="844" y="88" textAnchor="middle" fontFamily="Manrope, sans-serif" fontWeight="800" fontSize="20" fill="#FFFFFF" letterSpacing="2">
            LINHA 2
          </text>
          <text x="844" y="110" textAnchor="middle" fontFamily="Manrope, sans-serif" fontWeight="600" fontSize="11" fill="#E4A9C4" letterSpacing="3">
            EMBALAGEM
          </text>
        </g>
      </m.g>

      {/* meio: a linha de embalagem em inox, a esteira andando e as pessoas de touca (paralaxe média) */}
      <m.g style={{ x: mid }}>
        <g filter="url(#e01-blur)">
          {[
            { x: 470, y: 224, h: 112, w: 46 },
            { x: 700, y: 232, h: 104, w: 44 },
            { x: 880, y: 228, h: 108, w: 46 },
          ].map((p) => (
            <g key={p.x}>
              <circle cx={p.x + p.w / 2} cy={p.y + 14} r="15" fill="#E6C9B4" />
              <path d={`M${p.x + p.w / 2 - 15} ${p.y + 12} a15 15 0 0 1 30 0 z`} fill="#FFFFFF" />
              <rect x={p.x} y={p.y + 30} width={p.w} height={p.h - 30} rx="12" fill="#FFFFFF" stroke="#DDD7E6" />
            </g>
          ))}
        </g>
        <rect x="380" y="250" width="580" height="86" rx="14" fill="url(#e01-steel)" stroke="#A89FBA" />
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

      {/* piso: linhas de fuga e a faixa de segurança */}
      {[0, 160, 320, 480, 640, 800, 960].map((x) => (
        <line key={x} x1={x} y1="336" x2={480 + (x - 480) * 2.2} y2={STAGE_H} stroke="#FFFFFF" strokeOpacity="0.5" />
      ))}
      <rect x="0" y="452" width={STAGE_W} height="6" fill="#E4A9C4" fillOpacity="0.45" />
    </svg>
  )
}

/* ------------------------------------------------------------------------------------------------
 * O Marcos: a figura 3D recortada, entrando pela esquerda e respirando devagar.
 * ---------------------------------------------------------------------------------------------- */

function Character({ on, reduced, near, pinging }: { on: boolean; reduced: boolean; near: MotionValue<number>; pinging: boolean }) {
  const src = figures.marcos
  if (!src) return null
  return (
    <m.div className="absolute left-[64px] top-[58px]" style={{ y: near }}>
      <m.div
        initial={reduced ? false : { opacity: 0, x: -48 }}
        animate={on ? { opacity: 1, x: 0 } : undefined}
        transition={{ duration: 0.8, ease: EASE, delay: 0.1 }}
      >
        <m.div animate={reduced ? undefined : { y: [0, -4, 0] }} transition={{ duration: 4.6, ease: 'easeInOut', repeat: Infinity }}>
          <img src={src} alt="" width={196} height={470} className="block h-[470px] w-auto drop-shadow-[0_14px_18px_rgba(27,18,56,0.22)]" draggable={false} />
        </m.div>
      </m.div>
      {/* sombra no chão */}
      <span className="absolute -bottom-2 left-1/2 h-4 w-[170px] -translate-x-1/2 rounded-full bg-brand-ink/15 blur-[6px]" />
      {/* o toque no tablet: um pulso rosa quando a requisição é enviada */}
      <span className="absolute left-[128px] top-[214px]">
        {pinging && !reduced && (
          <>
            <m.span className="absolute -left-4 -top-4 h-8 w-8 rounded-full border-2 border-brand-pink" initial={{ scale: 0.4, opacity: 0.9 }} animate={{ scale: 2.4, opacity: 0 }} transition={{ duration: 0.9, ease: 'easeOut' }} />
            <m.span className="absolute -left-4 -top-4 h-8 w-8 rounded-full border-2 border-brand-pink" initial={{ scale: 0.4, opacity: 0.9 }} animate={{ scale: 2.4, opacity: 0 }} transition={{ duration: 0.9, ease: 'easeOut', delay: 0.25 }} />
          </>
        )}
      </span>
    </m.div>
  )
}

/* ------------------------------------------------------------------------------------------------
 * A interface: o card da Requisição de Vaga e as aprovações chegando.
 * ---------------------------------------------------------------------------------------------- */

const fields = [
  { label: 'Cargo', value: 'Supervisora de Produção' },
  { label: 'Centro de custo', value: 'Embalagem · Linha 2 · Sorocaba' },
  { label: 'Motivo', value: 'Aumento de quadro' },
]

function RequestCard({ on, reduced, sent }: { on: boolean; reduced: boolean; sent: boolean }) {
  return (
    <m.div
      className="absolute left-[330px] top-[54px] w-[292px] rounded-2xl border border-brand-mist bg-white p-4 shadow-lift"
      initial={reduced ? false : { opacity: 0, y: 18, scale: 0.96 }}
      animate={on ? { opacity: 1, y: 0, scale: 1 } : undefined}
      transition={{ duration: 0.6, ease: EASE, delay: 0.5 }}
    >
      <m.div animate={reduced ? undefined : { y: [0, -3, 0] }} transition={{ duration: 5.2, ease: 'easeInOut', repeat: Infinity, delay: 1 }}>
        <div className="flex items-center justify-between">
          <span className="flex items-center gap-2 text-[11px] font-bold uppercase tracking-[0.14em] text-brand-purple">
            <Logo variant="symbol" tone="flat" decorative className="h-3.5 w-3.5" />
            Portal do Gestor
          </span>
          <span className="whitespace-nowrap rounded-full bg-brand-off-white px-2 py-0.5 text-[9.5px] font-semibold text-brand-graphite">Requisição de Vaga</span>
        </div>
        <p className="mt-2.5 text-[15px] font-extrabold leading-snug text-brand-ink">Nova vaga para a Linha 2</p>
        <dl className="mt-3 space-y-2">
          {fields.map((f) => (
            <div key={f.label} className="rounded-lg border border-brand-mist bg-brand-off-white/70 px-2.5 py-1.5">
              <dt className="text-[9.5px] font-semibold uppercase tracking-[0.12em] text-brand-graphite">{f.label}</dt>
              <dd className="text-[12.5px] font-semibold text-brand-ink">{f.value}</dd>
            </div>
          ))}
          <div className="flex items-center justify-between rounded-lg border border-emerald-200 bg-emerald-50 px-2.5 py-1.5">
            <div>
              <dt className="text-[9.5px] font-semibold uppercase tracking-[0.12em] text-emerald-700">Salário</dt>
              <dd className="text-[12.5px] font-semibold text-emerald-800">Dentro da faixa · Cargos e Salários</dd>
            </div>
            <Check className="h-4 w-4 text-emerald-600" strokeWidth={3} aria-hidden />
          </div>
        </dl>
        <div
          className={cn(
            'mt-3 flex h-9 items-center justify-center gap-2 rounded-lg text-[12.5px] font-bold transition-colors duration-500',
            sent ? 'bg-emerald-600 text-white' : 'bg-brand-purple text-white',
          )}
        >
          {sent ? (
            <>
              <Check className="h-4 w-4" strokeWidth={3} aria-hidden />
              Enviada para aprovação
            </>
          ) : (
            <>
              <Send className="h-3.5 w-3.5" aria-hidden />
              Enviar para aprovação
            </>
          )}
        </div>
      </m.div>
    </m.div>
  )
}

const approvals = [
  { phase: 3, initials: 'CN', name: 'Cláudia Nunes', role: 'Controladoria', text: 'Previsto e realizado do centro de custo conferidos. Aprovado.' },
  { phase: 4, initials: 'DO', name: 'Diretoria de Operações', role: 'pelo celular', text: 'Aprovado na alçada final.' },
  { phase: 5, initials: 'HC', name: 'Headcount', role: 'Administração de Pessoal', text: 'Vaga criada. Posição aberta na Linha 2.' },
]

function Approvals({ shown, reduced }: { shown: number; reduced: boolean }) {
  return (
    <div className="absolute right-[24px] top-[150px] w-[256px] space-y-2.5">
      <p className="text-[10px] font-bold uppercase tracking-[0.16em] text-brand-graphite">Workflow de aprovação</p>
      {approvals.map((a, i) => {
        const visible = shown >= a.phase
        return (
          <m.div
            key={a.name}
            className="flex items-start gap-2.5 rounded-xl border border-brand-mist bg-white/95 p-2.5 shadow-soft backdrop-blur"
            initial={reduced ? false : { opacity: 0, x: 24 }}
            animate={visible ? { opacity: 1, x: 0 } : undefined}
            transition={{ duration: 0.5, ease: EASE }}
          >
            <span
              className={cn(
                'flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-[10px] font-extrabold text-white',
                i === 2 ? 'bg-brand-pink' : 'bg-brand-purple',
              )}
            >
              {a.initials}
            </span>
            <span className="min-w-0 flex-1">
              <span className="flex items-center gap-1.5 text-[12px] font-bold leading-tight text-brand-ink">
                {a.name}
                <span className="inline-flex h-4 w-4 items-center justify-center rounded-full bg-emerald-500 text-white">
                  <Check className="h-2.5 w-2.5" strokeWidth={3.5} aria-hidden />
                </span>
              </span>
              <span className="block text-[10px] font-semibold uppercase tracking-[0.1em] text-brand-graphite">{a.role}</span>
              <span className="mt-0.5 block text-[11.5px] leading-snug text-brand-graphite">{a.text}</span>
            </span>
          </m.div>
        )
      })}
    </div>
  )
}

function Caption() {
  return (
    <div className="absolute bottom-[18px] left-[24px] flex flex-wrap gap-2">
      <span className="inline-flex items-center gap-1.5 rounded-full border border-white/60 bg-white/85 px-3 py-1 text-[11.5px] font-semibold text-brand-ink shadow-soft backdrop-blur">
        <Clock className="h-3.5 w-3.5 text-brand-pink" aria-hidden />
        Dia 1 · Seg 07/09 · 08:40
      </span>
      <span className="inline-flex items-center gap-1.5 rounded-full border border-white/60 bg-white/85 px-3 py-1 text-[11.5px] font-semibold text-brand-ink shadow-soft backdrop-blur">
        <MapPin className="h-3.5 w-3.5 text-brand-purple" aria-hidden />
        Vale Verde Alimentos · Sorocaba
      </span>
    </div>
  )
}
