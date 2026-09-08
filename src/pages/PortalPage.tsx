import { Navigate, useParams } from 'react-router'
import {
  Apple,
  ArrowRight,
  ArrowUpRight,
  HelpCircle,
  KeyRound,
  LifeBuoy,
  Lock,
  Play,
  ShieldAlert,
  ShieldCheck,
} from 'lucide-react'
import { PageTransition } from '@/components/motion/PageTransition'
import { NatPontoPhone } from '@/components/mockups/natponto/screens'
import { NATPONTO_SIZE } from '@/components/mockups/natponto/NatPontoFrame'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import iconeCandidato from '@/assets/portais/icone-candidato.svg'
import iconeNatdocs from '@/assets/portais/icone-natdocs.svg'
import iconeChamado from '@/assets/portais/icone-chamado.svg'
import { Logo, LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { SpotlightCard } from '@/components/motion/SpotlightCard'
import { NetworkField } from '@/components/nati/NetworkField'
import { HubPortais } from '@/components/portais/HubPortais'
import { useSeo } from '@/hooks/useSeo'
import {
  acharCliente,
  copy,
  ilustracoes,
  sistemas,
  type Ambiente,
  type Cliente,
  type Sistema,
  type SistemaKey,
} from '@/content/portais'

/**
 * A porta de entrada de um cliente: /portais/:slug e /portais/dev/:slug.
 *
 * Quem chega não veio navegando pelo site — veio de um link que o RH mandou,
 * muitas vezes no celular, para resolver uma coisa só. Por isso a página tem
 * cabeçalho e rodapé PRÓPRIOS, não os do site institucional: o menu de
 * marketing aqui só ofereceria saídas erradas.
 */
export default function PortalPage({ ambiente = 'prod' }: { ambiente?: Ambiente }) {
  const { slug = '' } = useParams()
  const cliente = acharCliente(slug)

  useSeo({
    title: cliente ? `Portais ${cliente.name} | Natcorp` : 'Portais | Natcorp',
    description: cliente
      ? `Acesso aos portais e serviços Natcorp de ${cliente.name}: colaborador, gestor, operador, candidato, NatDocs e chamados.`
      : 'Acesso aos portais Natcorp.',
    path: ambiente === 'dev' ? `/portais/dev/${slug}` : `/portais/${slug}`,
    // Endereço de acesso de um cliente não é conteúdo de busca.
    noindex: true,
  })

  if (!cliente) return <Navigate to="/portais" replace />

  const url = (key: SistemaKey) => cliente.urls[ambiente][key]
  const portais = sistemas.filter((s) => s.kind === 'portal')
  const servicos = sistemas.filter((s) => s.kind === 'service')

  return (
    <PageTransition>
      <div className="bg-white">
        <BarraTopo />
        {ambiente === 'dev' && <AvisoHomologacao />}
        <Hero cliente={cliente} url={url} ambiente={ambiente} />
        <SecaoPerfis portais={portais} url={url} />
        <SecaoServicos servicos={servicos} url={url} />
        <FaixaNatPonto />
        <SecaoAjuda url={url} />
        <Rodape cliente={cliente} url={url} ambiente={ambiente} />
      </div>
    </PageTransition>
  )
}

/* -------------------------------------------------------------------- topo */

function BarraTopo() {
  return (
    <header className="sticky top-0 z-40 border-b border-white/10 bg-brand-blue/90 text-white shadow-[inset_0_2px_0_#C95788] backdrop-blur-md">
      <div className="mx-auto flex h-16 max-w-6xl items-center gap-4 px-5 sm:px-8">
        <a href="/" className="shrink-0" aria-label="Natcorp">
          <Logo variant="horizontal" tone="white" className="h-7 w-auto" />
        </a>
        <nav className="ml-auto flex items-center gap-2 text-[13px] font-semibold">
          <a href="#ajuda" className="rounded-full px-3 py-2 transition-colors hover:bg-white/10">
            Ajuda
          </a>
          <a
            href="/"
            className="inline-flex items-center gap-1.5 rounded-full border border-white/25 px-3 py-2 transition-colors hover:bg-white/10"
          >
            natcorp.com.br
            <ArrowUpRight className="h-3.5 w-3.5" aria-hidden />
          </a>
        </nav>
      </div>
    </header>
  )
}

function AvisoHomologacao() {
  return (
    <div className="border-b border-amber-300 bg-amber-100" role="status">
      <div className="mx-auto flex max-w-6xl items-center gap-3 px-5 py-3 sm:px-8">
        <ShieldAlert className="h-5 w-5 shrink-0 text-amber-800" aria-hidden />
        <p className="text-[13.5px] font-semibold leading-snug text-amber-900">
          Ambiente de homologação. Os dados aqui são de teste e podem ser apagados a qualquer momento.
        </p>
      </div>
    </div>
  )
}

/* -------------------------------------------------------------------- hero */

function Hero({ cliente, url, ambiente }: { cliente: Cliente; url: (k: SistemaKey) => string; ambiente: Ambiente }) {
  return (
    <section className="relative isolate overflow-hidden bg-brand-blue text-white">
      {/* Quatro camadas, de trás para a frente: gradiente da marca, malha,
          campo de pontos e um brilho rosa. Nada aqui é informação — some
          inteiro para quem pediu menos movimento (o NetworkField se congela
          sozinho, e o hub troca a animação por um quadro parado). */}
      <div className="absolute inset-0" aria-hidden>
        <div className="absolute inset-0 bg-[radial-gradient(60%_80%_at_85%_50%,rgba(160,105,205,0.55),transparent_70%),radial-gradient(45%_60%_at_100%_100%,rgba(201,87,136,0.4),transparent_70%),linear-gradient(180deg,#2C1A63_0%,#3A1A66_60%,#4A1B72_100%)]" />
        <div
          className="absolute inset-0 hidden bg-[linear-gradient(rgba(255,255,255,0.06)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,0.06)_1px,transparent_1px)] bg-[size:56px_56px] lg:block"
          style={{ maskImage: 'radial-gradient(55% 90% at 78% 50%, #000, transparent 75%)', WebkitMaskImage: 'radial-gradient(55% 90% at 78% 50%, #000, transparent 75%)' }}
        />
        <NetworkField className="pointer-events-none absolute inset-0 h-full w-full opacity-40 lg:opacity-60 lg:[mask-image:linear-gradient(90deg,transparent_25%,#000_60%)] lg:[-webkit-mask-image:linear-gradient(90deg,transparent_25%,#000_60%)]" />
        <div className="absolute left-[30%] top-[-40%] hidden h-[180%] w-[45%] rounded-full bg-[radial-gradient(closest-side,rgba(201,87,136,0.3),rgba(201,87,136,0.1)_45%,rgba(201,87,136,0)_100%)] lg:block" />
      </div>

      <div className="relative mx-auto grid max-w-6xl gap-8 px-5 py-10 sm:px-8 sm:py-12 lg:grid-cols-[minmax(0,1fr)_auto] lg:items-center lg:gap-12 lg:py-14">
        <div>
          <Eyebrow tom="claro">{cliente.name}</Eyebrow>

          <h1 className="mt-3 text-[28px] font-extrabold leading-tight tracking-brand sm:text-[34px]">Portais</h1>

          <p className="mt-3 max-w-xl text-[14px] leading-relaxed text-white/75">{copy.hero.lead}</p>

          {/* Atalhos: quem já sabe para onde vai não precisa rolar até o cartão. */}
          <ul className="mt-5 flex flex-wrap gap-2">
            {sistemas.map((s) => (
              <li key={s.key}>
                <a
                  href={url(s.key)}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center gap-1.5 rounded-full border border-white/20 bg-white/10 px-3 py-1.5 text-[12.5px] font-semibold transition-colors hover:border-white/40 hover:bg-white/20 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#E4A9C4]"
                >
                  {s.short}
                  {s.key === 'chamado' && <span className="text-[10px] font-bold text-white/60">RH</span>}
                  <ArrowUpRight className="h-3 w-3 opacity-70" aria-hidden />
                </a>
              </li>
            ))}
          </ul>
        </div>

        <div className="relative hidden lg:block">
          {/* O hub é maior que a coluna e transborda de propósito: ele atravessa
              o hero por trás do quadro, e o `overflow-hidden` da seção corta o
              excesso. Sem `pointer-events-none` ele roubaria o clique do quadro. */}
          <div
            className="pointer-events-none absolute left-1/2 top-1/2 h-[720px] w-[1080px] -translate-x-[62.5%] -translate-y-1/2"
            aria-hidden
          >
            <HubPortais className="block h-full w-full overflow-visible" />
          </div>
          <CartaoMarca cliente={cliente} ambiente={ambiente} />
        </div>
      </div>
    </section>
  )
}

/** O quadro com a marca de quem é o portal — quem abriu precisa se reconhecer.
 *  A moldura translúcida é o quadro; o branco por dentro é o palco do logo. */
function CartaoMarca({ cliente, ambiente }: { cliente: Cliente; ambiente: Ambiente }) {
  return (
    <div
      className="relative w-[300px] rounded-2xl border border-white/25 bg-white/[0.08] p-3 backdrop-blur-sm"
      aria-label={`${cliente.name}, ambiente ${ambiente === 'dev' ? 'de homologação' : 'de produção'}`}
    >
      <div className="flex min-h-[88px] items-center justify-center rounded-xl bg-white px-6 py-4">
        {cliente.logo ? (
          <img src={cliente.logo} alt={cliente.name} className="max-h-12 w-auto object-contain" />
        ) : (
          <Logo variant="horizontal" tone="gradient" title={cliente.name} className="block h-9 w-auto" />
        )}
      </div>
    </div>
  )
}

/* ---------------------------------------------------------------- seções */

function Eyebrow({ children, tom = 'escuro' }: { children: React.ReactNode; tom?: 'claro' | 'escuro' }) {
  const cor = tom === 'claro' ? 'text-white/70' : 'text-brand-purple'
  return (
    <p className={`flex items-center gap-2 text-[11px] font-bold uppercase tracking-[0.14em] ${cor}`}>
      <span className="flex gap-1" aria-hidden>
        {[0.9, 0.7, 0.5, 0.35, 0.2].map((o, i) => (
          <span key={i} className="h-1.5 w-1.5 rotate-45 rounded-[1px] bg-current" style={{ opacity: o }} />
        ))}
      </span>
      {children}
    </p>
  )
}

function Cabecalho({ eyebrow, titulo, lead }: { eyebrow: string; titulo: string; lead: string }) {
  return (
    <div className="max-w-3xl">
      <Eyebrow>{eyebrow}</Eyebrow>
      <h2 className="mt-3 text-[30px] font-extrabold leading-tight tracking-brand text-brand-ink sm:text-[34px]">{titulo}</h2>
      <p className="mt-3 text-[14.5px] leading-relaxed text-brand-graphite">{lead}</p>
    </div>
  )
}

function SecaoPerfis({ portais, url }: { portais: Sistema[]; url: (k: SistemaKey) => string }) {
  return (
    <section className="bg-brand-off-white py-14 sm:py-16 lg:py-20">
      <div className="mx-auto max-w-6xl px-5 sm:px-8">
        <Cabecalho eyebrow={copy.perfis.eyebrow} titulo={copy.perfis.titulo} lead={copy.perfis.lead} />
        <div className="mt-10 grid gap-6 md:grid-cols-2 xl:grid-cols-3">
          {portais.map((s) => (
            <CartaoPortal key={s.key} sistema={s} href={url(s.key)} />
          ))}
        </div>
      </div>
    </section>
  )
}

function CartaoPortal({ sistema, href }: { sistema: Sistema; href: string }) {
  const ilustra = ilustracoes[sistema.key]
  return (
    <SpotlightCard className="group h-full overflow-hidden rounded-[28px] border border-brand-mist bg-white shadow-soft transition-[transform,box-shadow] duration-500 ease-brand hover:-translate-y-1 hover:shadow-lift">
      <div className="flex h-full flex-col">
        <div className="relative h-[220px] shrink-0 overflow-hidden bg-[linear-gradient(180deg,#F4F2F7_0%,#FBFAFD_100%)]">
          {/* o símbolo da marca, grande e quase apagado, como marca d'água */}
          <LogoOutline
            strokeWidth={1.25}
            className="absolute -right-12 -top-14 h-[260px] w-[260px] rotate-12 text-brand-purple/[0.12]"
          />
          <div
            className="absolute inset-x-0 bottom-0 h-40 bg-[radial-gradient(60%_80%_at_50%_100%,rgba(201,87,136,0.16),transparent_70%)]"
            aria-hidden
          />
          {ilustra && (
            <img
              src={ilustra.src}
              alt={ilustra.alt}
              draggable={false}
              /* CENTRALIZADA e ancorada no topo, ocupando a faixa inteira — foi
                 aqui que a minha versão errou: encostei a figura à direita e
                 encolhi a faixa, e o personagem ficou fora de lugar. */
              className="absolute left-1/2 top-5 h-[calc(100%-1.25rem)] w-[200px] -translate-x-1/2 object-cover object-top transition-transform duration-700 ease-brand group-hover:scale-[1.04]"
            />
          )}
          <div className="absolute inset-x-0 bottom-0 h-14 bg-gradient-to-t from-white to-transparent" aria-hidden />
          <span className="absolute left-5 top-5 inline-flex items-center gap-2 rounded-full border border-brand-mist bg-white/90 px-3 py-1 text-[11px] font-bold uppercase tracking-[0.12em] text-brand-purple">
            <span className="h-1.5 w-1.5 rotate-45 rounded-[1px] bg-brand-gradient" aria-hidden />
            {sistema.audience}
          </span>
        </div>

        <div className="flex flex-1 flex-col px-6 pb-6 pt-1 sm:px-7 sm:pb-7">
          <h3 className="text-[22px] font-extrabold leading-tight text-brand-ink">{sistema.name}</h3>
          <p className="mt-2 text-[14.5px] leading-relaxed text-brand-graphite">{sistema.description}</p>
          <Chips itens={sistema.tasks} />
          <div className="mt-auto pt-6">
            <Button asChild size="lg" className="w-full">
              <a href={href} target="_blank" rel="noopener noreferrer">
                Entrar no {sistema.name}
                <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" aria-hidden />
              </a>
            </Button>
          </div>
        </div>
      </div>
    </SpotlightCard>
  )
}

const iconesServico: Partial<Record<SistemaKey, string>> = {
  candidato: iconeCandidato,
  natdocs: iconeNatdocs,
  chamado: iconeChamado,
}

function SecaoServicos({ servicos, url }: { servicos: Sistema[]; url: (k: SistemaKey) => string }) {
  return (
    <section className="bg-white py-14 sm:py-16 lg:py-20">
      <div className="mx-auto max-w-6xl px-5 sm:px-8">
        <Cabecalho eyebrow={copy.servicos.eyebrow} titulo={copy.servicos.titulo} lead={copy.servicos.lead} />
        <div className="mt-10 grid gap-6 md:grid-cols-3">
          {servicos.map((s) => (
            <CartaoServico key={s.key} sistema={s} href={url(s.key)} />
          ))}
        </div>
      </div>
    </section>
  )
}

function CartaoServico({ sistema, href }: { sistema: Sistema; href: string }) {
  const icone = iconesServico[sistema.key]
  const destaque = sistema.key === 'chamado'

  return (
    <SpotlightCard className="group h-full overflow-hidden rounded-[28px] border border-brand-mist bg-white shadow-soft transition-[transform,box-shadow] duration-500 ease-brand hover:-translate-y-1 hover:shadow-lift">
      <div className="flex h-full flex-col p-6 sm:p-7">
        <div className="flex items-start justify-between gap-4">
          {icone && (
            <img
              src={icone}
              alt=""
              width={84}
              height={84}
              draggable={false}
              className="h-[84px] w-[84px] shrink-0 transition-transform duration-700 ease-brand group-hover:-rotate-3 group-hover:scale-105"
            />
          )}
          <span
            className={`rounded-full border px-3 py-1 text-right text-[11px] font-bold uppercase tracking-[0.12em] ${
              destaque ? 'border-brand-purple bg-brand-purple text-white' : 'border-brand-mist bg-brand-off-white text-brand-purple'
            }`}
          >
            {sistema.audience}
          </span>
        </div>

        <h3 className="mt-5 text-[22px] font-extrabold leading-tight text-brand-ink">{sistema.name}</h3>
        <p className="mt-2 text-[14.5px] leading-relaxed text-brand-graphite">{sistema.description}</p>
        {sistema.note && <p className="mt-2 text-[13px] leading-relaxed text-brand-gray">{sistema.note}</p>}

        <Chips itens={sistema.tasks} />

        <div className="mt-auto pt-6">
          <Button asChild variant="secondary" size="lg" className="w-full">
            <a href={href} target="_blank" rel="noopener noreferrer">
              {destaque ? 'Abrir chamado (RH)' : `Abrir o ${sistema.name}`}
              <ArrowUpRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5 group-hover/btn:-translate-y-0.5" aria-hidden />
            </a>
          </Button>
        </div>
      </div>
    </SpotlightCard>
  )
}

/** As tarefas viram etiquetas: a pessoa varre e reconhece a sua, sem ler frase. */
function Chips({ itens }: { itens: readonly string[] }) {
  return (
    <ul className="mt-4 flex flex-wrap gap-1.5" aria-label="O que você faz aqui">
      {itens.map((t) => (
        <li key={t} className="rounded-md border border-brand-mist bg-brand-off-white px-2 py-0.5 text-[11.5px] font-semibold text-brand-graphite">
          {t}
        </li>
      ))}
    </ul>
  )
}

/* ---------------------------------------------------------------- natponto */

function FaixaNatPonto() {
  return (
    <section className="bg-white pb-14 sm:pb-16 lg:pb-20">
      <div className="mx-auto max-w-6xl px-5 sm:px-8">
        <div className="relative overflow-hidden rounded-3xl bg-[linear-gradient(120deg,#511C76,#8B2F86_55%,#9A408A)] p-8 text-white sm:p-10 lg:grid lg:grid-cols-[minmax(0,1fr)_auto] lg:items-center lg:gap-10">
          <div className="max-w-2xl">
            <Eyebrow tom="claro">{copy.natponto.eyebrow}</Eyebrow>
            <h2 className="mt-3 text-[26px] font-extrabold leading-tight tracking-brand sm:text-[30px]">
              {copy.natponto.titulo}
            </h2>
            <p className="mt-3 text-[14px] leading-relaxed text-white/80">{copy.natponto.lead}</p>

            <ul className="mt-5 flex flex-wrap gap-2">
              {copy.natponto.chips.map((c) => (
                <li key={c} className="rounded-full border border-white/20 bg-white/10 px-3 py-1.5 text-[12px] font-semibold">
                  {c}
                </li>
              ))}
            </ul>

            <div className="mt-6 flex flex-wrap gap-3">
              <LojaApp href={copy.natponto.apple} icone={Apple} linha1="Baixar na" linha2="App Store" />
              <LojaApp href={copy.natponto.google} icone={Play} linha1="Disponível no" linha2="Google Play" />
            </div>
          </div>

          {/* O mesmo mockup usado nas páginas do NatPonto: quem já viu o app no
              site reconhece a tela aqui. Some no celular, onde ele competiria
              com o próprio conteúdo por largura. */}
          <div className="mt-10 hidden lg:mt-0 lg:block" aria-hidden>
            {/* O frame tem largura fixa (320px) por dentro; encolher pelo
                contêiner só o cortava. `ScaledFrame` é o utilitário que o
                próprio site usa para isto: escala o conteúdo e reserva a caixa
                do tamanho já escalado. */}
            <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height} className="w-[248px]">
              <NatPontoPhone screen="home" />
            </ScaledFrame>
          </div>
        </div>
      </div>
    </section>
  )
}

function LojaApp({
  href,
  icone: Icone,
  linha1,
  linha2,
}: {
  href: string
  icone: typeof Apple
  linha1: string
  linha2: string
}) {
  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      className="inline-flex items-center gap-2.5 rounded-xl bg-brand-ink px-4 py-2.5 transition-transform hover:-translate-y-0.5 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#E4A9C4]"
    >
      <Icone className="h-6 w-6" aria-hidden />
      <span className="leading-tight">
        <span className="block text-[9.5px] uppercase tracking-[0.1em] text-white/70">{linha1}</span>
        <span className="block text-[14px] font-bold">{linha2}</span>
      </span>
    </a>
  )
}

/* ------------------------------------------------------------------ ajuda */

const iconesAjuda = [KeyRound, Lock, LifeBuoy]

function SecaoAjuda({ url }: { url: (k: SistemaKey) => string }) {
  return (
    <section id="ajuda" className="scroll-mt-20 bg-brand-off-white py-14 sm:py-16 lg:py-20">
      <div className="mx-auto max-w-6xl px-5 sm:px-8">
        <Cabecalho eyebrow={copy.ajuda.eyebrow} titulo={copy.ajuda.titulo} lead={copy.ajuda.lead} />

        <div className="mt-10 grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
          {copy.ajuda.cartoes.map((c, i) => {
            const Icone = iconesAjuda[i] ?? HelpCircle
            const ultimo = i === copy.ajuda.cartoes.length - 1
            return (
              <article key={c.titulo} className="flex flex-col rounded-2xl border border-brand-mist bg-white p-5">
                <span className="flex h-9 w-9 items-center justify-center rounded-lg bg-brand-off-white text-brand-purple">
                  <Icone className="h-4 w-4" strokeWidth={1.9} aria-hidden />
                </span>
                <h3 className="mt-4 text-[14.5px] font-extrabold tracking-brand text-brand-ink">{c.titulo}</h3>
                <p className="mt-2 text-[13px] leading-relaxed text-brand-graphite">{c.texto}</p>
                {ultimo && (
                  <a
                    href={url('chamado')}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="mt-3 inline-flex items-center gap-1 text-[13px] font-bold text-brand-purple hover:underline"
                  >
                    Abrir chamado
                    <ArrowUpRight className="h-3.5 w-3.5" aria-hidden />
                  </a>
                )}
              </article>
            )
          })}
        </div>

        <div className="mt-6 flex flex-col gap-3 rounded-2xl border border-brand-mist bg-white p-5 sm:flex-row sm:items-center">
          <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-[linear-gradient(135deg,#511C76,#9A408A)]">
            <ShieldCheck className="h-5 w-5 text-white" strokeWidth={1.9} aria-hidden />
          </span>
          <div>
            <p className="text-[11px] font-bold uppercase tracking-[0.12em] text-brand-purple">Segurança</p>
            <p className="text-[14.5px] font-extrabold tracking-brand text-brand-ink">{copy.ajuda.seguranca.titulo}</p>
            <p className="mt-1 text-[13px] leading-relaxed text-brand-graphite">
              {copy.ajuda.seguranca.texto}{' '}
              <a href="/seguranca" className="font-bold text-brand-purple hover:underline">
                {copy.ajuda.seguranca.link}
              </a>
            </p>
          </div>
        </div>
      </div>
    </section>
  )
}

/* ----------------------------------------------------------------- rodapé */

function Rodape({ cliente, url, ambiente }: { cliente: Cliente; url: (k: SistemaKey) => string; ambiente: Ambiente }) {
  return (
    <footer className="bg-brand-blue py-10 text-white">
      <div className="mx-auto flex max-w-6xl flex-col gap-6 px-5 sm:flex-row sm:items-center sm:justify-between sm:px-8">
        <div className="flex items-center gap-4">
          <Logo variant="horizontal" tone="white" className="h-7 w-auto" />
          <span className="text-[12.5px] text-white/60">{copy.rodape.tagline}</span>
        </div>
        <ul className="flex flex-wrap items-center gap-x-6 gap-y-2 text-[13px] font-semibold">
          <li>
            <a href="/" className="hover:text-[#E4A9C4]">
              Site da Natcorp
            </a>
          </li>
          <li>
            <a href="/seguranca" className="hover:text-[#E4A9C4]">
              Segurança
            </a>
          </li>
          <li>
            <a href="/contato" className="hover:text-[#E4A9C4]">
              Contato
            </a>
          </li>
          <li>
            {/* "Suporte (RH)" e não "Suporte (Chamado)": o rótulo diz de quem
                é a porta. Colaborador e gestor falam com o RH da empresa; só o
                RH abre chamado com a Natcorp. */}
            <a href={url('chamado')} target="_blank" rel="noopener noreferrer" className="hover:text-[#E4A9C4]">
              Suporte (RH)
            </a>
          </li>
          <li>
            {/* O caminho oposto ao ambiente atual: quem está em produção vê
                "Homologação", e quem está em homologação vê a volta. */}
            <a
              href={ambiente === 'dev' ? `/portais/${cliente.slug}` : `/portais/dev/${cliente.slug}`}
              className="hover:text-[#E4A9C4]"
            >
              {ambiente === 'dev' ? 'Produção' : 'Homologação'}
            </a>
          </li>
        </ul>
      </div>
      <div className="mx-auto mt-8 flex max-w-6xl flex-col gap-1 border-t border-white/10 px-5 pt-6 text-[12px] text-white/50 sm:px-8">
        <span>© {new Date().getFullYear()} Natcorp. Todos os direitos reservados.</span>
        <span>{copy.rodape.nota}</span>
      </div>
    </footer>
  )
}
