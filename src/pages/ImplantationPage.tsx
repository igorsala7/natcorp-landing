import { ArrowRight } from 'lucide-react'
import { Link } from 'react-router'
import { Section, SectionHeader, Eyebrow } from '@/components/sections/Section'
import { ServicesSection } from '@/components/sections/ServicesSection'
import { FAQSection } from '@/components/sections/FAQSection'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { JsonLd } from '@/components/seo/JsonLd'
import { LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'
import { implantationFaqs, implantationSteps } from '@/content/implantation'
import { paths, siteConfig } from '@/content/site'

const stats = [
  { value: 'Sem limite', label: 'de anos de histórico na migração' },
  { value: 'Em paralelo', label: 'a folha atual roda junto na homologação' },
  { value: 'Time próprio', label: 'implanta, treina, desenvolve e atende' },
]

/**
 * Implantação, migração e serviços.
 *
 * Este conteúdo era uma seção dentro de /sobre, e 49 links internos apontavam para
 * `/sobre#servicos` — o segundo destino mais linkado do site, à frente da página de
 * folha, e mesmo assim um fragmento dentro de "quem somos".
 *
 * Virou página porque responde à maior objeção do diretor de TI ("como é a virada e
 * quem atende depois?") e porque "implantação de sistema de RH" é busca real, que
 * âncora dentro de página institucional não atende.
 */
export default function ImplantationPage() {
  useSeo({
    title: 'Implantação de sistema de RH: migração e suporte | Natcorp',
    description:
      'Como é a implantação do sistema de RH da Natcorp: levantamento por empresa e filial, migração do histórico completo, homologação com a folha atual em paralelo e suporte próprio.',
    path: paths.implantation,
  })

  return (
    <PageTransition>
      <Section
        tone="off"
        className="overflow-hidden pb-14 pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pb-16"
        aria-labelledby="implantacao-title"
      >
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[34%] h-[150%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Implantação e serviços' }]} />
          <div className="mt-8 grid items-end gap-10 lg:grid-cols-[1.4fr_1fr] lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Implantação e serviços</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="implantacao-title"
                text="A implantação do sistema de RH que [[termina no primeiro fechamento]]."
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  Trocar de sistema de RH assusta por um motivo justo: a folha não pode sair errada. Por isso a
                  implantação da Natcorp migra o histórico inteiro, roda a folha atual em paralelo durante a
                  homologação e só vira quando os números batem — com o primeiro fechamento acompanhado por quem
                  implantou.
                </p>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <Link to="#contato">
                    Falar sobre a implantação
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
                <Button asChild size="lg" variant="secondary">
                  <Link to={paths.commercial}>Ver o modelo comercial</Link>
                </Button>
              </Reveal>
            </div>
            <Reveal delay={0.3} className="grid gap-3">
              {stats.map((s) => (
                <div key={s.label} className="rounded-2xl border border-brand-mist bg-white p-5 shadow-soft">
                  <p className="text-2xl font-extrabold tracking-brand text-brand-purple">{s.value}</p>
                  <p className="mt-1 text-sm leading-snug text-brand-graphite">{s.label}</p>
                </div>
              ))}
            </Reveal>
          </div>
        </div>
      </Section>

      <Section id="etapas" tone="white" aria-labelledby="etapas-title">
        {/* As etapas são um processo real, em ordem e com nome — por isso viram HowTo.
            O bloco fica junto da seção que desenha os passos, e não no topo da página:
            schema descreve o que está visível. */}
        <JsonLd
          data={{
            '@context': 'https://schema.org',
            '@type': 'HowTo',
            name: 'Como é a implantação do sistema de RH da Natcorp',
            description:
              'As etapas de uma implantação, do levantamento por empresa e filial ao primeiro fechamento de folha acompanhado.',
            inLanguage: 'pt-BR',
            publisher: { '@id': `${siteConfig.url}/#org` },
            step: implantationSteps.map((s, i) => ({
              '@type': 'HowToStep',
              position: i + 1,
              name: s.title,
              text: s.text,
              url: `${siteConfig.url}${paths.implantation}#etapas`,
            })),
          }}
        />
        <div className="container">
          <SectionHeader
            id="etapas-title"
            eyebrow="Como funciona"
            title="Da primeira reunião ao [[primeiro fechamento]]."
            lead="Sete etapas, na ordem em que acontecem. O projeto não termina na virada: termina quando a primeira folha fecha certa."
          />
          <Stagger className="mt-10 grid gap-3 sm:grid-cols-2 lg:grid-cols-3" stagger={0.06}>
            {implantationSteps.map((s, i) => (
              <StaggerItem
                key={s.title}
                className="flex h-full flex-col rounded-2xl border border-brand-mist bg-brand-off-white/40 p-5"
              >
                <span className="font-mono text-[12px] font-bold text-brand-purple">
                  {String(i + 1).padStart(2, '0')}
                </span>
                <span className="mt-2 block text-[15.5px] font-bold leading-snug text-brand-ink">{s.title}</span>
                <span className="mt-1.5 block text-[14px] leading-relaxed text-brand-graphite">{s.text}</span>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      <ServicesSection id="servicos" tone="off" />

      <FAQSection
        id="faq-implantacao"
        tone="white"
        items={implantationFaqs}
        eyebrow="Perguntas frequentes"
        title="Dúvidas sobre [[implantação e migração]]."
        lead="O que grupos com várias empresas e filiais perguntam antes de decidir a virada."
        more={{ to: paths.faq, label: 'Ver todas as perguntas frequentes' }}
      />

      <Section tone="off" flush className="py-12 sm:py-14" aria-label="Próximos passos">
        <div className="container">
          <p className="text-[11px] font-bold uppercase tracking-[0.14em] text-brand-gray">Próximos passos</p>
          <ul className="mt-4 flex flex-wrap gap-x-8 gap-y-2 text-[15px]">
            <li>
              <Link to={paths.commercial} className="font-semibold text-brand-purple underline-offset-2 hover:underline">
                Como a Natcorp é contratada
              </Link>
            </li>
            <li>
              <Link to={paths.security} className="font-semibold text-brand-purple underline-offset-2 hover:underline">
                Segurança e infraestrutura
              </Link>
            </li>
            <li>
              <Link to={paths.contact} className="font-semibold text-brand-purple underline-offset-2 hover:underline">
                Falar com a Natcorp
              </Link>
            </li>
          </ul>
        </div>
      </Section>

      <CTASection
        title="Veja como seria a implantação na sua empresa."
        text="Conte quantas empresas, filiais e convenções entram na conta. A partir daí, o cronograma deixa de ser genérico."
      />
    </PageTransition>
  )
}
