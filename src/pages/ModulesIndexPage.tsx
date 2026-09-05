import { useId, useMemo, useState } from 'react'
import { Link } from 'react-router'
import { ArrowRight, Building2, Network, Search, Users, X } from 'lucide-react'
import { Section, Eyebrow } from '@/components/sections/Section'
import { ModulesSection } from '@/components/sections/ModulesSection'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'
import { getGroup, groups, modulePath, moduleRegistry, type ModuleEntry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import { paths } from '@/content/site'
import { cn } from '@/lib/utils'

const stats = [
  { value: '31', label: 'módulos, cada um com a sua página' },
  { value: '7', label: 'frentes do RH' },
  { value: '1', label: 'cadastro, uma base, uma experiência' },
]

/* Por onde começar, conforme a estrutura da organização. */
const shortcuts = [
  {
    icon: Network,
    title: 'Holding com RH central',
    text: 'Vários CNPJs na mesma folha, um time cuidando de todos. Os módulos que mais pesam:',
    modules: ['folha-de-pagamento', 'administracao-de-pessoal', 'business-intelligence'],
    links: [{ to: paths.groups, label: 'Como funciona para grupos' }],
  },
  {
    icon: Users,
    title: 'Grupo com RH em cada filial',
    text: 'Cada equipe vê só a sua filial e a matriz fecha a folha. Os módulos que mais pesam:',
    modules: ['portais', 'requisicoes-com-workflow', 'ponto-eletronico'],
    links: [
      { to: paths.groups, label: 'Como funciona para grupos' },
      { to: modulePath('portais'), label: 'Portais' },
    ],
  },
  {
    icon: Building2,
    title: 'Empresa única',
    text: 'Uma base, perfis por unidade e centro de custo. Os módulos que mais pesam:',
    modules: ['admissao-digital', 'natponto', 'nati'],
    links: [{ to: paths.groups, label: 'Como funciona para a sua estrutura' }],
  },
]

/* Busca sem acento e sem caixa. */
const fold = (s: string) =>
  s
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .trim()

export default function ModulesIndexPage() {
  useSeo({
    title: 'Módulos do sistema de RH Natcorp | Natcorp',
    description:
      'Conheça os 31 módulos da Natcorp: folha de pagamento, ponto eletrônico, eSocial, admissão digital, SESMT, recrutamento, avaliações, treinamento, people analytics e a NATI.',
    path: '/modulos',
  })

  const [query, setQuery] = useState('')
  const searchId = useId()
  const q = fold(query)

  const results = useMemo(() => {
    if (!q) return null
    const terms = q.split(/\s+/).filter(Boolean)
    const matches = moduleRegistry.filter((mod) => {
      const hay = fold(`${mod.name} ${mod.short} ${getGroup(mod.group).name}`)
      return terms.every((t) => hay.includes(t))
    })
    return groups
      .map((g) => ({ group: g, modules: matches.filter((mod) => mod.group === g.id) }))
      .filter((g) => g.modules.length > 0)
  }, [q])

  const count = results?.reduce((n, g) => n + g.modules.length, 0) ?? moduleRegistry.length

  return (
    <PageTransition>
      <Section tone="off" className="overflow-hidden pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pt-[calc(var(--nav-h)+5rem)]" aria-labelledby="modulos-index-title">
        <LogoOutline className="pointer-events-none absolute -right-[10%] -top-[30%] h-[140%] w-auto text-brand-purple/[0.12]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: 'Módulos' }]} />
          <div className="mt-8 grid items-end gap-10 lg:grid-cols-[1.4fr_1fr]">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow>Todos os módulos</Eyebrow>
              </Reveal>
              <SplitText
                as="h1"
                id="modulos-index-title"
                text="31 módulos. [[Um único sistema.]]"
                className="mt-5 text-4xl font-extrabold leading-[1.05] text-brand-ink sm:text-5xl lg:text-6xl"
                highlightClassName="text-brand-purple"
              />
              <Reveal delay={0.25}>
                <p className="mt-6 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                  Do Departamento Pessoal ao SESMT, do recrutamento ao People Analytics: cada módulo tem a sua página,
                  com o que ele faz, como funciona e o que muda para a sua empresa. Escolha por onde começar.
                </p>
              </Reveal>
              <Reveal delay={0.35} className="mt-8 flex flex-wrap gap-3">
                <Button asChild size="lg">
                  <Link to="#contato">
                    Agendar demonstração
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
              </Reveal>
            </div>
            <Reveal delay={0.3} className="grid grid-cols-3 gap-3 lg:grid-cols-1">
              {stats.map((s) => (
                <div key={s.label} className="rounded-2xl border border-brand-mist bg-white p-5 shadow-soft">
                  <p className="text-3xl font-extrabold tracking-brand text-brand-purple">{s.value}</p>
                  <p className="mt-1 text-sm text-brand-graphite">{s.label}</p>
                </div>
              ))}
            </Reveal>
          </div>

          {/* Por onde começar */}
          <Reveal delay={0.2} className="mt-14 lg:mt-16">
            <Eyebrow>Por onde começar</Eyebrow>
          </Reveal>
          <Stagger className="mt-5 grid gap-4 lg:grid-cols-3" stagger={0.08}>
            {shortcuts.map(({ icon: Icon, title, text, modules, links }) => (
              <StaggerItem key={title} className="flex h-full flex-col rounded-2xl border border-brand-mist bg-white p-5 shadow-soft">
                <div className="flex items-center gap-3">
                  <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple">
                    <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
                  </span>
                  <h2 className="text-[17px] font-extrabold leading-snug text-brand-ink">{title}</h2>
                </div>
                <p className="mt-3 text-[14.5px] leading-relaxed text-brand-graphite">{text}</p>
                <ul className="mt-3 flex flex-wrap gap-2" aria-label={`Módulos para ${title}`}>
                  {modules.map((slug) => {
                    const mod = moduleRegistry.find((x) => x.slug === slug)
                    if (!mod) return null
                    return (
                      <li key={slug}>
                        <Link
                          to={modulePath(slug)}
                          className="inline-flex items-center gap-1 rounded-lg border border-brand-mist px-2.5 py-1.5 text-[12.5px] font-semibold text-brand-ink transition-colors duration-300 hover:border-brand-purple/40 hover:bg-brand-off-white hover:text-brand-purple"
                        >
                          {mod.name}
                        </Link>
                      </li>
                    )
                  })}
                </ul>
                <div className="mt-auto flex flex-wrap gap-x-5 gap-y-1.5 pt-4">
                  {links.map((l) => (
                    <Link key={l.to} to={l.to} className="group inline-flex items-center gap-1.5 text-[13.5px] font-semibold text-brand-purple">
                      {l.label}
                      <ArrowRight className="h-3.5 w-3.5 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
                    </Link>
                  ))}
                </div>
              </StaggerItem>
            ))}
          </Stagger>

          {/* Busca */}
          <Reveal delay={0.1} className="mt-12 lg:mt-14">
            <div className="rounded-2xl border border-brand-mist bg-white p-4 shadow-soft sm:p-5">
              <label htmlFor={searchId} className="block text-[13px] font-semibold uppercase tracking-[0.14em] text-brand-purple">
                Buscar um módulo
              </label>
              <div className="relative mt-2">
                <Search className="pointer-events-none absolute left-3.5 top-1/2 h-4.5 w-4.5 -translate-y-1/2 text-brand-graphite" strokeWidth={1.8} aria-hidden />
                <input
                  id={searchId}
                  type="search"
                  value={query}
                  onChange={(e) => setQuery(e.target.value)}
                  placeholder="Ex.: folha, ponto, eSocial, SESMT, portais"
                  autoComplete="off"
                  aria-describedby={`${searchId}-count`}
                  className="h-12 w-full rounded-xl border border-brand-mist bg-brand-off-white/60 pl-11 pr-11 text-[15px] text-brand-ink placeholder:text-brand-graphite/70 focus-visible:border-brand-purple focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple/30"
                />
                {query && (
                  <button
                    type="button"
                    onClick={() => setQuery('')}
                    aria-label="Limpar a busca"
                    className="absolute right-2.5 top-1/2 flex h-7 w-7 -translate-y-1/2 items-center justify-center rounded-full text-brand-graphite transition-colors hover:bg-brand-off-white hover:text-brand-ink"
                  >
                    <X className="h-4 w-4" strokeWidth={2} aria-hidden />
                  </button>
                )}
              </div>
              <p id={`${searchId}-count`} role="status" aria-live="polite" className="mt-2 text-[13.5px] text-brand-graphite">
                {q
                  ? count === 0
                    ? `Nenhum módulo encontrado para "${query.trim()}".`
                    : `${count} ${count === 1 ? 'módulo encontrado' : 'módulos encontrados'} para "${query.trim()}".`
                  : `${moduleRegistry.length} módulos em ${groups.length} frentes. Busque pelo nome, pelo que o módulo faz ou pela frente.`}
              </p>
            </div>
          </Reveal>
        </div>
      </Section>

      {results ? <SearchResults results={results} query={query.trim()} onClear={() => setQuery('')} /> : <ModulesSection withHeader={false} id="lista" />}
      <CTASection />
    </PageTransition>
  )
}

interface ResultGroup {
  group: (typeof groups)[number]
  modules: ModuleEntry[]
}

function SearchResults({ results, query, onClear }: { results: ResultGroup[]; query: string; onClear: () => void }) {
  return (
    <Section id="lista" tone="white" className="pt-0 sm:pt-0 lg:pt-0" aria-label="Resultados da busca">
      <div className="container">
        {results.length === 0 ? (
          <div className="rounded-3xl border border-brand-mist bg-brand-off-white/50 p-8 text-center">
            <p className="text-lg font-bold text-brand-ink">Nenhum módulo com "{query}".</p>
            <p className="mt-2 text-[15px] text-brand-graphite">Tente outro termo, como folha, ponto, eSocial, benefícios, exames ou portal.</p>
            <button type="button" onClick={onClear} className="mt-5 inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
              Ver todos os módulos
              <ArrowRight className="h-4 w-4" aria-hidden />
            </button>
          </div>
        ) : (
          <div className="space-y-8">
            {results.map(({ group, modules }) => (
              <section key={group.id} aria-labelledby={`busca-${group.id}`} className="rounded-3xl border border-brand-mist bg-white p-6 shadow-soft sm:p-8">
                <h2 id={`busca-${group.id}`} className="text-2xl font-extrabold text-brand-ink">
                  {group.name}
                </h2>
                <p className="mt-1 text-base font-semibold text-brand-purple">{group.tagline}</p>
                <ul className="mt-5 grid gap-3 sm:grid-cols-2">
                  {modules.map((mod) => {
                    const Icon = moduleIcons[mod.icon]
                    return (
                      <li key={mod.slug}>
                        <Link
                          to={modulePath(mod.slug)}
                          className={cn(
                            'group flex h-full items-center gap-3 rounded-xl border border-brand-mist/80 bg-brand-off-white/40 p-4 transition-[border-color,background-color,transform,box-shadow] duration-300 ease-brand hover:-translate-y-0.5 hover:border-brand-purple/30 hover:bg-white hover:shadow-soft',
                          )}
                        >
                          <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-white text-brand-purple shadow-soft transition-colors duration-300 group-hover:bg-brand-purple group-hover:text-white">
                            <Icon className="h-5 w-5" strokeWidth={1.6} aria-hidden />
                          </span>
                          <span className="min-w-0 flex-1">
                            <span className="block font-bold text-brand-ink transition-colors duration-300 group-hover:text-brand-purple">{mod.name}</span>
                            <span className="block text-sm leading-snug text-brand-graphite">{mod.short}</span>
                          </span>
                          <ArrowRight className="h-4 w-4 shrink-0 text-brand-graphite transition-transform duration-300 group-hover:translate-x-0.5 group-hover:text-brand-purple" aria-hidden />
                        </Link>
                      </li>
                    )
                  })}
                </ul>
              </section>
            ))}
            <p className="text-[14px] text-brand-graphite">
              <button type="button" onClick={onClear} className="inline-flex items-center gap-1.5 font-semibold text-brand-purple">
                Limpar a busca e ver os 31 módulos
                <ArrowRight className="h-3.5 w-3.5" aria-hidden />
              </button>
            </p>
          </div>
        )}
      </div>
    </Section>
  )
}
