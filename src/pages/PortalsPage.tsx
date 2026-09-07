import { Link } from 'react-router'
import { ArrowRight, Check, ChevronRight } from 'lucide-react'
import { Section, SectionHeader, Eyebrow } from '@/components/sections/Section'
import { PortalsSection } from '@/components/sections/PortalsSection'
import { StructureStrip } from '@/components/sections/StructureStrip'
import { ResponsiveSection } from '@/components/sections/ResponsiveSection'
import { FAQSection } from '@/components/sections/FAQSection'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { RequestMockup } from '@/components/mockups/RequestMockup'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'
import { faqs, type FaqItem } from '@/content/faq'
import { modulePath, modulesByGroup } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import { paths } from '@/content/site'
import { structurePath } from '@/content/structures'

const stats = [
  { value: '3', label: 'portais: gestor, colaborador e candidato' },
  { value: '+25', label: 'tipos de requisição com alçadas de aprovação' },
  { value: '24x7', label: 'NATI e Chamado Interno respondendo' },
]

const requestBullets = [
  'Mais de 25 tipos de requisição com alçadas parametrizáveis',
  'Aprovado no fluxo, efetivado no sistema, sem redigitar',
  'Histórico completo de cada pedido, para quem pediu e para quem aprovou',
]

const localFaq: FaqItem[] = [
  {
    q: 'O que o colaborador resolve sozinho no portal?',
    a: 'Holerite, informe de rendimentos, espelho de ponto, pedidos de férias, atestados, reembolsos, documentos para assinar e chamados. As dúvidas mais comuns a NATI responde na hora, no portal ou no WhatsApp.',
  },
  {
    q: 'Como o gestor aprova pelo celular?',
    a: 'O Portal do Gestor mostra as pendências da equipe: requisições, marcações de ponto, férias e avaliações. O gestor aprova ou devolve com um toque, o sistema efetiva a informação e avisa quem pediu.',
  },
  {
    q: 'O candidato precisa de cadastro?',
    a: 'Ele cria o próprio perfil no Quadro de Vagas, com a marca da sua empresa, acompanha o processo seletivo e, se aprovado, faz a admissão digital no mesmo portal, incluindo a assinatura do contrato.',
  },
]

export default function PortalsPage() {
  useSeo({
    title: 'Portais e autoatendimento do RH | Natcorp',
    description:
      'Portais do Gestor, do Colaborador e do Candidato: holerite, ponto, férias, aprovações, admissão digital e requisições com workflow, no celular ou no computador.',
    path: paths.portals,
  })
  const modules = modulesByGroup('autoatendimento')
  const faqItems = [
    ...faqs.filter((f) => f.q.startsWith('Cada filial pode operar')),
    ...faqs.filter((f) => f.q.startsWith('Funciona no celular')),
    ...localFaq,
  ]

  return (
    <PageTransition>
      <Section tone="off" className="overflow-hidden pb-12 pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pb-16 lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="portais-page-title">
        <LogoOutline className="pointer-events-none absolute -right-[10%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Portais e autoatendimento' }]} />
          <div className="mt-8 grid items-end gap-10 lg:grid-cols-[1.4fr_1fr]">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Portais e autoatendimento</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="portais-page-title"
                text="Cada pessoa com o seu portal. [[O RH sem fila.]]"
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-6xl"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  Gestor, colaborador e candidato resolvem o que precisam sozinhos, no celular ou no computador. O pedido
                  nasce no portal, passa pelo fluxo de aprovação e é efetivado no sistema. O RH acompanha, em vez de digitar.
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
                  <Link to={paths.journey}>Ver a jornada do colaborador</Link>
                </Button>
              </Reveal>
            </div>
            <Reveal delay={0.3} className="grid grid-cols-3 gap-3 lg:grid-cols-1">
              {stats.map((s) => (
                <div key={s.label} className="rounded-2xl border border-brand-mist bg-white p-5 shadow-soft">
                  <p className="text-3xl font-extrabold tracking-brand text-brand-purple">{s.value}</p>
                  <p className="mt-1 text-sm text-brand-graphite">{s.label}</p>
                </div>
              ))}
            </Reveal>
          </div>
        </div>
      </Section>

      <PortalsSection withHeader={false} />

      {/* Requisições com workflow */}
      <Section id="requisicoes" tone="off" aria-labelledby="requisicoes-title">
        <div className="container grid items-center gap-10 lg:grid-cols-2 lg:gap-16">
          <div>
            <Reveal y={12} duration={0.5}>
              <Eyebrow>Requisições com workflow</Eyebrow>
            </Reveal>
            <Reveal delay={0.08}>
              <h2 id="requisicoes-title" className="mt-4 text-3xl font-extrabold leading-tight text-brand-ink sm:text-4xl">
                Aprovou, efetivou. <span className="text-brand-purple">Sem digitar de novo.</span>
              </h2>
            </Reveal>
            <Reveal delay={0.16}>
              <p className="mt-5 text-[17px] leading-relaxed text-brand-graphite">
                Férias, vaga, promoção, movimentação, desligamento, reembolso, atestado, abono: o pedido nasce no portal, o
                fluxo de aprovação roda e, aprovado, o sistema efetiva a informação automaticamente. A NATI e o Chamado
                Interno resolvem as dúvidas antes de virarem e-mail.
              </p>
            </Reveal>
            <Stagger className="mt-6 space-y-3" delay={0.25}>
              {requestBullets.map((b) => (
                <StaggerItem key={b} className="flex items-start gap-3 text-[15px] font-medium text-brand-ink">
                  <span className="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                    <Check className="h-3 w-3" strokeWidth={3} aria-hidden />
                  </span>
                  {b}
                </StaggerItem>
              ))}
            </Stagger>
            <Reveal delay={0.3} className="mt-7 rounded-2xl border border-brand-mist bg-white p-5 shadow-soft">
              <p className="text-[15px] leading-relaxed text-brand-graphite">
                <strong className="font-bold text-brand-ink">Em grupos com filiais:</strong> as filiais lançam dentro do seu perfil e das suas alçadas; a
                matriz acompanha as pendências por unidade e fecha a folha.
              </p>
              <div className="mt-3 flex flex-wrap items-center gap-x-6 gap-y-2 text-[14px] font-semibold text-brand-purple">
                <Link to={structurePath('rh-por-unidade')} className="group inline-flex items-center gap-1.5">
                  Como o RH em cada unidade fecha na matriz
                  <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                </Link>
                <Link to={modulePath('requisicoes-com-workflow')} className="group inline-flex items-center gap-1.5">
                  Módulo Requisições com Workflow
                  <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                </Link>
              </div>
            </Reveal>
          </div>
          <Reveal delay={0.2} className="min-w-0">
            <div role="img" aria-label="Tela de requisições: pedidos de férias, reembolso e movimentação seguindo o fluxo de aprovação" className="rounded-3xl border border-brand-mist bg-white p-4 shadow-soft sm:p-6">
              <div inert>
                <RequestMockup />
              </div>
            </div>
          </Reveal>
        </div>
      </Section>

      {/* Módulos de autoatendimento */}
      <Section id="modulos" tone="white" aria-labelledby="portais-modulos-title">
        <div className="container">
          <SectionHeader
            id="portais-modulos-title"
            eyebrow="Autoatendimento, módulo a módulo"
            title="O que trabalha por trás [[dos portais]]."
            lead="Seis módulos que dão ao gestor, ao colaborador e ao candidato o que antes dependia de um e-mail para o RH."
          />
          <Stagger className="mt-12 grid gap-3 sm:grid-cols-2 lg:grid-cols-3" stagger={0.06}>
            {modules.map((mod) => {
              const Icon = moduleIcons[mod.icon]
              return (
                <StaggerItem key={mod.slug}>
                  <Link
                    to={modulePath(mod.slug)}
                    className="group flex h-full items-start gap-4 rounded-2xl border border-brand-mist bg-white p-5 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
                  >
                    <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                      <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                    </span>
                    <span className="min-w-0">
                      <span className="flex items-center gap-1.5 text-[15px] font-bold text-brand-ink group-hover:text-brand-purple">
                        {mod.name}
                        <ChevronRight className="h-4 w-4 text-brand-gray transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                      </span>
                      <span className="mt-1 block text-[13.5px] leading-snug text-brand-graphite">{mod.short}</span>
                    </span>
                  </Link>
                </StaggerItem>
              )
            })}
          </Stagger>
        </div>
      </Section>

      <ResponsiveSection tone="off" eyebrow="Os portais em qualquer tela" />

      {/* Para a sua estrutura: os portais seguem perfis por empresa, filial e centro de custo */}
      <StructureStrip
        id="estrutura"
        tone="white"
        title="Os portais seguem a estrutura da sua empresa."
        text="Perfis por empresa, filial e centro de custo: cada equipe vê só o que é dela e o RH consolida. Veja como o sistema se encaixa na sua estrutura."
      />

      <FAQSection
        tone="off"
        items={faqItems}
        eyebrow="Perguntas sobre os portais"
        title="O que gestores e colaboradores [[perguntam]]."
        lead="Respostas curtas sobre o que cada perfil consegue fazer sozinho."
        more={{ to: paths.faq, label: 'Ver todas as perguntas frequentes' }}
      />

      <CTASection
        title="Veja os portais com a cara da sua empresa."
        text="Mostramos o Portal do Gestor, o do Colaborador e o do Candidato com exemplos do seu segmento, no celular e no computador."
      />
    </PageTransition>
  )
}
