import { useMemo } from 'react'
import { Link, useParams } from 'react-router'
import { m, useReducedMotion } from 'motion/react'
import { ArrowRight, ArrowUpRight, KeyRound, LifeBuoy, LockKeyhole, ShieldCheck, Sparkles } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Section, SectionHeader, Eyebrow } from '@/components/sections/Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { SplitText } from '@/components/motion/SplitText'
import { SpotlightCard } from '@/components/motion/SpotlightCard'
import { PageTransition } from '@/components/motion/PageTransition'
import { scrollToElement } from '@/components/motion/ScrollManager'
import { NetworkField } from '@/components/nati/NetworkField'
import { Logo, LogoOutline } from '@/components/brand/Logo'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { MODULES, SYMBOL_BOX } from '@/components/brand/logo-paths'
import { useSeo } from '@/hooks/useSeo'
import { greeting, hubPath, portalApps, portalUrl, resolveClient, type PortalApp } from '@/content/portals'
import { paths, siteConfig } from '@/content/site'
import { EASE, viewportOnce } from '@/lib/motion'
import { cn } from '@/lib/utils'
import figureAna from '@/assets/portals/figure-ana.webp'
import figureRafael from '@/assets/portals/figure-rafael.webp'
import figureMarcos from '@/assets/portals/figure-marcos.webp'
import figureBeatriz from '@/assets/portals/figure-beatriz.webp'
import iconCandidato from '@/assets/portals/icons/quadro-de-vagas.svg'
import iconNatDocs from '@/assets/portals/icons/assinatura-eletronica.svg'
import iconChamado from '@/assets/portals/icons/chamado-interno.svg'
import iconNatPonto from '@/assets/portals/icons/natponto.svg'

/** Quem ilustra cada portal do sistema: os personagens da jornada, na mesma família 3D da NATI. */
const figures: Partial<Record<PortalApp['key'], { src: string; alt: string; objectPosition?: string }>> = {
  colaborador: {
    src: figureRafael,
    alt: 'Rafael, técnico de segurança, com o celular na mão',
  },
  gestor: {
    src: figureMarcos,
    alt: 'Marcos, gerente de produção, de blazer roxo',
  },
  operador: {
    src: figureBeatriz,
    alt: 'Beatriz, analista de admissão, com o notebook',
  },
}

/** Ícones dos aplicativos e serviços: os mesmos ícones de módulo da marca. */
const icons: Partial<Record<PortalApp['key'], string>> = {
  candidato: iconCandidato,
  natdocs: iconNatDocs,
  chamado: iconChamado,
}

/**
 * Página de acesso aos portais de um cliente (/portais/<cliente>): a porta de entrada do sistema,
 * com a mesma identidade do site. Não usa o menu e o rodapé de marketing: quem chega aqui quer entrar.
 */
export default function PortalHubPage() {
  const { cliente } = useParams()
  const client = useMemo(() => resolveClient(cliente), [cliente])
  const reduced = useReducedMotion() ?? false
  const isNatcorp = client.slug === 'natcorp'
  const hello = greeting()

  useSeo({
    title: `Portais ${client.name} | Natcorp`,
    description: `Acesse os portais Natcorp da ${client.name}: Colaborador, Gestor, Operador, Candidato, NatDocs e Chamado. Um único sistema, uma única base.`,
    path: hubPath(client.slug),
    noindex: !isNatcorp,
  })

  const systemPortals = portalApps.filter((p) => p.kind === 'portal')
  const services = portalApps.filter((p) => p.kind === 'service')
  const chamado = portalApps.find((p) => p.key === 'chamado')!

  return (
    <PageTransition>
      <HubHeader clientName={client.name} />

      {/* ---------- abertura ---------- */}
      <section className="on-dark relative isolate overflow-hidden bg-brand-blue text-white" aria-labelledby="hub-title">
        <div className="absolute inset-0" aria-hidden>
          <div className="absolute inset-0 bg-[radial-gradient(70%_60%_at_82%_40%,rgba(160,105,205,0.5),transparent_70%),radial-gradient(45%_45%_at_100%_100%,rgba(201,87,136,0.35),transparent_70%),radial-gradient(60%_50%_at_0%_0%,rgba(44,26,99,0.9),transparent_70%),linear-gradient(180deg,#2C1A63_0%,#3A1A66_45%,#4A1B72_100%)]" />
          <NetworkField
            density={0.6}
            className="opacity-40 lg:[mask-image:linear-gradient(90deg,transparent_25%,#000_65%)] lg:[-webkit-mask-image:linear-gradient(90deg,transparent_25%,#000_65%)]"
          />
          <ModuleDraw reduced={reduced} className="absolute right-[-6%] top-[-18%] hidden w-[min(46vw,640px)] text-[#F3C9DA] lg:block" />
          <div className="absolute inset-x-0 top-0 h-24 bg-gradient-to-b from-[#1B1238]/60 to-transparent" />
        </div>

        <div className="container relative grid gap-10 pt-16 sm:pt-20 lg:grid-cols-[minmax(0,1.1fr)_minmax(0,0.9fr)] lg:items-end lg:gap-6 lg:pt-24">
          <div className="pb-14 lg:pb-24">
            <Reveal y={12} duration={0.5}>
              <Eyebrow tone="white">Portais Natcorp · {client.name}</Eyebrow>
            </Reveal>
            <SplitText
              as="h1"
              id="hub-title"
              text={`${hello}. [[Por onde você entra hoje?]]`}
              highlightClassName="text-[#F3C9DA]"
              className="mt-5 text-[2.5rem] font-extrabold leading-[1.04] sm:text-5xl lg:text-[3.6rem] xl:text-[4rem]"
            />
            <Reveal delay={0.3} y={16}>
              <p className="mt-6 max-w-xl text-[16px] leading-relaxed text-white/85 sm:text-lg">
                Escolha o seu portal. É o mesmo sistema e a mesma base de dados
                {isNatcorp ? '' : ` da ${client.name}`}, com a NATI, nossa Inteligência Artificial, para responder o que você precisar.
              </p>
            </Reveal>
            <Reveal delay={0.45} y={12}>
              <div className="mt-9">
                <p className="text-[11px] font-semibold uppercase tracking-[0.16em] text-white/60">Acesso rápido</p>
                <ul className="mt-3 flex flex-wrap gap-2">
                  {portalApps.map((app) => (
                    <li key={app.key}>
                      <a
                        href={portalUrl(app, client)}
                        className="group inline-flex items-center gap-1.5 rounded-full border border-white/25 bg-white/[0.06] px-3.5 py-1.5 text-[13px] font-semibold text-white/90 transition-colors hover:border-white/60 hover:bg-white/15 hover:text-white"
                      >
                        {app.short}
                        <ArrowUpRight
                          className="h-3.5 w-3.5 opacity-60 transition-transform group-hover:translate-x-px group-hover:-translate-y-px group-hover:opacity-100"
                          strokeWidth={2.2}
                        />
                      </a>
                    </li>
                  ))}
                </ul>
              </div>
            </Reveal>
          </div>

          {/* a Ana entra no sistema; a NATI já está lá dentro */}
          <div className="relative hidden min-h-[520px] lg:block" aria-hidden>
            <div className="absolute bottom-0 left-1/2 h-10 w-[70%] -translate-x-1/2 rounded-[100%] bg-[radial-gradient(closest-side,rgba(243,201,218,0.5),rgba(243,201,218,0))] blur-md" />
            <m.img
              src={figureAna}
              alt=""
              draggable={false}
              className="absolute bottom-0 left-1/2 h-[560px] w-auto -translate-x-1/2 object-contain drop-shadow-[0_30px_40px_rgba(27,18,56,0.5)]"
              initial={reduced ? false : { opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 1, ease: EASE, delay: 0.3 }}
            />
            <m.div
              className="absolute left-0 top-[24%] w-[250px] rounded-2xl border border-[#E4A9C4]/40 bg-[#1B1238]/80 p-3.5 shadow-[0_12px_40px_rgba(27,18,56,0.45)]"
              initial={reduced ? false : { opacity: 0, y: 16 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.9, ease: EASE, delay: 1 }}
            >
              <div className="flex items-start gap-3">
                <NatiAvatar ring className="h-9 w-9 shrink-0" />
                <div className="min-w-0">
                  <p className="text-[10.5px] font-bold uppercase tracking-[0.14em] text-[#E4A9C4]">NATI · em todos os portais</p>
                  <p className="mt-0.5 text-[13px] font-semibold leading-snug text-white">
                    Pergunte em linguagem natural: holerite, ponto, férias, benefícios. Eu respondo na hora.
                  </p>
                </div>
              </div>
            </m.div>
          </div>
        </div>
      </section>

      {/* ---------- portais do sistema ---------- */}
      <Section tone="off" id="portais" className="py-16 sm:py-20 lg:py-24">
        <div className="container">
          <SectionHeader
            eyebrow="Portais do sistema"
            title="Entre pelo seu perfil."
            lead="Cada portal mostra só o que faz sentido para você. O cadastro é um só: o que muda é o que você vê e o que pode fazer."
          />
          <Stagger className="mt-12 grid gap-6 md:grid-cols-2 xl:grid-cols-3" stagger={0.1}>
            {systemPortals.map((app) => (
              <StaggerItem key={app.key} className="h-full">
                <PortalCard app={app} href={portalUrl(app, client)} />
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      {/* ---------- aplicativos e serviços ---------- */}
      <Section tone="white" id="servicos" className="py-16 sm:py-20 lg:py-24">
        <div className="container">
          <SectionHeader
            eyebrow="Aplicativos e serviços"
            title="Candidatura, documentos e suporte."
            lead="Três entradas fora do dia a dia do RH: para quem ainda não é da empresa, para quem tem algo a assinar e para quem precisa de ajuda com o sistema."
          />
          <Stagger className="mt-12 grid gap-6 md:grid-cols-3" stagger={0.1}>
            {services.map((app) => (
              <StaggerItem key={app.key} className="h-full">
                <ServiceCard app={app} href={portalUrl(app, client)} />
              </StaggerItem>
            ))}
          </Stagger>
        </div>
      </Section>

      {/* ---------- ajuda ---------- */}
      <Section tone="off" id="ajuda" className="py-16 sm:py-20 lg:py-24">
        <div className="container">
          <SectionHeader
            eyebrow="Precisa de ajuda?"
            title="Antes de abrir um chamado."
            lead="O acesso é criado pela sua empresa. Os problemas mais comuns se resolvem em um minuto."
          />
          <Stagger className="mt-12 grid gap-5 sm:grid-cols-2 lg:grid-cols-4" stagger={0.08}>
            {[
              {
                icon: LockKeyhole,
                title: 'Primeiro acesso',
                text: 'Seu usuário é criado pelo RH da sua empresa. Se ainda não recebeu, fale com o RH antes de tentar entrar.',
              },
              {
                icon: KeyRound,
                title: 'Esqueci a senha',
                text: 'Peça a redefinição na tela de entrada do portal ou ao RH da sua empresa. A senha é sua: a Natcorp não tem acesso a ela.',
              },
              {
                icon: Sparkles,
                title: 'Pergunte à NATI',
                text: 'Dúvidas sobre holerite, ponto, férias e benefícios a NATI responde dentro do portal, em linguagem natural.',
              },
              {
                icon: LifeBuoy,
                title: 'Suporte Natcorp',
                text: 'Problema no sistema? Abra um chamado. A equipe de suporte responde no próprio Chamado, com número e prazo.',
                href: portalUrl(chamado, client),
                cta: 'Abrir chamado',
              },
            ].map((item) => (
              <StaggerItem key={item.title} className="h-full">
                <div className="flex h-full flex-col rounded-2xl border border-brand-mist bg-white p-6 shadow-soft">
                  <span className="grid h-11 w-11 place-items-center rounded-xl bg-brand-gradient text-white">
                    <item.icon className="h-5 w-5" strokeWidth={2} />
                  </span>
                  <h3 className="mt-5 text-[17px] font-extrabold text-brand-ink">{item.title}</h3>
                  <p className="mt-2 text-[14px] leading-relaxed text-brand-graphite">{item.text}</p>
                  {item.href && (
                    <a href={item.href} className="mt-auto inline-flex items-center gap-1.5 pt-5 text-[13.5px] font-bold text-brand-purple hover:underline">
                      {item.cta} <ArrowRight className="h-4 w-4" />
                    </a>
                  )}
                </div>
              </StaggerItem>
            ))}
          </Stagger>

          <div className="mt-6 grid gap-5 lg:grid-cols-2">
            <Reveal>
              <div className="flex h-full items-center gap-5 rounded-2xl border border-brand-mist bg-white p-6 shadow-soft">
                <img src={iconNatPonto} alt="" width={72} height={72} className="h-[72px] w-[72px] shrink-0" draggable={false} />
                <div>
                  <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-purple">NatPonto</p>
                  <h3 className="mt-1 text-[17px] font-extrabold text-brand-ink">O ponto é pelo celular.</h3>
                  <p className="mt-1.5 text-[14px] leading-relaxed text-brand-graphite">
                    A marcação é no app NatPonto, com reconhecimento facial. O RH da sua empresa libera o seu acesso; o espelho fica no Portal do Colaborador.
                  </p>
                </div>
              </div>
            </Reveal>
            <Reveal delay={0.1}>
              <div className="on-dark flex h-full items-center gap-5 rounded-2xl bg-brand-gradient p-6 text-white shadow-glow">
                <span className="grid h-[72px] w-[72px] shrink-0 place-items-center rounded-2xl border border-white/20 bg-white/10">
                  <ShieldCheck className="h-8 w-8 text-[#F3C9DA]" strokeWidth={1.8} />
                </span>
                <div>
                  <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-[#E4A9C4]">Segurança</p>
                  <h3 className="mt-1 text-[17px] font-extrabold">Seus dados, protegidos.</h3>
                  <p className="mt-1.5 text-[14px] leading-relaxed text-white/85">
                    Servidores dedicados na Oracle Cloud, com contingência, criptografia e acesso por perfil. Nunca compartilhe sua senha.{' '}
                    <Link to={paths.security} className="font-bold text-white underline-offset-4 hover:underline">
                      Como cuidamos da segurança
                    </Link>
                  </p>
                </div>
              </div>
            </Reveal>
          </div>
        </div>
      </Section>

      <HubFooter chamadoHref={portalUrl(chamado, client)} />
    </PageTransition>
  )
}

/* ---------------- peças da página ---------------- */

function HubHeader({ clientName }: { clientName: string }) {
  return (
    <header className="on-dark sticky top-0 z-40 border-b border-white/10 bg-brand-blue/90 text-white backdrop-blur-md">
      <div className="container flex h-16 items-center gap-4">
        <Link to={paths.home} className="shrink-0" aria-label="Natcorp, ir para o site">
          <Logo variant="horizontal" tone="white" decorative className="h-8 w-auto" />
        </Link>
        <span className="hidden h-6 w-px bg-white/20 sm:block" aria-hidden />
        <span className="hidden items-center gap-2 rounded-full border border-white/20 bg-white/[0.06] px-3 py-1 text-[12px] font-semibold text-white/85 sm:inline-flex">
          <span className="h-1.5 w-1.5 rotate-45 rounded-[1px] bg-[#F3C9DA]" aria-hidden />
          Portais · {clientName}
        </span>
        <nav className="ml-auto flex items-center gap-2 text-[13px] font-semibold" aria-label="Atalhos">
          <a
            href="#ajuda"
            onClick={(e) => {
              const el = document.getElementById('ajuda')
              if (!el) return
              e.preventDefault()
              scrollToElement(el)
            }}
            className="rounded-full px-3 py-2 text-white/80 transition-colors hover:bg-white/10 hover:text-white"
          >
            Ajuda
          </a>
          <Link
            to={paths.home}
            className="hidden items-center gap-1.5 rounded-full border border-white/25 px-3.5 py-2 text-white/90 transition-colors hover:border-white/60 hover:bg-white/10 sm:inline-flex"
          >
            natcorp.com.br <ArrowUpRight className="h-3.5 w-3.5" strokeWidth={2.2} />
          </Link>
        </nav>
      </div>
    </header>
  )
}

function HubFooter({ chamadoHref }: { chamadoHref: string }) {
  return (
    <footer className="on-dark bg-brand-blue py-10 text-white">
      <div className="container flex flex-col gap-6 sm:flex-row sm:items-center sm:justify-between">
        <div className="flex items-center gap-4">
          <Logo variant="horizontal" tone="white" decorative className="h-8 w-auto" />
          <span className="hidden h-6 w-px bg-white/20 sm:block" aria-hidden />
          <p className="text-[13px] text-white/70">HR Tech brasileira. Há mais de 35 anos, todo o RH em um único sistema.</p>
        </div>
        <ul className="flex flex-wrap items-center gap-x-6 gap-y-2 text-[13px] font-semibold">
          <li>
            <Link to={paths.home} className="text-white/85 hover:text-white">
              Site da Natcorp
            </Link>
          </li>
          <li>
            <Link to={paths.security} className="text-white/85 hover:text-white">
              Segurança
            </Link>
          </li>
          <li>
            <Link to={paths.contact} className="text-white/85 hover:text-white">
              Contato
            </Link>
          </li>
          <li>
            <a href={chamadoHref} className="text-white/85 hover:text-white">
              Suporte
            </a>
          </li>
        </ul>
      </div>
      <div className="container mt-8 flex flex-col gap-1 border-t border-white/10 pt-6 text-[12px] text-white/50 sm:flex-row sm:justify-between">
        <span>
          © {new Date().getFullYear()} {siteConfig.name}. Todos os direitos reservados.
        </span>
        <span>Os portais abrem em natcorpbr.com.br, o ambiente do sistema.</span>
      </div>
    </footer>
  )
}

/** Cartão de um portal do sistema: o personagem no palco, o que a pessoa faz ali e o botão de entrar. */
function PortalCard({ app, href }: { app: PortalApp; href: string }) {
  const fig = figures[app.key]
  return (
    <SpotlightCard className="group h-full overflow-hidden rounded-[28px] border border-brand-mist bg-white shadow-soft transition-[transform,box-shadow] duration-500 ease-brand hover:-translate-y-1 hover:shadow-lift">
      <div className="flex h-full flex-col">
        <div className="relative h-[236px] shrink-0 overflow-hidden bg-[linear-gradient(180deg,#F4F2F7_0%,#FBFAFD_100%)]">
          <LogoOutline strokeWidth={1.25} className="absolute -right-12 -top-14 h-[260px] w-[260px] rotate-12 text-brand-purple/[0.12]" />
          <div className="absolute inset-x-0 bottom-0 h-40 bg-[radial-gradient(60%_80%_at_50%_100%,rgba(201,87,136,0.16),transparent_70%)]" aria-hidden />
          {fig && (
            <m.img
              src={fig.src}
              alt={fig.alt}
              draggable={false}
              className="absolute left-1/2 top-5 h-[calc(100%-1.25rem)] w-[210px] -translate-x-1/2 object-cover object-top transition-transform duration-700 ease-brand group-hover:scale-[1.04]"
              style={{ objectPosition: fig.objectPosition ?? 'top' }}
              initial={{ opacity: 0, y: 18 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={viewportOnce}
              transition={{ duration: 0.8, ease: EASE, delay: 0.15 }}
            />
          )}
          <div className="absolute inset-x-0 bottom-0 h-14 bg-gradient-to-t from-white to-transparent" aria-hidden />
          <span className="absolute left-5 top-5 inline-flex items-center gap-2 rounded-full border border-brand-mist bg-white/90 px-3 py-1 text-[11px] font-bold uppercase tracking-[0.12em] text-brand-purple">
            <span className="h-1.5 w-1.5 rotate-45 rounded-[1px] bg-brand-gradient" aria-hidden />
            {app.audience}
          </span>
        </div>
        <div className="flex flex-1 flex-col px-6 pb-6 pt-1 sm:px-7 sm:pb-7">
          <h3 className="text-[22px] font-extrabold leading-tight text-brand-ink">{app.name}</h3>
          <p className="mt-2 text-[14.5px] leading-relaxed text-brand-graphite">{app.description}</p>
          <ul className="mt-4 flex flex-wrap gap-1.5" aria-label="O que você faz aqui">
            {app.tasks.map((t) => (
              <li key={t} className="rounded-md border border-brand-mist bg-brand-off-white px-2 py-0.5 text-[11.5px] font-semibold text-brand-graphite">
                {t}
              </li>
            ))}
          </ul>
          <div className="mt-auto pt-6">
            <Button asChild size="lg" className="w-full">
              <a href={href}>
                Entrar no Portal do {app.short}
                <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
              </a>
            </Button>
          </div>
        </div>
      </div>
    </SpotlightCard>
  )
}

/** Cartão de aplicativo ou serviço: o ícone de módulo da marca, para quem é e o botão de abrir. */
function ServiceCard({ app, href }: { app: PortalApp; href: string }) {
  const icon = icons[app.key]
  return (
    <SpotlightCard className="group h-full rounded-[28px] border border-brand-mist bg-white shadow-soft transition-[transform,box-shadow] duration-500 ease-brand hover:-translate-y-1 hover:shadow-lift">
      <div className="flex h-full flex-col p-6 sm:p-7">
        <div className="flex items-start justify-between gap-4">
          {icon && (
            <img
              src={icon}
              alt=""
              width={84}
              height={84}
              className="h-[84px] w-[84px] shrink-0 transition-transform duration-700 ease-brand group-hover:-rotate-3 group-hover:scale-105"
              draggable={false}
            />
          )}
          <span className="rounded-full border border-brand-mist bg-brand-off-white px-3 py-1 text-[11px] font-bold uppercase tracking-[0.12em] text-brand-purple">
            {app.audience}
          </span>
        </div>
        <h3 className="mt-5 text-[22px] font-extrabold leading-tight text-brand-ink">{app.name}</h3>
        <p className="mt-2 text-[14.5px] leading-relaxed text-brand-graphite">{app.description}</p>
        <ul className="mt-4 flex flex-wrap gap-1.5" aria-label="O que você faz aqui">
          {app.tasks.map((t) => (
            <li key={t} className="rounded-md border border-brand-mist bg-brand-off-white px-2 py-0.5 text-[11.5px] font-semibold text-brand-graphite">
              {t}
            </li>
          ))}
        </ul>
        <div className="mt-auto pt-6">
          <Button asChild variant="secondary" size="lg" className="w-full">
            <a href={href}>
              Abrir {app.short === 'Candidato' ? 'o Portal do Candidato' : `o ${app.short}`}
              <ArrowUpRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5 group-hover/btn:-translate-y-0.5" />
            </a>
          </Button>
        </div>
      </div>
    </SpotlightCard>
  )
}

/** O símbolo da Natcorp em contorno, desenhando-se na entrada (grafismo da abertura). */
function ModuleDraw({ reduced, className }: { reduced: boolean; className?: string }) {
  return (
    <svg viewBox={`0 0 ${SYMBOL_BOX} ${SYMBOL_BOX}`} className={cn('block', className)} aria-hidden focusable="false">
      {MODULES.map((d, i) => (
        <m.path
          key={i}
          d={d}
          fill="none"
          stroke="currentColor"
          strokeWidth={1.4}
          strokeOpacity={0.26}
          vectorEffect="non-scaling-stroke"
          initial={reduced ? false : { pathLength: 0, opacity: 0 }}
          animate={{ pathLength: 1, opacity: 1 }}
          transition={{ duration: 1.8, ease: EASE, delay: 0.2 + i * 0.15 }}
        />
      ))}
    </svg>
  )
}
