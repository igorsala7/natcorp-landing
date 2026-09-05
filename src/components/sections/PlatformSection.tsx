import { useEffect, useRef, useState } from 'react'
import type { KeyboardEvent } from 'react'
import { m, useReducedMotion } from 'motion/react'
import { ArrowRight, ChevronRight } from 'lucide-react'
import { Link } from 'react-router'
import { Button } from '@/components/ui/button'
import { Reveal } from '@/components/motion/Reveal'
import { BrandGradient } from '@/components/brand/Logo'
import { MODULES, SYMBOL_BOX } from '@/components/brand/logo-paths'
import { useBrandGradientId } from '@/hooks/useBrandGradientId'
import { getGroup, modulePath, modulesByGroup } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import type { GroupId } from '@/content/modulePages/types'
import { paths } from '@/content/site'
import { EASE, viewportOnce } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { Eyebrow, Section } from './Section'

/* Os três pilares, agora como uma linha compacta de apoio ao lado do título. */
const pillars = [
  { title: 'Um cadastro', text: 'O colaborador entra uma vez e já existe na folha, no ponto, nos benefícios e no SESMT.' },
  { title: 'Uma base', text: 'O mesmo dado em todos os módulos, sem exportar nada para cruzar folha, frequência, saúde e talentos.' },
  { title: 'Uma experiência', text: 'Portais por perfil, no celular ou no computador, com a mesma linguagem para gestor, colaborador e candidato.' },
]

interface Area {
  id: string
  name: string
  /** Uma frase, uma linha: o que a área resolve. */
  line: string
  groups: GroupId[]
}

/** Uma área por módulo do símbolo, na mesma ordem de MODULES: topo, direita, esquerda, base. */
const areas: Area[] = [
  {
    id: 'dp',
    name: 'Departamento Pessoal',
    line: 'Folha, ponto, benefícios e eSocial fechando o mês sobre o mesmo cadastro, sem redigitar nada.',
    groups: ['pessoal-e-folha', 'ponto-e-jornada'],
  },
  {
    id: 'sst',
    name: 'Medicina e Segurança do Trabalho',
    line: 'O SESMT dentro do sistema de RH: exames, riscos e eventos de SST saem sem retrabalho.',
    groups: ['saude-e-seguranca'],
  },
  {
    id: 'rh',
    name: 'Recursos Humanos',
    line: 'Da vaga à sucessão em um fluxo só, com portais para gestor, colaborador e candidato.',
    groups: ['talentos', 'desenvolvimento', 'autoatendimento'],
  },
  {
    id: 'dados',
    name: 'Dados, IA e Plataforma',
    line: 'Painéis, relatórios e a NATI lendo todos os módulos, em nuvem segura e com APIs prontas.',
    groups: ['dados-ia-plataforma'],
  },
]

/* Direção de entrada de cada módulo (topo, direita, esquerda, base) na grade a 45°. */
const offsets = [
  { x: 0, y: -2.2 },
  { x: 2.2, y: 0 },
  { x: -2.2, y: 0 },
  { x: 0, y: 2.2 },
]

const CYCLE_MS = 3500
const MIST = '#E9E5F1'
const PINK = '#C95788'
const fillTransition = { duration: 0.5, ease: EASE }

export function PlatformSection() {
  const gradId = useBrandGradientId()
  const glowId = `${gradId}-glow`
  const reduced = useReducedMotion()

  const [active, setActive] = useState(0)
  /** Primeira interação do usuário (hover, clique ou foco): o ciclo automático para de vez. */
  const [paused, setPaused] = useState(false)
  const [inView, setInView] = useState(false)
  const tabRefs = useRef<(HTMLButtonElement | null)[]>([])

  const area = areas[active]
  const moduleCount = area.groups.reduce((n, g) => n + modulesByGroup(g).length, 0)

  useEffect(() => {
    if (paused || reduced || !inView) return
    const id = window.setInterval(() => setActive((a) => (a + 1) % areas.length), CYCLE_MS)
    return () => window.clearInterval(id)
  }, [paused, reduced, inView])

  const pick = (i: number) => {
    setPaused(true)
    setActive(i)
  }

  const onKeyDown = (e: KeyboardEvent<HTMLDivElement>) => {
    const last = areas.length - 1
    const next =
      e.key === 'ArrowRight'
        ? (active + 1) % areas.length
        : e.key === 'ArrowLeft'
          ? (active + last) % areas.length
          : e.key === 'Home'
            ? 0
            : e.key === 'End'
              ? last
              : null
    if (next === null) return
    e.preventDefault()
    pick(next)
    tabRefs.current[next]?.focus()
  }

  return (
    <Section id="plataforma" tone="off" aria-labelledby="plataforma-title">
      <div className="container">
        {/* Abertura: rótulo + frase à esquerda; os três pilares em texto corrido à direita. */}
        <div className="grid gap-8 lg:grid-cols-[minmax(0,1fr)_minmax(0,26rem)] lg:items-end lg:gap-16">
          <div>
            <Reveal y={12} duration={0.5}>
              <Eyebrow>A plataforma</Eyebrow>
            </Reveal>
            <Reveal delay={0.1} y={16}>
              <h2 id="plataforma-title" className="mt-5 text-3xl font-extrabold leading-[1.1] tracking-brand text-brand-ink sm:text-4xl">
                Um sistema. Uma base. <span className="text-brand-purple">Uma experiência.</span>
              </h2>
            </Reveal>
          </div>
          <Reveal delay={0.2} y={16}>
            <ul className="space-y-2 text-sm leading-snug text-brand-graphite lg:pb-1" aria-label="Os três pilares da plataforma">
              {pillars.map((p) => (
                <li key={p.title} className="flex gap-2.5">
                  <span aria-hidden className="mt-[7px] h-1.5 w-1.5 shrink-0 rotate-45 bg-brand-purple/60" />
                  <span>
                    <strong className="font-bold text-brand-ink">{p.title}.</strong> {p.text}
                  </span>
                </li>
              ))}
            </ul>
          </Reveal>
        </div>

        {/* Palco: símbolo interativo + abas à esquerda, painel da área à direita. */}
        <m.div
          className="mt-12 grid items-start gap-10 lg:mt-16 lg:grid-cols-[minmax(0,1.15fr)_minmax(0,1fr)] lg:gap-14"
          onViewportEnter={() => setInView(true)}
          onViewportLeave={() => setInView(false)}
          viewport={{ amount: 0.3 }}
        >
          <div className="min-w-0">
            <div className="relative mx-auto w-full max-w-[560px] px-6 sm:px-8">
              <m.div
                aria-hidden
                className="absolute inset-[14%] rounded-full bg-[radial-gradient(circle,rgba(154,64,138,0.2),transparent_65%)] blur-2xl"
                animate={reduced ? undefined : { scale: [1, 1.08, 1] }}
                transition={{ duration: 7, repeat: Infinity, ease: 'easeInOut' }}
              />
              <m.svg
                viewBox={`0 0 ${SYMBOL_BOX} ${SYMBOL_BOX}`}
                className="relative block w-full overflow-visible"
                aria-hidden
                focusable="false"
                initial="hidden"
                whileInView="visible"
                viewport={viewportOnce}
              >
                <defs>
                  <BrandGradient id={gradId} />
                  <filter id={glowId} x="-50%" y="-50%" width="200%" height="200%">
                    <feGaussianBlur stdDeviation="0.32" />
                  </filter>
                </defs>
                {MODULES.map((d, i) => {
                  const on = i === active
                  return (
                    <m.g
                      key={i}
                      variants={{
                        hidden: { opacity: 0, x: offsets[i].x, y: offsets[i].y },
                        visible: { opacity: 1, x: 0, y: 0, transition: { duration: 1.1, ease: EASE, delay: 0.15 + i * 0.1 } },
                      }}
                    >
                      {/* brilho rosa por baixo do módulo ativo */}
                      <g filter={`url(#${glowId})`} transform="translate(0 0.14)">
                        <m.path d={d} fill={PINK} initial={false} animate={{ opacity: on ? 0.42 : 0 }} transition={fillTransition} />
                      </g>
                      {/* névoa com traço sutil: o estado de repouso */}
                      <path d={d} fill={MIST} stroke="#511C76" strokeOpacity={0.14} strokeWidth={1} vectorEffect="non-scaling-stroke" />
                      {/* gradiente da marca: aparece por cima quando a área está ativa */}
                      <m.path d={d} fill={`url(#${gradId})`} initial={false} animate={{ opacity: on ? 1 : 0 }} transition={fillTransition} />
                      {/* alvo transparente do mouse; a interação acessível fica nas abas abaixo */}
                      <path
                        d={d}
                        fill="transparent"
                        pointerEvents="all"
                        className="cursor-pointer"
                        onPointerEnter={(e) => {
                          if (e.pointerType === 'mouse') pick(i)
                        }}
                        onClick={() => pick(i)}
                      />
                    </m.g>
                  )
                })}
              </m.svg>
            </div>

            {/* Barra das quatro áreas: um losango colorido marca a ativa. */}
            <Reveal delay={0.5} y={10} duration={0.5}>
              <div
                role="tablist"
                aria-label="Áreas do sistema"
                onKeyDown={onKeyDown}
                onPointerEnter={(e) => {
                  if (e.pointerType === 'mouse') setPaused(true)
                }}
                className="mt-8 flex flex-wrap justify-center gap-x-1 gap-y-1 sm:gap-x-2"
              >
                {areas.map((a, i) => {
                  const selected = i === active
                  return (
                    <button
                      key={a.id}
                      ref={(el) => {
                        tabRefs.current[i] = el
                      }}
                      id={`plataforma-tab-${a.id}`}
                      type="button"
                      role="tab"
                      aria-selected={selected}
                      aria-controls="plataforma-panel"
                      tabIndex={selected ? 0 : -1}
                      onClick={() => pick(i)}
                      onFocus={() => setPaused(true)}
                      className={cn(
                        'group/tab inline-flex items-center gap-2.5 rounded-lg px-3 py-2 text-sm font-semibold transition-colors duration-300 ease-brand focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple focus-visible:ring-offset-2 focus-visible:ring-offset-brand-off-white',
                        selected ? 'text-brand-ink' : 'text-brand-graphite hover:text-brand-ink',
                      )}
                    >
                      <span
                        aria-hidden
                        className={cn(
                          'h-2 w-2 shrink-0 rotate-45 rounded-[1px] transition-[background-color,box-shadow,transform] duration-300 ease-brand',
                          selected
                            ? 'scale-110 bg-brand-gradient shadow-[0_0_0_3px_rgba(201,87,136,0.18)]'
                            : 'bg-brand-mist ring-1 ring-brand-purple/15 group-hover/tab:bg-brand-purple/30',
                        )}
                      />
                      {a.name}
                    </button>
                  )
                })}
              </div>
            </Reveal>
          </div>

          {/* Painel da área ativa: a única moldura da seção. */}
          <Reveal delay={0.3} className="min-w-0">
            <div
              id="plataforma-panel"
              role="tabpanel"
              aria-labelledby={`plataforma-tab-${area.id}`}
              className="rounded-2xl border border-brand-mist bg-white p-6 shadow-soft sm:p-7"
            >
              <m.div key={active} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.4, ease: EASE }}>
                <div className="flex flex-wrap items-baseline justify-between gap-x-4 gap-y-1">
                  <h3 className="text-xl font-extrabold tracking-brand text-brand-ink sm:text-2xl">{area.name}</h3>
                  <span className="text-[13px] font-semibold text-brand-graphite">
                    {moduleCount} {moduleCount === 1 ? 'módulo' : 'módulos'}
                  </span>
                </div>
                <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{area.line}</p>

                <div className="mt-4 space-y-3">
                  {area.groups.map((gid) => {
                    const group = getGroup(gid)
                    return (
                      <div key={gid}>
                        {area.groups.length > 1 && (
                          <p className="mb-0.5 mt-2 text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">{group.name}</p>
                        )}
                        <ul className="grid gap-x-5 sm:grid-cols-2" aria-label={`Módulos de ${group.name}`}>
                          {modulesByGroup(gid).map((mod) => {
                            const Icon = moduleIcons[mod.icon]
                            return (
                              <li key={mod.slug}>
                                <Link
                                  to={modulePath(mod.slug)}
                                  className="group -mx-2 flex items-start gap-3 rounded-lg px-2 py-2 transition-colors duration-300 ease-brand hover:bg-brand-off-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple"
                                >
                                  <span className="mt-0.5 flex h-8 w-8 shrink-0 items-center justify-center rounded-md bg-brand-off-white text-brand-purple transition-colors duration-300 group-hover:bg-brand-purple group-hover:text-white">
                                    <Icon className="h-4 w-4" strokeWidth={1.6} aria-hidden />
                                  </span>
                                  <span className="min-w-0 flex-1">
                                    <span className="flex items-center gap-1 text-[14px] font-bold text-brand-ink transition-colors duration-300 group-hover:text-brand-purple">
                                      {mod.name}
                                      <ChevronRight className="h-3.5 w-3.5 shrink-0 text-brand-gray transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                                    </span>
                                    <span className="block text-[12.5px] leading-snug text-brand-graphite">{mod.short}</span>
                                  </span>
                                </Link>
                              </li>
                            )
                          })}
                        </ul>
                      </div>
                    )
                  })}
                </div>

                <Link
                  to={paths.modules}
                  className="mt-5 inline-flex items-center gap-1.5 text-sm font-semibold text-brand-purple underline-offset-4 hover:underline"
                >
                  Ver todos os módulos
                  <ArrowRight className="h-4 w-4" aria-hidden />
                </Link>
              </m.div>
            </div>
          </Reveal>
        </m.div>

        <Reveal delay={0.2} className="mt-12 flex flex-wrap gap-3 lg:mt-14">
          <Button asChild size="lg">
            <Link to={paths.modules}>
              Ver os 31 módulos
              <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
            </Link>
          </Button>
          <Button asChild size="lg" variant="secondary">
            <Link to={paths.portals}>Portais e autoatendimento</Link>
          </Button>
        </Reveal>
      </div>
    </Section>
  )
}
