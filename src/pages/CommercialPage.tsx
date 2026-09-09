import { Link } from 'react-router'
import { ArrowRight, Cable, Check, Cloud, Database, Headset, History, Infinity as InfinityIcon, Layers, Sparkles, Users } from 'lucide-react'
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
import { modulePath } from '@/content/modulePages'
import { paths } from '@/content/site'

/* Os três pilares do modelo: como o sistema é contratado. */
const pillars = [
  {
    icon: Layers,
    kicker: 'Modular',
    title: 'Contrate o que a sua operação precisa.',
    text: 'Módulos nativos, todos na mesma base de dados. A proposta considera os módulos da sua operação, com folha, ponto, eSocial, talentos, SESMT e NATI conversando entre si desde o primeiro dia.',
    link: { to: paths.modules, label: 'Ver todos os módulos' },
  },
  {
    icon: Cloud,
    kicker: 'SaaS em nuvem',
    title: 'Como serviço, em servidores dedicados na Oracle Cloud.',
    text: 'Nada para instalar na sua empresa. Produção, homologação e contingência em servidores dedicados na Oracle Cloud Infrastructure, com monitoramento 24 horas pela Natcorp.',
    link: { to: paths.security, label: 'Ver a infraestrutura' },
  },
  {
    icon: Users,
    kicker: 'Pelo número de colaboradores',
    title: 'Um valor que acompanha o tamanho da sua empresa.',
    text: 'O valor é calculado pelo número de colaboradores. Contratou, abriu uma filial, incorporou uma empresa? A conta segue a mesma lógica, sem cobrança por usuário, por CNPJ ou por histórico.',
    link: { to: '#comparativo', label: 'Ver o comparativo' },
  },
]

/* Os dois compromissos que mais pesam na decisão: histórico completo e ERP integrado. */
const keystones = [
  {
    icon: History,
    title: 'O histórico completo da sua empresa vem junto.',
    text: 'A implantação migra todo o histórico, não só os últimos anos. Cada colaborador chega com a trajetória inteira: admissões, movimentações, férias, afastamentos, cálculos e documentos. As consultas, auditorias e cálculos que dependem do passado funcionam desde o primeiro dia.',
    links: [
      { to: `${paths.about}#servicos`, label: 'Como é a implantação' },
      { to: modulePath('ged'), label: 'GED' },
    ],
  },
  {
    icon: Cable,
    title: 'Integrado ao ERP no fechamento da folha.',
    text: 'A contabilização da folha, com as provisões, sai por empresa e CNPJ, pronta para o ERP. Os dados financeiros e contábeis chegam ao sistema que a sua empresa já usa no fechamento, por APIs, arquivos ou webhooks, sem planilha no meio do caminho.',
    links: [
      { to: modulePath('conexao-com-outros-sistemas'), label: 'Conexão com Outros Sistemas' },
      { to: modulePath('folha-de-pagamento'), label: 'Folha de Pagamento' },
    ],
  },
]

/* O que outros sistemas costumam limitar ou cobrar à parte e aqui já vem no sistema (comparativo oficial). */
const included = [
  { icon: Users, title: 'Usuários ilimitados', text: 'Todos os colaboradores, gestores e candidatos usam os portais. Em produção e em homologação, sem cobrança por usuário.' },
  { icon: InfinityIcon, title: 'CNPJs e sindicatos ilimitados', text: 'Todas as empresas do grupo na mesma base, cada uma com as suas convenções, sem cobrança adicional por CNPJ.' },
  { icon: Database, title: 'Histórico ilimitado', text: 'Migração sem limite de anos e histórico completo dentro do sistema, sem cobrança por volume de dados.' },
  { icon: Cloud, title: 'Nuvem Oracle com três ambientes', text: 'Produção, homologação e contingência em servidores dedicados, com dois backups por dia e monitoramento 24 horas.' },
  { icon: Sparkles, title: 'NATI integrada', text: 'A Inteligência Artificial trabalha dentro do sistema e no WhatsApp, para colaboradores, gestores e RH.' },
  { icon: Headset, title: 'Suporte por chamados', text: 'Central com prazos definidos, histórico e controle de qualidade do atendimento.' },
]

const steps = [
  { title: 'Demonstração com os seus dados', text: 'Você mostra a operação: empresas, unidades, convenções, volumes. A gente mostra o sistema resolvendo cada ponto.' },
  { title: 'Proposta modular, pelo número de colaboradores', text: 'A proposta lista os módulos da sua operação e o valor calculado pelo número de colaboradores. Sem letra pequena.' },
  { title: 'Implantação com o histórico completo', text: 'Planejamento por empresa e filial, migração de todo o histórico, homologação com a folha atual em paralelo e treinamento das equipes antes de entrar em produção.' },
]

const faq: FaqItem[] = [
  {
    q: 'Como a Natcorp cobra?',
    a: 'A contratação é modular, como serviço em nuvem, e o valor é calculado pelo número de colaboradores. Você contrata os módulos que a sua operação precisa. Não há cobrança por usuário, por CNPJ nem por histórico.',
  },
  {
    q: 'A implantação traz todo o histórico ou só alguns anos?',
    a: 'Todo o histórico. A migração não tem limite de anos: a trajetória completa de cada colaborador entra no sistema, e as consultas, auditorias e cálculos que dependem do passado funcionam desde o início.',
  },
  {
    q: 'A folha se integra ao ERP da empresa?',
    a: 'Sim. No fechamento, a contabilização da folha com as provisões sai por empresa e CNPJ, pronta para o ERP, e chega ao sistema da sua empresa por APIs, arquivos ou webhooks, pelo módulo Conexão com Outros Sistemas.',
  },
  {
    q: 'O que vem incluído e costuma ser cobrado à parte em outros sistemas?',
    a: 'Usuários, CNPJs, sindicatos e histórico sem limite, três ambientes na nuvem Oracle com dois backups por dia, a NATI integrada e o suporte por chamados. O comparativo desta página mostra item por item.',
  },
]

export default function CommercialPage() {
  useSeo({
    title: 'Modelo comercial: SaaS modular pelo número de colaboradores | Natcorp',
    description:
      'Como o sistema de RH da Natcorp é contratado: SaaS modular em nuvem, com valor pelo número de colaboradores, implantação com histórico e folha integrada ao ERP.',
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
                text="Modular, em nuvem, [[pelo número de colaboradores]]."
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-[3.4rem]"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  Você contrata os módulos que a sua operação precisa, usa tudo como serviço em servidores dedicados na nuvem Oracle e paga pelo número
                  de colaboradores. Simples de entender, fácil de prever e pronto para crescer com a empresa.
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
              <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">Como funciona a conta</p>
              <ul className="mt-3 space-y-3">
                {[
                  'Modular: você escolhe os módulos que a operação precisa',
                  'Como serviço, em nuvem: servidores dedicados na Oracle Cloud, nada para instalar',
                  'Valor calculado pelo número de colaboradores',
                  'Implantação com o histórico completo da empresa',
                  'Contabilização da folha integrada ao seu ERP',
                ].map((t) => (
                  <li key={t} className="flex items-start gap-3 text-[15px] text-brand-ink">
                    <span className="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                      <Check className="h-3 w-3" strokeWidth={3} aria-hidden />
                    </span>
                    {t}
                  </li>
                ))}
              </ul>
              <p className="mt-5 border-t border-brand-mist pt-4 text-[13px] leading-relaxed text-brand-graphite">
                Sem cobrança por usuário, por CNPJ, por sindicato nem por histórico. O comparativo mostra o que isso muda frente a outros sistemas.
              </p>
            </Reveal>
          </div>
        </div>
      </Section>

      <Section id="pilares" tone="white" aria-labelledby="pilares-title">
        <div className="container">
          <SectionHeader id="pilares-title" eyebrow="Como o sistema é contratado" title="Três decisões simples. [[Nenhuma surpresa]] depois." lead="Modular, como serviço em nuvem e pelo número de colaboradores. É assim que a Natcorp entra na sua empresa." />
          <Stagger className="mt-12 grid gap-4 lg:grid-cols-3" stagger={0.1}>
            {pillars.map((p) => (
              <StaggerItem key={p.kicker} className="group flex h-full flex-col rounded-3xl border border-brand-mist bg-brand-off-white p-7 transition-[transform,box-shadow,border-color] duration-500 ease-brand hover:-translate-y-1 hover:border-brand-purple/30 hover:bg-white hover:shadow-lift">
                <span className="flex h-12 w-12 items-center justify-center rounded-xl bg-white text-brand-purple shadow-soft transition-colors duration-500 group-hover:bg-brand-purple group-hover:text-white">
                  <p.icon className="h-6 w-6" strokeWidth={1.6} aria-hidden />
                </span>
                <p className="mt-6 text-[12px] font-extrabold uppercase tracking-[0.14em] text-brand-purple">{p.kicker}</p>
                <h3 className="mt-2 text-xl font-extrabold leading-snug text-brand-ink">{p.title}</h3>
                <p className="mt-3 flex-1 text-[15px] leading-relaxed text-brand-graphite">{p.text}</p>
                <Link to={p.link.to} className="group/link mt-5 inline-flex items-center gap-1.5 text-[14px] font-semibold text-brand-purple">
                  {p.link.label}
                  <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover/link:translate-x-0.5" aria-hidden />
                </Link>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      <Section id="implantacao" tone="dark" className="overflow-hidden" aria-labelledby="implantacao-title">
        <LogoOutline className="pointer-events-none absolute -left-[10%] -top-[40%] h-[150%] w-auto text-white/[0.06]" />
        <div className="container relative">
          <SectionHeader
            id="implantacao-title"
            tone="dark"
            eyebrow="O que vem junto"
            title="Todo o histórico da empresa. [[O ERP já conectado]]."
            lead="Dois pontos que costumam travar a troca de sistema e que aqui já fazem parte da implantação."
          />
          <Stagger className="mt-12 grid gap-4 lg:grid-cols-2" stagger={0.12}>
            {keystones.map((k) => (
              <StaggerItem key={k.title} className="flex h-full flex-col rounded-3xl border border-white/10 bg-white/[0.05] p-7">
                <span className="flex h-12 w-12 items-center justify-center rounded-xl bg-white/10 text-[#E4A9C4]">
                  <k.icon className="h-6 w-6" strokeWidth={1.6} aria-hidden />
                </span>
                <h3 className="mt-6 text-2xl font-extrabold leading-snug">{k.title}</h3>
                <p className="mt-3 flex-1 text-[15.5px] leading-relaxed text-white/75">{k.text}</p>
                <ul className="mt-6 flex flex-wrap gap-x-6 gap-y-2 text-[14px] font-semibold" aria-label={`Saiba mais: ${k.title}`}>
                  {k.links.map((l) => (
                    <li key={l.to}>
                      <Link to={l.to} className="group/link inline-flex items-center gap-1.5 text-white underline-offset-4 hover:underline">
                        {l.label}
                        <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover/link:translate-x-0.5" aria-hidden />
                      </Link>
                    </li>
                  ))}
                </ul>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      <Section id="incluido" tone="white" aria-labelledby="incluido-title">
        <div className="container">
          <SectionHeader id="incluido-title" eyebrow="Diferenciais frente a outros sistemas" title="O que costuma ser [[limite ou custo extra]], aqui já vem no sistema." lead="Sem módulo à parte e sem letra pequena." />
          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-3" stagger={0.06}>
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

      <FAQSection id="comercial-faq" tone="off" items={faq} eyebrow="Perguntas sobre o modelo" title="Como cobra, o que vem junto, [[o que está incluído]]." lead="Sem surpresa na proposta." more={{ to: paths.faq, label: 'Ver todas as perguntas frequentes' }} />

      <CTASection />
    </PageTransition>
  )
}
