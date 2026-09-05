import { useRef } from 'react'
import { m, useReducedMotion, useScroll, useTransform } from 'motion/react'
import { ArrowRight, ChevronDown, Sparkles } from 'lucide-react'
import { Link } from 'react-router'
import { Button } from '@/components/ui/button'
import { HeroSymbol } from '@/components/brand/HeroSymbol'
import { SplitText } from '@/components/motion/SplitText'
import { Magnetic } from '@/components/motion/Magnetic'
import { useIntroDone } from '@/hooks/useIntroDone'
import { people } from '@/content/people'
import { paths } from '@/content/site'
import { EASE } from '@/lib/motion'
import { scrollToElement } from '@/components/motion/ScrollManager'

const trust = ['+30 módulos integrados', '2.500 folhas por minuto', 'NATI, a IA do RH', 'Nuvem Oracle com contingência']

/**
 * Abertura: fotografia real em tela cheia, véu no gradiente da marca à esquerda para o texto
 * e o símbolo Natcorp em luz envolvendo a pessoa à direita.
 */
export function Hero() {
  const done = useIntroDone()
  const reduced = useReducedMotion()
  const ref = useRef<HTMLElement>(null)
  const { scrollYProgress } = useScroll({ target: ref, offset: ['start start', 'end start'] })
  const yText = useTransform(scrollYProgress, [0, 1], [0, -70])
  const opacityText = useTransform(scrollYProgress, [0, 0.6], [1, 0])
  const yPhoto = useTransform(scrollYProgress, [0, 1], [0, 90])
  const scalePhoto = useTransform(scrollYProgress, [0, 1], [1, 1.06])

  const show = (delay: number) => ({
    initial: { opacity: 0, y: 20 },
    animate: done ? { opacity: 1, y: 0 } : { opacity: 0, y: 20 },
    transition: { duration: 0.8, ease: EASE, delay },
  })

  return (
    <section
      ref={ref}
      id="top"
      className="on-dark relative isolate flex min-h-[92svh] flex-col overflow-hidden bg-brand-blue text-white lg:min-h-0"
      aria-labelledby="hero-title"
    >
      {/* Fotografia + véus + símbolo */}
      <div className="absolute inset-0" aria-hidden>
        <m.div
          className="absolute inset-0"
          style={{ y: reduced ? 0 : yPhoto, scale: reduced ? 1 : scalePhoto }}
          initial={{ opacity: 0, scale: 1.06 }}
          animate={done ? { opacity: 1, scale: 1 } : { opacity: 0, scale: 1.06 }}
          transition={{ duration: 1.6, ease: EASE }}
        >
          <img
            src={people.hero.src}
            alt=""
            width={1800}
            height={1200}
            fetchPriority="high"
            decoding="async"
            className="absolute inset-0 h-full w-full object-cover object-[68%_18%] lg:object-[66%_38%]"
          />
        </m.div>
        {/* harmoniza a foto com a marca */}
        <div className="absolute inset-0 bg-brand-purple/45 mix-blend-multiply" />
        <div className="absolute inset-0 bg-[radial-gradient(60%_70%_at_72%_45%,rgba(201,87,136,0.18),transparent_70%)]" />
        {/* o símbolo em luz fica sob os véus: à esquerda ele se dissolve no roxo do texto */}
        <m.div
          className="absolute right-[-64%] top-0 h-[95%] lg:right-[-2.5%] lg:top-[60%] lg:h-[112%] lg:-translate-y-1/2"
          initial={{ opacity: 0, scale: 0.94 }}
          animate={done ? { opacity: 1, scale: 1 } : { opacity: 0, scale: 0.94 }}
          transition={{ duration: 1.4, ease: EASE, delay: 0.35 }}
        >
          <HeroSymbol className="h-full w-auto" />
        </m.div>
        {/* véu para o texto: base no celular, lateral esquerda no desktop */}
        <div className="absolute inset-0 bg-[linear-gradient(180deg,rgba(44,26,99,0.35)_0%,rgba(44,26,99,0.15)_32%,rgba(44,26,99,0.92)_58%,#2C1A63_72%)] lg:bg-[linear-gradient(90deg,#2C1A63_0%,rgba(44,26,99,0.96)_24%,rgba(60,30,110,0.72)_46%,rgba(81,28,118,0.22)_66%,rgba(81,28,118,0)_100%)]" />
        <div className="absolute inset-0 hidden bg-[linear-gradient(180deg,rgba(44,26,99,0.45)_0%,transparent_22%,transparent_78%,rgba(27,18,56,0.5)_100%)] lg:block" />
      </div>

      <div className="container relative mt-auto flex flex-col pb-14 pt-[calc(var(--nav-h)+50svh)] sm:pt-[calc(var(--nav-h)+46svh)] lg:min-h-[min(760px,88vh)] lg:justify-center lg:py-[calc(var(--nav-h)+4rem)]">
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
            className="mt-6 text-[2.75rem] font-extrabold leading-[1.02] sm:text-6xl lg:text-[4.4rem] xl:text-[5rem]"
          />

          <m.p {...show(0.55)} className="mt-6 max-w-xl text-lg leading-relaxed text-white/85 sm:text-xl">
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
              <Link to={paths.system}>Conhecer o sistema</Link>
            </Button>
          </m.div>

          <m.ul {...show(0.85)} className="mt-10 flex flex-wrap items-center gap-x-6 gap-y-2 text-[13px] font-medium text-white/75">
            {trust.map((t) => (
              <li key={t} className="flex items-center gap-2">
                <span className="h-1.5 w-1.5 rounded-full bg-[#E4A9C4]" aria-hidden />
                {t}
              </li>
            ))}
          </m.ul>
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
        <m.span className="block" animate={{ y: [0, 6, 0] }} transition={{ duration: 1.8, repeat: Infinity, ease: 'easeInOut' }}>
          <ChevronDown className="h-6 w-6" />
        </m.span>
      </m.a>
    </section>
  )
}
