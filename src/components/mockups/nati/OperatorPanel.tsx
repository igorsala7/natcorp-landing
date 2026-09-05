import type { ReactNode } from 'react'
import { m } from 'motion/react'
import {
  Bell,
  BookOpen,
  Camera,
  Database,
  ExternalLink,
  FileSearch,
  Filter,
  Home,
  Info,
  KeyRound,
  Landmark,
  ListChecks,
  MapPin,
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
import { EASE, viewportOnce } from '@/lib/motion'

export const PANEL_SIZE = {
  desktop: { width: 1180, height: 760 },
  tablet: { width: 820, height: 640 },
} as const

type Layout = keyof typeof PANEL_SIZE

const menu = [
  { icon: Home, label: 'Home', active: true },
  { icon: Users, label: 'Colaboradores' },
  { icon: Settings, label: 'Ativar Processos' },
  { icon: Megaphone, label: 'Requisições' },
  { icon: FileSearch, label: 'Pesquisa de Processos' },
  { icon: SquarePlus, label: 'Apoio' },
  { icon: Database, label: 'Consultas' },
  { icon: Landmark, label: 'Estrutura' },
  { icon: Table2, label: 'Operacional' },
  { icon: ListChecks, label: 'Relatórios' },
  { icon: MapPin, label: 'Localizar' },
  { icon: Send, label: 'eSocial' },
  { icon: Camera, label: 'Fotos' },
  { icon: KeyRound, label: 'Acessos' },
]

const filiais = [
  { label: 'Natcorp Do Brasil Fil 10', v: 70 },
  { label: 'Natcorp Do Brasil Fil 4', v: 85 },
  { label: 'Natcorp Do Brasil Fil 97', v: 95 },
  { label: 'Natcorp Do Brasil - Matriz', v: 571 },
]

const locais = [
  ['Prevenção De P…', 100],
  ['Aprendizagem', 78],
  ['Serviços Gerais', 62],
  ['Açougue', 48],
  ['Medicina Do Tr…', 40],
  ['Refrigeração', 34],
  ['Arquivo', 26],
  ['Contabilidade', 22],
  ['Diretoria', 18],
  ['Tesouraria Cent…', 14],
] as const

const cargos = [
  ['Analista Admini…', 100],
  ['Professor Ensin…', 64],
  ['Analista De Neg…', 46],
  ['Gerente De Loja', 38],
  ['Comprador Sen…', 30],
  ['Encarregado De…', 26],
  ['Auditor Interno', 22],
  ['Coordenador D…', 18],
  ['Médico Do Trab…', 16],
  ['Comprador De …', 14],
] as const

const tiles = [
  { n: '571', label: 'Matriz - São Paulo', bg: 'bg-[#B1416E]' },
  { n: '95', label: 'Loja 97 - Escritório Rh/M…', bg: 'bg-brand-blue' },
  { n: '83', label: 'Loja 04 - Pompéia', bg: 'bg-brand-purple' },
  { n: '70', label: 'Loja 10 - Pará De Minas', bg: 'bg-[#237A54]' },
]

const pie = [
  ['#C95788', 7],
  ['#511C76', 5],
  ['#2C1A63', 4],
  ['#F0A34A', 4],
  ['#2E9E6B', 3],
  ['#9A408A', 3],
  ['#E4A9C4', 2],
  ['#8E88A3', 2],
  ['#F26D86', 6],
  ['#7B47B4', 5],
  ['#1E7A57', 4],
  ['#B1416E', 5],
  ['#F5C242', 4],
  ['#3B82F6', 3],
  ['#C95788', 8],
  ['#511C76', 7],
  ['#2C1A63', 6],
  ['#F0A34A', 5],
  ['#2E9E6B', 5],
  ['#9A408A', 6],
  ['#8E88A3', 6],
] as const

const legend = ['Açougue', 'Adm De Rec…', 'Apoio Admin…', 'Aprendizagem', 'Arquivo', 'Auditoria', 'Cartão Fácil', 'Central Adm…', 'Comercial C…', 'Comite Trib…']

/* Fatias da pizza pré-calculadas. */
const pieSlices = (() => {
  const total = pie.reduce((s, [, v]) => s + v, 0)
  let acc = 0
  const p = (a: number) => `${60 + 54 * Math.cos(a)},${60 + 54 * Math.sin(a)}`
  return pie.map(([, pct]) => {
    const a0 = (acc / total) * 2 * Math.PI - Math.PI / 2
    acc += pct
    const a1 = (acc / total) * 2 * Math.PI - Math.PI / 2
    return `M60,60 L${p(a0)} A54,54 0 ${pct / total > 0.5 ? 1 : 0} 1 ${p(a1)} Z`
  })
})()

function Card({ title, children, className }: { title: string; children: ReactNode; className?: string }) {
  return (
    <div className={cn('flex min-h-0 flex-col overflow-hidden rounded-lg border border-brand-mist bg-white', className)}>
      <div className="flex items-center justify-between border-b border-brand-mist border-l-[3px] border-l-brand-purple px-4 py-2.5">
        <p className="truncate text-[15px] font-semibold text-brand-ink">{title}</p>
        <ExternalLink className="h-3.5 w-3.5 shrink-0 text-brand-graphite" strokeWidth={1.8} aria-hidden />
      </div>
      <div className="min-h-0 flex-1 p-4">{children}</div>
    </div>
  )
}

function GrowBar({ height, delay, className }: { height: string; delay: number; className?: string }) {
  return (
    <m.span
      className={cn('block rounded-t-sm', className)}
      style={{ height, transformOrigin: 'bottom' }}
      initial={{ scaleY: 0 }}
      whileInView={{ scaleY: 1 }}
      viewport={viewportOnce}
      transition={{ duration: 0.8, ease: EASE, delay }}
    />
  )
}

function YAxis({ labels }: { labels: string[] }) {
  return (
    <div className="flex h-full flex-col justify-between pr-2 text-right text-[10.5px] tabular text-brand-graphite">
      {labels.map((l) => (
        <span key={l}>{l}</span>
      ))}
    </div>
  )
}

function HBars({ rows, color, delay = 0.3 }: { rows: readonly (readonly [string, number])[]; color: string; delay?: number }) {
  return (
    <ul className="space-y-1.5">
      {rows.map(([l, v], i) => (
        <li key={l} className="flex items-center gap-2 text-[10.5px] text-brand-graphite">
          <span className="w-24 shrink-0 truncate text-right">{l}</span>
          <m.span
            className={cn('block h-2 rounded-sm', color)}
            style={{ width: `${v}%`, transformOrigin: 'left' }}
            initial={{ scaleX: 0 }}
            whileInView={{ scaleX: 1 }}
            viewport={viewportOnce}
            transition={{ duration: 0.7, ease: EASE, delay: delay + i * 0.04 }}
          />
        </li>
      ))}
    </ul>
  )
}

function EmpresaChart() {
  return (
    <div className="flex h-full flex-col">
      <div className="flex flex-1">
        <YAxis labels={['1,0K', '0,8K', '0,6K', '0,4K', '0,2K', '0,0']} />
        <div className="relative flex flex-1 items-end justify-center border-b border-brand-mist bg-[repeating-linear-gradient(180deg,transparent_0,transparent_calc(20%-1px),#E9E5F1_calc(20%-1px),#E9E5F1_20%)]">
          <GrowBar height="80%" delay={0.2} className="w-[42%] bg-[#C4507F]" />
        </div>
      </div>
      <p className="mt-2 text-center text-[11px] text-brand-graphite">Natcorp Do Brasil</p>
      <p className="mt-1 flex items-center justify-center gap-1.5 text-[10.5px] text-brand-graphite">
        <span className="h-2 w-2 bg-[#C4507F]" /> Colaborador X Empresa
      </p>
    </div>
  )
}

function FilialChart() {
  return (
    <div className="flex h-full flex-col">
      <div className="flex flex-1">
        <YAxis labels={['600', '500', '400', '300', '200', '100', '0']} />
        <div className="flex flex-1 items-end justify-around border-b border-brand-mist bg-[repeating-linear-gradient(180deg,transparent_0,transparent_calc(16.66%-1px),#E9E5F1_calc(16.66%-1px),#E9E5F1_16.66%)] px-2">
          {filiais.map((f, i) => (
            <GrowBar key={f.label} height={`${(f.v / 600) * 100}%`} delay={0.25 + i * 0.08} className="w-[16%] bg-[#C4507F]" />
          ))}
        </div>
      </div>
      <div className="ml-8 mt-1.5 grid grid-cols-4 gap-1 text-center text-[9.5px] leading-tight text-brand-graphite">
        {filiais.map((f) => (
          <span key={f.label}>{f.label}</span>
        ))}
      </div>
    </div>
  )
}

function PieCard() {
  return (
    <div className="flex h-full items-center gap-3">
      <svg viewBox="0 0 120 120" className="h-36 w-36 shrink-0">
        {pieSlices.map((sl, i) => (
          <path key={i} d={sl} fill={pie[i][0]} stroke="#fff" strokeWidth={0.6} />
        ))}
      </svg>
      <ul className="min-w-0 space-y-[3px] text-[10.5px] text-brand-graphite">
        {legend.map((l, i) => (
          <li key={l} className="flex items-center gap-1.5 truncate">
            <span className="h-2 w-2 shrink-0 rounded-[1px]" style={{ background: pie[i][0] }} />
            {l}
          </li>
        ))}
      </ul>
    </div>
  )
}

function Tiles() {
  return (
    <div className="grid h-full grid-cols-2 gap-2">
      {tiles.map((t) => (
        <div key={t.label} className={cn('flex flex-col justify-center rounded-md px-4 py-3 text-white', t.bg)}>
          <p className="text-[32px] font-semibold leading-none tabular">{t.n}</p>
          <p className="mt-2 truncate text-[12px] text-white">{t.label}</p>
        </div>
      ))}
    </div>
  )
}

/**
 * Painel do Operador (Indicadores Demográficos) reproduzido em HTML/CSS.
 * `layout="desktop"` (1180 × 760) ou `layout="tablet"` (820 × 640). Use dentro de um ScaledFrame.
 */
export function OperatorPanel({ layout = 'desktop', overlay }: { layout?: Layout; overlay?: ReactNode }) {
  const { width, height } = PANEL_SIZE[layout]
  const tablet = layout === 'tablet'
  return (
    <div className="relative overflow-hidden rounded-xl bg-[#F4F2F7] text-brand-ink shadow-lift" style={{ width, height }} aria-hidden>
      <div className="flex h-12 items-center gap-4 bg-brand-purple px-3 text-white">
        <span className="flex h-8 w-8 items-center justify-center rounded bg-white/15">
          <Menu className="h-4 w-4" />
        </span>
        <span className="text-[17px] font-medium">Painel do Operador</span>
        <span className="ml-auto flex items-center gap-5 text-[13px]">
          <Search className="h-4 w-4" />
          <span className="flex items-center gap-1.5">
            <Info className="h-4 w-4" />
            {!tablet && 'Manual'}
          </span>
          <span className="flex items-center gap-1.5">
            <BookOpen className="h-4 w-4" />
            {!tablet && 'Blog'}
          </span>
          <span className="flex items-center gap-1.5">
            <Bell className="h-4 w-4" />
            {tablet ? '[6]' : '[6] Notificações ▾'}
          </span>
          <span className="flex items-center gap-1.5">
            <User className="h-4 w-4" />
            {!tablet && '365785 ▾'}
          </span>
        </span>
      </div>

      <div className="flex h-[calc(100%-3rem)]">
        <aside className={cn('shrink-0 bg-[#2B2D36] py-1 text-[13px] text-white/85', tablet ? 'w-14' : 'w-[196px]')}>
          {menu.map(({ icon: Icon, label, active }) => (
            <div key={label} className={cn('flex items-center gap-3 px-4 py-[9px]', active && 'bg-white/10 text-white', tablet && 'justify-center px-0')}>
              <Icon className="h-4 w-4 shrink-0 text-[#C4507F]" strokeWidth={1.8} />
              {!tablet && label}
            </div>
          ))}
        </aside>

        <div className="flex min-w-0 flex-1 flex-col gap-4 overflow-hidden p-4">
          <div className="flex items-center justify-between rounded-lg border border-brand-mist border-l-[3px] border-l-brand-purple bg-white px-4 py-2.5">
            <p className="truncate text-[17px] font-semibold">
              Indicadores Demográficos <span className="text-[12px] font-normal text-brand-graphite">(04 de Setembro às 22:15)</span>
            </p>
            <span className="flex shrink-0 gap-2">
              <span className="flex items-center gap-1.5 rounded bg-brand-purple px-3 py-1.5 text-[12px] font-semibold text-white">
                Filtrar <Filter className="h-3.5 w-3.5" />
              </span>
              <span className="flex items-center rounded bg-brand-purple px-2.5 py-1.5 text-white">
                <ExternalLink className="h-3.5 w-3.5" />
              </span>
            </span>
          </div>

          <div className={cn('grid min-h-0 flex-1 gap-4', tablet ? 'grid-cols-2 grid-rows-2' : 'grid-cols-3 grid-rows-2')}>
            <Card title="Colaboradores X Empresa">
              <EmpresaChart />
            </Card>
            <Card title="Colaboradores X Filial">
              <FilialChart />
            </Card>
            {!tablet && (
              <Card title="Colaboradores X Centro de Custo">
                <PieCard />
              </Card>
            )}
            <Card title="Colaboradores X Local de Trabalho">
              <HBars rows={locais} color="bg-[#F0A34A]" />
            </Card>
            <Card title="Colaboradores X Unid. Administrativa">
              <Tiles />
            </Card>
            {!tablet && (
              <Card title="Colaboradores X Cargo">
                <HBars rows={cargos} color="bg-[#2E9E6B]" delay={0.4} />
              </Card>
            )}
          </div>
        </div>
      </div>

      <span className="absolute bottom-5 right-5 flex h-14 w-14 items-center justify-center rounded-full bg-[linear-gradient(135deg,#6A2E8E,#B4568F)] text-white shadow-lift">
        <MessageCircle className="h-6 w-6" strokeWidth={2} />
      </span>

      {overlay && <div className="absolute bottom-5 right-5 w-[520px]">{overlay}</div>}
    </div>
  )
}
