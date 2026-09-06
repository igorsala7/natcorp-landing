import { ArrowRight } from 'lucide-react'
import { Link } from 'react-router'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { LogoOutline } from '@/components/brand/Logo'
import { Stagger, StaggerItem } from '@/components/motion/Reveal'
import { moduleGroups } from '@/content/modules'
import { groups, modulePath, modulesByGroup, type GroupMeta } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import { categoryMeta, dataFrontNote, natiNote } from '@/content/moduleCategories'
import { paths } from '@/content/site'
import { cn } from '@/lib/utils'

/**
 * As sete frentes em cartões: ícone, nome, tagline, os módulos como chips (cada um com a sua página)
 * e o cartão inteiro levando à frente na página de módulos. "Dados, IA e Plataforma" fecha a grade
 * como cartão largo e escuro, com a NATI.
 */

const FEATURED: GroupMeta['id'] = 'dados-ia-plataforma'

const countLabel = (n: number) => `${n} ${n === 1 ? 'módulo' : 'módulos'}`

/** Duas frases sobre a frente, do agrupamento oficial (src/content/modules.ts). */
const descriptionOf = new Map(moduleGroups.map((g) => [g.id, g.description]))

/** Foco visível do link que cobre o cartão: o anel vai para o cartão inteiro. */
const ringOnStretch = 'has-[.stretch:focus-visible]:ring-2 has-[.stretch:focus-visible]:ring-offset-2 has-[.stretch:focus-visible]:ring-offset-brand-off-white'

function CategoryCard({ group }: { group: GroupMeta }) {
  const mods = modulesByGroup(group.id)
  const Icon = moduleIcons[categoryMeta[group.id].icon]
  return (
    <article
      className={cn(
        'group/card relative flex h-full flex-col rounded-2xl border border-brand-mist bg-white p-6 shadow-soft transition-[transform,box-shadow] duration-500 ease-brand hover:-translate-y-1 hover:shadow-lift',
        ringOnStretch,
        'has-[.stretch:focus-visible]:ring-brand-purple',
      )}
    >
      {/* borda no gradiente da marca, só no hover: uma camada de gradiente atrás de uma camada branca 1 px menor */}
      <span
        aria-hidden
        className="pointer-events-none absolute -inset-px rounded-2xl bg-brand-gradient opacity-0 transition-opacity duration-500 group-hover/card:opacity-100"
      />
      <span aria-hidden className="pointer-events-none absolute inset-0 rounded-[15px] bg-white" />
      <div className="relative flex h-full flex-col">
        <div className="flex items-start justify-between gap-4">
          <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple transition-colors duration-300 group-hover/card:bg-brand-purple group-hover/card:text-white">
            <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
          </span>
          <span className="rounded-full border border-brand-mist px-2.5 py-1 text-[11.5px] font-semibold tabular text-brand-graphite">{countLabel(mods.length)}</span>
        </div>
        <h3 className="mt-5 text-[19px] font-extrabold leading-snug text-brand-ink">{group.name}</h3>
        <p className="mt-1 text-[14.5px] font-semibold leading-snug text-brand-purple">{group.tagline}</p>
        {descriptionOf.has(group.id) && <p className="mt-2.5 text-[14px] leading-relaxed text-brand-graphite">{descriptionOf.get(group.id)}</p>}
        <ul className="relative z-10 mt-4 flex flex-wrap gap-1.5" aria-label={`Módulos de ${group.name}`}>
          {mods.map((mod) => {
            const ModIcon = moduleIcons[mod.icon]
            return (
              <li key={mod.slug}>
                <Link
                  to={modulePath(mod.slug)}
                  className="inline-flex items-center gap-1.5 rounded-md border border-brand-mist bg-white px-2 py-1 text-[12px] font-semibold text-brand-ink transition-colors duration-300 hover:border-brand-purple/40 hover:bg-brand-off-white hover:text-brand-purple focus-visible:outline-offset-0"
                >
                  <ModIcon className="h-3 w-3 text-brand-purple" strokeWidth={1.8} aria-hidden />
                  {mod.name}
                </Link>
              </li>
            )
          })}
        </ul>
        <div className="mt-auto pt-5">
          <Link
            to={`${paths.modules}#${group.id}`}
            aria-label={`Ver a frente ${group.name} na página de módulos`}
            className="stretch inline-flex items-center gap-1.5 text-[13.5px] font-semibold text-brand-purple after:absolute after:inset-0 after:rounded-2xl focus-visible:outline-none"
          >
            Ver a frente
            <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover/card:translate-x-0.5" aria-hidden />
          </Link>
        </div>
      </div>
    </article>
  )
}

function FeaturedCard({ group }: { group: GroupMeta }) {
  const mods = modulesByGroup(group.id)
  const Icon = moduleIcons[categoryMeta[group.id].icon]
  return (
    <article
      className={cn(
        'on-dark group/card relative flex h-full flex-col overflow-hidden rounded-2xl bg-brand-ink p-6 text-white shadow-lift transition-transform duration-500 ease-brand hover:-translate-y-1 sm:p-8 lg:flex-row lg:items-center lg:gap-12',
        ringOnStretch,
        'has-[.stretch:focus-visible]:ring-white',
      )}
    >
      <div className="pointer-events-none absolute inset-0" aria-hidden>
        <div className="absolute inset-0 bg-[radial-gradient(60%_80%_at_85%_20%,rgba(154,64,138,0.55),transparent_65%)]" />
        <div className="absolute inset-0 bg-[radial-gradient(45%_60%_at_5%_100%,rgba(201,87,136,0.22),transparent_70%)]" />
        <LogoOutline className="absolute -right-[6%] -top-[70%] h-[220%] w-auto text-white/[0.08]" />
      </div>

      <div className="relative min-w-0 flex-1">
        <div className="flex items-start justify-between gap-4">
          <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-white/10 text-[#E4A9C4] ring-1 ring-white/15">
            <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
          </span>
          <span className="rounded-full border border-white/20 px-2.5 py-1 text-[11.5px] font-semibold tabular text-white/80">{countLabel(mods.length)}</span>
        </div>
        <h3 className="mt-5 text-[22px] font-extrabold leading-snug sm:text-2xl">{group.name}</h3>
        <p className="mt-1.5 text-[15px] font-semibold text-[#E4A9C4]">{group.tagline}</p>
        <p className="mt-3 max-w-xl text-[14.5px] leading-relaxed text-white/80">{dataFrontNote}</p>
        <ul className="relative z-10 mt-5 flex flex-wrap gap-1.5" aria-label={`Módulos de ${group.name}`}>
          {mods.map((mod) => {
            const ModIcon = moduleIcons[mod.icon]
            return (
              <li key={mod.slug}>
                <Link
                  to={modulePath(mod.slug)}
                  className="inline-flex items-center gap-1.5 rounded-md border border-white/20 bg-white/[0.06] px-2 py-1 text-[12px] font-semibold text-white transition-colors duration-300 hover:border-white/40 hover:bg-white/15 focus-visible:outline-offset-0"
                >
                  <ModIcon className="h-3 w-3 text-[#E4A9C4]" strokeWidth={1.8} aria-hidden />
                  {mod.name}
                </Link>
              </li>
            )
          })}
        </ul>
        <div className="mt-6">
          <Link
            to={`${paths.modules}#${group.id}`}
            aria-label={`Ver a frente ${group.name} na página de módulos`}
            className="stretch inline-flex items-center gap-1.5 text-[13.5px] font-semibold text-white after:absolute after:inset-0 after:rounded-2xl focus-visible:outline-none"
          >
            Ver a frente
            <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover/card:translate-x-0.5" aria-hidden />
          </Link>
        </div>
      </div>

      {/* A NATI, que lê tudo isso */}
      <div className="relative z-10 mt-7 flex items-center gap-4 rounded-2xl border border-white/15 bg-white/[0.07] p-4 backdrop-blur-sm lg:mt-0 lg:w-[340px] lg:shrink-0 lg:p-5">
        <span className="relative shrink-0">
          <span className="absolute inset-[-6px] animate-pulse-soft rounded-full bg-[#C95788]/30 blur-md" aria-hidden />
          <NatiAvatar ring className="relative h-14 w-14" />
        </span>
        <div className="min-w-0">
          <p className="text-[10.5px] font-bold uppercase tracking-[0.14em] text-[#E4A9C4]">NATI · Inteligência Artificial</p>
          <p className="mt-1 text-[13.5px] leading-snug text-white/90">{natiNote}</p>
          <Link to={paths.nati} className="group/nati mt-2 inline-flex items-center gap-1 text-[13px] font-semibold text-white underline-offset-4 hover:underline">
            Conhecer a NATI
            <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover/nati:translate-x-0.5" aria-hidden />
          </Link>
        </div>
      </div>
    </article>
  )
}

export function CategoryCards({ className }: { className?: string }) {
  return (
    <Stagger className={cn('grid gap-4 md:grid-cols-2 lg:grid-cols-3', className)} stagger={0.07}>
      {groups.map((g) => {
        const featured = g.id === FEATURED
        return (
          <StaggerItem key={g.id} className={cn('min-w-0', featured && 'md:col-span-2 lg:col-span-3')}>
            {featured ? <FeaturedCard group={g} /> : <CategoryCard group={g} />}
          </StaggerItem>
        )
      })}
    </Stagger>
  )
}
