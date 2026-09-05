import { useEffect, useRef, useState } from 'react'
import type { ComponentType } from 'react'
import { AnimatePresence, m } from 'motion/react'
import { ArrowRight, Check } from 'lucide-react'
import { Link } from 'react-router'
import { journeyPath } from '@/content/site'
import { Section, Eyebrow } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { EmployeeAvatar } from '@/components/brand/EmployeeAvatar'
import { AdmissionMockup } from '@/components/mockups/AdmissionMockup'
import { FlowMockup } from '@/components/mockups/FlowMockup'
import { RequestMockup } from '@/components/mockups/RequestMockup'
import { SesmtMockup } from '@/components/mockups/SesmtMockup'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

/**
 * A jornada com personalidade de história: o texto rola, a tela fica fixa e troca
 * a cada momento. Uma personagem (a Ana), quatro cenas, um sistema.
 */

interface Feature {
  id: string
  eyebrow: string
  moment: string
  title: string
  text: string
  bullets: string[]
  mockup: ComponentType<{ className?: string }>
  label: string
}

const features: Feature[] = [
  {
    id: 'admissao',
    eyebrow: 'Talentos · Admissão Digital',
    moment: 'Semana 1',
    title: 'A admissão que leva minutos, não dias.',
    text: 'A Ana preenche os próprios dados no Portal do Candidato, anexa os documentos no GED e assina o contrato eletronicamente, com validade jurídica. O RH valida e admite em poucos cliques. Folha, ponto e benefícios já nascem prontos.',
    bullets: [
      'Coleta eletrônica de dados e documentos, sem papel',
      'Assinatura eletrônica com validade jurídica (padrão ICP-Brasil)',
      'Integração nativa com a folha: zero digitação, zero retrabalho',
    ],
    mockup: AdmissionMockup,
    label: 'Tela da admissão digital: dados, documentos e contrato assinado',
  },
  {
    id: 'ponto-folha',
    eyebrow: 'Ponto e Jornada · Pessoal e Folha',
    moment: 'Primeiro dia',
    title: 'O ponto chega certo. A folha fecha rápido.',
    text: 'A marcação no NatPonto, com geolocalização e reconhecimento facial, ou no relógio da empresa é apurada conforme a jornada: fixa, flexível, variável ou 12x36. Os eventos vão direto para a folha, calculada a 2.500 colaboradores por minuto, e o eSocial é enviado e acompanhado no mesmo lugar.',
    bullets: [
      'Banco de horas, DSR, adicional noturno e escalas por convenção',
      'Abono de marcações com workflow e comprovante anexado',
      'eSocial: envio e retorno de cada layout, sem retrabalho',
    ],
    mockup: FlowMockup,
    label: 'Fluxo do ponto para a folha e para o eSocial',
  },
  {
    id: 'requisicoes',
    eyebrow: 'Autoatendimento · Requisições com workflow',
    moment: 'Primeiro mês',
    title: 'Aprovou, efetivou. Sem digitar de novo.',
    text: 'Férias, vaga, promoção, movimentação, desligamento, reembolso, atestado, abono: o pedido nasce no portal, o fluxo de aprovação roda e, aprovado, o sistema efetiva a informação automaticamente. A NATI e o Chamado Interno resolvem as dúvidas antes de virarem e-mail.',
    bullets: [
      'Mais de 25 tipos de requisição com alçadas parametrizáveis',
      'Portais do Gestor, do Colaborador e do Candidato',
      'Rastreabilidade: histórico completo de cada pedido',
    ],
    mockup: RequestMockup,
    label: 'Requisição de férias passando pelo fluxo de aprovação',
  },
  {
    id: 'sesmt',
    eyebrow: 'Saúde e Segurança · SESMT',
    moment: 'Todo ano',
    title: 'Exames, riscos e documentos em dia, dentro do RH.',
    text: 'Medicina e Segurança do Trabalho operam na mesma base do RH: do PGR ao GHE, do PCMSO ao ASO digital. EPIs com CA validado, CAT, LTCAT e PPP eletrônico. Os eventos de SST do eSocial saem com validação prévia, sem multa por divergência.',
    bullets: [
      'ASO, PCMSO, PGR, LTCAT, PPP e CAT emitidos pelo sistema',
      'Alertas de exames e treinamentos de NR a vencer',
      'Fluxo digital de acidentes, afastamentos e CIPA',
    ],
    mockup: SesmtMockup,
    label: 'Painel do SESMT: exames, EPIs e documentos em dia',
  },
]

export function JourneySection() {
  const [active, setActive] = useState(0)
  const stepRefs = useRef<(HTMLLIElement | null)[]>([])

  useEffect(() => {
    const els = stepRefs.current.filter((el): el is HTMLLIElement => Boolean(el))
    if (!els.length || typeof IntersectionObserver === 'undefined') return
    const io = new IntersectionObserver(
      (entries) => {
        entries.forEach((e) => {
          if (e.isIntersecting) setActive(Number((e.target as HTMLElement).dataset.step))
        })
      },
      { rootMargin: '-42% 0px -48% 0px', threshold: 0 },
    )
    els.forEach((el) => io.observe(el))
    return () => io.disconnect()
  }, [])

  const Active = features[active].mockup

  return (
    <Section id="jornada" tone="white" className="overflow-x-clip" aria-labelledby="jornada-title">
      <div className="container">
        {/* Abertura em tom de história */}
        <div className="max-w-4xl">
          <Reveal y={12} duration={0.5} className="flex flex-wrap items-center gap-3">
            <EmployeeAvatar ring className="h-11 w-11" />
            <Eyebrow trail={false}>A jornada da Ana · quatro momentos, um sistema</Eyebrow>
          </Reveal>
          <Reveal delay={0.1}>
            <h2 id="jornada-title" className="mt-5 text-3xl font-extrabold leading-[1.1] text-brand-ink sm:text-4xl lg:text-5xl">
              Uma vaga nasce numa segunda-feira. Três semanas depois, <span className="text-brand-purple">a Ana bate o ponto.</span>
            </h2>
          </Reveal>
          <Reveal delay={0.2}>
            <p className="mt-5 max-w-2xl text-lg leading-relaxed text-brand-graphite">
              Cada momento da jornada acontece dentro do sistema e alimenta o próximo. Role e acompanhe: a tela muda com a história.
            </p>
          </Reveal>
        </div>

        <div className="mt-10 lg:mt-16 lg:grid lg:grid-cols-[minmax(0,1fr)_minmax(0,1.15fr)] lg:gap-16">
          {/* Momentos */}
          <ol className="relative">
            <span className="absolute left-[19px] top-6 hidden h-[calc(100%-3rem)] w-px bg-brand-mist lg:block" aria-hidden />
            {features.map((f, i) => {
              const Mockup = f.mockup
              const current = i === active
              return (
                <li
                  key={f.id}
                  ref={(el) => {
                    stepRefs.current[i] = el
                  }}
                  data-step={i}
                  className="relative py-10 lg:flex lg:min-h-[78vh] lg:items-center lg:py-12"
                  aria-labelledby={`${f.id}-title`}
                >
                  <div className="lg:pl-16">
                    <span className="absolute left-0 top-10 hidden lg:block lg:top-1/2 lg:-translate-y-1/2" aria-hidden>
                      <span
                        className={cn(
                          'flex h-10 w-10 items-center justify-center rounded-full border text-[12px] font-extrabold transition-colors duration-500',
                          current ? 'border-brand-purple bg-brand-purple text-white' : 'border-brand-mist bg-white text-brand-graphite',
                        )}
                      >
                        {String(i + 1).padStart(2, '0')}
                      </span>
                    </span>
                    <Reveal y={12} duration={0.5} className="flex flex-wrap items-center gap-x-3 gap-y-1">
                      <span className="rounded-full bg-brand-purple/10 px-2.5 py-1 text-[11px] font-bold uppercase tracking-[0.12em] text-brand-purple">{f.moment}</span>
                      <Eyebrow trail={false} className="text-brand-graphite">
                        {f.eyebrow}
                      </Eyebrow>
                    </Reveal>
                    <Reveal delay={0.08}>
                      <h3 id={`${f.id}-title`} className="mt-4 text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl lg:text-[2.1rem]">
                        {f.title}
                      </h3>
                    </Reveal>
                    <Reveal delay={0.16}>
                      <p className="mt-4 text-[16px] leading-relaxed text-brand-graphite">{f.text}</p>
                    </Reveal>
                    <Stagger className="mt-5 space-y-2.5" delay={0.25}>
                      {f.bullets.map((b) => (
                        <StaggerItem key={b} className="flex items-start gap-3 text-[15px] font-medium text-brand-ink">
                          <span className="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                            <Check className="h-3 w-3" strokeWidth={3} aria-hidden />
                          </span>
                          {b}
                        </StaggerItem>
                      ))}
                    </Stagger>
                    {/* No celular a tela vem logo abaixo de cada momento */}
                    <Reveal delay={0.2} className="relative mt-8 lg:hidden">
                      <Glow />
                      <div role="img" aria-label={f.label}>
                        <div inert>
                          <Mockup className="relative" />
                        </div>
                      </div>
                    </Reveal>
                  </div>
                </li>
              )
            })}
          </ol>

          {/* Tela fixa (desktop) */}
          <div className="hidden lg:block">
            <div className="sticky top-[calc(var(--nav-h)+2rem)] flex h-[calc(100vh-var(--nav-h)-4rem)] items-center">
              <div className="relative w-full">
                <Glow />
                <div role="img" aria-label={features[active].label} className="relative">
                  <AnimatePresence mode="wait" initial={false}>
                    <m.div
                      key={features[active].id}
                      initial={{ opacity: 0, y: 28, scale: 0.98 }}
                      animate={{ opacity: 1, y: 0, scale: 1 }}
                      exit={{ opacity: 0, y: -18, scale: 0.985 }}
                      transition={{ duration: 0.5, ease: EASE }}
                    >
                      <div inert>
                        <Active className="relative" />
                      </div>
                    </m.div>
                  </AnimatePresence>
                </div>
                <ol className="mt-6 flex items-center justify-center gap-2" aria-label="Momento em destaque">
                  {features.map((f, i) => (
                    <li key={f.id} aria-current={i === active ? 'step' : undefined}>
                      <span className={cn('block h-1.5 rounded-full transition-all duration-500', i === active ? 'w-8 bg-brand-purple' : 'w-3 bg-brand-mist')} />
                      <span className="sr-only">{f.moment}</span>
                    </li>
                  ))}
                </ol>
              </div>
            </div>
          </div>
        </div>

        <Reveal delay={0.1} className="mt-12 lg:mt-8">
          <Link
            to={journeyPath}
            className="group flex flex-col gap-5 rounded-3xl bg-brand-blue p-6 text-white shadow-soft transition-[transform,box-shadow] duration-500 ease-brand hover:-translate-y-1 hover:shadow-lift sm:flex-row sm:items-center sm:justify-between sm:p-8"
          >
            <span>
              <span className="block text-[12px] font-semibold uppercase tracking-[0.16em] text-[#E4A9C4]">A história completa, etapa por etapa</span>
              <span className="mt-2 block text-xl font-extrabold leading-snug sm:text-2xl">As 21 etapas da jornada da Ana, da requisição da vaga à promoção.</span>
              <span className="mt-2 block max-w-2xl text-[15px] leading-relaxed text-white/70">Com o fluxograma que acompanha a rolagem e os módulos que entram em cada etapa.</span>
            </span>
            <span className="inline-flex shrink-0 items-center gap-2 rounded-lg bg-white px-5 py-3 text-sm font-semibold text-brand-purple transition-colors duration-300 group-hover:bg-[#F3DCE7]">
              Ler a história
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </span>
          </Link>
        </Reveal>
      </div>
    </Section>
  )
}

function Glow() {
  return <div aria-hidden className="pointer-events-none absolute -inset-6 rounded-[2rem] bg-[radial-gradient(60%_60%_at_50%_50%,rgba(154,64,138,0.16),transparent_70%)]" />
}
