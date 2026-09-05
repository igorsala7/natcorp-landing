import type { ReactNode } from 'react'
import { Bell, LogOut, Menu, Wifi, X } from 'lucide-react'
import { Logo } from '@/components/brand/Logo'
import { cn } from '@/lib/utils'

export const NATPONTO_SIZE = { width: 320, height: 690 } as const

interface NatPontoFrameProps {
  children: ReactNode
  /** 'app' = barra com menu, logo, sino e sair; 'modal' = título com X; 'none' = tela cheia. */
  topBar?: 'app' | 'modal' | 'none'
  title?: string
  clock?: string
  className?: string
  label?: string
}

/** Moldura do celular com a barra de status e a barra do app NatPonto. Desenhada em 320 × 690. */
export function NatPontoFrame({ children, topBar = 'app', title, clock = '18:32', className, label }: NatPontoFrameProps) {
  return (
    <div
      className={cn('relative flex flex-col overflow-hidden rounded-[2.2rem] border-[8px] border-brand-ink bg-[#F4F2F7] text-brand-ink shadow-lift', className)}
      style={{ width: NATPONTO_SIZE.width, height: NATPONTO_SIZE.height }}
      role={label ? 'img' : undefined}
      aria-label={label}
      aria-hidden={label ? undefined : true}
    >
      <div className="absolute left-1/2 top-2 z-20 h-4 w-20 -translate-x-1/2 rounded-full bg-brand-ink" />

      {/* barra de status */}
      <div className={cn('flex h-10 shrink-0 items-end justify-between px-5 pb-1 text-[11px] font-semibold text-white', topBar === 'none' ? 'bg-[#2A1550]' : 'bg-[#4A1D70]')}>
        <span className="tabular">{clock}</span>
        <span className="flex items-center gap-1.5">
          <span className="flex items-end gap-[2px]" aria-hidden>
            {[4, 6, 8, 10].map((h) => (
              <span key={h} className="block w-[3px] rounded-[1px] bg-white" style={{ height: h }} />
            ))}
          </span>
          <Wifi className="h-3.5 w-3.5" strokeWidth={2.2} />
          <span className="rounded-[4px] bg-white px-1 text-[9px] font-bold text-[#4A1D70]">97</span>
        </span>
      </div>

      {topBar === 'app' && (
        <div className="flex h-12 shrink-0 items-center justify-between bg-[linear-gradient(180deg,#3A1B62,#2C1A63)] px-4 text-white">
          <Menu className="h-5 w-5" strokeWidth={2} />
          <Logo tone="white" className="h-5 w-auto" decorative />
          <span className="flex items-center gap-4">
            <Bell className="h-4.5 w-4.5" strokeWidth={2} />
            <LogOut className="h-4.5 w-4.5" strokeWidth={2} />
          </span>
        </div>
      )}
      {topBar === 'modal' && (
        <div className="flex h-12 shrink-0 items-center justify-between bg-[linear-gradient(180deg,#3A1B62,#2C1A63)] px-4 text-white">
          <span className="text-[16px] font-bold">{title}</span>
          <X className="h-5 w-5" strokeWidth={2} />
        </div>
      )}

      <div className="relative min-h-0 flex-1">{children}</div>
    </div>
  )
}
