import { m } from 'motion/react'
import { Clock, Home, MapPin, ScanFace, User } from 'lucide-react'
import { Logo } from '@/components/brand/Logo'
import { cn } from '@/lib/utils'

/** NatPonto no celular: cabeçalho em Azul Profundo com o símbolo, um botão primário por tela. */
export function PhoneMockup({ className }: { className?: string }) {
  return (
    <div
      className={cn(
        'relative aspect-[9/19] w-[220px] overflow-hidden rounded-[2.2rem] border-[7px] border-brand-ink bg-white text-brand-ink shadow-lift',
        className,
      )}
      role="img"
      aria-label="App NatPonto: registro de ponto com reconhecimento facial e geolocalização"
    >
      <div className="absolute left-1/2 top-2 h-4 w-16 -translate-x-1/2 rounded-full bg-brand-ink" aria-hidden />
      <div className="bg-brand-blue px-4 pb-5 pt-8 text-white">
        <div className="flex items-center justify-between">
          <Logo variant="symbol" tone="white" className="h-5 w-5" decorative />
          <span className="text-[10px] text-white/70">Olá, Ana</span>
        </div>
        <p className="mt-4 text-[10px] uppercase tracking-[0.14em] text-white/60">Jornada de hoje</p>
        <p className="mt-0.5 text-[17px] font-extrabold tabular tracking-brand">08:02 · 12:00</p>
      </div>

      <div className="px-4 pt-4">
        <div className="relative mx-auto flex h-28 w-28 items-center justify-center">
          <m.span
            aria-hidden
            className="absolute inset-0 rounded-full border-2 border-dashed border-brand-purple/40"
            animate={{ rotate: 360 }}
            transition={{ duration: 18, ease: 'linear', repeat: Infinity }}
          />
          <m.span
            aria-hidden
            className="absolute inset-3 rounded-full bg-brand-purple/10"
            animate={{ scale: [1, 1.06, 1], opacity: [0.7, 1, 0.7] }}
            transition={{ duration: 2.6, ease: 'easeInOut', repeat: Infinity }}
          />
          <ScanFace className="relative h-11 w-11 text-brand-purple" strokeWidth={1.4} />
        </div>
        <p className="mt-2 text-center text-[10.5px] font-semibold">Reconhecimento facial</p>
        <p className="mt-1 flex items-center justify-center gap-1 text-[10px] text-brand-graphite">
          <MapPin className="h-3 w-3" strokeWidth={1.8} />
          Matriz · São Paulo
        </p>

        <div className="mt-4 rounded-lg bg-brand-purple py-2.5 text-center text-[11.5px] font-semibold text-white">
          Registrar ponto
        </div>

        <div className="mt-3 rounded-lg border border-brand-mist p-2.5 text-[10px]">
          <div className="flex items-center justify-between">
            <span className="text-brand-graphite">Banco de horas</span>
            <span className="font-semibold text-emerald-700">+06:40</span>
          </div>
          <div className="mt-1 flex items-center justify-between">
            <span className="text-brand-graphite">Marcações no mês</span>
            <span className="font-semibold">84</span>
          </div>
        </div>
      </div>

      <div className="absolute inset-x-0 bottom-0 flex justify-around border-t border-brand-mist bg-white px-4 py-3">
        <Home className="h-4 w-4 text-brand-purple" strokeWidth={1.6} />
        <Clock className="h-4 w-4 text-brand-mist" strokeWidth={1.6} />
        <User className="h-4 w-4 text-brand-mist" strokeWidth={1.6} />
      </div>
    </div>
  )
}
