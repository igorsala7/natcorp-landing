import { ArrowRight, Award, Cloud, Sparkles, Trophy } from 'lucide-react'
import { Link } from 'react-router'
import { Counter } from '@/components/motion/Counter'
import { Marquee } from '@/components/motion/Marquee'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { allModuleNames } from '@/content/modules'
import { awards } from '@/content/recognition'
import { paths } from '@/content/site'
import { Logo } from '@/components/brand/Logo'

const awardIcons = [Trophy, Award, Sparkles, Cloud]

const stats = [
  { value: 35, prefix: '+', suffix: '', label: 'anos dedicados exclusivamente à tecnologia para gestão de pessoas' },
  { value: 30, prefix: '+', suffix: '', label: 'módulos integrados, do Departamento Pessoal ao SESMT' },
  { value: 2500, prefix: '', suffix: '', label: 'folhas de pagamento calculadas por minuto' },
  { value: 500, prefix: '+', suffix: ' mil', label: 'colaboradores com os dados administrados no sistema' },
]

export function ProofStrip() {
  return (
    <section id="numeros" className="relative z-10 bg-white" aria-label="Natcorp em números">
      <div className="container">
        <Stagger className="grid grid-cols-2 gap-x-6 gap-y-10 border-b border-brand-mist py-12 lg:grid-cols-4 lg:py-14">
          {stats.map((s) => (
            <StaggerItem key={s.label}>
              <p className="text-4xl font-extrabold tracking-brand text-brand-purple sm:text-5xl">
                <Counter value={s.value} prefix={s.prefix} suffix={s.suffix} />
              </p>
              <p className="mt-2 max-w-[16rem] text-sm leading-snug text-brand-graphite">{s.label}</p>
            </StaggerItem>
          ))}
        </Stagger>

        <Reveal delay={0.1} className="flex flex-col gap-4 border-b border-brand-mist py-6 lg:flex-row lg:items-center lg:justify-between">
          <ul className="flex flex-wrap items-center gap-x-6 gap-y-2" aria-label="Reconhecimentos">
            {awards.map((a, i) => {
              const Icon = awardIcons[i % awardIcons.length]
              return (
                <li key={a.title} className="flex items-center gap-2 text-[13px] font-semibold text-brand-ink">
                  <Icon className="h-4 w-4 text-brand-purple" strokeWidth={1.8} aria-hidden />
                  {a.title}
                </li>
              )
            })}
          </ul>
          <Link to={`${paths.about}#reconhecimento`} className="group inline-flex shrink-0 items-center gap-1.5 text-[13px] font-semibold text-brand-purple">
            Ver reconhecimentos e clientes
            <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
          </Link>
        </Reveal>
      </div>

      <div className="py-8">
        <Marquee speed={90} className="text-sm font-semibold text-brand-graphite">
          {allModuleNames.map((name) => (
            <span key={name} className="flex items-center gap-8 whitespace-nowrap">
              {name}
              <Logo variant="symbol" tone="flat" decorative className="h-2.5 w-2.5 opacity-40" />
            </span>
          ))}
        </Marquee>
      </div>
    </section>
  )
}
