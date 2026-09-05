import { ArrowRight, ClipboardCheck, Code2, GraduationCap, Handshake, Headset, Rocket, Users } from 'lucide-react'
import { Link } from 'react-router'
import { Section } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { paths } from '@/content/site'
import { cn } from '@/lib/utils'

/* Serviços que acompanham o sistema (site anterior, página "Serviços", e material de implantação). */
const services = [
  {
    icon: Rocket,
    title: 'Implantação e migração',
    text: 'Planejamento por empresa e filial, migração do histórico sem limite de anos, homologação com a folha atual em paralelo e treinamento das equipes antes de entrar em produção.',
    featured: true,
  },
  { icon: Users, title: 'Alocação de consultores', text: 'Consultores Natcorp dentro da sua operação, no ritmo que o projeto pede.' },
  { icon: Handshake, title: 'BPO de RH', text: 'Assumimos folha, ponto e rotinas de Departamento Pessoal quando fizer sentido para a sua empresa.' },
  { icon: GraduationCap, title: 'Treinamento de usuários', text: 'Capacitação da equipe de RH e dos gestores, por módulo e por perfil de uso.' },
  { icon: Code2, title: 'Fábrica de software', text: 'Desenvolvimentos sob medida feitos pela própria Natcorp, sem depender de terceiros.' },
  { icon: ClipboardCheck, title: 'Gerenciamento de projeto', text: 'Cronograma, marcos e acompanhamento do início ao primeiro fechamento de folha.' },
  { icon: Headset, title: 'Suporte por chamados', text: 'Central de chamados com prazos definidos, histórico e controle de qualidade do atendimento.' },
]

interface ServicesSectionProps {
  id?: string
  tone?: 'white' | 'off'
}

/** Serviços que acompanham o sistema: implantação, consultores, BPO, treinamento, fábrica, projeto e suporte. */
export function ServicesSection({ id = 'servicos', tone = 'off' }: ServicesSectionProps) {
  return (
    <Section id={id} tone={tone} aria-labelledby={`${id}-title`}>
      <div className="container">
        <div>
          <div className="max-w-3xl">
            <Reveal y={12} duration={0.5}>
              <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-brand-purple">Além do sistema</p>
            </Reveal>
            <Reveal delay={0.08}>
              <h2 id={`${id}-title`} className="mt-3 text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">Um time que entrega junto, da implantação ao dia a dia.</h2>
            </Reveal>
            <Reveal delay={0.16}>
              <p className="mt-4 text-[16px] leading-relaxed text-brand-graphite">
                Sistema é metade da história. A outra metade é quem implanta, treina, desenvolve e atende. Tudo isso é feito pela própria Natcorp.
              </p>
            </Reveal>
          </div>
          <Stagger className="mt-10 grid gap-4 sm:grid-cols-2 lg:grid-cols-3" stagger={0.08}>
            {services.map((sv) => (
              <StaggerItem
                key={sv.title}
                className={cn(
                  'group flex gap-4 rounded-2xl border bg-white p-5 transition-[transform,box-shadow,border-color,background-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:bg-white hover:shadow-lift',
                  sv.featured ? 'border-brand-purple/25 shadow-soft sm:col-span-2 lg:col-span-3' : 'border-brand-mist',
                )}
              >
                <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                  <sv.icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                </span>
                <span className={cn('min-w-0', sv.featured && 'lg:flex lg:items-baseline lg:gap-6')}>
                  <span className={cn('block text-[15.5px] font-bold text-brand-ink', sv.featured && 'lg:shrink-0 lg:text-[17px]')}>{sv.title}</span>
                  <span className={cn('mt-1 block text-[14px] leading-relaxed text-brand-graphite', sv.featured && 'lg:mt-0 lg:text-[15px]')}>{sv.text}</span>
                </span>
              </StaggerItem>
            ))}
          </Stagger>

          <Reveal delay={0.1} className="mt-10 flex flex-wrap items-center gap-x-8 gap-y-2 text-[15px] font-semibold text-brand-purple">
            <Link to="#contato" className="group inline-flex items-center gap-2">
              Falar sobre a implantação
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
            <Link to={paths.commercial} className="group inline-flex items-center gap-2">
              Ver o modelo comercial
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
          </Reveal>
        </div>
      </div>
    </Section>
  )
}
