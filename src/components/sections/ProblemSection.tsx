import { m } from 'motion/react'
import { AlertTriangle, BarChart2, Unplug } from 'lucide-react'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { EASE, viewportOnce } from '@/lib/motion'

const pains = [
  {
    icon: Unplug,
    title: 'Sistemas que não conversam',
    text: 'Ponto em um lugar, folha em outro, SESMT em planilha. Cada integração é um ponto de falha e uma digitação a mais.',
  },
  {
    icon: AlertTriangle,
    title: 'Retrabalho e risco',
    text: 'Conferência manual, pendências no eSocial e prazos de exames que ninguém viu. O erro custa multa, passivo e confiança.',
  },
  {
    icon: BarChart2,
    title: 'Decisão sem dado',
    text: 'Turnover, custo de folha e headcount fechados semanas depois. A diretoria pergunta, o RH exporta para o Excel.',
  },
]

/* Resultados observados na operação de clientes (material comercial Natcorp — "Produtividade de RH"). */
const gains = [
  { label: 'Fechamento da folha', natcorp: 20, note: 'até 80% mais rápido' },
  { label: 'Tratamento do ponto', natcorp: 25, note: '75% menos tempo' },
  { label: 'Dúvidas de colaboradores', natcorp: 30, note: '70% menos chamados' },
  { label: 'Gestão de benefícios', natcorp: 35, note: '65% mais eficiente' },
]

export function ProblemSection() {
  return (
    <Section id="desafio" tone="white" className="pt-8 sm:pt-12 lg:pt-16" aria-labelledby="desafio-title">
      <div className="container">
        <SectionHeader
          id="desafio-title"
          eyebrow="O custo do RH operacional"
          title="Quanto do tempo do seu RH ainda vai para o que [[não é estratégico]]?"
          lead="Sistemas que não conversam, planilhas paralelas e retrabalho entre ponto, folha e eSocial. É assim que a área que cuida das pessoas perde o tempo que deveria estar na estratégia."
        />

        <div className="mt-14 grid gap-10 lg:mt-20 lg:grid-cols-[1fr_1.05fr] lg:gap-16">
          <Stagger className="grid gap-4 sm:grid-cols-3 lg:grid-cols-1">
            {pains.map(({ icon: Icon, title, text }) => (
              <StaggerItem
                key={title}
                className="group rounded-2xl border border-brand-mist p-6 transition-[border-color,box-shadow,transform] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
              >
                <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                  <Icon className="h-5 w-5" strokeWidth={1.6} />
                </span>
                <h3 className="mt-4 text-lg font-bold text-brand-ink">{title}</h3>
                <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{text}</p>
              </StaggerItem>
            ))}
          </Stagger>

          <Reveal delay={0.15} className="rounded-3xl bg-brand-blue p-6 text-white sm:p-8 lg:p-10">
            <div className="flex items-baseline justify-between gap-4">
              <h3 className="text-xl font-bold sm:text-2xl">Com a Natcorp</h3>
              <span className="text-xs font-semibold uppercase tracking-[0.14em] text-white/55">Tempo da rotina</span>
            </div>
            <ul className="mt-8 space-y-6">
              {gains.map((g, i) => (
                <li key={g.label}>
                  <div className="flex items-baseline justify-between gap-4 text-sm">
                    <span className="font-semibold">{g.label}</span>
                    <span className="font-extrabold tabular text-[#E4A9C4]">{g.note}</span>
                  </div>
                  <div className="mt-2 space-y-1.5">
                    <Bar width={100} delay={0.1 + i * 0.12} tone="gray" label="Modelo tradicional" />
                    <Bar width={g.natcorp} delay={0.3 + i * 0.12} tone="purple" label="Natcorp" />
                  </div>
                </li>
              ))}
            </ul>
            <p className="mt-8 text-xs leading-relaxed text-white/50">
              Resultados observados na operação de clientes Natcorp. Valores máximos; variam conforme o porte e o processo de cada empresa.
            </p>
          </Reveal>
        </div>
      </div>
    </Section>
  )
}

function Bar({ width, delay, tone, label }: { width: number; delay: number; tone: 'gray' | 'purple'; label: string }) {
  return (
    <div className="flex items-center gap-3">
      <span className="w-[7.5rem] shrink-0 text-[11px] text-white/55">{label}</span>
      <div className="h-2 flex-1 overflow-hidden rounded-full bg-white/10">
        <m.div
          className={tone === 'purple' ? 'h-full rounded-full bg-gradient-to-r from-brand-plum to-[#E4A9C4]' : 'h-full rounded-full bg-white/30'}
          initial={{ width: 0 }}
          whileInView={{ width: `${width}%` }}
          viewport={viewportOnce}
          transition={{ duration: 1.1, ease: EASE, delay }}
        />
      </div>
    </div>
  )
}
