import {
  Activity,
  ArrowRight,
  ClipboardCheck,
  Cloud,
  Database,
  DatabaseBackup,
  EyeOff,
  FilePen,
  Gauge,
  Globe,
  Headset,
  KeyRound,
  Layers,
  Lock,
  RefreshCw,
  ScrollText,
  Server,
  ShieldCheck,
  UserCheck,
  Users,
} from 'lucide-react'
import { Link } from 'react-router'
import { Section, Eyebrow, SectionHeader } from '@/components/sections/Section'
import { SecuritySection } from '@/components/sections/SecuritySection'
import { FAQSection } from '@/components/sections/FAQSection'
import { CTASection } from '@/components/sections/CTASection'
import { InfraDiagram } from '@/components/security/InfraDiagram'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { useSeo } from '@/hooks/useSeo'
import { faqs, type FaqItem } from '@/content/faq'
import { modulePath } from '@/content/modulePages'
import { paths } from '@/content/site'
import { structurePath } from '@/content/structures'

const seals = [
  { icon: Cloud, label: 'Servidores dedicados na Oracle Cloud' },
  { icon: DatabaseBackup, label: '2 backups por dia' },
  { icon: KeyRound, label: 'Autenticação em dois fatores e VPN' },
  { icon: ShieldCheck, label: 'LGPD' },
]

/* As três camadas do desenho, explicadas em uma frase cada. */
const layers = [
  {
    icon: Server,
    title: 'Aplicação',
    text: 'Oracle WebLogic e Oracle REST Data Services recebem cada requisição que passou pelo firewall e executam as aplicações Java do sistema.',
  },
  {
    icon: Database,
    title: 'Dados',
    text: 'Oracle APEX conversa com o Oracle Database. Leitura e gravação passam por um canal protegido, dentro da mesma nuvem.',
  },
  {
    icon: UserCheck,
    title: 'Permissões',
    text: 'Uma camada de controle filtra os dados conforme o perfil de quem acessa. Cada pessoa só enxerga o que a sua função permite, por empresa e filial.',
  },
]

/* Tecnologia Oracle de ponta a ponta: os seis temas da apresentação da Natcorp. */
const oracle = [
  {
    icon: Cloud,
    title: 'Oracle Cloud Infrastructure',
    text: 'Servidores dedicados na Oracle Cloud, com alta performance, disponibilidade e escalabilidade para a sua operação de RH.',
  },
  {
    icon: Layers,
    title: 'Ambientes isolados',
    text: 'Produção, homologação e contingência (disaster recovery), com políticas de espelhamento e recuperação.',
  },
  {
    icon: Gauge,
    title: 'Performance',
    text: 'Mais de 2.500 colaboradores calculados por minuto na folha, com estabilidade nos dias de fechamento.',
  },
  {
    icon: Lock,
    title: 'Segurança',
    text: 'LGPD, criptografia, autenticação em dois fatores, gestão de acessos por perfil e trilha de auditoria detalhada.',
  },
  {
    icon: DatabaseBackup,
    title: 'Backups múltiplos',
    text: 'Dois backups por dia, automatizados, com políticas de retenção e restauração e cópias guardadas em ambiente isolado.',
  },
  {
    icon: Activity,
    title: 'Cibersegurança 24 horas',
    text: 'Monitoramento contínuo por um time especializado em infraestrutura, com auditoria de acessos.',
  },
]

/* Como o sistema chega até você: só como serviço, pelo navegador. */
const saas = [
  {
    icon: Server,
    title: 'Servidores dedicados na Oracle Cloud',
    text: 'Infraestrutura dedicada à sua operação, sem nada para instalar ou manter na empresa. Monitoramento e atualizações ficam com a Natcorp.',
  },
  {
    icon: RefreshCw,
    title: 'Atualizações sem parar a operação',
    text: 'As novas versões entram sem interromper o RH, sempre com homologação antes de chegar à produção.',
  },
  {
    icon: Globe,
    title: 'Acesso de qualquer lugar, com controle',
    text: 'Perfis de acesso, trilha de auditoria e login corporativo (SSO). Cada pessoa vê só o que precisa.',
  },
]

const lgpd: { icon: typeof Users; text: string; link?: { to: string; label: string } }[] = [
  { icon: Users, text: 'Perfis de acesso granulares por empresa e filial.', link: { to: structurePath('rh-por-unidade'), label: 'Como funciona com RH por unidade' } },
  { icon: ScrollText, text: 'Trilha de auditoria de acessos e alterações.' },
  { icon: EyeOff, text: 'Anonimização e retenção conforme a política da empresa.' },
  { icon: ClipboardCheck, text: 'Consentimento e finalidade nos portais do candidato e do colaborador.' },
  { icon: FilePen, text: 'Contratos de tratamento de dados com a Natcorp.' },
]

/* Compromissos de serviço: só o que já está dito no site. Prazos, RPO, RTO e certificações ficam na proposta e no contrato. */
const commitments = [
  { icon: DatabaseBackup, title: 'Dois backups por dia', text: 'Cópias de segurança guardadas em ambiente isolado.' },
  { icon: Layers, title: 'Três ambientes', text: 'Produção, homologação e contingência (disaster recovery).' },
  { icon: Activity, title: 'Monitoramento 24 horas', text: 'Por um time especializado, com auditoria de acessos.' },
  { icon: Lock, title: 'Camadas de proteção', text: 'Criptografia, HTTPS, WAF, autenticação em dois fatores e VPN.' },
  { icon: ScrollText, title: 'Trilha de auditoria', text: 'Registro de acessos e alterações, com perfis por empresa e filial.' },
  { icon: Cloud, title: 'Servidores dedicados na Oracle Cloud', text: 'Oracle Cloud Infrastructure dedicada à sua operação, sem nada para instalar na empresa.' },
  { icon: Headset, title: 'Suporte por chamados', text: 'Central de chamados com prazos definidos, histórico e controle de qualidade.' },
]

const securityFaqs: FaqItem[] = [
  {
    q: 'O sistema é instalado ou em nuvem?',
    a: 'Em nuvem, como serviço (SaaS), em servidores dedicados na Oracle Cloud Infrastructure. Nada é instalado na sua empresa: o acesso é pelo navegador, passando pelo firewall de aplicação e pela autenticação em dois fatores. Cada cliente conta com ambientes de produção, homologação e contingência, e a Natcorp cuida da infraestrutura.',
  },
  ...faqs.filter((f) => f.q.startsWith('Onde ficam os dados') || f.q.startsWith('A Natcorp se conecta')),
]

export default function SecurityPage() {
  useSeo({
    title: 'Segurança e infraestrutura: servidores dedicados na Oracle Cloud | Natcorp',
    description:
      'Sistema de RH em servidores dedicados na Oracle Cloud: firewall de aplicação, dois fatores, camada de permissões, três ambientes, dois backups por dia e LGPD.',
    path: paths.security,
  })

  return (
    <PageTransition>
      <Section
        tone="off"
        className="overflow-hidden pt-[calc(var(--nav-h)+3rem)] pb-10 sm:pt-[calc(var(--nav-h)+4rem)] sm:pb-12 lg:pt-[calc(var(--nav-h)+5rem)] lg:pb-14"
        aria-labelledby="seguranca-page-title"
      >
        <LogoOutline className="pointer-events-none absolute -right-[10%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Segurança e infraestrutura' }]} />
          <div className="mt-8 max-w-3xl">
            <Reveal y={12} duration={0.5}>
              <Eyebrow>Segurança e infraestrutura</Eyebrow>
            </Reveal>
            <SplitText
              as="h1"
              id="seguranca-page-title"
              text="Nuvem segura, com [[plano de contingência]]."
              className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-6xl"
              highlightClassName="text-brand-purple"
            />
            <Reveal delay={0.25}>
              <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                A operação de RH não pode parar. Por isso a Natcorp roda em servidores dedicados na Oracle Cloud Infrastructure, com produção e
                homologação separadas, uma contingência pronta para assumir e cada camada protegida, do navegador ao banco de dados.
              </p>
            </Reveal>
            <Reveal delay={0.35}>
              <ul className="mt-8 flex flex-wrap gap-2.5" aria-label="Selos de segurança">
                {seals.map((s) => (
                  <li
                    key={s.label}
                    className="inline-flex items-center gap-2 rounded-full border border-brand-mist bg-white px-4 py-2 text-[13.5px] font-semibold text-brand-ink shadow-soft"
                  >
                    <s.icon className="h-4 w-4 shrink-0 text-brand-purple" strokeWidth={1.8} aria-hidden />
                    {s.label}
                  </li>
                ))}
              </ul>
            </Reveal>
          </div>
        </div>
      </Section>

      <SecuritySection withHeader={false} tone="off" diagram={false} />

      <Section id="arquitetura" tone="dark" className="overflow-hidden" aria-labelledby="arquitetura-title">
        <LogoOutline className="pointer-events-none absolute -bottom-[45%] -right-[12%] h-[130%] w-auto text-white/[0.08]" />
        <div className="container relative">
          <SectionHeader
            id="arquitetura-title"
            tone="dark"
            eyebrow="Arquitetura"
            title="Do navegador ao banco de dados, [[cada camada protegida]]."
            lead="A Natcorp roda em servidores dedicados na Oracle Cloud Infrastructure. Cada acesso passa pelo firewall de aplicação, autentica com credenciais e dois fatores e só enxerga os dados que o perfil permite."
          />
          <div className="mt-12 lg:mt-16">
            <InfraDiagram variant="full" />
          </div>
          <Stagger className="mt-10 grid gap-4 md:grid-cols-3" stagger={0.1} role="list" aria-label="As três camadas da arquitetura">
            {layers.map((l) => (
              <StaggerItem key={l.title} role="listitem" className="flex gap-4 rounded-2xl border border-white/10 bg-white/[0.04] p-5">
                <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-white/10 text-[#E4A9C4]">
                  <l.icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                </span>
                <div className="min-w-0">
                  <h3 className="text-[16px] font-extrabold text-white">{l.title}</h3>
                  <p className="mt-1.5 text-[14px] leading-relaxed text-white/70">{l.text}</p>
                </div>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      <Section id="saas" tone="white" aria-labelledby="saas-title">
        <div className="container">
          <div className="grid gap-8 lg:grid-cols-[minmax(0,1fr)_auto] lg:items-end">
            <SectionHeader
              id="saas-title"
              eyebrow="Tecnologia Oracle de ponta a ponta"
              title="Infraestrutura de [[nível corporativo]]."
              lead="Performance, segurança e disponibilidade para a gestão de pessoas da sua organização. Você usa o sistema pelo navegador. A infraestrutura, as atualizações e o monitoramento ficam com a Natcorp."
            />
            <Reveal delay={0.3} className="lg:pb-2">
              <p className="inline-flex items-center gap-2 rounded-full border border-brand-mist bg-brand-off-white px-4 py-2 text-[12px] font-semibold uppercase tracking-[0.14em] text-brand-purple">
                <Cloud className="h-4 w-4" strokeWidth={1.8} aria-hidden />
                Parceiro Oracle
              </p>
            </Reveal>
          </div>
          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:mt-16 lg:grid-cols-3" stagger={0.08} role="list">
            {oracle.map((item) => (
              <StaggerItem
                key={item.title}
                role="listitem"
                className="group flex h-full flex-col rounded-3xl border border-brand-mist bg-white p-7 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1.5 hover:border-brand-purple/30 hover:shadow-lift"
              >
                <span className="inline-flex h-12 w-12 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                  <item.icon className="h-6 w-6" strokeWidth={1.6} aria-hidden />
                </span>
                <h3 className="mt-5 text-xl font-bold text-brand-ink">{item.title}</h3>
                <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{item.text}</p>
              </StaggerItem>
            ))}
          </Stagger>

          <div className="mt-14 border-t border-brand-mist pt-10 lg:mt-16">
            <Reveal y={12} duration={0.5}>
              <h3 className="text-[12px] font-semibold uppercase tracking-[0.16em] text-brand-purple">Como o sistema chega até você</h3>
            </Reveal>
            <Stagger className="mt-6 grid gap-4 md:grid-cols-3" stagger={0.1} role="list">
              {saas.map((item) => (
                <StaggerItem key={item.title} role="listitem" className="flex gap-4 rounded-2xl border border-brand-mist bg-brand-off-white p-5">
                  <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-white text-brand-purple shadow-soft">
                    <item.icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                  </span>
                  <div className="min-w-0">
                    <h4 className="text-[16px] font-extrabold leading-snug text-brand-ink">{item.title}</h4>
                    <p className="mt-1.5 text-[14px] leading-relaxed text-brand-graphite">{item.text}</p>
                  </div>
                </StaggerItem>
              ))}
            </Stagger>
          </div>

          <Reveal delay={0.1} className="mt-10 flex flex-wrap items-center gap-x-8 gap-y-2 text-[15px] font-semibold text-brand-purple">
            <Link to={modulePath('infraestrutura-e-seguranca')} className="group inline-flex items-center gap-2">
              Ver o módulo Infraestrutura e Segurança
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
            <Link to={modulePath('conexao-com-outros-sistemas')} className="group inline-flex items-center gap-2">
              Conexão com Outros Sistemas
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
          </Reveal>
        </div>
      </Section>

      <Section id="lgpd" tone="off" aria-labelledby="lgpd-title">
        <div className="container grid gap-10 lg:grid-cols-[1fr_1.4fr] lg:gap-16">
          <div className="lg:sticky lg:top-32 lg:self-start">
            <SectionHeader
              id="lgpd-title"
              eyebrow="Privacidade"
              title="LGPD [[por desenho]]."
              lead="Os controles que a lei pede já fazem parte do sistema. Nada precisa ser adaptado depois."
            />
          </div>
          <Stagger className="grid gap-3" stagger={0.08} role="list">
            {lgpd.map((item) => (
              <StaggerItem
                key={item.text}
                role="listitem"
                className="group flex items-center gap-4 rounded-2xl border border-brand-mist bg-white p-5 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:shadow-lift"
              >
                <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                  <item.icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                </span>
                <span className="min-w-0 flex-1 text-[15.5px] font-semibold text-brand-ink">
                  {item.text}
                  {item.link && (
                    <>
                      {' '}
                      <Link to={item.link.to} className="font-semibold text-brand-purple underline decoration-brand-purple/40 underline-offset-4 hover:decoration-brand-purple">
                        {item.link.label}
                      </Link>
                      .
                    </>
                  )}
                </span>
              </StaggerItem>
            ))}
          </Stagger>
          <Reveal delay={0.1} className="lg:col-span-2">
            <Link to={modulePath('infraestrutura-e-seguranca')} className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
              Ver todos os controles no módulo Infraestrutura e Segurança
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
          </Reveal>
        </div>
      </Section>

      <Section id="compromissos" tone="white" aria-labelledby="compromissos-title">
        <div className="container">
          <SectionHeader
            id="compromissos-title"
            eyebrow="Compromissos de serviço"
            title="O que já faz parte do serviço, [[do backup ao suporte]]."
            lead="Sete compromissos que acompanham o sistema desde o primeiro dia, sem módulo à parte."
          />
          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:mt-16 lg:grid-cols-4" stagger={0.06} role="list">
            {commitments.map((c) => (
              <StaggerItem key={c.title} role="listitem" className="flex h-full flex-col rounded-2xl border border-brand-mist bg-white p-5 shadow-soft">
                <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple">
                  <c.icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                </span>
                <h3 className="mt-4 text-[16px] font-extrabold leading-snug text-brand-ink">{c.title}</h3>
                <p className="mt-1.5 text-[14px] leading-relaxed text-brand-graphite">{c.text}</p>
              </StaggerItem>
            ))}
            <StaggerItem role="listitem" className="flex h-full flex-col justify-between rounded-2xl bg-brand-blue p-5 text-white">
              <p className="text-[14px] leading-relaxed text-white/80">Prazos de atendimento, RPO, RTO e certificações constam da proposta e do contrato.</p>
              <Link to="#contato" className="group mt-4 inline-flex items-center gap-1.5 text-[14px] font-semibold text-white">
                Pedir a proposta
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
              </Link>
            </StaggerItem>
          </Stagger>
        </div>
      </Section>

      <FAQSection
        tone="off"
        items={securityFaqs}
        eyebrow="Perguntas sobre segurança"
        title="O que o time de TI [[pergunta primeiro]]."
        lead="Nuvem, dados e conexões com o que a sua empresa já usa."
        more={{ to: paths.faq, label: 'Ver todas as perguntas frequentes' }}
      />

      <CTASection
        title="Fale com quem cuida da infraestrutura."
        text="Traga o seu time de TI para a conversa. Mostramos a arquitetura, os ambientes, os controles e as conexões com os sistemas que você já usa."
      />
    </PageTransition>
  )
}
