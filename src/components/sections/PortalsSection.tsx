import { ArrowRight, Briefcase, Building2, MonitorSmartphone, ScanFace, UserRound, Users } from 'lucide-react'
import { Link } from 'react-router'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Logo } from '@/components/brand/Logo'
import { modulePath } from '@/content/modulePages'
import { paths } from '@/content/site'

const portals = [
  {
    icon: Users,
    title: 'Portal do Gestor',
    text: 'A equipe inteira em uma tela: aprovações, ponto, férias, avaliações e indicadores do time.',
    items: ['Aprovações de requisições e ponto', 'Visão 360° da equipe', 'Indicadores e People Analytics', 'Feedbacks e avaliações'],
  },
  {
    icon: UserRound,
    title: 'Portal do Colaborador',
    text: 'Autoatendimento de verdade: holerite, ponto, férias, benefícios, documentos e chamados, sem passar pelo RH.',
    items: ['Holerite, informe e espelho de ponto', 'Requisições de férias, atestado, reembolso', 'Assinatura eletrônica de documentos', 'Chamado Interno e NATI'],
  },
  {
    icon: Briefcase,
    title: 'Portal do Candidato',
    text: 'Da candidatura à admissão digital, com a marca da sua empresa e uma experiência que já começa bem.',
    items: ['Quadro de Vagas com a sua marca', 'Currículo e banco de talentos', 'Acompanhamento do processo seletivo', 'Admissão digital e assinatura do contrato'],
  },
]

/* O que sustenta os portais: o app de ponto, o acesso em qualquer tela e o controle por empresa e filial. */
const extras = [
  {
    icon: ScanFace,
    title: 'NatPonto',
    text: 'App de marcação de ponto com reconhecimento facial e geolocalização, para iOS e Android. Funciona para equipes em campo, em várias unidades e em escala.',
    links: [{ label: 'Conhecer o NatPonto', to: modulePath('natponto') }],
  },
  {
    icon: MonitorSmartphone,
    title: 'Multiplataforma',
    text: 'Responsivo no celular, no tablet e no computador. A mesma tela, com as mesmas funções, em qualquer aparelho.',
    links: [{ label: 'Veja o sistema em cada tela', to: modulePath('infraestrutura-e-seguranca', '#multiplataforma') }],
  },
  {
    icon: Building2,
    title: 'Multiempresa e multifilial',
    text: 'Controle por empresa, filial e centro de custo, com perfis de acesso e alçadas por unidade. Cada equipe vê só o que é dela; a matriz consolida.',
    links: [
      { label: 'Como um grupo opera', to: paths.groups },
      { label: 'Módulo Portais', to: modulePath('portais') },
    ],
  },
]

interface PortalsSectionProps {
  id?: string
  tone?: 'white' | 'off'
  /** Sem o cabeçalho, para páginas em que o título já está no topo. */
  withHeader?: boolean
}

export function PortalsSection({ id = 'portais', tone = 'white', withHeader = true }: PortalsSectionProps) {
  return (
    <Section id={id} tone={tone} aria-labelledby={withHeader ? `${id}-title` : undefined} className={withHeader ? undefined : 'pt-0 sm:pt-0 lg:pt-0'}>
      <div className="container">
        {withHeader ? (
          <SectionHeader
            id={`${id}-title`}
            align="center"
            eyebrow="Portais e mobilidade"
            title="Cada pessoa com o [[seu portal]]."
            lead="Gestor, colaborador e candidato acessam o que precisam, no celular ou no computador, com a mesma linguagem. O RH define o que cada perfil vê e faz."
          />
        ) : (
          <h2 className="sr-only">Os três portais</h2>
        )}

        <Stagger className={withHeader ? 'mt-14 grid gap-5 md:grid-cols-3 lg:mt-20' : 'grid gap-5 md:grid-cols-3'}>
          {portals.map(({ icon: Icon, title, text, items }) => (
            <StaggerItem
              key={title}
              className="group flex flex-col overflow-hidden rounded-3xl border border-brand-mist bg-white shadow-soft transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1.5 hover:border-brand-purple/30 hover:shadow-lift"
            >
              <div className="flex items-center justify-between bg-brand-blue px-5 py-3 text-white">
                <Logo variant="symbol" tone="white" className="h-4 w-4" decorative />
                <span className="flex gap-1" aria-hidden>
                  <span className="h-1.5 w-6 rounded-full bg-white/25" />
                  <span className="h-1.5 w-3 rounded-full bg-white/15" />
                </span>
              </div>
              <div className="flex flex-1 flex-col p-6">
                <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                  <Icon className="h-5 w-5" strokeWidth={1.6} />
                </span>
                <h3 className="mt-4 text-xl font-bold text-brand-ink">{title}</h3>
                <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{text}</p>
                <ul className="mt-5 space-y-2 border-t border-brand-mist pt-5 text-sm text-brand-ink">
                  {items.map((it) => (
                    <li key={it} className="flex items-start gap-2.5">
                      <span className="mt-[7px] h-1.5 w-1.5 shrink-0 rotate-45 rounded-[1px] bg-brand-pink" aria-hidden />
                      {it}
                    </li>
                  ))}
                </ul>
              </div>
            </StaggerItem>
          ))}
        </Stagger>

        <Reveal delay={0.15} className="mt-6 grid gap-5 md:grid-cols-3">
          {extras.map(({ icon: Icon, title, text, links }) => (
            <div key={title} className={`flex h-full flex-col rounded-2xl p-6 ${tone === 'off' ? 'border border-brand-mist bg-white shadow-soft' : 'bg-brand-off-white'}`}>
              <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-white text-brand-purple shadow-soft">
                <Icon className="h-5 w-5" strokeWidth={1.6} />
              </span>
              <h3 className="mt-4 text-lg font-bold text-brand-ink">{title}</h3>
              <p className="mt-1 flex-1 text-[15px] leading-relaxed text-brand-graphite">{text}</p>
              <ul className="mt-4 flex flex-wrap gap-x-5 gap-y-1.5 text-[14px] font-semibold text-brand-purple" aria-label={`Saiba mais sobre ${title}`}>
                {links.map((l) => (
                  <li key={l.to}>
                    <Link to={l.to} className="group/link inline-flex items-center gap-1.5 underline-offset-4 hover:underline">
                      {l.label}
                      <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover/link:translate-x-0.5" aria-hidden />
                    </Link>
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </Reveal>
      </div>
    </Section>
  )
}
