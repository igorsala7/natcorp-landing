import { forwardRef, useId } from 'react'
import { Logo } from '@/components/brand/Logo'
import { cn } from '@/lib/utils'

interface ModuleCoreProps {
  /** Lado da caixa (px). O disco ocupa 62% dela; o resto são anéis e brilho. */
  size?: number
  reduced: boolean
  className?: string
}

/**
 * A base de dados: um disco no gradiente da marca com o símbolo da Natcorp, um anel tracejado
 * girando devagar e ondas que se afastam do centro (SMIL, desligadas com movimento reduzido).
 * A ref aponta para o disco, para as ligações do palco mirarem na borda dele.
 */
export const ModuleCore = forwardRef<HTMLDivElement, ModuleCoreProps>(function ModuleCore({ size = 220, reduced, className }, ref) {
  const uid = useId().replace(/[^a-zA-Z0-9]/g, '')
  const haloId = `mc-halo-${uid}`
  const disc = Math.round(size * 0.62)

  return (
    <div className={cn('relative grid shrink-0 place-items-center', className)} style={{ width: size, height: size }}>
      <svg viewBox="0 0 200 200" className="absolute inset-0 h-full w-full overflow-visible" aria-hidden focusable="false">
        <defs>
          <radialGradient id={haloId} cx="0.5" cy="0.5" r="0.5">
            <stop offset="0" stopColor="#C95788" stopOpacity="0.28" />
            <stop offset="0.55" stopColor="#9A408A" stopOpacity="0.12" />
            <stop offset="1" stopColor="#9A408A" stopOpacity="0" />
          </radialGradient>
        </defs>
        <circle cx="100" cy="100" r="100" fill={`url(#${haloId})`} />
        {/* anel tracejado, girando */}
        <circle cx="100" cy="100" r="86" fill="none" stroke="#511C76" strokeOpacity="0.28" strokeWidth="1" strokeDasharray="2 9" strokeLinecap="round">
          {!reduced && <animateTransform attributeName="transform" type="rotate" from="0 100 100" to="360 100 100" dur="70s" repeatCount="indefinite" />}
        </circle>
        <circle cx="100" cy="100" r="74" fill="none" stroke="#511C76" strokeOpacity="0.1" strokeWidth="1" />
        {/* ondas que saem do disco */}
        {!reduced &&
          [0, 1.5].map((delay) => (
            <circle key={delay} cx="100" cy="100" r="64" fill="none" stroke="#C95788" strokeWidth="1.5">
              <animate attributeName="r" from="64" to="98" dur="3s" begin={`${delay}s`} repeatCount="indefinite" />
              <animate attributeName="stroke-opacity" from="0.55" to="0" dur="3s" begin={`${delay}s`} repeatCount="indefinite" />
            </circle>
          ))}
      </svg>

      <div
        ref={ref}
        className="relative flex flex-col items-center justify-center rounded-full bg-brand-gradient text-white shadow-[0_18px_40px_-16px_rgba(81,28,118,0.6),inset_0_1px_0_rgba(255,255,255,0.25)]"
        style={{ width: disc, height: disc }}
      >
        <span className="absolute inset-[3px] rounded-full border border-white/20" aria-hidden />
        <Logo variant="symbol" tone="white" decorative className="h-auto w-[48%] drop-shadow-[0_6px_14px_rgba(27,18,56,0.35)]" />
      </div>
    </div>
  )
})

/** Legenda sob a base: o que ela significa em quatro palavras. */
export function BaseLabel({ className }: { className?: string }) {
  return (
    <p
      className={cn(
        'inline-flex items-center gap-2 rounded-full border border-brand-mist bg-white px-3.5 py-1.5 text-[11.5px] font-bold uppercase tracking-[0.14em] text-brand-purple shadow-soft',
        className,
      )}
    >
      <span className="h-1.5 w-1.5 rotate-45 rounded-[1px] bg-brand-gradient" aria-hidden />
      Uma base de dados
      <span className="h-1 w-1 rounded-full bg-brand-graphite/40" aria-hidden />
      Um cadastro
    </p>
  )
}
