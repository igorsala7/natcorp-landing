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
  { label: 'Fil 10', v: 70 },
  { label: 'Fil 4', v: 90 },
  { label: 'Fil 97', v: 110 },
  { label: 'Fil 12', v: 60 },
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
] as const

const tiles = [
  { n: '571', label: 'Matriz - São Paulo', bg: 'bg-[#B1416E]' },
  { n: '97', label: 'Loja 97 - Escritório', bg: 'bg-brand-blue' },
  { n: '83', label: 'Loja 04 - Pompéia', bg: 'bg-brand-purple' },
  { n: '76', label: 'Loja 10 - Pará De Minas', bg: 'bg-[#2E9E6B]' },
]

const pie = [
  ['#C95788', 34],
  ['#511C76', 22],
  ['#2C1A63', 14],
  ['#9A408A', 10],
  ['#E4A9C4', 8],
  ['#8E88A3', 12],
] as const

/* Fatias da pizza pré-calculadas (evita recalcular a cada render). */
const pieSlices = (() => {
  let acc = 0
  const p = (a: number) => `${60 + 54 * Math.cos(a)},${60 + 54 * Math.sin(a)}`
  return pie.map(([, pct]) => {
    const a0 = (acc / 100) * 2 * Math.PI - Math.PI / 2
    acc += pct
    const a1 = (acc / 100) * 2 * Math.PI - Math.PI / 2
    return `M60,60 L${p(a0)} A54,54 0 ${pct > 50 ? 1 : 0} 1 ${p(a1)} Z`
  })
})()

function Card({ title, children, className }: { title: string; children: ReactNode; className?: string }) {
  return (
    <div className={cn('rounded-lg border border-brand-mist bg-white', className)}>
      <div className="flex items-center justify-between border-b border-brand-mist border-l-[3px] border-l-brand-purple px-4 py-3">
        <p className="text-[15px] font-semibold text-brand-ink">{title}</p>
        <ExternalLink className="h-3.5 w-3.5 text-brand-graphite" strokeWidth={1.8} aria-hidden />
      </div>
      <div className="p-4">{children}</div>
    </div>
  )
}

/**
 * Painel do Operador (desktop) com os Indicadores Demográficos, reproduzido em HTML/CSS.
 * Desenhado em 1180 × 720 px; use dentro de um ScaledFrame. `overlay` recebe a janela da NATI.
 */
export function OperatorPanel({ overlay }: { overlay?: ReactNode }) {
  return (
    <div className="relative h-[720px] w-[1180px] overflow-hidden rounded-xl bg-[#F4F2F7] text-brand-ink shadow-lift" aria-hidden>
      {/* barra superior */}
      <div className="flex h-12 items-center gap-4 bg-brand-purple px-3 text-white">
        <span className="flex h-8 w-8 items-center justify-center rounded bg-white/15">
          <Menu className="h-4 w-4" />
        </span>
        <span className="text-[17px] font-medium">Painel do Operador</span>
        <span className="ml-auto flex items-center gap-5 text-[13px]">
          <Search className="h-4 w-4" />
          <span className="flex items-center gap-1.5">
            <Info className="h-4 w-4" />
            Manual
          </span>
          <span className="flex items-center gap-1.5">
            <BookOpen className="h-4 w-4" />
            Blog
          </span>
          <span className="flex items-center gap-1.5">
            <Bell className="h-4 w-4" />
            [6] Notificações ▾
          </span>
          <span className="flex items-center gap-1.5">
            <User className="h-4 w-4" />
            365785 ▾
          </span>
        </span>
      </div>

      <div className="flex h-[calc(100%-3rem)]">
        {/* menu lateral */}
        <aside className="w-[196px] shrink-0 bg-[#2B2D36] py-1 text-[13px] text-white/85">
          {menu.map(({ icon: Icon, label, active }) => (
            <div key={label} className={cn('flex items-center gap-3 px-4 py-[9px]', active && 'bg-white/10 text-white')}>
              <Icon className="h-4 w-4 text-[#C4507F]" strokeWidth={1.8} />
              {label}
            </div>
          ))}
        </aside>

        {/* conteúdo */}
        <div className="flex-1 space-y-4 overflow-hidden p-5">
          <div className="flex items-center justify-between rounded-lg border border-brand-mist border-l-[3px] border-l-brand-purple bg-white px-4 py-3">
            <p className="text-[18px] font-semibold">
              Indicadores Demográficos <span className="text-[12px] font-normal text-brand-graphite">(04 de Setembro às 22:15)</span>
            </p>
            <span className="flex gap-2">
              <span className="flex items-center gap-1.5 rounded bg-brand-purple px-3 py-1.5 text-[12px] font-semibold text-white">
                Filtrar <Filter className="h-3.5 w-3.5" />
              </span>
              <span className="flex items-center rounded bg-brand-purple px-2.5 py-1.5 text-white">
                <ExternalLink className="h-3.5 w-3.5" />
              </span>
            </span>
          </div>

          <div className="grid grid-cols-3 gap-4">
            <Card title="Colaboradores X Empresa">
              <div className="flex h-36 items-end gap-2 border-b border-brand-mist pl-8">
                <span className="absolute text-[10px] text-brand-graphite" />
                <m.span
                  className="mx-auto block w-24 rounded-t-sm bg-[#C4507F]"
                  style={{ height: '78%', transformOrigin: 'bottom' }}
                  initial={{ scaleY: 0 }}
                  whileInView={{ scaleY: 1 }}
                  viewport={viewportOnce}
                  transition={{ duration: 0.8, ease: EASE, delay: 0.2 }}
                />
              </div>
              <p className="mt-1.5 text-center text-[11px] text-brand-graphite">Natcorp Do Brasil</p>
            </Card>
            <Card title="Colaboradores X Filial">
              <div className="flex h-36 items-end gap-3 border-b border-brand-mist px-3">
                {filiais.map((f, i) => (
                  <m.span
                    key={f.label}
                    className="block flex-1 rounded-t-sm bg-[#C4507F]"
                    style={{ height: `${f.v / 1.6}%`, transformOrigin: 'bottom' }}
                    initial={{ scaleY: 0 }}
                    whileInView={{ scaleY: 1 }}
                    viewport={viewportOnce}
                    transition={{ duration: 0.8, ease: EASE, delay: 0.25 + i * 0.08 }}
                  />
                ))}
              </div>
              <div className="mt-1.5 flex justify-around text-[10px] text-brand-graphite">
                {filiais.map((f) => (
                  <span key={f.label}>Natcorp {f.label}</span>
                ))}
              </div>
            </Card>
            <Card title="Colaboradores X Centro de Custo">
              <div className="flex items-center gap-4">
                <svg viewBox="0 0 120 120" className="h-36 w-36">
                  {pieSlices.map((sl, i) => (
                    <path key={i} d={sl} fill={pie[i][0]} />
                  ))}
                </svg>
                <ul className="space-y-1 text-[10.5px] text-brand-graphite">
                  {['Açougue', 'Adm De Rec…', 'Apoio Admin…', 'Aprendizagem', 'Arquivo', 'Auditoria'].map((l, i) => (
                    <li key={l} className="flex items-center gap-1.5">
                      <span className="h-2 w-2 rounded-sm" style={{ background: pie[i % pie.length][0] }} />
                      {l}
                    </li>
                  ))}
                </ul>
              </div>
            </Card>
            <Card title="Colaboradores X Local de Trabalho" className="col-span-1">
              <ul className="space-y-1.5">
                {locais.map(([l, v], i) => (
                  <li key={l} className="flex items-center gap-2 text-[10.5px] text-brand-graphite">
                    <span className="w-24 shrink-0 truncate text-right">{l}</span>
                    <m.span
                      className="block h-2 rounded-sm bg-[#F0A34A]"
                      style={{ width: `${v}%`, transformOrigin: 'left' }}
                      initial={{ scaleX: 0 }}
                      whileInView={{ scaleX: 1 }}
                      viewport={viewportOnce}
                      transition={{ duration: 0.7, ease: EASE, delay: 0.3 + i * 0.05 }}
                    />
                  </li>
                ))}
              </ul>
            </Card>
            <Card title="Colaboradores X Unid. Administrativa" className="col-span-2">
              <div className="grid grid-cols-4 gap-2">
                {tiles.map((t) => (
                  <div key={t.label} className={cn('rounded-md p-4 text-white', t.bg)}>
                    <p className="text-[34px] font-semibold leading-none tabular">{t.n}</p>
                    <p className="mt-2 text-[12px] text-white">{t.label}</p>
                  </div>
                ))}
              </div>
            </Card>
          </div>
        </div>
      </div>

      {overlay && <div className="absolute bottom-5 right-5 w-[520px]">{overlay}</div>}
    </div>
  )
}
