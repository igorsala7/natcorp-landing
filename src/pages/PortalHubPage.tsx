import { useRef, type CSSProperties } from 'react'
import { Link, useParams } from 'react-router'
import { m, useInView, useReducedMotion } from 'motion/react'
import { ArrowRight, ArrowUpRight, FlaskConical, KeyRound, LifeBuoy, LockKeyhole, MapPin, QrCode, ScanFace, ShieldCheck, WifiOff } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Section, SectionHeader, Eyebrow } from '@/components/sections/Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { SplitText } from '@/components/motion/SplitText'
import { SpotlightCard } from '@/components/motion/SpotlightCard'
import { PageTransition } from '@/components/motion/PageTransition'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import { scrollToElement } from '@/components/motion/ScrollManager'
import { NetworkField } from '@/components/nati/NetworkField'
import { Logo, LogoOutline } from '@/components/brand/Logo'
import { NatPontoIcon } from '@/components/brand/NatPontoIcon'
import { StoreBadges } from '@/components/brand/StoreBadges'
import { ModuleLights, amberPalette, rosePalette } from '@/components/portals/ModuleLights'
import { NATPONTO_SIZE } from '@/components/mockups/natponto/NatPontoFrame'
import { NatPontoPhone } from '@/components/mockups/natponto/screens'
import { useSeo } from '@/hooks/useSeo'
import { usePortalClient, usePortalClients } from '@/hooks/usePortalClient'
import { clientLogo, hubPath, portalApps, portalHost, portalUrl, type PortalApp, type PortalClient, type PortalEnv } from '@/content/portals'
import { paths, siteConfig } from '@/content/site'
import { EASE, viewportOnce } from '@/lib/motion'
import { cn } from '@/lib/utils'
import figureColaborador from '@/assets/portals/figure-colaborador.webp'
import figureMarcos from '@/assets/portals/figure-marcos.webp'
import figureBeatriz from '@/assets/portals/figure-beatriz.webp'
import figureColaboradorDupla from '@/assets/portals/figure-colaborador-dupla.webp'
import figureGestorDupla from '@/assets/portals/figure-gestor-dupla.webp'
import figureOperadorDupla from '@/assets/portals/figure-operador-dupla.webp'
import iconCandidato from '@/assets/portals/icons/quadro-de-vagas.svg'
import iconNatDocs from '@/assets/portals/icons/assinatura-eletronica.svg'
import iconChamado from '@/assets/portals/icons/chamado-interno.svg'

/**
 * Quem ilustra cada portal do sistema: os personagens da jornada, na mesma
 * família 3D do material da marca.
 *
 * `dupla` é o segundo personagem do quadro. Cada portal é usado por mais de um
 * tipo de pessoa, e um retrato só sugere o contrário.
 *
 * OS NÚMEROS NÃO SÃO CHUTE. Cada arquivo foi gerado com um enquadramento
 * diferente, então a mesma largura em CSS deixava um personagem com a cabeça
 * maior que a do outro. `larg` sai de medição do PNG — altura da cabeça,
 * largura do ombro e altura do corpo, valendo a MEDIANA das três, porque
 * cabelo volumoso estraga a medida da cabeça e ombro largo de homem estraga a
 * do ombro. Com ela, os dois aparecem na MESMA escala: a altura exibida dos
 * dois bate dentro de 1px em todos os pares.
 *
 * `esq` é o canto esquerdo da imagem medido A PARTIR DO CENTRO do palco, para
 * a dupla ficar centrada em qualquer largura de cartão. O valor sai da
 * silhueta real dentro da faixa que aparece (já contando o espelhamento, que
 * troca as bordas de lado), com 16px de folga entre as duas pessoas — é o que
 * garante que fiquem lado a lado, sem uma tapar a outra.
 *
 * Trocar um arquivo de figura exige refazer a conta; o LEIA-ME em
 * src/assets/portals explica como.
 */
interface Figura {
  src: string
  alt: string
  /** Largura da imagem dentro do palco, em px. */
  larg: number
  /** Canto esquerdo da imagem, em px a partir do centro do palco. */
  esq: number
  /** Do topo do palco até o topo da cabeça, em px. */
  topo: number
  /** Espelha a figura, para as duas não olharem para o mesmo lado. */
  espelhado?: boolean
}
const figures: Partial<Record<PortalApp['key'], { principal: Figura; dupla?: Figura }>> = {
  colaborador: {
    principal: { src: figureColaborador, alt: 'Colaborador de camisa com a marca Natcorp, com o celular na mão', larg: 186, esq: -31, topo: 20 },
    dupla: { src: figureColaboradorDupla, alt: 'Colaboradora de camiseta lilás, com o celular na mão', larg: 135, esq: -176, topo: 20, espelhado: true },
  },
  gestor: {
    principal: { src: figureMarcos, alt: 'Gestor de blazer roxo, com o tablet na mão', larg: 186, esq: -15, topo: 20 },
    dupla: { src: figureGestorDupla, alt: 'Gestora de blazer rosa, com a prancheta na mão', larg: 142, esq: -171, topo: 20, espelhado: true },
  },
  operador: {
    principal: { src: figureBeatriz, alt: 'Analista do RH com o notebook na mão', larg: 165, esq: 22, topo: 20 },
    dupla: { src: figureOperadorDupla, alt: 'Operador de polo roxa da Natcorp, com o coletor na mão', larg: 193, esq: -179, topo: 20, espelhado: true },
  },
}

/** Ícones dos aplicativos e serviços: os mesmos ícones de módulo da marca. */
const icons: Partial<Record<PortalApp['key'], string>> = {
  candidato: iconCandidato,
  natdocs: iconNatDocs,
  chamado: iconChamado,
}

/**
 * Página de acesso aos portais de um cliente (/portais/<cliente> e /portais/dev/<cliente> na homologação):
 * a porta de entrada do sistema, com a identidade do site, o logotipo do cliente e os endereços dos portais
 * dele, como estão no cadastro. Não usa o menu e o rodapé de marketing: quem chega aqui quer entrar.
 */
export default function PortalHubPage({ env = 'prod' }: { env?: PortalEnv }) {
  const { cliente } = useParams()
  const client = usePortalClient(cliente)
  const dev = env === 'dev'

  useSeo({
    title: client ? `${dev ? 'Homologação · ' : ''}Portais ${client.name} | Natcorp` : 'Ambiente não encontrado | Portais Natcorp',
    description: client
      ? `Acesse os portais Natcorp da ${client.name}: Colaborador, Gestor, Operador, Candidato, NatDocs e Chamado. Um único sistema, uma única base.`
      : 'Não encontramos esse ambiente. Confira o endereço com o RH da sua empresa.',
    path: hubPath(client?.slug ?? cliente ?? '', env),
    noindex: dev || !client || client.slug !== 'natcorp',
  })

  if (!client) return <NotFound slug={cliente ?? ''} env={env} />

  return (
    <PageTransition>
      {dev && <EnvBanner client={client} />}
      <HubHeader client={client} env={env} />
      <Opening client={client} env={env} />

      {/* ---------- portais do sistema ---------- */}
      <Section tone="off" id="portais" className="py-14 sm:py-16 lg:py-20">
        <div className="container">
          <Eyebrow>Portais do sistema</Eyebrow>
          <Stagger className="mt-8 grid gap-6 md:grid-cols-2 xl:grid-cols-3" stagger={0.1}>
            {portalApps
              .filter((p) => p.kind === 'portal')
              .map((app) => (
                <StaggerItem key={app.key} className="h-full">
                  <PortalCard app={app} href={portalUrl(app, client, env)} dev={dev} />
                </StaggerItem>
              ))}
          </Stagger>
        </div>
      </Section>

      {/* ---------- aplicativos e serviços ---------- */}
      <Section tone="white" id="servicos" className="py-14 sm:py-16 lg:py-20">
        <div className="container">
          <SectionHeader
            eyebrow="Aplicativos e serviços"
            title="Candidatura, documentos e suporte."
            lead="Três entradas fora do dia a dia: para quem ainda não é da empresa, para quem tem algo a assinar e para o RH falar com a Natcorp."
          />
          <Stagger className="mt-10 grid gap-6 md:grid-cols-3" stagger={0.1}>
            {portalApps
              .filter((p) => p.kind === 'service')
              .map((app) => (
                <StaggerItem key={app.key} className="h-full">
                  <ServiceCard app={app} href={portalUrl(app, client, env)} dev={dev} />
                </StaggerItem>
              ))}
          </Stagger>
        </div>
      </Section>

      <NatPonto />
      <Help client={client} env={env} />
      <HubFooter client={client} env={env} />
    </PageTransition>
  )
}

/* ---------------- abertura ---------------- */

/**
 * Abertura baixa: saudação, uma linha, acesso rápido e a identidade do cliente, envolvida pelos losangos do
 * hero da home (os módulos em luz, com o brilho correndo na borda). Os cartões ficam logo abaixo.
 */
function Opening({ client, env }: { client: PortalClient; env: PortalEnv }) {
  const reduced = useReducedMotion() ?? false
  const ref = useRef<HTMLElement>(null)
  /** Os laços contínuos só rodam com a abertura na tela. */
  const inView = useInView(ref, { margin: '80px 0px' })
  const loop = inView && !reduced
  const dev = env === 'dev'
  return (
    <section ref={ref} className="on-dark relative isolate overflow-hidden bg-brand-blue text-white" aria-labelledby="hub-title">
      <div className="absolute inset-0" aria-hidden>
        <div
          className={cn(
            'absolute inset-0',
            dev
              ? 'bg-[radial-gradient(60%_80%_at_85%_50%,rgba(242,184,75,0.24),transparent_70%),linear-gradient(180deg,#1B1238_0%,#2C1A63_60%,#3A1A66_100%)]'
              : 'bg-[radial-gradient(60%_80%_at_85%_50%,rgba(160,105,205,0.55),transparent_70%),radial-gradient(45%_60%_at_100%_100%,rgba(201,87,136,0.4),transparent_70%),linear-gradient(180deg,#2C1A63_0%,#3A1A66_60%,#4A1B72_100%)]',
          )}
        />
        {/* a malha técnica, do lado do sistema */}
        <div
          className="absolute inset-0 hidden bg-[linear-gradient(rgba(255,255,255,0.06)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,0.06)_1px,transparent_1px)] bg-[size:56px_56px] lg:block"
          style={{
            WebkitMaskImage: 'radial-gradient(55% 90% at 78% 50%, #000, transparent 75%)',
            maskImage: 'radial-gradient(55% 90% at 78% 50%, #000, transparent 75%)',
          }}
        />
        <NetworkField
          density={0.7}
          className="opacity-40 lg:opacity-60 lg:[mask-image:linear-gradient(90deg,transparent_25%,#000_60%)] lg:[-webkit-mask-image:linear-gradient(90deg,transparent_25%,#000_60%)]"
        />
        {/* brilho que deriva devagar, para o roxo respirar */}
        <m.div
          className={cn(
            'absolute left-[30%] top-[-40%] hidden h-[180%] w-[45%] rounded-full lg:block',
            dev
              ? 'bg-[radial-gradient(closest-side,rgba(242,184,75,0.18),rgba(242,184,75,0.06)_45%,rgba(242,184,75,0)_100%)]'
              : 'bg-[radial-gradient(closest-side,rgba(201,87,136,0.3),rgba(201,87,136,0.1)_45%,rgba(201,87,136,0)_100%)]',
          )}
          style={{ willChange: 'transform, opacity' }}
          initial={{ x: '0%', y: '0%', opacity: 0.5 }}
          animate={loop ? { x: ['0%', '18%', '0%'], y: ['0%', '10%', '0%'], opacity: [0.5, 0.9, 0.5] } : { x: '0%', y: '0%', opacity: 0.5 }}
          transition={loop ? { duration: 12, ease: 'easeInOut', repeat: Infinity } : { duration: 1.2, ease: EASE }}
        />
      </div>

      <div className="container relative grid gap-8 py-10 sm:py-12 lg:grid-cols-[minmax(0,1fr)_auto] lg:items-center lg:gap-12 lg:py-14">
        <div>
          <Reveal y={10} duration={0.45}>
            <div className="flex flex-wrap items-center gap-3">
              <Eyebrow tone="white">Portais Natcorp · {client.name}</Eyebrow>
              {dev && <EnvChip />}
            </div>
          </Reveal>
          <SplitText
            as="h1"
            id="hub-title"
            text="[[Portais]]"
            className="mt-4 text-[2rem] font-extrabold leading-[1.06] sm:text-4xl lg:text-[2.75rem]"
            highlightClassName={dev ? 'text-[#F2B84B]' : 'text-[#F3C9DA]'}
          />
          <Reveal delay={0.25} y={12}>
            <p className="mt-4 max-w-xl text-[15px] leading-relaxed text-white/80 sm:text-base">
              {dev
                ? 'Esta é a base de homologação: serve para testar. Os dados daqui não são os da operação e podem ser apagados.'
                : 'Escolha o seu portal. É o mesmo sistema e a mesma base de dados: o que muda é o que você vê e o que pode fazer.'}
            </p>
          </Reveal>
          <Reveal delay={0.4} y={10}>
            <ul className="mt-6 flex flex-wrap gap-2" aria-label="Acesso rápido">
              {portalApps.map((app) => (
                <li key={app.key}>
                  <a
                    href={portalUrl(app, client, env)}
                    className="group inline-flex items-center gap-1.5 rounded-full border border-white/25 bg-white/[0.06] px-3.5 py-1.5 text-[13px] font-semibold text-white/90 transition-colors hover:border-white/60 hover:bg-white/15 hover:text-white"
                  >
                    {app.short}
                    {app.key === 'chamado' && <span className="text-[11px] font-bold text-white/60">RH</span>}
                    <ArrowUpRight
                      className="h-3.5 w-3.5 opacity-60 transition-transform group-hover:translate-x-px group-hover:-translate-y-px group-hover:opacity-100"
                      strokeWidth={2.2}
                    />
                  </a>
                </li>
              ))}
            </ul>
          </Reveal>
        </div>

        {/* a identidade do cliente, no centro do módulo em luz */}
        <div className="relative hidden lg:block">
          <div className="pointer-events-none absolute left-1/2 top-1/2 h-[720px] w-[1080px] -translate-x-[62.5%] -translate-y-1/2" aria-hidden>
            <ModuleLights on loop={loop} palette={dev ? amberPalette : rosePalette} id={dev ? 'hub-dev' : 'hub'} className="h-full w-full" />
          </div>
          <ClientBadge client={client} env={env} />
        </div>
      </div>
    </section>
  )
}

/** A identidade do cliente na abertura: só o logotipo (ou o nome), em um cartão de vidro. */
function ClientBadge({ client, env }: { client: PortalClient; env: PortalEnv }) {
  const dev = env === 'dev'
  const logo = clientLogo(client)
  const own = client.slug === 'natcorp'
  return (
    <m.div
      className={cn('relative w-[300px] rounded-2xl border p-3 backdrop-blur-sm', dev ? 'border-[#F2B84B]/50 bg-[#1B1238]/70' : 'border-white/25 bg-white/[0.08]')}
      initial={{ opacity: 0, y: 14 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.8, ease: EASE, delay: 0.5 }}
      aria-label={`${client.name}, ambiente ${dev ? 'de homologação' : 'de produção'}`}
    >
      <div className="flex min-h-[88px] items-center justify-center rounded-xl bg-white px-6 py-4">
        {logo ? (
          <img src={logo} alt={client.name} className="max-h-14 w-auto max-w-[230px] object-contain" draggable={false} />
        ) : own ? (
          <Logo variant="horizontal" decorative className="h-9 w-auto" />
        ) : (
          <span className="text-[22px] font-extrabold tracking-tight text-brand-ink">{client.name}</span>
        )}
      </div>
    </m.div>
  )
}

/* ---------------- homologação ---------------- */

/** Faixa âmbar no topo, presente só na base de homologação. */
function EnvBanner({ client }: { client: PortalClient }) {
  return (
    <div className="relative z-50 bg-[#F2B84B] text-brand-ink" role="status">
      <div className="absolute inset-y-0 left-0 w-3 bg-[repeating-linear-gradient(135deg,#1B1238_0_6px,transparent_6px_12px)] opacity-60" aria-hidden />
      <div className="container flex flex-wrap items-center gap-x-4 gap-y-1 py-2 text-[13px] font-semibold">
        <span className="inline-flex items-center gap-1.5 font-extrabold uppercase tracking-[0.12em]">
          <FlaskConical className="h-4 w-4" strokeWidth={2.2} /> Homologação
        </span>
        <span className="text-brand-ink/80">Base de testes da {client.name}: os dados podem ser apagados e não valem para a operação.</span>
        <Link to={hubPath(client.slug, 'prod')} className="ml-auto inline-flex items-center gap-1 font-bold underline-offset-4 hover:underline">
          Ir para a produção <ArrowRight className="h-3.5 w-3.5" />
        </Link>
      </div>
    </div>
  )
}

function EnvChip({ className }: { className?: string }) {
  return (
    <span
      className={cn(
        'inline-flex items-center gap-1.5 rounded-full bg-[#F2B84B] px-2.5 py-0.5 text-[11px] font-extrabold uppercase tracking-[0.12em] text-brand-ink',
        className,
      )}
    >
      <FlaskConical className="h-3 w-3" strokeWidth={2.4} /> Homologação
    </span>
  )
}

/* ---------------- moldura ---------------- */

function HubHeader({ client, env }: { client: PortalClient; env: PortalEnv }) {
  const dev = env === 'dev'
  const logo = clientLogo(client)
  const own = client.slug === 'natcorp'
  return (
    <header
      className={cn('on-dark sticky top-0 z-40 border-b text-white backdrop-blur-md', dev ? 'border-[#F2B84B]/40 bg-[#1B1238]/90' : 'border-white/10 bg-brand-blue/90')}
    >
      <div className="container flex h-16 items-center gap-3 sm:gap-4">
        <Link to={paths.home} className="shrink-0" aria-label="Natcorp, ir para o site">
          <Logo variant="horizontal" tone="white" decorative className="h-7 w-auto sm:h-8" />
        </Link>
        {!own && (
          <>
            <span className="h-6 w-px bg-white/25" aria-hidden />
            {logo ? (
              <span className="inline-flex h-9 items-center rounded-lg bg-white px-2.5">
                <img src={logo} alt={client.name} className="h-6 w-auto max-w-[140px] object-contain" draggable={false} />
              </span>
            ) : (
              <span className="text-[15px] font-extrabold tracking-tight text-white">{client.name}</span>
            )}
          </>
        )}
        {dev && <EnvChip className="hidden sm:inline-flex" />}
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

function HubFooter({ client, env }: { client: PortalClient; env: PortalEnv }) {
  const chamado = portalApps.find((p) => p.key === 'chamado')!
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
            <a href={portalUrl(chamado, client, env)} className="text-white/85 hover:text-white">
              Suporte (RH)
            </a>
          </li>
          <li>
            <Link to={hubPath(client.slug, env === 'dev' ? 'prod' : 'dev')} className="text-white/60 hover:text-white">
              {env === 'dev' ? 'Produção' : 'Homologação'}
            </Link>
          </li>
        </ul>
      </div>
      <div className="container mt-8 flex flex-col gap-1 border-t border-white/10 pt-6 text-[12px] text-white/50 sm:flex-row sm:justify-between">
        <span>
          © {new Date().getFullYear()} {siteConfig.name}. Todos os direitos reservados.
        </span>
        <span>Os portais abrem em {portalHost(client, env)}, o ambiente do sistema.</span>
      </div>
    </footer>
  )
}

/**
 * Uma figura no palco do cartão.
 *
 * O espelhamento e o zoom do hover moram AQUI, no wrapper, e não na <m.img>:
 * ao terminar a animação de entrada o motion deixa `transform: none` inline no
 * elemento, e inline vence classe. Um `scale-x-[-1]` ou um
 * `group-hover:scale-[1.04]` na imagem simplesmente nunca chegava a valer.
 * Como os dois são transform, vão juntos numa variável CSS.
 */
function Figurante({ fig, delay }: { fig: Figura; delay: number }) {
  return (
    <div
      className="absolute transition-transform duration-700 ease-brand [transform:scaleX(var(--esp))] group-hover:[transform:scale(calc(var(--esp)*1.04),1.04)]"
      style={{
        width: fig.larg,
        top: fig.topo,
        height: `calc(100% - ${fig.topo}px)`,
        left: `calc(50% + ${fig.esq}px)`,
        '--esp': fig.espelhado ? -1 : 1,
      } as CSSProperties}
    >
      <m.img
        src={fig.src}
        alt={fig.alt}
        draggable={false}
        className="h-full w-full object-cover object-top"
        initial={{ opacity: 0, y: 18 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={viewportOnce}
        transition={{ duration: 0.8, ease: EASE, delay }}
      />
    </div>
  )
}

/* ---------------- cartões ---------------- */

/** Cartão de um portal do sistema: o personagem no palco, o que a pessoa faz ali e o botão de entrar. */
function PortalCard({ app, href, dev }: { app: PortalApp; href: string; dev: boolean }) {
  const fig = figures[app.key]
  return (
    <SpotlightCard className="group h-full overflow-hidden rounded-[28px] border border-brand-mist bg-white shadow-soft transition-[transform,box-shadow] duration-500 ease-brand hover:-translate-y-1 hover:shadow-lift">
      <div className="flex h-full flex-col">
        <div className="relative h-[220px] shrink-0 overflow-hidden bg-[linear-gradient(180deg,#F4F2F7_0%,#FBFAFD_100%)]">
          <LogoOutline strokeWidth={1.25} className="absolute -right-12 -top-14 h-[260px] w-[260px] rotate-12 text-brand-purple/[0.12]" />
          <div className="absolute inset-x-0 bottom-0 h-40 bg-[radial-gradient(60%_80%_at_50%_100%,rgba(201,87,136,0.16),transparent_70%)]" aria-hidden />
          {fig && (
            <>
              {/* Lado a lado, no mesmo nível e na mesma escala, com a segunda
                  espelhada para as duas não olharem para o mesmo lado. */}
              {fig.dupla && <Figurante fig={fig.dupla} delay={0.25} />}
              <Figurante fig={fig.principal} delay={0.15} />
            </>
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
          <div className="mt-auto pt-6">
            <Button asChild size="lg" className="w-full">
              <a href={href}>
                Entrar no Portal do {app.short}
                <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
              </a>
            </Button>
            {dev && <DevNote />}
          </div>
        </div>
      </div>
    </SpotlightCard>
  )
}

/** Cartão de aplicativo ou serviço: o ícone de módulo da marca, para quem é e o botão de abrir. */
function ServiceCard({ app, href, dev }: { app: PortalApp; href: string; dev: boolean }) {
  const icon = icons[app.key]
  const restricted = app.key === 'chamado'
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
          <span
            className={cn(
              'rounded-full border px-3 py-1 text-right text-[11px] font-bold uppercase tracking-[0.12em]',
              restricted ? 'border-brand-purple/30 bg-brand-purple text-white' : 'border-brand-mist bg-brand-off-white text-brand-purple',
            )}
          >
            {app.audience}
          </span>
        </div>
        <h3 className="mt-5 text-[22px] font-extrabold leading-tight text-brand-ink">{app.name}</h3>
        <p className="mt-2 text-[14.5px] leading-relaxed text-brand-graphite">{app.description}</p>
        {app.note && <p className="mt-2 text-[12.5px] leading-relaxed text-brand-gray">{app.note}</p>}
        <div className="mt-auto pt-6">
          <Button asChild variant="secondary" size="lg" className="w-full">
            <a href={href}>
              {app.key === 'candidato' ? 'Abrir o Portal do Candidato' : app.key === 'chamado' ? 'Abrir chamado (RH)' : `Abrir o ${app.short}`}
              <ArrowUpRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5 group-hover/btn:-translate-y-0.5" />
            </a>
          </Button>
          {dev && <DevNote />}
        </div>
      </div>
    </SpotlightCard>
  )
}

function DevNote() {
  return (
    <p className="mt-2 inline-flex w-full items-center justify-center gap-1.5 text-[11.5px] font-bold uppercase tracking-[0.1em] text-[#B8791F]">
      <FlaskConical className="h-3.5 w-3.5" strokeWidth={2.2} /> Base de homologação
    </p>
  )
}

/* ---------------- NatPonto ---------------- */

const natPontoPoints = [
  { icon: ScanFace, text: 'Reconhecimento facial' },
  { icon: MapPin, text: 'Local dentro do raio' },
  { icon: WifiOff, text: 'Funciona sem internet' },
  { icon: QrCode, text: 'Comprovante com QR' },
]

/** O app de ponto, com os selos das lojas: a marcação é no celular, o espelho fica no Portal do Colaborador. */
function NatPonto() {
  return (
    <Section tone="white" id="natponto" className="pb-14 pt-0 sm:pb-16 lg:pb-20">
      <div className="container">
        <Reveal>
          <div className="on-dark relative overflow-hidden rounded-[32px] bg-brand-gradient text-white shadow-glow">
            <LogoOutline strokeWidth={1} className="absolute -left-24 -top-32 h-[420px] w-[420px] -rotate-12 text-white/[0.08]" />
            <div className="absolute inset-0 bg-[radial-gradient(50%_80%_at_85%_100%,rgba(27,18,56,0.45),transparent_70%)]" aria-hidden />
            <div className="relative grid gap-8 px-7 pt-8 sm:px-10 sm:pt-10 lg:grid-cols-[minmax(0,1fr)_320px] lg:items-end lg:gap-12 lg:px-12 lg:pt-12">
              <div className="pb-8 sm:pb-10 lg:pb-12">
                <div className="flex items-center gap-3">
                  <NatPontoIcon className="h-11 w-11" />
                  <Eyebrow tone="white" trail={false}>
                    NatPonto · App de ponto
                  </Eyebrow>
                </div>
                <h2 className="mt-5 text-[1.75rem] font-extrabold leading-[1.08] sm:text-[2.1rem]">O ponto é pelo celular.</h2>
                <p className="mt-3 max-w-xl text-[15px] leading-relaxed text-white/85 sm:text-base">
                  A marcação é no app NatPonto, com reconhecimento facial e geolocalização. Baixe o app, entre com o acesso liberado pelo RH da sua empresa e marque o
                  ponto. O espelho e os ajustes ficam no Portal do Colaborador.
                </p>
                <ul className="mt-5 flex flex-wrap gap-2" aria-label="O que o app faz">
                  {natPontoPoints.map(({ icon: Icon, text }) => (
                    <li
                      key={text}
                      className="inline-flex items-center gap-1.5 rounded-full border border-white/20 bg-white/10 px-3 py-1 text-[12.5px] font-semibold text-white/90"
                    >
                      <Icon className="h-3.5 w-3.5 text-[#F3C9DA]" strokeWidth={2} /> {text}
                    </li>
                  ))}
                </ul>
                <StoreBadges className="mt-7" />
              </div>
              {/* o app, saindo pela borda de baixo do cartão */}
              <div className="relative mx-auto hidden h-[300px] w-[260px] overflow-hidden lg:block" aria-hidden>
                <div className="absolute inset-x-0 top-0">
                  <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height} className="w-full">
                    <NatPontoPhone screen="home" />
                  </ScaledFrame>
                </div>
              </div>
            </div>
          </div>
        </Reveal>
      </div>
    </Section>
  )
}

/* ---------------- ajuda ---------------- */

function Help({ client, env }: { client: PortalClient; env: PortalEnv }) {
  const chamado = portalApps.find((p) => p.key === 'chamado')!
  const items = [
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
      icon: LifeBuoy,
      title: 'Suporte Natcorp (RH)',
      text: 'Problema no sistema? O RH da empresa abre um chamado com a Natcorp. Colaboradores e gestores falam com o próprio RH.',
      href: portalUrl(chamado, client, env),
      cta: 'Abrir chamado',
    },
  ]
  return (
    <Section tone="off" id="ajuda" className="py-14 sm:py-16 lg:py-20">
      <div className="container">
        <SectionHeader
          eyebrow="Precisa de ajuda?"
          title="Antes de abrir um chamado."
          lead="O acesso é criado pela sua empresa. Os problemas mais comuns se resolvem em um minuto."
        />
        <Stagger className="mt-10 grid gap-5 sm:grid-cols-2 lg:grid-cols-4" stagger={0.08}>
          {items.map((item) => (
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

        <Reveal className="mt-6">
          <div className="flex flex-col gap-5 rounded-2xl border border-brand-mist bg-white p-6 shadow-soft sm:flex-row sm:items-center">
            <span className="grid h-[64px] w-[64px] shrink-0 place-items-center rounded-2xl bg-brand-gradient">
              <ShieldCheck className="h-8 w-8 text-white" strokeWidth={1.8} />
            </span>
            <div>
              <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-purple">Segurança</p>
              <h3 className="mt-1 text-[17px] font-extrabold text-brand-ink">Seus dados, protegidos.</h3>
              <p className="mt-1.5 text-[14px] leading-relaxed text-brand-graphite">
                Servidores dedicados na Oracle Cloud, com contingência, criptografia e acesso por perfil. Nunca compartilhe sua senha.{' '}
                <Link to={paths.security} className="font-bold text-brand-purple underline-offset-4 hover:underline">
                  Como cuidamos da segurança
                </Link>
              </p>
            </div>
          </div>
        </Reveal>
      </div>
    </Section>
  )
}

/* ---------------- ambiente não encontrado ---------------- */

function NotFound({ slug, env }: { slug: string; env: PortalEnv }) {
  const known = usePortalClients()
  return (
    <PageTransition>
      <header className="on-dark border-b border-white/10 bg-brand-blue text-white">
        <div className="container flex h-16 items-center">
          <Link to={paths.home} aria-label="Natcorp, ir para o site">
            <Logo variant="horizontal" tone="white" decorative className="h-8 w-auto" />
          </Link>
        </div>
      </header>
      <Section tone="off" className="min-h-[calc(100vh-4rem)] py-16">
        <div className="container max-w-2xl">
          <Eyebrow>Portais Natcorp{env === 'dev' ? ' · Homologação' : ''}</Eyebrow>
          <h1 className="mt-5 text-[2rem] font-extrabold leading-tight text-brand-ink sm:text-4xl">Não encontramos o ambiente "{slug}".</h1>
          <p className="mt-4 text-[16px] leading-relaxed text-brand-graphite">
            Cada empresa tem o próprio endereço, no formato natcorp.com.br/portais/<b>nome-da-empresa</b>. Confira o endereço que o RH da sua empresa enviou ou escolha
            abaixo.
          </p>
          <ul className="mt-8 flex flex-wrap gap-2">
            {known.map((c) => (
              <li key={c.slug}>
                <Link
                  to={hubPath(c.slug, env)}
                  className="inline-flex items-center gap-1.5 rounded-full border border-brand-mist bg-white px-4 py-2 text-[13.5px] font-bold text-brand-purple shadow-soft hover:border-brand-purple/40"
                >
                  {c.name} <ArrowRight className="h-3.5 w-3.5" />
                </Link>
              </li>
            ))}
          </ul>
        </div>
      </Section>
    </PageTransition>
  )
}
