import { ClipboardCheck, Cloud, DatabaseBackup, EyeOff, FilePen, Globe, KeyRound, RefreshCw, ScrollText, ServerOff, ShieldCheck, Users } from 'lucide-react'
import { Section, Eyebrow, SectionHeader } from '@/components/sections/Section'
import { SecuritySection } from '@/components/sections/SecuritySection'
import { FAQSection } from '@/components/sections/FAQSection'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { useSeo } from '@/hooks/useSeo'
import { faqs, type FaqItem } from '@/content/faq'
import { paths } from '@/content/site'

const seals = [
  { icon: Cloud, label: 'Oracle Cloud Infrastructure' },
  { icon: DatabaseBackup, label: '2 backups por dia' },
  { icon: KeyRound, label: 'Autenticação em dois fatores e VPN' },
  { icon: ShieldCheck, label: 'LGPD' },
]

const saas = [
  {
    icon: ServerOff,
    title: 'Sem servidor próprio',
    text: 'Nada para instalar ou manter na empresa. Infraestrutura, monitoramento e atualizações ficam com a Natcorp.',
  },
  {
    icon: RefreshCw,
    title: 'Legislação e versões em dia',
    text: 'As atualizações entram sem parar a operação, sempre com homologação antes de aplicar em produção.',
  },
  {
    icon: Globe,
    title: 'Acesso de qualquer lugar, com controle',
    text: 'Perfis de acesso, trilha de auditoria e login corporativo (SSO). Cada pessoa vê só o que precisa.',
  },
]

const lgpd = [
  { icon: Users, text: 'Perfis de acesso granulares por empresa e filial.' },
  { icon: ScrollText, text: 'Trilha de auditoria de acessos e alterações.' },
  { icon: EyeOff, text: 'Anonimização e retenção conforme a política da empresa.' },
  { icon: ClipboardCheck, text: 'Consentimento e finalidade nos portais do candidato e do colaborador.' },
  { icon: FilePen, text: 'Contratos de tratamento de dados com a Natcorp.' },
]

const securityFaqs: FaqItem[] = [
  {
    q: 'O sistema é instalado ou em nuvem?',
    a: 'Apenas em nuvem, como serviço (SaaS), na infraestrutura Oracle Cloud. Cada cliente conta com ambientes de produção, homologação e contingência, e a Natcorp cuida da infraestrutura.',
  },
  ...faqs.filter((f) => f.q.startsWith('Onde ficam os dados') || f.q.startsWith('A Natcorp se conecta')),
]

export default function SecurityPage() {
  useSeo({
    title: 'Segurança e infraestrutura: nuvem Oracle com contingência | Natcorp',
    description:
      'Sistema de RH 100% SaaS na Oracle Cloud: produção, homologação e contingência, dois backups por dia, autenticação em dois fatores, VPN e LGPD por desenho.',
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
                A operação de RH não pode parar. Por isso a Natcorp roda na Oracle Cloud, com produção e homologação separadas, uma
                contingência pronta para assumir e a LGPD por desenho.
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

      <SecuritySection withHeader={false} tone="off" />

      <Section id="saas" tone="white" aria-labelledby="saas-title">
        <div className="container">
          <SectionHeader
            id="saas-title"
            eyebrow="Como o sistema chega até você"
            title="100% SaaS, na [[nuvem Oracle]]."
            lead="A Natcorp é oferecida apenas como serviço. Você usa o sistema. A infraestrutura, as atualizações e o monitoramento ficam com a gente."
          />
          <Stagger className="mt-12 grid gap-4 md:grid-cols-3 lg:mt-16" stagger={0.1}>
            {saas.map((item) => (
              <StaggerItem
                key={item.title}
                className="group rounded-3xl border border-brand-mist bg-white p-7 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1.5 hover:border-brand-purple/30 hover:shadow-lift"
              >
                <span className="inline-flex h-12 w-12 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                  <item.icon className="h-6 w-6" strokeWidth={1.6} aria-hidden />
                </span>
                <h3 className="mt-5 text-xl font-bold text-brand-ink">{item.title}</h3>
                <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{item.text}</p>
              </StaggerItem>
            ))}
          </Stagger>
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
                <span className="text-[15.5px] font-semibold text-brand-ink">{item.text}</span>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      <FAQSection
        tone="white"
        items={securityFaqs}
        eyebrow="Perguntas sobre segurança"
        title="O que o time de TI [[pergunta primeiro]]."
        lead="Nuvem, dados e conexões com o que a sua empresa já usa."
        more={{ to: `${paths.system}#faq`, label: 'Ver todas as perguntas frequentes' }}
      />

      <CTASection
        title="Fale com quem cuida da infraestrutura."
        text="Traga o seu time de TI para a conversa. Mostramos os ambientes, os controles e as conexões com os sistemas que você já usa."
      />
    </PageTransition>
  )
}
