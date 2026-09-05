import type { HTMLAttributes } from 'react'
import ana from '@/assets/avatars/ana.png'
import { cn } from '@/lib/utils'

interface EmployeeAvatarProps extends HTMLAttributes<HTMLSpanElement> {
  ring?: boolean
  decorative?: boolean
}

/**
 * Avatar da colaboradora fictícia (Ana Ribeiro), no mesmo estilo 3D da NATI:
 * cabelo escuro preso, óculos redondos e blusa em Azul Profundo. Substitui fotos reais nas telas reproduzidas.
 */
export function EmployeeAvatar({ ring = false, decorative = true, className, ...rest }: EmployeeAvatarProps) {
  return (
    <span
      className={cn(
        'relative block aspect-square overflow-hidden rounded-full bg-[linear-gradient(180deg,#FFFFFF_0%,#EDE4F4_100%)]',
        ring && 'shadow-[0_0_0_2px_#E4A9C4]',
        className,
      )}
      role={decorative ? undefined : 'img'}
      aria-hidden={decorative || undefined}
      aria-label={decorative ? undefined : 'Avatar da colaboradora Ana'}
      {...rest}
    >
      <img src={ana} alt="" draggable={false} className="absolute inset-0 h-full w-full translate-y-[7%] scale-[1.18] object-cover" />
    </span>
  )
}
