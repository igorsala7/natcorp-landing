import { Counter } from '@/components/motion/Counter'
import { Marquee } from '@/components/motion/Marquee'
import { Stagger, StaggerItem } from '@/components/motion/Reveal'
import { allModuleNames } from '@/content/modules'
import { Logo } from '@/components/brand/Logo'

const stats = [
  { value: 35, prefix: '+', suffix: '', label: 'anos dedicados exclusivamente à tecnologia para gestão de pessoas' },
  { value: 30, prefix: '+', suffix: '', label: 'módulos integrados, do Departamento Pessoal ao SESMT' },
  { value: 2500, prefix: '', suffix: '', label: 'folhas de pagamento calculadas por minuto' },
  { value: 500, prefix: '+', suffix: ' mil', label: 'colaboradores com os dados administrados no sistema' },
]

export function ProofStrip() {
  return (
    <section id="numeros" className="relative z-10 bg-white pt-8 sm:pt-12" aria-label="Natcorp em números">
      <div className="container">
        <Stagger className="grid grid-cols-2 gap-x-6 gap-y-10 border-b border-brand-mist py-12 lg:grid-cols-4 lg:py-16">
          {stats.map((s) => (
            <StaggerItem key={s.label}>
              <p className="text-4xl font-extrabold tracking-brand text-brand-purple sm:text-5xl">
                <Counter value={s.value} prefix={s.prefix} suffix={s.suffix} />
              </p>
              <p className="mt-2 max-w-[16rem] text-sm leading-snug text-brand-graphite">{s.label}</p>
            </StaggerItem>
          ))}
        </Stagger>
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
