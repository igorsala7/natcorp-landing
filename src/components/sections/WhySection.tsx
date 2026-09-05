import { ArrowRight } from 'lucide-react'
import { Link } from 'react-router'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Logo } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { HumanModule } from '@/components/brand/HumanModule'
import { people } from '@/content/people'
import { paths } from '@/content/site'

/* Os quatro pilares da marca (Manual de Identidade, seção 01). */
const pillars = [
  { big: '30+', title: 'Abrangência', text: 'Mais de 30 módulos. Tudo o que o RH faz, em um só lugar, com um único cadastro e uma única base.' },
  { big: '35+', title: 'Solidez', text: 'Mais de 35 anos de especialização exclusiva em RH, plataforma premiada, parceira Oracle e nuvem com contingência.' },
  { big: 'NATI', title: 'Inteligência', text: 'A NATI e o People Analytics transformando dado em decisão, dentro do sistema e sem depender de TI.' },
  { big: '1:1', title: 'Proximidade', text: 'Acompanhamento próximo, atenção e agilidade de resposta. Um time que conhece a sua operação pelo nome.' },
]

export function WhySection() {
  return (
    <Section id="por-que-natcorp" tone="white" aria-labelledby="porque-title">
      <div className="container">
        <SectionHeader
          id="porque-title"
          align="center"
          eyebrow="Por que Natcorp"
          title="Por que as grandes empresas [[escolhem a Natcorp]]."
          lead="Não é só a quantidade de funcionalidades. É a combinação de abrangência, solidez, inteligência e um time que responde rápido."
        />

        <Stagger className="mt-14 grid gap-4 sm:grid-cols-2 lg:mt-20 lg:grid-cols-4" stagger={0.1}>
          {pillars.map((p) => (
            <StaggerItem
              key={p.title}
              className="group relative overflow-hidden rounded-3xl border border-brand-mist bg-white p-7 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1.5 hover:border-brand-purple/30 hover:shadow-lift"
            >
              <span className="pointer-events-none absolute -right-8 -top-8 h-32 w-32 rounded-full bg-brand-off-white transition-transform duration-700 ease-brand group-hover:scale-[1.6]" aria-hidden />
              <p className="relative text-4xl font-extrabold tracking-brand text-brand-purple">{p.big}</p>
              <h3 className="relative mt-5 text-xl font-bold text-brand-ink">{p.title}</h3>
              <p className="relative mt-2 text-[15px] leading-relaxed text-brand-graphite">{p.text}</p>
            </StaggerItem>
          ))}
        </Stagger>

        <Reveal delay={0.1} className="mt-8 flex flex-wrap items-center justify-center gap-x-8 gap-y-2 text-[15px] font-semibold text-brand-purple">
          <Link to={`${paths.system}#comparativo`} className="group inline-flex items-center gap-2">
            Ver o comparativo com outros sistemas
            <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
          </Link>
          <Link to={`${paths.about}#servicos`} className="group inline-flex items-center gap-2">
            Conhecer os serviços que acompanham o sistema
            <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
          </Link>
        </Reveal>

        <Reveal delay={0.2} className="on-dark relative mt-16 overflow-hidden rounded-3xl bg-brand-gradient text-white lg:mt-24">
          <Logo variant="symbol" tone="white" decorative className="absolute -left-12 -top-12 h-56 w-56 opacity-[0.07]" />
          <div className="relative grid grid-cols-1 items-center gap-8 px-6 py-12 sm:px-12 sm:py-14 lg:grid-cols-[1fr_auto] lg:gap-14">
            <div className="max-w-2xl">
              <p className="text-2xl font-extrabold leading-snug sm:text-3xl lg:text-4xl">
                Foque no que importa: o negócio e as pessoas. Deixe a parte mecânica e operacional com o sistema.
              </p>
              <p className="mt-4 text-[15px] font-medium text-white/70">Soluções inteligentes para organizações que levam a gestão de pessoas a sério. Do C-Level ao estagiário.</p>
              <Button asChild variant="inverse" size="lg" className="mt-8">
                <Link to="#contato">
                  Agendar demonstração
                  <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                </Link>
              </Button>
            </div>
            <HumanModule
              shape="module"
              src={people.time.src}
              alt={people.time.alt}
              frame={people.time.frame}
              tint={0.4}
              className="mx-auto w-[240px] sm:w-[280px] lg:w-[300px]"
            />
          </div>
        </Reveal>
      </div>
    </Section>
  )
}
