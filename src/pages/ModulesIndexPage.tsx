import { Link } from 'react-router'
import { ArrowRight } from 'lucide-react'
import { Section, Eyebrow } from '@/components/sections/Section'
import { ModulesSection } from '@/components/sections/ModulesSection'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'
import { moduleRegistry } from '@/content/modulePages'

const stats = [
  { value: '30+', label: 'módulos integrados' },
  { value: '7', label: 'frentes do RH' },
  { value: '1', label: 'cadastro, uma base, uma experiência' },
]

export default function ModulesIndexPage() {
  useSeo({
    title: 'Módulos do sistema de RH Natcorp | Natcorp',
    description:
      'Conheça os mais de 30 módulos da Natcorp: folha de pagamento, ponto eletrônico, eSocial, admissão digital, SESMT, recrutamento, avaliações, treinamento, people analytics e a NATI.',
    path: '/modulos',
  })

  return (
    <PageTransition>
      <Section tone="off" className="overflow-hidden pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="modulos-index-title">
        <LogoOutline className="pointer-events-none absolute -right-[10%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Módulos' }]} />
          <div className="mt-8 grid items-end gap-10 lg:grid-cols-[1.4fr_1fr]">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Todos os módulos</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="modulos-index-title"
                text="Mais de 30 módulos. [[Um único sistema.]]"
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-6xl"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  Do Departamento Pessoal ao SESMT, do recrutamento ao People Analytics: cada módulo tem a sua página,
                  com o que ele faz, como funciona e o que muda para a sua empresa. Escolha por onde começar.
                </p>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <Link to="#contato">
                    Agendar demonstração
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
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
          <p className="mt-10 text-sm text-brand-graphite">{moduleRegistry.length} páginas de módulo · atualizadas a partir do material oficial Natcorp</p>
        </div>
      </Section>
      <ModulesSection withHeader={false} id="lista" />
      <CTASection />
    </PageTransition>
  )
}
