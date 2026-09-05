import { ArrowRight, Building2, Network, Users } from 'lucide-react'
import { Link } from 'react-router'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { structureCards, type StructureKey } from '@/content/structure'
import { paths } from '@/content/site'
import { cn } from '@/lib/utils'

const icons: Record<StructureKey, typeof Building2> = {
  unica: Building2,
  central: Network,
  filiais: Users,
}

interface StructureSectionProps {
  id?: string
  tone?: 'white' | 'off' | 'dark'
  /** Sem cabeçalho: só os três cartões (para usar dentro de outra seção). */
  withHeader?: boolean
  eyebrow?: string
  title?: string
  lead?: string
  /** Mostra o link para a página /grupos. */
  more?: boolean
  className?: string
}

/**
 * "Para a sua estrutura": empresa única, holding com RH central e grupo com RH em cada filial.
 * Cada cartão diz o que muda no sistema e leva às páginas que aprofundam.
 */
export function StructureSection({
  id = 'estrutura',
  tone = 'off',
  withHeader = true,
  eyebrow = 'Para a sua estrutura',
  title = 'Uma base para [[o grupo inteiro]]. Cada equipe vê só o que é dela.',
  lead = 'Várias empresas, CNPJs, sindicatos e filiais no mesmo cadastro. Perfis, alçadas e trilha de auditoria por unidade; folha, headcount e orçamento consolidados para a matriz. Escolha o jeito de operar: o sistema acompanha.',
  more = true,
  className,
}: StructureSectionProps) {
  const dark = tone === 'dark'
  return (
    <Section id={id} tone={tone} className={cn('overflow-x-clip', className)} aria-labelledby={withHeader ? `${id}-title` : undefined} aria-label={withHeader ? undefined : 'Para a sua estrutura'}>
      <div className="container">
        {withHeader && <SectionHeader id={`${id}-title`} tone={dark ? 'dark' : 'light'} eyebrow={eyebrow} title={title} lead={lead} />}
        <StructureCards tone={tone} className={withHeader ? 'mt-12' : undefined} />
        {more && (
          <Reveal delay={0.2} className="mt-8">
            <Link
              to={paths.groups}
              className={cn('group inline-flex items-center gap-2 text-[15px] font-semibold', dark ? 'text-white' : 'text-brand-purple')}
            >
              Ver tudo o que muda para grupos com várias empresas e filiais
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
          </Reveal>
        )}
      </div>
    </Section>
  )
}

/** Só os três cartões, para compor dentro de outras seções. */
export function StructureCards({ tone = 'off', className }: { tone?: 'white' | 'off' | 'dark'; className?: string }) {
  const dark = tone === 'dark'
  return (
    <Stagger className={cn('grid gap-4 lg:grid-cols-3', className)} stagger={0.1}>
      {structureCards.map((c) => {
        const Icon = icons[c.key]
        return (
          <StaggerItem
            key={c.key}
            className={cn(
              'flex h-full flex-col rounded-3xl border p-6 transition-[transform,box-shadow] duration-500 ease-brand hover:-translate-y-1',
              dark ? 'border-white/10 bg-white/[0.05] text-white hover:bg-white/[0.08]' : 'border-brand-mist bg-white shadow-soft hover:shadow-lift',
            )}
          >
            <span className={cn('flex h-11 w-11 items-center justify-center rounded-xl', dark ? 'bg-white/10 text-white' : 'bg-brand-off-white text-brand-purple')}>
              <Icon className="h-5 w-5" strokeWidth={1.7} aria-hidden />
            </span>
            <p className={cn('mt-5 text-[11px] font-bold uppercase tracking-[0.14em]', dark ? 'text-[#E4A9C4]' : 'text-brand-purple')}>{c.eyebrow}</p>
            <h3 className={cn('mt-2 text-xl font-extrabold leading-snug', dark ? 'text-white' : 'text-brand-ink')}>{c.title}</h3>
            <p className={cn('mt-3 text-[15px] leading-relaxed', dark ? 'text-white/75' : 'text-brand-graphite')}>{c.text}</p>
            <ul className="mt-4 space-y-1.5">
              {c.bullets.map((b) => (
                <li key={b} className={cn('flex items-start gap-2 text-[14px] leading-snug', dark ? 'text-white/85' : 'text-brand-ink')}>
                  <span aria-hidden className={cn('mt-[7px] h-1.5 w-1.5 shrink-0 rounded-full', dark ? 'bg-[#E4A9C4]' : 'bg-brand-pink')} />
                  {b}
                </li>
              ))}
            </ul>
            <ul className="mt-5 flex flex-wrap gap-2 pt-1" aria-label="Saiba mais">
              {c.links.map((l) => (
                <li key={l.to + l.label}>
                  <Link
                    to={l.to}
                    className={cn(
                      'inline-flex items-center gap-1 rounded-lg border px-2.5 py-1.5 text-[12.5px] font-semibold transition-colors duration-300',
                      dark ? 'border-white/20 text-white hover:bg-white/10' : 'border-brand-mist text-brand-purple hover:border-brand-purple/40 hover:bg-brand-off-white',
                    )}
                  >
                    {l.label}
                    <ArrowRight className="h-3 w-3" aria-hidden />
                  </Link>
                </li>
              ))}
            </ul>
          </StaggerItem>
        )
      })}
    </Stagger>
  )
}
