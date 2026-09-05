import { Section, SectionHeader } from './Section'
import { Stagger, StaggerItem } from '@/components/motion/Reveal'
import { SpotlightCard } from '@/components/motion/SpotlightCard'
import { personas } from '@/content/personas'
import { HumanModule } from '@/components/brand/HumanModule'

export function PersonasSection() {
  return (
    <Section id="para-quem" tone="off" aria-labelledby="paraquem-title">
      <div className="container">
        <SectionHeader
          id="paraquem-title"
          eyebrow="Para quem"
          title="Para quem decide e para [[quem opera]]."
          lead="Da diretoria ao RH da filial e à contabilidade, cada pessoa ganha algo concreto quando o RH inteiro roda em um único sistema."
        />

        <Stagger className="mt-12 grid gap-5 md:grid-cols-2 lg:mt-16 xl:grid-cols-3" stagger={0.1}>
          {personas.map(({ id, icon: Icon, role, headline, points, portrait }) => (
            <StaggerItem key={id}>
              <SpotlightCard className="h-full rounded-3xl border border-brand-mist bg-white p-7 shadow-soft transition-[border-color] duration-500 hover:border-brand-purple/30" color="rgba(154,64,138,0.10)">
                <div className="flex items-center gap-4">
                  <HumanModule
                    shape="module"
                    tone="light"
                    src={portrait.src}
                    alt={portrait.alt}
                    frame={portrait.frame}
                    tint={0.3}
                    animated={false}
                    className="w-[5.25rem] shrink-0"
                  >
                    <span className="absolute -bottom-1 -right-1 inline-flex h-7 w-7 items-center justify-center rounded-lg bg-brand-gradient text-white shadow-soft" aria-hidden>
                      <Icon className="h-3.5 w-3.5" strokeWidth={1.8} />
                    </span>
                  </HumanModule>
                  <p className="text-[12px] font-semibold uppercase tracking-[0.14em] text-brand-purple">{role}</p>
                </div>
                <h3 className="mt-5 text-2xl font-extrabold leading-tight text-brand-ink">{headline}</h3>
                <ul className="mt-5 space-y-2.5">
                  {points.map((p) => (
                    <li key={p} className="flex items-start gap-2.5 text-[15px] leading-relaxed text-brand-graphite">
                      <span className="mt-[9px] h-1.5 w-1.5 shrink-0 rotate-45 rounded-[1px] bg-brand-pink" aria-hidden />
                      {p}
                    </li>
                  ))}
                </ul>
              </SpotlightCard>
            </StaggerItem>
          ))}
        </Stagger>
      </div>
    </Section>
  )
}
