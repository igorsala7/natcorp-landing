import { useRef } from 'react'
import { m, useReducedMotion, useScroll, useTransform } from 'motion/react'
import { ArrowRight, ChevronDown, ScanFace, Sparkles, Wallet } from 'lucide-react'
import { Link } from 'react-router'
import { Button } from '@/components/ui/button'
import { LogoOutline } from '@/components/brand/Logo'
import { HumanModule, type HumanChip } from '@/components/brand/HumanModule'
import { SplitText } from '@/components/motion/SplitText'
import { Magnetic } from '@/components/motion/Magnetic'
import { useIntroDone } from '@/hooks/useIntroDone'
import { people } from '@/content/people'
import { EASE } from '@/lib/motion'
import { scrollToElement } from '@/components/motion/ScrollManager'

const trust = ['+30 módulos integrados', '2.500 folhas por minuto', 'NATI, a IA do RH', 'Nuvem Oracle com contingência']

const chips: HumanChip[] = [
  { icon: Sparkles, label: 'NATI', value: 'Respondeu 42 dúvidas hoje', at: 'tr', desktopOnly: true },
  { icon: Wallet, label: 'Folha', value: 'Fechada em 6 minutos', at: 'l', desktopOnly: true },
  { icon: ScanFace, label: 'NatPonto', value: 'Ponto registrado às 08:02', at: 'br' },
]

export function Hero() {
  const done = useIntroDone()
  const reduced = useReducedMotion()
  const ref = useRef<HTMLElement>(null)
  const { scrollYProgress } = useScroll({ target: ref, offset: ['start start', 'end start'] })
  const yText = useTransform(scrollYProgress, [0, 1], [0, -80])
  const opacityText = useTransform(scrollYProgress, [0, 0.55], [1, 0])
  const yVisual = useTransform(scrollYProgress, [0, 1], [0, 70])

  const show = (delay: number) => ({
    initial: { opacity: 0, y: 20 },
    animate: done ? { opacity: 1, y: 0 } : { opacity: 0, y: 20 },
    transition: { duration: 0.8, ease: EASE, delay },
  })

  return (
    <section
      ref={ref}
      id="top"
      className="on-dark relative isolate overflow-hidden bg-brand-gradient text-white"
      aria-labelledby="hero-title"
    >
      <div className="pointer-events-none absolute inset-0" aria-hidden>
        <LogoOutline className="absolute -left-[22%] -bottom-[48%] h-[150%] w-auto text-white/[0.16]" />
        <div className="absolute inset-0 bg-[radial-gradient(70%_55%_at_18%_8%,rgba(201,87,136,0.32),transparent_62%)]" />
        <div className="absolute inset-0 bg-[radial-gradient(50%_40%_at_85%_90%,rgba(27,18,56,0.55),transparent_70%)]" />
      </div>

      <div className="container relative grid grid-cols-1 items-center gap-12 pb-16 pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:grid-cols-[1.02fr_0.98fr] lg:gap-10 lg:pb-24 lg:pt-[calc(var(--nav-h)+3.5rem)] xl:gap-16">
        <m.div style={{ y: reduced ? 0 : yText, opacity: reduced ? 1 : opacityText }} className="max-w-2xl">
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
            className="mt-6 text-[2.75rem] font-extrabold leading-[1.02] sm:text-6xl lg:text-[4rem] xl:text-[4.6rem]"
          />

          <m.p {...show(0.55)} className="mt-6 max-w-xl text-lg leading-relaxed text-white/80 sm:text-xl">
            Folha, ponto, eSocial, admissão digital, saúde e segurança do trabalho, talentos e People Analytics.
            Mais de 30 módulos integrados, com a NATI, nossa inteligência artificial, trabalhando dentro do sistema.
            Para grandes empresas que querem um RH protagonista.
          </m.p>

          <m.div {...show(0.7)} className="mt-9 flex flex-wrap items-center gap-3">
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

          <m.ul {...show(0.85)} className="mt-10 flex flex-wrap items-center gap-x-6 gap-y-2 text-[13px] font-medium text-white/70">
            {trust.map((t) => (
              <li key={t} className="flex items-center gap-2">
                <span className="h-1.5 w-1.5 rounded-full bg-[#E4A9C4]" aria-hidden />
                {t}
              </li>
            ))}
          </m.ul>
        </m.div>

        <m.div
          style={{ y: reduced ? 0 : yVisual }}
          initial={{ opacity: 0, y: 40, scale: 0.96 }}
          animate={done ? { opacity: 1, y: 0, scale: 1 } : { opacity: 0, y: 40, scale: 0.96 }}
          transition={{ duration: 1.1, ease: EASE, delay: 0.5 }}
          className="relative mx-auto w-full max-w-[380px] sm:max-w-[460px] lg:max-w-none lg:justify-self-end xl:max-w-[560px]"
        >
          <HumanModule
            src={people.hero.src}
            alt={people.hero.alt}
            frame={people.hero.frame}
            chips={chips}
            loading="eager"
          />
          <m.p
            {...show(1.1)}
            className="mt-4 text-center text-[12px] font-medium text-white/55 lg:absolute lg:-bottom-8 lg:left-1/2 lg:mt-0 lg:-translate-x-1/2 lg:whitespace-nowrap"
          >
            Gente no centro. O sistema em volta.
          </m.p>
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
        className="absolute bottom-5 left-1/2 hidden -translate-x-1/2 text-white/60 transition-colors hover:text-white lg:block"
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
    </section>
  )
}
