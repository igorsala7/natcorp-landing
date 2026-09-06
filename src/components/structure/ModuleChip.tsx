import { Link } from 'react-router'
import { getModuleEntry, modulePath } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import { cn } from '@/lib/utils'

interface ModuleChipProps {
  slug: string
  /** 'light' sobre fundos claros; 'dark' sobre o azul profundo e o gradiente. */
  tone?: 'light' | 'dark'
  size?: 'sm' | 'md'
  className?: string
}

/** Chip de módulo com ícone e nome, ligando à página do módulo. Usado nas páginas de estrutura. */
export function ModuleChip({ slug, tone = 'light', size = 'md', className }: ModuleChipProps) {
  const entry = getModuleEntry(slug)
  if (!entry) return null
  const Icon = moduleIcons[entry.icon]
  const dark = tone === 'dark'
  const sm = size === 'sm'
  return (
    <Link
      to={modulePath(slug)}
      className={cn(
        'group/chip inline-flex items-center gap-2 rounded-xl border font-bold transition-[border-color,box-shadow,transform,background-color] duration-300 ease-brand hover:-translate-y-0.5 focus-visible:outline-none focus-visible:ring-2',
        sm ? 'py-1 pl-1.5 pr-2.5 text-[12.5px]' : 'py-1.5 pl-2 pr-3 text-[13px]',
        dark
          ? 'border-white/20 bg-white/10 text-white hover:border-white/50 hover:bg-white/[0.16] focus-visible:ring-[#E4A9C4]'
          : 'border-brand-mist bg-white text-brand-ink hover:border-brand-purple/40 hover:shadow-soft focus-visible:ring-brand-purple',
        className,
      )}
    >
      <span
        className={cn(
          'flex shrink-0 items-center justify-center rounded-lg',
          sm ? 'h-6 w-6' : 'h-7 w-7',
          dark ? 'bg-[#E4A9C4] text-brand-blue' : 'bg-brand-off-white text-brand-purple',
        )}
      >
        <Icon className={sm ? 'h-3 w-3' : 'h-3.5 w-3.5'} strokeWidth={1.8} aria-hidden />
      </span>
      {entry.name}
    </Link>
  )
}
