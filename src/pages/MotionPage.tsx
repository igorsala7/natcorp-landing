import { useState } from 'react'
import { RotateCcw } from 'lucide-react'
import { Section, Eyebrow } from '@/components/sections/Section'
import { PageTransition } from '@/components/motion/PageTransition'
import { LogoMotion } from '@/components/brand/LogoMotion'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'

/**
 * Página interna de motion da marca: mostra as peças animadas em fundo escuro e claro,
 * com um botão para repetir. Fora do menu e do sitemap.
 */
export default function MotionPage() {
  useSeo({ title: 'Motion da marca | Natcorp', description: 'Peças de motion da identidade Natcorp.', path: '/motion', noindex: true })
  const [take, setTake] = useState(0)
  const replay = () => setTake((t) => t + 1)

  return (
    <PageTransition>
      <Section tone="off" className="pt-[calc(var(--nav-h)+3rem)] pb-10 sm:pb-12 lg:pb-14" aria-labelledby="motion-title">
        <div className="container">
          <div className="flex flex-wrap items-end justify-between gap-4">
            <div>
              <Eyebrow>Motion da marca</Eyebrow>
              <h1 id="motion-title" className="mt-4 text-4xl font-extrabold tracking-tight text-brand-ink sm:text-5xl">
                A assinatura em movimento
              </h1>
              <p className="mt-3 max-w-2xl text-lg text-brand-graphite">
                Os quatro módulos se encontram, o X acende do centro para fora e o nome aparece ao lado.
              </p>
            </div>
            <Button type="button" size="lg" onClick={replay}>
              <RotateCcw />
              Repetir
            </Button>
          </div>
        </div>
      </Section>

      <Section tone="dark" flush className="py-0" aria-label="Assinatura em fundo escuro">
        <div className="container flex min-h-[60vh] items-center justify-center py-16" data-motion="dark">
          <LogoMotion key={`dark-${take}`} tone="white" className="w-[min(78vw,560px)]" />
        </div>
      </Section>

      <Section tone="white" flush className="py-0" aria-label="Assinatura em fundo claro">
        <div className="container flex min-h-[60vh] items-center justify-center py-16" data-motion="light">
          <LogoMotion key={`light-${take}`} tone="gradient" className="w-[min(78vw,560px)]" />
        </div>
      </Section>
    </PageTransition>
  )
}
