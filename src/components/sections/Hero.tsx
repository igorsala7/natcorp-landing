import { useRef } from 'react'
import { m, useReducedMotion, useScroll, useTransform } from 'motion/react'
import { ArrowRight, ChevronDown, Sparkles } from 'lucide-react'
import { Link } from 'react-router'
import { Button } from '@/components/ui/button'
import { LogoOutline } from '@/components/brand/Logo'
import { SplitText } from '@/components/motion/SplitText'
import { Magnetic } from '@/components/motion/Magnetic'
import { useIntroDone } from '@/hooks/useIntroDone'
import { DashboardMockup } from '@/components/mockups/DashboardMockup'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import { NATPONTO_SIZE } from '@/components/mockups/natponto/NatPontoFrame'
import { NatPontoPhone } from '@/components/mockups/natponto/screens'
import { EASE } from '@/lib/motion'
import { scrollToElement } from '@/components/motion/ScrollManager'

const trust = ['+30 módulos integrados', '2.500 folhas por minuto', 'NATI, a IA do RH', 'Nuvem Oracle com contingência']

export function Hero() {
  const done = useIntroDone()
  const reduced = useReducedMotion()
  const ref = useRef<HTMLElement>(null)
  const { scrollYProgress } = useScroll({ target: ref, offset: ['start start', 'end start'] })
  const yText = useTransform(scrollYProgress, [0, 1], [0, -80])
  const opacityText = useTransform(scrollYProgress, [0, 0.55], [1, 0])
  const yMock = useTransform(scrollYProgress, [0, 1], [0, 90])
  const yPhone = useTransform(scrollYProgress, [0, 1], [0, 40])

  const show = (delay: number) => ({
    initial: { opacity: 0, y: 20 },
    animate: done ? { opacity: 1, y: 0 } : { opacity: 0, y: 20 },
    transition: { duration: 0.8, ease: EASE, delay },
  })

  return (
    <section
      ref={ref}
      id="top"
      className="on-dark relative isolate overflow-visible bg-brand-gradient text-white"
      aria-labelledby="hero-title"
    >
      <div className="pointer-events-none absolute inset-0 overflow-hidden" aria-hidden>
        <LogoOutline className="absolute -right-[16%] -top-[34%] h-[150%] w-auto text-white/[0.28]" />
        <div className="absolute inset-0 bg-[radial-gradient(70%_55%_at_18%_8%,rgba(201,87,136,0.32),transparent_62%)]" />
        <div className="absolute inset-0 bg-[radial-gradient(50%_40%_at_85%_90%,rgba(27,18,56,0.55),transparent_70%)]" />
      </div>

      <div className="container relative pt-[calc(var(--nav-h)+3.5rem)] sm:pt-[calc(var(--nav-h)+5rem)]">
        <m.div style={{ y: reduced ? 0 : yText, opacity: reduced ? 1 : opacityText }} className="mx-auto max-w-4xl text-center">
          <m.p
            {...show(0.05)}
            className="inline-flex items-center gap-2 whitespace-nowrap rounded-full border border-white/20 bg-white/10 px-3.5 py-1.5 text-[11px] font-semibold uppercase tracking-[0.1em] text-white/90 backdrop-blur-sm sm:px-4 sm:text-[12px] sm:tracking-[0.14em]"
          >
            <Sparkles className="h-3.5 w-3.5 text-[#E4A9C4]" strokeWidth={2} />
            HR Tech brasileira · há mais de 35 anos
          </m.p>

          <SplitText
            as="h1"
            id="hero-title"
            mode="controlled"
            visible={done}
            delay={0.15}
            stagger={0.08}
            text="Todo o RH. Um único sistema."
            className="mt-6 text-[2.75rem] font-extrabold leading-[1.02] sm:text-6xl lg:text-7xl xl:text-[5.5rem]"
          />

          <m.p {...show(0.55)} className="mx-auto mt-6 max-w-2xl text-lg leading-relaxed text-white/80 sm:text-xl">
            Folha, ponto, eSocial, admissão digital, saúde e segurança do trabalho, talentos e People Analytics.
            Mais de 30 módulos integrados, com a NATI, nossa inteligência artificial, trabalhando dentro do sistema.
            Para grandes empresas que querem um RH protagonista.
          </m.p>

          <m.div {...show(0.7)} className="mt-9 flex flex-wrap items-center justify-center gap-3">
            <Magnetic>
              <Button asChild variant="inverse" size="xl">
                <Link to="#contato">
                  Agendar demonstração
                  <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                </Link>
              </Button>
            </Magnetic>
            <Button asChild variant="outline-inverse" size="xl">
              <Link to="#modulos">Conhecer os módulos</Link>
            </Button>
          </m.div>

          <m.ul {...show(0.85)} className="mt-10 flex flex-wrap items-center justify-center gap-x-6 gap-y-2 text-[13px] font-medium text-white/70">
            {trust.map((t) => (
              <li key={t} className="flex items-center gap-2">
                <span className="h-1.5 w-1.5 rounded-full bg-[#E4A9C4]" aria-hidden />
                {t}
              </li>
            ))}
          </m.ul>
        </m.div>

        <m.div
          initial={{ opacity: 0, y: 60, scale: 0.97 }}
          animate={done ? { opacity: 1, y: 0, scale: 1 } : { opacity: 0, y: 60, scale: 0.97 }}
          transition={{ duration: 1.1, ease: EASE, delay: 0.9 }}
          className="relative z-20 mx-auto mt-14 max-w-5xl sm:mt-20"
        >
          <m.div style={{ y: reduced ? 0 : yMock }}>
            <DashboardMockup />
          </m.div>
          <m.div
            style={{ y: reduced ? 0 : yPhone }}
            className="absolute -bottom-12 -right-2 hidden md:block lg:-right-16 xl:-right-24"
            initial={{ opacity: 0, y: 40, rotate: -4 }}
            animate={done ? { opacity: 1, y: 0, rotate: -4 } : { opacity: 0, y: 40, rotate: -4 }}
            transition={{ duration: 1, ease: EASE, delay: 1.3 }}
          >
            <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height} className="w-[200px] lg:w-[230px]">
              <NatPontoPhone screen="home" />
            </ScaledFrame>
          </m.div>
        </m.div>
      </div>

      <m.a
        href="#numeros"
        onClick={(e) => {
          const el = document.getElementById('numeros')
          if (!el) return
          e.preventDefault()
          scrollToElement(el)
        }}
        aria-label="Rolar para a próxima seção"
        className="absolute bottom-6 left-1/2 hidden -translate-x-1/2 text-white/60 transition-colors hover:text-white lg:block"
        initial={{ opacity: 0 }}
        animate={done ? { opacity: 1 } : { opacity: 0 }}
        transition={{ delay: 1.8, duration: 0.8 }}
      >
        <m.span
          className="block"
          animate={{ y: [0, 6, 0] }}
          transition={{ duration: 1.8, repeat: Infinity, ease: 'easeInOut' }}
        >
          <ChevronDown className="h-6 w-6" />
        </m.span>
      </m.a>

      {/* respiro para o mockup sobrepor a próxima seção */}
      <div className="h-24 sm:h-32" aria-hidden />
    </section>
  )
}
