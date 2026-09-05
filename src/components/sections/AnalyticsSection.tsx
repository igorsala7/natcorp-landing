import { useState } from 'react'
import { Link } from 'react-router'
import { AnimatePresence, m } from 'motion/react'
import { ArrowRight, BarChart3, Download, LayoutDashboard, Sparkles, Table2 } from 'lucide-react'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import { ANALYTICS_SIZE } from '@/components/mockups/analytics/shell'
import { MedicineIndicators } from '@/components/mockups/analytics/MedicineIndicators'
import { FinancialComparison, type ComparisonMode } from '@/components/mockups/analytics/FinancialComparison'
import { modulePath } from '@/content/modulePages'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'

const tabs = [
  { id: 'prontos', label: 'Painéis prontos', hint: 'Indicadores de Medicina Ocupacional' },
  { id: 'proprio', label: 'Monte o seu', hint: 'Comparativo financeiro entre dois períodos' },
] as const

type TabId = (typeof tabs)[number]['id']

const points = [
  { icon: LayoutDashboard, title: 'Painéis prontos por área', text: 'Demográficos, medicina, ponto, folha, recrutamento: indicadores por unidade, área, gestor e centro de custo.' },
  { icon: BarChart3, title: 'Qualquer listagem vira gráfico', text: 'Com o botão Ações, filtre, agrupe, cruze e escolha pizza, barras ou linhas. Sem pedir nada à TI.' },
  { icon: Table2, title: 'Gráfico e tabela, lado a lado', text: 'Alterne entre a visão gráfica e a tabela com destaques, como as diferenças negativas entre dois meses.' },
  { icon: Download, title: 'Salve e exporte', text: 'Relatório salvo, público ou privado, e exportação em CSV, Excel ou PDF para a próxima reunião.' },
]

/** Resumo do People Analytics na home: painéis prontos e o criador de gráficos, em HTML/CSS. */
export function AnalyticsSection() {
  const [tab, setTab] = useState<TabId>('prontos')
  const [mode, setMode] = useState<ComparisonMode>('chart')
  return (
    <Section id="analytics" tone="off" className="overflow-hidden" aria-labelledby="analytics-title">
      <div className="container">
        <SectionHeader
          id="analytics-title"
          align="center"
          eyebrow="People Analytics · Business Intelligence"
          title="Painéis prontos ou o gráfico [[que você quiser]]."
          lead="Os dados de todos os módulos, em tempo real, no Painel do Operador. Consulte os indicadores prontos ou monte a sua própria análise, com filtros, cruzamentos e o tipo de gráfico que contar melhor a história."
        />

        <Reveal delay={0.1} className="mt-12 lg:mt-16">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div role="tablist" aria-label="Exemplos do People Analytics" className="inline-flex rounded-xl border border-brand-mist bg-white p-1 shadow-soft">
              {tabs.map((t) => (
                <button
                  key={t.id}
                  id={`analytics-tab-${t.id}`}
                  role="tab"
                  type="button"
                  aria-selected={tab === t.id}
                  aria-controls="analytics-panel"
                  onClick={() => setTab(t.id)}
                  className={cn('rounded-lg px-4 py-2 text-sm font-semibold transition-colors duration-300', tab === t.id ? 'bg-brand-purple text-white' : 'text-brand-graphite hover:text-brand-purple')}
                >
                  {t.label}
                </button>
              ))}
            </div>
            <div className="flex items-center gap-3">
              <p className="hidden text-sm text-brand-graphite sm:block">{tabs.find((t) => t.id === tab)?.hint}</p>
              {tab === 'proprio' && (
                <div className="inline-flex rounded-lg border border-brand-mist bg-white p-0.5 text-[13px] font-semibold" role="group" aria-label="Modo de visualização">
                  {(['chart', 'table'] as const).map((mo) => (
                    <button
                      key={mo}
                      type="button"
                      aria-pressed={mode === mo}
                      onClick={() => setMode(mo)}
                      className={cn('inline-flex items-center gap-1.5 rounded-md px-3 py-1.5 transition-colors duration-300', mode === mo ? 'bg-brand-off-white text-brand-purple' : 'text-brand-graphite hover:text-brand-purple')}
                    >
                      {mo === 'chart' ? <BarChart3 className="h-3.5 w-3.5" aria-hidden /> : <Table2 className="h-3.5 w-3.5" aria-hidden />}
                      {mo === 'chart' ? 'Gráfico' : 'Tabela'}
                    </button>
                  ))}
                </div>
              )}
            </div>
          </div>

          <div
            id="analytics-panel"
            role="tabpanel"
            aria-labelledby={`analytics-tab-${tab}`}
            className="relative mt-5 rounded-2xl border border-brand-mist bg-white p-2 shadow-lift sm:p-3"
          >
            <AnimatePresence mode="wait" initial={false}>
              <m.div
                key={`${tab}-${mode}`}
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: -6 }}
                transition={{ duration: 0.35, ease: EASE }}
                role="img"
                aria-label={
                  tab === 'prontos'
                    ? 'Painel do Operador com os indicadores de Medicina Ocupacional: procedimentos, tipos de procedimento, unidades de atendimento e profissionais'
                    : mode === 'chart'
                      ? 'Comparativo de históricos financeiros entre abril e maio de 2025 em gráfico de barras, com filtros e o botão Editar Gráfico'
                      : 'Comparativo de históricos financeiros entre abril e maio de 2025 em tabela, com as diferenças negativas destacadas'
                }
              >
                <ScaledFrame width={ANALYTICS_SIZE.width} height={ANALYTICS_SIZE.height}>
                  {tab === 'prontos' ? <MedicineIndicators /> : <FinancialComparison mode={mode} />}
                </ScaledFrame>
              </m.div>
            </AnimatePresence>
          </div>
        </Reveal>

        <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-4" stagger={0.08}>
          {points.map(({ icon: Icon, title, text }) => (
            <StaggerItem key={title} className="rounded-2xl border border-brand-mist bg-white p-6">
              <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple">
                <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
              </span>
              <h3 className="mt-4 text-[17px] font-bold text-brand-ink">{title}</h3>
              <p className="mt-2 text-[14.5px] leading-relaxed text-brand-graphite">{text}</p>
            </StaggerItem>
          ))}
        </Stagger>

        <Reveal delay={0.15} className="mt-10 flex flex-wrap items-center justify-center gap-x-8 gap-y-3 text-sm">
          <Link to={modulePath('people-analytics')} className="group inline-flex items-center gap-2 font-semibold text-brand-purple">
            <Sparkles className="h-4 w-4" aria-hidden />
            Ver o People Analytics tela a tela
            <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
          </Link>
          <Link to={modulePath('business-intelligence')} className="group inline-flex items-center gap-2 font-semibold text-brand-graphite hover:text-brand-purple">
            Business Intelligence
            <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
          </Link>
        </Reveal>
      </div>
    </Section>
  )
}
