import { useId, type ReactNode } from 'react'
import { m, useReducedMotion, type Variants } from 'motion/react'
import {
  AppWindow,
  Braces,
  Cloud,
  Cpu,
  Database,
  Gauge,
  Globe,
  KeyRound,
  Lock,
  Monitor,
  Network,
  RectangleEllipsis,
  Server,
  ShieldCheck,
  Smartphone,
  UserCheck,
} from 'lucide-react'
import { EASE, viewportOnce } from '@/lib/motion'
import { cn } from '@/lib/utils'

/**
 * A arquitetura da Natcorp, do dispositivo do usuário ao Oracle Database, desenhada para fundo escuro
 * (Section tone="dark" ou o cartão azul da home). Três zonas ligadas por trilhos com tráfego animado:
 * dispositivo → Web Application Firewall → Oracle Cloud Infrastructure (servidor de aplicação ⇄ servidor de
 * banco de dados, com a camada de permissões antes do banco). Em telas estreitas as zonas empilham e os
 * trilhos ficam verticais. O desenho é decorativo; a leitura acessível vem da lista `sr-only`.
 */

const HIGHLIGHT = '#E4A9C4'

type Icon = typeof Cloud

interface InfraDiagramProps {
  /** `full` para a página de segurança; `compact` para o cartão da home. */
  variant?: 'full' | 'compact'
  className?: string
}

const nodeVariants: Variants = {
  hidden: { opacity: 0, y: 14 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.6, ease: EASE } },
}
const linkVariants: Variants = {
  hidden: { opacity: 0 },
  visible: { opacity: 1, transition: { duration: 0.5, ease: EASE } },
}
const rootVariants = (stagger: number): Variants => ({
  hidden: {},
  visible: { transition: { staggerChildren: stagger } },
})

/* ------------------------------------------------------------------------------------------------
 * Trilhos: linhas com tracejado em movimento (ida em cima, volta embaixo) e seta na ponta.
 * ---------------------------------------------------------------------------------------------- */

interface LanesProps {
  dir: 'h' | 'v'
  /** Comprimento do trilho, em px. */
  length: number
  /** Espessura da área do trilho (eixo perpendicular), em px. */
  thick?: number
  /** Ida e volta (duas faixas) ou só ida. */
  twoWay?: boolean
  animate: boolean
  className?: string
}

const DASH = '4 8'
const PERIOD = 12

function Lanes({ dir, length, thick = 40, twoWay = true, animate, className }: LanesProps) {
  const uid = useId().replace(/[^a-zA-Z0-9]/g, '')
  const arrow = `infra-arrow-${uid}`
  const w = dir === 'h' ? length : thick
  const h = dir === 'h' ? thick : length
  const a = twoWay ? thick / 2 - 5 : thick / 2
  const b = thick / 2 + 5
  const pad = 2
  const forward = dir === 'h' ? { x1: pad, y1: a, x2: length - pad, y2: a } : { x1: a, y1: pad, x2: a, y2: length - pad }
  const back = dir === 'h' ? { x1: length - pad, y1: b, x2: pad, y2: b } : { x1: b, y1: length - pad, x2: b, y2: pad }
  const lanes = twoWay ? [forward, back] : [forward]
  return (
    <svg width={w} height={h} viewBox={`0 0 ${w} ${h}`} className={cn('block shrink-0 overflow-visible', className)} aria-hidden focusable="false">
      <defs>
        <marker id={arrow} viewBox="0 0 8 8" refX="7" refY="4" markerWidth="8" markerHeight="8" markerUnits="userSpaceOnUse" orient="auto">
          <path d="M1,0.8 L7,4 L1,7.2" fill="none" stroke={HIGHLIGHT} strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round" />
        </marker>
      </defs>
      {lanes.map((l, i) => (
        <g key={i}>
          <line {...l} stroke="#FFFFFF" strokeOpacity="0.22" strokeWidth="1.5" strokeLinecap="round" markerEnd={`url(#${arrow})`} />
          {animate ? (
            <m.line
              {...l}
              stroke={HIGHLIGHT}
              strokeWidth="1.5"
              strokeLinecap="round"
              strokeDasharray={DASH}
              initial={{ strokeDashoffset: 0 }}
              animate={{ strokeDashoffset: -PERIOD }}
              transition={{ duration: 0.9, repeat: Infinity, ease: 'linear', delay: i * 0.45 }}
            />
          ) : (
            <line {...l} stroke={HIGHLIGHT} strokeOpacity="0.75" strokeWidth="1.5" strokeLinecap="round" strokeDasharray={DASH} />
          )}
        </g>
      ))}
    </svg>
  )
}

function LockBadge({ size = 'md' }: { size?: 'md' | 'sm' }) {
  return (
    <span
      className={cn(
        'absolute left-1/2 top-1/2 flex -translate-x-1/2 -translate-y-1/2 items-center justify-center rounded-full bg-[#E4A9C4] text-brand-blue shadow-[0_0_0_4px_rgba(228,169,196,0.18)]',
        size === 'md' ? 'h-7 w-7' : 'h-6 w-6',
      )}
    >
      <Lock className={size === 'md' ? 'h-3.5 w-3.5' : 'h-3 w-3'} strokeWidth={2.4} />
    </span>
  )
}

/* Conector entre duas zonas: vertical em telas estreitas, horizontal a partir do ponto de quebra. */
interface FlowLinkProps {
  bp: 'sm' | 'lg'
  lock?: boolean
  label?: string
  length?: number
  animate: boolean
}

const bpClasses = {
  sm: { v: 'sm:hidden', h: 'hidden sm:flex' },
  lg: { v: 'lg:hidden', h: 'hidden lg:flex' },
} as const

function FlowLink({ bp, lock, label, length = 64, animate }: FlowLinkProps) {
  return (
    <m.div variants={animate ? linkVariants : undefined} className="relative flex items-center justify-center self-stretch">
      <div className={cn('flex items-center gap-2.5', bpClasses[bp].v)}>
        <div className="relative">
          <Lanes dir="v" length={52} animate={animate} />
          {lock && <LockBadge />}
        </div>
        {label && <span className="text-[12.5px] font-semibold text-[#E4A9C4]">{label}</span>}
      </div>
      <div className={cn('flex-col items-center justify-center', bpClasses[bp].h)}>
        <div className="relative">
          <Lanes dir="h" length={length} animate={animate} />
          {lock && <LockBadge />}
        </div>
        {label && <span className="-mt-0.5 text-[12.5px] font-semibold text-[#E4A9C4]">{label}</span>}
      </div>
    </m.div>
  )
}

/* Ligação curta dentro de um servidor: um passo desce para o seguinte. */
function ChainLink({ animate }: { animate: boolean }) {
  return (
    <div className="flex justify-center">
      <Lanes dir="v" length={22} twoWay={false} animate={animate} />
    </div>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Nós
 * ---------------------------------------------------------------------------------------------- */

function Chip({ icon: Icon, children, accent, className }: { icon?: Icon; children: ReactNode; accent?: boolean; className?: string }) {
  return (
    <span
      className={cn(
        'inline-flex min-w-0 items-center gap-2 rounded-lg border px-3 py-2 text-[13px] font-semibold leading-tight',
        accent ? 'border-[#E4A9C4]/50 bg-[#E4A9C4]/10 text-white' : 'border-white/[0.12] bg-white/[0.06] text-white/90',
        className,
      )}
    >
      {Icon && <Icon className={cn('h-4 w-4 shrink-0', accent ? 'text-[#E4A9C4]' : 'text-white/70')} strokeWidth={1.8} />}
      <span className="min-w-0">{children}</span>
    </span>
  )
}

interface ZoneProps {
  icon: Icon
  eyebrow: string
  title: string
  badge?: string
  accent?: boolean
  animate: boolean
  className?: string
  children?: ReactNode
}

function Zone({ icon: Icon, eyebrow, title, badge, accent, animate, className, children }: ZoneProps) {
  return (
    <m.div
      variants={animate ? nodeVariants : undefined}
      className={cn(
        'relative flex min-w-0 flex-col rounded-2xl border p-4 sm:p-5',
        accent ? 'border-[#E4A9C4]/40 bg-white/[0.04]' : 'border-white/15 bg-white/[0.06]',
        className,
      )}
    >
      <div className="flex flex-wrap items-start gap-3">
        <span className={cn('flex h-10 w-10 shrink-0 items-center justify-center rounded-xl', accent ? 'bg-[#E4A9C4] text-brand-blue' : 'bg-white/10 text-white')}>
          <Icon className="h-5 w-5" strokeWidth={1.7} />
        </span>
        <div className={cn('flex-1', badge ? 'min-w-[12rem]' : 'min-w-0')}>
          <p className="text-[12.5px] font-semibold uppercase tracking-[0.14em] text-[#E4A9C4]">{eyebrow}</p>
          <p className="mt-0.5 text-[15.5px] font-extrabold leading-snug text-white">{title}</p>
        </div>
        {badge && (
          <span className="inline-flex h-8 items-center gap-1.5 self-start rounded-full border border-[#E4A9C4]/50 bg-brand-blue px-3 text-[12.5px] font-semibold text-[#E4A9C4]">
            <Server className="h-3.5 w-3.5" strokeWidth={2} />
            {badge}
          </span>
        )}
      </div>
      {children}
    </m.div>
  )
}

interface ServerCardProps {
  icon: Icon
  title: string
  caption: string
  /** Bloco ancorado na base do cartão (equilibra a altura entre os dois servidores). */
  footer?: ReactNode
  animate: boolean
  children: ReactNode
}

function ServerCard({ icon: Icon, title, caption, footer, animate, children }: ServerCardProps) {
  return (
    <m.div variants={animate ? nodeVariants : undefined} className="flex min-w-0 flex-col rounded-xl border border-white/15 bg-brand-blue/50 p-4">
      <div className="flex items-center gap-2.5">
        <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-white/10 text-white">
          <Icon className="h-4 w-4" strokeWidth={1.8} />
        </span>
        <p className="text-[14.5px] font-extrabold leading-snug text-white">{title}</p>
      </div>
      <div className="mt-3.5 flex flex-col gap-1.5">{children}</div>
      <p className={cn('text-[12.5px] leading-snug text-white/60', footer ? 'mt-3' : 'mt-auto pt-4')}>{caption}</p>
      {footer && <div className="mt-auto pt-4">{footer}</div>}
    </m.div>
  )
}

/* Janela de navegador estilizada: o acesso é por URL, nada instalado. */
function BrowserFrame() {
  return (
    <div className="mt-4 flex-1 overflow-hidden rounded-xl border border-white/15 bg-brand-blue/50">
      <div className="flex items-center gap-2 border-b border-white/10 px-3 py-2">
        <span className="flex gap-1" aria-hidden>
          <span className="h-2 w-2 rounded-full bg-white/25" />
          <span className="h-2 w-2 rounded-full bg-white/25" />
          <span className="h-2 w-2 rounded-full bg-white/25" />
        </span>
        <span className="flex min-w-0 flex-1 items-center gap-1.5 rounded-md bg-white/[0.08] px-2 py-1 text-[12.5px] font-semibold text-white/80">
          <Lock className="h-3 w-3 shrink-0 text-[#E4A9C4]" strokeWidth={2.4} />
          <span className="truncate">https://portal.natcorp…</span>
        </span>
      </div>
      <div className="flex h-[calc(100%-2.6rem)] flex-col gap-2 p-3" aria-hidden>
        <div className="h-2 w-2/3 rounded-full bg-white/15" />
        <div className="h-2 w-full rounded-full bg-white/10" />
        <div className="h-2 w-5/6 rounded-full bg-white/10" />
        <div className="mt-auto grid grid-cols-3 gap-2 pt-1">
          <div className="h-8 rounded-md bg-white/[0.08]" />
          <div className="h-8 rounded-md bg-white/[0.08]" />
          <div className="h-8 rounded-md bg-[#E4A9C4]/25" />
        </div>
      </div>
    </div>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Leitura acessível
 * ---------------------------------------------------------------------------------------------- */

const fullSteps = [
  'Dispositivo do usuário: navegador, no desktop ou no celular, acessando a URL do portal. Nada é instalado na empresa.',
  'Web Application Firewall: conexão HTTPS com SSL, filtro WAF, credenciais do usuário e autenticação em dois fatores.',
  'Oracle Cloud Infrastructure, em servidores dedicados. Servidor de aplicação: Oracle REST Data Services e Oracle WebLogic executam as aplicações Java.',
  'Servidor de banco de dados: Oracle APEX envia as operações de leitura e gravação (GET, PUT, POST e DELETE) por uma camada de permissões, que entrega ao Oracle Database só os dados que o perfil do usuário permite.',
]

const compactSteps = [
  'Usuário: acesso pelo navegador, no desktop ou no celular.',
  'Firewall de aplicação: HTTPS, WAF e autenticação em dois fatores.',
  'Oracle Cloud, em servidores dedicados: servidor de aplicação e servidor de dados conversam por um canal protegido.',
]

/* ------------------------------------------------------------------------------------------------
 * Variantes
 * ---------------------------------------------------------------------------------------------- */

function FullDiagram({ animate }: { animate: boolean }) {
  return (
    <m.div
      aria-hidden
      className="grid gap-2 lg:grid-cols-[minmax(0,13.5rem)_4rem_minmax(0,15.5rem)_4rem_minmax(0,1fr)] lg:items-stretch lg:gap-0"
      variants={animate ? rootVariants(0.14) : undefined}
      initial={animate ? 'hidden' : false}
      whileInView="visible"
      viewport={viewportOnce}
    >
      <Zone icon={Monitor} eyebrow="Quem acessa" title="Dispositivo do usuário" animate={animate}>
        <div className="mt-4 flex flex-wrap gap-2">
          <Chip icon={Monitor}>Desktop</Chip>
          <Chip icon={Smartphone}>Celular</Chip>
          <Chip icon={Globe}>Navegador, pela URL do portal</Chip>
        </div>
        <BrowserFrame />
        <p className="mt-4 text-[12.5px] leading-snug text-white/60">Nada para instalar na empresa. O acesso é pelo navegador.</p>
      </Zone>

      <FlowLink bp="lg" label="HTTPS" animate={animate} />

      <Zone icon={ShieldCheck} eyebrow="O que protege" title="Web Application Firewall" animate={animate}>
        <div className="mt-4 flex flex-1 flex-col justify-center gap-2.5">
          <Chip icon={Lock}>HTTPS com certificado SSL</Chip>
          <Chip icon={ShieldCheck}>WAF: filtro de ameaças</Chip>
          <Chip icon={KeyRound}>Credenciais do usuário</Chip>
          <Chip icon={RectangleEllipsis}>Autenticação em dois fatores</Chip>
        </div>
        <p className="mt-4 text-[12.5px] leading-snug text-white/60">Cada requisição é filtrada e autenticada antes de chegar ao sistema.</p>
      </Zone>

      <FlowLink bp="lg" lock animate={animate} />

      <Zone icon={Cloud} eyebrow="Onde roda" title="Oracle Cloud Infrastructure" badge="Servidores dedicados" accent animate={animate}>
        <div className="mt-4 grid gap-2 sm:grid-cols-[minmax(0,1fr)_3rem_minmax(0,1fr)] sm:gap-0">
          <ServerCard
            icon={Server}
            title="Servidor de aplicação"
            caption="Recebe as requisições que passaram pelo firewall e executa as regras do sistema."
            footer={
              <span className="flex items-center gap-2.5 rounded-lg border border-white/10 bg-white/[0.04] px-3 py-2.5">
                <Gauge className="h-4 w-4 shrink-0 text-[#E4A9C4]" strokeWidth={1.8} />
                <span className="text-[12.5px] leading-snug text-white/80">
                  <span className="font-bold text-white">Mais de 2.500 colaboradores</span> calculados por minuto na folha.
                </span>
              </span>
            }
            animate={animate}
          >
            <Chip icon={Network}>Oracle REST Data Services</Chip>
            <Chip icon={Cpu}>Oracle WebLogic</Chip>
            <ChainLink animate={animate} />
            <Chip icon={Braces}>Aplicações Java</Chip>
          </ServerCard>

          <FlowLink bp="sm" lock length={48} animate={animate} />

          <ServerCard icon={Database} title="Servidor de banco de dados" caption="Lê e grava só o que o perfil de quem acessa autoriza." animate={animate}>
            <Chip icon={AppWindow}>Oracle APEX</Chip>
            <ChainLink animate={animate} />
            <span className="inline-flex items-center justify-center gap-1.5 self-center rounded-full border border-[#E4A9C4]/50 bg-white/[0.06] px-3 py-1 text-[12.5px] font-semibold tracking-wide text-[#E4A9C4]">
              <Lock className="h-3 w-3 shrink-0" strokeWidth={2.4} />
              GET · PUT · POST · DELETE
            </span>
            <ChainLink animate={animate} />
            <span className="flex items-start gap-2.5 rounded-lg border border-[#E4A9C4]/50 bg-[#E4A9C4]/10 px-3 py-2.5">
              <UserCheck className="mt-0.5 h-4 w-4 shrink-0 text-[#E4A9C4]" strokeWidth={1.8} />
              <span className="min-w-0 flex-1">
                <span className="block text-[13px] font-bold leading-tight text-white">Camada de permissões</span>
                <span className="mt-0.5 block text-[12.5px] leading-snug text-white/75">Dados conforme o perfil do usuário</span>
              </span>
              <Lock className="mt-0.5 h-3.5 w-3.5 shrink-0 text-[#E4A9C4]" strokeWidth={2.2} />
            </span>
            <ChainLink animate={animate} />
            <Chip icon={Database} accent>
              Oracle Database
            </Chip>
          </ServerCard>
        </div>
      </Zone>
    </m.div>
  )
}

function CompactNode({
  icon: Icon,
  title,
  caption,
  accent,
  animate,
  children,
}: {
  icon: Icon
  title: string
  caption?: string
  accent?: boolean
  animate: boolean
  children?: ReactNode
}) {
  return (
    <m.div
      variants={animate ? nodeVariants : undefined}
      className={cn('flex min-w-0 flex-col rounded-xl border p-3.5', accent ? 'border-[#E4A9C4]/40 bg-white/[0.04]' : 'border-white/15 bg-white/[0.06]')}
    >
      <div className="flex items-center gap-2.5">
        <span className={cn('flex h-9 w-9 shrink-0 items-center justify-center rounded-lg', accent ? 'bg-[#E4A9C4] text-brand-blue' : 'bg-white/10 text-white')}>
          <Icon className="h-[18px] w-[18px]" strokeWidth={1.8} />
        </span>
        <div className="min-w-0">
          <p className="text-[14px] font-extrabold leading-tight text-white">{title}</p>
          {caption && <p className="mt-0.5 text-[12.5px] leading-snug text-white/65">{caption}</p>}
        </div>
      </div>
      {children}
    </m.div>
  )
}

function CompactDiagram({ animate }: { animate: boolean }) {
  return (
    <m.div
      aria-hidden
      className="grid gap-1.5 sm:grid-cols-[minmax(0,1fr)_3rem_minmax(0,1.1fr)_3rem_minmax(0,1.35fr)] sm:items-stretch sm:gap-0"
      variants={animate ? rootVariants(0.12) : undefined}
      initial={animate ? 'hidden' : false}
      whileInView="visible"
      viewport={viewportOnce}
    >
      <CompactNode icon={Monitor} title="Usuário" caption="Navegador, no desktop ou no celular" animate={animate} />
      <FlowLink bp="sm" length={48} animate={animate} />
      <CompactNode icon={ShieldCheck} title="Firewall de aplicação" animate={animate}>
        <div className="mt-2.5 flex flex-wrap gap-1.5">
          {['HTTPS', 'WAF', '2FA'].map((t) => (
            <span key={t} className="rounded-md border border-white/[0.12] bg-white/[0.06] px-2 py-1 text-[12.5px] font-semibold text-white/90">
              {t}
            </span>
          ))}
        </div>
      </CompactNode>
      <FlowLink bp="sm" lock length={48} animate={animate} />
      <CompactNode icon={Cloud} title="Oracle Cloud" caption="Servidores dedicados" accent animate={animate}>
        <div className="mt-2.5 flex items-center gap-1.5">
          <span className="inline-flex flex-1 items-center justify-center gap-1.5 rounded-md border border-white/[0.12] bg-white/[0.06] px-2 py-1 text-[12.5px] font-semibold text-white/90">
            <Server className="h-3.5 w-3.5 text-white/70" strokeWidth={1.8} />
            Aplicação
          </span>
          <Lanes dir="h" length={30} thick={24} animate={animate} />
          <span className="inline-flex flex-1 items-center justify-center gap-1.5 rounded-md border border-[#E4A9C4]/50 bg-[#E4A9C4]/10 px-2 py-1 text-[12.5px] font-semibold text-white">
            <Database className="h-3.5 w-3.5 text-[#E4A9C4]" strokeWidth={1.8} />
            Dados
          </span>
        </div>
      </CompactNode>
    </m.div>
  )
}

export function InfraDiagram({ variant = 'full', className }: InfraDiagramProps) {
  const reduced = useReducedMotion()
  const animate = !reduced
  const steps = variant === 'full' ? fullSteps : compactSteps
  return (
    <div className={cn('relative', className)}>
      {variant === 'full' ? <FullDiagram animate={animate} /> : <CompactDiagram animate={animate} />}
      <ol className="sr-only">
        {steps.map((s) => (
          <li key={s}>{s}</li>
        ))}
      </ol>
    </div>
  )
}
