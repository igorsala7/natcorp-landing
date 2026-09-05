import type { HTMLAttributes } from 'react'
import nati from '@/assets/avatars/nati.png'
import { cn } from '@/lib/utils'

interface NatiAvatarProps extends HTMLAttributes<HTMLSpanElement> {
  /** Anel rosa ao redor (como no chat do sistema). */
  ring?: boolean
  decorative?: boolean
}

/**
 * Avatar oficial da NATI: personagem 3D (cabelo roxo, headset, blusa rosa) sobre um disco claro,
 * como no material da Natcorp. O arquivo em src/assets/avatars/nati.png pode ser trocado pelo
 * original em alta resolução sem mexer no código.
 */
export function NatiAvatar({ ring = false, decorative = true, className, ...rest }: NatiAvatarProps) {
  return (
    <span
      className={cn(
        'relative block aspect-square overflow-hidden rounded-full bg-[linear-gradient(180deg,#FFFFFF_0%,#F3E8F5_100%)]',
        ring && 'shadow-[0_0_0_2px_#E4A9C4]',
        className,
      )}
      role={decorative ? undefined : 'img'}
      aria-hidden={decorative || undefined}
      aria-label={decorative ? undefined : 'NATI, assistente de RH'}
      {...rest}
    >
      <img src={nati} alt="" draggable={false} className="absolute inset-0 h-full w-full translate-y-[7%] scale-[1.18] object-cover" />
    </span>
  )
}
