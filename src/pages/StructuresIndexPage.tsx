import { Link } from 'react-router'
import { ArrowRight, Building2, Check, ChevronRight, Network, Send } from 'lucide-react'
import { Section, Eyebrow, SectionHeader } from '@/components/sections/Section'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { StructureChooser } from '@/components/structure/StructureChooser'
import { useSeo } from '@/hooks/useSeo'
import { chooserQuestions, structureIcons, structurePath, structureRegistry, structuresPath } from '@/content/structures'
import { paths } from '@/content/site'

const promises = [
  { t: 'Três perguntas', d: 'Quantas empresas, onde estão as equipes e como o RH opera. Sem cadastro, sem formulário.' },
  { t: 'Cinco estruturas', d: 'Empresa única, várias unidades, grupo com RH central, RH em cada unidade e equipes alocadas em clientes.' },
  { t: 'Um destino', d: 'Em todas elas, o caminho leva ao mesmo lugar: um único time de RH operando tudo, o centro de serviços compartilhados.' },
]

const cscBullets = [
  { icon: Network, text: 'Um time, várias empresas e unidades' },
  { icon: Send, text: 'Requisições eletrônicas pelos portais' },
  { icon: Building2, text: 'Folha, eSocial e contabilização por empresa' },
]

export default function StructuresIndexPage() {
  useSeo({
    title: 'Como é a sua estrutura? Empresa única, grupo, filiais | Natcorp',
    description:
      'Sistema de RH para empresa única, várias unidades, grupo com RH central, RH por unidade ou equipes em clientes: responda a três perguntas e veja o encaixe.',
    path: structuresPath,
  })

  return (
    <PageTransition>
      {/* Abertura */}
      <Section tone="off" className="overflow-hidden pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="estruturas-title">
        <LogoOutline className="pointer-events-none absolute -right-[10%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Como é a sua estrutura?' }]} />
          <div className="mt-8 grid grid-cols-1 items-end gap-10 lg:grid-cols-[1.4fr_1fr]">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Como é a sua estrutura?</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="estruturas-title"
                text="Como é a [[sua estrutura]]?"
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-6xl"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  Uma empresa numa sede só, uma rede de filiais, um grupo com vários CNPJs, um RH em cada unidade ou equipes trabalhando dentro de
                  clientes. O sistema é o mesmo; o que muda é quem faz o quê, por onde o pedido entra e como a folha fecha. Responda a{' '}
                  {chooserQuestions.length} perguntas e veja a sua.
                </p>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <Link to="#escolha">
                    Responder às {chooserQuestions.length} perguntas
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
                <Button asChild size="lg" variant="secondary">
                  <Link to="#estruturas">Ver as {structureRegistry.length} estruturas</Link>
                </Button>
              </Reveal>
            </div>
            <Reveal delay={0.3} className="grid gap-3">
              {promises.map((p) => (
                <div key={p.t} className="rounded-2xl border border-brand-mist bg-white p-5 shadow-soft">
                  <p className="text-[15px] font-bold text-brand-ink">{p.t}</p>
                  <p className="mt-1 text-[13.5px] leading-snug text-brand-graphite">{p.d}</p>
                </div>
              ))}
            </Reveal>
          </div>
        </div>
      </Section>

      {/* O seletor */}
      <Section id="escolha" tone="white" className="scroll-mt-20" aria-labelledby="escolha-title">
        <div className="container">
          <SectionHeader id="escolha-title" eyebrow="Três perguntas" title="Responda e veja [[qual é a sua]]." lead="O resultado aparece na hora e leva à página da estrutura: como o RH costuma funcionar, quem faz o quê, o fluxo do centro de serviços e os módulos que mais pesam." />
          <Reveal delay={0.15} className="mt-12 rounded-4xl border border-brand-mist bg-brand-off-white p-5 sm:p-8 lg:p-10">
            <StructureChooser />
          </Reveal>
        </div>
      </Section>

      {/* As cinco estruturas */}
      <Section id="estruturas" tone="off" className="scroll-mt-20" aria-labelledby="lista-title">
        <div className="container">
          <SectionHeader id="lista-title" eyebrow={`${structureRegistry.length} estruturas`} title="Ou vá direto [[à sua]]." />
          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-3" stagger={0.06}>
            {structureRegistry.map((s) => {
              const Icon = structureIcons[s.icon]
              return (
                <StaggerItem key={s.slug}>
                  <Link
                    to={structurePath(s.slug)}
                    className="group flex h-full flex-col rounded-3xl border border-brand-mist bg-white p-6 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1.5 hover:border-brand-purple/30 hover:shadow-lift focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple"
                  >
                    <span className="flex h-12 w-12 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                      <Icon className="h-6 w-6" strokeWidth={1.6} aria-hidden />
                    </span>
                    <span className="mt-5 flex items-start gap-1.5 text-xl font-bold leading-snug text-brand-ink group-hover:text-brand-purple">
                      {s.name}
                      <ChevronRight className="mt-1.5 h-4 w-4 shrink-0 text-brand-graphite transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                    </span>
                    <span className="mt-2 flex-1 text-[15px] leading-relaxed text-brand-graphite">{s.short}</span>
                    <span className="mt-5 flex flex-wrap gap-1.5">
                      {s.tags.map((t) => (
                        <span key={t} className="rounded-full bg-brand-off-white px-2.5 py-1 text-[12px] font-semibold text-brand-graphite">
                          {t}
                        </span>
                      ))}
                    </span>
                  </Link>
                </StaggerItem>
              )
            })}
            <StaggerItem>
              <div className="flex h-full flex-col justify-between rounded-3xl border border-dashed border-brand-purple/40 bg-brand-off-white/60 p-6">
                <div>
                  <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-brand-purple">Prefere ver pelo seu segmento?</p>
                  <p className="mt-3 text-[15px] leading-relaxed text-brand-graphite">
                    Indústria, varejo, saúde, serviços, setor público e outros: as dores de cada mercado e os módulos que respondem a elas.
                  </p>
                </div>
                <Link to={paths.segments} className="group mt-5 inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
                  Ver pelo seu segmento
                  <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                </Link>
              </div>
            </StaggerItem>
          </Stagger>
        </div>
      </Section>

      {/* Onde tudo isso leva */}
      <Section id="csc" tone="dark" className="overflow-hidden" aria-labelledby="csc-title">
        <LogoOutline className="pointer-events-none absolute -left-[10%] -top-[40%] h-[150%] w-auto text-white/[0.06]" />
        <div className="container relative grid grid-cols-1 gap-10 lg:grid-cols-[1.3fr_1fr] lg:items-center lg:gap-16">
          <div>
            <SectionHeader
              id="csc-title"
              tone="dark"
              eyebrow="Onde tudo isso leva"
              title="O centro de serviços [[compartilhados]]."
              lead="Seja qual for a estrutura, o caminho leva ao mesmo lugar: um único time de RH fazendo a gestão e a operação de todas as empresas e unidades. As requisições nascem nos portais, chegam a esse time e voltam prontas, por empresa e por unidade."
            />
            <Reveal delay={0.3} className="mt-8 flex flex-wrap gap-3">
              <Button asChild size="lg" variant="inverse">
                <Link to={structurePath('grupo-rh-central')}>
                  Ver o grupo com RH central
                  <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                </Link>
              </Button>
              <Button asChild size="lg" variant="outline-inverse">
                <Link to={paths.portals}>Portais e requisições</Link>
              </Button>
            </Reveal>
          </div>
          <Stagger className="grid gap-3" stagger={0.1} delay={0.2}>
            {cscBullets.map((b) => (
              <StaggerItem key={b.text} className="flex items-center gap-4 rounded-2xl border border-white/10 bg-white/[0.05] p-5">
                <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-[#E4A9C4] text-brand-blue">
                  <b.icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                </span>
                <span className="flex items-center gap-2 text-[16px] font-bold text-white">
                  {b.text}
                  <Check className="h-4 w-4 shrink-0 text-[#E4A9C4]" strokeWidth={2.5} aria-hidden />
                </span>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      <CTASection title="Veja a Natcorp com a estrutura da sua empresa." />
    </PageTransition>
  )
}
