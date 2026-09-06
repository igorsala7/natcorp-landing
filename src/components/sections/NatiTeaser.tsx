import { useEffect, useState } from 'react'
import { AnimatePresence, m, useReducedMotion } from 'motion/react'
import { ArrowRight } from 'lucide-react'
import { Link } from 'react-router'
import { Button } from '@/components/ui/button'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { NetworkField } from '@/components/nati/NetworkField'
import { TypedText } from '@/components/motion/TypedText'
import { Reveal } from '@/components/motion/Reveal'
import { insights } from '@/content/nati'
import { paths } from '@/content/site'
import { EASE } from '@/lib/motion'

/** Prévia do poder da NATI logo no começo da home: uma análise por vez, digitada, cruzando módulos. */
export function NatiTeaser() {
  const reduced = useReducedMotion()
  const [i, setI] = useState(0)
  useEffect(() => {
    if (reduced) return
    const t = window.setInterval(() => setI((v) => (v + 1) % insights.length), 6500)
    return () => window.clearInterval(t)
  }, [reduced])
  const ins = insights[i]
  const firstSentence = ins.text.split('. ')[0] + '.'

  return (
    <section className="bg-white pb-4 pt-2 sm:pb-8" aria-labelledby="nati-teaser-title">
      <div className="container">
        <Reveal>
          <div className="on-dark relative overflow-hidden rounded-3xl bg-brand-ink text-white shadow-glow">
            <NetworkField density={0.9} className="opacity-60" />
            <div className="pointer-events-none absolute inset-0 bg-[radial-gradient(50%_80%_at_0%_50%,rgba(154,64,138,0.45),transparent_60%)]" aria-hidden />
            <div className="relative grid grid-cols-1 items-center gap-6 px-6 py-6 lg:grid-cols-[minmax(0,17rem)_1fr_auto] lg:gap-10 lg:px-8">
              <div className="flex items-center gap-4">
                <span className="relative shrink-0">
                  <span className="absolute inset-[-6px] animate-pulse-soft rounded-full bg-[#C95788]/30 blur-md" aria-hidden />
                  <NatiAvatar ring className="relative h-14 w-14" />
                </span>
                <div>
                  <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-[#E4A9C4]">NATI · Inteligência Artificial especialista em RH</p>
                  <h2 id="nati-teaser-title" className="mt-1 text-[17px] font-extrabold leading-snug">
                    Enquanto você lia isto, a NATI cruzou todos os módulos do sistema.
                  </h2>
                </div>
              </div>

              <div className="min-w-0 rounded-2xl border border-white/10 bg-white/[0.06] px-4 py-3" aria-live="polite">
                <AnimatePresence mode="wait" initial={false}>
                  <m.div key={ins.id} initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -6 }} transition={{ duration: 0.35, ease: EASE }}>
                    <ul className="flex flex-wrap gap-1.5" aria-label="Módulos cruzados">
                      {ins.modules.map((mo) => (
                        <li key={mo} className="rounded-md border border-[#E4A9C4]/35 bg-[#E4A9C4]/10 px-2 py-0.5 text-[10.5px] font-semibold text-[#F3C9DA]">
                          {mo}
                        </li>
                      ))}
                    </ul>
                    <p className="mt-2 text-[14.5px] font-medium leading-snug text-white/90">
                      <TypedText key={ins.id} text={firstSentence} speed={14} delay={100} />
                    </p>
                  </m.div>
                </AnimatePresence>
              </div>

              <div className="flex flex-wrap items-center gap-3 lg:flex-col lg:items-stretch">
                <Button asChild variant="inverse" size="lg">
                  <Link to="#nati">
                    Ver a NATI em ação
                    <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
                  </Link>
                </Button>
                <Link to={paths.nati} className="inline-flex items-center justify-center gap-1.5 text-sm font-semibold text-white/85 underline-offset-4 hover:text-white hover:underline">
                  Conhecer a NATI
                </Link>
              </div>
            </div>
          </div>
        </Reveal>
      </div>
    </section>
  )
}
