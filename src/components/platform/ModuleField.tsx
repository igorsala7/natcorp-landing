import { useEffect, useMemo, useState } from 'react'
import { AnimatePresence, m, useInView, useReducedMotion } from 'motion/react'
import type { Variants } from 'motion/react'
import { Link } from 'react-router'
import { useNodeRects, type NodeRect } from '@/components/journey/useNodeRects'
import { getGroup, groups, modulePath, moduleRegistry, modulesByGroup, type GroupMeta, type ModuleEntry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import type { GroupId } from '@/content/modulePages/types'
import { categoryMeta, type StageSide } from '@/content/moduleCategories'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { BaseLabel, ModuleCore } from './ModuleCore'

/**
 * O palco dos módulos (desktop): os 31 módulos em volta de uma única base de dados,
 * agrupados por frente, cada um ligado ao centro por uma linha. Um foco percorre os
 * módulos um a um (ou segue o mouse) e acende a frente inteira; a legenda sob a base
 * diz o que o módulo faz. Decorativo: os cartões das frentes, logo abaixo, são a versão
 * acessível com os mesmos links.
 */

const CYCLE_MS = 2600
const CORE_SIZE = 220
const N = moduleRegistry.length
const CORE_INDEX = N

const indexOf = new Map(moduleRegistry.map((mod, i) => [mod.slug, i]))
const sideOf = (id: GroupId) => categoryMeta[id].side
const leftGroups = groups.filter((g) => sideOf(g.id) === 'left')
const rightGroups = groups.filter((g) => sideOf(g.id) === 'right')
const topGroups = groups.filter((g) => sideOf(g.id) === 'top')

/* ---------------- Variações de entrada ---------------- */

const chipVariants: Variants = {
  hidden: ({ side }: { i: number; side: StageSide }) => ({
    opacity: 0,
    x: side === 'left' ? -32 : side === 'right' ? 32 : 0,
    y: side === 'top' ? -24 : 0,
  }),
  visible: ({ i }: { i: number; side: StageSide }) => ({
    opacity: 1,
    x: 0,
    y: 0,
    transition: { duration: 0.8, ease: EASE, delay: 0.2 + i * 0.03 },
  }),
}

const labelVariants: Variants = {
  hidden: { opacity: 0, y: 6 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.6, ease: EASE, delay: 0.15 } },
}

const coreVariants: Variants = {
  hidden: { opacity: 0, scale: 0.78 },
  visible: { opacity: 1, scale: 1, transition: { duration: 1, ease: EASE, delay: 0.05 } },
}

const captionVariants: Variants = {
  hidden: { opacity: 0, y: 10 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.6, ease: EASE, delay: 0.9 } },
}

const lineVariants: Variants = {
  hidden: { pathLength: 0, opacity: 0 },
  visible: (i: number) => ({
    pathLength: 1,
    opacity: 1,
    transition: { pathLength: { duration: 0.9, ease: EASE, delay: 0.35 + i * 0.028 }, opacity: { duration: 0.3, delay: 0.35 + i * 0.028 } },
  }),
}

/* ---------------- Geometria das ligações ---------------- */

interface Connection {
  d: string
  from: { x: number; y: number }
  to: { x: number; y: number }
}

function connection(rect: NodeRect, side: StageSide, cx: number, cy: number, radius: number): Connection {
  const from =
    side === 'left'
      ? { x: rect.x + rect.w, y: rect.y + rect.h / 2 }
      : side === 'right'
        ? { x: rect.x, y: rect.y + rect.h / 2 }
        : { x: rect.x + rect.w / 2, y: rect.y + rect.h }
  const angle = Math.atan2(from.y - cy, from.x - cx)
  const to = { x: cx + radius * Math.cos(angle), y: cy + radius * Math.sin(angle) }
  const d =
    side === 'top'
      ? `M ${from.x} ${from.y} C ${from.x} ${from.y + (to.y - from.y) * 0.55}, ${to.x} ${to.y - (to.y - from.y) * 0.55}, ${to.x} ${to.y}`
      : `M ${from.x} ${from.y} C ${from.x + (to.x - from.x) * 0.5} ${from.y}, ${to.x - (to.x - from.x) * 0.5} ${to.y}, ${to.x} ${to.y}`
  return { d, from, to }
}

/* ---------------- Peças ---------------- */

interface ChipProps {
  mod: ModuleEntry
  index: number
  side: StageSide
  state: 'idle' | 'sibling' | 'active'
  onEnter: (i: number) => void
  setRef: (el: HTMLElement | null) => void
}

function Chip({ mod, index, side, state, onEnter, setRef }: ChipProps) {
  const Icon = moduleIcons[mod.icon]
  const active = state === 'active'
  const sibling = state === 'sibling'
  return (
    <m.span ref={setRef} variants={chipVariants} custom={{ i: index, side }} className="inline-flex max-w-full">
      <Link
        to={modulePath(mod.slug)}
        tabIndex={-1}
        onPointerEnter={() => onEnter(index)}
        onFocus={() => onEnter(index)}
        className={cn(
          'relative inline-flex h-9 max-w-full items-center gap-2 overflow-hidden rounded-lg border px-2.5 text-[12.5px] font-semibold leading-none transition-[border-color,color,transform,box-shadow] duration-300 ease-brand',
          active
            ? '-translate-y-0.5 border-transparent text-white shadow-[0_12px_24px_-10px_rgba(81,28,118,0.6)]'
            : sibling
              ? 'border-brand-purple/35 bg-brand-purple/[0.06] text-brand-purple'
              : 'border-brand-mist bg-white text-brand-ink hover:border-brand-purple/40',
        )}
      >
        <span aria-hidden className={cn('absolute inset-0 bg-brand-gradient transition-opacity duration-300', active ? 'opacity-100' : 'opacity-0')} />
        <Icon className={cn('relative h-3.5 w-3.5 shrink-0', active ? 'text-white' : 'text-brand-purple')} strokeWidth={1.8} aria-hidden />
        <span className="relative truncate">{mod.name}</span>
      </Link>
    </m.span>
  )
}

interface ClusterProps {
  group: GroupMeta
  align: 'start' | 'end' | 'center'
  activeGroup: GroupId | null
  activeIndex: number | null
  onEnter: (i: number) => void
  setNodeRef: (i: number) => (el: HTMLElement | null) => void
}

function Cluster({ group, align, activeGroup, activeIndex, onEnter, setNodeRef }: ClusterProps) {
  const mods = modulesByGroup(group.id)
  const Icon = moduleIcons[categoryMeta[group.id].icon]
  const side = sideOf(group.id)
  const lit = activeGroup === group.id
  return (
    <div className={cn('flex flex-col gap-2.5', align === 'end' && 'items-end', align === 'center' && 'items-center')}>
      <m.p
        variants={labelVariants}
        className={cn(
          'flex items-center gap-1.5 text-[10.5px] font-bold uppercase tracking-[0.14em] transition-colors duration-300',
          lit ? 'text-brand-purple' : 'text-brand-graphite',
        )}
      >
        <Icon className="h-3.5 w-3.5" strokeWidth={1.9} aria-hidden />
        {group.name}
        <span className={cn('font-semibold tabular', lit ? 'text-brand-purple/70' : 'text-brand-graphite/60')}>{mods.length}</span>
      </m.p>
      <div className={cn('flex max-w-full flex-wrap gap-2', align === 'end' && 'justify-end', align === 'center' && 'justify-center')}>
        {mods.map((mod) => {
          const i = indexOf.get(mod.slug)!
          return (
            <Chip
              key={mod.slug}
              mod={mod}
              index={i}
              side={side}
              state={activeIndex === i ? 'active' : lit ? 'sibling' : 'idle'}
              onEnter={onEnter}
              setRef={setNodeRef(i)}
            />
          )
        })}
      </div>
    </div>
  )
}

function Caption({ mod, cycling }: { mod: ModuleEntry | null; cycling: boolean }) {
  const Icon = mod ? moduleIcons[mod.icon] : moduleIcons.database
  const group = mod ? getGroup(mod.group) : null
  return (
    <m.div variants={captionVariants} className="relative w-full max-w-[300px] overflow-hidden rounded-2xl border border-brand-mist bg-white/90 p-3.5 shadow-soft backdrop-blur-sm">
      <AnimatePresence mode="wait" initial={false}>
        <m.div key={mod?.slug ?? 'base'} initial={{ opacity: 0, y: 6 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -4 }} transition={{ duration: 0.3, ease: EASE }}>
          <div className="flex items-center gap-2.5">
            <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-brand-gradient text-white">
              <Icon className="h-4 w-4" strokeWidth={1.8} aria-hidden />
            </span>
            <div className="min-w-0">
              <p className="truncate text-[10.5px] font-bold uppercase tracking-[0.14em] text-brand-purple">{group ? group.name : 'Uma base de dados'}</p>
              <p className="truncate text-[14px] font-extrabold leading-tight text-brand-ink">{mod ? mod.name : `${N} módulos, um só cadastro`}</p>
            </div>
          </div>
          <p className="mt-2 min-h-[34px] text-[12.5px] leading-snug text-brand-graphite">
            {mod ? mod.short : 'Cada módulo lê e escreve na mesma base. Nada é digitado duas vezes.'}
          </p>
        </m.div>
      </AnimatePresence>
      {cycling && mod && (
        <m.span
          key={mod.slug}
          aria-hidden
          className="absolute bottom-0 left-0 h-[2px] w-full origin-left bg-gradient-to-r from-brand-pink to-brand-purple"
          initial={{ scaleX: 0 }}
          animate={{ scaleX: 1 }}
          transition={{ duration: CYCLE_MS / 1000, ease: 'linear' }}
        />
      )}
    </m.div>
  )
}

/* ---------------- Palco ---------------- */

export function ModuleField({ className }: { className?: string }) {
  const reduced = useReducedMotion() ?? false
  const { containerRef, setNodeRef, rects } = useNodeRects<HTMLElement>(N + 1)
  /**
   * A entrada é dirigida por `animate` (e não por `whileInView`): o AnimatePresence das rotas
   * tem `initial={false}`, o que bloqueia o estado inicial dos filhos na primeira página carregada.
   */
  const entered = useInView(containerRef, { once: true, margin: '0px 0px -12% 0px' })
  const inView = useInView(containerRef, { amount: 0.3 })

  const [active, setActive] = useState(0)
  const [hovering, setHovering] = useState(false)
  /** O foco só começa a andar depois que o palco terminou de se montar. */
  const [ready, setReady] = useState(false)

  useEffect(() => {
    if (ready || !entered) return
    const t = window.setTimeout(() => setReady(true), reduced ? 0 : 1500)
    return () => window.clearTimeout(t)
  }, [entered, ready, reduced])

  const cycling = ready && inView && !hovering && !reduced
  useEffect(() => {
    if (!cycling) return
    const id = window.setInterval(() => setActive((a) => (a + 1) % N), CYCLE_MS)
    return () => window.clearInterval(id)
  }, [cycling])

  const spot = ready || reduced ? active : null
  const activeMod = spot === null ? null : moduleRegistry[spot]
  const activeGroup = activeMod?.group ?? null

  const links = useMemo(() => {
    const core = rects[CORE_INDEX]
    if (!core) return null
    const cx = core.x + core.w / 2
    const cy = core.y + core.h / 2
    const radius = core.w / 2 + 5
    return moduleRegistry.map((mod, i) => {
      const r = rects[i]
      return r ? connection(r, sideOf(mod.group), cx, cy, radius) : null
    })
  }, [rects])

  const activeLink = spot !== null && links ? links[spot] : null
  const clusterProps = { activeGroup, activeIndex: spot, onEnter: setActive, setNodeRef }

  return (
    <m.div
      ref={containerRef}
      aria-hidden
      className={cn('relative overflow-hidden rounded-[2rem] border border-brand-mist bg-white shadow-soft', className)}
      initial={reduced ? false : 'hidden'}
      animate={reduced || entered ? 'visible' : 'hidden'}
      onPointerEnter={() => setHovering(true)}
      onPointerLeave={() => setHovering(false)}
    >
      {/* fundo: grade a 45° que se dissolve nas bordas e um brilho atrás da base */}
      <div className="pointer-events-none absolute inset-0 bg-grid-45 opacity-80 [background-size:28px_28px] [mask-image:radial-gradient(70%_75%_at_50%_50%,#000_30%,transparent_100%)]" />
      <div className="pointer-events-none absolute left-1/2 top-1/2 h-[560px] w-[560px] -translate-x-1/2 -translate-y-1/2 rounded-full bg-[radial-gradient(circle,rgba(154,64,138,0.14),transparent_62%)] blur-2xl" />

      {/* ligações: uma por módulo, todas chegando à base */}
      <svg className="pointer-events-none absolute inset-0 h-full w-full overflow-visible" focusable="false">
        <defs>
          {activeLink && (
            <linearGradient id="pf-active" gradientUnits="userSpaceOnUse" x1={activeLink.from.x} y1={activeLink.from.y} x2={activeLink.to.x} y2={activeLink.to.y}>
              <stop offset="0" stopColor="#C95788" />
              <stop offset="1" stopColor="#511C76" />
            </linearGradient>
          )}
        </defs>
        {links?.map((link, i) => {
          if (!link) return null
          const lit = activeGroup === moduleRegistry[i].group
          return (
            <m.path
              key={moduleRegistry[i].slug}
              d={link.d}
              fill="none"
              stroke="#511C76"
              strokeWidth={1.25}
              strokeLinecap="round"
              className="transition-[stroke-opacity] duration-500"
              style={{ strokeOpacity: lit ? 0.42 : 0.13 }}
              variants={lineVariants}
              custom={i}
            />
          )
        })}
        {activeLink && (
          <m.path
            key={`hl-${spot}`}
            d={activeLink.d}
            fill="none"
            stroke="url(#pf-active)"
            strokeWidth={2.25}
            strokeLinecap="round"
            initial={reduced ? false : { pathLength: 0, opacity: 0 }}
            animate={{ pathLength: 1, opacity: 1 }}
            transition={{ duration: 0.65, ease: EASE }}
          />
        )}
        {activeLink && !reduced && (
          <g key={`pulse-${spot}`}>
            <circle r="7" fill="#C95788" opacity="0.22">
              <animateMotion dur="1.5s" begin="0.3s" repeatCount="indefinite" path={activeLink.d} />
            </circle>
            <circle r="3.2" fill="#C95788">
              <animateMotion dur="1.5s" begin="0.3s" repeatCount="indefinite" path={activeLink.d} />
            </circle>
          </g>
        )}
      </svg>

      <div className="relative grid grid-cols-[minmax(0,1fr)_minmax(0,1.1fr)_minmax(0,1fr)] items-center gap-x-6 px-6 py-8 xl:gap-x-10 xl:px-10 xl:py-10">
        <div className="flex flex-col items-end gap-7">
          {leftGroups.map((g) => (
            <Cluster key={g.id} group={g} align="end" {...clusterProps} />
          ))}
        </div>

        <div className="flex flex-col items-center gap-7">
          {topGroups.map((g) => (
            <Cluster key={g.id} group={g} align="center" {...clusterProps} />
          ))}
          <m.div variants={coreVariants} className="flex flex-col items-center">
            <ModuleCore ref={setNodeRef(CORE_INDEX)} size={CORE_SIZE} reduced={reduced} />
            <BaseLabel className="-mt-1" />
          </m.div>
          <Caption mod={activeMod} cycling={cycling} />
        </div>

        <div className="flex flex-col items-start gap-7">
          {rightGroups.map((g) => (
            <Cluster key={g.id} group={g} align="start" {...clusterProps} />
          ))}
        </div>
      </div>
    </m.div>
  )
}
