import { Link } from 'react-router'
import { m } from 'motion/react'
import { ArrowRight, Check, ClipboardCheck, MapPin, MapPinOff, Smartphone, Tablet, Users } from 'lucide-react'
import { Section, SectionHeader, Eyebrow } from '@/components/sections/Section'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { NatPontoIcon } from '@/components/brand/NatPontoIcon'
import { Button } from '@/components/ui/button'
import { BenefitsGrid, FeaturesGrid, PersonasGrid, RelatedModules } from '@/components/modules/blocks'
import { StoreBadges } from '@/components/brand/StoreBadges'
import { NATPONTO_SIZE } from '@/components/mockups/natponto/NatPontoFrame'
import { NatPontoPhone, type NatPontoScreen } from '@/components/mockups/natponto/screens'
import { getGroup, getModuleEntry, modulePath, type ModuleEntry } from '@/content/modulePages'
import type { ModulePage as ModulePageData } from '@/content/modulePages/types'
import { structurePath } from '@/content/structures'
import { EASE, viewportOnce } from '@/lib/motion'
import { ImplantationBlock, ModuleFaqAccordion, ModuleNav, SeeAlsoStrip } from './ModulePage'

const journey: { screen: NatPontoScreen; title: string; text: string }[] = [
  { screen: 'home', title: 'Abrir o app', text: 'Relógio, dados da pessoa, escala do dia e o botão Registrar Ponto. Um toque para começar.' },
  { screen: 'face', title: 'Reconhecimento facial', text: 'O colaborador posiciona o rosto na moldura e aguarda a contagem. Sem cartão, sem senha.' },
  { screen: 'success', title: 'Marcação registrada', text: 'Com ou sem internet. Sem sinal, a marcação fica guardada e é sincronizada depois.' },
  { screen: 'receipt', title: 'Comprovante', text: 'Código QR de verificação, hash SHA-256, registro de programa de computador no INPI e a geolocalização dentro do raio.' },
]

const modes = [
  { icon: Smartphone, title: 'No celular de cada pessoa', text: 'Para equipes em campo, externas ou em home office. A marcação registra o local e o horário.' },
  { icon: Tablet, title: 'No tablet da unidade', text: 'Modo multiusuário: um aparelho fixo atende a equipe inteira de uma loja, fábrica ou clínica.' },
  { icon: Users, title: 'Para quem opera o ponto', text: 'A marcação chega em segundos ao Ponto Eletrônico, com a apuração aplicando as regras da jornada.' },
]

/* Como o app se comporta em um grupo com muitas unidades. */
const units = [
  {
    icon: MapPin,
    title: 'Um raio por unidade, uma pessoa em várias',
    text: 'Cada filial tem o seu perímetro de marcação. Quem transita entre unidades marca em qualquer uma delas, e o comprovante registra onde foi.',
    link: { to: structurePath('varias-unidades'), label: 'Perfis e unidades por estrutura' },
  },
  {
    icon: MapPinOff,
    title: 'Fora do raio, a marcação entra sinalizada',
    text: 'O registro não se perde: entra no Ponto Eletrônico com a marca de fora do raio e vai para o gestor justificar pelo portal.',
    link: { to: modulePath('portais'), label: 'Portal do Gestor' },
  },
  {
    icon: ClipboardCheck,
    title: 'Ajuste, abono e hora extra passam pela alçada da filial',
    text: 'Cada unidade aprova o que é dela, no fluxo de requisições. O RH central vê a fila por unidade e fecha o ponto de todas.',
    link: { to: modulePath('requisicoes-com-workflow'), label: 'Requisições com Workflow' },
  },
]

export default function NatPontoModulePage({ entry, page }: { entry: ModuleEntry; page: ModulePageData }) {
  const group = getGroup(entry.group)
  const related = page.related.map(getModuleEntry).filter((r): r is ModuleEntry => Boolean(r))

  return (
    <PageTransition>
      <Section tone="off" className="overflow-hidden pb-16 pt-[calc(var(--nav-h)+2.5rem)] sm:pt-[calc(var(--nav-h)+3.5rem)] lg:pb-24" aria-labelledby="module-title">
        <LogoOutline className="pointer-events-none absolute -right-[12%] -top-[36%] h-[150%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Módulos', to: '/modulos' }, { label: group.name, to: `/modulos#${group.id}` }, { label: 'NatPonto' }]} />
          <div className="mt-8 grid items-center gap-12 lg:grid-cols-[1.15fr_1fr] lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>{group.name} · App de ponto</Eyebrow>
              </Reveal>
              <div className="mt-5 flex items-start gap-4">
                <m.span initial={{ opacity: 0, scale: 0.8 }} animate={{ opacity: 1, scale: 1 }} transition={{ duration: 0.6, ease: EASE }} className="mt-1 hidden shrink-0 sm:block">
                  <NatPontoIcon className="h-16 w-16 drop-shadow-[0_10px_20px_rgba(201,87,136,0.35)]" />
                </m.span>
                <SplitText
                  as="h1"
                  id="module-title"
                  text={page.tagline}
                  className="text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-[3.5rem]"
                  highlightClassName="text-brand-purple"
                />
              </div>
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-xl text-lg leading-relaxed text-brand-graphite sm:text-xl">{page.summary}</p>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <Link to="#contato">
                    Agendar demonstração
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
                <Button asChild size="lg" variant="secondary">
                  <Link to="#jornada">Ver o app tela a tela</Link>
                </Button>
              </Reveal>
              <Reveal delay={0.4} className="mt-5">
                <StoreBadges tone="light" />
              </Reveal>
              <Stagger className="mt-10 grid grid-cols-2 gap-x-6 gap-y-6 sm:grid-cols-3" delay={0.4}>
                {page.highlights.map((h) => (
                  <StaggerItem key={h.label}>
                    <p className="text-2xl font-extrabold tracking-brand text-brand-purple sm:text-3xl">{h.value}</p>
                    <p className="mt-1 text-sm leading-snug text-brand-graphite">{h.label}</p>
                  </StaggerItem>
                ))}
              </Stagger>
            </div>

            <m.div initial={{ opacity: 0, y: 28 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.9, ease: EASE, delay: 0.25 }} className="relative mx-auto w-full max-w-[300px]">
              <div aria-hidden className="pointer-events-none absolute -inset-8 rounded-[3rem] bg-[radial-gradient(60%_60%_at_50%_40%,rgba(201,87,136,0.22),transparent_70%)]" />
              <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height} className="relative">
                <NatPontoPhone screen="home" />
              </ScaledFrame>
            </m.div>
          </div>
        </div>
      </Section>

      <Section id="beneficios" tone="white" aria-labelledby="beneficios-title">
        <div className="container">
          <SectionHeader id="beneficios-title" eyebrow="O que muda" title="O que muda com [[o NatPonto]]." />
          <BenefitsGrid items={page.benefits} />
        </div>
      </Section>

      <Section id="jornada" tone="off" className="overflow-hidden" aria-labelledby="jornada-title">
        <div className="container">
          <SectionHeader
            id="jornada-title"
            align="center"
            eyebrow="Tela a tela"
            title="Como o colaborador [[bate o ponto]]."
            lead="Quatro telas, menos de um minuto. As telas abaixo reproduzem o aplicativo em uso."
          />
          <ol className="mt-14 grid gap-10 sm:grid-cols-2 lg:mt-20 lg:grid-cols-4 lg:gap-6">
            {journey.map((s, i) => (
              <m.li
                key={s.screen}
                className="min-w-0"
                initial={{ opacity: 0, y: 30 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={viewportOnce}
                transition={{ duration: 0.8, ease: EASE, delay: i * 0.12 }}
              >
                <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height} className="mx-auto max-w-[280px]">
                  <NatPontoPhone screen={s.screen} />
                </ScaledFrame>
                <div className="mx-auto mt-5 max-w-[280px]">
                  <span className="flex h-9 w-9 items-center justify-center rounded-full bg-brand-purple text-sm font-extrabold tabular text-white">{i + 1}</span>
                  <h3 className="mt-3 text-lg font-bold text-brand-ink">{s.title}</h3>
                  <p className="mt-1.5 text-[15px] leading-relaxed text-brand-graphite">{s.text}</p>
                </div>
              </m.li>
            ))}
          </ol>
        </div>
      </Section>

      <Section id="modos" tone="white" aria-labelledby="modos-title">
        <div className="container">
          <SectionHeader id="modos-title" eyebrow="Onde funciona" title="No celular de cada um ou no [[tablet da unidade]]." />
          <Stagger className="mt-12 grid gap-4 md:grid-cols-3">
            {modes.map(({ icon: Icon, title, text }) => (
              <StaggerItem key={title} className="rounded-2xl border border-brand-mist bg-white p-6 shadow-soft">
                <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple">
                  <Icon className="h-5 w-5" strokeWidth={1.6} />
                </span>
                <h3 className="mt-4 text-lg font-bold text-brand-ink">{title}</h3>
                <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{text}</p>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      <Section id="unidades" tone="off" className="overflow-hidden" aria-labelledby="unidades-title">
        <LogoOutline className="pointer-events-none absolute -left-[14%] -bottom-[40%] h-[120%] w-auto text-brand-purple/[0.08]" />
        <div className="container relative">
          <SectionHeader
            id="unidades-title"
            eyebrow="Em 25 unidades"
            title="Um app para [[todas as filiais]]. Cada uma com o seu raio."
            lead="Fábrica, loja, clínica ou obra: o NatPonto segue a estrutura da empresa. O raio é por unidade, a alçada é da filial e o fechamento é da matriz."
          />
          <Stagger className="mt-12 grid gap-4 md:grid-cols-3" stagger={0.1}>
            {units.map(({ icon: Icon, title, text, link }) => (
              <StaggerItem key={title} className="flex h-full flex-col rounded-2xl border border-brand-mist bg-white p-6 shadow-soft">
                <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple">
                  <Icon className="h-5 w-5" strokeWidth={1.6} aria-hidden />
                </span>
                <h3 className="mt-4 text-lg font-bold leading-snug text-brand-ink">{title}</h3>
                <p className="mt-2 flex-1 text-[15px] leading-relaxed text-brand-graphite">{text}</p>
                <Link to={link.to} className="group mt-5 inline-flex items-center gap-1.5 text-[14px] font-semibold text-brand-purple">
                  {link.label}
                  <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                </Link>
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      <Section id="funcionalidades" tone="white" aria-labelledby="funcionalidades-title">
        <div className="container">
          <SectionHeader id="funcionalidades-title" eyebrow="Funcionalidades" title="O que o NatPonto [[faz]]." lead="Funcionalidades que existem hoje no aplicativo, descritas na linguagem de quem usa." />
          <FeaturesGrid items={page.features} />
        </div>
      </Section>

      <Section id="conformidade" tone="dark" className="overflow-hidden" aria-labelledby="conexoes-title">
        <LogoOutline className="pointer-events-none absolute -bottom-[45%] -left-[14%] h-[130%] w-auto text-white/[0.1]" />
        <div className="container relative grid gap-12 lg:grid-cols-2 lg:gap-16">
          <div>
            <Reveal y={12} duration={0.5}>
              <Eyebrow tone="white">Conformidade e prova</Eyebrow>
            </Reveal>
            <Reveal delay={0.08}>
              <h2 className="mt-4 text-3xl font-extrabold leading-tight sm:text-4xl">Cada marcação com prova.</h2>
            </Reveal>
            <Stagger className="mt-6 space-y-3" delay={0.2}>
              {[...(page.compliance ?? []), 'Geolocalização com o raio permitido de cada unidade'].map((c) => (
                <StaggerItem key={c} className="flex items-start gap-3 text-[15px] text-white/85">
                  <span className="mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-white/10 text-[#E4A9C4]">
                    <Check className="h-3 w-3" strokeWidth={3} />
                  </span>
                  {c}
                </StaggerItem>
              ))}
            </Stagger>
          </div>
          <div>
            <Reveal y={12} duration={0.5}>
              <Eyebrow tone="white">Conecta com</Eyebrow>
            </Reveal>
            <Reveal delay={0.08}>
              <h2 id="conexoes-title" className="mt-4 text-3xl font-extrabold leading-tight sm:text-4xl">
                Da marcação à folha, sem digitar.
              </h2>
            </Reveal>
            <RelatedModules items={related} />
          </div>
        </div>
      </Section>

      {page.personas && page.personas.length > 0 && (
        <Section id="para-quem" tone="off" aria-labelledby="personas-title">
          <div className="container">
            <SectionHeader id="personas-title" eyebrow="Para quem" title="Quem ganha com [[o NatPonto]]." />
            <PersonasGrid items={page.personas} />
          </div>
        </Section>
      )}

      <Section id="perguntas" tone="white" aria-labelledby="perguntas-title">
        <div className="container grid gap-10 lg:grid-cols-[1fr_1.6fr] lg:gap-16">
          <div className="lg:sticky lg:top-32 lg:self-start">
            <SectionHeader id="perguntas-title" eyebrow="Perguntas frequentes" title="Dúvidas sobre [[o NatPonto]]." />
            <Reveal delay={0.3} className="mt-8">
              <Link to="#contato" className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
                Quer ver na prática? Agende uma demonstração
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" />
              </Link>
            </Reveal>
          </div>
          <Reveal delay={0.15}>
            <ModuleFaqAccordion items={page.faq} />
          </Reveal>
        </div>
      </Section>

      <ImplantationBlock tone="off" />
      <SeeAlsoStrip tone="white" />
      <ModuleNav slug={entry.slug} />

      <CTASection title="Veja o NatPonto funcionando com a jornada da sua equipe." />
    </PageTransition>
  )
}
