import { useRef } from 'react'
import { m, useReducedMotion, useScroll, useTransform } from 'motion/react'
import { ArrowRight, ChevronDown, Sparkles } from 'lucide-react'
import { Link } from 'react-router'
import { Button } from '@/components/ui/button'
import { HeroStage } from '@/components/hero/HeroStage'
import { HeroScene } from '@/components/hero/HeroScene'
import { NetworkField } from '@/components/nati/NetworkField'
import { SplitText } from '@/components/motion/SplitText'
import { Magnetic } from '@/components/motion/Magnetic'
import { useIntroDone } from '@/hooks/useIntroDone'
import { paths } from '@/content/site'
import { EASE } from '@/lib/motion'
import { scrollToElement } from '@/components/motion/ScrollManager'

/** Qual composição abre a home: `scene` (cena completa fornecida) ou `stage` (recorte da pessoa no palco). */
const VARIANT: 'scene' | 'stage' = 'scene'

const trust = ['Todos os módulos integrados', '2.500 folhas por minuto', 'NATI, a IA do RH', 'Nuvem Oracle com contingência', 'Várias empresas e CNPJs, uma base']

/**
 * Abertura da home: campo roxo luminoso, a pessoa com o tablet à direita, entre o humano e o sistema
 * (a foto se dissolve em pontos no gradiente da marca; a tela do tablet acende; os cartões flutuam).
 */
export function Hero() {
  const done = useIntroDone()
  const reduced = useReducedMotion() ?? false
  const ref = useRef<HTMLElement>(null)
  const { scrollYProgress } = useScroll({ target: ref, offset: ['start start', 'end start'] })
  const yText = useTransform(scrollYProgress, [0, 1], [0, -70])
  const opacityText = useTransform(scrollYProgress, [0, 0.6], [1, 0])
  const yStage = useTransform(scrollYProgress, [0, 1], [0, 80])
  const scaleScene = useTransform(scrollYProgress, [0, 1], [1, 1.06])

  const show = (delay: number) => ({
    initial: { opacity: 0, y: 20 },
    animate: done ? { opacity: 1, y: 0 } : { opacity: 0, y: 20 },
    transition: { duration: 0.8, ease: EASE, delay },
  })

  const scrollHint = (
    <m.a
      href="#nati-teaser-title"
      onClick={(e) => {
        const el = document.getElementById('nati-teaser-title')
        if (!el) return
        e.preventDefault()
        scrollToElement(el)
      }}
      aria-label="Rolar para a próxima seção"
      className="absolute bottom-5 left-1/2 hidden -translate-x-1/2 text-white/60 transition-colors hover:text-white lg:block"
      initial={{ opacity: 0 }}
      animate={done ? { opacity: 1 } : { opacity: 0 }}
      transition={{ delay: 1.8, duration: 0.8 }}
    >
      <m.span className="block" animate={reduced ? undefined : { y: [0, 6, 0] }} transition={{ duration: 1.8, repeat: Infinity, ease: 'easeInOut' }}>
        <ChevronDown className="h-6 w-6" />
      </m.span>
    </m.a>
  )

  const text = (
    <m.div style={{ y: reduced ? 0 : yText, opacity: reduced ? 1 : opacityText }} className="relative z-10 max-w-2xl">
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
        text="Todo o RH. [[Um único sistema.]]"
        highlightClassName="text-[#F3C9DA]"
        className="mt-5 text-[2.6rem] font-extrabold leading-[1.02] sm:mt-6 sm:text-6xl lg:text-[4.2rem] xl:text-[4.9rem]"
      />

      <m.p {...show(0.55)} className="mt-5 max-w-xl text-[15.5px] leading-relaxed text-white/85 sm:mt-6 sm:text-xl">
        Folha, ponto, eSocial, admissão digital, saúde e segurança do trabalho, talentos e People Analytics.
        Todos os módulos integrados, com a NATI, nossa Inteligência Artificial, trabalhando dentro do sistema.
        Para grandes empresas que querem um RH protagonista.
      </m.p>

      <m.div {...show(0.7)} className="mt-7 flex flex-wrap items-center gap-3 sm:mt-9">
        <Magnetic>
          <Button asChild variant="inverse" size="xl">
            <Link to="#contato">
              Agendar demonstração
              <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
            </Link>
          </Button>
        </Magnetic>
        <Button asChild variant="outline-inverse" size="xl">
          <Link to={paths.modules}>Conhecer os módulos</Link>
        </Button>
      </m.div>

      <m.ul {...show(0.85)} className="mt-8 hidden flex-wrap items-center gap-x-5 gap-y-2 text-[13px] font-medium text-white/75 sm:mt-10 sm:flex sm:gap-x-6">
        {trust.map((t) => (
          <li key={t} className="flex items-center gap-2">
            <span className="h-1.5 w-1.5 rounded-full bg-[#E4A9C4]" aria-hidden />
            {t}
          </li>
        ))}
      </m.ul>
    </m.div>
  )

  if (VARIANT === 'scene') {
    return (
      <section ref={ref} id="top" className="on-dark relative isolate flex min-h-[92svh] flex-col overflow-hidden bg-brand-blue text-white lg:min-h-0" aria-labelledby="hero-title">
        <HeroScene on={done} reduced={reduced} y={reduced ? 0 : yStage} scale={reduced ? 1 : scaleScene} />
        <div className="container relative mt-auto flex flex-col items-start pb-12 pt-[calc(var(--nav-h)+38svh)] sm:pb-14 sm:pt-[calc(var(--nav-h)+42svh)] lg:min-h-[min(820px,90vh)] lg:justify-center lg:py-[calc(var(--nav-h)+4rem)]">
          {text}
        </div>
        {scrollHint}
      </section>
    )
  }

  return (
    <section ref={ref} id="top" className="on-dark relative isolate overflow-hidden bg-[#4A1B72] text-white" aria-labelledby="hero-title">
      {/* o campo: luz lavanda atrás da pessoa, rosa embaixo à direita, azul profundo no canto do texto */}
      <div className="absolute inset-0" aria-hidden>
        <div className="absolute inset-0 bg-[radial-gradient(70%_60%_at_80%_45%,rgba(160,105,205,0.55),transparent_70%),radial-gradient(45%_45%_at_95%_95%,rgba(201,87,136,0.4),transparent_70%),radial-gradient(60%_50%_at_0%_0%,rgba(44,26,99,0.85),transparent_70%),linear-gradient(180deg,#3A1A66_0%,#4A1B72_40%,#4B1D74_100%)]" />
        {/* a malha técnica, só do lado do sistema */}
        <div
          className="absolute inset-0 bg-[linear-gradient(rgba(255,255,255,0.06)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,0.06)_1px,transparent_1px)] bg-[size:56px_56px]"
          style={{
            WebkitMaskImage: 'radial-gradient(60% 70% at 78% 55%, #000, transparent 75%)',
            maskImage: 'radial-gradient(60% 70% at 78% 55%, #000, transparent 75%)',
          }}
        />
        <NetworkField density={0.75} className="opacity-50 lg:[mask-image:linear-gradient(90deg,transparent_28%,#000_60%)] lg:[-webkit-mask-image:linear-gradient(90deg,transparent_28%,#000_60%)]" />
        <div className="absolute inset-x-0 top-0 h-32 bg-gradient-to-b from-[#2C1A63]/70 to-transparent" />
      </div>

      <div className="container relative grid gap-8 pt-[calc(var(--nav-h)+2.5rem)] lg:min-h-[min(860px,92vh)] lg:grid-cols-[minmax(0,1.02fr)_minmax(0,0.98fr)] lg:items-end lg:gap-6 lg:pt-[calc(var(--nav-h)+2rem)] xl:gap-10">
        <div className="self-center pb-2 lg:pb-24">{text}</div>
        <m.div style={{ y: reduced ? 0 : yStage }} className="relative mx-auto w-full max-w-[440px] self-end lg:mx-0 lg:ml-auto lg:max-w-[560px] xl:max-w-[620px]">
          <HeroStage on={done} reduced={reduced} />
        </m.div>
      </div>

      {scrollHint}
    </section>
  )
}
