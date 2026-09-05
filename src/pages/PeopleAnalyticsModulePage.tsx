import { useState, type ReactNode } from 'react'
import { Link } from 'react-router'
import { AnimatePresence, m } from 'motion/react'
import { ArrowRight, BarChart3, Check, Database, Download, Filter, Layers, PieChart, Save, Sparkles, Table2 } from 'lucide-react'
import { Section, SectionHeader, Eyebrow } from '@/components/sections/Section'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { BenefitsGrid, FeaturesGrid, PersonasGrid, RelatedModules } from '@/components/modules/blocks'
import { OperatorPanel, PANEL_SIZE } from '@/components/mockups/nati/OperatorPanel'
import { ANALYTICS_SIZE } from '@/components/mockups/analytics/shell'
import { MedicineIndicators } from '@/components/mockups/analytics/MedicineIndicators'
import { FinancialComparison, type ComparisonMode } from '@/components/mockups/analytics/FinancialComparison'
import { RecruitmentModal } from '@/components/mockups/analytics/RecruitmentModal'
import { getGroup, getModuleEntry, type ModuleEntry } from '@/content/modulePages'
import type { ModulePage as ModulePageData } from '@/content/modulePages/types'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { ImplantationBlock, ModuleFaqAccordion, ModuleNav, SeeAlsoStrip } from './ModulePage'

const actions = [
  { icon: Filter, title: 'Filtrar e selecionar colunas', text: 'Mostre só o que importa: colaboradores ativos de um centro de custo, rubricas de um tipo, um período.' },
  { icon: Layers, title: 'Agrupar, quebrar e cruzar', text: 'Quebra de controle por filial ou cargo, soma e média por coluna, pivô cruzando dois eixos.' },
  { icon: Sparkles, title: 'Destacar desvios', text: 'Uma regra colore linhas ou células. No comparativo, as diferenças negativas ficam em rosa.' },
  { icon: PieChart, title: 'Gerar e editar o gráfico', text: 'Pizza, barras ou linhas a partir de qualquer cruzamento, com o botão Editar Gráfico para ajustar eixos e séries.' },
  { icon: Save, title: 'Salvar como relatório', text: 'Público, para a equipe, ou privado, só para você. A análise vira consulta recorrente.' },
  { icon: Download, title: 'Exportar', text: 'CSV, Excel ou PDF, e a imagem do gráfico com o ícone de câmera em cada card.' },
]

function Frame({ label, children, className }: { label: string; children: ReactNode; className?: string }) {
  return (
    <div role="img" aria-label={label} className={cn('rounded-2xl border border-brand-mist bg-white p-2 shadow-lift sm:p-3', className)}>
      {children}
    </div>
  )
}

export default function PeopleAnalyticsModulePage({ entry, page }: { entry: ModuleEntry; page: ModulePageData }) {
  const group = getGroup(entry.group)
  const related = page.related.map(getModuleEntry).filter((r): r is ModuleEntry => Boolean(r))
  const [mode, setMode] = useState<ComparisonMode>('chart')

  return (
    <PageTransition>
      <Section tone="off" className="overflow-hidden pb-16 pt-[calc(var(--nav-h)+2.5rem)] sm:pt-[calc(var(--nav-h)+3.5rem)] lg:pb-24" aria-labelledby="module-title">
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[36%] h-[150%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Módulos', to: '/modulos' }, { label: group.name, to: `/modulos#${group.id}` }, { label: entry.name }]} />
          <div className="mt-8 grid grid-cols-1 items-center gap-12 lg:grid-cols-[1fr_1.15fr] lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>{group.name} · People Analytics</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="module-title"
                text={page.tagline}
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-[3.4rem]"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-xl text-lg leading-relaxed text-brand-graphite sm:text-xl">{page.summary}</p>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <Link to="#contato">
                    Agendar demonstração
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
                <Button asChild size="lg" variant="secondary">
                  <Link to="#criar">Ver como se monta um gráfico</Link>
                </Button>
              </Reveal>
              <Stagger className="mt-10 grid grid-cols-2 gap-x-6 gap-y-6 sm:grid-cols-3" delay={0.4}>
                {page.highlights.map((h) => (
                  <StaggerItem key={h.label}>
                    <p className="text-2xl font-extrabold tracking-brand text-brand-purple sm:text-3xl">{h.value}</p>
                    <p className="mt-1 text-sm leading-snug text-brand-graphite">{h.label}</p>
                  </StaggerItem>
                ))}
              </Stagger>
            </div>

            <m.div initial={{ opacity: 0, y: 28 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.9, ease: EASE, delay: 0.25 }} className="relative min-w-0">
              <div aria-hidden className="pointer-events-none absolute -inset-6 rounded-[2rem] bg-[radial-gradient(60%_60%_at_50%_40%,rgba(154,64,138,0.18),transparent_70%)]" />
              <Frame label="Painel do Operador com os Indicadores Demográficos: colaboradores por empresa, filial, centro de custo, local de trabalho, unidade administrativa e cargo" className="relative">
                <ScaledFrame width={PANEL_SIZE.desktop.width} height={PANEL_SIZE.desktop.height}>
                  <OperatorPanel layout="desktop" />
                </ScaledFrame>
              </Frame>
            </m.div>
          </div>
        </div>
      </Section>

      {/* Painéis prontos */}
      <Section id="paineis" tone="white" className="overflow-hidden" aria-labelledby="paineis-title">
        <div className="container">
          <SectionHeader
            id="paineis-title"
            eyebrow="Painéis prontos"
            title="Indicadores prontos para [[cada área do RH]]."
            lead="Demográficos, Medicina Ocupacional, ponto, folha, recrutamento. Cada card mostra percentual ou quantidade, vira pizza ou barras e exporta como imagem com um clique."
          />
          <Reveal delay={0.1} className="mt-12">
            <Frame label="Painel do Operador com os indicadores de Medicina Ocupacional: procedimentos por tipo em barras, tipos de procedimento em pizza, unidades de atendimento e profissionais em percentuais">
              <ScaledFrame width={ANALYTICS_SIZE.width} height={ANALYTICS_SIZE.height}>
                <MedicineIndicators />
              </ScaledFrame>
            </Frame>
          </Reveal>
          <Stagger className="mt-8 grid gap-4 sm:grid-cols-3" stagger={0.08}>
            {[
              { t: 'Filtros no topo', d: 'Empresa, filial, período e o que mais a área precisar. Pesquisar e limpar em um clique.' },
              { t: 'Cada card, do seu jeito', d: 'Percentual ou quantidade, pizza ou barras. O ícone de câmera salva a imagem para a apresentação.' },
              { t: 'Sempre atualizado', d: 'O painel lê o dado vivo do sistema, com a data e a hora da última atualização no cabeçalho.' },
            ].map((p) => (
              <StaggerItem key={p.t} className="flex items-start gap-3 rounded-2xl border border-brand-mist bg-brand-off-white p-5">
                <span className="mt-0.5 flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                  <Check className="h-3.5 w-3.5" strokeWidth={3} aria-hidden />
                </span>
                <span>
                  <span className="block text-[15px] font-bold text-brand-ink">{p.t}</span>
                  <span className="mt-1 block text-[14px] leading-relaxed text-brand-graphite">{p.d}</span>
                </span>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      {/* Monte o seu */}
      <Section id="criar" tone="off" className="overflow-hidden" aria-labelledby="criar-title">
        <div className="container">
          <div className="flex flex-wrap items-end justify-between gap-6">
            <SectionHeader
              id="criar-title"
              eyebrow="Monte o seu"
              title="Da tabela ao gráfico, [[sem sair da tela]]."
              lead="O comparativo de históricos financeiros entre abril e maio: os mesmos dados em tabela, com as diferenças negativas destacadas, ou em gráfico, com o botão Editar Gráfico para ajustar o que quiser."
            />
            <div className="inline-flex rounded-xl border border-brand-mist bg-white p-1 shadow-soft" role="group" aria-label="Modo de visualização">
              {(['table', 'chart'] as const).map((mo) => (
                <button
                  key={mo}
                  type="button"
                  aria-pressed={mode === mo}
                  onClick={() => setMode(mo)}
                  className={cn('inline-flex items-center gap-2 rounded-lg px-4 py-2 text-sm font-semibold transition-colors duration-300', mode === mo ? 'bg-brand-purple text-white' : 'text-brand-graphite hover:text-brand-purple')}
                >
                  {mo === 'chart' ? <BarChart3 className="h-4 w-4" aria-hidden /> : <Table2 className="h-4 w-4" aria-hidden />}
                  {mo === 'chart' ? 'Gráfico' : 'Tabela'}
                </button>
              ))}
            </div>
          </div>

          <div className="mt-8">
            <AnimatePresence mode="wait" initial={false}>
              <m.div key={mode} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -6 }} transition={{ duration: 0.35, ease: EASE }}>
                <Frame
                  label={
                    mode === 'chart'
                      ? 'Comparativo de históricos financeiros entre abril e maio de 2025 em gráfico de barras, com filtros de empresa e períodos e o botão Editar Gráfico'
                      : 'Comparativo de históricos financeiros entre abril e maio de 2025 em tabela, com as linhas de diferença negativa destacadas em rosa'
                  }
                >
                  <ScaledFrame width={ANALYTICS_SIZE.width} height={ANALYTICS_SIZE.height}>
                    <FinancialComparison mode={mode} />
                  </ScaledFrame>
                </Frame>
              </m.div>
            </AnimatePresence>
          </div>

          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-3" stagger={0.08}>
            {actions.map(({ icon: Icon, title, text }, i) => (
              <StaggerItem key={title} className="relative rounded-2xl border border-brand-mist bg-white p-6">
                <span className="absolute right-5 top-5 text-[11px] font-bold tabular text-brand-graphite">{String(i + 1).padStart(2, '0')}</span>
                <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple">
                  <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                </span>
                <h3 className="mt-4 text-[17px] font-bold text-brand-ink">{title}</h3>
                <p className="mt-2 text-[14.5px] leading-relaxed text-brand-graphite">{text}</p>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      {/* Qualquer listagem */}
      <Section id="listagem" tone="white" className="overflow-hidden" aria-labelledby="listagem-title">
        <div className="container">
          <div className="grid grid-cols-1 items-center gap-10 lg:grid-cols-[1fr_1.5fr] lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Qualquer listagem</Eyebrow>
              </Reveal>
              <Reveal delay={0.08}>
                <h2 id="listagem-title" className="mt-4 text-3xl font-extrabold leading-tight text-brand-ink sm:text-4xl">
                  Do Recrutamento à Folha, <span className="text-brand-purple">toda lista vira análise.</span>
                </h2>
              </Reveal>
              <Reveal delay={0.16}>
                <p className="mt-5 text-[16.5px] leading-relaxed text-brand-graphite">
                  Aqui, a lista de candidatos do Recrutamento e Seleção virou um gráfico de candidatos por cargo em segundos: Ações, gráfico, pronto. O mesmo vale para
                  colaboradores, ponto, benefícios, treinamentos e SESMT, porque todos compartilham o mesmo cadastro.
                </p>
              </Reveal>
              <Reveal delay={0.22}>
                <ul className="mt-6 space-y-2.5">
                  {['Relatório primário ou os relatórios salvos pela equipe', 'Alternância entre tabela e gráfico na própria barra', 'Ações: filtrar, agrupar, pivô, destacar, gráfico, salvar, exportar'].map((b) => (
                    <li key={b} className="flex items-start gap-3 text-[15px] text-brand-ink">
                      <span className="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                        <Check className="h-3 w-3" strokeWidth={3} aria-hidden />
                      </span>
                      {b}
                    </li>
                  ))}
                </ul>
              </Reveal>
            </div>
            <Reveal delay={0.15} className="min-w-0">
              <Frame label="Janela Recrutamento e Seleção sobre o Painel do Operador, com o gráfico de candidatos por cargo gerado a partir da listagem">
                <ScaledFrame width={ANALYTICS_SIZE.width} height={ANALYTICS_SIZE.height}>
                  <RecruitmentModal />
                </ScaledFrame>
              </Frame>
            </Reveal>
          </div>
        </div>
      </Section>

      <Section id="beneficios" tone="off" aria-labelledby="beneficios-title">
        <div className="container">
          <SectionHeader id="beneficios-title" eyebrow="O que muda" title="O que muda com [[o People Analytics]]." />
          <BenefitsGrid items={page.benefits} />
        </div>
      </Section>

      <Section id="funcionalidades" tone="white" aria-labelledby="funcionalidades-title">
        <div className="container">
          <SectionHeader id="funcionalidades-title" eyebrow="Funcionalidades" title="O que o People Analytics [[faz]]." lead="Funcionalidades que existem hoje no sistema, descritas na linguagem de quem usa." />
          <FeaturesGrid items={page.features} />
        </div>
      </Section>

      <Section id="conexoes" tone="dark" className="overflow-hidden" aria-labelledby="conexoes-title">
        <LogoOutline className="pointer-events-none absolute -left-[10%] -top-[40%] h-[150%] w-auto text-white/[0.06]" />
        <div className="container relative grid grid-cols-1 gap-12 lg:grid-cols-2 lg:gap-16">
          <div>
            <Reveal y={12} duration={0.5}>
              <Eyebrow tone="white">Dados de todos os módulos</Eyebrow>
            </Reveal>
            <Reveal delay={0.08}>
              <h2 id="conexoes-title" className="mt-4 text-3xl font-extrabold leading-tight sm:text-4xl">
                Um cadastro só. Por isso o cruzamento é nativo.
              </h2>
            </Reveal>
            <Reveal delay={0.16}>
              <p className="mt-4 text-[16px] leading-relaxed text-white/80">
                Folha, ponto, benefícios, cargos, avaliações e SESMT entram na mesma análise porque nasceram na mesma base. E a NATI lê os indicadores gerados e explica, em linguagem
                natural, o que mudou e por quê.
              </p>
            </Reveal>
            <Reveal delay={0.22} className="mt-6 flex items-start gap-3 rounded-2xl border border-white/10 bg-white/[0.05] p-4 text-[14px] text-white/85">
              <Database className="mt-0.5 h-4 w-4 shrink-0 text-[#E4A9C4]" aria-hidden />
              <span>A informação não sai do sistema para ser analisada: perfis de acesso e segurança continuam valendo dentro da análise.</span>
            </Reveal>
          </div>
          <div>
            <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-white/60">Conecta com</p>
            <RelatedModules items={related} />
          </div>
        </div>
      </Section>

      {page.personas && page.personas.length > 0 && (
        <Section id="para-quem" tone="off" aria-labelledby="personas-title">
          <div className="container">
            <SectionHeader id="personas-title" eyebrow="Para quem" title="Quem ganha com [[o People Analytics]]." />
            <PersonasGrid items={page.personas} />
          </div>
        </Section>
      )}

      <Section id="perguntas" tone="white" aria-labelledby="perguntas-title">
        <div className="container grid grid-cols-1 gap-10 lg:grid-cols-[1fr_1.4fr] lg:gap-16">
          <div>
            <SectionHeader id="perguntas-title" eyebrow="Perguntas frequentes" title="Dúvidas sobre [[o People Analytics]]." />
          </div>
          <div>
            <ModuleFaqAccordion items={page.faq} />
          </div>
        </div>
      </Section>

      <ImplantationBlock tone="off" />
      <SeeAlsoStrip tone="white" />
      <ModuleNav slug={entry.slug} />

      <CTASection title="Veja o People Analytics com os indicadores da sua empresa." />
    </PageTransition>
  )
}
