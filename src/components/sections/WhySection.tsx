import { ArrowRight } from 'lucide-react'
import { Link } from 'react-router'
import { m } from 'motion/react'
import { Section, Eyebrow } from './Section'
import { Reveal } from '@/components/motion/Reveal'
import { Logo } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { HumanModule } from '@/components/brand/HumanModule'
import { people } from '@/content/people'
import { comparison } from '@/content/recognition'
import { paths } from '@/content/site'
import { DUR, EASE, viewportOnce } from '@/lib/motion'
import { cn } from '@/lib/utils'

/* Os quatro pilares da marca (Manual de Identidade, seção 01). */
const pillars = [
  { big: '1', title: 'Abrangência', text: 'Um único sistema para tudo o que o RH faz, com um único cadastro e uma única base.' },
  { big: '35+', title: 'Solidez', text: 'Mais de 35 anos de especialização exclusiva em RH, plataforma premiada, parceira Oracle e servidores dedicados na Oracle Cloud, com contingência.' },
  { big: 'NATI', title: 'Inteligência', text: 'A NATI, a Inteligência Artificial do RH, e o People Analytics transformando dado em decisão, dentro do sistema e sem depender de TI.' },
  { big: '1:1', title: 'Proximidade', text: 'Acompanhamento próximo, atenção e agilidade de resposta. Um time que conhece a sua operação pelo nome.' },
]

/* O que a Natcorp não cobra; a frase de apoio vem do comparativo oficial (content/recognition). */
const noCharge = [
  { label: 'por usuário', feature: 'Cobrança por usuário' },
  { label: 'por CNPJ', feature: 'Cobrança por CNPJ' },
  { label: 'por histórico', feature: 'Histórico de dados' },
].map((item) => ({ ...item, detail: comparison.find((row) => row.feature === item.feature)?.natcorp ?? '' }))

interface ManifestoWordProps {
  text: string
  className?: string
  delay?: number
}

/**
 * Palavra do manifesto: sobe de dentro de um recorte ao entrar na tela.
 * A folga do recorte (0,3em) evita cortar descendentes com a entrelinha de 0,95.
 */
function ManifestoWord({ text, className, delay = 0 }: ManifestoWordProps) {
  return (
    <h3 className={cn('leading-[0.95]', className)}>
      <span className="-mb-[0.3em] -mt-[0.1em] inline-block overflow-hidden pb-[0.3em] pr-[0.04em] pt-[0.1em] align-bottom">
        <m.span
          className="inline-block will-change-transform"
          initial={{ y: '115%', opacity: 0 }}
          whileInView={{ y: '0%', opacity: 1 }}
          viewport={viewportOnce}
          transition={{ duration: DUR.scene, ease: EASE, delay }}
        >
          {text}
        </m.span>
      </span>
    </h3>
  )
}

export function WhySection() {
  return (
    <Section id="por-que-natcorp" tone="off" aria-labelledby="porque-title">
      <div className="container">
        <h2 id="porque-title" className="sr-only">
          Por que as grandes empresas escolhem a Natcorp
        </h2>
        <Reveal y={12} duration={0.5}>
          <Eyebrow>Por que Natcorp</Eyebrow>
        </Reveal>

        {/* Manifesto: os quatro pilares como palavras, uma por linha, com ritmo alternado. */}
        <ul role="list" className="mt-12 space-y-12 sm:space-y-14 lg:mt-16 lg:space-y-16">
          {pillars.map((p, i) => {
            const shifted = i % 2 === 1
            return (
              <li
                key={p.title}
                className={cn('flex flex-col gap-5 lg:flex-row lg:flex-wrap lg:items-end lg:gap-x-10 lg:gap-y-5', shifted && 'lg:ml-[18%]')}
              >
                <div>
                  <Reveal y={10} duration={0.5}>
                    <p className="text-[12px] font-semibold uppercase tracking-[0.14em] text-brand-purple">{p.big}</p>
                  </Reveal>
                  <ManifestoWord
                    text={p.title}
                    delay={0.08}
                    className={cn(
                      'mt-3 text-5xl font-extrabold tracking-brand sm:text-7xl lg:text-[6.5rem]',
                      shifted ? 'text-brand-purple' : 'text-brand-ink',
                    )}
                  />
                </div>
                <Reveal delay={0.3} y={12} className="max-w-xs lg:w-80 lg:shrink-0 lg:pb-[0.35rem]">
                  <p className="text-[15px] leading-relaxed text-brand-graphite">{p.text}</p>
                </Reveal>
              </li>
            )
          })}
        </ul>

        {/* O que a Natcorp não cobra: três linhas grandes, cada uma riscada em rosa ao rolar. */}
        <div className="mt-20 lg:mt-28">
          <Reveal y={12} duration={0.5}>
            <Eyebrow tone="purple" trail={false}>
              O que a Natcorp não cobra
            </Eyebrow>
          </Reveal>
          <ul role="list" className="mt-6 space-y-6 sm:mt-8 sm:space-y-7">
            {noCharge.map((item, i) => (
              <li key={item.label} className="flex flex-col gap-2 sm:flex-row sm:items-baseline sm:gap-10">
                <Reveal y={12} delay={i * 0.08} className="shrink-0">
                  <span className="relative inline-block text-3xl font-extrabold leading-none tracking-brand text-brand-ink sm:text-5xl">
                    {item.label}
                    <m.span
                      aria-hidden
                      className="pointer-events-none absolute left-0 top-[0.61em] h-[4px] w-full origin-left -translate-y-1/2 rounded-full bg-brand-pink sm:h-[6px]"
                      initial={{ scaleX: 0 }}
                      whileInView={{ scaleX: 1 }}
                      viewport={viewportOnce}
                      transition={{ duration: 0.6 + i * 0.12, ease: EASE, delay: 0.3 + i * 0.15 }}
                    />
                  </span>
                </Reveal>
                <Reveal y={10} delay={0.35 + i * 0.1} duration={0.5} className="max-w-sm">
                  <p className="text-[15px] leading-relaxed text-brand-graphite">{item.detail}</p>
                </Reveal>
              </li>
            ))}
          </ul>

          <Reveal delay={0.1} className="mt-10 max-w-xl">
            <p className="text-[15px] leading-relaxed text-brand-graphite">
              <strong className="font-bold text-brand-ink">Como cobramos:</strong> contratação modular, como serviço em nuvem, com o valor calculado pelo número de colaboradores.
            </p>
          </Reveal>

          <Reveal delay={0.15} className="mt-5 flex flex-wrap items-center gap-x-8 gap-y-2 text-[15px] font-semibold text-brand-purple">
            <Link to={paths.commercial} className="group inline-flex items-center gap-2">
              Ver o modelo comercial
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
            <Link to={`${paths.commercial}#comparativo`} className="group inline-flex items-center gap-2">
              Ver o comparativo com outros sistemas
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
            <Link to={`${paths.about}#servicos`} className="group inline-flex items-center gap-2">
              Conhecer os serviços que acompanham o sistema
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
            <Link to={`${paths.security}#arquitetura`} className="group inline-flex items-center gap-2">
              Ver a arquitetura da infraestrutura na Oracle Cloud
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
          </Reveal>
        </div>

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
