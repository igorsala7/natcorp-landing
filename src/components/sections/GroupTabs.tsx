import { useRef, useState } from 'react'
import type { KeyboardEvent, ReactNode } from 'react'
import { Link } from 'react-router'
import { m } from 'motion/react'
import { ChevronRight } from 'lucide-react'
import { Section, SectionHeader } from './Section'
import { Reveal } from '@/components/motion/Reveal'
import { FitFrame, ScaledFrame } from '@/components/motion/ScaledFrame'
import { DashboardMockup } from '@/components/mockups/DashboardMockup'
import { SesmtMockup } from '@/components/mockups/SesmtMockup'
import { AdmissionMockup } from '@/components/mockups/AdmissionMockup'
import { EMPLOYEE_CARD_SIZE, EmployeeCardMockup } from '@/components/mockups/EmployeeCardMockup'
import { RequestMockup } from '@/components/mockups/RequestMockup'
import { NATPONTO_SIZE } from '@/components/mockups/natponto/NatPontoFrame'
import { NatPontoPhone } from '@/components/mockups/natponto/screens'
import { Conversation, NatiBubble, NatiChatWindow, UserBubble } from '@/components/mockups/nati/NatiChatWindow'
import { NatiChartCard } from '@/components/mockups/nati/NatiChartCard'
import { groups, modulePath, modulesByGroup } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import type { GroupId } from '@/content/modulePages/types'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'

/** Duas frases por frente: o que ela resolve no dia a dia. */
const descriptions: Record<GroupId, string> = {
  'pessoal-e-folha':
    'Folha, headcount, cargos, benefícios e eSocial calculados sobre o mesmo cadastro, com o ponto já apurado. O Departamento Pessoal fecha o mês sem redigitar nada e acompanha cada evento do eSocial na mesma tela.',
  'ponto-e-jornada':
    'A marcação chega do NatPonto ou do relógio, a apuração segue a jornada e a escala de cada pessoa, e as horas certas entram na folha. Banco de horas, abonos e exceções ficam visíveis para o gestor antes do fechamento.',
  'saude-e-seguranca':
    'ASO, PCMSO, PGR, EPIs e CAT no mesmo sistema em que vivem a admissão, o cargo e o afastamento. O SESMT enxerga os vencimentos com antecedência e os eventos de SST do eSocial saem sem retrabalho.',
  talentos:
    'Da requisição da vaga à assinatura do contrato, tudo acontece em um fluxo só, sem papel. Quem é aprovado vira colaborador na folha, no ponto e nos benefícios com poucos cliques.',
  desenvolvimento:
    'Avaliações, metas, treinamentos e sucessão usam os mesmos dados de cargo, equipe e histórico. O gestor acompanha a evolução de cada pessoa e o RH prepara os próximos passos com base em fatos.',
  autoatendimento:
    'Gestor, colaborador e candidato resolvem o que precisam nos portais, no celular ou no computador. Cada pedido segue o fluxo de aprovação e é efetivado no sistema sem passar pelo RH.',
  'dados-ia-plataforma':
    'Todos os módulos alimentam os painéis, os relatórios e a NATI, que responde em linguagem natural e gera gráficos na hora. Tudo em nuvem segura, com APIs prontas para conversar com os outros sistemas da empresa.',
}

/** Média salarial de exemplo para o gráfico gerado pela NATI. */
const payByRole = {
  labels: ['Supervisor de Setor', 'Analista de Operações', 'Técnico de Segurança', 'Assistente de DP', 'Auxiliar Administrativo'],
  values: [8900, 6400, 5200, 3900, 2800],
}

const chartIn = { hidden: { opacity: 0, y: 12 }, visible: { opacity: 1, y: 0, transition: { duration: 0.5, ease: EASE } } }

interface Visual {
  /** Descrição do visual para leitores de tela. */
  label: string
  /** Legenda curta exibida sob o cartão. */
  caption: string
  render: () => ReactNode
}

/** Um visual por frente. Só o da aba ativa é montado. */
const visuals: Record<GroupId, Visual> = {
  'pessoal-e-folha': {
    label: 'Tela do sistema Natcorp com a visão geral do mês: headcount, custo de folha, turnover, admissões digitais, requisições no prazo e sugestões da NATI',
    caption: 'Painel do Operador: a visão geral do mês, com a folha pronta para fechar',
    render: () => (
      <FitFrame width={880}>
        <DashboardMockup className="border-brand-mist shadow-soft" />
      </FitFrame>
    ),
  },
  'ponto-e-jornada': {
    label: 'App NatPonto na tela inicial: relógio, dados da colaboradora, escala do dia e botão Registrar Ponto',
    caption: 'NatPonto: a tela inicial, com a escala do dia e um toque para registrar',
    render: () => (
      <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height} className="mx-auto w-[220px]">
        <NatPontoPhone screen="home" />
      </ScaledFrame>
    ),
  },
  'saude-e-seguranca': {
    label: 'Tela do SESMT: exames dos próximos 15 dias, a cadeia que vai do ASO ao eSocial e os eventos de saúde e segurança já enviados',
    caption: 'Medicina Ocupacional: os próximos exames e os eventos de SST do eSocial',
    render: () => <SesmtMockup className="shadow-soft" />,
  },
  talentos: {
    label: 'Tela da Admissão Digital: etapas da admissão de Ana Ribeiro, com dados, documentos e o contrato de trabalho pronto para assinar',
    caption: 'Admissão Digital: etapas concluídas e contrato pronto para assinar',
    render: () => <AdmissionMockup className="shadow-soft" />,
  },
  desenvolvimento: {
    label: 'Painel do Operador no celular com os dados da colaboradora: matrícula, cargo, situação, admissão, empresa, filial e centro de custo',
    caption: 'Dados do Colaborador no celular: cargo, histórico e situação em uma tela',
    render: () => (
      <ScaledFrame width={EMPLOYEE_CARD_SIZE.width} height={EMPLOYEE_CARD_SIZE.height} className="mx-auto w-[220px]">
        <EmployeeCardMockup />
      </ScaledFrame>
    ),
  },
  autoatendimento: {
    label: 'Requisição de férias no fluxo de aprovação: pedido do colaborador, aprovação do gestor, conferência do RH e efetivação na folha',
    caption: 'Requisição de férias: aprovada no fluxo e efetivada na folha',
    render: () => <RequestMockup className="shadow-soft" />,
  },
  'dados-ia-plataforma': {
    label: 'Conversa com a NATI: pergunta sobre a média salarial por cargo e resposta com análise e gráfico de barras gerado na hora',
    caption: 'NATI: pergunta em linguagem natural, análise e gráfico na hora',
    render: () => (
      <NatiChatWindow bare bodyClassName="p-4">
        <Conversation stagger={0.4} delay={0.1}>
          <UserBubble time="09:41">Qual é a média salarial por cargo na Filial 97?</UserBubble>
          <NatiBubble>
            <p className="pr-6">
              Aqui está a média salarial dos cinco maiores cargos da Filial 97, com base na folha de agosto. <b>Ponto de atenção:</b> o cargo de
              Supervisor de Setor está 6% acima da mediana das outras filiais.
            </p>
          </NatiBubble>
          <m.div variants={chartIn} className="pl-[42px]">
            <NatiChartCard title="Média Salarial por Cargo - Filial 97" data={payByRole} types={['bar']} labelHeader="Cargo" valueLabel="Média salarial" />
          </m.div>
        </Conversation>
      </NatiChatWindow>
    ),
  },
}

interface GroupTabsProps {
  id?: string
}

/** As sete frentes do sistema em abas: módulos de cada uma e um visual do que ela faz. */
export function GroupTabs({ id = 'frentes' }: GroupTabsProps) {
  const [active, setActive] = useState<GroupId>(groups[0].id)
  const tabRefs = useRef<(HTMLButtonElement | null)[]>([])

  const group = groups.find((g) => g.id === active) ?? groups[0]
  const modules = modulesByGroup(group.id)
  const visual = visuals[group.id]

  const select = (index: number) => {
    const next = groups[index]
    setActive(next.id)
    tabRefs.current[index]?.focus()
  }

  const onKeyDown = (e: KeyboardEvent<HTMLDivElement>) => {
    const current = groups.findIndex((g) => g.id === active)
    const last = groups.length - 1
    switch (e.key) {
      case 'ArrowRight':
        e.preventDefault()
        select(current === last ? 0 : current + 1)
        break
      case 'ArrowLeft':
        e.preventDefault()
        select(current === 0 ? last : current - 1)
        break
      case 'Home':
        e.preventDefault()
        select(0)
        break
      case 'End':
        e.preventDefault()
        select(last)
        break
      default:
        break
    }
  }

  return (
    <Section id={id} tone="white" aria-labelledby={`${id}-title`}>
      <div className="container">
        <SectionHeader
          id={`${id}-title`}
          eyebrow="Frente por frente"
          title="Escolha uma frente e veja [[o que entra nela]]."
          lead="Cada frente reúne os módulos que trabalham juntos no dia a dia. Escolha uma delas para ver a tela, os módulos e o que muda na operação."
        />

        <Reveal delay={0.1} className="mt-10 lg:mt-14">
          {/* Abas: rolam na horizontal em telas pequenas e quebram linha no desktop. */}
          <div
            role="tablist"
            aria-label="Frentes do sistema"
            onKeyDown={onKeyDown}
            className="no-scrollbar -mx-5 -my-1 flex gap-2 overflow-x-auto px-5 py-1 sm:-mx-6 sm:px-6 lg:mx-0 lg:flex-wrap lg:overflow-visible lg:px-0"
          >
            {groups.map((g, i) => {
              const selected = g.id === active
              return (
                <button
                  key={g.id}
                  ref={(el) => {
                    tabRefs.current[i] = el
                  }}
                  id={`${id}-tab-${g.id}`}
                  type="button"
                  role="tab"
                  aria-selected={selected}
                  aria-controls={`${id}-panel`}
                  tabIndex={selected ? 0 : -1}
                  onClick={() => setActive(g.id)}
                  className={cn(
                    'inline-flex shrink-0 items-center gap-2 whitespace-nowrap rounded-full border px-4 py-2 text-sm font-semibold transition-[background-color,color,border-color] duration-300 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple focus-visible:ring-offset-2',
                    selected
                      ? 'border-brand-purple bg-brand-purple text-white'
                      : 'border-brand-mist bg-white text-brand-graphite hover:border-brand-purple/40 hover:text-brand-purple',
                  )}
                >
                  {g.name}
                  <span className={cn('text-xs tabular', selected ? 'text-white/70' : 'text-brand-graphite')}>{modulesByGroup(g.id).length}</span>
                </button>
              )
            })}
          </div>

          <div id={`${id}-panel`} role="tabpanel" aria-labelledby={`${id}-tab-${group.id}`} className="mt-8 lg:mt-10">
            <m.div
              key={group.id}
              initial={{ opacity: 0, y: 14 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.4, ease: EASE }}
              className="grid items-start gap-10 lg:grid-cols-[1fr_1.1fr] lg:gap-14"
            >
              <div className="min-w-0">
                <h3 className="text-2xl font-extrabold text-brand-ink sm:text-3xl">{group.name}</h3>
                <p className="mt-2 text-base font-semibold text-brand-purple">{group.tagline}</p>
                <p className="mt-4 text-[15px] leading-relaxed text-brand-graphite">{descriptions[group.id]}</p>

                <ul className="mt-6 grid gap-2 sm:grid-cols-2 lg:grid-cols-1" aria-label={`Módulos de ${group.name}`}>
                  {modules.map((mod) => {
                    const Icon = moduleIcons[mod.icon]
                    return (
                      <li key={mod.slug}>
                        <Link
                          to={modulePath(mod.slug)}
                          className="group flex h-full items-center gap-3 rounded-xl border border-brand-mist/80 bg-brand-off-white/40 p-3 transition-[border-color,background-color,transform,box-shadow] duration-300 ease-brand hover:-translate-y-0.5 hover:border-brand-purple/30 hover:bg-white hover:shadow-soft"
                        >
                          <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-white text-brand-purple shadow-soft transition-colors duration-300 group-hover:bg-brand-purple group-hover:text-white">
                            <Icon className="h-5 w-5" strokeWidth={1.6} aria-hidden />
                          </span>
                          <span className="min-w-0 flex-1">
                            <span className="block text-[15px] font-bold text-brand-ink transition-colors duration-300 group-hover:text-brand-purple">{mod.name}</span>
                            <span className="block text-[13px] leading-snug text-brand-graphite">{mod.short}</span>
                          </span>
                          <ChevronRight className="h-4 w-4 shrink-0 text-brand-gray transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                        </Link>
                      </li>
                    )
                  })}
                </ul>
              </div>

              <div className="min-w-0">
                <div role="img" aria-label={visual.label} className="rounded-3xl border border-brand-mist bg-brand-off-white p-4 sm:p-6">
                  {/* inert: o mockup é só ilustração, nada dentro dele recebe foco */}
                  <div inert>{visual.render()}</div>
                </div>
                <p className="mt-3 text-center text-[13px] text-brand-graphite">{visual.caption}</p>
              </div>
            </m.div>
          </div>
        </Reveal>
      </div>
    </Section>
  )
}
