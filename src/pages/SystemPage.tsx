import { Link } from 'react-router'
import { ArrowRight } from 'lucide-react'
import { Section, Eyebrow } from '@/components/sections/Section'
import { GroupTabs } from '@/components/sections/GroupTabs'
import { AnalyticsSection } from '@/components/sections/AnalyticsSection'
import { NatPontoSection } from '@/components/sections/NatPontoSection'
import { ResponsiveSection } from '@/components/sections/ResponsiveSection'
import { ComparisonSection } from '@/components/sections/ComparisonSection'
import { PersonasSection } from '@/components/sections/PersonasSection'
import { FAQSection } from '@/components/sections/FAQSection'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'
import { CTAInline } from '@/components/sections/CTAInline'

const stats = [
  { value: '35+', label: 'anos de especialização em RH' },
  { value: '7', label: 'frentes do RH' },
  { value: '1', label: 'cadastro, uma base, uma experiência' },
]

export default function SystemPage() {
  useSeo({
    title: 'O sistema de RH Natcorp: sete frentes, um único sistema | Natcorp',
    description:
      'Departamento Pessoal, RH e Medicina e Segurança do Trabalho na mesma base, com a NATI dentro de tudo. Veja as sete frentes do sistema Natcorp, tela a tela.',
    path: '/sistema',
  })

  return (
    <PageTransition>
      <Section tone="off" className="overflow-hidden pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="sistema-title">
        <LogoOutline className="pointer-events-none absolute -right-[10%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Sistema' }]} />
          <div className="mt-8 grid grid-cols-1 items-end gap-10 lg:grid-cols-[1.4fr_1fr]">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>O sistema</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="sistema-title"
                text="Sete frentes do RH. [[Um único sistema.]]"
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-6xl"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  O Departamento Pessoal, o RH e a Medicina e Segurança do Trabalho operando na mesma base, com a NATI dentro de tudo. Não é
                  integração entre produtos: é um sistema só, com módulos que crescem com a sua empresa.
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
                  <Link to="/modulos">Ver todos os módulos</Link>
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

      <GroupTabs id="frentes" />
      <AnalyticsSection />
      <NatPontoSection />
      <CTAInline titulo="Quer ver o sistema com a sua operação?" tom="marca" />
      <ResponsiveSection tone="off" />
      <ComparisonSection id="comparativo" />
      <PersonasSection />
      <FAQSection />
      <CTASection title="Veja o sistema com os dados da sua empresa." />
    </PageTransition>
  )
}
