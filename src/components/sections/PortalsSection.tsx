import { Briefcase, Building2, ScanFace, UserRound, Users } from 'lucide-react'
import { Link } from 'react-router'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Logo } from '@/components/brand/Logo'

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

export function PortalsSection() {
  return (
    <Section id="portais" tone="white" aria-labelledby="portais-title">
      <div className="container">
        <SectionHeader
          id="portais-title"
          align="center"
          eyebrow="Portais e mobilidade"
          title="Cada pessoa com o [[seu portal]]."
          lead="Gestor, colaborador e candidato acessam o que precisam, no celular ou no computador, com a mesma linguagem. O RH define o que cada perfil vê e faz."
        />

        <Stagger className="mt-14 grid gap-5 md:grid-cols-3 lg:mt-20">
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

        <Reveal delay={0.15} className="mt-6 grid gap-5 md:grid-cols-2">
          <div className="flex items-start gap-4 rounded-2xl bg-brand-off-white p-6">
            <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-white text-brand-purple shadow-soft">
              <ScanFace className="h-5 w-5" strokeWidth={1.6} />
            </span>
            <div>
              <h3 className="text-lg font-bold text-brand-ink">NatPonto</h3>
              <p className="mt-1 text-[15px] leading-relaxed text-brand-graphite">
                App de marcação de ponto com reconhecimento facial e geolocalização, para iOS e Android. Funciona para equipes em campo, em várias unidades e em escala.
              </p>
            </div>
          </div>
          <div className="flex items-start gap-4 rounded-2xl bg-brand-off-white p-6">
            <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-white text-brand-purple shadow-soft">
              <Building2 className="h-5 w-5" strokeWidth={1.6} />
            </span>
            <div>
              <h3 className="text-lg font-bold text-brand-ink">Multiplataforma e multiempresa</h3>
              <p className="mt-1 text-[15px] leading-relaxed text-brand-graphite">
                Responsivo no celular, no tablet e no computador. Controle por empresa, filial e centro de custo, com perfis de acesso para cada realidade.{' '}
                <Link to="#multiplataforma" className="font-semibold text-brand-purple underline-offset-4 hover:underline">
                  Veja o sistema em cada tela
                </Link>
                .
              </p>
            </div>
          </div>
        </Reveal>
      </div>
    </Section>
  )
}
