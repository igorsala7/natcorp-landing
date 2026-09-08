import { type HTMLAttributes, type ReactNode } from 'react'
import { m } from 'motion/react'
import type { HTMLMotionProps, Variants } from 'motion/react'
import { Logo, LogoOutline, ModuleTrail } from '@/components/brand/Logo'
import { Counter } from '@/components/motion/Counter'
import { SplitText } from '@/components/motion/SplitText'
import { deckMeta } from '@/content/presentation'
import { useIsDesktop } from '@/hooks/useMediaQuery'
import { useFitZoom } from './useFitZoom'
import { DUR, EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'

/**
 * Um slide da apresentação executiva (manual, seção 14): 16:9 com margens de 8%,
 * um assunto por slide, eyebrow com o número da seção, rodapé com o símbolo à direita
 * e o número do slide. Ocupa a tela inteira e encaixa na rolagem (scroll-snap).
 * Os tamanhos de texto vêm de variáveis fluidas definidas em `.deck-root` (index.css).
 */

export type SlideTone = 'white' | 'off' | 'dark' | 'gradient'

/** O que o Deck passa a cada slide: a posição dele na sequência. */
export interface SlideMeta {
  id: string
  index: number
  total: number
  /** Texto do eyebrow: "NN · label". */
  label: string
}

interface SlideProps extends SlideMeta {
  tone?: SlideTone
  className?: string
  /** Contorno do símbolo sangrando pelo canto superior direito (manual, seção 10). */
  contour?: boolean
  /** Sem eyebrow (capa). */
  bare?: boolean
  children: ReactNode
}

const tones: Record<SlideTone, string> = {
  white: 'bg-white text-brand-ink',
  off: 'bg-brand-off-white text-brand-ink',
  dark: 'on-dark bg-brand-blue text-white',
  gradient: 'on-dark bg-brand-gradient text-white',
}

const isDarkTone = (tone: SlideTone) => tone === 'dark' || tone === 'gradient'

const isPrintPreview = () => typeof window !== 'undefined' && window.matchMedia('print').matches

export function Slide({ id, index, total, label, tone = 'white', className, contour = false, bare = false, children }: SlideProps) {
  const dark = isDarkTone(tone)
  const n = String(index).padStart(2, '0')
  const desktop = useIsDesktop()
  const { outer, inner } = useFitZoom(desktop || isPrintPreview())
  return (
    <section
      id={`slide-${index + 1}`}
      data-slide={index}
      data-slide-id={id}
      data-tone={tone}
      data-label={label}
      aria-label={`Slide ${index + 1} de ${total}: ${label}`}
      className={cn('deck-slide relative flex min-h-dvh w-full snap-start flex-col overflow-hidden lg:snap-always', tones[tone], className)}
    >
      {contour && (
        <LogoOutline
          className={cn('pointer-events-none absolute -right-[8%] -top-[34%] h-[150%] w-auto', dark ? 'text-white/[0.32]' : 'text-brand-purple/[0.2]')}
        />
      )}
      <div className="relative flex min-h-dvh flex-1 flex-col px-[var(--dk-mx)] pb-[var(--dk-mb)] pt-[var(--dk-mt)]">
        {!bare && (
          <div className={cn('flex items-center gap-3 text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.16em]', dark ? 'text-white/80' : 'text-brand-purple')}>
            <ModuleTrail tone={dark ? 'white' : 'purple'} />
            <span>
              {n} · {label}
            </span>
          </div>
        )}
        <div ref={outer} className="flex min-h-0 flex-1 flex-col justify-center py-[var(--dk-gap)]">
          <div ref={inner} className="deck-fit">{children}</div>
        </div>
        <footer
          className={cn(
            'deck-slide-footer mt-auto hidden items-center justify-between text-[length:var(--dk-small)] sm:flex',
            dark ? 'text-white/60' : 'text-brand-gray',
          )}
          aria-hidden
        >
          <span className="font-medium">Natcorp · {deckMeta.edition}</span>
          <span className="inline-flex items-center gap-2 font-semibold tabular">
            <Logo variant="symbol" tone={dark ? 'white' : 'gradient'} decorative className="h-[1.1em] w-[1.1em]" />
            {index + 1} / {total}
          </span>
        </footer>
      </div>
    </section>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Tipografia do deck
 * ---------------------------------------------------------------------------------------------- */

interface SlideTitleProps {
  text: string
  as?: 'h1' | 'h2'
  dark?: boolean
  className?: string
  id?: string
  delay?: number
}

/** Título do slide: revelação palavra a palavra; trechos [[assim]] recebem a cor de destaque. */
export function SlideTitle({ text, as = 'h2', dark = false, className, id, delay = 0.05 }: SlideTitleProps) {
  return (
    <SplitText
      as={as}
      id={id}
      text={text}
      delay={delay}
      className={cn(
        'font-extrabold leading-[1.04] tracking-brand',
        as === 'h1' ? 'text-[length:var(--dk-h1)]' : 'text-[length:var(--dk-h2)]',
        dark ? 'text-white' : 'text-brand-ink',
        className,
      )}
      highlightClassName={dark ? 'text-[#E4A9C4]' : 'text-brand-purple'}
    />
  )
}

/** Texto curto com trechos [[destacados]] na cor da marca, sem animação. */
export function Marked({ text, className, dark = false }: { text: string; className?: string; dark?: boolean }) {
  const parts = text.split(/\[\[|\]\]/)
  return (
    <span className={className}>
      {parts.map((part, i) =>
        i % 2 === 1 ? (
          <b key={`${part}-${i}`} className={cn('font-extrabold', dark ? 'text-[#E4A9C4]' : 'text-brand-purple')}>
            {part}
          </b>
        ) : (
          <span key={`${part}-${i}`}>{part}</span>
        ),
      )}
    </span>
  )
}

interface RiseProps extends HTMLMotionProps<'div'> {
  delay?: number
  y?: number
  duration?: number
}

/** Bloco que sobe e aparece quando o slide entra na tela (uma vez). */
export function Rise({ children, delay = 0, y = 22, duration = DUR.slow, className, ...rest }: RiseProps) {
  return (
    <m.div
      className={className}
      initial={{ opacity: 0, y }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, amount: 0.1 }}
      transition={{ duration, ease: EASE, delay }}
      {...rest}
    >
      {children}
    </m.div>
  )
}

const itemUp: Variants = {
  hidden: { opacity: 0, y: 18 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.6, ease: EASE } },
}

type ListTag = 'div' | 'ul' | 'ol' | 'li'

interface StaggerProps extends HTMLMotionProps<'div'> {
  stagger?: number
  delay?: number
  /** Elemento renderizado (lista semântica quando os itens são uma lista). */
  as?: ListTag
}

/** Contêiner que orquestra a entrada escalonada dos filhos `Item`. */
export function Stagger({ children, stagger = 0.07, delay = 0.15, className, as = 'div', ...rest }: StaggerProps) {
  const Comp = m[as] as typeof m.div
  return (
    <Comp
      className={className}
      variants={{ hidden: {}, visible: { transition: { staggerChildren: stagger, delayChildren: delay } } }}
      initial="hidden"
      whileInView="visible"
      viewport={{ once: true, amount: 0.1 }}
      {...rest}
    >
      {children}
    </Comp>
  )
}

export function Item({ children, className, as = 'div', ...rest }: HTMLMotionProps<'div'> & { as?: ListTag }) {
  const Comp = m[as] as typeof m.div
  return (
    <Comp variants={itemUp} className={className} {...rest}>
      {children}
    </Comp>
  )
}

interface LeadProps {
  children: ReactNode
  dark?: boolean
  className?: string
  delay?: number
}

/** Parágrafo de apoio sob o título. */
export function SlideLead({ children, dark = false, className, delay = 0.25 }: LeadProps) {
  return (
    <Rise delay={delay} y={14}>
      <p className={cn('text-[length:var(--dk-lead)] leading-relaxed', dark ? 'text-white/78' : 'text-brand-graphite', className)}>{children}</p>
    </Rise>
  )
}

interface BigProps {
  value: string | number
  /** Palavra pequena antes do número ("até"). */
  kicker?: string
  prefix?: string
  suffix?: string
  label: string
  dark?: boolean
  size?: 'lg' | 'md'
  /** Cor do número: roxo (padrão), rosa (o dado que importa) ou branco. */
  accent?: 'purple' | 'pink' | 'white'
  className?: string
}

/** Número de destaque em ExtraBold com cor de destaque e legenda curta (manual, seção 14). */
export function Big({ value, kicker, prefix = '', suffix = '', label, dark = false, size = 'lg', accent, className }: BigProps) {
  const color = accent === 'pink' ? 'text-brand-pink' : accent === 'white' || (dark && !accent) ? 'text-white' : 'text-brand-purple'
  return (
    <div className={cn('min-w-0', className)}>
      <p className={cn('font-extrabold leading-none tracking-brand tabular', size === 'lg' ? 'text-[length:var(--dk-big)]' : 'text-[length:var(--dk-mid)]', dark && accent === 'pink' ? 'text-[#E4A9C4]' : color)}>
        {kicker && <span className="mr-[0.18em] text-[0.42em] font-bold">{kicker}</span>}
        {typeof value === 'number' ? <Counter value={value} prefix={prefix} suffix={suffix} /> : `${prefix}${value}${suffix}`}
      </p>
      <p className={cn('mt-2 max-w-[18rem] text-[length:var(--dk-small)] font-medium leading-snug', dark ? 'text-white/70' : 'text-brand-graphite')}>{label}</p>
    </div>
  )
}

interface ChipProps extends HTMLAttributes<HTMLSpanElement> {
  dark?: boolean
  tone?: 'purple' | 'pink' | 'neutral'
}

/** Etiqueta curta (perfis, plataformas, serviços). */
export function Chip({ dark = false, tone = 'neutral', className, children, ...rest }: ChipProps) {
  return (
    <span
      className={cn(
        'inline-flex items-center gap-1.5 rounded-full border px-[0.8em] py-[0.35em] text-[length:var(--dk-small)] font-semibold leading-none',
        dark
          ? tone === 'pink'
            ? 'border-[#E4A9C4]/50 bg-[#E4A9C4]/10 text-white'
            : 'border-white/20 bg-white/[0.06] text-white/90'
          : tone === 'purple'
            ? 'border-brand-purple/20 bg-brand-purple/[0.06] text-brand-purple'
            : tone === 'pink'
              ? 'border-brand-pink/30 bg-brand-pink/[0.08] text-brand-ink'
              : 'border-brand-mist bg-white text-brand-graphite',
        className,
      )}
      {...rest}
    >
      {children}
    </span>
  )
}

interface CardProps extends HTMLAttributes<HTMLDivElement> {
  dark?: boolean
  /** Realce em rosa: o cartão que importa. */
  accent?: boolean
}

/** Cartão com borda em Névoa (claro) ou vidro leve (escuro). */
export function Card({ dark = false, accent = false, className, children, ...rest }: CardProps) {
  return (
    <div
      className={cn(
        'rounded-2xl border p-[var(--dk-card)]',
        dark
          ? accent
            ? 'border-[#E4A9C4]/40 bg-white/[0.06]'
            : 'border-white/12 bg-white/[0.05]'
          : accent
            ? 'border-brand-pink/40 bg-white shadow-soft'
            : 'border-brand-mist bg-white shadow-soft',
        className,
      )}
      {...rest}
    >
      {children}
    </div>
  )
}

/** Quadrado com ícone, no estilo dos menus do site. */
export function IconBox({ dark = false, className, children }: { dark?: boolean; className?: string; children: ReactNode }) {
  return (
    <span
      className={cn(
        'flex h-[var(--dk-icon)] w-[var(--dk-icon)] shrink-0 items-center justify-center rounded-lg [&_svg]:h-[55%] [&_svg]:w-[55%]',
        dark ? 'bg-white/10 text-[#E4A9C4]' : 'bg-brand-purple/[0.08] text-brand-purple',
        className,
      )}
      aria-hidden
    >
      {children}
    </span>
  )
}
