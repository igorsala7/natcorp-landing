import { ArrowRight } from 'lucide-react'
import { Link } from 'react-router'
import { Section } from './Section'
import { Reveal } from '@/components/motion/Reveal'
import { structureIcons, structurePath, structureRegistry, structuresPath } from '@/content/structures'
import { cn } from '@/lib/utils'

interface StructureStripProps {
  id?: string
  tone?: 'white' | 'off' | 'dark'
  className?: string
  /** Pergunta da faixa (padrão: "Como é a sua estrutura?"). */
  title?: string
  /** Frase curta abaixo da pergunta. */
  text?: string
}

/**
 * Faixa compacta "Como é a sua estrutura?": as cinco estruturas como chips, cada uma levando à sua página,
 * e o link para o seletor em /estruturas. Para fechar páginas de segmento, jornada e portais.
 */
export function StructureStrip({
  id = 'estrutura',
  tone = 'off',
  className,
  title = 'Como é a sua estrutura?',
  text = 'Empresa única, grupo, filiais, RH central ou por unidade: veja como o sistema, os módulos e o fluxo do centro de serviços se encaixam na sua.',
}: StructureStripProps) {
  const dark = tone === 'dark'
  return (
    <Section id={id} tone={tone} flush className={cn('py-12 sm:py-14 lg:py-16', className)} aria-labelledby={`${id}-title`}>
      <div className="container">
        <Reveal className={cn('rounded-3xl border p-6 sm:p-8', dark ? 'border-white/10 bg-white/[0.05]' : 'border-brand-mist bg-white shadow-soft')}>
          <div className="grid gap-6 lg:grid-cols-[minmax(0,1fr)_minmax(0,1.6fr)] lg:items-center lg:gap-10">
            <div>
              <h2 id={`${id}-title`} className={cn('text-2xl font-extrabold leading-tight tracking-brand sm:text-[1.75rem]', dark ? 'text-white' : 'text-brand-ink')}>
                {title}
              </h2>
              <p className={cn('mt-2 text-[14.5px] leading-relaxed', dark ? 'text-white/75' : 'text-brand-graphite')}>{text}</p>
            </div>
            <div>
              <ul className="flex flex-wrap gap-2" aria-label="As cinco estruturas">
                {structureRegistry.map((s) => {
                  const Icon = structureIcons[s.icon]
                  return (
                    <li key={s.slug}>
                      <Link
                        to={structurePath(s.slug)}
                        title={s.name}
                        className={cn(
                          'group inline-flex items-center gap-2 rounded-xl border py-2 pl-2 pr-3.5 text-[13.5px] font-bold transition-[border-color,background-color,transform,box-shadow] duration-300 ease-brand hover:-translate-y-0.5 focus-visible:outline-none focus-visible:ring-2',
                          dark
                            ? 'border-white/20 bg-white/10 text-white hover:border-white/50 hover:bg-white/[0.16] focus-visible:ring-[#E4A9C4]'
                            : 'border-brand-mist bg-brand-off-white text-brand-ink hover:border-brand-purple/40 hover:bg-white hover:shadow-soft focus-visible:ring-brand-purple',
                        )}
                      >
                        <span className={cn('flex h-7 w-7 items-center justify-center rounded-lg', dark ? 'bg-[#E4A9C4] text-brand-blue' : 'bg-white text-brand-purple shadow-[inset_0_0_0_1px_#E9E5F1] group-hover:bg-brand-purple group-hover:text-white group-hover:shadow-none')}>
                          <Icon className="h-3.5 w-3.5" strokeWidth={1.8} aria-hidden />
                        </span>
                        {s.label}
                      </Link>
                    </li>
                  )
                })}
              </ul>
              <Link
                to={structuresPath}
                className={cn('group mt-5 inline-flex items-center gap-2 text-[15px] font-semibold', dark ? 'text-white' : 'text-brand-purple')}
              >
                Não sabe qual é a sua? Responda a três perguntas
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
              </Link>
            </div>
          </div>
        </Reveal>
      </div>
    </Section>
  )
}
