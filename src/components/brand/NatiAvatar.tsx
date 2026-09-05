import type { SVGProps } from 'react'
import { cn } from '@/lib/utils'
import { useBrandGradientId } from '@/hooks/useBrandGradientId'

interface NatiAvatarProps extends Omit<SVGProps<SVGSVGElement>, 'children'> {
  /** Anel rosa ao redor (como no chat do sistema). */
  ring?: boolean
  decorative?: boolean
}

/**
 * Avatar da NATI reproduzido em vetor: cabelo roxo, headset, blusa rosa.
 * Construído em SVG para escalar sem perda e seguir a paleta da marca.
 */
export function NatiAvatar({ ring = false, decorative = true, className, ...rest }: NatiAvatarProps) {
  const id = useBrandGradientId()
  const g = (n: string) => `${id}-${n}`
  return (
    <svg
      viewBox="0 0 128 128"
      className={cn('block', className)}
      role={decorative ? undefined : 'img'}
      aria-hidden={decorative || undefined}
      aria-label={decorative ? undefined : 'NATI, assistente de RH'}
      focusable="false"
      {...rest}
    >
      <defs>
        <linearGradient id={g('hair')} x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#B27BE0" />
          <stop offset="1" stopColor="#7B47B4" />
        </linearGradient>
        <radialGradient id={g('face')} cx="0.42" cy="0.35" r="0.75">
          <stop offset="0" stopColor="#FFD3B0" />
          <stop offset="1" stopColor="#F0A87E" />
        </radialGradient>
        <linearGradient id={g('shirt')} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#FF95A8" />
          <stop offset="1" stopColor="#EE6C86" />
        </linearGradient>
        <linearGradient id={g('set')} x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#5C2F82" />
          <stop offset="1" stopColor="#3B1C5C" />
        </linearGradient>
        <clipPath id={g('clip')}>
          <circle cx="64" cy="64" r="64" />
        </clipPath>
      </defs>

      {ring && <circle cx="64" cy="64" r="63" fill="none" stroke="#E4A9C4" strokeWidth="3" />}

      <g clipPath={ring ? `url(#${g('clip')})` : undefined}>
        {/* cabelo (fundo) */}
        <path
          d="M24 78 C18 56 30 30 64 30 C98 30 110 56 104 78 C102 92 96 100 88 104 L40 104 C32 100 26 92 24 78 Z"
          fill={`url(#${g('hair')})`}
        />
        {/* blusa */}
        <path d="M12 132 C12 106 32 98 64 98 C96 98 116 106 116 132 Z" fill={`url(#${g('shirt')})`} />
        {/* pescoço */}
        <path d="M54 82 H74 V98 C74 103 70 106 64 106 C58 106 54 103 54 98 Z" fill="#E69C74" />
        {/* rosto */}
        <ellipse cx="64" cy="62" rx="29" ry="31" fill={`url(#${g('face')})`} />
        {/* franja */}
        <path
          d="M34 56 C36 30 92 30 94 56 C88 50 82 47 76 51 C70 43 58 43 52 51 C46 47 40 50 34 56 Z"
          fill={`url(#${g('hair')})`}
        />
        <path d="M36 54 C28 70 30 86 40 96 L34 96 C22 86 24 66 36 54 Z" fill={`url(#${g('hair')})`} />
        <path d="M92 54 C100 70 98 86 88 96 L94 96 C106 86 104 66 92 54 Z" fill={`url(#${g('hair')})`} />
        <ellipse cx="50" cy="40" rx="14" ry="5" fill="#fff" opacity="0.16" transform="rotate(-18 50 40)" />

        {/* headset: haste, fones e microfone */}
        <path d="M27 60 C27 24 101 24 101 60" fill="none" stroke={`url(#${g('set')})`} strokeWidth="7" strokeLinecap="round" />
        <rect x="17" y="52" width="15" height="26" rx="7.5" fill={`url(#${g('set')})`} />
        <rect x="96" y="52" width="15" height="26" rx="7.5" fill={`url(#${g('set')})`} />
        <rect x="21" y="57" width="7" height="16" rx="3.5" fill="#7A48B3" opacity="0.6" />
        <rect x="100" y="57" width="7" height="16" rx="3.5" fill="#7A48B3" opacity="0.6" />
        <path d="M103 74 C103 86 90 90 76 86" fill="none" stroke="#3B1C5C" strokeWidth="3.5" strokeLinecap="round" />
        <circle cx="74" cy="85" r="4.2" fill="#3B1C5C" />

        {/* sobrancelhas, olhos, nariz, boca, bochechas */}
        <path d="M45 53 Q51 49.5 57 53" fill="none" stroke="#8B55C2" strokeWidth="2.6" strokeLinecap="round" />
        <path d="M71 53 Q77 49.5 83 53" fill="none" stroke="#8B55C2" strokeWidth="2.6" strokeLinecap="round" />
        <ellipse cx="52" cy="63" rx="3.2" ry="4.6" fill="#2B1A3A" />
        <ellipse cx="76" cy="63" rx="3.2" ry="4.6" fill="#2B1A3A" />
        <circle cx="53" cy="61.5" r="1" fill="#fff" />
        <circle cx="77" cy="61.5" r="1" fill="#fff" />
        <ellipse cx="64" cy="70" rx="3.2" ry="2.4" fill="#E08E66" opacity="0.85" />
        <path d="M55 77 Q64 84 73 77" fill="none" stroke="#6B3A2E" strokeWidth="2.4" strokeLinecap="round" />
        <circle cx="47" cy="72" r="5" fill="#F48FA0" opacity="0.45" />
        <circle cx="81" cy="72" r="5" fill="#F48FA0" opacity="0.45" />
      </g>
    </svg>
  )
}
