import type { ComponentType, ReactNode } from 'react'
import { ArrowRight, Check } from 'lucide-react'
import { Link } from 'react-router'
import { journeyPath } from '@/content/site'
import { Section, SectionHeader, Eyebrow } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Parallax } from '@/components/motion/Parallax'
import { AdmissionMockup } from '@/components/mockups/AdmissionMockup'
import { FlowMockup } from '@/components/mockups/FlowMockup'
import { RequestMockup } from '@/components/mockups/RequestMockup'
import { SesmtMockup } from '@/components/mockups/SesmtMockup'
import { cn } from '@/lib/utils'

interface Feature {
  id: string
  eyebrow: string
  title: string
  text: string
  bullets: string[]
  mockup: ComponentType<{ className?: string }>
}

const features: Feature[] = [
  {
    id: 'admissao',
    eyebrow: 'Talentos · Admissão Digital',
    title: 'A admissão que leva minutos, não dias.',
    text: 'O candidato preenche os próprios dados no Portal do Candidato, anexa os documentos no GED e assina o contrato eletronicamente, com validade jurídica. O RH valida e admite em poucos cliques. Folha, ponto e benefícios já nascem prontos.',
    bullets: [
      'Coleta eletrônica de dados e documentos, sem papel',
      'Assinatura eletrônica com validade jurídica (padrão ICP-Brasil)',
      'Integração nativa com a folha: zero digitação, zero retrabalho',
    ],
    mockup: AdmissionMockup,
  },
  {
    id: 'ponto-folha',
    eyebrow: 'Ponto e Jornada · Pessoal e Folha',
    title: 'O ponto chega certo. A folha fecha rápido.',
    text: 'A marcação no NatPonto, com geolocalização e reconhecimento facial, ou no relógio da empresa é apurada conforme a jornada: fixa, flexível, variável ou 12×36. Os eventos vão direto para a folha, calculada a 2.500 colaboradores por minuto, e o eSocial é enviado e acompanhado no mesmo lugar.',
    bullets: [
      'Banco de horas, DSR, adicional noturno e escalas por convenção',
      'Abono de marcações com workflow e comprovante anexado',
      'eSocial: envio e retorno de cada layout, sem retrabalho',
    ],
    mockup: FlowMockup,
  },
  {
    id: 'requisicoes',
    eyebrow: 'Autoatendimento · Requisições com workflow',
    title: 'Aprovou, efetivou. Sem digitar de novo.',
    text: 'Férias, vaga, promoção, movimentação, desligamento, reembolso, atestado, abono: o pedido nasce no portal, o fluxo de aprovação roda e, aprovado, o sistema efetiva a informação automaticamente. A NATI e o Chamado Interno resolvem as dúvidas antes de virarem e-mail.',
    bullets: [
      'Mais de 25 tipos de requisição com alçadas parametrizáveis',
      'Portais do Gestor, do Colaborador e do Candidato',
      'Rastreabilidade: histórico completo de cada pedido',
    ],
    mockup: RequestMockup,
  },
  {
    id: 'sesmt',
    eyebrow: 'Saúde e Segurança · SESMT',
    title: 'Exames, riscos e documentos em dia, dentro do RH.',
    text: 'Medicina e Segurança do Trabalho operam na mesma base do RH: do PGR ao GHE, do PCMSO ao ASO digital. EPIs com CA validado, CAT, LTCAT e PPP eletrônico. Os eventos de SST do eSocial saem com validação prévia, sem multa por divergência.',
    bullets: [
      'ASO, PCMSO, PGR, LTCAT, PPP e CAT emitidos pelo sistema',
      'Alertas de exames e treinamentos de NR a vencer',
      'Fluxo digital de acidentes, afastamentos e CIPA',
    ],
    mockup: SesmtMockup,
  },
]

export function JourneySection() {
  return (
    <Section id="jornada" tone="off" className="overflow-hidden" aria-labelledby="jornada-title">
      <div className="container">
        <SectionHeader
          id="jornada-title"
          eyebrow="A jornada do colaborador"
          title="Do candidato ao desligamento, [[sem papel]]."
          lead="Cada etapa da jornada acontece dentro do sistema e alimenta a próxima. Uma ação inicial, dezenas de atualizações automáticas."
        />

        <div className="mt-16 space-y-24 lg:mt-24 lg:space-y-32">
          {features.map((f, i) => (
            <FeatureBlock key={f.id} feature={f} reverse={i % 2 === 1} />
          ))}
        </div>

        <Reveal delay={0.1} className="mt-20 lg:mt-28">
          <Link
            to={journeyPath}
            className="group flex flex-col gap-5 rounded-3xl border border-brand-mist bg-white p-6 shadow-soft transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift sm:flex-row sm:items-center sm:justify-between sm:p-8"
          >
            <span>
              <span className="block text-[12px] font-semibold uppercase tracking-[0.16em] text-brand-purple">Jornada do colaborador, etapa por etapa</span>
              <span className="mt-2 block text-xl font-extrabold leading-snug text-brand-ink sm:text-2xl">
                Uma vaga nasce numa segunda-feira. Três semanas depois, a Ana bate o ponto.
              </span>
              <span className="mt-2 block max-w-2xl text-[15px] leading-relaxed text-brand-graphite">
                As 21 etapas, da requisição da vaga à promoção, contadas como um exemplo do dia a dia, com os módulos que entram em cada uma.
              </span>
            </span>
            <span className="inline-flex shrink-0 items-center gap-2 rounded-lg bg-brand-purple px-5 py-3 text-sm font-semibold text-white transition-colors duration-300 group-hover:bg-brand-purple-hover">
              Ler a história
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </span>
          </Link>
        </Reveal>
      </div>
    </Section>
  )
}

function FeatureBlock({ feature, reverse }: { feature: Feature; reverse: boolean }) {
  const Mockup = feature.mockup
  return (
    <article
      className={cn('grid items-center gap-10 lg:grid-cols-2 lg:gap-16', reverse && 'lg:[&>*:first-child]:order-2')}
      aria-labelledby={`${feature.id}-title`}
    >
      <div>
        <Reveal y={12} duration={0.5}>
          <Eyebrow>{feature.eyebrow}</Eyebrow>
        </Reveal>
        <Reveal delay={0.08}>
          <h3 id={`${feature.id}-title`} className="mt-4 text-3xl font-extrabold leading-tight text-brand-ink sm:text-4xl">
            {feature.title}
          </h3>
        </Reveal>
        <Reveal delay={0.16}>
          <p className="mt-5 text-[17px] leading-relaxed text-brand-graphite">{feature.text}</p>
        </Reveal>
        <Stagger className="mt-6 space-y-3" delay={0.25}>
          {feature.bullets.map((b) => (
            <StaggerItem key={b} className="flex items-start gap-3 text-[15px] font-medium text-brand-ink">
              <span className="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                <Check className="h-3 w-3" strokeWidth={3} />
              </span>
              {b}
            </StaggerItem>
          ))}
        </Stagger>
      </div>
      <Parallax distance={28} className="relative">
        <Glow />
        <Mockup className="relative" />
      </Parallax>
    </article>
  )
}

function Glow(): ReactNode {
  return (
    <div
      aria-hidden
      className="pointer-events-none absolute -inset-6 rounded-[2rem] bg-[radial-gradient(60%_60%_at_50%_50%,rgba(154,64,138,0.16),transparent_70%)]"
    />
  )
}
