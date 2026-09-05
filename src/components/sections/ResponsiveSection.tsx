import { Cloud, MonitorSmartphone, RefreshCw, Users } from 'lucide-react'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { DevicesShowcase } from '@/components/mockups/DevicesShowcase'

const points = [
  { icon: Cloud, title: '100% em nuvem', text: 'Nada para instalar, nada para sincronizar. Abre no navegador, de qualquer lugar, com a mesma segurança.' },
  { icon: MonitorSmartphone, title: 'Responsivo de verdade', text: 'A mesma tela se adapta ao desktop, ao notebook, ao tablet e ao celular. Não é um app separado com menos funções.' },
  { icon: Users, title: 'Cada perfil no seu aparelho', text: 'O RH opera no computador, o gestor aprova no tablet e o colaborador consulta os próprios dados no celular.' },
  { icon: RefreshCw, title: 'Sempre atualizado', text: 'Uma única versão para todos. A nova funcionalidade aparece para a empresa inteira ao mesmo tempo.' },
]

interface ResponsiveSectionProps {
  id?: string
  tone?: 'white' | 'off'
  eyebrow?: string
}

/** O mesmo sistema em qualquer tela: showcase de notebook, tablet e celular. */
export function ResponsiveSection({ id = 'multiplataforma', tone = 'white', eyebrow = 'Multiplataforma · 100% em nuvem' }: ResponsiveSectionProps) {
  return (
    <Section id={id} tone={tone} className="overflow-hidden" aria-labelledby={`${id}-title`}>
      <div className="container">
        <SectionHeader
          id={`${id}-title`}
          align="center"
          eyebrow={eyebrow}
          title="O mesmo sistema no desktop, no notebook, no tablet e [[no celular]]."
          lead="Tudo em nuvem e com a mesma interface em qualquer tamanho de tela. No nosso mercado, isso ainda é raro: é um dos diferenciais que mais pesam na escolha da Natcorp."
        />

        <Reveal delay={0.2} className="mt-14 lg:mt-20">
          <DevicesShowcase />
        </Reveal>

        <Stagger className="mt-14 grid gap-4 sm:grid-cols-2 lg:mt-20 lg:grid-cols-4" stagger={0.08}>
          {points.map(({ icon: Icon, title, text }) => (
            <StaggerItem key={title} className="rounded-2xl border border-brand-mist bg-white p-6 shadow-soft">
              <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple">
                <Icon className="h-5 w-5" strokeWidth={1.6} />
              </span>
              <h3 className="mt-4 text-lg font-bold text-brand-ink">{title}</h3>
              <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{text}</p>
            </StaggerItem>
          ))}
        </Stagger>
      </div>
    </Section>
  )
}
