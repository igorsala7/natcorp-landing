import { useState } from 'react'
import { Link } from 'react-router'
import { m } from 'motion/react'
import { ArrowRight, Check } from 'lucide-react'
import { Section, Eyebrow } from './Section'
import { TypedText } from '@/components/motion/TypedText'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { LogoOutline } from '@/components/brand/Logo'
import { NeuralHub } from '@/components/nati/NeuralHub'
import { InsightStream } from '@/components/nati/InsightStream'
import { NetworkField } from '@/components/nati/NetworkField'
import { NatiStats } from '@/components/nati/NatiStats'
import { capabilities } from '@/content/nati'
import { paths } from '@/content/site'
import { Conversation, NatiAnswerFooter, NatiBubble, NatiChatWindow, UserBubble } from '@/components/mockups/nati/NatiChatWindow'
import { NatiTable, type LedgerRow } from '@/components/mockups/nati/NatiTable'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

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
        <NetworkField density={0.7} className="opacity-70" />
        <LogoOutline className="absolute -bottom-[40%] -left-[14%] h-[130%] w-auto text-white/[0.10]" />
        <div className="absolute inset-0 bg-[radial-gradient(55%_50%_at_80%_15%,rgba(154,64,138,0.4),transparent_65%)]" />
        <div className="absolute inset-0 bg-[radial-gradient(40%_40%_at_10%_90%,rgba(201,87,136,0.18),transparent_70%)]" />
      </div>

      <div className="container relative">
        {/* A NATI se apresenta: o título é uma mensagem dela, digitada */}
        <div className="max-w-3xl">
          <Reveal y={12} duration={0.5}>
            <Eyebrow tone="white">Inteligência Artificial · NATI, a IA especialista em RH</Eyebrow>
          </Reveal>
          <Reveal delay={0.1} className="mt-6 flex items-start gap-3 sm:gap-4">
            <NatiAvatar ring className="h-12 w-12 shrink-0 sm:h-14 sm:w-14" />
            <div className="relative rounded-3xl rounded-tl-lg bg-white px-5 py-4 text-brand-ink shadow-lift sm:px-6 sm:py-5">
              <h2 id="nati-title" className="text-xl font-extrabold leading-snug sm:text-2xl lg:text-[1.75rem]">
                <TypedText text="Oi, eu sou a NATI. Leio os 31 módulos do sistema, cruzo folha, ponto, SESMT e talentos e respondo em segundos, com análise e sugestão." />
              </h2>
              <span className="mt-2 block text-[11px] font-semibold uppercase tracking-[0.12em] text-brand-graphite">agora · no sistema, no WhatsApp e no Teams</span>
            </div>
          </Reveal>
          <Reveal delay={0.25}>
            <p className="mt-6 text-lg leading-relaxed text-white/75 sm:text-xl">
              A NATI não é um chatbot de respostas prontas. É uma Inteligência Artificial treinada em cada frente do RH, que enxerga a operação inteira e transforma dado em decisão: análise, diagnóstico, pontos de atenção e sugestão, com as fontes citadas.
            </p>
          </Reveal>
        </div>

        {/* O sistema inteiro fluindo para a NATI, e a NATI analisando */}
        <div className="mt-12 grid grid-cols-1 items-center gap-10 lg:mt-16 lg:grid-cols-[1.1fr_1fr] lg:gap-12">
          <Reveal delay={0.15} className="mx-auto w-full max-w-[560px] lg:max-w-none">
            <NeuralHub />
            <p className="mt-3 text-center text-[12.5px] text-white/55">Sete frentes, 31 módulos, uma única Inteligência Artificial lendo tudo ao mesmo tempo.</p>
          </Reveal>
          <Reveal delay={0.25} className="min-w-0">
            <InsightStream />
          </Reveal>
        </div>

        <Reveal delay={0.1} className="mt-14 lg:mt-20">
          <NatiStats tone="dark" />
        </Reveal>

        {/* Cinco capacidades */}
        <Stagger className="mt-12 grid grid-cols-2 gap-x-6 gap-y-6 border-t border-white/10 pt-8 sm:grid-cols-3 lg:grid-cols-5" stagger={0.08}>
          {capabilities.map((c) => (
            <StaggerItem key={c.id}>
              <p className="text-[12px] font-extrabold uppercase tracking-[0.14em] text-[#E4A9C4]">{c.name}</p>
              <p className="mt-1.5 text-[14px] leading-snug text-white/75">{c.text}</p>
            </StaggerItem>
          ))}
        </Stagger>

        {/* E quando alguém pergunta */}
        <div className="mt-16 grid items-start gap-10 lg:mt-20 lg:grid-cols-[1fr_1.15fr] lg:gap-14">
          <div className="min-w-0">
            <Reveal y={12} duration={0.5}>
              <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-[#E4A9C4]">E quando alguém pergunta</p>
            </Reveal>
            <Reveal delay={0.08}>
              <h3 className="mt-3 text-2xl font-extrabold leading-tight sm:text-3xl">Pergunte como perguntaria a uma pessoa. Receba o que uma equipe inteira levaria dias para montar.</h3>
            </Reveal>
            <Reveal delay={0.16}>
              <p className="mt-4 text-[15.5px] leading-relaxed text-white/70">
                Colaborador, gestor e RH falam com a mesma NATI, cada um vendo só o que o seu perfil permite. Toda resposta segue a regra da casa:
              </p>
            </Reveal>
            <Reveal delay={0.24} className="mt-5 flex flex-wrap items-center gap-2">
              {rule.map((r, i) => (
                <span key={r} className="flex items-center gap-2 text-[13px] font-semibold">
                  <span className="rounded-full border border-white/20 bg-white/10 px-3 py-1">{r}</span>
                  {i < rule.length - 1 && <ArrowRight className="h-3.5 w-3.5 text-white/40" aria-hidden />}
                </span>
              ))}
            </Reveal>
            <Reveal delay={0.3} className="mt-6 flex flex-wrap items-center gap-2">
              {channels.map((c) => (
                <span key={c} className="rounded-full border border-white/15 bg-white/[0.06] px-3.5 py-1.5 text-[13px] font-semibold text-white/85">
                  {c}
                </span>
              ))}
            </Reveal>
            <Reveal delay={0.4} className="mt-8">
              <Link to={paths.nati} className="group inline-flex items-center gap-2 text-[15px] font-semibold text-white">
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
      </div>
    </Section>
  )
}
