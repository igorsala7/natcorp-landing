import { ArrowRight } from 'lucide-react'
import { Link } from 'react-router'
import { journeyPath } from '@/content/site'
import { phases, steps, type CastKey, type PhaseNumber } from '@/content/hiringJourney'
import { getModuleEntry, modulePath } from '@/content/modulePages'
import { Section, Eyebrow } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { EmployeeAvatar } from '@/components/brand/EmployeeAvatar'
import { CastAvatar } from '@/components/journey/Cast'
import { cn } from '@/lib/utils'

/**
 * A jornada da Ana resumida em quatro fases: o ciclo completo do colaborador dentro do sistema,
 * com quem entra em cada fase e os módulos que a sustentam. A história inteira fica na página da jornada.
 */

/** Módulos que melhor representam cada fase (a lista completa está na página da jornada). */
const phaseModules: Record<PhaseNumber, string[]> = {
  1: ['requisicoes-com-workflow', 'quadro-de-vagas', 'recrutamento-e-selecao', 'cargos-e-salarios'],
  2: ['admissao-digital', 'gestao-de-beneficios', 'medicina-ocupacional', 'assinatura-eletronica'],
  3: ['onboarding', 'natponto', 'seguranca-do-trabalho', 'treinamento-e-desenvolvimento'],
  4: ['avaliacoes-e-feedbacks', 'requisicoes-com-workflow', 'folha-de-pagamento', 'carreira-e-sucessao'],
}

/** Quem aparece em cada fase, na ordem da história, com a Ana sempre à frente quando entra. */
function phaseCast(n: PhaseNumber): CastKey[] {
  const seen = new Set<CastKey>()
  for (const s of steps) if (s.phase === n && !seen.has(s.character)) seen.add(s.character)
  const list = [...seen]
  return (list.includes('ana') ? ['ana' as CastKey, ...list.filter((c) => c !== 'ana')] : list).slice(0, 3)
}

export function JourneySection() {
  return (
    <Section id="jornada" tone="off" className="overflow-x-clip" aria-labelledby="jornada-title">
      <div className="container">
        <div className="max-w-3xl">
          <Reveal y={12} duration={0.5} className="flex flex-wrap items-center gap-3">
            <EmployeeAvatar ring className="h-11 w-11" />
            <Eyebrow trail={false}>Jornada completa · Conheça a história da Ana</Eyebrow>
          </Reveal>
          <Reveal delay={0.1}>
            <h2 id="jornada-title" className="mt-5 text-3xl font-extrabold leading-[1.1] text-brand-ink sm:text-4xl lg:text-5xl">
              Uma vaga nasce e, em poucos cliques, <span className="text-brand-purple">a Ana já está contratada.</span>
            </h2>
          </Reveal>
          <Reveal delay={0.2}>
            <p className="mt-5 max-w-2xl text-lg leading-relaxed text-brand-graphite">
              Da requisição da vaga à promoção, o ciclo completo do colaborador acontece dentro do sistema: cada fase alimenta a seguinte, sem papel e
              sem digitar de novo. Aqui vai o resumo. A história inteira, com os personagens e as telas, está na página da jornada.
            </p>
          </Reveal>
        </div>

        {/* As quatro fases, como uma linha do tempo */}
        <Stagger className="relative mt-10 grid gap-4 sm:grid-cols-2 lg:mt-14 lg:grid-cols-4" delay={0.15}>
          <span className="absolute left-0 right-0 top-[27px] hidden h-px bg-brand-mist lg:block" aria-hidden />
          {phases.map((p) => (
            <StaggerItem key={p.n} className="relative flex h-full flex-col rounded-3xl border border-brand-mist bg-white p-6 shadow-soft">
              <div className="flex items-center justify-between gap-3">
                <span className="inline-flex items-center gap-2">
                  <span className="flex h-7 w-7 items-center justify-center rounded-full bg-brand-purple text-[11px] font-extrabold text-white">{p.n}</span>
                  <span className="text-[11px] font-bold uppercase tracking-[0.12em] text-brand-purple">Fase {p.n}</span>
                </span>
                <span className="text-[11px] font-semibold text-brand-graphite">{p.range}</span>
              </div>
              <h3 className="mt-4 text-xl font-extrabold leading-tight text-brand-ink">{p.title}</h3>
              <p className="mt-2 text-[14.5px] leading-relaxed text-brand-graphite">{p.subtitle}</p>

              <div className="mt-5 flex items-center gap-2" aria-label="Quem entra nesta fase">
                <span className="flex -space-x-2">
                  {phaseCast(p.n).map((who) => (
                    <CastAvatar key={who} who={who} className="h-8 w-8 shrink-0 ring-2 ring-white" initialsClassName="text-[10px]" />
                  ))}
                </span>
                <span className="text-[12px] font-medium text-brand-graphite">{castLine(phaseCast(p.n))}</span>
              </div>

              <ul className="mt-5 flex flex-wrap gap-1.5 border-t border-brand-mist pt-4" aria-label="Módulos desta fase">
                {phaseModules[p.n].map((slug) => {
                  const entry = getModuleEntry(slug)
                  if (!entry) return null
                  return (
                    <li key={slug}>
                      <Link
                        to={modulePath(slug)}
                        className={cn(
                          'inline-block rounded-full bg-brand-off-white px-2.5 py-1 text-[12px] font-semibold text-brand-ink transition-colors duration-300',
                          'hover:bg-brand-purple hover:text-white focus-visible:bg-brand-purple focus-visible:text-white',
                        )}
                      >
                        {entry.name}
                      </Link>
                    </li>
                  )
                })}
              </ul>
            </StaggerItem>
          ))}
        </Stagger>

        <Reveal delay={0.1} className="mt-8 lg:mt-10">
          <Link
            to={journeyPath}
            className="group flex flex-col gap-5 rounded-3xl bg-brand-blue p-6 text-white shadow-soft transition-[transform,box-shadow] duration-500 ease-brand hover:-translate-y-1 hover:shadow-lift sm:flex-row sm:items-center sm:justify-between sm:p-8"
          >
            <span>
              <span className="block text-[12px] font-semibold uppercase tracking-[0.16em] text-[#E4A9C4]">Conheça a história da Ana</span>
              <span className="mt-2 block text-xl font-extrabold leading-snug sm:text-2xl">O ciclo completo, da requisição da vaga à promoção, contado etapa por etapa.</span>
              <span className="mt-2 block max-w-2xl text-[15px] leading-relaxed text-white/70">
                Em história, com os personagens e as telas do sistema, ou em diagrama, com os módulos que entram em cada etapa.
              </span>
            </span>
            <span className="inline-flex shrink-0 items-center gap-2 rounded-lg bg-white px-5 py-3 text-sm font-semibold text-brand-purple transition-colors duration-300 group-hover:bg-[#F3DCE7]">
              Ler a história
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </span>
          </Link>
        </Reveal>
      </div>
    </Section>
  )
}

const firstNames: Record<CastKey, string> = {
  ana: 'Ana',
  marcos: 'Marcos',
  juliana: 'Juliana',
  claudia: 'Cláudia',
  beatriz: 'Beatriz',
  henrique: 'Dr. Henrique',
  rafael: 'Rafael',
  paulo: 'Paulo',
  nati: 'NATI',
}

function castLine(keys: CastKey[]) {
  const names = keys.map((k) => firstNames[k])
  if (names.length <= 1) return names[0] ?? ''
  return `${names.slice(0, -1).join(', ')} e ${names[names.length - 1]}`
}
