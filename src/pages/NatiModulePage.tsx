import { Link } from 'react-router'
import { m } from 'motion/react'
import {
  ArrowRight,
  Bookmark,
  Brain,
  Check,
  ChevronRight,
  Database,
  Download,
  History,
  MessageSquare,
  Mic,
  Paperclip,
  Pin,
  Plug,
  ShieldCheck,
  Sparkles,
  ThumbsUp,
  UserCheck,
} from 'lucide-react'
import { Section, SectionHeader, Eyebrow } from '@/components/sections/Section'
import { CTASection } from '@/components/sections/CTASection'
import { FaqAccordion } from '@/components/sections/FaqAccordion'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import { SpotlightCard } from '@/components/motion/SpotlightCard'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { Button } from '@/components/ui/button'
import { BenefitsGrid, FeaturesGrid, FlowSteps, PersonasGrid, PrevNext, RelatedModules } from '@/components/modules/blocks'
import { Conversation, NatiAnswerFooter, NatiBubble, NatiChatWindow, UserBubble } from '@/components/mockups/nati/NatiChatWindow'
import { NatiChartCard } from '@/components/mockups/nati/NatiChartCard'
import { NatiTable, type LedgerRow } from '@/components/mockups/nati/NatiTable'
import { WhatsAppMockup } from '@/components/mockups/nati/WhatsAppMockup'
import { OperatorPanel, PANEL_SIZE } from '@/components/mockups/nati/OperatorPanel'
import { getGroup, getModuleEntry, type ModuleEntry } from '@/content/modulePages'
import type { ModulePage as ModulePageData } from '@/content/modulePages/types'
import { EASE } from '@/lib/motion'
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

const introRows = [
  { k: 'Demonstrativo de pagamento', v: 'Processamento direto no celular' },
  { k: 'Atualizações de dados', v: 'Dados pessoais e dependentes' },
  { k: 'Solicitações sem burocracia', v: 'Férias, atestados e benefícios' },
  { k: 'Consulta de benefícios', v: 'Respostas instantâneas via WhatsApp ou sistema', tag: 'Em poucos cliques' },
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
  { icon: MessageSquare, title: 'Transparente sobre limites.', text: 'Toda conversa lembra: "Sou uma IA e posso cometer enganos — sempre valide as informações."' },
]

export default function NatiModulePage({ entry, page }: { entry: ModuleEntry; page: ModulePageData }) {
  const group = getGroup(entry.group)
  const { prev, next } = moduleNeighbors(entry.slug)
  const related = page.related.map(getModuleEntry).filter((r): r is ModuleEntry => Boolean(r))

  return (
    <PageTransition>
      {/* Hero */}
      <Section
        tone="off"
        className="overflow-hidden pb-16 pt-[calc(var(--nav-h)+2.5rem)] sm:pt-[calc(var(--nav-h)+3.5rem)] lg:pb-24"
        aria-labelledby="module-title"
      >
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[36%] h-[150%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb
            items={[
              { label: 'Início', to: '/' },
              { label: 'Módulos', to: '/modulos' },
              { label: group.name, to: `/modulos#${group.id}` },
              { label: 'NATI' },
            ]}
          />
          <div className="mt-8 grid items-center gap-12 lg:grid-cols-[1.05fr_1fr] lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Inovação em inteligência artificial</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="module-title"
                text="Conheça a NATI. [[Sua agente digital de RH.]]"
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-[3.5rem]"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  A inteligência artificial que transforma a experiência do RH e dos colaboradores. Integrada ao sistema e
                  disponível no WhatsApp e no Teams, a NATI entende o que você pede em linguagem natural, consulta a base de
                  dados da empresa e devolve resposta, gráfico ou documento na hora.
                </p>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <Link to="#contato">
                    Agendar demonstração
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
                <Button asChild size="lg" variant="secondary">
                  <Link to="#analise">Ver a NATI em ação</Link>
                </Button>
              </Reveal>
              <Stagger className="mt-10 grid grid-cols-2 gap-x-6 gap-y-6 sm:grid-cols-4" delay={0.4}>
                {page.highlights.map((h) => (
                  <StaggerItem key={h.label}>
                    <p className="text-3xl font-extrabold tracking-brand text-brand-purple">{h.value}</p>
                    <p className="mt-1 text-sm leading-snug text-brand-graphite">{h.label}</p>
                  </StaggerItem>
                ))}
              </Stagger>
            </div>

            <IntroCard />
          </div>
        </div>
      </Section>

      {/* O que muda */}
      <Section id="beneficios" tone="white" aria-labelledby="beneficios-title">
        <div className="container">
          <SectionHeader id="beneficios-title" eyebrow="O que muda" title="O que muda para a [[sua empresa]]." />
          <BenefitsGrid items={page.benefits} />
        </div>
      </Section>

      {/* Análise em linguagem natural */}
      <Section id="analise" tone="off" aria-labelledby="analise-title">
        <div className="container">
          <SectionHeader
            id="analise-title"
            eyebrow="Pergunte em linguagem natural"
            title="Uma pergunta. [[Uma análise completa]]."
            lead="Peça o histórico de uma pessoa, a comparação entre dois meses ou a leitura de um indicador. A NATI consulta a base de dados que você escolheu, mostra de onde tirou cada informação e responde com análise, diagnóstico, pontos de atenção e sugestão."
          />
          <div className="mt-12 grid items-start gap-10 lg:mt-16 lg:grid-cols-[1fr_1.35fr] lg:gap-14">
            <Stagger className="min-w-0 space-y-4 lg:sticky lg:top-32" delay={0.2}>
              {behind.map(({ icon: Icon, title, text }) => (
                <StaggerItem key={title} className="flex gap-4 rounded-2xl border border-brand-mist bg-white p-5">
                  <span className="mt-0.5 flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-brand-off-white text-brand-purple">
                    <Icon className="h-5 w-5" strokeWidth={1.7} />
                  </span>
                  <div>
                    <h3 className="font-bold text-brand-ink">{title}</h3>
                    <p className="mt-1 text-[14.5px] leading-relaxed text-brand-graphite">{text}</p>
                  </div>
                </StaggerItem>
              ))}
            </Stagger>

            <Reveal delay={0.15} className="min-w-0">
              <NatiChatWindow>
                <Conversation stagger={0.5}>
                  <UserBubble time="04/09/2026 14:45">
                    Quero o histórico cadastral de cargos e salários, as avaliações, os feedbacks e as férias do período
                    inteiro da Ana Ribeiro. Faça uma análise estratégica desta colaboradora.
                  </UserBubble>
                  <NatiBubble>
                    <p className="flex items-center gap-1.5 pr-6 font-bold">
                      <Pin className="h-3.5 w-3.5 text-brand-pink" strokeWidth={2} aria-hidden />
                      Base de dados consultada e coleta efetuada
                    </p>
                    <p className="mt-1.5">
                      A resposta baseia-se nas consultas executadas no sistema para a colaboradora <b>Ana Ribeiro (Matrícula 205818,
                      Empresa 700 - Natcorp do Brasil)</b>:
                    </p>
                    <ul className="mt-1.5 list-disc space-y-1 pl-4">
                      <li>
                        <b>Linha do tempo — Cargos:</b> 6 registros históricos consultados (de 03/06/1996 até o cargo atual).
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
                      <b>Pontos de atenção:</b> férias vencem em 02/06/2027; última revisão salarial há 16 meses. <b>Sugestão:</b> programar as
                      férias até o próximo fechamento e incluir a colaboradora no ciclo de mérito com um PDI de liderança.
                    </p>
                  </NatiBubble>
                  <m.div variants={{ hidden: { opacity: 0, y: 12 }, visible: { opacity: 1, y: 0, transition: { duration: 0.5, ease: EASE } } }} className="pl-[42px]">
                    <NatiChartCard title="Evolução Salarial - Ana Ribeiro (Matrícula 205818)" data={salaryHistory} types={['line', 'bar']} defaultType="line" trend labelHeader="Competência" valueLabel="Salário" />
                  </m.div>
                  <NatiAnswerFooter />
                </Conversation>
              </NatiChatWindow>
            </Reveal>
          </div>
        </div>
      </Section>

      {/* Gráficos e tabelas */}
      <Section id="graficos" tone="white" aria-labelledby="graficos-title">
        <div className="container">
          <SectionHeader
            id="graficos-title"
            eyebrow="Gráficos e tabelas na conversa"
            title="Do gráfico à tabela, [[sem sair do chat]]."
            lead="Troque o tipo de gráfico, veja os mesmos dados em tabela, amplie, exporte em CSV ou PNG e salve no seu painel. O cartão abaixo é interativo: experimente."
          />
          <div className="mt-12 grid items-start gap-8 lg:mt-16 lg:grid-cols-2">
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
                    Me retorne meu histórico financeiro de março de 2025 e abril de 2025 e faça um comparativo das diferenças e se há
                    algo a se preocupar
                  </UserBubble>
                  <NatiBubble>
                    <p className="pr-6">
                      Abaixo está o seu histórico financeiro referente a <b>março de 2025</b> e <b>abril de 2025</b>, juntamente com o
                      comparativo detalhado das diferenças.
                    </p>
                    <NatiTable rows={ledger} className="mt-3" />
                    <p className="mt-3">
                      <b>Comparativo:</b> proventos idênticos nos dois meses. A única diferença é o desconto de Vale Refeição em abril,
                      previsto no seu plano. <b>Nada a se preocupar.</b>
                    </p>
                  </NatiBubble>
                  <NatiAnswerFooter sources={2} />
                </Conversation>
              </NatiChatWindow>
            </Reveal>
          </div>
        </div>
      </Section>

      {/* WhatsApp */}
      <Section id="whatsapp" tone="off" aria-labelledby="whatsapp-title">
        <div className="container grid items-center gap-12 lg:grid-cols-2 lg:gap-16">
          <div>
            <SectionHeader
              id="whatsapp-title"
              eyebrow="No WhatsApp"
              title="O colaborador resolve sozinho, [[no WhatsApp]]."
              lead="Sem instalar nada e sem abrir chamado. A pessoa pergunta pelo canal que já usa e recebe o documento ou a informação na hora, com respostas padronizadas e confidenciais, 24 horas por dia."
            />
            <Stagger className="mt-8 space-y-3" delay={0.2}>
              {whatsappItems.map((item) => (
                <StaggerItem key={item} className="flex items-start gap-3 text-[15px] font-medium text-brand-ink">
                  <span className="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                    <Check className="h-3 w-3" strokeWidth={3} />
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
      </Section>

      {/* Dentro do sistema */}
      <Section id="no-sistema" tone="dark" className="overflow-hidden" aria-labelledby="sistema-title">
        <LogoOutline className="pointer-events-none absolute -right-[16%] -top-[40%] h-[140%] w-auto text-white/[0.1]" />
        <div className="container relative">
          <SectionHeader
            id="sistema-title"
            tone="dark"
            eyebrow="Dentro do sistema"
            title="Ao lado de quem [[opera o RH]]."
            lead="No Painel do Operador, a NATI fica a um clique, sobre a tela em que você está trabalhando. Escolha a base de dados, salve os prompts que mais usa, consulte o histórico e fale por voz ou texto."
          />
          <Reveal delay={0.2} className="mt-12">
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
                          <Pin className="h-3.5 w-3.5 text-brand-pink" strokeWidth={2} aria-hidden />
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
          </Reveal>

          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-3" stagger={0.06}>
            {tools.map(({ icon: Icon, title, text }) => (
              <StaggerItem key={title}>
                <SpotlightCard className="h-full rounded-2xl border border-white/12 bg-white/[0.06] p-5 backdrop-blur-sm" color="rgba(228,169,196,0.16)">
                  <Icon className="h-5 w-5 text-[#E4A9C4]" strokeWidth={1.7} />
                  <h3 className="mt-3 font-bold">{title}</h3>
                  <p className="mt-1.5 text-[14.5px] leading-relaxed text-white/70">{text}</p>
                </SpotlightCard>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      {/* O que a NATI analisa */}
      <Section id="funcionalidades" tone="off" aria-labelledby="funcionalidades-title">
        <div className="container">
          <SectionHeader
            id="funcionalidades-title"
            eyebrow="Dez frentes do RH"
            title="O que a NATI [[analisa]]."
            lead="Um único motor cognitivo lendo folha, pessoal, frequência, benefícios, cargos, medicina, segurança, recrutamento, feedback e treinamento."
          />
          <FeaturesGrid items={page.features} />
        </div>
      </Section>

      {/* Como responde */}
      {page.flow && (
        <Section id="como-funciona" tone="white" aria-labelledby="fluxo-title">
          <div className="container">
            <SectionHeader id="fluxo-title" eyebrow="Regra do sistema" title={page.flow.title} />
            <FlowSteps steps={page.flow.steps} />
          </div>
        </Section>
      )}

      {/* Limites, conformidade e conexões */}
      <Section id="conformidade" tone="dark" className="overflow-hidden" aria-labelledby="limites-title">
        <LogoOutline className="pointer-events-none absolute -bottom-[45%] -left-[14%] h-[130%] w-auto text-white/[0.1]" />
        <div className="container relative">
          <SectionHeader id="limites-title" tone="dark" eyebrow="Limites claros" title="Inteligência com [[responsabilidade]]." />
          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            {guardrails.map(({ icon: Icon, title, text }) => (
              <StaggerItem key={title}>
                <SpotlightCard className="h-full rounded-2xl border border-white/12 bg-white/[0.06] p-6 backdrop-blur-sm" color="rgba(228,169,196,0.18)">
                  <Icon className="h-6 w-6 text-[#E4A9C4]" strokeWidth={1.6} />
                  <h3 className="mt-4 text-lg font-bold">{title}</h3>
                  <p className="mt-2 text-[15px] leading-relaxed text-white/70">{text}</p>
                </SpotlightCard>
              </StaggerItem>
            ))}
          </Stagger>

          <div className="mt-16 grid gap-12 lg:grid-cols-2 lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow tone="white">Conformidade</Eyebrow>
              </Reveal>
              <Reveal delay={0.08}>
                <h3 className="mt-4 text-2xl font-extrabold leading-tight sm:text-3xl">Feito para a regra brasileira.</h3>
              </Reveal>
              <Stagger className="mt-6 flex flex-wrap gap-2" delay={0.2} stagger={0.05}>
                {(page.compliance ?? []).map((c) => (
                  <StaggerItem key={c} className="rounded-full border border-white/20 bg-white/[0.07] px-3.5 py-1.5 text-[13.5px] font-semibold backdrop-blur-sm">
                    {c}
                  </StaggerItem>
                ))}
              </Stagger>
            </div>
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow tone="white">Conecta com</Eyebrow>
              </Reveal>
              <Reveal delay={0.08}>
                <h3 className="mt-4 text-2xl font-extrabold leading-tight sm:text-3xl">A NATI lê a mesma base de todos os módulos.</h3>
              </Reveal>
              <RelatedModules items={related} className="mt-6" />
            </div>
          </div>
        </div>
      </Section>

      {page.personas && page.personas.length > 0 && (
        <Section id="para-quem" tone="off" aria-labelledby="personas-title">
          <div className="container">
            <SectionHeader id="personas-title" eyebrow="Para quem" title="Quem ganha com [[a NATI]]." />
            <PersonasGrid items={page.personas} />
          </div>
        </Section>
      )}

      <Section id="perguntas" tone="white" aria-labelledby="perguntas-title">
        <div className="container grid gap-10 lg:grid-cols-[1fr_1.6fr] lg:gap-16">
          <div className="lg:sticky lg:top-32 lg:self-start">
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

      <nav aria-label="Outros módulos" className="border-t border-brand-mist bg-white">
        <div className="container grid gap-3 py-8 sm:grid-cols-2">
          <PrevNext entry={prev} direction="prev" />
          <PrevNext entry={next} direction="next" />
        </div>
      </nav>

      <CTASection title="Veja a NATI respondendo com os dados da sua empresa." />
    </PageTransition>
  )
}

function IntroCard() {
  return (
    <div className="relative mx-auto w-full max-w-lg lg:max-w-none">
      <div aria-hidden className="pointer-events-none absolute -inset-8 rounded-[2.5rem] bg-[radial-gradient(60%_60%_at_50%_40%,rgba(154,64,138,0.2),transparent_70%)]" />
      <m.div
        className="relative rounded-3xl bg-brand-blue p-5 text-white shadow-glow sm:p-6"
        initial={{ opacity: 0, y: 28, scale: 0.98 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        transition={{ duration: 0.9, ease: EASE, delay: 0.25 }}
      >
        <div className="flex items-start gap-4">
          <m.span
            className="flex h-20 w-20 shrink-0 items-center justify-center rounded-full bg-white/95"
            animate={{ y: [0, -4, 0] }}
            transition={{ duration: 4, repeat: Infinity, ease: 'easeInOut' }}
          >
            <NatiAvatar ring decorative={false} className="h-[74px] w-[74px]" />
          </m.span>
          <m.div
            className="rounded-2xl rounded-tl-md bg-white px-4 py-3 text-brand-ink"
            initial={{ opacity: 0, x: -8 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.6, ease: EASE, delay: 0.7 }}
          >
            <p className="text-[15px] font-bold">Olá! Como posso ajudar você hoje?</p>
            <p className="mt-1 text-[13px] leading-snug text-brand-graphite">
              Posso processar folhas, responder dúvidas sobre benefícios, gerar relatórios e muito mais!
            </p>
          </m.div>
        </div>
        <m.ul
          className="mt-5 space-y-2.5"
          initial="hidden"
          animate="visible"
          variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.14, delayChildren: 1 } } }}
        >
          {introRows.map((r) => (
            <m.li
              key={r.k}
              variants={{ hidden: { opacity: 0, y: 10 }, visible: { opacity: 1, y: 0, transition: { duration: 0.5, ease: EASE } } }}
              className="rounded-xl border border-white/12 bg-white/[0.08] px-4 py-3"
            >
              <div className="flex items-center justify-between gap-3">
                <p className="text-[12px] text-white/65">{r.k}</p>
                {r.tag && <span className="text-[11px] font-semibold text-[#E4A9C4]">{r.tag}</span>}
              </div>
              <p className="mt-0.5 flex items-center gap-2 text-[14px] font-semibold">
                <Check className="h-4 w-4 text-[#E4A9C4]" strokeWidth={2.5} aria-hidden />
                {r.v}
              </p>
            </m.li>
          ))}
        </m.ul>
      </m.div>
    </div>
  )
}
