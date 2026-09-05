import type { SVGProps } from 'react'
import { cn } from '@/lib/utils'
import { useBrandGradientId } from '@/hooks/useBrandGradientId'

interface EmployeeAvatarProps extends Omit<SVGProps<SVGSVGElement>, 'children'> {
  ring?: boolean
  decorative?: boolean
}

/**
 * Avatar da colaboradora fictícia (Ana Ribeiro) no mesmo estilo da NATI:
 * cabelo escuro, óculos redondos e blusa em Azul Profundo. Substitui fotos reais nas telas reproduzidas.
 */
export function EmployeeAvatar({ ring = false, decorative = true, className, ...rest }: EmployeeAvatarProps) {
  const id = useBrandGradientId()
  const g = (n: string) => `${id}-${n}`
  return (
    <svg
      viewBox="0 0 128 128"
      className={cn('block', className)}
      role={decorative ? undefined : 'img'}
      aria-hidden={decorative || undefined}
      aria-label={decorative ? undefined : 'Avatar da colaboradora'}
      focusable="false"
      {...rest}
    >
      <defs>
        <linearGradient id={g('hair')} x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#4A3560" />
          <stop offset="1" stopColor="#24162F" />
        </linearGradient>
        <radialGradient id={g('face')} cx="0.42" cy="0.35" r="0.75">
          <stop offset="0" stopColor="#F7D3B5" />
          <stop offset="1" stopColor="#E3A67E" />
        </radialGradient>
        <linearGradient id={g('shirt')} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#3E2A7A" />
          <stop offset="1" stopColor="#2C1A63" />
        </linearGradient>
        <clipPath id={g('clip')}>
          <circle cx="64" cy="64" r="64" />
        </clipPath>
      </defs>

      {ring && <circle cx="64" cy="64" r="63" fill="none" stroke="#511C76" strokeWidth="3" />}

      <g clipPath={ring ? `url(#${g('clip')})` : undefined}>
        <path d="M26 80 C20 54 34 28 64 28 C94 28 108 54 102 80 C100 92 96 100 90 106 L38 106 C32 100 28 92 26 80 Z" fill={`url(#${g('hair')})`} />
        <path d="M12 132 C12 106 32 98 64 98 C96 98 116 106 116 132 Z" fill={`url(#${g('shirt')})`} />
        <path d="M54 82 H74 V98 C74 103 70 106 64 106 C58 106 54 103 54 98 Z" fill="#D8976F" />
        <ellipse cx="64" cy="62" rx="29" ry="31" fill={`url(#${g('face')})`} />
        <path d="M35 58 C36 32 92 32 93 58 C86 48 78 46 70 50 C66 44 62 44 58 50 C50 46 42 48 35 58 Z" fill={`url(#${g('hair')})`} />
        <path d="M36 56 C30 72 32 88 40 98 L34 98 C24 88 26 68 36 56 Z" fill={`url(#${g('hair')})`} />
        <path d="M92 56 C98 72 96 88 88 98 L94 98 C104 88 102 68 92 56 Z" fill={`url(#${g('hair')})`} />
        <ellipse cx="52" cy="40" rx="13" ry="4.5" fill="#fff" opacity="0.12" transform="rotate(-18 52 40)" />

        <path d="M45 54 Q51 50.5 57 54" fill="none" stroke="#3B2A4A" strokeWidth="2.4" strokeLinecap="round" />
        <path d="M71 54 Q77 50.5 83 54" fill="none" stroke="#3B2A4A" strokeWidth="2.4" strokeLinecap="round" />
        <ellipse cx="52" cy="64" rx="3" ry="4.2" fill="#2B1A3A" />
        <ellipse cx="76" cy="64" rx="3" ry="4.2" fill="#2B1A3A" />
        <circle cx="53" cy="62.6" r="1" fill="#fff" />
        <circle cx="77" cy="62.6" r="1" fill="#fff" />
        {/* óculos */}
        <circle cx="52" cy="64" r="9.5" fill="#fff" fillOpacity="0.08" stroke="#2B1A3A" strokeWidth="2.2" />
        <circle cx="76" cy="64" r="9.5" fill="#fff" fillOpacity="0.08" stroke="#2B1A3A" strokeWidth="2.2" />
        <path d="M61.5 64 H66.5" stroke="#2B1A3A" strokeWidth="2.2" strokeLinecap="round" />
        <path d="M42.5 63 L37 61" stroke="#2B1A3A" strokeWidth="2.2" strokeLinecap="round" />
        <path d="M85.5 63 L91 61" stroke="#2B1A3A" strokeWidth="2.2" strokeLinecap="round" />
        <ellipse cx="64" cy="71" rx="3" ry="2.3" fill="#D08560" opacity="0.85" />
        <path d="M56 78 Q64 84 72 78" fill="none" stroke="#6B3A2E" strokeWidth="2.3" strokeLinecap="round" />
        <circle cx="46" cy="73" r="5" fill="#F48FA0" opacity="0.4" />
        <circle cx="82" cy="73" r="5" fill="#F48FA0" opacity="0.4" />
      </g>
    </svg>
  )
}
