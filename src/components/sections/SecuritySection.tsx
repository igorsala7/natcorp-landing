import { m } from 'motion/react'
import { ArrowRight, Cable, Cloud, DatabaseBackup, Layers, Lock, ShieldCheck } from 'lucide-react'
import { Link } from 'react-router'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { modulePath } from '@/content/modulePages'
import { paths } from '@/content/site'
import { viewportOnce } from '@/lib/motion'

interface SecurityItem {
  icon: typeof Cloud
  title: string
  text: string
  /** Páginas que aprofundam o assunto. */
  links?: { label: string; to: string }[]
}

const items: SecurityItem[] = [
  { icon: Cloud, title: 'Parceiro Oracle', text: 'Infraestrutura Oracle Cloud com servidores dedicados e alta disponibilidade para a sua operação de RH.' },
  { icon: Layers, title: 'Produção, homologação e contingência', text: 'Ambientes separados para validar mudanças antes de aplicar, e um serviço de recuperação de desastres pronto para assumir.' },
  { icon: DatabaseBackup, title: 'Backups diários', text: 'Dois backups por dia, guardados em ambiente isolado, para que nenhum dado do RH se perca.' },
  {
    icon: Lock,
    title: 'Camadas de proteção',
    text: 'Criptografia, HTTPS, firewall de aplicação, autenticação em dois fatores e VPN, com auditoria de acessos e monitoramento 24 horas por um time especializado.',
  },
  {
    icon: ShieldCheck,
    title: 'LGPD por desenho',
    text: 'Perfis de acesso granulares, anonimização, trilha de auditoria e controle por empresa e filial.',
    links: [
      { label: 'Infraestrutura e Segurança', to: modulePath('infraestrutura-e-seguranca') },
      { label: 'Perfis por empresa e filial', to: paths.groups },
    ],
  },
  {
    icon: Cable,
    title: 'Conecta com o que você já usa',
    text: 'ERP, operadoras de benefícios, relógios de ponto, login corporativo (SSO): APIs prontas, construtor de APIs, arquivos e webhooks.',
    links: [{ label: 'Conexão com Outros Sistemas', to: modulePath('conexao-com-outros-sistemas') }],
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
}

export function SecuritySection({ id = 'seguranca', tone = 'off', withHeader = true }: SecuritySectionProps) {
  return (
    <Section id={id} tone={tone} aria-labelledby={withHeader ? `${id}-title` : undefined} className={withHeader ? undefined : 'pt-0 sm:pt-0 lg:pt-0'}>
      <div className="container">
        {!withHeader && <h2 className="sr-only">Infraestrutura, ambientes e camadas de proteção</h2>}
        {withHeader && (
          <SectionHeader
            id={`${id}-title`}
            eyebrow="Segurança e infraestrutura"
            title="Nuvem segura, com [[plano de contingência]]."
            lead="A operação de RH não pode parar. Por isso a Natcorp roda na infraestrutura Oracle Cloud, com ambientes separados para produção e homologação e um serviço de contingência pronto para assumir."
          />
        )}

        <Reveal delay={0.2} className={withHeader ? 'mt-12 overflow-hidden rounded-3xl bg-brand-blue p-6 text-white sm:p-8 lg:mt-16' : 'overflow-hidden rounded-3xl bg-brand-blue p-6 text-white sm:p-8'}>
          <div className="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
            <div className="lg:max-w-xs">
              <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-white/60">Oracle Cloud Infrastructure</p>
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
