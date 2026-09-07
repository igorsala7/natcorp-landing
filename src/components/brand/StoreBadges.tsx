import { natPontoStores } from '@/content/site'
import { cn } from '@/lib/utils'

type Store = 'apple' | 'google'

/* Marcas das lojas (traçados do Simple Icons, CC0). */
const glyphs: Record<Store, string> = {
  apple:
    'M12.152 6.896c-.948 0-2.415-1.078-3.96-1.04-2.04.027-3.91 1.183-4.961 3.014-2.117 3.675-.546 9.103 1.519 12.09 1.013 1.454 2.208 3.09 3.792 3.039 1.52-.065 2.09-.987 3.935-.987 1.831 0 2.35.987 3.96.948 1.637-.026 2.676-1.48 3.676-2.948 1.156-1.688 1.636-3.325 1.662-3.415-.039-.013-3.182-1.221-3.22-4.857-.026-3.04 2.48-4.494 2.597-4.559-1.429-2.09-3.623-2.324-4.39-2.376-2-.156-3.675 1.09-4.61 1.09zM15.53 3.83c.843-1.012 1.4-2.427 1.245-3.83-1.207.052-2.662.805-3.532 1.818-.78.896-1.454 2.338-1.273 3.714 1.338.104 2.715-.688 3.559-1.701',
  google:
    'M22.018 13.298l-3.919 2.218-3.515-3.493 3.543-3.521 3.891 2.202a1.49 1.49 0 0 1 0 2.594zM1.337.924a1.486 1.486 0 0 0-.112.568v21.017c0 .217.045.419.124.6l11.155-11.087L1.337.924zm12.207 10.065l3.258-3.238L3.45.195a1.466 1.466 0 0 0-.946-.179l11.04 10.973zm0 2.067l-11 10.933c.298.036.612-.016.906-.183l13.324-7.54-3.23-3.21z',
}

const copy: Record<Store, { small: string; big: string; aria: string }> = {
  apple: { small: 'Baixar na', big: 'App Store', aria: 'Baixar o NatPonto na App Store' },
  google: { small: 'Disponível no', big: 'Google Play', aria: 'Baixar o NatPonto no Google Play' },
}

interface StoreBadgeProps {
  store: Store
  /** `dark` para fundos escuros (selo branco), `light` para fundos claros (selo escuro). */
  tone?: 'dark' | 'light'
  className?: string
}

/** Selo de loja do app NatPonto, no padrão das lojas: marca à esquerda, duas linhas de texto. */
export function StoreBadge({ store, tone = 'dark', className }: StoreBadgeProps) {
  const c = copy[store]
  return (
    <a
      href={natPontoStores[store]}
      target="_blank"
      rel="noopener noreferrer"
      aria-label={c.aria}
      className={cn(
        'group inline-flex h-12 items-center gap-2.5 rounded-xl border pl-3 pr-4 transition-[transform,background-color,border-color] duration-300 ease-brand hover:-translate-y-0.5',
        tone === 'dark' ? 'border-white/25 bg-white text-brand-ink hover:border-white' : 'border-brand-ink bg-brand-ink text-white hover:bg-[#2C1A63]',
        className,
      )}
    >
      <svg viewBox="0 0 24 24" className="h-6 w-6 shrink-0" aria-hidden focusable="false">
        <path d={glyphs[store]} fill="currentColor" />
      </svg>
      <span className="flex flex-col leading-none">
        <span className="text-[10px] font-semibold uppercase tracking-[0.06em] opacity-75">{c.small}</span>
        <span className="mt-0.5 text-[16px] font-extrabold tracking-tight">{c.big}</span>
      </span>
    </a>
  )
}

/** Os dois selos, lado a lado. */
export function StoreBadges({ tone = 'dark', className }: { tone?: 'dark' | 'light'; className?: string }) {
  return (
    <div className={cn('flex flex-wrap items-center gap-3', className)}>
      <StoreBadge store="apple" tone={tone} />
      <StoreBadge store="google" tone={tone} />
    </div>
  )
}
