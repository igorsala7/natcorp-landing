import { m } from 'motion/react'
import {
  BarChart3,
  Clock,
  FileSignature,
  HeartPulse,
  LayoutDashboard,
  Sparkles,
  UserPlus,
  Users,
  Wallet,
} from 'lucide-react'
import { Logo } from '@/components/brand/Logo'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

/* Dados de exemplo do manual de identidade (seção 15 — Produto SaaS). */
const kpis = [
  { label: 'Headcount ativo', value: '12.480', delta: '+2,1% no mês', up: true },
  { label: 'Custo de folha', value: 'R$ 84,2 mi', delta: '−1,4% vs. plano', up: true },
  { label: 'Turnover 12m', value: '8,6%', delta: '−0,9 p.p.', up: true },
  { label: 'Admissões digitais', value: '318', delta: 'no mês, sem papel', up: null },
]

const bars = [62, 74, 70, 82, 78, 88, 84, 91, 87, 94, 90, 96]

const nav = [
  { icon: LayoutDashboard, label: 'Visão geral', active: true },
  { icon: Wallet, label: 'Folha de Pagamento' },
  { icon: Clock, label: 'Ponto Eletrônico' },
  { icon: FileSignature, label: 'Admissão Digital' },
  { icon: HeartPulse, label: 'Medicina e Segurança' },
  { icon: UserPlus, label: 'Recrutamento e Seleção' },
  { icon: Users, label: 'Avaliações' },
  { icon: BarChart3, label: 'People Analytics' },
]

const nati = [
  '12 ASOs vencem nos próximos 15 dias — agendar exames.',
  '3 marcações de ponto pendentes de abono antes da folha.',
  'Requisição de vaga aprovada: processo seletivo aberto.',
]

export function DashboardMockup({ className }: { className?: string }) {
  return (
    <div
      className={cn(
        'overflow-hidden rounded-2xl border border-white/20 bg-white text-brand-ink shadow-glow',
        className,
      )}
      role="img"
      aria-label="Tela do sistema Natcorp: visão geral com headcount, custo de folha, turnover, admissões digitais e sugestões da NATI"
    >
      <div className="grid md:grid-cols-[196px_1fr]">
        {/* Navegação em Azul Profundo */}
        <aside className="hidden flex-col bg-brand-blue p-4 text-white md:flex">
          <Logo tone="white" className="h-5 w-auto" decorative />
          <ul className="mt-6 space-y-0.5 text-[11.5px] font-medium">
            {nav.map(({ icon: Icon, label, active }) => (
              <li
                key={label}
                className={cn(
                  'flex items-center gap-2 rounded-md px-2.5 py-1.5',
                  active ? 'bg-white/12 text-white' : 'text-white/60',
                )}
              >
                <Icon className="h-3.5 w-3.5" strokeWidth={1.6} />
                {label}
              </li>
            ))}
          </ul>
          <div className="mt-auto flex items-center gap-2 pt-6 text-[10.5px] text-white/60">
            <span className="h-6 w-6 rounded-full bg-brand-plum" />
            Nome Sobrenome · Admin
          </div>
        </aside>

        {/* Área de trabalho */}
        <div className="p-4 sm:p-5">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div>
              <p className="text-[15px] font-bold">Visão geral</p>
              <p className="text-[11px] text-brand-graphite">Setembro de 2026 · 12.480 colaboradores</p>
            </div>
            <div className="flex gap-2 text-[11px] font-semibold">
              <span className="rounded-md border border-brand-mist px-2.5 py-1">Exportar</span>
              <span className="rounded-md bg-brand-purple px-2.5 py-1 text-white">Fechar folha</span>
            </div>
          </div>

          <div className="mt-4 grid grid-cols-2 gap-2.5 lg:grid-cols-4">
            {kpis.map((k) => (
              <div key={k.label} className="rounded-lg border border-brand-mist p-3">
                <p className="text-[10.5px] text-brand-graphite">{k.label}</p>
                <p className="mt-1 text-[17px] font-extrabold tabular tracking-brand">{k.value}</p>
                <p className={cn('mt-0.5 text-[10.5px] font-medium', k.up ? 'text-emerald-700' : 'text-brand-graphite')}>
                  {k.delta}
                </p>
              </div>
            ))}
          </div>

          <div className="mt-2.5 grid gap-2.5 lg:grid-cols-[1.35fr_1fr]">
            <div className="rounded-lg border border-brand-mist p-3">
              <div className="flex items-center justify-between">
                <p className="text-[11px] font-semibold">Requisições atendidas no prazo</p>
                <p className="text-[10.5px] text-brand-graphite">últimos 12 meses</p>
              </div>
              <m.div
                className="mt-3 flex h-24 items-end gap-1.5"
                initial="hidden"
                whileInView="visible"
                viewport={viewportOnce}
                variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.05, delayChildren: 0.3 } } }}
              >
                {bars.map((h, i) => (
                  <m.div
                    key={i}
                    className={cn('flex-1 rounded-t-sm', i === bars.length - 1 ? 'bg-brand-pink' : 'bg-brand-purple/85')}
                    style={{ height: `${h}%`, transformOrigin: 'bottom' }}
                    variants={{
                      hidden: { scaleY: 0, opacity: 0.4 },
                      visible: { scaleY: 1, opacity: 1, transition: { duration: 0.7, ease: EASE } },
                    }}
                  />
                ))}
              </m.div>
            </div>

            <div className="rounded-lg border border-brand-purple/25 bg-brand-off-white/70 p-3">
              <div className="flex items-center gap-1.5 text-[11px] font-semibold text-brand-purple">
                <Sparkles className="h-3.5 w-3.5" strokeWidth={1.8} />
                NATI · sugestões de hoje
              </div>
              <ul className="mt-2 space-y-1.5 text-[10.5px] leading-snug text-brand-graphite">
                {nati.map((t, i) => (
                  <m.li
                    key={t}
                    className="flex gap-1.5"
                    initial={{ opacity: 0, x: 8 }}
                    whileInView={{ opacity: 1, x: 0 }}
                    viewport={viewportOnce}
                    transition={{ duration: 0.5, ease: EASE, delay: 0.6 + i * 0.15 }}
                  >
                    <span className="mt-[5px] h-1 w-1 shrink-0 rounded-full bg-brand-pink" />
                    {t}
                  </m.li>
                ))}
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
