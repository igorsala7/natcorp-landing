import { Award, Cloud, Sparkles, Trophy } from 'lucide-react'
import { Eyebrow } from './Section'
import { Marquee } from '@/components/motion/Marquee'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Logo } from '@/components/brand/Logo'
import { awards, clients, facts } from '@/content/recognition'

const awardIcons = [Trophy, Award, Sparkles, Cloud]

/** Reconhecimentos, fatos da empresa e clientes atendidos. */
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
      </div>

      <div className="mt-14 border-y border-brand-mist py-8 lg:mt-20">
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
