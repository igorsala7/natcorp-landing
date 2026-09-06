import { Link } from 'react-router'
import { ArrowRight } from 'lucide-react'
import { Section, Eyebrow } from '@/components/sections/Section'
import { FAQSection } from '@/components/sections/FAQSection'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { useSeo } from '@/hooks/useSeo'
import { faqs } from '@/content/faq'
import { structureFaqs } from '@/content/structure'
import { journeyPath, paths } from '@/content/site'

const shortcuts = [
  { to: paths.structures, title: 'Como é a sua estrutura?', text: 'Empresa única, grupo, filiais, RH central ou por unidade.' },
  { to: paths.commercial, title: 'Modelo comercial', text: 'Modular, em nuvem, pelo número de colaboradores.' },
  { to: paths.security, title: 'Segurança e infraestrutura', text: 'Nuvem Oracle, ambientes, backups e LGPD.' },
  { to: `${paths.about}#servicos`, title: 'Implantação, suporte e serviços', text: 'Como a Natcorp entra e acompanha a operação.' },
  { to: journeyPath, title: 'Jornada do colaborador', text: 'O ciclo completo, da vaga à promoção, em história ou diagrama.' },
  { to: paths.modules, title: 'Todos os módulos', text: 'Uma página por módulo, com funcionalidades e FAQ.' },
]

export default function FaqPage() {
  useSeo({
    title: 'Perguntas frequentes sobre o sistema de RH da Natcorp | Natcorp',
    description:
      'Respostas diretas sobre abrangência, porte e estrutura, volume, filiais e matriz, eSocial, ponto, NATI, segurança, integrações, implantação e modelo comercial.',
    path: paths.faq,
  })

  return (
    <PageTransition>
      <Section tone="off" className="overflow-hidden pb-10 pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pb-12 lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="faq-page-title">
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Perguntas frequentes' }]} />
          <div className="mt-8 max-w-3xl">
            <Reveal y={12} duration={0.5}>
              <Eyebrow>Perguntas frequentes</Eyebrow>
            </Reveal>
            <SplitText
              as="h1"
              id="faq-page-title"
              text="Tudo o que as empresas perguntam [[antes de escolher]]."
              className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-[3.4rem]"
              highlightClassName="text-brand-purple"
            />
            <Reveal delay={0.25}>
              <p className="mt-6 text-lg leading-relaxed text-brand-graphite sm:text-xl">
                Respostas diretas, sem rodeio. Cada uma leva à página que aprofunda o assunto.
              </p>
            </Reveal>
          </div>
          <Stagger className="mt-10 grid gap-3 sm:grid-cols-2 lg:grid-cols-3" stagger={0.06}>
            {shortcuts.map((s) => (
              <StaggerItem key={s.to}>
                <Link
                  to={s.to}
                  className="group flex h-full flex-col rounded-2xl border border-brand-mist bg-white p-5 shadow-soft transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
                >
                  <span className="text-[15px] font-extrabold text-brand-ink">{s.title}</span>
                  <span className="mt-1 flex-1 text-[13.5px] leading-snug text-brand-graphite">{s.text}</span>
                  <span className="mt-3 inline-flex items-center gap-1.5 text-[13px] font-semibold text-brand-purple">
                    Abrir
                    <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                  </span>
                </Link>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      <FAQSection id="faq-geral" tone="white" items={faqs} eyebrow="Sobre o sistema" title="Abrangência, porte, [[volume e estrutura]]." lead="As perguntas mais comuns de quem está trocando de sistema de RH." />
      <FAQSection
        id="faq-grupos"
        tone="off"
        items={structureFaqs}
        eyebrow="Para grupos"
        title="Várias empresas, [[várias filiais]], uma base."
        lead="O que grupos com RH central ou com RH em cada filial perguntam antes de qualquer outra coisa."
        more={{ to: paths.structures, label: 'Ver como o sistema se encaixa na sua estrutura' }}
      />

      <CTASection />
    </PageTransition>
  )
}
