import { Link } from 'react-router'
import { ArrowRight, Check, Cloud, Database, Headset, Infinity as InfinityIcon, RefreshCw, Sparkles, Users } from 'lucide-react'
import { Section, Eyebrow, SectionHeader } from '@/components/sections/Section'
import { ComparisonSection } from '@/components/sections/ComparisonSection'
import { FAQSection } from '@/components/sections/FAQSection'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'
import type { FaqItem } from '@/content/faq'
import { paths } from '@/content/site'

const included = [
  { icon: Users, title: 'Usuários ilimitados', text: 'Todos os colaboradores, gestores e candidatos usam os portais. Em produção e em homologação, sem cobrança por usuário.' },
  { icon: InfinityIcon, title: 'CNPJs e sindicatos ilimitados', text: 'Todas as empresas do grupo na mesma base, cada uma com as suas convenções, sem cobrança adicional por CNPJ.' },
  { icon: Database, title: 'Histórico ilimitado', text: 'Migração sem limite de anos e histórico completo dentro do sistema, sem cobrança por volume de dados.' },
  { icon: Cloud, title: 'Nuvem Oracle com três ambientes', text: 'Produção, homologação e contingência, com dois backups por dia e monitoramento 24 horas.' },
  { icon: RefreshCw, title: 'Legislação e versões em dia', text: 'Atualizações do sistema e dos layouts do eSocial chegam para todos os clientes, sem projeto de upgrade.' },
  { icon: Sparkles, title: 'NATI integrada', text: 'A inteligência artificial trabalha dentro do sistema e no WhatsApp, para colaboradores, gestores e RH.' },
  { icon: Headset, title: 'Suporte por chamados', text: 'Central com prazos definidos, histórico e controle de qualidade do atendimento.' },
]

const steps = [
  { title: 'Demonstração com os seus dados', text: 'Você mostra a operação: empresas, unidades, convenções, volumes. A gente mostra o sistema resolvendo cada ponto.' },
  { title: 'Proposta por porte e módulos', text: 'A proposta considera o número de colaboradores e os módulos que a sua operação precisa. Dá para começar pelo mais urgente e ampliar depois, sem reimplantar.' },
  { title: 'Implantação com cronograma', text: 'Planejamento por empresa e filial, migração do histórico, homologação com a folha atual em paralelo e treinamento das equipes antes de entrar em produção.' },
]

const faq: FaqItem[] = [
  {
    q: 'Como a Natcorp cobra?',
    a: 'A proposta considera o porte e os módulos que a sua operação precisa. Não há cobrança por usuário, por CNPJ nem por histórico: todos os colaboradores acessam os portais, todas as empresas do grupo entram na mesma base e a migração traz o histórico completo.',
  },
  {
    q: 'Posso começar por alguns módulos?',
    a: 'Sim. Os módulos são nativos e integrados na mesma base, então dá para começar pelo que resolve a dor mais urgente e ampliar depois, sem reimplantar nem migrar de novo.',
  },
  {
    q: 'A implantação e o treinamento estão incluídos?',
    a: 'Implantação, migração e treinamento fazem parte do projeto e entram na proposta com cronograma e marcos, do planejamento ao primeiro fechamento de folha. Consultores alocados, BPO e fábrica de software são serviços à parte, quando fizer sentido para a sua empresa.',
  },
  {
    q: 'O que acontece quando a legislação muda?',
    a: 'As atualizações legais e de layouts do eSocial fazem parte do sistema e chegam para todos os clientes. Nada para instalar, nenhum projeto de upgrade.',
  },
]

export default function CommercialPage() {
  useSeo({
    title: 'Modelo comercial: sem cobrança por usuário, CNPJ ou histórico | Natcorp',
    description:
      'Como a Natcorp é contratada: SaaS na nuvem Oracle, usuários, CNPJs e histórico ilimitados, NATI incluída, comparativo com outros sistemas e como funciona a proposta e a implantação.',
    path: paths.commercial,
  })

  return (
    <PageTransition>
      <Section tone="off" className="overflow-hidden pb-12 pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pb-16 lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="comercial-title">
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Modelo comercial' }]} />
          <div className="mt-8 grid grid-cols-1 items-start gap-12 lg:grid-cols-[1.3fr_1fr] lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Modelo comercial</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="comercial-title"
                text="Contratado como serviço. [[Sem cobrar]] por usuário, por CNPJ nem por histórico."
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-[3.4rem]"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  Um sistema completo, em nuvem, contratado como serviço. A proposta considera o porte e os módulos da sua operação. O que costuma ser limite
                  ou custo extra em outros sistemas, aqui vem incluído.
                </p>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <Link to="#contato">
                    Pedir uma proposta
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
                <Button asChild size="lg" variant="outline">
                  <Link to="#comparativo">Ver o comparativo</Link>
                </Button>
              </Reveal>
            </div>
            <Reveal delay={0.3} className="rounded-3xl border border-brand-mist bg-white p-6 shadow-soft">
              <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">O que não entra na conta</p>
              <ul className="mt-3 space-y-3">
                {['Cobrança por usuário ou por acesso aos portais', 'Cobrança por CNPJ ou por sindicato', 'Cobrança por histórico de dados ou por anos migrados', 'Projeto de upgrade a cada mudança na legislação'].map((t) => (
                  <li key={t} className="flex items-start gap-3 text-[15px] text-brand-ink">
                    <span className="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                      <Check className="h-3 w-3" strokeWidth={3} aria-hidden />
                    </span>
                    {t}
                  </li>
                ))}
              </ul>
            </Reveal>
          </div>
        </div>
      </Section>

      <Section id="incluido" tone="white" aria-labelledby="incluido-title">
        <div className="container">
          <SectionHeader id="incluido-title" eyebrow="O que está incluído" title="Sete coisas que [[já vêm no sistema]]." lead="Sem módulo extra e sem letra pequena." />
          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-4" stagger={0.06}>
            {included.map((c) => (
              <StaggerItem key={c.title} className="flex h-full flex-col rounded-2xl border border-brand-mist bg-brand-off-white p-5">
                <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-white text-brand-purple shadow-soft">
                  <c.icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                </span>
                <h3 className="mt-4 text-[16px] font-extrabold leading-snug text-brand-ink">{c.title}</h3>
                <p className="mt-2 text-[14px] leading-relaxed text-brand-graphite">{c.text}</p>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      <ComparisonSection id="comparativo" tone="off" />

      <Section id="contratacao" tone="white" aria-labelledby="contratacao-title">
        <div className="container">
          <SectionHeader id="contratacao-title" eyebrow="Como funciona a contratação" title="Da demonstração ao [[primeiro fechamento]]." lead="Três passos, com o time da Natcorp ao lado em todos." />
          <Stagger className="mt-12 grid gap-4 lg:grid-cols-3" stagger={0.1}>
            {steps.map((s, i) => (
              <StaggerItem key={s.title} className="rounded-2xl border border-brand-mist bg-white p-6 shadow-soft">
                <span className="flex h-9 w-9 items-center justify-center rounded-full bg-brand-purple text-[12px] font-extrabold text-white">{i + 1}</span>
                <h3 className="mt-4 text-lg font-extrabold leading-snug text-brand-ink">{s.title}</h3>
                <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{s.text}</p>
              </StaggerItem>
            ))}
          </Stagger>
          <Reveal delay={0.2} className="mt-8">
            <Link to={`${paths.about}#servicos`} className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
              Ver implantação, suporte e serviços
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
          </Reveal>
        </div>
      </Section>

      <FAQSection id="comercial-faq" tone="off" items={faq} eyebrow="Perguntas sobre o modelo" title="Como cobra, [[como começa]], o que está incluído." lead="Sem surpresa na proposta." more={{ to: paths.faq, label: 'Ver todas as perguntas frequentes' }} />

      <CTASection />
    </PageTransition>
  )
}
