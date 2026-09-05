import { ArrowRight, Mail, MessageCircle, Phone } from 'lucide-react'
import { Link } from 'react-router'
import { Section, Eyebrow, SectionHeader } from '@/components/sections/Section'
import { CTASection } from '@/components/sections/CTASection'
import { FAQSection } from '@/components/sections/FAQSection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { useSeo } from '@/hooks/useSeo'
import { paths, siteConfig } from '@/content/site'
import type { FaqItem } from '@/content/faq'

const channels = [
  { icon: Phone, label: 'Telefone', value: siteConfig.phone, href: siteConfig.phoneHref, external: false, hint: 'Ligue e fale direto com o nosso time.' },
  { icon: MessageCircle, label: 'WhatsApp', value: siteConfig.whatsapp, href: siteConfig.whatsappHref, external: true, hint: 'Mande uma mensagem e siga a conversa por lá.' },
  { icon: Mail, label: 'E-mail', value: siteConfig.email, href: `mailto:${siteConfig.email}`, external: false, hint: 'Escreva para a gente. Respondemos em até 1 dia útil.' },
]

const steps: { title: string; text: string; links?: { label: string; to: string }[] }[] = [
  { title: 'Conversa inicial', text: 'Entendemos a sua operação: empresas, unidades, sistemas atuais e o que mais pesa no dia a dia do RH.' },
  { title: 'Demonstração com a sua realidade', text: 'Mostramos o sistema com exemplos do seu segmento, com as regras e as rotinas que a sua equipe conhece.' },
  {
    title: 'Proposta e implantação',
    text: 'A proposta considera o porte e os módulos da sua operação. Depois, cronograma, marcos e o time que acompanha do início ao primeiro fechamento de folha.',
    links: [
      { label: 'Como cobramos', to: paths.commercial },
      { label: 'Como é a implantação', to: `${paths.about}#servicos` },
    ],
  },
]

const contactFaqs: FaqItem[] = [
  {
    q: 'Em quanto tempo recebo retorno?',
    a: 'Em até 1 dia útil. Vale para o telefone, o WhatsApp, o e-mail e o formulário desta página. O canal não muda o prazo.',
  },
  {
    q: 'A Natcorp atende empresas fora de São Paulo?',
    a: 'Sim. Atendemos todo o território nacional. A implantação e o suporte acontecem de forma remota, com visitas quando necessário.',
  },
  {
    q: 'Como é o suporte depois da implantação?',
    a: 'Pela central de chamados, com prazos definidos, histórico de cada atendimento e controle de qualidade. O time que implantou continua por perto.',
  },
]

export default function ContactPage() {
  useSeo({
    title: 'Contato: fale com a Natcorp | Natcorp',
    description:
      'Telefone, WhatsApp, e-mail ou formulário: fale com a Natcorp e agende uma demonstração do sistema de RH. Resposta em até 1 dia útil, em todo o Brasil.',
    path: paths.contact,
  })

  return (
    <PageTransition>
      <Section tone="off" className="overflow-hidden pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="contato-page-title">
        <LogoOutline className="pointer-events-none absolute -right-[10%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Contato' }]} />
          <div className="mt-8 max-w-3xl">
            <Reveal y={12} duration={0.5}>
              <Eyebrow>Contato</Eyebrow>
            </Reveal>
            <SplitText
              as="h1"
              id="contato-page-title"
              text="Fale com a [[Natcorp]]."
              className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-6xl"
              highlightClassName="text-brand-purple"
            />
            <Reveal delay={0.25}>
              <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                Telefone, WhatsApp, e-mail ou o formulário desta página: escolha o canal. Respondemos em até 1 dia útil e atendemos
                todo o território nacional.
              </p>
            </Reveal>
          </div>

          <Stagger className="mt-12 grid gap-4 sm:grid-cols-3" stagger={0.08} delay={0.3}>
            {channels.map((c) => (
              <StaggerItem key={c.label}>
                <a
                  href={c.href}
                  {...(c.external ? { target: '_blank', rel: 'noreferrer noopener' } : {})}
                  className="group flex h-full flex-col rounded-3xl border border-brand-mist bg-white p-6 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1.5 hover:border-brand-purple/30 hover:shadow-lift"
                >
                  <span className="flex h-12 w-12 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                    <c.icon className="h-6 w-6" strokeWidth={1.6} aria-hidden />
                  </span>
                  <span className="mt-5 text-[12px] font-semibold uppercase tracking-[0.16em] text-brand-graphite">{c.label}</span>
                  <span className="mt-1 text-xl font-bold text-brand-ink transition-colors group-hover:text-brand-purple">{c.value}</span>
                  <span className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{c.hint}</span>
                </a>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      <Section id="como-funciona" tone="white" aria-labelledby="como-funciona-title">
        <div className="container">
          <SectionHeader
            id="como-funciona-title"
            eyebrow="Como funciona"
            title="Do primeiro contato à [[implantação]]."
            lead="Três passos, sem burocracia. Do outro lado, gente que conhece folha, ponto, eSocial e SESMT de grandes empresas."
          />
          <Stagger className="mt-12 grid gap-4 lg:mt-16 lg:grid-cols-3" stagger={0.1} role="list">
            {steps.map((s, i) => (
              <StaggerItem
                key={s.title}
                role="listitem"
                className="group relative overflow-hidden rounded-3xl border border-brand-mist bg-white p-7 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1.5 hover:border-brand-purple/30 hover:shadow-lift"
              >
                <span className="pointer-events-none absolute -right-8 -top-8 h-32 w-32 rounded-full bg-brand-off-white transition-transform duration-700 ease-brand group-hover:scale-[1.6]" aria-hidden />
                <p className="relative text-4xl font-extrabold tracking-brand text-brand-purple">{String(i + 1).padStart(2, '0')}</p>
                <h3 className="relative mt-5 text-xl font-bold text-brand-ink">{s.title}</h3>
                <p className="relative mt-2 text-[15px] leading-relaxed text-brand-graphite">{s.text}</p>
                {s.links && (
                  <ul className="relative mt-4 flex flex-wrap gap-x-5 gap-y-1.5 text-[14px] font-semibold text-brand-purple">
                    {s.links.map((l) => (
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

      <CTASection title="Agende uma demonstração." text="Conte um pouco sobre a sua operação de RH. Respondemos em até 1 dia útil." />

      <FAQSection
        tone="off"
        items={contactFaqs}
        eyebrow="Dúvidas sobre o atendimento"
        title="Antes de falar com a gente, [[vale saber]]."
        lead="Prazos, abrangência e suporte: respostas diretas."
        more={{ to: paths.faq, label: 'Ver todas as perguntas frequentes' }}
      />
    </PageTransition>
  )
}
