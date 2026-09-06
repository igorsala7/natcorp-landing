import type { HTMLAttributes } from 'react'
import { EmployeeAvatar } from '@/components/brand/EmployeeAvatar'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { busts, figures } from '@/content/journeyArt'
import { cast, castMember, type CastKey } from '@/content/hiringJourney'
import { cn } from '@/lib/utils'

interface CastAvatarProps extends HTMLAttributes<HTMLSpanElement> {
  who: CastKey
  ring?: boolean
  /** Tamanho do texto das iniciais, quando não há retrato. */
  initialsClassName?: string
}

/**
 * Avatar redondo de um personagem da história. A Ana e a NATI usam os avatares 3D oficiais;
 * os demais usam o retrato em src/assets/journey/bust-<personagem>.png (já recortado com o rosto no centro) quando existe, ou as iniciais.
 */
export function CastAvatar({ who, ring = false, className, initialsClassName = 'text-[11px]', ...rest }: CastAvatarProps) {
  if (who === 'ana') return <EmployeeAvatar ring={ring} className={className} {...rest} />
  if (who === 'nati') return <NatiAvatar ring={ring} className={className} {...rest} />
  const src = busts[who]
  const member = castMember(who)
  if (src) {
    return (
      <span
        aria-hidden
        className={cn('relative block aspect-square overflow-hidden rounded-full bg-[linear-gradient(180deg,#FFFFFF_0%,#EDE4F4_100%)]', ring && 'shadow-[0_0_0_2px_#E4A9C4]', className)}
        {...rest}
      >
        <img src={src} alt="" draggable={false} className="absolute inset-0 h-full w-full object-cover" />
      </span>
    )
  }
  return (
    <span
      aria-hidden
      className={cn(
        'flex aspect-square items-center justify-center rounded-full bg-brand-off-white font-extrabold text-brand-purple',
        ring && 'shadow-[0_0_0_2px_#E4A9C4]',
        initialsClassName,
        className,
      )}
      {...rest}
    >
      {member.initials}
    </span>
  )
}

interface CastFigureProps {
  who: CastKey
  alt: string
  className?: string
  imgClassName?: string
}

/** Figura 3D recortada (corpo inteiro ou meio corpo) de um personagem, quando o arquivo existe. */
export function CastFigure({ who, alt, className, imgClassName }: CastFigureProps) {
  const src = figures[who]
  if (!src) return null
  return (
    <figure className={cn('relative', className)}>
      <img src={src} alt={alt} draggable={false} className={cn('relative z-10 h-full w-auto max-w-none object-contain', imgClassName)} />
    </figure>
  )
}

/** Lista de quem aparece na história, com avatar, nome e papel. */
export function CastList({ className, compact = false }: { className?: string; compact?: boolean }) {
  return (
    <ul className={cn(compact ? 'flex flex-wrap gap-x-6 gap-y-3' : 'divide-y divide-brand-mist', className)}>
      {cast.map((c) => (
        <li key={c.key} className={cn('flex items-center gap-3', compact ? 'py-0.5' : 'py-2')}>
          <CastAvatar who={c.key} ring={c.hero} className="h-9 w-9 shrink-0" />
          <span className="min-w-0">
            <span className="block text-[13.5px] font-bold text-brand-ink">{c.name}</span>
            <span className="block text-[12px] leading-snug text-brand-graphite">{c.role}</span>
          </span>
        </li>
      ))}
    </ul>
  )
}
