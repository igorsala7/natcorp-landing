import type { HTMLAttributes, ReactNode } from 'react'
import { cn } from '@/lib/utils'
import { ModuleTrail } from '@/components/brand/Logo'
import { SplitText } from '@/components/motion/SplitText'
import { Reveal } from '@/components/motion/Reveal'

type Tone = 'white' | 'off' | 'dark' | 'gradient'

interface SectionProps extends HTMLAttributes<HTMLElement> {
  tone?: Tone
  children: ReactNode
  /** Remove o padding vertical padrão. */
  flush?: boolean
}

const tones: Record<Tone, string> = {
  white: 'bg-white text-brand-ink',
  off: 'bg-brand-off-white text-brand-ink',
  dark: 'on-dark bg-brand-blue text-white',
  gradient: 'on-dark bg-brand-gradient text-white',
}

export function Section({ tone = 'white', className, children, flush = false, ...rest }: SectionProps) {
  return (
    <section className={cn('relative', tones[tone], !flush && 'py-20 sm:py-24 lg:py-32', className)} {...rest}>
      {children}
    </section>
  )
}

interface EyebrowProps {
  children: ReactNode
  tone?: 'purple' | 'white' | 'pink'
  className?: string
  trail?: boolean
}

/** Rótulo de seção: trilha de módulos + texto curto em caixa alta. */
export function Eyebrow({ children, tone = 'purple', className, trail = true }: EyebrowProps) {
  return (
    <div
      className={cn(
        'flex items-center gap-3 text-[12px] font-semibold uppercase tracking-[0.16em]',
        tone === 'white' ? 'text-white/80' : tone === 'pink' ? 'text-brand-pink' : 'text-brand-purple',
        className,
      )}
    >
      {trail && <ModuleTrail tone={tone === 'white' ? 'white' : 'purple'} />}
      <span>{children}</span>
    </div>
  )
}

interface SectionHeaderProps {
  eyebrow?: string
  title: string
  lead?: string
  align?: 'left' | 'center'
  tone?: 'light' | 'dark'
  className?: string
  titleAs?: 'h1' | 'h2' | 'h3'
  titleClassName?: string
  id?: string
}

export function SectionHeader({
  eyebrow,
  title,
  lead,
  align = 'left',
  tone = 'light',
  className,
  titleAs = 'h2',
  titleClassName,
  id,
}: SectionHeaderProps) {
  const dark = tone === 'dark'
  return (
    <div className={cn('max-w-3xl', align === 'center' && 'mx-auto text-center', className)}>
      {eyebrow && (
        <Reveal y={12} duration={0.5}>
          <Eyebrow tone={dark ? 'white' : 'purple'} className={cn(align === 'center' && 'justify-center')}>
            {eyebrow}
          </Eyebrow>
        </Reveal>
      )}
      <SplitText
        id={id}
        as={titleAs}
        text={title}
        className={cn(
          'mt-5 text-[2rem] font-extrabold leading-[1.08] sm:text-4xl lg:text-5xl',
          dark ? 'text-white' : 'text-brand-ink',
          titleClassName,
        )}
        highlightClassName={dark ? 'text-[#E4A9C4]' : 'text-brand-purple'}
      />
      {lead && (
        <Reveal delay={0.25} y={16}>
          <p className={cn('mt-5 text-lg leading-relaxed sm:text-xl', dark ? 'text-white/75' : 'text-brand-graphite')}>
            {lead}
          </p>
        </Reveal>
      )}
    </div>
  )
}
