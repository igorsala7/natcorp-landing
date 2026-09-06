import { useRef, useState } from 'react'
import { m, useInView, type MotionValue } from 'motion/react'
import { ScanFace } from 'lucide-react'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { EASE } from '@/lib/motion'
import heroV2 from '@/assets/people/hero-v2.webp'
import heroV2Large from '@/assets/people/hero-v2-3152.webp'

/**
 * Fundo do hero: a cena natcorp_hero_v2 (a profissional com o tablet junto à janela, o módulo do símbolo
 * em contorno e as linhas de fluxo), com a arte da marca animada por cima, em código, alinhada à imagem:
 * - o contorno do módulo redesenhado em luz, que se desenha na entrada e recebe um brilho percorrendo a borda;
 * - linhas de fluxo com pacotes de luz correndo em direção à pessoa;
 * - um módulo menor em vidro, respirando, perto do tablet;
 * - o véu para o texto e os cartões do sistema.
 * A imagem e o SVG ficam no mesmo quadro (2000 x 843), que cobre a seção como um object-fit: cover.
 */

const W = 2000
const H = 843
/* O módulo grande, medido sobre a imagem (quadrado arredondado girado 45°, um pouco mais alto que largo). */
const MODULE = 'M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z'
/* Um módulo menor, em vidro, perto do tablet. */
const SMALL = { cx: 1770, cy: 700, s: 0.3 }
/** Segundo módulo, atrás do principal: centro, inclinação e escala (o principal está centrado em 1412, 425). */
const MODULE2 = { cx: 1300, cy: 500, rotate: 12, s: 1.12 }

/* Linhas de fluxo: saem da esquerda, embaixo, e sobem em curva até a pessoa; cada uma com um leve desvio. */
const flows = Array.from({ length: 7 }, (_, i) => {
  const y0 = 600 + i * 34
  const y1 = 520 + i * 18
  const y2 = 300 + i * 14
  return { d: `M-40 ${y0} C 420 ${y0 - 30}, 760 ${y1}, 1040 ${y1 - 60} S 1500 ${y2 + 40}, ${W + 40} ${y2}`, dur: 8 + i * 0.9, delay: i * 0.7 }
})

interface HeroSceneProps {
  on: boolean
  reduced: boolean
  y: MotionValue<number> | 0
  scale: MotionValue<number> | 1
}

export function HeroScene({ on, reduced, y, scale }: HeroSceneProps) {
  const root = useRef<HTMLDivElement>(null)
  /** Os laços contínuos (pacotes de luz, brilho na borda, respiração) só rodam com o hero na tela. */
  const inView = useInView(root, { margin: '120px 0px' })
  const loop = on && inView && !reduced
  /** Depois da primeira entrada, os laços voltam sem a espera da introdução (estado derivado durante a renderização). */
  const [prev, setPrev] = useState({ loop: false, looped: false })
  if (prev.loop !== loop) setPrev({ loop, looped: prev.looped || prev.loop })
  const wait = prev.looped ? 0 : 1
  return (
    <div ref={root} className="absolute inset-0" aria-hidden>
      {/* o quadro que cobre a seção (no celular, só a parte de cima): imagem e arte no mesmo sistema de coordenadas */}
      <div className="absolute inset-x-0 top-0 h-[62%] overflow-hidden [container-type:size] lg:h-full">
      <m.div
        className="absolute [--fx:84%] [--fy:50%] lg:[--fx:62%] lg:[--fy:45%]"
        style={{
          left: 'var(--fx)',
          top: 'var(--fy)',
          translate: 'calc(var(--fx) * -1) calc(var(--fy) * -1)',
          width: `max(100cqw, calc(100cqh * ${(W / H).toFixed(4)}))`,
          aspectRatio: `${W} / ${H}`,
          y,
          scale,
          // o quadro tem layer própria: a paralaxe da rolagem só recompõe, sem repintar a foto
          willChange: 'transform',
        }}
        initial={{ opacity: 0 }}
        animate={on ? { opacity: 1 } : { opacity: 0 }}
        transition={{ duration: 1.4, ease: EASE }}
      >
        <img
          src={heroV2}
          srcSet={`${heroV2} 2000w, ${heroV2Large} 3152w`}
          sizes="(min-width: 1024px) 125vw, 150vw"
          alt=""
          width={W}
          height={H}
          fetchPriority="high"
          decoding="async"
          draggable={false}
          className="absolute inset-0 h-full w-full"
        />

        <svg viewBox={`0 0 ${W} ${H}`} preserveAspectRatio="none" className="absolute inset-0 h-full w-full overflow-visible">
          <defs>
            <linearGradient id="hv2-edge" x1="0" y1="0" x2="1" y2="1">
              <stop offset="0" stopColor="#F3C9DA" stopOpacity="0.95" />
              <stop offset="0.5" stopColor="#E4A9C4" stopOpacity="0.7" />
              <stop offset="1" stopColor="#C95788" stopOpacity="0.35" />
            </linearGradient>
            <linearGradient id="hv2-edge-2" x1="0" y1="0" x2="1" y2="1">
              <stop offset="0" stopColor="#E4A9C4" stopOpacity="0.9" />
              <stop offset="0.5" stopColor="#C95788" stopOpacity="0.75" />
              <stop offset="1" stopColor="#9A408A" stopOpacity="0.55" />
            </linearGradient>
          </defs>

          {/* linhas de fluxo: traço contínuo fraco + pacotes de luz correndo */}
          <g strokeLinecap="round" fill="none">
            {flows.map((f, i) => (
              <m.path
                key={`f${i}`}
                d={f.d}
                stroke="#F3C9DA"
                strokeWidth="1.3"
                strokeOpacity="0.28"
                initial={{ pathLength: 0 }}
                animate={on ? { pathLength: 1 } : { pathLength: 0 }}
                transition={{ duration: 1.8, ease: EASE, delay: 0.4 + i * 0.08 }}
              />
            ))}
          </g>

          {/* o segundo módulo, atrás: deslocado, mais inclinado e afastado do principal, linha mais fina e um tom mais escuro */}
          <g transform={`translate(${MODULE2.cx} ${MODULE2.cy}) rotate(${MODULE2.rotate}) scale(${MODULE2.s}) translate(-1412 -425)`}>
            <m.path
              d={MODULE}
              fill="none"
              stroke="#C95788"
              strokeWidth="7"
              strokeOpacity="0.14"
              initial={{ pathLength: 0, opacity: 0 }}
              animate={on ? { pathLength: 1, opacity: 1 } : { pathLength: 0, opacity: 0 }}
              transition={{ duration: 2.8, ease: EASE, delay: 0.8 }}
            />
            <m.path
              d={MODULE}
              fill="none"
              stroke="url(#hv2-edge-2)"
              strokeWidth="2.2"
              initial={{ pathLength: 0, opacity: 0 }}
              animate={on ? { pathLength: 1, opacity: 1 } : { pathLength: 0, opacity: 0 }}
              transition={{ duration: 2.8, ease: EASE, delay: 0.8 }}
            />
          </g>

          {/* o módulo grande: brilho difuso por baixo, contorno nítido por cima, desenhando-se na entrada */}
          <m.path
            d={MODULE}
            fill="none"
            stroke="#E4A9C4"
            strokeWidth="26"
            strokeOpacity="0.08"
            initial={{ pathLength: 0, opacity: 0 }}
            animate={on ? { pathLength: 1, opacity: 1 } : { pathLength: 0, opacity: 0 }}
            transition={{ duration: 2.4, ease: EASE, delay: 0.3 }}
          />
          <m.path
            d={MODULE}
            fill="none"
            stroke="#E4A9C4"
            strokeWidth="10"
            strokeOpacity="0.16"
            initial={{ pathLength: 0, opacity: 0 }}
            animate={on ? { pathLength: 1, opacity: 1 } : { pathLength: 0, opacity: 0 }}
            transition={{ duration: 2.4, ease: EASE, delay: 0.3 }}
          />
          <m.path
            d={MODULE}
            fill="none"
            stroke="url(#hv2-edge)"
            strokeWidth="3"
            initial={{ pathLength: 0, opacity: 0 }}
            animate={on ? { pathLength: 1, opacity: 1 } : { pathLength: 0, opacity: 0 }}
            transition={{ duration: 2.4, ease: EASE, delay: 0.3 }}
          />

        </svg>

        {/* camada em movimento, numa layer própria do compositor: o que anima a cada quadro fica separado da foto e dos traços parados */}
        <svg viewBox={`0 0 ${W} ${H}`} preserveAspectRatio="none" className="absolute inset-0 h-full w-full overflow-visible will-change-transform">
          <defs>
            <linearGradient id="hv2-glass" x1="0" y1="0" x2="1" y2="1">
              <stop offset="0" stopColor="#F3C9DA" stopOpacity="0.28" />
              <stop offset="0.55" stopColor="#C95788" stopOpacity="0.16" />
              <stop offset="1" stopColor="#511C76" stopOpacity="0.1" />
            </linearGradient>
          </defs>
          <g strokeLinecap="round" fill="none">
            {loop &&
              flows.map((f, i) => (
                <m.path
                  key={`p${i}`}
                  d={f.d}
                  pathLength={1}
                  stroke="#FFFFFF"
                  strokeWidth="1.8"
                  strokeOpacity="0.85"
                  strokeDasharray="0.09 1"
                  initial={{ strokeDashoffset: 1, opacity: 0 }}
                  animate={{ strokeDashoffset: -1, opacity: 1 }}
                  transition={{
                    strokeDashoffset: { duration: f.dur, ease: 'linear', repeat: Infinity, delay: (2 + f.delay) * wait },
                    opacity: { duration: 1, delay: (2 + f.delay) * wait },
                  }}
                />
              ))}
          </g>
          {/* a luz que percorre a borda do módulo, sem parar */}
          {loop && (
            <>
              <m.path
                d={MODULE}
                pathLength={1}
                fill="none"
                stroke="#F3C9DA"
                strokeWidth="12"
                strokeLinecap="round"
                strokeDasharray="0.06 1"
                initial={{ strokeDashoffset: 0, opacity: 0 }}
                animate={{ strokeDashoffset: -2, opacity: 0.35 }}
                transition={{ strokeDashoffset: { duration: 18, ease: 'linear', repeat: Infinity, delay: 2.6 * wait }, opacity: { duration: 1.2, delay: 2.6 * wait } }}
              />
              <m.path
                d={MODULE}
                pathLength={1}
                fill="none"
                stroke="#FFFFFF"
                strokeWidth="4"
                strokeLinecap="round"
                strokeDasharray="0.05 1"
                initial={{ strokeDashoffset: 0, opacity: 0 }}
                animate={{ strokeDashoffset: -2, opacity: 0.95 }}
                transition={{ strokeDashoffset: { duration: 18, ease: 'linear', repeat: Infinity, delay: 2.6 * wait }, opacity: { duration: 1.2, delay: 2.6 * wait } }}
              />
            </>
          )}
          {/* o módulo menor, em vidro, respirando perto do tablet */}
          <m.g
            style={{ transformOrigin: `${SMALL.cx}px ${SMALL.cy}px`, transformBox: 'view-box' }}
            initial={{ opacity: 0, scale: 0.9 }}
            animate={on ? { opacity: 1, scale: loop ? [1, 1.04, 1] : 1 } : { opacity: 0, scale: 0.9 }}
            transition={{ opacity: { duration: 1.2, ease: EASE, delay: 1.4 }, scale: loop ? { duration: 7, ease: 'easeInOut', repeat: Infinity, delay: 1.4 * wait } : { duration: 1.2 } }}
          >
            <g transform={`translate(${SMALL.cx} ${SMALL.cy}) scale(${SMALL.s}) translate(-1412 -425)`}>
              <path d={MODULE} fill="url(#hv2-glass)" stroke="#F3C9DA" strokeWidth="4" strokeOpacity="0.75" />
              <path d={MODULE} fill="none" stroke="#FFFFFF" strokeWidth="2" strokeOpacity="0.5" transform="translate(-14 -14) scale(1.0)" />
            </g>
          </m.g>
        </svg>

      </m.div>
      </div>

    {/* cartões do sistema, presos à seção (não ao quadro da imagem) */}
      <m.div
        className="absolute right-[2%] top-[12%] hidden w-[240px] lg:block 2xl:right-[3%] 2xl:w-[280px]"
        initial={{ opacity: 0, y: 16 }}
        animate={on ? { opacity: 1, y: 0 } : { opacity: 0, y: 16 }}
        transition={{ duration: 0.9, ease: EASE, delay: 1.6 }}
      >
        <div
          className="rounded-2xl border border-white/20 bg-[#1B1238]/80 p-3.5 shadow-[0_12px_40px_rgba(27,18,56,0.45)]">
          <div className="flex items-start gap-3">
            <NatiAvatar ring className="h-9 w-9 shrink-0" />
            <div className="min-w-0">
              <p className="text-[10.5px] font-bold uppercase tracking-[0.14em] text-[#E4A9C4]">NATI · Inteligência Artificial</p>
              <p className="mt-0.5 text-[13.5px] font-semibold leading-snug text-white">12 pessoas com férias vencendo em setembro. Preparei os avisos aos gestores.</p>
            </div>
          </div>
        </div>
      </m.div>
      <m.div
        className="absolute bottom-[12%] right-[5%] hidden w-[270px] lg:block"
        initial={{ opacity: 0, y: 16 }}
        animate={on ? { opacity: 1, y: 0 } : { opacity: 0, y: 16 }}
        transition={{ duration: 0.9, ease: EASE, delay: 1.8 }}
      >
        <div
          className="rounded-2xl border border-white/20 bg-[#1B1238]/75 p-3.5 shadow-[0_12px_40px_rgba(27,18,56,0.45)]">
          <div className="flex items-center gap-3">
            <span className="grid h-9 w-9 shrink-0 place-items-center rounded-xl bg-[#C95788]/25 text-[#F3C9DA] ring-1 ring-[#E4A9C4]/40">
              <ScanFace className="h-[18px] w-[18px]" strokeWidth={2} />
            </span>
            <div className="min-w-0">
              <p className="text-[10.5px] font-bold uppercase tracking-[0.14em] text-[#E4A9C4]">NatPonto</p>
              <p className="mt-0.5 text-[13.5px] font-semibold leading-snug text-white">Marcação às 08:02, com reconhecimento facial</p>
            </div>
          </div>
        </div>
      </m.div>

      {/* brilho que deriva devagar do lado do texto, para o roxo respirar */}
      <m.div
        className="absolute left-[-12%] top-[18%] h-[95%] w-[58%] rounded-full bg-[radial-gradient(closest-side,rgba(201,87,136,0.26),rgba(201,87,136,0.1)_45%,rgba(201,87,136,0)_100%)]"
        style={{ willChange: 'transform, opacity' }}
        animate={loop ? { x: ['0%', '14%', '0%'], y: ['0%', '-12%', '0%'], opacity: [0.45, 0.85, 0.45] } : { x: '0%', y: '0%', opacity: 0.6 }}
        transition={loop ? { duration: 14, ease: 'easeInOut', repeat: Infinity } : { duration: 1.2, ease: EASE }}
      />

      {/* véu para o texto: base no celular, lateral esquerda no desktop */}
      <div className="absolute inset-0 bg-[linear-gradient(180deg,rgba(44,26,99,0.3)_0%,rgba(44,26,99,0.08)_16%,rgba(44,26,99,0.75)_44%,#2C1A63_58%)] lg:bg-[linear-gradient(90deg,rgba(44,26,99,0.92)_0%,rgba(44,26,99,0.78)_20%,rgba(44,26,99,0.45)_36%,rgba(44,26,99,0.12)_50%,rgba(44,26,99,0)_62%)]" />
      <div className="absolute inset-x-0 top-0 h-28 bg-gradient-to-b from-[#1B1238]/55 to-transparent" />
    </div>
  )
}
