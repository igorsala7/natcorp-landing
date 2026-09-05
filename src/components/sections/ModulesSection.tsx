import { useState } from 'react'
import { m } from 'motion/react'
import { ArrowUpRight } from 'lucide-react'
import { Link } from 'react-router'
import { Section, SectionHeader } from './Section'
import { moduleGroups } from '@/content/modules'
import { modulePath } from '@/content/modulePages'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

interface ModulesSectionProps {
  /** Na página /modulos o cabeçalho vem do hero da própria página. */
  withHeader?: boolean
  id?: string
}

export function ModulesSection({ withHeader = true, id = 'modulos' }: ModulesSectionProps) {
  const [active, setActive] = useState(0)
  /* Na página /modulos o h1 é o hero; os grupos viram h2 para manter a hierarquia. */
  const GroupHeading = withHeader ? 'h3' : 'h2'

  return (
    <Section id={id} tone="white" aria-labelledby={withHeader ? 'modulos-title' : undefined} className={cn(!withHeader && 'pt-0 sm:pt-0 lg:pt-0')}>
      <div className="container">
        {withHeader && (
          <SectionHeader
            id="modulos-title"
            align="center"
            eyebrow="31 módulos"
            title="Tudo o que o RH faz, [[em um só lugar]]."
            lead="Sete frentes, 31 módulos, uma única base de dados. Clique em um módulo para conhecer a página dele; o sistema cresce com a sua empresa."
          />
        )}

        <div className={cn('lg:grid lg:grid-cols-[280px_1fr] lg:gap-12 xl:grid-cols-[320px_1fr]', withHeader && 'mt-12 lg:mt-16')}>
          <nav
            aria-label="Grupos de módulos"
            className="no-scrollbar sticky top-[var(--nav-h)] z-30 -mx-5 overflow-x-auto border-b border-brand-mist bg-white/90 px-5 py-3 backdrop-blur-md lg:top-[calc(var(--nav-h)+1.5rem)] lg:mx-0 lg:h-fit lg:overflow-visible lg:border-0 lg:bg-transparent lg:p-0 lg:backdrop-blur-none"
          >
            <ul className="flex gap-2 lg:flex-col lg:gap-1">
              {moduleGroups.map((g, i) => {
                const Icon = g.icon
                const isActive = i === active
                return (
                  <li key={g.id} className="shrink-0">
                    <Link
                      to={`#${g.id}`}
                      aria-current={isActive ? 'true' : undefined}
                      onClick={() => setActive(i)}
                      className={cn(
                        'flex items-center gap-3 whitespace-nowrap rounded-full px-4 py-2 text-sm font-semibold transition-colors duration-300 lg:rounded-xl lg:px-4 lg:py-3',
                        isActive
                          ? 'bg-brand-purple text-white lg:bg-brand-off-white lg:text-brand-purple'
                          : 'bg-brand-off-white text-brand-graphite hover:text-brand-purple lg:bg-transparent',
                      )}
                    >
                      <Icon className="hidden h-4.5 w-4.5 lg:block" strokeWidth={1.6} />
                      {g.name}
                      <span className={cn('ml-auto hidden text-xs tabular lg:inline', isActive ? 'text-brand-purple/70' : 'text-brand-gray')}>
                        {g.modules.length}
                      </span>
                    </Link>
                  </li>
                )
              })}
            </ul>
          </nav>

          <div className="mt-8 space-y-6 lg:mt-0">
            {moduleGroups.map((g, i) => {
              const Icon = g.icon
              return (
                <m.article
                  key={g.id}
                  id={g.id}
                  className="relative scroll-mt-32 rounded-3xl border border-brand-mist bg-white p-6 shadow-soft sm:p-8 lg:scroll-mt-28"
                  initial={{ opacity: 0, y: 32 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true, margin: '0px 0px -10% 0px' }}
                  transition={{ duration: 0.8, ease: EASE }}
                  aria-labelledby={`${g.id}-title`}
                >
                  <m.span
                    aria-hidden
                    className="pointer-events-none absolute inset-x-0 top-[35%] h-px"
                    onViewportEnter={() => setActive(i)}
                    viewport={{ margin: '-45% 0px -45% 0px' }}
                  />
                  <header className="flex flex-col gap-4 sm:flex-row sm:items-start sm:gap-5">
                    <span className="inline-flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-brand-gradient text-white">
                      <Icon className="h-6 w-6" strokeWidth={1.6} />
                    </span>
                    <div>
                      <GroupHeading id={`${g.id}-title`} className="text-2xl font-extrabold text-brand-ink">
                        {g.name}
                      </GroupHeading>
                      <p className="mt-1 text-base font-semibold text-brand-purple">{g.tagline}</p>
                      <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{g.description}</p>
                    </div>
                  </header>

                  <ul className="mt-6 grid gap-3 sm:grid-cols-2">
                    {g.modules.map((mod) => (
                      <li key={mod.name}>
                        <Link
                          to={modulePath(mod.slug, mod.hash)}
                          className="group flex h-full flex-col rounded-xl border border-brand-mist/80 bg-brand-off-white/40 p-4 transition-[border-color,background-color,transform,box-shadow] duration-300 ease-brand hover:-translate-y-0.5 hover:border-brand-purple/30 hover:bg-white hover:shadow-soft focus-visible:outline-offset-0"
                        >
                          <p className="flex items-center gap-2 font-bold text-brand-ink">
                            <span className="h-1.5 w-1.5 rotate-45 rounded-[1px] bg-brand-pink" aria-hidden />
                            {mod.name}
                            <ArrowUpRight
                              className="ml-auto h-4 w-4 shrink-0 text-brand-gray opacity-0 transition-[opacity,transform,color] duration-300 group-hover:translate-x-0.5 group-hover:text-brand-purple group-hover:opacity-100 group-focus-visible:opacity-100"
                              aria-hidden
                            />
                          </p>
                          <p className="mt-1 text-sm leading-relaxed text-brand-graphite">{mod.desc}</p>
                        </Link>
                      </li>
                    ))}
                  </ul>
                </m.article>
              )
            })}
          </div>
        </div>
      </div>
    </Section>
  )
}
