import { m } from 'motion/react'
import { Activity, ArrowRight, Cloud, DatabaseBackup, Gauge, Layers, Lock } from 'lucide-react'
import { Link } from 'react-router'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { InfraDiagram } from '@/components/security/InfraDiagram'
import { modulePath } from '@/content/modulePages'
import { paths } from '@/content/site'
import { structurePath } from '@/content/structures'
import { viewportOnce } from '@/lib/motion'

interface SecurityItem {
  icon: typeof Cloud
  title: string
  text: string
  /** Páginas que aprofundam o assunto. */
  links?: { label: string; to: string }[]
}

/* Os seis temas da infraestrutura, na mesma ordem da apresentação da Natcorp. */
const items: SecurityItem[] = [
  {
    icon: Cloud,
    title: 'Servidores dedicados na Oracle Cloud',
    text: 'Parceira Oracle, a Natcorp roda em servidores dedicados na Oracle Cloud Infrastructure, com alta performance, disponibilidade e escalabilidade.',
  },
  {
    icon: Layers,
    title: 'Produção, homologação e contingência',
    text: 'Ambientes isolados para validar mudanças antes de aplicar, com espelhamento e um serviço de recuperação de desastres pronto para assumir.',
  },
  {
    icon: Gauge,
    title: 'Performance para a folha',
    text: 'Mais de 2.500 colaboradores calculados por minuto, com estabilidade nos dias de fechamento. Mais filiais e mais usuários não deixam o sistema lento.',
  },
  {
    icon: Lock,
    title: 'Segurança em camadas',
    text: 'LGPD, criptografia, HTTPS, firewall de aplicação, autenticação em dois fatores e VPN, com gestão de acessos por perfil e trilha de auditoria detalhada.',
    links: [
      { label: 'Infraestrutura e Segurança', to: modulePath('infraestrutura-e-seguranca') },
      { label: 'Perfis por empresa e filial', to: structurePath('rh-por-unidade') },
    ],
  },
  {
    icon: DatabaseBackup,
    title: 'Backups múltiplos',
    text: 'Dois backups por dia, automatizados e guardados em ambiente isolado, com políticas de retenção e restauração.',
  },
  {
    icon: Activity,
    title: 'Cibersegurança 24 horas',
    text: 'Monitoramento contínuo por um time especializado em infraestrutura, com auditoria de acessos e um canal direto com a engenharia para incidentes.',
  },
]

const envs = [
  { name: 'Produção', desc: 'A operação do dia a dia' },
  { name: 'Homologação', desc: 'Valide antes de aplicar' },
  { name: 'Contingência', desc: 'Recuperação de desastres' },
]

interface SecuritySectionProps {
  id?: string
  tone?: 'white' | 'off'
  /** Sem o cabeçalho, para páginas em que o título já está no topo. */
  withHeader?: boolean
  /** Desenho compacto da arquitetura no cartão escuro. A página /seguranca desliga, porque traz o desenho completo em #arquitetura. */
  diagram?: boolean
}

export function SecuritySection({ id = 'seguranca', tone = 'off', withHeader = true, diagram = true }: SecuritySectionProps) {
  return (
    <Section id={id} tone={tone} aria-labelledby={withHeader ? `${id}-title` : undefined} className={withHeader ? undefined : 'pt-0 sm:pt-0 lg:pt-0'}>
      <div className="container">
        {!withHeader && <h2 className="sr-only">Infraestrutura, ambientes e camadas de proteção</h2>}
        {withHeader && (
          <SectionHeader
            id={`${id}-title`}
            eyebrow="Segurança e infraestrutura"
            title="Servidores dedicados na Oracle Cloud, com [[plano de contingência]]."
            lead="A operação de RH não pode parar. Por isso a Natcorp roda em servidores dedicados na Oracle Cloud Infrastructure, com ambientes separados para produção e homologação, um serviço de contingência pronto para assumir e cada camada protegida, do navegador ao banco de dados."
          />
        )}

        <Reveal delay={0.2} className={withHeader ? 'mt-12 overflow-hidden rounded-3xl bg-brand-blue p-6 text-white sm:p-8 lg:mt-16' : 'overflow-hidden rounded-3xl bg-brand-blue p-6 text-white sm:p-8'}>
          {diagram ? (
            <>
              <div className="grid gap-7 lg:grid-cols-[minmax(0,17rem)_minmax(0,1fr)] lg:items-center lg:gap-10">
                <div>
                  <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-white/60">Arquitetura na Oracle Cloud</p>
                  <p className="mt-2 text-xl font-bold leading-snug">Do navegador ao banco de dados, cada camada protegida.</p>
                  <p className="mt-2 text-[14px] leading-relaxed text-white/70">
                    Servidores dedicados, firewall de aplicação, dois fatores e uma camada de permissões antes de qualquer dado.
                  </p>
                  <Link
                    to={`${paths.security}#arquitetura`}
                    className="group mt-4 inline-flex items-center gap-1.5 text-[13.5px] font-semibold text-white/85 underline-offset-4 hover:text-white hover:underline"
                  >
                    Ver a arquitetura completa
                    <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                  </Link>
                </div>
                <InfraDiagram variant="compact" className="min-w-0" />
              </div>
              <ul className="mt-6 flex flex-wrap gap-x-6 gap-y-2 border-t border-white/10 pt-5" aria-label="Três ambientes">
                {envs.map((e, i) => (
                  <m.li
                    key={e.name}
                    className="flex items-center gap-2 text-[13.5px]"
                    initial={{ opacity: 0, y: 8 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={viewportOnce}
                    transition={{ duration: 0.6, delay: 0.5 + i * 0.1 }}
                  >
                    <span className={i === 2 ? 'h-2 w-2 shrink-0 rounded-full bg-[#E4A9C4]' : 'h-2 w-2 shrink-0 rounded-full bg-emerald-400 animate-pulse-soft'} aria-hidden />
                    <span className="font-bold">{e.name}</span>
                    <span className="text-white/60">{e.desc}</span>
                  </m.li>
                ))}
              </ul>
            </>
          ) : (
            <div className="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
              <div className="lg:max-w-xs">
                <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-white/60">Servidores dedicados na Oracle Cloud</p>
                <p className="mt-2 text-xl font-bold">Três ambientes, uma operação que não para.</p>
                <Link
                  to={modulePath('infraestrutura-e-seguranca')}
                  className="group mt-3 inline-flex items-center gap-1.5 text-[13.5px] font-semibold text-white/85 underline-offset-4 hover:text-white hover:underline"
                >
                  Ver o módulo Infraestrutura e Segurança
                  <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                </Link>
              </div>
              <ul className="grid flex-1 grid-cols-1 gap-3 sm:grid-cols-3">
                {envs.map((e, i) => (
                  <m.li
                    key={e.name}
                    className="relative rounded-xl border border-white/15 bg-white/[0.06] p-4"
                    initial={{ opacity: 0, y: 12 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={viewportOnce}
                    transition={{ duration: 0.6, delay: 0.3 + i * 0.12 }}
                  >
                    <span className="flex items-center gap-2 text-sm font-bold">
                      <span className={i === 2 ? 'h-2 w-2 rounded-full bg-[#E4A9C4]' : 'h-2 w-2 rounded-full bg-emerald-400 animate-pulse-soft'} aria-hidden />
                      {e.name}
                    </span>
                    <p className="mt-1 text-[12.5px] text-white/65">{e.desc}</p>
                  </m.li>
                ))}
              </ul>
            </div>
          )}
        </Reveal>

        <Stagger className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {items.map(({ icon: Icon, title, text, links }) => (
            <StaggerItem
              key={title}
              className="group flex h-full flex-col rounded-2xl border border-brand-mist bg-white p-6 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
            >
              <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                <Icon className="h-5 w-5" strokeWidth={1.6} />
              </span>
              <h3 className="mt-4 text-lg font-bold text-brand-ink">{title}</h3>
              <p className="mt-2 flex-1 text-[15px] leading-relaxed text-brand-graphite">{text}</p>
              {links && (
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
              )}
            </StaggerItem>
          ))}
        </Stagger>
      </div>
    </Section>
  )
}
