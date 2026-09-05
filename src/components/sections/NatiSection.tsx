import { useState } from 'react'
import { Link } from 'react-router'
import { m } from 'motion/react'
import { ArrowRight, Brain, Check, MessageSquare, Sparkles, Zap } from 'lucide-react'
import { Section, Eyebrow } from './Section'
import { TypedText } from '@/components/motion/TypedText'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { LogoOutline } from '@/components/brand/Logo'
import { Conversation, NatiAnswerFooter, NatiBubble, NatiChatWindow, UserBubble } from '@/components/mockups/nati/NatiChatWindow'
import { NatiTable, type LedgerRow } from '@/components/mockups/nati/NatiTable'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

const pillars = [
  { icon: MessageSquare, title: 'Assistente inteligente', text: 'Responde dúvidas, agiliza consultas e processa informações em linguagem natural.' },
  { icon: Brain, title: 'Análises estratégicas', text: 'Leituras automáticas sobre tendências, turnover e desempenho da equipe.' },
  { icon: Zap, title: 'Processamento rápido', text: 'A folha de 2.500 colaboradores calculada em um minuto.' },
  { icon: Sparkles, title: 'Modelos de linguagem de última geração', text: 'Não é um chatbot de respostas prontas: conversa natural, análises complexas e aprendizado contínuo.' },
]

const rule = ['Análise', 'Diagnóstico', 'Pontos de atenção', 'Sugestão']

const channels = ['No sistema', 'No WhatsApp', 'No Microsoft Teams', 'Por texto ou voz', 'Mais de 120 idiomas']

const ledger: LedgerRow[] = [
  { comp: '03/2025', tipo: 'Provento', rubrica: 'Horas Normais', valor: 'R$ 8.420,00' },
  { comp: '03/2025', tipo: 'Desconto', rubrica: 'I.N.S.S.', valor: 'R$ 908,85' },
  { comp: '04/2025', tipo: 'Provento', rubrica: 'Horas Normais', valor: 'R$ 8.420,00' },
  { comp: '04/2025', tipo: 'Desconto', rubrica: 'Vale Refeição', valor: 'R$ 96,00' },
]

const tabs = [
  { id: 'colaborador', label: 'Colaborador' },
  { id: 'gestor', label: 'Gestor' },
  { id: 'rh', label: 'RH' },
] as const

type TabId = (typeof tabs)[number]['id']

function ChatFor({ tab }: { tab: TabId }) {
  if (tab === 'colaborador') {
    return (
      <Conversation key="colaborador" stagger={0.45}>
        <UserBubble time="15:49">Quero meu holerite de março de 2025</UserBubble>
        <NatiBubble>
          <p className="pr-6">
            Seu <b>holerite de Março/2025</b> já foi gerado e enviado pra você.
            <Check className="ml-1 inline h-3.5 w-3.5 text-emerald-600" strokeWidth={3} aria-hidden />
          </p>
          <p className="mt-2">
            Se quiser, posso gerar também de <b>outro mês/ano</b> ou o seu <b>informe de rendimentos</b>.
          </p>
        </NatiBubble>
        <UserBubble time="15:50">Quais são meus dados de férias deste ano?</UserBubble>
        <NatiBubble>
          Pelos seus registros de férias deste ano:
          <ul className="mt-1.5 list-disc space-y-0.5 pl-4">
            <li>
              <b>Período aquisitivo:</b> 03/06/2025 a 02/06/2026
            </li>
            <li>
              <b>Saldo disponível:</b> 30 dias
            </li>
            <li>
              <b>Data limite para programar:</b> 02/06/2027
            </li>
          </ul>
        </NatiBubble>
      </Conversation>
    )
  }
  if (tab === 'gestor') {
    return (
      <Conversation key="gestor" stagger={0.45}>
        <UserBubble time="09:12">Como está o banco de horas da minha equipe?</UserBubble>
        <NatiBubble>
          <p className="pr-6">
            <b>Análise:</b> 3 pessoas estão acima de 40 h positivas. <b>Diagnóstico:</b> concentração na escala noturna.
          </p>
          <p className="mt-2">
            <b>Ponto de atenção:</b> o limite da convenção é 60 h. <b>Sugestão:</b> programar folgas compensadas até 30/09.
          </p>
        </NatiBubble>
        <NatiAnswerFooter sources={3} note="Resposta baseada no Ponto Eletrônico e na convenção coletiva cadastrada." />
      </Conversation>
    )
  }
  return (
    <Conversation key="rh" stagger={0.45}>
      <UserBubble time="14:07">Compare a folha de março e abril de 2025 e me diga se há algo a se preocupar</UserBubble>
      <NatiBubble>
        <p className="pr-6">
          Abaixo está o histórico de <b>março</b> e <b>abril de 2025</b>, com o comparativo das diferenças.
        </p>
        <NatiTable rows={ledger} className="mt-3" />
        <p className="mt-3">
          <b>Comparativo:</b> proventos idênticos. A diferença é o desconto de Vale Refeição em abril, previsto no plano. <b>Nada a se
          preocupar.</b>
        </p>
      </NatiBubble>
      <NatiAnswerFooter sources={2} />
    </Conversation>
  )
}

export function NatiSection() {
  const [tab, setTab] = useState<TabId>('colaborador')

  return (
    <Section id="nati" tone="dark" className="overflow-hidden" aria-labelledby="nati-title">
      <div className="pointer-events-none absolute inset-0" aria-hidden>
        <LogoOutline className="absolute -bottom-[40%] -left-[14%] h-[130%] w-auto text-white/[0.12]" />
        <div className="absolute inset-0 bg-[radial-gradient(55%_50%_at_80%_20%,rgba(154,64,138,0.35),transparent_65%)]" />
      </div>

      <div className="container relative">
        {/* A NATI se apresenta: o título é uma mensagem dela, digitada */}
        <div className="max-w-3xl">
          <Reveal y={12} duration={0.5}>
            <Eyebrow tone="white">NATI · Sua agente digital de RH</Eyebrow>
          </Reveal>
          <Reveal delay={0.1} className="mt-6 flex items-start gap-3 sm:gap-4">
            <NatiAvatar ring className="h-12 w-12 shrink-0 sm:h-14 sm:w-14" />
            <div className="relative rounded-3xl rounded-tl-lg bg-white px-5 py-4 text-brand-ink shadow-lift sm:px-6 sm:py-5">
              <h2 id="nati-title" className="text-xl font-extrabold leading-snug sm:text-2xl lg:text-[1.75rem]">
                <TypedText text="Oi, eu sou a NATI. Trabalho dentro do sistema, respondo o RH em linguagem natural e faço a parte chata por você." />
              </h2>
              <span className="mt-2 block text-[11px] font-semibold uppercase tracking-[0.12em] text-brand-graphite">agora · no sistema, no WhatsApp e no Teams</span>
            </div>
          </Reveal>
          <Reveal delay={0.25}>
            <p className="mt-6 text-lg leading-relaxed text-white/75 sm:text-xl">
              A NATI gera relatórios e gráficos na hora e analisa folha, ponto, benefícios e talentos. Cada resposta traz análise, diagnóstico, pontos de atenção e sugestão.
            </p>
          </Reveal>
        </div>

        <div className="mt-12 grid items-start gap-10 lg:mt-16 lg:grid-cols-[1fr_1.15fr] lg:gap-14">
          <div className="min-w-0">
            <Stagger className="grid gap-3 sm:grid-cols-2 lg:grid-cols-1" stagger={0.08}>
              {pillars.map(({ icon: Icon, title, text }) => (
                <StaggerItem key={title} className="flex gap-4 rounded-2xl border border-white/12 bg-white/[0.06] p-5 backdrop-blur-sm">
                  <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-white/10 text-[#E4A9C4]">
                    <Icon className="h-5 w-5" strokeWidth={1.7} />
                  </span>
                  <div>
                    <h3 className="font-bold">{title}</h3>
                    <p className="mt-1 text-[14.5px] leading-relaxed text-white/70">{text}</p>
                  </div>
                </StaggerItem>
              ))}
            </Stagger>

            <Reveal delay={0.3} className="mt-6 flex flex-wrap items-center gap-2">
              {rule.map((r, i) => (
                <span key={r} className="flex items-center gap-2 text-[13px] font-semibold">
                  <span className="rounded-full border border-white/20 bg-white/10 px-3 py-1">{r}</span>
                  {i < rule.length - 1 && <span className="text-white/40" aria-hidden>→</span>}
                </span>
              ))}
            </Reveal>

            <Reveal delay={0.4} className="mt-8">
              <Link to="/modulos/nati" className="group inline-flex items-center gap-2 text-[15px] font-semibold text-white">
                Conhecer a NATI em detalhes
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
              </Link>
            </Reveal>
          </div>

          <div className="min-w-0">
            <div role="tablist" aria-label="Exemplos de conversa por perfil" className="mb-4 inline-flex rounded-xl border border-white/15 bg-white/5 p-1">
              {tabs.map((t) => (
                <button
                  key={t.id}
                  role="tab"
                  id={`nati-tab-${t.id}`}
                  aria-selected={tab === t.id}
                  aria-controls="nati-chat"
                  onClick={() => setTab(t.id)}
                  className={cn('relative rounded-lg px-4 py-2 text-[13px] font-semibold transition-colors sm:text-sm', tab === t.id ? 'text-brand-blue' : 'text-white/70 hover:text-white')}
                >
                  {tab === t.id && <m.span layoutId="nati-home-tab" className="absolute inset-0 rounded-lg bg-white" transition={{ duration: 0.4, ease: EASE }} aria-hidden />}
                  <span className="relative">{t.label}</span>
                </button>
              ))}
            </div>
            <Reveal delay={0.15} className="min-w-0">
              <div id="nati-chat" role="tabpanel" aria-labelledby={`nati-tab-${tab}`}>
                <NatiChatWindow bodyClassName="min-h-[320px]">
                  <ChatFor tab={tab} />
                </NatiChatWindow>
              </div>
            </Reveal>
          </div>
        </div>

        <Reveal delay={0.2} className="mt-12 flex flex-wrap items-center justify-center gap-2 lg:mt-16">
          {channels.map((c) => (
            <span key={c} className="rounded-full border border-white/15 bg-white/[0.06] px-3.5 py-1.5 text-[13px] font-semibold text-white/85">
              {c}
            </span>
          ))}
        </Reveal>
      </div>
    </Section>
  )
}
