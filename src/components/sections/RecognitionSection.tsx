import { ArrowRight, Award, Cloud, Sparkles, Trophy } from 'lucide-react'
import { Link } from 'react-router'
import { Eyebrow } from './Section'
import { Marquee } from '@/components/motion/Marquee'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Logo } from '@/components/brand/Logo'
import { awards, clientGroups, clients, facts } from '@/content/recognition'

const awardIcons = [Trophy, Award, Sparkles, Cloud]

/** Reconhecimentos, fatos da empresa, como os clientes se organizam e a lista de quem usa o sistema. */
export function RecognitionSection() {
  const half = Math.ceil(clients.length / 2)
  const rows = [clients.slice(0, half), clients.slice(half)]
  return (
    <section id="reconhecimento" className="relative bg-white py-16 lg:py-24" aria-labelledby="reconhecimento-title">
      <div className="container">
        <div className="grid grid-cols-1 gap-10 lg:grid-cols-[1fr_1.25fr] lg:items-center lg:gap-16">
          <div>
            <Reveal y={12} duration={0.5}>
              <Eyebrow>Quem somos</Eyebrow>
            </Reveal>
            <Reveal delay={0.08}>
              <h2 id="reconhecimento-title" className="mt-4 text-3xl font-extrabold leading-tight text-brand-ink sm:text-4xl">
                Pioneira em inteligência artificial para o RH. <span className="text-brand-purple">Reconhecida aqui e fora.</span>
              </h2>
            </Reveal>
            <Reveal delay={0.16}>
              <ul className="mt-6 space-y-2.5">
                {facts.map((f) => (
                  <li key={f} className="flex items-start gap-3 text-[15.5px] text-brand-graphite">
                    <Logo variant="symbol" tone="flat" decorative className="mt-1.5 h-3 w-3 shrink-0 text-brand-purple" />
                    {f}
                  </li>
                ))}
              </ul>
            </Reveal>
          </div>

          <Stagger className="grid grid-cols-2 gap-3 sm:grid-cols-4 lg:grid-cols-2 xl:grid-cols-4" stagger={0.08}>
            {awards.map((a, i) => {
              const Icon = awardIcons[i % awardIcons.length]
              return (
                <StaggerItem key={a.title} className="group flex flex-col rounded-2xl border border-brand-mist bg-brand-off-white p-5 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:bg-white hover:shadow-lift">
                  <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-white text-brand-purple shadow-soft transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                    <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                  </span>
                  <span className="mt-5 text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">{a.kind}</span>
                  <span className="mt-1 text-[15px] font-extrabold leading-snug text-brand-ink">{a.title}</span>
                  <span className="mt-0.5 text-[12.5px] text-brand-graphite">{a.org}</span>
                </StaggerItem>
              )
            })}
          </Stagger>
        </div>

        {/* Quem opera com a Natcorp: a estrutura de cada tipo de cliente, sem números de porte. */}
        <div id="clientes" className="mt-16 lg:mt-24">
          <Reveal y={12} duration={0.5}>
            <Eyebrow>Quem opera com a Natcorp</Eyebrow>
          </Reveal>
          <Reveal delay={0.08}>
            <h3 className="mt-4 max-w-2xl text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">
              Estruturas diferentes. <span className="text-brand-purple">A mesma base.</span>
            </h3>
          </Reveal>
          <Stagger className="mt-8 grid gap-4 lg:grid-cols-3" stagger={0.1}>
            {clientGroups.map((g) => (
              <StaggerItem
                key={g.id}
                className="flex h-full flex-col rounded-3xl border border-brand-mist bg-white p-6 shadow-soft transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
              >
                <h4 className="text-xl font-extrabold leading-snug text-brand-ink">{g.title}</h4>
                <p className="mt-3 text-[15px] leading-relaxed text-brand-graphite">{g.text}</p>
                <ul className="mb-5 mt-4 flex flex-wrap gap-1.5" aria-label={`Clientes: ${g.title}`}>
                  {g.examples.map((name) => (
                    <li key={name} className="rounded-md border border-brand-mist bg-brand-off-white px-2 py-0.5 text-[12px] font-semibold text-brand-graphite">
                      {name}
                    </li>
                  ))}
                </ul>
                <ul className="mt-auto flex flex-wrap gap-x-5 gap-y-1.5 border-t border-brand-mist pt-4 text-[14px] font-semibold text-brand-purple" aria-label="Saiba mais">
                  {g.links.map((l) => (
                    <li key={l.to}>
                      <Link to={l.to} className="group/link inline-flex items-center gap-1.5 underline-offset-4 hover:underline">
                        {l.label}
                        <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover/link:translate-x-0.5" aria-hidden />
                      </Link>
                    </li>
                  ))}
                </ul>
              </StaggerItem>
            ))}
          </Stagger>
          <Reveal delay={0.1}>
            <p className="mt-4 text-[13px] leading-relaxed text-brand-graphite">Números de porte e prazos de implantação de cada cliente são apresentados na demonstração.</p>
          </Reveal>
        </div>
      </div>

      <div className="mt-12 border-y border-brand-mist py-8 lg:mt-16">
        <p className="container text-[12px] font-semibold uppercase tracking-[0.16em] text-brand-graphite">Empresas e instituições que usam a Natcorp</p>
        <div className="mt-5 space-y-3" aria-label={`Clientes atendidos: ${clients.join(', ')}`}>
          {rows.map((row, i) => (
            <Marquee key={i} speed={i === 0 ? 80 : 95} reverse={i === 1} className="text-[15px] font-bold text-brand-ink/75">
              {row.map((name) => (
                <span key={name} className="flex items-center gap-8 whitespace-nowrap">
                  {name}
                  <Logo variant="symbol" tone="flat" decorative className="h-2.5 w-2.5 opacity-40" />
                </span>
              ))}
            </Marquee>
          ))}
        </div>
      </div>
    </section>
  )
}
