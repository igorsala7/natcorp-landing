import { useState } from 'react'
import { m } from 'motion/react'
import { Brain, ShieldCheck, UserCheck } from 'lucide-react'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { SpotlightCard } from '@/components/motion/SpotlightCard'
import { LogoOutline } from '@/components/brand/Logo'
import { NatiChatMockup, type Conversation } from '@/components/mockups/NatiChatMockup'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

const rule = ['Análise', 'Diagnóstico', 'Pontos de atenção', 'Sugestão']

interface Persona {
  id: string
  tab: string
  tabShort?: string
  title: string
  bullets: string[]
  conversation: Conversation
}

const personas: Persona[] = [
  {
    id: 'colaboradores',
    tab: 'Colaboradores',
    title: 'Respostas na hora, no sistema, no WhatsApp ou no Teams.',
    bullets: [
      'Dúvidas sobre holerite, férias, benefícios e ponto respondidas 24 horas por dia',
      'Orientação clara e padronizada, sem depender de e-mail para o RH',
      'Cada interação vira um dado para melhorar o atendimento',
    ],
    conversation: {
      id: 'colaboradores',
      user: 'Quantos dias de férias eu ainda tenho?',
      reply: [
        'Você tem 20 dias disponíveis do período 2025/2026, com vencimento em 14/03/2027.',
        'Quer abrir uma requisição de férias agora? O seu gestor aprova pelo portal.',
      ],
      actions: ['Abrir requisição', 'Ver holerite'],
    },
  },
  {
    id: 'gestores',
    tab: 'Gestores',
    title: 'Um assistente para a rotina e as decisões da equipe.',
    bullets: [
      'Alertas de distorção salarial, custo de benefícios e variações atípicas',
      'Apoio em avaliações, treinamentos e requisições do time',
      'Conformidade com CLT, eSocial e NRs sempre atualizada',
    ],
    conversation: {
      id: 'gestores',
      user: 'Como está o banco de horas da minha equipe?',
      reply: [
        'Análise: 3 pessoas estão acima de 40 h positivas. Diagnóstico: concentração na escala noturna.',
        'Ponto de atenção: o limite da convenção é 60 h. Sugestão: programar folgas compensadas até 30/09.',
      ],
      actions: ['Programar folgas', 'Ver por pessoa'],
    },
  },
  {
    id: 'operadores',
    tab: 'Operadores do RH',
    tabShort: 'Operadores',
    title: 'Uma copiloto analítica para dez frentes do RH.',
    bullets: [
      'Auditoria contínua antes do fechamento da folha',
      'Sugestões sobre passivo trabalhista, exames a vencer e EPIs',
      'Análises e gráficos gerados dentro do sistema, sem depender de TI',
    ],
    conversation: {
      id: 'operadores',
      user: 'Tem algo pendente antes de fechar a folha?',
      reply: [
        '12 ASOs vencem em 15 dias, 3 marcações aguardam abono e 1 requisição de vaga foi aprovada hoje.',
        'Quer que eu gere a lista de pendências por centro de custo?',
      ],
      actions: ['Gerar lista', 'Fechar folha'],
    },
  },
]

const guardrails = [
  { icon: UserCheck, title: 'A NATI sugere. O gestor decide.', text: 'Sem poder decisório e sem ações automáticas sobre pessoas: cada sugestão passa por quem responde pela equipe.' },
  { icon: Brain, title: 'Especialista, não generalista.', text: 'Conhece folha, ponto, benefícios, saúde ocupacional e as regras da sua empresa. Atualizada com a legislação vigente.' },
  { icon: ShieldCheck, title: 'Confidencialidade e LGPD.', text: 'Cada pessoa vê apenas o que o seu perfil permite. Os dados ficam no sistema, com trilha de auditoria.' },
]

export function NatiSection() {
  const [active, setActive] = useState(0)
  const persona = personas[active]

  return (
    <Section id="nati" tone="dark" className="overflow-hidden" aria-labelledby="nati-title">
      <div className="pointer-events-none absolute inset-0" aria-hidden>
        <LogoOutline className="absolute -bottom-[40%] -left-[14%] h-[130%] w-auto text-white/[0.12]" />
        <div className="absolute inset-0 bg-[radial-gradient(55%_50%_at_80%_20%,rgba(154,64,138,0.35),transparent_65%)]" />
      </div>

      <div className="container relative">
        <SectionHeader
          id="nati-title"
          tone="dark"
          eyebrow="NATI · Inteligência artificial"
          title="A IA que trabalha [[dentro do sistema]]."
          lead="A NATI não é um chatbot genérico. Ela conhece a folha, o ponto, os benefícios, a saúde ocupacional e as regras da sua empresa. Cada pergunta volta com análise, diagnóstico, pontos de atenção e sugestão."
        />

        <Reveal delay={0.3} className="mt-8 flex flex-wrap items-center gap-2">
          {rule.map((r, i) => (
            <span key={r} className="flex items-center gap-2 text-sm font-semibold">
              <span className="rounded-full border border-white/20 bg-white/10 px-3.5 py-1.5 backdrop-blur-sm">{r}</span>
              {i < rule.length - 1 && <span className="text-white/40" aria-hidden>→</span>}
            </span>
          ))}
        </Reveal>

        <div className="mt-14 grid items-start gap-10 lg:mt-20 lg:grid-cols-[1fr_1.05fr] lg:gap-16">
          <div>
            <div role="tablist" aria-label="Para quem a NATI trabalha" className="inline-flex rounded-xl border border-white/15 bg-white/5 p-1">
              {personas.map((p, i) => (
                <button
                  key={p.id}
                  role="tab"
                  id={`nati-tab-${p.id}`}
                  aria-selected={i === active}
                  aria-controls={`nati-panel-${p.id}`}
                  onClick={() => setActive(i)}
                  className={cn(
                    'relative rounded-lg px-3.5 py-2 text-[13px] font-semibold transition-colors sm:px-4 sm:text-sm',
                    i === active ? 'text-brand-blue' : 'text-white/70 hover:text-white',
                  )}
                >
                  {i === active && (
                    <m.span
                      layoutId="nati-tab"
                      className="absolute inset-0 rounded-lg bg-white"
                      transition={{ duration: 0.4, ease: EASE }}
                      aria-hidden
                    />
                  )}
                  <span className="relative">
                    {p.tabShort ? (
                      <>
                        <span className="sm:hidden">{p.tabShort}</span>
                        <span className="hidden sm:inline">{p.tab}</span>
                      </>
                    ) : (
                      p.tab
                    )}
                  </span>
                </button>
              ))}
            </div>

            <m.div
              key={persona.id}
              role="tabpanel"
              id={`nati-panel-${persona.id}`}
              aria-labelledby={`nati-tab-${persona.id}`}
              initial={{ opacity: 0, y: 12 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.5, ease: EASE }}
              className="mt-8"
            >
              <h3 className="text-2xl font-extrabold leading-tight sm:text-3xl">{persona.title}</h3>
              <ul className="mt-6 space-y-3">
                {persona.bullets.map((b) => (
                  <li key={b} className="flex items-start gap-3 text-[15px] text-white/85">
                    <span className="mt-2 h-1.5 w-1.5 shrink-0 rotate-45 rounded-[1px] bg-[#E4A9C4]" aria-hidden />
                    {b}
                  </li>
                ))}
              </ul>
            </m.div>

            <p className="mt-8 text-sm text-white/55">
              Disponível em mais de 120 idiomas · no sistema, no WhatsApp e no Microsoft Teams.
            </p>
          </div>

          <Reveal delay={0.2}>
            <NatiChatMockup conversation={persona.conversation} />
          </Reveal>
        </div>

        <Stagger className="mt-16 grid gap-4 md:grid-cols-3 lg:mt-24">
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
      </div>
    </Section>
  )
}
