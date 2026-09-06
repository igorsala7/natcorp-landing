import { m, type MotionValue } from 'motion/react'
import { ScanFace } from 'lucide-react'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { EASE } from '@/lib/motion'
import heroScene from '@/assets/people/hero-scene.webp'

/**
 * Fundo do hero em cena completa: a profissional com o tablet junto à janela, envolvida pelos
 * módulos em néon e pelas ondas de dados (imagem fornecida pela Natcorp). Por cima, só o que
 * a cena não tem: o véu para o texto, um brilho que deriva devagar e os cartões do sistema.
 */

interface HeroSceneProps {
  on: boolean
  reduced: boolean
  y: MotionValue<number> | 0
  scale: MotionValue<number> | 1
}

export function HeroScene({ on, reduced, y, scale }: HeroSceneProps) {
  return (
    <div className="absolute inset-0" aria-hidden>
      <m.div
        className="absolute inset-0"
        style={{ y, scale }}
        initial={{ opacity: 0, scale: 1.06 }}
        animate={on ? { opacity: 1, scale: 1 } : { opacity: 0, scale: 1.06 }}
        transition={{ duration: 1.6, ease: EASE }}
      >
        <img
          src={heroScene}
          alt=""
          width={2000}
          height={1116}
          fetchPriority="high"
          decoding="async"
          draggable={false}
          className="absolute inset-0 h-full w-full object-cover object-[78%_18%] lg:object-[70%_40%]"
        />
      </m.div>

      {/* brilho que deriva devagar sobre as ondas, em screen, para a cena respirar */}
      {!reduced && (
        <m.div
          className="absolute left-[10%] top-[20%] h-[60%] w-[50%] rounded-full bg-[radial-gradient(closest-side,rgba(201,87,136,0.35),transparent)] blur-3xl"
          style={{ mixBlendMode: 'screen' }}
          animate={{ x: ['0%', '18%', '0%'], y: ['0%', '-10%', '0%'], opacity: [0.5, 0.9, 0.5] }}
          transition={{ duration: 14, ease: 'easeInOut', repeat: Infinity }}
        />
      )}

      {/* véu para o texto: base no celular, lateral esquerda no desktop */}
      <div className="absolute inset-0 bg-[linear-gradient(180deg,rgba(44,26,99,0.35)_0%,rgba(44,26,99,0.12)_18%,rgba(44,26,99,0.86)_46%,#2C1A63_60%)] lg:bg-[linear-gradient(90deg,#2C1A63_0%,rgba(44,26,99,0.94)_20%,rgba(44,26,99,0.7)_38%,rgba(44,26,99,0.28)_52%,rgba(44,26,99,0)_66%)]" />
      <div className="absolute inset-0 hidden bg-[linear-gradient(180deg,rgba(27,18,56,0.5)_0%,transparent_20%,transparent_80%,rgba(27,18,56,0.45)_100%)] lg:block" />

      {/* cartões do sistema, perto do tablet */}
      <m.div
        className="absolute right-[3%] top-[22%] hidden w-[300px] lg:block xl:right-[4%]"
        initial={{ opacity: 0, y: 16 }}
        animate={on ? { opacity: 1, y: 0 } : { opacity: 0, y: 16 }}
        transition={{ duration: 0.9, ease: EASE, delay: 1.2 }}
      >
        <m.div
          className="rounded-2xl border border-white/15 bg-[#1B1238]/55 p-3.5 shadow-[0_12px_40px_rgba(27,18,56,0.45)] backdrop-blur-md"
          animate={reduced ? undefined : { y: [0, -7, 0] }}
          transition={{ duration: 6.5, ease: 'easeInOut', repeat: Infinity }}
        >
          <div className="flex items-start gap-3">
            <NatiAvatar ring className="h-9 w-9 shrink-0" />
            <div className="min-w-0">
              <p className="text-[10.5px] font-bold uppercase tracking-[0.14em] text-[#E4A9C4]">NATI · Inteligência Artificial</p>
              <p className="mt-0.5 text-[13.5px] font-semibold leading-snug text-white">12 pessoas com férias vencendo em setembro. Preparei os avisos aos gestores.</p>
            </div>
          </div>
        </m.div>
      </m.div>
      <m.div
        className="absolute bottom-[14%] right-[6%] hidden w-[270px] lg:block"
        initial={{ opacity: 0, y: 16 }}
        animate={on ? { opacity: 1, y: 0 } : { opacity: 0, y: 16 }}
        transition={{ duration: 0.9, ease: EASE, delay: 1.4 }}
      >
        <m.div
          className="rounded-2xl border border-white/15 bg-[#1B1238]/55 p-3.5 shadow-[0_12px_40px_rgba(27,18,56,0.45)] backdrop-blur-md"
          animate={reduced ? undefined : { y: [0, -5, 0] }}
          transition={{ duration: 7, ease: 'easeInOut', repeat: Infinity, delay: 1.6 }}
        >
          <div className="flex items-center gap-3">
            <span className="grid h-9 w-9 shrink-0 place-items-center rounded-xl bg-[#C95788]/25 text-[#F3C9DA] ring-1 ring-[#E4A9C4]/40">
              <ScanFace className="h-[18px] w-[18px]" strokeWidth={2} />
            </span>
            <div className="min-w-0">
              <p className="text-[10.5px] font-bold uppercase tracking-[0.14em] text-[#E4A9C4]">NatPonto</p>
              <p className="mt-0.5 text-[13.5px] font-semibold leading-snug text-white">Marcação às 08:02, com reconhecimento facial</p>
            </div>
          </div>
        </m.div>
      </m.div>
    </div>
  )
}
