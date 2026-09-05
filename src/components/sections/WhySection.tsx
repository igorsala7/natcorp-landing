import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Logo } from '@/components/brand/Logo'

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

        <Reveal delay={0.2} className="relative mt-10 overflow-hidden rounded-3xl bg-brand-gradient px-6 py-12 text-center text-white sm:px-12 sm:py-16">
          <Logo variant="symbol" tone="white" decorative className="absolute -right-10 -top-10 h-48 w-48 opacity-[0.08]" />
          <p className="mx-auto max-w-3xl text-2xl font-extrabold leading-snug sm:text-3xl lg:text-4xl">
            Soluções inteligentes para organizações que levam a gestão de pessoas a sério.
          </p>
          <p className="mt-4 text-sm font-medium text-white/70">Do C-Level ao estagiário, um RH que lidera o negócio.</p>
        </Reveal>
      </div>
    </Section>
  )
}
