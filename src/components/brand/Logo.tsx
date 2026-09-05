import type { SVGProps } from 'react'
import { useBrandGradientId } from '@/hooks/useBrandGradientId'
import { cn } from '@/lib/utils'
import { H_WIDTH, MODULES, SYMBOL_BOX, V_HEIGHT, WORDMARK_H, WORDMARK_V } from './logo-paths'

export type LogoTone = 'gradient' | 'flat' | 'white' | 'ink' | 'black'
export type LogoVariant = 'horizontal' | 'vertical' | 'symbol'

interface LogoProps extends Omit<SVGProps<SVGSVGElement>, 'children'> {
  variant?: LogoVariant
  tone?: LogoTone
  title?: string
  /** Quando true, o SVG é ignorado por leitores de tela (uso decorativo). */
  decorative?: boolean
}

const PURPLE = '#511C76'
const INK = '#1B1238'

/** Gradiente Natcorp: linear 135°, Ameixa 0% → Roxo Natcorp 50% → Azul Profundo 100%. */
export function BrandGradient({ id }: { id: string }) {
  return (
    <linearGradient id={id} gradientUnits="userSpaceOnUse" x1="0" y1="0" x2={SYMBOL_BOX} y2={SYMBOL_BOX}>
      <stop offset="0" stopColor="#9A408A" />
      <stop offset="0.5" stopColor="#511C76" />
      <stop offset="1" stopColor="#2C1A63" />
    </linearGradient>
  )
}

/**
 * Assinatura Natcorp construída em vetor a partir do manual de identidade:
 * símbolo (4 módulos a 45°) + wordmark em Manrope 640.
 */
export function Logo({
  variant = 'horizontal',
  tone = 'gradient',
  title = 'Natcorp',
  decorative = false,
  className,
  ...rest
}: LogoProps) {
  const gradId = useBrandGradientId()
  const symbolFill =
    tone === 'gradient' ? `url(#${gradId})` : tone === 'white' ? '#ffffff' : tone === 'black' ? '#000000' : PURPLE
  const wordFill = tone === 'white' ? '#ffffff' : tone === 'black' ? '#000000' : tone === 'flat' ? PURPLE : INK
  const viewBox =
    variant === 'horizontal'
      ? `0 0 ${H_WIDTH} ${SYMBOL_BOX}`
      : variant === 'vertical'
        ? `-2.5 0 13 ${V_HEIGHT}`
        : `0 0 ${SYMBOL_BOX} ${SYMBOL_BOX}`
  const words = variant === 'horizontal' ? WORDMARK_H : variant === 'vertical' ? WORDMARK_V : []

  return (
    <svg
      viewBox={viewBox}
      className={cn('block', className)}
      role={decorative ? undefined : 'img'}
      aria-hidden={decorative || undefined}
      aria-label={decorative ? undefined : title}
      focusable="false"
      {...rest}
    >
      {tone === 'gradient' && (
        <defs>
          <BrandGradient id={gradId} />
        </defs>
      )}
      {MODULES.map((d, i) => (
        <path key={i} d={d} fill={symbolFill} />
      ))}
      {words.map((d, i) => (
        <path key={i} d={d} fill={wordFill} />
      ))}
    </svg>
  )
}

/**
 * Grafismo "contorno" (manual, seção 10): o símbolo em um único traço de 1 px, sem preenchimento,
 * sangrando por um canto da peça. Cor via `currentColor` — roxo a 20–25% sobre branco, branco a 30–35% sobre roxo.
 */
export function LogoOutline({ className, strokeWidth = 1, ...rest }: SVGProps<SVGSVGElement>) {
  return (
    <svg
      viewBox={`0 0 ${SYMBOL_BOX} ${SYMBOL_BOX}`}
      aria-hidden
      focusable="false"
      className={cn('block', className)}
      {...rest}
    >
      {MODULES.map((d, i) => (
        <path
          key={i}
          d={d}
          fill="none"
          stroke="currentColor"
          strokeWidth={strokeWidth}
          vectorEffect="non-scaling-stroke"
        />
      ))}
    </svg>
  )
}

/** Trilha de módulos: o símbolo esmaece em cinco passos (100 → 12%). Divisor de seções. */
export function ModuleTrail({ className, tone = 'purple' }: { className?: string; tone?: 'purple' | 'white' }) {
  const steps = [1, 0.62, 0.38, 0.22, 0.12]
  return (
    <div className={cn('flex items-center gap-2', className)} aria-hidden>
      {steps.map((o) => (
        <svg key={o} viewBox={`0 0 ${SYMBOL_BOX} ${SYMBOL_BOX}`} className="h-3.5 w-3.5" style={{ opacity: o }}>
          {MODULES.map((d, i) => (
            <path key={i} d={d} fill={tone === 'white' ? '#fff' : PURPLE} />
          ))}
        </svg>
      ))}
    </div>
  )
}
