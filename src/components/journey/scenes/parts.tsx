import { useId, type ReactNode } from 'react'
import { m, type MotionValue } from 'motion/react'
import { Check, Clock, MapPin, type LucideIcon } from 'lucide-react'
import { Logo } from '@/components/brand/Logo'
import { figures } from '@/content/journeyArt'
import type { CastKey } from '@/content/hiringJourney'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { STAGE_H, STAGE_W } from './SceneStage'

/* ------------------------------------------------------------------------------------------------
 * Peças compartilhadas das cenas montadas por camadas. Tudo é posicionado em pixels do palco
 * (960 x 540, ver SceneStage). Cada cena escolhe o cenário, as figuras e a sequência da interface.
 * ---------------------------------------------------------------------------------------------- */


/* ---------------------------------------------- figuras ---------------------------------------- */

interface FigureProps {
  who: CastKey
  /** Canto superior esquerdo da figura, em pixels do palco. */
  x: number
  y: number
  /** Altura da figura em pixels do palco (a largura segue a proporção da imagem). */
  height: number
  /** De onde a figura entra. */
  from?: 'left' | 'right' | 'bottom'
  delay?: number
  /** Espelha a figura horizontalmente (para olhar para o outro lado). */
  flip?: boolean
  on: boolean
  reduced: boolean
  /** Paralaxe de primeiro plano (StageContext.near). */
  near?: MotionValue<number>
  /** Largura da sombra no chão; por padrão, 70% da altura da figura dividido por 2. */
  shadowWidth?: number
  className?: string
}

/** Figura 3D recortada de um personagem: entra por um lado, respira devagar e tem sombra no chão. */
export function Figure({ who, x, y, height, from = 'left', delay = 0.1, flip = false, on, reduced, near, shadowWidth, className }: FigureProps) {
  const src = figures[who]
  if (!src) return null
  const offset = from === 'left' ? { x: -48, y: 0 } : from === 'right' ? { x: 48, y: 0 } : { x: 0, y: 40 }
  const shadow = shadowWidth ?? Math.round(height * 0.36)
  return (
    <m.div className={cn('absolute', className)} style={{ left: x, top: y, y: near }}>
      <m.div initial={reduced ? false : { opacity: 0, ...offset }} animate={on ? { opacity: 1, x: 0, y: 0 } : undefined} transition={{ duration: 0.8, ease: EASE, delay }}>
        <m.div animate={reduced ? undefined : { y: [0, -4, 0] }} transition={{ duration: 4.6, ease: 'easeInOut', repeat: Infinity, delay }}>
          <img
            src={src}
            alt=""
            className="block w-auto drop-shadow-[0_14px_18px_rgba(27,18,56,0.22)]"
            style={{ height, transform: flip ? 'scaleX(-1)' : undefined }}
            draggable={false}
          />
        </m.div>
      </m.div>
      <span className="absolute -bottom-2 left-1/2 h-4 -translate-x-1/2 rounded-full bg-brand-ink/15 blur-[6px]" style={{ width: shadow }} />
    </m.div>
  )
}

/** Um pulso rosa em um ponto do palco (um toque, um envio, uma leitura). */
export function Ping({ x, y, active, reduced }: { x: number; y: number; active: boolean; reduced: boolean }) {
  if (!active || reduced) return null
  return (
    <span className="absolute" style={{ left: x, top: y }}>
      {[0, 0.25].map((delay) => (
        <m.span
          key={delay}
          className="absolute -left-4 -top-4 h-8 w-8 rounded-full border-2 border-brand-pink"
          initial={{ scale: 0.4, opacity: 0.9 }}
          animate={{ scale: 2.4, opacity: 0 }}
          transition={{ duration: 0.9, ease: 'easeOut', delay }}
        />
      ))}
    </span>
  )
}

/* ---------------------------------------------- interface -------------------------------------- */

interface UiCardProps {
  x: number
  y: number
  width: number
  /** Nome do produto no cabeçalho (ex.: "Portal do Gestor", "NatDocs", "GED"). */
  product: string
  /** Etiqueta à direita do cabeçalho (ex.: "Requisição de Vaga"). */
  tag?: string
  on: boolean
  reduced: boolean
  delay?: number
  /** Flutuação lenta depois de entrar. */
  float?: boolean
  /** Fundo escuro (para telas de sistema) ou claro (portais). */
  tone?: 'light' | 'dark'
  className?: string
  children: ReactNode
}

/** Card da interface no estilo dos portais: cabeçalho com o símbolo e o nome do produto, corpo livre. */
export function UiCard({ x, y, width, product, tag, on, reduced, delay = 0.5, float = true, tone = 'light', className, children }: UiCardProps) {
  const dark = tone === 'dark'
  return (
    <m.div
      className={cn('absolute rounded-2xl border p-4 shadow-lift', dark ? 'border-white/10 bg-brand-ink text-white' : 'border-brand-mist bg-white text-brand-ink', className)}
      style={{ left: x, top: y, width }}
      initial={reduced ? false : { opacity: 0, y: 18, scale: 0.96 }}
      animate={on ? { opacity: 1, y: 0, scale: 1 } : undefined}
      transition={{ duration: 0.6, ease: EASE, delay }}
    >
      <m.div animate={reduced || !float ? undefined : { y: [0, -3, 0] }} transition={{ duration: 5.2, ease: 'easeInOut', repeat: Infinity, delay: delay + 0.6 }}>
        <div className="flex items-center justify-between gap-2">
          <span className={cn('flex items-center gap-2 whitespace-nowrap text-[11px] font-bold uppercase tracking-[0.14em]', dark ? 'text-[#E4A9C4]' : 'text-brand-purple')}>
            <Logo variant="symbol" tone={dark ? 'white' : 'flat'} decorative className="h-3.5 w-3.5 shrink-0" />
            {product}
          </span>
          {tag && (
            <span className={cn('whitespace-nowrap rounded-full px-2 py-0.5 text-[9.5px] font-semibold', dark ? 'bg-white/10 text-white/80' : 'bg-brand-off-white text-brand-graphite')}>{tag}</span>
          )}
        </div>
        {children}
      </m.div>
    </m.div>
  )
}

/** Campo rótulo + valor dentro de um UiCard. `ok` fica verde (validado), `warn` fica rosa (atenção). */
export function Field({ label, value, tone = 'default', icon: Icon }: { label: string; value: ReactNode; tone?: 'default' | 'ok' | 'warn'; icon?: LucideIcon }) {
  return (
    <div
      className={cn(
        'flex items-center justify-between gap-2 rounded-lg border px-2.5 py-1.5',
        tone === 'ok' ? 'border-emerald-200 bg-emerald-50' : tone === 'warn' ? 'border-brand-pink/40 bg-brand-pink/10' : 'border-brand-mist bg-brand-off-white/70',
      )}
    >
      <div className="min-w-0">
        <p className={cn('text-[9.5px] font-semibold uppercase tracking-[0.12em]', tone === 'ok' ? 'text-emerald-700' : tone === 'warn' ? 'text-brand-plum' : 'text-brand-graphite')}>{label}</p>
        <p className={cn('truncate text-[12.5px] font-semibold', tone === 'ok' ? 'text-emerald-800' : 'text-brand-ink')}>{value}</p>
      </div>
      {tone === 'ok' && !Icon && <Check className="h-4 w-4 shrink-0 text-emerald-600" strokeWidth={3} aria-hidden />}
      {Icon && <Icon className={cn('h-4 w-4 shrink-0', tone === 'warn' ? 'text-brand-pink' : 'text-brand-purple')} strokeWidth={2.2} aria-hidden />}
    </div>
  )
}

/** Botão que muda de estado quando a ação acontece (enviar, confirmar, assinar). */
export function ActionButton({ done, idleLabel, doneLabel, icon: Icon, className }: { done: boolean; idleLabel: string; doneLabel: string; icon?: LucideIcon; className?: string }) {
  return (
    <div className={cn('flex h-9 items-center justify-center gap-2 rounded-lg text-[12.5px] font-bold text-white transition-colors duration-500', done ? 'bg-emerald-700' : 'bg-brand-purple', className)}>
      {done ? <Check className="h-4 w-4" strokeWidth={3} aria-hidden /> : Icon ? <Icon className="h-3.5 w-3.5" aria-hidden /> : null}
      {done ? doneLabel : idleLabel}
    </div>
  )
}

export interface SceneEvent {
  /** A fase a partir da qual o evento aparece. */
  phase: number
  /** Iniciais no círculo (ou um ícone). */
  initials?: string
  icon?: LucideIcon
  name: string
  role: string
  text: string
  /** Cor do círculo. */
  tone?: 'purple' | 'pink' | 'green'
}

/** Eventos chegando em pilha (aprovações, avisos, integrações), ligados às fases da cena. */
export function EventStack({ x, y, width, title, items, shown, reduced, from = 'right' }: { x: number; y: number; width: number; title: string; items: SceneEvent[]; shown: number; reduced: boolean; from?: 'left' | 'right' }) {
  return (
    <div className="absolute space-y-2.5" style={{ left: x, top: y, width }}>
      <p className="text-[10px] font-bold uppercase tracking-[0.16em] text-brand-graphite">{title}</p>
      {items.map((a) => {
        const visible = shown >= a.phase
        const Icon = a.icon
        return (
          <m.div
            key={a.name}
            className="flex items-start gap-2.5 rounded-xl border border-brand-mist bg-white/95 p-2.5 shadow-soft backdrop-blur"
            initial={reduced ? false : { opacity: 0, x: from === 'right' ? 24 : -24 }}
            animate={visible ? { opacity: 1, x: 0 } : undefined}
            transition={{ duration: 0.5, ease: EASE }}
          >
            <span className={cn('flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-[10px] font-extrabold text-white', a.tone === 'pink' ? 'bg-brand-plum' : a.tone === 'green' ? 'bg-emerald-700' : 'bg-brand-purple')}>
              {Icon ? <Icon className="h-4 w-4" strokeWidth={2.2} aria-hidden /> : a.initials}
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

/** Legenda no canto: dia e hora, e o lugar. */
export function Caption({ when, where }: { when: string; where: string }) {
  const pill = 'inline-flex items-center gap-1.5 rounded-full border border-white/60 bg-white/85 px-3 py-1 text-[11.5px] font-semibold text-brand-ink shadow-soft backdrop-blur'
  return (
    <div className="absolute bottom-[18px] left-[24px] flex flex-wrap gap-2">
      <span className={pill}>
        <Clock className="h-3.5 w-3.5 text-brand-pink" aria-hidden />
        {when}
      </span>
      <span className={pill}>
        <MapPin className="h-3.5 w-3.5 text-brand-purple" aria-hidden />
        {where}
      </span>
    </div>
  )
}

/* ---------------------------------------------- cenário (SVG) ---------------------------------- */

/** O contêiner SVG do cenário, no tamanho do palco. Coloque as camadas dentro. */
export function Backdrop({ children }: { children: ReactNode }) {
  return (
    <svg viewBox={`0 0 ${STAGE_W} ${STAGE_H}`} width={STAGE_W} height={STAGE_H} className="absolute inset-0" aria-hidden focusable="false">
      {children}
    </svg>
  )
}

/** Parede (fundo) e piso, com um brilho rosa suave no meio. `floorY` é a linha do chão. */
export function Room({ floorY = 336, wall = ['#F8F5FB', '#E9E5F1'], floor = ['#E6E1EE', '#F4F2F7'], glow = true, lines = true }: { floorY?: number; wall?: [string, string]; floor?: [string, string]; glow?: boolean; lines?: boolean }) {
  const id = useId().replace(/[^a-zA-Z0-9]/g, '')
  return (
    <>
      <defs>
        <linearGradient id={`${id}-wall`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor={wall[0]} />
          <stop offset="1" stopColor={wall[1]} />
        </linearGradient>
        <linearGradient id={`${id}-floor`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor={floor[0]} />
          <stop offset="1" stopColor={floor[1]} />
        </linearGradient>
        <radialGradient id={`${id}-glow`} cx="0.5" cy="0.5" r="0.5">
          <stop offset="0" stopColor="#C95788" stopOpacity="0.16" />
          <stop offset="1" stopColor="#C95788" stopOpacity="0" />
        </radialGradient>
      </defs>
      <rect width={STAGE_W} height={STAGE_H} fill={`url(#${id}-wall)`} />
      <rect y={floorY} width={STAGE_W} height={STAGE_H - floorY} fill={`url(#${id}-floor)`} />
      {glow && <ellipse cx="640" cy={floorY + 24} rx="420" ry="120" fill={`url(#${id}-glow)`} />}
      {lines && [0, 160, 320, 480, 640, 800, 960].map((x) => <line key={x} x1={x} y1={floorY} x2={480 + (x - 480) * 2.2} y2={STAGE_H} stroke="#FFFFFF" strokeOpacity="0.5" />)}
    </>
  )
}

/** Uma fileira de janelas altas com feixes de luz até o chão. */
export function WindowRow({ xs = [40, 210, 380, 550, 720, 890], y = 52, w = 130, h = 86, floorY = 336 }: { xs?: number[]; y?: number; w?: number; h?: number; floorY?: number }) {
  const id = useId().replace(/[^a-zA-Z0-9]/g, '')
  return (
    <>
      <defs>
        <linearGradient id={`${id}-win`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#FFFFFF" />
          <stop offset="1" stopColor="#EFE8F7" />
        </linearGradient>
        <linearGradient id={`${id}-beam`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#FFFFFF" stopOpacity="0.55" />
          <stop offset="1" stopColor="#FFFFFF" stopOpacity="0" />
        </linearGradient>
      </defs>
      {xs.map((x) => (
        <g key={x}>
          <rect x={x} y={y} width={w} height={h} rx="6" fill={`url(#${id}-win)`} stroke="#D7D0E2" />
          <line x1={x + w / 2} y1={y} x2={x + w / 2} y2={y + h} stroke="#D7D0E2" />
          <line x1={x} y1={y + h / 2} x2={x + w} y2={y + h / 2} stroke="#D7D0E2" />
          <polygon points={`${x + 10},${y + h} ${x + w - 10},${y + h} ${x + w + 60},${floorY} ${x - 60},${floorY}`} fill={`url(#${id}-beam)`} />
        </g>
      ))}
    </>
  )
}

/** Pessoas ao fundo, desfocadas: touca (ou cabelo) e um casaco claro. */
export function People({ spots, coat = '#FFFFFF', hair = '#FFFFFF', blur = 1.6 }: { spots: { x: number; y: number; w?: number; h?: number }[]; coat?: string; hair?: string; blur?: number }) {
  const id = useId().replace(/[^a-zA-Z0-9]/g, '')
  return (
    <>
      <defs>
        <filter id={`${id}-blur`} x="-20%" y="-20%" width="140%" height="140%">
          <feGaussianBlur stdDeviation={blur} />
        </filter>
      </defs>
      <g filter={`url(#${id}-blur)`}>
        {spots.map((p) => {
          const w = p.w ?? 46
          const h = p.h ?? 110
          return (
            <g key={`${p.x}-${p.y}`}>
              <circle cx={p.x + w / 2} cy={p.y + 14} r="15" fill="#E6C9B4" />
              <path d={`M${p.x + w / 2 - 15} ${p.y + 12} a15 15 0 0 1 30 0 z`} fill={hair} />
              <rect x={p.x} y={p.y + 30} width={w} height={h - 30} rx="12" fill={coat} stroke="#DDD7E6" />
            </g>
          )
        })}
      </g>
    </>
  )
}

/** Faixa de segurança no piso. */
export function SafetyStripe({ y = 452 }: { y?: number }) {
  return <rect x="0" y={y} width={STAGE_W} height="6" fill="#E4A9C4" fillOpacity="0.45" />
}

/** Bloco desfocado ao fundo (um armário, um painel, uma máquina). */
export function FarBlock({ x, y, w, h, rows = 3 }: { x: number; y: number; w: number; h: number; rows?: number }) {
  const id = useId().replace(/[^a-zA-Z0-9]/g, '')
  return (
    <>
      <defs>
        <filter id={`${id}-blur`} x="-20%" y="-20%" width="140%" height="140%">
          <feGaussianBlur stdDeviation="2.6" />
        </filter>
      </defs>
      <g filter={`url(#${id}-blur)`}>
        <rect x={x} y={y} width={w} height={h} rx="10" fill="#D5CFE0" />
        {Array.from({ length: rows }, (_, i) => (
          <rect key={i} x={x + 15} y={y + 15 + i * 30} width={w - 30} height="18" rx="4" fill="#C7C0D5" />
        ))}
      </g>
    </>
  )
}

/** Placa roxa com um título e um subtítulo (sinalização do lugar). */
export function Sign({ x, y, w = 176, h = 64, title, subtitle }: { x: number; y: number; w?: number; h?: number; title: string; subtitle?: string }) {
  return (
    <g>
      <rect x={x} y={y} width={w} height={h} rx="12" fill="#511C76" />
      <text x={x + w / 2} y={y + (subtitle ? 28 : 40)} textAnchor="middle" fontFamily="Manrope, sans-serif" fontWeight="800" fontSize="20" fill="#FFFFFF" letterSpacing="2">
        {title}
      </text>
      {subtitle && (
        <text x={x + w / 2} y={y + 50} textAnchor="middle" fontFamily="Manrope, sans-serif" fontWeight="600" fontSize="11" fill="#E4A9C4" letterSpacing="3">
          {subtitle}
        </text>
      )}
    </g>
  )
}

