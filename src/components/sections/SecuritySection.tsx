import { m } from 'motion/react'
import { Cable, Cloud, DatabaseBackup, Layers, Lock, ShieldCheck } from 'lucide-react'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { viewportOnce } from '@/lib/motion'

const items = [
  { icon: Cloud, title: 'Parceiro Oracle', text: 'Infraestrutura Oracle Cloud com servidores dedicados e alta disponibilidade para a sua operação de RH.' },
  { icon: Layers, title: 'Produção, homologação e contingência', text: 'Ambientes separados para validar mudanças antes de aplicar, e um serviço de recuperação de desastres pronto para assumir.' },
  { icon: DatabaseBackup, title: 'Backups diários', text: 'Dois backups por dia, guardados em ambiente isolado, para que nenhum dado do RH se perca.' },
  { icon: Lock, title: 'Camadas de proteção', text: 'Criptografia, HTTPS, firewall de aplicação, autenticação em dois fatores e VPN, com auditoria de acessos e monitoramento 24 horas por um time especializado.' },
  { icon: ShieldCheck, title: 'LGPD por desenho', text: 'Perfis de acesso granulares, anonimização, trilha de auditoria e controle por empresa e filial.' },
  { icon: Cable, title: 'Conecta com o que você já usa', text: 'ERP, operadoras de benefícios, relógios de ponto, login corporativo (SSO): APIs prontas, construtor de APIs, arquivos e webhooks.' },
]

const envs = [
  { name: 'Produção', desc: 'A operação do dia a dia' },
  { name: 'Homologação', desc: 'Valide antes de aplicar' },
  { name: 'Contingência', desc: 'Recuperação de desastres' },
]

export function SecuritySection() {
  return (
    <Section id="seguranca" tone="off" aria-labelledby="seguranca-title">
      <div className="container">
        <SectionHeader
          id="seguranca-title"
          eyebrow="Segurança e infraestrutura"
          title="Nuvem segura, com [[plano de contingência]]."
          lead="A operação de RH não pode parar. Por isso a Natcorp roda na infraestrutura Oracle Cloud, com ambientes separados para produção e homologação e um serviço de contingência pronto para assumir."
        />

        <Reveal delay={0.2} className="mt-12 overflow-hidden rounded-3xl bg-brand-blue p-6 text-white sm:p-8 lg:mt-16">
          <div className="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
            <div className="lg:max-w-xs">
              <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-white/60">Oracle Cloud Infrastructure</p>
              <p className="mt-2 text-xl font-bold">Três ambientes, uma operação que não para.</p>
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
          {items.map(({ icon: Icon, title, text }) => (
            <StaggerItem
              key={title}
              className="group rounded-2xl border border-brand-mist bg-white p-6 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
            >
              <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
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
