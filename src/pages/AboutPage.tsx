import { Link } from 'react-router'
import { ArrowRight, Eye, HeartHandshake, Target } from 'lucide-react'
import { Section, Eyebrow, SectionHeader } from '@/components/sections/Section'
import { RecognitionSection } from '@/components/sections/RecognitionSection'
import { ServicesSection } from '@/components/sections/ServicesSection'
import { VideosSection } from '@/components/sections/VideosSection'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { Logo, LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'
import { paths } from '@/content/site'

const stats = [
  { value: '35 anos', label: 'de história dedicada ao RH' },
  { value: '+500 mil', label: 'colaboradores com os dados administrados' },
  { value: '31', label: 'módulos integrados' },
  { value: '2.500', label: 'folhas por minuto' },
]

/* Missão, visão e valores, como constam no site anterior da Natcorp. */
const mission = {
  icon: Target,
  title: 'Missão',
  text: 'Manter e buscar a excelência nos processos de gestão de pessoas, com tecnologia, e dedicação em tudo o que fazemos.',
}

const vision = {
  icon: Eye,
  title: 'Visão',
  text: 'Ser a referência em tecnologia para a gestão de pessoas no Brasil.',
}

const values = [
  'Clientes são parceiros.',
  'Excelência como objetivo.',
  'Atualização constante às tendências que atendem os parceiros.',
  'Atenção, ética, respeito e honestidade.',
  'Dedicação em todas as ações.',
  'Investimento contínuo em todas as áreas.',
]

const cardClass =
  'group relative overflow-hidden rounded-3xl border border-brand-mist bg-white p-7 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift'

export default function AboutPage() {
  useSeo({
    title: 'Sobre a Natcorp: 35 anos de tecnologia para o RH | Natcorp',
    description:
      'HR Tech brasileira com 35 anos de história: um sistema de RH completo e integrado, sempre em dia com a legislação, com dados de mais de 500 mil colaboradores.',
    path: paths.about,
  })

  return (
    <PageTransition>
      <Section tone="off" className="overflow-hidden pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="sobre-title">
        <LogoOutline className="pointer-events-none absolute -right-[10%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Sobre a Natcorp' }]} />
          <div className="mt-8 grid grid-cols-1 items-end gap-10 lg:grid-cols-[1.4fr_1fr]">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Sobre a Natcorp</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="sobre-title"
                text="Há 35 anos fazendo o RH das grandes empresas [[funcionar]]."
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-6xl"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  A Natcorp é uma HR Tech brasileira. Entendemos as dificuldades do RH no Brasil e desenvolvemos um sistema completo e
                  integrado, sempre atualizado com a legislação. Hoje, o sistema administra os dados de mais de 500 mil colaboradores.
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
                  <Link to={paths.contact}>Falar com a gente</Link>
                </Button>
              </Reveal>
            </div>
            <Reveal delay={0.3} className="grid grid-cols-2 gap-3">
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

      <Section id="missao" tone="white" aria-labelledby="missao-title">
        <div className="container">
          <SectionHeader
            id="missao-title"
            eyebrow="Missão, visão e valores"
            title="O que nos move, [[todos os dias]]."
            lead="Tecnologia e dedicação em tudo o que fazemos, com o cliente como parceiro. É assim há 35 anos."
          />
          <Stagger className="mt-12 grid gap-4 lg:mt-16 lg:grid-cols-2" stagger={0.1}>
            {[mission, vision].map((item) => (
              <StaggerItem key={item.title} className={cardClass}>
                <span className="pointer-events-none absolute -right-8 -top-8 h-32 w-32 rounded-full bg-brand-off-white transition-transform duration-700 ease-brand group-hover:scale-[1.6]" aria-hidden />
                <span className="relative inline-flex h-12 w-12 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                  <item.icon className="h-6 w-6" strokeWidth={1.6} aria-hidden />
                </span>
                <h3 className="relative mt-5 text-xl font-bold text-brand-ink">{item.title}</h3>
                <p className="relative mt-2 text-[15.5px] leading-relaxed text-brand-graphite">{item.text}</p>
              </StaggerItem>
            ))}
            <StaggerItem className={`${cardClass} lg:col-span-2`}>
              <span className="pointer-events-none absolute -right-8 -top-8 h-32 w-32 rounded-full bg-brand-off-white transition-transform duration-700 ease-brand group-hover:scale-[1.6]" aria-hidden />
              <span className="relative inline-flex h-12 w-12 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                <HeartHandshake className="h-6 w-6" strokeWidth={1.6} aria-hidden />
              </span>
              <h3 className="relative mt-5 text-xl font-bold text-brand-ink">Valores</h3>
              <ul className="relative mt-4 grid gap-x-8 gap-y-2.5 sm:grid-cols-2 lg:grid-cols-3">
                {values.map((v) => (
                  <li key={v} className="flex items-start gap-3 text-[15.5px] text-brand-graphite">
                    <Logo variant="symbol" tone="flat" decorative className="mt-1.5 h-3 w-3 shrink-0" />
                    {v}
                  </li>
                ))}
              </ul>
            </StaggerItem>
          </Stagger>
          <Reveal delay={0.1} className="mt-8 flex flex-wrap items-center gap-x-8 gap-y-2 text-[15px] font-semibold text-brand-purple">
            <Link to={paths.groups} className="group inline-flex items-center gap-2">
              Como atendemos grupos com várias empresas e filiais
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
            <Link to={paths.modules} className="group inline-flex items-center gap-2">
              Conhecer os 31 módulos
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
          </Reveal>
        </div>
      </Section>

      <RecognitionSection />
      <ServicesSection id="servicos" />
      <VideosSection />
      <CTASection
        title="Conheça a Natcorp de perto."
        text="Marque uma conversa com o nosso time. Mostramos o sistema com exemplos da sua operação e respondemos em até 1 dia útil."
      />
    </PageTransition>
  )
}
