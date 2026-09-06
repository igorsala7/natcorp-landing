import { useId, useRef, useState, type KeyboardEvent } from 'react'
import { Link } from 'react-router'
import { AnimatePresence, m, useReducedMotion } from 'motion/react'
import { ArrowRight, Check, Info } from 'lucide-react'
import { Button } from '@/components/ui/button'
import {
  chooserQuestions,
  getStructureEntry,
  hrQuestionMatters,
  matchStructure,
  structureIcons,
  structurePath,
  type ChooserAnswers,
  type ChooserQuestion,
} from '@/content/structures'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'

interface StructureChooserProps {
  /** Versão enxuta para a seção da home: perguntas e resultado empilhados, textos menores. */
  compact?: boolean
  className?: string
}

/** Por que a terceira pergunta deixa de importar, conforme a resposta sobre as unidades. */
const hrNotes: Partial<Record<NonNullable<ChooserAnswers['unidades']>, string>> = {
  sede: 'Com uma sede só, o RH é um time só.',
  clientes: 'Com equipes em clientes, o RH da ponta cuida da unidade e o central fecha tudo.',
}

/* ------------------------------------------------------------------------------------------------
 * Grupo de opções: botões com papel de rádio, tabindex itinerante e setas para mudar a resposta.
 * ---------------------------------------------------------------------------------------------- */

interface OptionGroupProps<K extends keyof ChooserAnswers> {
  index: number
  question: ChooserQuestion<K>
  value: ChooserAnswers[K]
  onChange: (value: NonNullable<ChooserAnswers[K]>) => void
  muted?: boolean
  note?: string
  compact?: boolean
}

function OptionGroup<K extends keyof ChooserAnswers>({ index, question, value, onChange, muted = false, note, compact = false }: OptionGroupProps<K>) {
  const uid = useId()
  const buttons = useRef<(HTMLButtonElement | null)[]>([])
  const options = question.options
  const selected = options.findIndex((o) => o.value === value)
  const focusable = selected >= 0 ? selected : 0

  const move = (e: KeyboardEvent<HTMLButtonElement>, from: number) => {
    let next: number | null = null
    if (e.key === 'ArrowRight' || e.key === 'ArrowDown') next = (from + 1) % options.length
    else if (e.key === 'ArrowLeft' || e.key === 'ArrowUp') next = (from - 1 + options.length) % options.length
    else if (e.key === 'Home') next = 0
    else if (e.key === 'End') next = options.length - 1
    if (next === null) return
    e.preventDefault()
    onChange(options[next].value)
    buttons.current[next]?.focus()
  }

  return (
    <div className={cn('transition-opacity duration-500', muted && 'opacity-60')}>
      <div className="flex items-center gap-3">
        <span
          aria-hidden
          className={cn(
            'flex shrink-0 items-center justify-center rounded-full text-[11px] font-extrabold tabular-nums transition-colors duration-300',
            compact ? 'h-6 w-6' : 'h-7 w-7',
            value && !muted ? 'bg-brand-purple text-white' : 'bg-brand-purple/10 text-brand-purple',
          )}
        >
          {String(index + 1).padStart(2, '0')}
        </span>
        <p id={`${uid}-q`} className={cn('font-extrabold leading-snug text-brand-ink', compact ? 'text-[15px]' : 'text-[17px] sm:text-lg')}>
          {question.question}
        </p>
      </div>
      <div
        role="radiogroup"
        aria-labelledby={`${uid}-q`}
        aria-describedby={note ? `${uid}-note` : undefined}
        className={cn('mt-3 grid gap-2', options.length === 3 ? 'sm:grid-cols-3' : 'sm:grid-cols-2', compact ? 'sm:gap-2' : 'sm:gap-3')}
      >
        {options.map((o, i) => {
          const checked = i === selected
          return (
            <button
              key={o.value}
              ref={(el) => {
                buttons.current[i] = el
              }}
              type="button"
              role="radio"
              aria-checked={checked}
              aria-labelledby={`${uid}-${o.value}-l`}
              aria-describedby={`${uid}-${o.value}-h`}
              tabIndex={muted ? -1 : i === focusable ? 0 : -1}
              disabled={muted}
              onClick={() => onChange(o.value)}
              onKeyDown={(e) => move(e, i)}
              className={cn(
                'group/opt flex w-full items-start gap-3 rounded-2xl border text-left transition-[border-color,background-color,box-shadow,transform] duration-300 ease-brand focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple focus-visible:ring-offset-2 disabled:cursor-default',
                compact ? 'p-3' : 'p-4',
                checked ? 'border-brand-purple bg-brand-purple/[0.06] shadow-soft' : 'border-brand-mist bg-white hover:border-brand-purple/40 hover:shadow-soft enabled:hover:-translate-y-0.5',
              )}
            >
              <span
                aria-hidden
                className={cn(
                  'mt-0.5 flex h-5 w-5 shrink-0 items-center justify-center rounded-full border-2 transition-colors duration-300',
                  checked ? 'border-brand-purple bg-brand-purple text-white' : 'border-brand-mist bg-white group-hover/opt:border-brand-purple/50',
                )}
              >
                {checked && <Check className="h-3 w-3" strokeWidth={3} />}
              </span>
              <span className="min-w-0">
                <span id={`${uid}-${o.value}-l`} className={cn('block font-bold leading-snug text-brand-ink', compact ? 'text-[14px]' : 'text-[15px]')}>
                  {o.label}
                </span>
                <span id={`${uid}-${o.value}-h`} className={cn('mt-0.5 block leading-snug text-brand-graphite', compact ? 'text-[12.5px]' : 'text-[13px]')}>
                  {o.hint}
                </span>
              </span>
            </button>
          )
        })}
      </div>
      {note && (
        <p id={`${uid}-note`} className="mt-3 flex items-start gap-2 text-[13.5px] leading-snug text-brand-graphite">
          <Info className="mt-0.5 h-4 w-4 shrink-0 text-brand-purple" aria-hidden />
          {note}
        </p>
      )}
    </div>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Resultado: a estrutura que descreve a operação, ou o convite para responder.
 * ---------------------------------------------------------------------------------------------- */

function Result({ slug, answered, compact }: { slug: string | null; answered: number; compact: boolean }) {
  const reduced = useReducedMotion()
  const entry = slug ? getStructureEntry(slug) : undefined
  const transition = reduced ? { duration: 0 } : { duration: 0.45, ease: EASE }

  return (
    <div aria-live="polite" className="relative">
      <AnimatePresence mode="wait" initial={false}>
        {entry ? (
          <m.div
            key={entry.slug}
            initial={{ opacity: 0, y: 14, scale: 0.98 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: -8, scale: 0.99 }}
            transition={transition}
            className={cn('on-dark relative overflow-hidden rounded-3xl bg-brand-gradient text-white shadow-lift', compact ? 'p-5 sm:p-6' : 'p-6 sm:p-8')}
          >
            <span aria-hidden className="pointer-events-none absolute -right-10 -top-16 h-44 w-44 rotate-45 rounded-[17%] border border-white/20" />
            <span aria-hidden className="pointer-events-none absolute -right-2 -top-8 h-28 w-28 rotate-45 rounded-[17%] bg-white/[0.07]" />
            <div className="relative">
              <p className="text-[11px] font-bold uppercase tracking-[0.16em] text-[#E4A9C4]">A sua estrutura</p>
              <div className="mt-3 flex items-start gap-4">
                <span className={cn('flex shrink-0 items-center justify-center rounded-2xl bg-white/15', compact ? 'h-11 w-11' : 'h-14 w-14')}>
                  <ResultIcon icon={entry.icon} className={compact ? 'h-5 w-5' : 'h-7 w-7'} />
                </span>
                <div className="min-w-0">
                  <h3 className={cn('font-extrabold leading-tight tracking-brand', compact ? 'text-xl' : 'text-2xl sm:text-[1.75rem]')}>{entry.name}</h3>
                  <p className={cn('mt-2 leading-relaxed text-white/85', compact ? 'text-[14px]' : 'text-[15.5px]')}>{entry.short}</p>
                </div>
              </div>
              <ul className="mt-4 flex flex-wrap gap-2" aria-label="Como essa estrutura se define">
                {entry.tags.map((t) => (
                  <li key={t} className="rounded-full border border-white/25 bg-white/10 px-3 py-1 text-[12.5px] font-semibold">
                    {t}
                  </li>
                ))}
              </ul>
              <Button asChild size={compact ? 'default' : 'lg'} variant="inverse" className="mt-6">
                <Link to={structurePath(entry.slug)}>
                  Ver como o sistema se encaixa
                  <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                </Link>
              </Button>
            </div>
          </m.div>
        ) : (
          <m.div
            key="empty"
            initial={{ opacity: 0, y: 14 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -8 }}
            transition={transition}
            className={cn('rounded-3xl border border-dashed border-brand-purple/30 bg-white/60', compact ? 'p-5' : 'p-6 sm:p-8')}
          >
            <p className="text-[11px] font-bold uppercase tracking-[0.16em] text-brand-purple">O resultado aparece aqui</p>
            <p className={cn('mt-3 font-extrabold leading-snug text-brand-ink', compact ? 'text-[17px]' : 'text-xl')}>
              {answered === 0 ? 'Responda às perguntas e veja qual estrutura descreve a sua operação.' : 'Falta pouco. Responda à próxima pergunta.'}
            </p>
            <p className={cn('mt-2 leading-relaxed text-brand-graphite', compact ? 'text-[13.5px]' : 'text-[15px]')}>
              Cinco estruturas, um sistema. Em cada uma, os módulos, os portais e o fluxo do centro de serviços se encaixam de um jeito.
            </p>
            <ol className="mt-5 flex items-center gap-2" aria-label={`${answered} de ${chooserQuestions.length} perguntas respondidas`}>
              {chooserQuestions.map((q, i) => (
                <li key={q.key} aria-hidden className={cn('h-1.5 flex-1 rounded-full transition-colors duration-500', i < answered ? 'bg-brand-purple' : 'bg-brand-mist')} />
              ))}
            </ol>
          </m.div>
        )}
      </AnimatePresence>
    </div>
  )
}

function ResultIcon({ icon, className }: { icon: keyof typeof structureIcons; className?: string }) {
  const Icon = structureIcons[icon]
  return <Icon className={className} strokeWidth={1.6} aria-hidden />
}

/* ------------------------------------------------------------------------------------------------
 * O seletor: três perguntas, resposta ao vivo, nada persistido.
 * ---------------------------------------------------------------------------------------------- */

export function StructureChooser({ compact = false, className }: StructureChooserProps) {
  const [answers, setAnswers] = useState<ChooserAnswers>({})
  const [companies, units, hr] = chooserQuestions
  const hrMuted = Boolean(answers.unidades) && !hrQuestionMatters(answers)
  const slug = matchStructure(answers)
  const answered = [answers.empresas, answers.unidades, hrMuted ? answers.unidades : answers.rh].filter(Boolean).length

  const set = <K extends keyof ChooserAnswers>(key: K) => (value: NonNullable<ChooserAnswers[K]>) => setAnswers((a) => ({ ...a, [key]: value }))

  return (
    <div className={cn(compact ? 'flex flex-col gap-6' : 'grid grid-cols-1 gap-10 lg:grid-cols-[1.25fr_1fr] lg:gap-12', className)}>
      <div className={cn('flex flex-col', compact ? 'gap-6' : 'gap-8')}>
        <OptionGroup index={0} question={companies} value={answers.empresas} onChange={set('empresas')} compact={compact} />
        <OptionGroup index={1} question={units} value={answers.unidades} onChange={set('unidades')} compact={compact} />
        <OptionGroup index={2} question={hr} value={answers.rh} onChange={set('rh')} muted={hrMuted} note={hrMuted && answers.unidades ? hrNotes[answers.unidades] : undefined} compact={compact} />
      </div>
      <div className={cn(!compact && 'lg:sticky lg:top-32 lg:self-start')}>
        <Result slug={slug} answered={answered} compact={compact} />
      </div>
    </div>
  )
}
