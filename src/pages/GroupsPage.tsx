import { Link } from 'react-router'
import { ArrowRight, Building2, CalendarCheck, ClipboardCheck, Layers, Send } from 'lucide-react'
import { Section, Eyebrow, SectionHeader } from '@/components/sections/Section'
import { StructureSection } from '@/components/sections/StructureSection'
import { FAQSection } from '@/components/sections/FAQSection'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'
import { getModuleEntry, modulePath } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import { groupCapabilities, structureFaqs } from '@/content/structure'
import { journeyPath, paths } from '@/content/site'

const facts = [
  { value: 'Ilimitados', label: 'empresas, CNPJs e sindicatos na mesma base, sem custo extra' },
  { value: '2.500', label: 'colaboradores calculados por minuto, por empresa' },
  { value: '3 níveis', label: 'de perfil de acesso: empresa, filial e centro de custo' },
  { value: 'Sem limite', label: 'de anos na migração do histórico' },
]

const closing = [
  { icon: Building2, title: 'As filiais lançam no seu perfil', text: 'Admissões, ponto, movimentações e benefícios entram pela equipe de cada unidade, dentro das suas alçadas.' },
  { icon: ClipboardCheck, title: 'A matriz vê as pendências por unidade', text: 'O que falta fechar em cada filial aparece em uma fila só, antes da data de corte.' },
  { icon: CalendarCheck, title: 'Folha por empresa, conferida pela NATI', text: 'Cada empresa roda a sua folha em minutos. A NATI aponta inconsistências antes de pagar.' },
  { icon: Send, title: 'eSocial e contabilização por CNPJ', text: 'Eventos enviados e acompanhados por empresa. A contabilização de cada CNPJ sai pronta para o ERP.' },
]

export default function GroupsPage() {
  useSeo({
    title: 'Para grupos com várias empresas e filiais | Natcorp',
    description:
      'Várias empresas, CNPJs, sindicatos e filiais em uma única base. Perfis e alçadas por unidade, folha e headcount consolidados para a matriz, RH centralizado ou por filial. Veja o que muda no sistema.',
    path: paths.groups,
  })

  return (
    <PageTransition>
      <Section tone="off" className="overflow-hidden pb-12 pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pb-16 lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="grupos-title">
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Grupos com várias empresas e filiais' }]} />
          <div className="mt-8 grid grid-cols-1 items-start gap-12 lg:grid-cols-[1.3fr_1fr] lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Para grupos com várias empresas e filiais</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="grupos-title"
                text="Uma base para [[o grupo inteiro]]. Cada equipe vê só o que é dela."
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-[3.4rem]"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  Sete empresas, 25 filiais e um RH central de 40 pessoas. Ou três empresas, dez filiais e uma equipe de RH em cada uma, com a folha fechando
                  na matriz. Os dois jeitos de operar cabem no mesmo sistema: o que muda é o perfil de quem entra, a alçada de quem aprova e a visão de quem
                  consolida.
                </p>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <Link to="#contato">
                    Ver com a estrutura do seu grupo
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
                <Button asChild size="lg" variant="outline">
                  <Link to="#fechamento">Como a matriz fecha a folha</Link>
                </Button>
              </Reveal>
            </div>
            <Stagger className="grid grid-cols-2 gap-3" delay={0.3}>
              {facts.map((f) => (
                <StaggerItem key={f.label} className="rounded-2xl border border-brand-mist bg-white p-5 shadow-soft">
                  <p className="text-2xl font-extrabold tracking-brand text-brand-purple sm:text-3xl">{f.value}</p>
                  <p className="mt-2 text-[13px] leading-snug text-brand-graphite">{f.label}</p>
                </StaggerItem>
              ))}
            </Stagger>
          </div>
        </div>
      </Section>

      <StructureSection
        id="estruturas"
        tone="white"
        eyebrow="Três jeitos de operar"
        title="Empresa única, [[holding com RH central]] ou grupo com RH em cada filial."
        lead="Cada cartão diz o que muda no sistema e leva à página que aprofunda."
        more={false}
      />

      <Section id="capacidades" tone="off" aria-labelledby="capacidades-title">
        <div className="container">
          <SectionHeader
            id="capacidades-title"
            eyebrow="O que muda no sistema"
            title="Oito coisas que um grupo precisa e que já vêm [[na mesma base]]."
            lead="Sem módulo extra e sem cobrança por CNPJ. Cada item leva ao módulo que faz o trabalho."
          />
          <Stagger className="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-4" stagger={0.06}>
            {groupCapabilities.map((c) => {
              const entry = getModuleEntry(c.slug)
              const Icon = entry ? moduleIcons[entry.icon] : Layers
              return (
                <StaggerItem key={c.title} className="flex h-full flex-col rounded-2xl border border-brand-mist bg-white p-5 shadow-soft">
                  <span className="flex h-10 w-10 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple">
                    <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                  </span>
                  <h3 className="mt-4 text-[16px] font-extrabold leading-snug text-brand-ink">{c.title}</h3>
                  <p className="mt-2 flex-1 text-[14px] leading-relaxed text-brand-graphite">{c.text}</p>
                  {entry && (
                    <Link to={modulePath(c.slug)} className="group mt-4 inline-flex items-center gap-1.5 text-[13px] font-semibold text-brand-purple">
                      {entry.name}
                      <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                    </Link>
                  )}
                </StaggerItem>
              )
            })}
          </Stagger>
        </div>
      </Section>

      <Section id="fechamento" tone="dark" className="overflow-hidden" aria-labelledby="fechamento-title">
        <LogoOutline className="pointer-events-none absolute -left-[10%] -top-[40%] h-[150%] w-auto text-white/[0.06]" />
        <div className="container relative">
          <SectionHeader
            id="fechamento-title"
            tone="dark"
            eyebrow="Fechamento com filiais"
            title="As filiais operam. [[A matriz fecha]]. Ninguém redigita."
            lead="O mesmo fluxo vale para o RH central que fecha tudo sozinho: o que muda é quem lança em cada etapa."
          />
          <Stagger className="mt-12 grid gap-4 md:grid-cols-2 lg:grid-cols-4" stagger={0.1}>
            {closing.map((s, i) => (
              <StaggerItem key={s.title} className="relative rounded-2xl border border-white/10 bg-white/[0.05] p-5">
                <span className="flex items-center gap-3">
                  <span className="flex h-9 w-9 items-center justify-center rounded-full bg-white/10 text-[12px] font-extrabold">{i + 1}</span>
                  <s.icon className="h-5 w-5 text-[#E4A9C4]" strokeWidth={1.7} aria-hidden />
                </span>
                <h3 className="mt-4 text-[16px] font-extrabold leading-snug">{s.title}</h3>
                <p className="mt-2 text-[14px] leading-relaxed text-white/75">{s.text}</p>
              </StaggerItem>
            ))}
          </Stagger>
          <Reveal delay={0.2} className="mt-10 flex flex-wrap gap-3">
            <Button asChild size="lg" variant="inverse">
              <Link to={journeyPath}>
                Ver a jornada completa, da vaga à promoção
                <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
              </Link>
            </Button>
            <Button asChild size="lg" variant="outline-inverse">
              <Link to={paths.portals}>Portais, perfis e requisições</Link>
            </Button>
          </Reveal>
        </div>
      </Section>

      <FAQSection
        id="grupos-faq"
        tone="white"
        items={structureFaqs}
        eyebrow="Perguntas de quem tem várias empresas"
        title="O que grupos perguntam [[antes de qualquer outra coisa]]."
        lead="Respostas diretas sobre CNPJs, perfis por filial, fechamento na matriz, volume e implantação."
        more={{ to: paths.faq, label: 'Ver todas as perguntas frequentes' }}
      />

      <CTASection />
    </PageTransition>
  )
}
