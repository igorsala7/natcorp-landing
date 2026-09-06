import { useState, type ComponentType, type HTMLAttributes, type ReactNode } from 'react'
import { RotateCcw } from 'lucide-react'
import { Section, Eyebrow } from '@/components/sections/Section'
import { PageTransition } from '@/components/motion/PageTransition'
import { LOGO_MOTION_MS, LogoMotion } from '@/components/brand/LogoMotion'
import { SYSTEM_MOTION_MS, SystemMotion } from '@/components/brand/motion/SystemMotion'
import { NATI_MOTION_MS, NatiMotion } from '@/components/brand/motion/NatiMotion'
import { CLOUD_MOTION_MS, CloudMotion } from '@/components/brand/motion/CloudMotion'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'
import { cn } from '@/lib/utils'
import { paths } from '@/content/site'

interface PieceProps {
  tone?: 'white' | 'gradient'
  play?: boolean
  className?: string
}

interface Piece {
  id: string
  title: string
  text: string
  ms: number
  Component: ComponentType<PieceProps>
  /** Largura da peça dentro do painel. */
  width: string
}

const pieces: Piece[] = [
  {
    id: 'assinatura',
    title: 'A assinatura',
    text: 'Os quatro losangos se aproximam devagar e se encaixam. Um instante parado. Então o raio rosa dispara pelo X vazado, do centro para fora, e o nome surge ao lado, com tudo centralizado.',
    ms: LOGO_MOTION_MS,
    Component: LogoMotion,
    width: 'w-[min(78vw,560px)]',
  },
  {
    id: 'sistema',
    title: 'Um sistema, uma experiência',
    text: 'Os módulos, espalhados e desconectados, se reúnem em volta de uma base única. O símbolo se forma no centro e um pulso rosa percorre todas as ligações.',
    ms: SYSTEM_MOTION_MS,
    Component: SystemMotion,
    width: 'w-[min(84vw,600px)]',
  },
  {
    id: 'nati',
    title: 'NATI, a Inteligência Artificial',
    text: 'Uma pergunta chega, a NATI consulta os módulos e responde com a lista pronta e a próxima ação sugerida.',
    ms: NATI_MOTION_MS,
    Component: NatiMotion,
    width: 'w-[min(84vw,600px)]',
  },
  {
    id: 'nuvem',
    title: 'Servidores dedicados na Oracle Cloud',
    text: 'A nuvem se desenha, os servidores de aplicação e de banco de dados sobem, o sistema pousa dentro dela e o acesso passa pelo firewall.',
    ms: CLOUD_MOTION_MS,
    Component: CloudMotion,
    width: 'w-[min(84vw,600px)]',
  },
]

const formatSeconds = (ms: number) => `${(ms / 1000).toFixed(1).replace('.', ',')} s`

/**
 * Página interna de motion da marca: cada peça em fundo escuro e claro, com repetição por peça.
 * Fora do menu e do sitemap.
 */
export default function MotionPage() {
  useSeo({ title: 'Motion da marca | Natcorp', description: 'Peças de motion da identidade Natcorp.', path: paths.motion, noindex: true })
  const [takes, setTakes] = useState<Record<string, number>>({})
  const replay = (id: string) => setTakes((t) => ({ ...t, [id]: (t[id] ?? 0) + 1 }))

  return (
    <PageTransition>
      <Section tone="off" className="pt-[calc(var(--nav-h)+3rem)] pb-12 sm:pb-14" aria-labelledby="motion-title">
        <div className="container">
          <Eyebrow>Motion da marca</Eyebrow>
          <h1 id="motion-title" className="mt-4 max-w-3xl text-4xl font-extrabold tracking-tight text-brand-ink sm:text-5xl">
            A marca em movimento
          </h1>
          <p className="mt-4 max-w-2xl text-lg text-brand-graphite">
            Quatro peças da mesma família, todas em vetor, nas proporções do manual. A primeira abre o site, em fundo
            claro, lenta e deliberada. As outras contam o sistema, a NATI e a nuvem com a mesma linguagem: os losangos,
            o raio rosa e o encaixe. Cada uma tem a versão para fundo claro e para fundo escuro.
          </p>
          <nav aria-label="Peças" className="mt-8 flex flex-wrap gap-2">
            {pieces.map((p) => (
              <button
                key={p.id}
                type="button"
                onClick={() => document.getElementById(p.id)?.scrollIntoView({ behavior: 'smooth', block: 'start' })}
                className="rounded-full border border-brand-mist bg-white px-4 py-2 text-sm font-semibold text-brand-ink transition-colors hover:border-brand-purple hover:text-brand-purple"
              >
                {p.title}
              </button>
            ))}
          </nav>
        </div>
      </Section>

      {pieces.map((p, i) => {
        const take = takes[p.id] ?? 0
        return (
          <Section key={p.id} id={p.id} tone={i % 2 ? 'off' : 'white'} className="scroll-mt-[var(--nav-h)] py-14 sm:py-16 lg:py-20" aria-labelledby={`${p.id}-title`}>
            <div className="container">
              <div className="flex flex-wrap items-end justify-between gap-4">
                  <div className="max-w-2xl">
                    <p className="text-sm font-bold uppercase tracking-[0.14em] text-brand-plum">
                      Peça {i + 1} · {formatSeconds(p.ms)}
                    </p>
                    <h2 id={`${p.id}-title`} className="mt-2 text-2xl font-extrabold tracking-tight text-brand-ink sm:text-3xl">
                      {p.title}
                    </h2>
                    <p className="mt-2 text-base text-brand-graphite sm:text-lg">{p.text}</p>
                  </div>
                  <Button type="button" variant="secondary" onClick={() => replay(p.id)}>
                    <RotateCcw />
                    Repetir
                  </Button>
                </div>
              <div className="mt-8 grid gap-4 lg:grid-cols-2">
                <Panel data-motion={`${p.id}-light`}>
                  <p.Component key={`${p.id}-light-${take}`} tone="gradient" className={p.width} />
                </Panel>
                <Panel dark data-motion={`${p.id}-dark`}>
                  <p.Component key={`${p.id}-dark-${take}`} tone="white" className={p.width} />
                </Panel>
              </div>
            </div>
          </Section>
        )
      })}
    </PageTransition>
  )
}

function Panel({ dark = false, className, children, ...rest }: { dark?: boolean; children: ReactNode } & HTMLAttributes<HTMLDivElement>) {
  return (
    <div
      className={cn(
        'flex min-h-[300px] items-center justify-center overflow-hidden rounded-3xl border px-6 py-12 sm:min-h-[360px]',
        dark ? 'on-dark border-brand-blue bg-brand-blue' : 'border-brand-mist bg-white',
        className,
      )}
      {...rest}
    >
      {children}
    </div>
  )
}
