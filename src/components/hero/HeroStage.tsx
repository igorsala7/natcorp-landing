import type { ReactNode } from 'react'
import { m, type Transition } from 'motion/react'
import { ScanFace, Wallet } from 'lucide-react'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { HeroSymbol } from '@/components/brand/HeroSymbol'
import { Logo } from '@/components/brand/Logo'
import { people } from '@/content/people'
import { useIsDesktop } from '@/hooks/useMediaQuery'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'

/**
 * O palco do hero: a pessoa (recorte com transparência) entre o humano e o sistema.
 *
 * Camadas, de trás para a frente:
 * 1. aura de luz e o símbolo em vidro;
 * 2. a versão "sistema" da pessoa: duotone no gradiente da marca, em pontos (meia-tinta), que
 *    aparece do lado direito, onde a foto natural se dissolve;
 * 3. a foto natural, com uma máscara horizontal que respira devagar;
 * 4. uma varredura de luz rosa que percorre a pessoa de tempos em tempos, só dentro do recorte;
 * 5. a tela do tablet acesa com o sistema, e os cartões flutuantes ligados a ela por fios de luz.
 */

/* A tela do tablet, em porcentagens da caixa da foto (1400 x 1750), com a inclinação da perspectiva. */
const SCREEN = { left: 73.4, top: 41.4, width: 16.4, height: 18, rotate: -2, skew: -15 }
/* Para onde os fios convergem (o centro da tela). */
const HUB = { x: 79, y: 51 }

interface HeroStageProps {
  on: boolean
  reduced: boolean
  className?: string
}

export function HeroStage({ on, reduced, className }: HeroStageProps) {
  const desktop = useIsDesktop()
  const src = desktop ? people.heroTablet.src : people.heroTablet.srcSm
  const maskPerson = { WebkitMaskImage: `url(${src})`, maskImage: `url(${src})`, WebkitMaskSize: '100% 100%', maskSize: '100% 100%', WebkitMaskRepeat: 'no-repeat', maskRepeat: 'no-repeat' } as const
  const enter = (delay: number, y = 18) => ({
    initial: { opacity: 0, y },
    animate: on ? { opacity: 1, y: 0 } : { opacity: 0, y },
    transition: { duration: 0.9, ease: EASE, delay },
  })

  return (
    <div className={cn('relative aspect-[4/5] w-full select-none', className)} aria-hidden>
      {/* 1. aura e símbolo em vidro */}
      <m.div
        className="absolute left-[-30%] top-[-12%] h-[120%] w-[160%] rounded-full bg-[radial-gradient(closest-side,rgba(190,140,225,0.55),rgba(154,64,138,0.18)_55%,transparent_75%)] blur-2xl"
        initial={{ opacity: 0, scale: 0.9 }}
        animate={on ? { opacity: 1, scale: 1 } : { opacity: 0, scale: 0.9 }}
        transition={{ duration: 1.6, ease: EASE }}
      />
      <m.div
        className="absolute right-[-22%] top-[-6%] hidden h-[78%] opacity-80 lg:block"
        initial={{ opacity: 0, scale: 0.94 }}
        animate={on ? { opacity: 0.8, scale: 1 } : { opacity: 0, scale: 0.94 }}
        transition={{ duration: 1.4, ease: EASE, delay: 0.3 }}
      >
        <HeroSymbol className="h-full w-auto" />
      </m.div>

      {/* 2. a pessoa como sistema: duotone em pontos, visível onde a foto natural se dissolve */}
      <m.div
        className="absolute inset-0 isolate"
        style={{
          WebkitMaskImage: `url(${src}), radial-gradient(circle, #000 1.15px, transparent 1.6px)`,
          maskImage: `url(${src}), radial-gradient(circle, #000 1.15px, transparent 1.6px)`,
          WebkitMaskSize: '100% 100%, 6px 6px',
          maskSize: '100% 100%, 6px 6px',
          WebkitMaskRepeat: 'no-repeat, repeat',
          maskRepeat: 'no-repeat, repeat',
          WebkitMaskComposite: 'source-in',
          maskComposite: 'intersect',
          backgroundImage: 'linear-gradient(165deg, #F3C9DA 0%, #C95788 38%, #7B2F9B 100%)',
        }}
        initial={{ opacity: 0 }}
        animate={on ? { opacity: 1 } : { opacity: 0 }}
        transition={{ duration: 1.4, ease: EASE, delay: 0.5 }}
      >
        <img src={src} alt="" draggable={false} className="absolute inset-0 h-full w-full" style={{ mixBlendMode: 'luminosity', filter: 'grayscale(1) contrast(1.12) brightness(1.08)' }} />
      </m.div>

      {/* 3. a foto natural, dissolvendo para a direita; a borda respira */}
      <m.div
        className={cn('absolute inset-0', !reduced && 'animate-hero-breathe')}
        style={{
          WebkitMaskImage: 'linear-gradient(90deg, #000 0%, #000 25%, rgba(0,0,0,0.92) 30%, rgba(0,0,0,0.35) 38%, transparent 45%)',
          maskImage: 'linear-gradient(90deg, #000 0%, #000 25%, rgba(0,0,0,0.92) 30%, rgba(0,0,0,0.35) 38%, transparent 45%)',
          WebkitMaskSize: '200% 100%',
          maskSize: '200% 100%',
          WebkitMaskRepeat: 'no-repeat',
          maskRepeat: 'no-repeat',
        }}
        initial={{ opacity: 0, y: 26, scale: 1.02 }}
        animate={on ? { opacity: 1, y: 0, scale: 1 } : { opacity: 0, y: 26, scale: 1.02 }}
        transition={{ duration: 1.3, ease: EASE, delay: 0.15 }}
      >
        <img
          src={src}
          alt={people.heroTablet.alt}
          width={1400}
          height={1750}
          fetchPriority="high"
          decoding="async"
          draggable={false}
          className="absolute inset-0 h-full w-full"
        />
      </m.div>

      {/* 4. a varredura de luz, só dentro do recorte da pessoa */}
      {!reduced && (
        <div className="absolute inset-0" style={maskPerson}>
          <m.div
            className="absolute top-0 h-full w-[2px] bg-[#F3C9DA]/90"
            style={{ boxShadow: '0 0 12px 3px rgba(243,201,218,0.75), 0 0 44px 10px rgba(201,87,136,0.45)' }}
            initial={{ left: '26%', opacity: 0 }}
            animate={on ? { left: ['26%', '100%'], opacity: [0, 0.9, 0.9, 0] } : { left: '26%', opacity: 0 }}
            transition={{ duration: 3.4, ease: 'easeInOut', delay: 2.2, repeat: Infinity, repeatDelay: 5.5, times: [0, 0.12, 0.85, 1] }}
          />
        </div>
      )}

      {/* 5. a tela do tablet acesa */}
      <m.div
        className="absolute"
        style={{ left: `${SCREEN.left}%`, top: `${SCREEN.top}%`, width: `${SCREEN.width}%`, height: `${SCREEN.height}%`, transformOrigin: '0 0', rotate: SCREEN.rotate, skewX: SCREEN.skew }}
        initial={{ opacity: 0 }}
        animate={on ? { opacity: 1 } : { opacity: 0 }}
        transition={{ duration: 0.8, ease: EASE, delay: 1.0 }}
      >
        <div className="h-full w-full overflow-hidden rounded-[4px] bg-[#1B1238]/85 ring-1 ring-[#E4A9C4]/40 shadow-[0_0_28px_rgba(228,169,196,0.55),0_0_70px_rgba(201,87,136,0.35)]">
          <div className="flex h-full flex-col p-[7%]">
            <div className="flex items-center gap-[5%]">
              <Logo variant="symbol" tone="white" decorative className="h-auto w-[16%]" />
              <span className="h-[3px] w-[40%] rounded-full bg-white/60" />
            </div>
            <div className="mt-[10%] flex flex-1 items-end gap-[6%]">
              {[38, 62, 48, 86, 70].map((h, i) => (
                <m.span
                  key={i}
                  className="w-full rounded-t-[2px] bg-[#E4A9C4]"
                  style={{ transformOrigin: 'bottom' }}
                  initial={{ scaleY: 0, height: `${h}%` }}
                  animate={on ? { scaleY: 1 } : { scaleY: 0 }}
                  transition={{ duration: 0.7, ease: EASE, delay: 1.3 + i * 0.08 }}
                />
              ))}
            </div>
            <div className="mt-[8%] flex items-center gap-[5%]">
              <span className="h-[3px] w-[55%] rounded-full bg-[#C95788]" />
              <span className="h-[3px] w-[25%] rounded-full bg-white/40" />
            </div>
          </div>
        </div>
      </m.div>

      {/* fios de luz do tablet aos cartões */}
      <svg viewBox="0 0 100 125" preserveAspectRatio="none" className="pointer-events-none absolute inset-0 hidden h-full w-full lg:block" aria-hidden>
        <defs>
          <linearGradient id="hero-wire" x1="0" y1="0" x2="1" y2="0">
            <stop offset="0" stopColor="#F3C9DA" stopOpacity="0.9" />
            <stop offset="1" stopColor="#E4A9C4" stopOpacity="0.15" />
          </linearGradient>
        </defs>
        {[
          `M${HUB.x} ${HUB.y} L92 30`,
          `M${HUB.x} ${HUB.y} L14 78`,
          `M${HUB.x} ${HUB.y} L90 104`,
        ].map((d, i) => (
          <m.path
            key={i}
            d={d}
            stroke="url(#hero-wire)"
            strokeWidth="0.35"
            fill="none"
            vectorEffect="non-scaling-stroke"
            initial={{ pathLength: 0, opacity: 0 }}
            animate={on ? { pathLength: 1, opacity: 1 } : { pathLength: 0, opacity: 0 }}
            transition={{ duration: 0.9, ease: EASE, delay: 1.35 + i * 0.15 }}
          />
        ))}
        {[
          [92, 30],
          [14, 78],
          [90, 104],
        ].map(([x, y], i) => (
          <m.circle key={i} cx={x} cy={y} r="0.9" fill="#F3C9DA" initial={{ opacity: 0 }} animate={on ? { opacity: 1 } : { opacity: 0 }} transition={{ duration: 0.4, delay: 2.1 + i * 0.15 }} />
        ))}
      </svg>

      {/* cartões flutuantes */}
      <Card {...enter(1.5)} className="right-0 top-[63%] w-[60%] max-w-[300px] lg:right-[-2%] lg:top-[14%] lg:w-[58%]" float={reduced ? 0 : 7} delay={0}>
        <div className="flex items-start gap-3">
          <NatiAvatar ring className="h-9 w-9 shrink-0" />
          <div className="min-w-0">
            <p className="text-[10.5px] font-bold uppercase tracking-[0.14em] text-[#E4A9C4]">NATI · Inteligência Artificial</p>
            <p className="mt-0.5 text-[13.5px] font-semibold leading-snug text-white">12 pessoas com férias vencendo em setembro. Preparei os avisos aos gestores.</p>
          </div>
        </div>
      </Card>
      <Card {...enter(1.65)} className="hidden lg:block left-[-6%] top-[60%] w-[54%] max-w-[270px]" float={reduced ? 0 : 5} delay={1.3}>
        <div className="flex items-center gap-3">
          <span className="grid h-9 w-9 shrink-0 place-items-center rounded-xl bg-[#C95788]/25 text-[#F3C9DA] ring-1 ring-[#E4A9C4]/40">
            <ScanFace className="h-[18px] w-[18px]" strokeWidth={2} />
          </span>
          <div className="min-w-0">
            <p className="text-[10.5px] font-bold uppercase tracking-[0.14em] text-[#E4A9C4]">NatPonto</p>
            <p className="mt-0.5 text-[13.5px] font-semibold leading-snug text-white">Marcação às 08:02, com reconhecimento facial</p>
          </div>
        </div>
      </Card>
      <Card {...enter(1.8)} className="hidden lg:block right-[2%] top-[80%] w-[56%] max-w-[280px]" float={reduced ? 0 : 6} delay={2.4}>
        <div className="flex items-center gap-3">
          <span className="grid h-9 w-9 shrink-0 place-items-center rounded-xl bg-white/10 text-white ring-1 ring-white/25">
            <Wallet className="h-[18px] w-[18px]" strokeWidth={2} />
          </span>
          <div className="min-w-0">
            <p className="text-[10.5px] font-bold uppercase tracking-[0.14em] text-[#E4A9C4]">Folha de Pagamento</p>
            <p className="mt-0.5 text-[13.5px] font-semibold leading-snug text-white">Fechamento de setembro concluído. 4 empresas, uma base.</p>
          </div>
        </div>
      </Card>
    </div>
  )
}

interface CardProps {
  className?: string
  children: ReactNode
  float: number
  delay: number
  initial: { opacity: number; y: number }
  animate: { opacity: number; y: number }
  transition: Transition
}

function Card({ className, children, float, delay, initial, animate, transition }: CardProps) {
  return (
    <m.div className={cn('absolute z-10', className)} initial={initial} animate={animate} transition={transition}>
      <m.div
        className="rounded-2xl border border-white/15 bg-white/[0.08] p-3.5 shadow-[0_12px_40px_rgba(27,18,56,0.35)] backdrop-blur-md"
        animate={float ? { y: [0, -float, 0] } : undefined}
        transition={{ duration: 6.5, ease: 'easeInOut', repeat: Infinity, delay }}
      >
        {children}
      </m.div>
    </m.div>
  )
}
