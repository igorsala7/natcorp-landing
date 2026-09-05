import { useCallback, useEffect, useId, useRef, useState, type KeyboardEvent, type MouseEvent } from 'react'
import { Link } from 'react-router'
import { AnimatePresence, m } from 'motion/react'
import {
  ArrowRight,
  Bookmark,
  Brain,
  Briefcase,
  Building2,
  Check,
  ChevronRight,
  Database,
  Download,
  History,
  Lightbulb,
  MessageSquare,
  Mic,
  Paperclip,
  Pin,
  Plug,
  ScanSearch,
  ShieldCheck,
  Sparkles,
  Stethoscope,
  ThumbsUp,
  TriangleAlert,
  UserCheck,
  UserRound,
  Users,
} from 'lucide-react'
import { Section, SectionHeader, Eyebrow } from '@/components/sections/Section'
import { CTASection } from '@/components/sections/CTASection'
import { FaqAccordion } from '@/components/sections/FaqAccordion'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { TypedText } from '@/components/motion/TypedText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import { SpotlightCard } from '@/components/motion/SpotlightCard'
import { scrollToElement } from '@/components/motion/ScrollManager'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { HeroSymbol } from '@/components/brand/HeroSymbol'
import { LogoOutline } from '@/components/brand/Logo'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { Button } from '@/components/ui/button'
import { NeuralHub } from '@/components/nati/NeuralHub'
import { InsightStream } from '@/components/nati/InsightStream'
import { NetworkField } from '@/components/nati/NetworkField'
import { FrontsMatrix } from '@/components/nati/FrontsMatrix'
import { NatiStats } from '@/components/nati/NatiStats'
import { NatiPipeline } from '@/components/nati/NatiPipeline'
import { BenefitsGrid, FeaturesGrid, FlowSteps, PersonasGrid, PrevNext, RelatedModules } from '@/components/modules/blocks'
import { Conversation, NatiAnswerFooter, NatiBubble, NatiChatWindow, UserBubble } from '@/components/mockups/nati/NatiChatWindow'
import { NatiChartCard } from '@/components/mockups/nati/NatiChartCard'
import { NatiTable, type LedgerRow } from '@/components/mockups/nati/NatiTable'
import { WhatsAppMockup } from '@/components/mockups/nati/WhatsAppMockup'
import { OperatorPanel, PANEL_SIZE } from '@/components/mockups/nati/OperatorPanel'
import { capabilities } from '@/content/nati'
import { getGroup, getModuleEntry, type ModuleEntry } from '@/content/modulePages'
import type { ModulePage as ModulePageData } from '@/content/modulePages/types'
import { cn } from '@/lib/utils'
import { EASE, fadeUp, staggerContainer, viewportOnce } from '@/lib/motion'
import { moduleNeighbors } from './ModulePage'

/* Dados de exemplo (colaboradora fictícia), no formato em que a NATI responde. */
const salaryHistory = {
  labels: ['06/1996', '03/1999', '08/2006', '01/2012', '02/2018', '03/2022', '01/2025', '05/2025'],
  values: [1100, 1650, 3400, 5600, 14200, 16800, 19600, 21500],
}

const topRoles = {
  labels: ['Supervisor De Setor', 'Gerente De Recursos Humanos', 'Médico Do Trabalho Coordenador', 'Gerente De Seleção E Treinamento', 'Médico Do Trabalho', 'Gerente De Remuneração'],
  values: [21500, 19900, 14100, 13900, 11000, 10600],
}

const ledger: LedgerRow[] = [
  { comp: '03/2025', tipo: 'Provento', rubrica: 'Horas Normais', valor: 'R$ 8.420,00' },
  { comp: '03/2025', tipo: 'Provento', rubrica: 'Ad. Tempo De Serviço', valor: 'R$ 842,00' },
  { comp: '03/2025', tipo: 'Desconto', rubrica: 'Desc. Adiant. Quinzenal', valor: 'R$ 3.368,00' },
  { comp: '03/2025', tipo: 'Desconto', rubrica: 'I.N.S.S.', valor: 'R$ 908,85' },
  { comp: '04/2025', tipo: 'Provento', rubrica: 'Horas Normais', valor: 'R$ 8.420,00' },
  { comp: '04/2025', tipo: 'Provento', rubrica: 'Ad. Tempo De Serviço', valor: 'R$ 842,00' },
  { comp: '04/2025', tipo: 'Desconto', rubrica: 'Desc. Adiant. Quinzenal', valor: 'R$ 3.368,00' },
  { comp: '04/2025', tipo: 'Desconto', rubrica: 'Vale Refeição', valor: 'R$ 96,00' },
]

const behind = [
  { icon: Database, title: 'Base de dados consultada', text: 'A NATI consulta apenas os arquivos, relatórios e módulos que você liberou, e diz isso no início da resposta.' },
  { icon: ChevronRight, title: 'Fontes citadas', text: 'Cada resposta lista as fontes usadas. Dá para conferir de onde saiu cada número.' },
  { icon: Sparkles, title: 'Análise estratégica', text: 'Não é só a consulta: vem o diagnóstico, os pontos de atenção e a sugestão do que fazer.' },
  { icon: Download, title: 'Gráfico pronto para usar', text: 'Evolução com linha de tendência, exportável em CSV e PNG e salva no painel.' },
]

const whatsappItems = [
  'Holerite e recibo de pagamento em PDF, na hora',
  'Informe de rendimentos de qualquer ano',
  'Dados de férias: período aquisitivo, saldo e prazo para programar',
  'Dados cadastrais e dependentes',
  'Consulta de benefícios e ponto',
  'Atestados e solicitações que seguem para o workflow',
]

const tools = [
  { icon: Database, title: 'Base de dados escolhida', text: 'Você indica quais arquivos, relatórios e módulos a NATI pode consultar. A resposta diz em que se baseou.' },
  { icon: Bookmark, title: 'Prompts salvos', text: 'As perguntas que o RH faz todo mês ficam guardadas: um clique e a análise sai atualizada.' },
  { icon: History, title: 'Histórico', text: 'Toda conversa fica registrada. Retome uma análise de onde parou.' },
  { icon: ChevronRight, title: 'Fontes citadas', text: 'Cada resposta lista as fontes consultadas, para conferência e auditoria.' },
  { icon: Mic, title: 'Por texto ou voz', text: 'Escreva ou fale. No celular, no computador ou no WhatsApp.' },
  { icon: Paperclip, title: 'Anexos', text: 'Envie um arquivo, uma planilha ou um documento e peça a leitura.' },
  { icon: ThumbsUp, title: 'Avaliação da resposta', text: 'Diga se foi útil. O RH acompanha a qualidade das respostas e a NATI melhora.' },
  { icon: Plug, title: 'Microsoft 365 e Teams', text: 'Conectada à conta corporativa: a mesma NATI dentro do Teams.' },
  { icon: Download, title: 'Gráficos e exportação', text: 'Barras, linha, radar ou tabela. Amplie, exporte em CSV ou PNG e salve no painel.' },
]

const guardrails = [
  { icon: UserCheck, title: 'A NATI sugere. O gestor decide.', text: 'Sem poder decisório e sem ações automáticas sobre pessoas: cada sugestão passa por quem responde pela equipe.' },
  { icon: Brain, title: 'Especialista, não generalista.', text: 'Conhece folha, ponto, benefícios, saúde ocupacional e as regras da sua empresa. Atualizada com a legislação vigente.' },
  { icon: ShieldCheck, title: 'Confidencialidade e LGPD.', text: 'Cada pessoa vê apenas o que o seu perfil permite. Os dados ficam no sistema, com trilha de auditoria.' },
  { icon: MessageSquare, title: 'Transparente sobre limites.', text: 'Toda conversa lembra que ela é uma IA, que pode cometer enganos e que as informações devem ser validadas.' },
]

/* Sub-navegação da página: as âncoras e a seção ativa. */
const subnav = [
  { id: 'visao', label: 'Visão' },
  { id: 'poder-analitico', label: 'Poder analítico' },
  { id: 'frentes', label: 'Frentes' },
  { id: 'no-dia-a-dia', label: 'No dia a dia' },
  { id: 'como-funciona', label: 'Como funciona' },
  { id: 'confianca', label: 'Confiança' },
  { id: 'perguntas', label: 'Perguntas' },
] as const

type SubnavId = (typeof subnav)[number]['id']

const channels = ['No sistema', 'No WhatsApp', 'No Microsoft Teams', 'Por texto ou voz']

/* Regra do sistema: o que vem em cada resposta. */
const answerParts = [
  { icon: ScanSearch, title: 'Análise', text: 'Lê regras, parametrizações, históricos e comparativos dos módulos envolvidos.' },
  { icon: Stethoscope, title: 'Diagnóstico', text: 'Explica a causa: o que mudou, onde e por quê.' },
  { icon: TriangleAlert, title: 'Pontos de atenção', text: 'Riscos financeiros, legais e de prazo, apontados antes do fechamento.' },
  { icon: Lightbulb, title: 'Sugestão', text: 'O que fazer, em ordem, pronto para quem decide aprovar.' },
]

/* A mesma NATI, uma resposta para cada cadeira. */
const profiles = [
  {
    icon: Briefcase,
    role: 'Para o RH',
    question: 'Tem algo fora do padrão na folha deste mês?',
    answer: 'Compara com os meses anteriores, aponta as rubricas que fugiram da curva e sugere a correção com a folha ainda aberta.',
  },
  {
    icon: Users,
    role: 'Para o gestor',
    question: 'Como está a minha equipe em horas extras e banco de horas?',
    answer: 'Cruza ponto, escala e afastamentos, mostra quem está no limite e sugere o ajuste da escala.',
  },
  {
    icon: UserRound,
    role: 'Para o colaborador',
    question: 'Quanto tenho de saldo de férias?',
    answer: 'Responde na hora, com período aquisitivo, saldo e prazo para programar. No WhatsApp, no Teams ou no sistema.',
  },
  {
    icon: Building2,
    role: 'Para a diretoria',
    question: 'Qual é o impacto do reajuste da convenção na folha?',
    answer: 'Simula o cenário com encargos, por centro de custo, e entrega o relatório pronto para a reunião.',
  },
]

const inSystem = [
  'A um clique, sobre a tela em que você está trabalhando',
  'Consulta só a base de dados que você liberou',
  'Prompts salvos, histórico e voz, sem trocar de janela',
]

const dailyTabs = [
  { id: 'analise', label: 'Análise estratégica', hint: 'O histórico de uma pessoa, com gráfico' },
  { id: 'graficos', label: 'Gráficos e tabelas', hint: 'Interativo: troque o tipo, veja em tabela' },
  { id: 'whatsapp', label: 'No WhatsApp', hint: 'O colaborador resolve sozinho' },
] as const

type DailyTabId = (typeof dailyTabs)[number]['id']

export default function NatiModulePage({ entry, page }: { entry: ModuleEntry; page: ModulePageData }) {
  const group = getGroup(entry.group)
  const { prev, next } = moduleNeighbors(entry.slug)
  const related = page.related.map(getModuleEntry).filter((r): r is ModuleEntry => Boolean(r))
  const [active, setActive] = useState<SubnavId>('visao')

  /* Scroll-spy: a seção que ocupa a faixa de leitura (35% a 45% da tela) é a atual. */
  useEffect(() => {
    const els = Array.from(document.querySelectorAll<HTMLElement>('[data-spy]'))
    if (els.length === 0) return
    const visible = new Set<HTMLElement>()
    const io = new IntersectionObserver(
      (entries) => {
        for (const e of entries) {
          if (e.isIntersecting) visible.add(e.target as HTMLElement)
          else visible.delete(e.target as HTMLElement)
        }
        let best: HTMLElement | null = null
        let bestTop = -Infinity
        for (const el of visible) {
          const top = el.getBoundingClientRect().top
          if (top > bestTop) {
            bestTop = top
            best = el
          }
        }
        const id = best?.dataset.spy
        if (id) setActive(id as SubnavId)
      },
      { rootMargin: '-35% 0px -55% 0px', threshold: 0 },
    )
    els.forEach((el) => io.observe(el))
    return () => io.disconnect()
  }, [])

  const go = useCallback((e: MouseEvent<HTMLAnchorElement>, id: string) => {
    const el = document.getElementById(id)
    if (!el) return
    e.preventDefault()
    scrollToElement(el)
  }, [])

  return (
    <PageTransition>
      {/* Hero */}
      <Section
        id="visao"
        tone="dark"
        flush
        data-spy="visao"
        className="flex min-h-[100svh] flex-col justify-center overflow-hidden bg-brand-ink pb-16 pt-[calc(var(--nav-h)+2rem)] sm:pt-[calc(var(--nav-h)+3rem)] lg:pb-20"
        aria-labelledby="module-title"
      >
        <NetworkField density={0.9} className="opacity-70" />
        <div
          aria-hidden
          className="pointer-events-none absolute inset-0 bg-[radial-gradient(55%_60%_at_78%_45%,rgba(154,64,138,0.42),transparent_70%),radial-gradient(40%_40%_at_8%_95%,rgba(201,87,136,0.18),transparent_70%)]"
        />
        <div aria-hidden className="pointer-events-none absolute -right-[16%] -top-[28%] hidden h-[130%] opacity-60 lg:block">
          <HeroSymbol className="h-full w-auto" />
        </div>

        <div className="container relative">
          <Breadcrumb
            className="text-white/60 [&_a:hover]:text-white [&_[aria-current]]:text-[#E4A9C4]"
            items={[
              { label: 'Início', to: '/' },
              { label: 'Módulos', to: '/modulos' },
              { label: group.name, to: `/modulos#${group.id}` },
              { label: 'NATI' },
            ]}
          />
          <div className="mt-8 grid items-center gap-12 lg:grid-cols-[1.05fr_1fr] lg:gap-10 xl:gap-16">
            <div className="max-w-2xl">
              <Reveal y={12} duration={0.5}>
                <Eyebrow tone="white">NATI · agente de IA especialista em RH</Eyebrow>
              </Reveal>
              <Reveal delay={0.1} y={8}>
                <p className="mt-6 inline-flex max-w-full items-center gap-2.5 rounded-full border border-white/12 bg-white/[0.06] py-1.5 pl-1.5 pr-4 text-[13.5px] font-semibold text-[#E4A9C4] backdrop-blur-sm sm:text-[14.5px]">
                  <NatiAvatar ring className="h-7 w-7 shrink-0" />
                  <TypedText text="Por que as horas extras de Barueri subiram em agosto?" speed={24} delay={700} />
                </p>
              </Reveal>
              <SplitText
                as="h1"
                id="module-title"
                text="A inteligência artificial que lê o RH inteiro [[e pensa junto com você]]."
                className="mt-5 text-4xl font-extrabold leading-[1.04] text-white sm:text-5xl lg:text-[3.5rem] xl:text-[4rem]"
                highlightClassName="text-[#E4A9C4]"
              />
              <Reveal delay={0.3}>
                <p className="mt-6 max-w-xl text-lg leading-relaxed text-white/75 sm:text-xl">{page.summary}</p>
              </Reveal>
              <Reveal delay={0.4} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg" variant="inverse">
                  <Link to="#contato">
                    Agendar demonstração
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
                <Button asChild size="lg" variant="outline-inverse">
                  <Link to="#poder-analitico">Ver a NATI analisando</Link>
                </Button>
              </Reveal>
              <Stagger className="mt-10 flex flex-wrap gap-2" delay={0.55} stagger={0.05}>
                {channels.map((c) => (
                  <StaggerItem key={c} className="inline-flex items-center gap-1.5 rounded-full border border-white/15 bg-white/[0.05] px-3 py-1 text-[12.5px] font-semibold text-white/80">
                    <Check className="h-3 w-3 text-[#E4A9C4]" strokeWidth={3} aria-hidden />
                    {c}
                  </StaggerItem>
                ))}
              </Stagger>
            </div>

            <div className="relative mx-auto w-full max-w-[620px]">
              <div aria-hidden className="pointer-events-none absolute inset-[-10%] rounded-full bg-[radial-gradient(50%_50%_at_50%_50%,rgba(154,64,138,0.35),transparent_70%)]" />
              <m.div
                className="relative"
                initial={{ opacity: 0, scale: 0.94 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ duration: 1.1, ease: EASE, delay: 0.3 }}
              >
                <NeuralHub />
              </m.div>
              <Reveal delay={0.9} y={8}>
                <p className="mt-3 text-center text-[12.5px] leading-snug text-white/55">
                  A NATI no centro. Em volta, as sete frentes do RH e os 31 módulos que ela lê o tempo todo.
                </p>
              </Reveal>
            </div>
          </div>
        </div>
      </Section>

      <PageSubnav active={active} onGo={go} />

      {/* Poder analítico */}
      <Section id="poder-analitico" tone="dark" data-spy="poder-analitico" className="overflow-hidden" aria-labelledby="poder-title">
        <div
          aria-hidden
          className="pointer-events-none absolute inset-0 bg-[radial-gradient(50%_50%_at_12%_15%,rgba(154,64,138,0.38),transparent_70%),radial-gradient(40%_50%_at_92%_90%,rgba(201,87,136,0.16),transparent_70%)]"
        />
        <LogoOutline className="pointer-events-none absolute -bottom-[42%] -right-[10%] h-[120%] w-auto text-white/[0.08]" />
        <div className="container relative">
          <SectionHeader
            id="poder-title"
            tone="dark"
            eyebrow="Poder analítico"
            title="Uma pergunta. [[Trinta e um módulos]] respondendo."
            lead="A NATI não consulta uma tela por vez. Ela cruza folha, ponto, saúde, talentos e metas para achar a causa, e devolve o que fazer. As análises abaixo trocam sozinhas: cenário ilustrativo, formato real."
          />
          <div className="mt-12 grid items-stretch gap-8 lg:mt-16 lg:grid-cols-[1.3fr_1fr] lg:gap-12">
            <Reveal className="min-w-0">
              <InsightStream className="h-full" />
            </Reveal>
            <Reveal delay={0.15} className="min-w-0">
              <div className="flex h-full flex-col rounded-3xl border border-white/12 bg-white/[0.05] p-6 backdrop-blur-sm sm:p-7">
                <Eyebrow tone="white">Regra do sistema</Eyebrow>
                <h3 className="mt-3 text-2xl font-extrabold leading-tight">O que vem em cada resposta.</h3>
                <m.ol className="mt-6 space-y-4" variants={staggerContainer(0.08, 0.2)} initial="hidden" whileInView="visible" viewport={viewportOnce}>
                  {answerParts.map(({ icon: Icon, title, text }, i) => (
                    <m.li key={title} variants={fadeUp} className="flex gap-4">
                      <span className="mt-0.5 flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-[#E4A9C4]/12 text-[#E4A9C4]">
                        <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                      </span>
                      <div>
                        <p className="font-bold">
                          <span className="mr-2 text-[12px] font-extrabold tabular text-[#E4A9C4]">{String(i + 1).padStart(2, '0')}</span>
                          {title}
                        </p>
                        <p className="mt-0.5 text-[14px] leading-relaxed text-white/70">{text}</p>
                      </div>
                    </m.li>
                  ))}
                </m.ol>
                <p className="mt-auto flex items-start gap-2.5 pt-6 text-[14px] leading-relaxed text-white/85">
                  <span className="mt-1 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-[#E4A9C4]/15 text-[#E4A9C4]">
                    <ChevronRight className="h-3.5 w-3.5" strokeWidth={2.5} aria-hidden />
                  </span>
                  Toda resposta começa dizendo em que base se baseou e termina citando as fontes. Dá para conferir de onde saiu cada número.
                </p>
              </div>
            </Reveal>
          </div>
          <div className="mt-16 border-t border-white/10 pt-12 lg:mt-20">
            <NatiStats tone="dark" />
          </div>
        </div>
      </Section>

      {/* Especialista em todas as frentes */}
      <Section id="frentes" tone="off" data-spy="frentes" className="overflow-hidden" aria-labelledby="frentes-title">
        <LogoOutline className="pointer-events-none absolute -left-[14%] -top-[30%] h-[120%] w-auto text-brand-purple/[0.08]" />
        <div className="container relative">
          <SectionHeader
            id="frentes-title"
            eyebrow="Especialista em todas as frentes"
            title="Treinada em [[cada frente do RH]]. Não em uma só."
            lead="Folha, ponto, SESMT, talentos, desenvolvimento, autoatendimento e dados: sete frentes, 31 módulos, uma única especialista. Em cada frente ela responde, analisa, alerta, executa e reporta. A tabela mostra um exemplo de cada."
          />

          <Stagger className="mt-12 grid gap-3 sm:grid-cols-2 lg:mt-14 lg:grid-cols-5" stagger={0.06}>
            {capabilities.map((c, i) => (
              <StaggerItem key={c.id} className="rounded-2xl border border-brand-mist bg-white p-4">
                <p className="flex items-center gap-2 text-[12px] font-extrabold uppercase tracking-[0.12em] text-brand-purple">
                  <span className="text-brand-purple tabular">{String(i + 1).padStart(2, '0')}</span>
                  {c.name}
                </p>
                <p className="mt-1.5 text-[13.5px] leading-snug text-brand-graphite">{c.text}</p>
              </StaggerItem>
            ))}
          </Stagger>

          <Reveal delay={0.1} className="mt-6">
            <FrontsMatrix tone="light" />
          </Reveal>

          <div className="mt-16 lg:mt-20">
            <Reveal y={12} duration={0.5}>
              <Eyebrow>Uma resposta para cada cadeira</Eyebrow>
            </Reveal>
            <Reveal delay={0.08}>
              <h3 className="mt-4 max-w-3xl text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">A mesma NATI. A profundidade que cada pessoa precisa.</h3>
            </Reveal>
            <Stagger className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
              {profiles.map(({ icon: Icon, role, question, answer }) => (
                <StaggerItem
                  key={role}
                  className="group flex h-full flex-col rounded-2xl border border-brand-mist bg-white p-6 transition-[border-color,box-shadow,transform] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
                >
                  <div className="flex items-center gap-3">
                    <span className="inline-flex h-10 w-10 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                      <Icon className="h-5 w-5" strokeWidth={1.6} aria-hidden />
                    </span>
                    <h4 className="text-[12px] font-semibold uppercase tracking-[0.14em] text-brand-purple">{role}</h4>
                  </div>
                  <p className="mt-5 rounded-xl rounded-bl-sm bg-brand-off-white px-3.5 py-2.5 text-[14px] font-semibold leading-snug text-brand-ink">"{question}"</p>
                  <p className="mt-3 flex items-start gap-2 text-[14.5px] leading-relaxed text-brand-graphite">
                    <NatiAvatar ring className="mt-0.5 h-5 w-5 shrink-0" />
                    {answer}
                  </p>
                </StaggerItem>
              ))}
            </Stagger>
          </div>

          <div className="mt-16 lg:mt-20">
            <Reveal y={12} duration={0.5}>
              <Eyebrow>Em detalhe</Eyebrow>
            </Reveal>
            <Reveal delay={0.08}>
              <h3 className="mt-4 max-w-3xl text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">O que a NATI analisa em cada frente.</h3>
            </Reveal>
            <FeaturesGrid items={page.features} />
          </div>
        </div>
      </Section>

      {/* No dia a dia */}
      <Section id="no-dia-a-dia" tone="white" data-spy="no-dia-a-dia" aria-labelledby="dia-title">
        <div className="container">
          <SectionHeader
            id="dia-title"
            eyebrow="No dia a dia"
            title="No dia a dia, [[é assim que a NATI trabalha]]."
            lead="Três cenários, no formato em que a NATI responde de verdade. Os dados são fictícios; o jeito de responder é o do sistema."
          />
          <Reveal delay={0.15} className="mt-10 lg:mt-12">
            <DailyTabs />
          </Reveal>
        </div>
      </Section>

      {/* Dentro do sistema */}
      <Section id="no-sistema" tone="dark" data-spy="no-dia-a-dia" className="overflow-hidden" aria-labelledby="sistema-title">
        <NetworkField density={0.7} className="opacity-50" />
        <div aria-hidden className="pointer-events-none absolute inset-0 bg-[radial-gradient(60%_50%_at_50%_100%,rgba(154,64,138,0.35),transparent_70%)]" />
        <div className="container relative">
          <div className="grid gap-10 lg:grid-cols-[1.1fr_1fr] lg:items-end lg:gap-16">
            <SectionHeader
              id="sistema-title"
              tone="dark"
              eyebrow="Dentro do sistema"
              title="Ao lado de quem [[opera o RH]]."
              lead="A NATI vive dentro do Painel do Operador. Ela fica a um clique, sobre a tela em que você está trabalhando, lendo a mesma base que você opera. Escolha a base de dados, salve os prompts que mais usa, consulte o histórico e fale por voz ou texto."
            />
            <Stagger className="grid gap-3" delay={0.2}>
              {inSystem.map((item) => (
                <StaggerItem key={item} className="flex items-center gap-3 rounded-2xl border border-white/12 bg-white/[0.06] px-4 py-3 text-[14.5px] font-medium backdrop-blur-sm">
                  <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-[#E4A9C4]/15 text-[#E4A9C4]">
                    <Check className="h-3.5 w-3.5" strokeWidth={3} aria-hidden />
                  </span>
                  {item}
                </StaggerItem>
              ))}
            </Stagger>
          </div>

          <Reveal delay={0.2} className="mt-12">
            <div
              role="img"
              aria-label="Painel do Operador do sistema Natcorp com a janela da NATI aberta sobre a tela de trabalho, respondendo a uma análise sobre a colaboradora Ana Ribeiro"
              inert
              className="rounded-xl shadow-glow"
            >
              <ScaledFrame width={PANEL_SIZE.desktop.width} height={PANEL_SIZE.desktop.height} className="rounded-xl">
                <OperatorPanel
                  overlay={
                    <NatiChatWindow bodyClassName="max-h-[300px] overflow-hidden">
                      <Conversation stagger={0.45}>
                        <UserBubble time="04/09/2026 14:45">
                          Quero o histórico cadastral de cargos, salários, avaliações, feedbacks e férias da Ana Ribeiro, com uma análise
                          estratégica.
                        </UserBubble>
                        <NatiBubble>
                          <p className="flex items-center gap-1.5 pr-6 font-bold">
                            <Pin className="h-3.5 w-3.5 text-brand-purple" strokeWidth={2} aria-hidden />
                            Base de dados consultada e coleta efetuada
                          </p>
                          <p className="mt-1.5">
                            Consultas executadas para <b>Ana Ribeiro (Matrícula 205818)</b>: 6 registros de cargos, 8 alterações salariais, 4
                            ciclos de avaliação e 30 dias de férias pendentes.
                          </p>
                        </NatiBubble>
                      </Conversation>
                    </NatiChatWindow>
                  }
                />
              </ScaledFrame>
            </div>
          </Reveal>
        </div>
      </Section>

      {/* Como funciona */}
      <Section id="como-funciona" tone="off" data-spy="como-funciona" aria-labelledby="fluxo-title">
        <div className="container">
          <SectionHeader
            id="fluxo-title"
            eyebrow="Como funciona"
            title="Como uma resposta [[nasce]]."
            lead="Da pergunta à ação, em seis passos. Os quatro do meio acontecem em segundos. O último só acontece com a aprovação de quem decide."
          />
          <Reveal delay={0.15} className="mt-14 lg:mt-16">
            <NatiPipeline tone="light" />
          </Reveal>

          {page.flow && (
            <Reveal delay={0.1} className="mt-16 lg:mt-20">
              <div className="rounded-3xl border border-brand-mist bg-white p-6 shadow-soft sm:p-8 lg:p-10">
                <Eyebrow>Regra do sistema</Eyebrow>
                <h3 className="mt-4 max-w-3xl text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">{page.flow.title}</h3>
                <FlowSteps steps={page.flow.steps} />
              </div>
            </Reveal>
          )}

          <div className="mt-16 lg:mt-20">
            <Reveal y={12} duration={0.5}>
              <Eyebrow>O que muda</Eyebrow>
            </Reveal>
            <Reveal delay={0.08}>
              <h3 className="mt-4 max-w-3xl text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">O que muda para a sua empresa.</h3>
            </Reveal>
            <BenefitsGrid items={page.benefits} />
          </div>
        </div>
      </Section>

      {/* Confiança */}
      <Section id="confianca" tone="dark" data-spy="confianca" className="overflow-hidden" aria-labelledby="confianca-title">
        <LogoOutline className="pointer-events-none absolute -bottom-[45%] -left-[14%] h-[130%] w-auto text-white/[0.1]" />
        <div aria-hidden className="pointer-events-none absolute inset-0 bg-[radial-gradient(45%_50%_at_95%_10%,rgba(154,64,138,0.32),transparent_70%)]" />
        <div className="container relative">
          <SectionHeader
            id="confianca-title"
            tone="dark"
            eyebrow="Confiança"
            title="Poder analítico com [[responsabilidade]]."
            lead="Quanto mais a NATI enxerga, mais claros precisam ser os limites. Ela sugere, cita as fontes e respeita o perfil de cada pessoa. Quem decide continua sendo gente."
          />
          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            {guardrails.map(({ icon: Icon, title, text }) => (
              <StaggerItem key={title}>
                <SpotlightCard className="h-full rounded-2xl border border-white/12 bg-white/[0.06] p-6 backdrop-blur-sm" color="rgba(228,169,196,0.18)">
                  <Icon className="h-6 w-6 text-[#E4A9C4]" strokeWidth={1.6} aria-hidden />
                  <h3 className="mt-4 text-lg font-bold">{title}</h3>
                  <p className="mt-2 text-[15px] leading-relaxed text-white/70">{text}</p>
                </SpotlightCard>
              </StaggerItem>
            ))}
          </Stagger>

          <div className="mt-16 lg:mt-20">
            <Reveal y={12} duration={0.5}>
              <Eyebrow tone="white">Ferramentas de quem usa todo dia</Eyebrow>
            </Reveal>
            <Reveal delay={0.08}>
              <h3 className="mt-4 text-2xl font-extrabold leading-tight sm:text-3xl">Tudo o que vem junto.</h3>
            </Reveal>
            <Stagger className="mt-8 grid gap-3 sm:grid-cols-2 lg:grid-cols-3" stagger={0.05}>
              {tools.map(({ icon: Icon, title, text }) => (
                <StaggerItem key={title} className="flex gap-3 rounded-xl border border-white/10 bg-white/[0.05] p-4">
                  <span className="mt-0.5 flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-white/10 text-[#E4A9C4]">
                    <Icon className="h-4 w-4" strokeWidth={1.7} aria-hidden />
                  </span>
                  <div className="min-w-0">
                    <h4 className="text-[14.5px] font-bold">{title}</h4>
                    <p className="mt-0.5 text-[13px] leading-snug text-white/65">{text}</p>
                  </div>
                </StaggerItem>
              ))}
            </Stagger>
          </div>

          {page.compliance && page.compliance.length > 0 && (
            <div className="mt-16 grid gap-6 lg:grid-cols-[1fr_2fr] lg:items-center lg:gap-16">
              <div>
                <Reveal y={12} duration={0.5}>
                  <Eyebrow tone="white">Conformidade</Eyebrow>
                </Reveal>
                <Reveal delay={0.08}>
                  <h3 className="mt-4 text-2xl font-extrabold leading-tight sm:text-3xl">Feito para a regra brasileira.</h3>
                </Reveal>
              </div>
              <Stagger className="flex flex-wrap gap-2" delay={0.2} stagger={0.05}>
                {page.compliance.map((c) => (
                  <StaggerItem key={c} className="rounded-full border border-white/20 bg-white/[0.07] px-3.5 py-1.5 text-[13.5px] font-semibold backdrop-blur-sm">
                    {c}
                  </StaggerItem>
                ))}
              </Stagger>
            </div>
          )}
        </div>
      </Section>

      {/* Para quem */}
      {page.personas && page.personas.length > 0 && (
        <Section id="para-quem" tone="off" data-spy="confianca" aria-labelledby="personas-title">
          <div className="container">
            <SectionHeader id="personas-title" eyebrow="Para quem" title="Quem ganha com [[a NATI]]." />
            <PersonasGrid items={page.personas} />
          </div>
        </Section>
      )}

      {/* Perguntas */}
      <Section id="perguntas" tone="white" data-spy="perguntas" aria-labelledby="perguntas-title">
        <div className="container grid gap-10 lg:grid-cols-[1fr_1.6fr] lg:gap-16">
          <div className="lg:sticky lg:top-[calc(var(--nav-h)+5rem)] lg:self-start">
            <SectionHeader id="perguntas-title" eyebrow="Perguntas frequentes" title="Dúvidas sobre [[a NATI]]." />
            <Reveal delay={0.3} className="mt-8">
              <Link to="#contato" className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
                Quer ver na prática? Agende uma demonstração
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" />
              </Link>
            </Reveal>
          </div>
          <Reveal delay={0.15}>
            <FaqAccordion items={page.faq} />
          </Reveal>
        </div>
      </Section>

      {/* Conecta com */}
      <Section tone="dark" flush data-spy="perguntas" className="overflow-hidden py-16 sm:py-20" aria-labelledby="conexoes-title">
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[60%] h-[180%] w-auto text-white/[0.08]" />
        <div className="container relative grid gap-10 lg:grid-cols-[1fr_1.4fr] lg:items-center lg:gap-16">
          <div>
            <Reveal y={12} duration={0.5}>
              <Eyebrow tone="white">Conecta com</Eyebrow>
            </Reveal>
            <Reveal delay={0.08}>
              <h2 id="conexoes-title" className="mt-4 text-3xl font-extrabold leading-tight sm:text-4xl">
                A NATI lê a mesma base de todos os módulos.
              </h2>
            </Reveal>
            <Reveal delay={0.16}>
              <p className="mt-4 max-w-md text-[17px] leading-relaxed text-white/75">
                Sem importar nem sincronizar nada: o dado que a folha grava é o mesmo que a NATI lê. Estes são os módulos que mais aparecem nas
                respostas dela.
              </p>
            </Reveal>
          </div>
          <RelatedModules items={related} className="lg:mt-0" />
        </div>
      </Section>

      <nav aria-label="Outros módulos" className="border-t border-brand-mist bg-white">
        <div className="container grid gap-3 py-8 sm:grid-cols-2">
          <PrevNext entry={prev} direction="prev" />
          <PrevNext entry={next} direction="next" />
        </div>
      </nav>

      <CTASection title="Veja a NATI analisando os dados da sua empresa." />
    </PageTransition>
  )
}

/* Barra fixa com as âncoras da página, logo abaixo do menu principal. */
function PageSubnav({ active, onGo }: { active: SubnavId; onGo: (e: MouseEvent<HTMLAnchorElement>, id: string) => void }) {
  const listRef = useRef<HTMLUListElement>(null)

  /* No celular, mantém o link ativo à vista dentro da faixa rolável. */
  useEffect(() => {
    const list = listRef.current
    const el = list?.querySelector<HTMLElement>(`[data-id="${active}"]`)
    if (!list || !el) return
    const left = el.offsetLeft - (list.clientWidth - el.offsetWidth) / 2
    list.scrollTo({ left: Math.max(0, left), behavior: 'smooth' })
  }, [active])

  return (
    <div className="on-dark sticky top-[var(--nav-h)] z-30 border-b border-white/10 bg-brand-ink/85 text-white shadow-[0_10px_30px_-18px_rgba(0,0,0,0.7)] backdrop-blur-xl">
      <nav aria-label="Seções desta página" className="container flex items-center gap-4">
        <span className="hidden h-12 items-center gap-2 border-r border-white/10 pr-4 text-[12px] font-bold uppercase tracking-[0.14em] text-white/70 lg:flex">
          <NatiAvatar ring className="h-6 w-6" />
          NATI
        </span>
        <ul ref={listRef} className="relative -mx-1 flex min-w-0 flex-1 gap-0.5 overflow-x-auto [scrollbar-width:none] [&::-webkit-scrollbar]:hidden">
          {subnav.map((s) => {
            const on = s.id === active
            return (
              <li key={s.id} className="shrink-0">
                <a
                  href={`#${s.id}`}
                  data-id={s.id}
                  aria-current={on ? 'location' : undefined}
                  onClick={(e) => onGo(e, s.id)}
                  className={cn(
                    'relative block whitespace-nowrap px-3.5 py-3.5 text-[13px] font-semibold transition-colors duration-300',
                    'after:absolute after:inset-x-3.5 after:bottom-0 after:h-[2px] after:origin-left after:rounded-full after:bg-[#E4A9C4] after:transition-transform after:duration-500 after:ease-brand',
                    on ? 'text-white after:scale-x-100' : 'text-white/60 after:scale-x-0 hover:text-white',
                  )}
                >
                  {s.label}
                </a>
              </li>
            )
          })}
        </ul>
        <Button asChild size="sm" variant="inverse" className="hidden shrink-0 lg:inline-flex">
          <Link to="#contato">Agendar demonstração</Link>
        </Button>
      </nav>
    </div>
  )
}

/* Três cenários de uso, em abas acessíveis (setas, Home e End trocam de aba). */
function DailyTabs() {
  const [tab, setTab] = useState<DailyTabId>('analise')
  const base = useId()
  const tabId = (id: DailyTabId) => `${base}-tab-${id}`
  const panelId = (id: DailyTabId) => `${base}-panel-${id}`

  const onKey = (e: KeyboardEvent<HTMLDivElement>) => {
    const idx = dailyTabs.findIndex((t) => t.id === tab)
    let next = idx
    if (e.key === 'ArrowRight') next = (idx + 1) % dailyTabs.length
    else if (e.key === 'ArrowLeft') next = (idx - 1 + dailyTabs.length) % dailyTabs.length
    else if (e.key === 'Home') next = 0
    else if (e.key === 'End') next = dailyTabs.length - 1
    else return
    e.preventDefault()
    const target = dailyTabs[next].id
    setTab(target)
    document.getElementById(tabId(target))?.focus()
  }

  return (
    <div>
      <div role="tablist" aria-label="Cenários de uso da NATI" onKeyDown={onKey} className="inline-flex max-w-full flex-wrap gap-1 rounded-2xl border border-brand-mist bg-brand-off-white p-1.5">
        {dailyTabs.map((t) => {
          const selected = t.id === tab
          return (
            <button
              key={t.id}
              id={tabId(t.id)}
              type="button"
              role="tab"
              aria-selected={selected}
              aria-controls={panelId(t.id)}
              tabIndex={selected ? 0 : -1}
              onClick={() => setTab(t.id)}
              className={cn(
                'rounded-xl px-4 py-2.5 text-left transition-[background-color,color,box-shadow] duration-300 ease-brand',
                selected ? 'bg-white text-brand-purple shadow-soft' : 'text-brand-graphite hover:text-brand-ink',
              )}
            >
              <span className="block text-[14px] font-bold">{t.label}</span>
              <span className={cn('hidden text-[12px] sm:block', selected ? 'text-brand-graphite' : 'text-brand-graphite')}>{t.hint}</span>
            </button>
          )
        })}
      </div>

      <div id={panelId(tab)} role="tabpanel" aria-labelledby={tabId(tab)} className="mt-10">
        <AnimatePresence mode="wait" initial={false}>
          <m.div key={tab} initial={{ opacity: 0, y: 12 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -8 }} transition={{ duration: 0.35, ease: EASE }}>
            <DailyPanel tab={tab} />
          </m.div>
        </AnimatePresence>
      </div>
    </div>
  )
}

function DailyPanel({ tab }: { tab: DailyTabId }) {
  if (tab === 'analise') {
    return (
      <div className="grid items-start gap-10 lg:grid-cols-[1fr_1.35fr] lg:gap-14">
        <div className="min-w-0 lg:sticky lg:top-[calc(var(--nav-h)+4.5rem)]">
          <h3 className="text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">Uma pessoa, o histórico inteiro, a sugestão pronta.</h3>
          <p className="mt-4 text-[16px] leading-relaxed text-brand-graphite">
            Peça o histórico de uma pessoa, a comparação entre dois meses ou a leitura de um indicador. A NATI consulta a base de dados que você
            escolheu, mostra de onde tirou cada informação e responde com análise, diagnóstico, pontos de atenção e sugestão.
          </p>
          <Stagger className="mt-8 space-y-4" delay={0.2}>
            {behind.map(({ icon: Icon, title, text }) => (
              <StaggerItem key={title} className="flex gap-4 rounded-2xl border border-brand-mist bg-white p-5">
                <span className="mt-0.5 flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-brand-off-white text-brand-purple">
                  <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                </span>
                <div>
                  <h4 className="font-bold text-brand-ink">{title}</h4>
                  <p className="mt-1 text-[14.5px] leading-relaxed text-brand-graphite">{text}</p>
                </div>
              </StaggerItem>
            ))}
          </Stagger>
        </div>

        <Reveal delay={0.15} className="min-w-0">
          <NatiChatWindow>
            <Conversation stagger={0.5}>
              <UserBubble time="04/09/2026 14:45">
                Quero o histórico cadastral de cargos e salários, as avaliações, os feedbacks e as férias do período inteiro da Ana Ribeiro. Faça
                uma análise estratégica desta colaboradora.
              </UserBubble>
              <NatiBubble>
                <p className="flex items-center gap-1.5 pr-6 font-bold">
                  <Pin className="h-3.5 w-3.5 text-brand-purple" strokeWidth={2} aria-hidden />
                  Base de dados consultada e coleta efetuada
                </p>
                <p className="mt-1.5">
                  A resposta baseia-se nas consultas executadas no sistema para a colaboradora{' '}
                  <b>Ana Ribeiro (Matrícula 205818, Empresa 700 - Natcorp do Brasil)</b>:
                </p>
                <ul className="mt-1.5 list-disc space-y-1 pl-4">
                  <li>
                    <b>Linha do tempo de cargos:</b> 6 registros históricos consultados (de 03/06/1996 até o cargo atual).
                  </li>
                  <li>
                    <b>Salários:</b> 8 alterações, com crescimento acima da mediana da filial.
                  </li>
                  <li>
                    <b>Avaliações e feedbacks:</b> 4 ciclos, média 4,6 em 5, sem plano de desenvolvimento aberto.
                  </li>
                  <li>
                    <b>Férias:</b> 30 dias do período 2025/2026 ainda sem programação.
                  </li>
                </ul>
                <p className="mt-2">
                  <b>Pontos de atenção:</b> férias vencem em 02/06/2027; última revisão salarial há 16 meses. <b>Sugestão:</b> programar as férias
                  até o próximo fechamento e incluir a colaboradora no ciclo de mérito com um PDI de liderança.
                </p>
              </NatiBubble>
              <m.div variants={{ hidden: { opacity: 0, y: 12 }, visible: { opacity: 1, y: 0, transition: { duration: 0.5, ease: EASE } } }} className="pl-[42px]">
                <NatiChartCard
                  title="Evolução Salarial - Ana Ribeiro (Matrícula 205818)"
                  data={salaryHistory}
                  types={['line', 'bar']}
                  defaultType="line"
                  trend
                  labelHeader="Competência"
                  valueLabel="Salário"
                />
              </m.div>
              <NatiAnswerFooter />
            </Conversation>
          </NatiChatWindow>
        </Reveal>
      </div>
    )
  }

  if (tab === 'graficos') {
    return (
      <div>
        <div className="max-w-3xl">
          <h3 className="text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">Do gráfico à tabela, sem sair do chat.</h3>
          <p className="mt-4 text-[16px] leading-relaxed text-brand-graphite">
            Troque o tipo de gráfico, veja os mesmos dados em tabela, amplie, exporte em CSV ou PNG e salve no seu painel. O cartão abaixo é
            interativo: experimente.
          </p>
        </div>
        <div className="mt-10 grid items-start gap-8 lg:grid-cols-2">
          <Reveal className="min-w-0">
            <NatiChartCard
              title="Média Salarial dos 6 Maiores Cargos - Filial 97"
              data={topRoles}
              types={['bar', 'radar', 'line']}
              defaultType="bar"
              labelHeader="Cargo"
              valueLabel="Média salarial"
              interactive
              className="shadow-lift"
            />
            <p className="mt-3 text-center text-sm text-brand-graphite">Interativo: troque entre Gráfico e Tabela e escolha Barras, Radar ou Linha.</p>
          </Reveal>
          <Reveal delay={0.15} className="min-w-0">
            <NatiChatWindow bare bodyClassName="p-4 sm:p-5">
              <Conversation stagger={0.4}>
                <UserBubble time="22/08/2026 14:07">
                  Me retorne meu histórico financeiro de março de 2025 e abril de 2025 e faça um comparativo das diferenças e se há algo a se
                  preocupar
                </UserBubble>
                <NatiBubble>
                  <p className="pr-6">
                    Abaixo está o seu histórico financeiro referente a <b>março de 2025</b> e <b>abril de 2025</b>, juntamente com o comparativo
                    detalhado das diferenças.
                  </p>
                  <NatiTable rows={ledger} className="mt-3" />
                  <p className="mt-3">
                    <b>Comparativo:</b> proventos idênticos nos dois meses. A única diferença é o desconto de Vale Refeição em abril, previsto no
                    seu plano. <b>Nada a se preocupar.</b>
                  </p>
                </NatiBubble>
                <NatiAnswerFooter sources={2} />
              </Conversation>
            </NatiChatWindow>
          </Reveal>
        </div>
      </div>
    )
  }

  return (
    <div className="grid items-center gap-12 lg:grid-cols-2 lg:gap-16">
      <div>
        <h3 className="text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">O colaborador resolve sozinho, no WhatsApp.</h3>
        <p className="mt-4 text-[16px] leading-relaxed text-brand-graphite">
          Sem instalar nada e sem abrir chamado. A pessoa pergunta pelo canal que já usa e recebe o documento ou a informação na hora, com
          respostas padronizadas e confidenciais, 24 horas por dia.
        </p>
        <Stagger className="mt-8 space-y-3" delay={0.2}>
          {whatsappItems.map((item) => (
            <StaggerItem key={item} className="flex items-start gap-3 text-[15px] font-medium text-brand-ink">
              <span className="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                <Check className="h-3 w-3" strokeWidth={3} aria-hidden />
              </span>
              {item}
            </StaggerItem>
          ))}
        </Stagger>
        <Reveal delay={0.4}>
          <p className="mt-8 inline-flex items-center gap-2 rounded-full bg-brand-pink/10 px-4 py-1.5 text-sm font-semibold text-brand-purple">
            <Sparkles className="h-4 w-4" strokeWidth={2} aria-hidden />
            Em poucos cliques, sem passar pelo RH
          </p>
        </Reveal>
      </div>
      <Reveal delay={0.15} className="flex justify-center lg:justify-end">
        <WhatsAppMockup />
      </Reveal>
    </div>
  )
}
