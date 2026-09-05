import type { ReactNode } from 'react'
import {
  BarChart3,
  Bell,
  BookOpen,
  Camera,
  ChevronDown,
  Database,
  FileSearch,
  Home,
  Info,
  KeyRound,
  Landmark,
  ListChecks,
  MapPin,
  Maximize2,
  Megaphone,
  Menu,
  MessageCircle,
  Search,
  Send,
  Settings,
  SquarePlus,
  Table2,
  User,
  Users,
} from 'lucide-react'
import { cn } from '@/lib/utils'
import { Logo } from '@/components/brand/Logo'

/** Tamanho de desenho das telas do Painel do Operador (use dentro de um ScaledFrame). */
export const ANALYTICS_SIZE = { width: 1180, height: 700 } as const

const rail = [Home, Users, Settings, Megaphone, FileSearch, SquarePlus, Database, Landmark, BarChart3, ListChecks, Users, MapPin, Send, Camera, KeyRound]

interface PanelShellProps {
  children: ReactNode
  /** Barra roxa secundária (abas de navegação), logo abaixo do cabeçalho. */
  subnav?: ReactNode
  /** Índice do ícone ativo na trilha lateral. */
  activeRail?: number
  className?: string
  /** Conteúdo sobreposto (ex.: modal). */
  overlay?: ReactNode
}

/** Moldura do Painel do Operador: cabeçalho roxo, trilha de ícones e área de conteúdo. */
export function PanelShell({ children, subnav, activeRail = 8, className, overlay }: PanelShellProps) {
  const { width, height } = ANALYTICS_SIZE
  return (
    <div className={cn('relative overflow-hidden rounded-xl bg-[#F4F2F7] text-brand-ink shadow-lift', className)} style={{ width, height }} aria-hidden>
      <div className="flex h-[52px] items-center gap-4 border-b-[3px] border-b-[#C95788] bg-brand-purple px-4 text-white">
        <Menu className="h-5 w-5" strokeWidth={2} />
        <span className="text-[19px] font-medium">Painel do Operador</span>
        <span className="ml-auto flex items-center gap-6 text-[13px]">
          <span className="flex items-center gap-1.5">
            <Search className="h-4 w-4" /> …
          </span>
          <span className="flex items-center gap-1.5">
            <Info className="h-4 w-4" /> Manual
          </span>
          <span className="flex items-center gap-1.5">
            <BookOpen className="h-4 w-4" /> Blog
          </span>
          <span className="flex items-center gap-1.5">
            <Bell className="h-4 w-4" /> [6] Notificações ▾
          </span>
          <span className="flex items-center gap-1.5">
            <User className="h-4 w-4" /> 365785 ▾
          </span>
        </span>
      </div>

      <div className="flex h-[calc(100%-52px)]">
        <aside className="flex w-14 shrink-0 flex-col items-center gap-[7px] bg-[#2B2D36] py-2">
          {rail.map((Icon, i) => (
            <span key={i} className={cn('flex h-8 w-9 items-center justify-center rounded', i === activeRail && 'bg-white/10')}>
              <Icon className="h-[18px] w-[18px] text-[#C95788]" strokeWidth={1.7} />
            </span>
          ))}
        </aside>
        <div className="flex min-w-0 flex-1 flex-col overflow-hidden">
          {subnav}
          <div className="min-h-0 flex-1 overflow-hidden">{children}</div>
        </div>
      </div>

      <span className="absolute bottom-5 right-5 flex h-14 w-14 items-center justify-center rounded-full bg-[linear-gradient(135deg,#6A2E8E,#B4568F)] text-white shadow-lift">
        <MessageCircle className="h-7 w-7" strokeWidth={1.8} />
      </span>
      {overlay}
    </div>
  )
}

/** Barra roxa com abas (ex.: Administração de Pessoal · Folha de Pagamento ▾ · Histórico Financeiro ▾). */
export function SubNav({ items }: { items: { label: string; caret?: boolean; active?: boolean }[] }) {
  return (
    <div className="flex h-12 shrink-0 items-stretch bg-brand-purple text-[15px] text-white">
      {items.map((it) => (
        <span key={it.label} className={cn('flex items-center gap-2 border-r border-white/15 px-4', it.active && 'bg-black/20 font-bold')}>
          {it.label}
          {it.caret && <ChevronDown className="h-4 w-4" strokeWidth={2} />}
        </span>
      ))}
    </div>
  )
}

/** Barra de ferramentas do relatório interativo: busca, Ir, relatório, alternância tabela/gráfico e Ações. */
export function ReportToolbar({ mode, highlightActions = false }: { mode: 'chart' | 'table'; highlightActions?: boolean }) {
  return (
    <div className="flex items-center gap-2 text-[13px]">
      <span className="flex h-9 items-center gap-1.5 rounded-l border border-brand-mist bg-white px-3 text-brand-graphite">
        <Search className="h-4 w-4" strokeWidth={2} />
        <ChevronDown className="h-3.5 w-3.5" />
      </span>
      <span className="h-9 w-[300px] border border-brand-mist bg-white" />
      <span className="flex h-9 items-center rounded-r border border-brand-mist bg-white px-3 font-bold text-brand-ink">Ir</span>
      <span className="ml-2 flex h-9 w-[250px] items-center justify-between rounded border border-brand-mist bg-white px-3 text-brand-graphite">
        1. Relatório Primário
        <ChevronDown className="h-4 w-4" />
      </span>
      <span className="ml-2 flex overflow-hidden rounded border border-brand-mist bg-white">
        <span className={cn('flex h-9 w-12 items-center justify-center text-brand-graphite', mode === 'table' && 'bg-brand-mist text-brand-ink')}>
          <Table2 className="h-4 w-4" strokeWidth={1.8} />
        </span>
        <span className={cn('flex h-9 w-12 items-center justify-center border-l border-brand-mist text-brand-graphite', mode === 'chart' && 'bg-brand-mist text-brand-ink')}>
          <BarChart3 className="h-4 w-4" strokeWidth={1.8} />
        </span>
      </span>
      <span className={cn('ml-2 flex h-9 items-center gap-1.5 rounded border bg-white px-3 text-brand-ink', highlightActions ? 'border-2 border-[#C95788]' : 'border-brand-mist')}>
        Ações
        <ChevronDown className="h-4 w-4" />
      </span>
      <span className="ml-auto flex h-10 w-10 items-center justify-center rounded-full border border-brand-mist bg-white">
        <Logo variant="symbol" tone="gradient" decorative className="h-6 w-6" />
      </span>
      <Maximize2 className="ml-2 h-4 w-4 text-brand-ink" strokeWidth={1.8} />
    </div>
  )
}

/** Linha abaixo da barra: chip "Editar Gráfico" ou destaque salvo. */
export function ChipRow({ kind }: { kind: 'edit' | 'highlight' }) {
  return (
    <div className="mt-3 flex items-center gap-4 border-t-[3px] border-brand-purple pt-3 text-[13px]">
      <ChevronDown className="ml-4 h-4 w-4 text-brand-graphite" />
      {kind === 'edit' ? (
        <span className="flex h-11 w-[440px] items-center overflow-hidden rounded border border-brand-mist bg-white">
          <span className="flex h-full w-11 items-center justify-center bg-[#2E86DE] text-white">
            <BarChart3 className="h-4 w-4" strokeWidth={2} />
          </span>
          <span className="px-3 text-brand-ink">Editar Gráfico</span>
        </span>
      ) : (
        <>
          <span className="flex h-5 w-5 items-center justify-center rounded border border-brand-graphite/50 bg-white text-[11px] text-brand-graphite">✓</span>
          <span className="flex h-11 w-[440px] items-center overflow-hidden rounded border border-[#F2A9A0] bg-[#FDE4E1]">
            <span className="flex h-full w-11 items-center justify-center bg-[#F5C242] text-white">☆</span>
            <span className="px-3 text-brand-ink">Diferença Negativa</span>
          </span>
        </>
      )}
      <span className="text-brand-graphite">✕</span>
    </div>
  )
}
