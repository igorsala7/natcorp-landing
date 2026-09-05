import { Suspense, lazy, useRef } from 'react'
import { useInView } from 'motion/react'
import { CheckCircle2 } from 'lucide-react'
import { LogoOutline } from '@/components/brand/Logo'
import { Reveal } from '@/components/motion/Reveal'
import { SplitText } from '@/components/motion/SplitText'
import { Eyebrow } from './Section'
import { siteConfig } from '@/content/site'

const LeadForm = lazy(() => import('./LeadForm'))

const bullets = [
  'Demonstração guiada pela realidade da sua empresa',
  'Time que acompanha de perto, da implantação ao dia a dia',
  'Sem compromisso e sem letra miúda',
]

interface CTASectionProps {
  title?: string
  text?: string
}

export function CTASection({
  title = 'Veja a Natcorp com os dados da sua empresa.',
  text = 'Conte um pouco sobre a sua operação de RH e agende uma conversa com quem entende de folha, ponto, eSocial e SESMT de grandes empresas. Respondemos em até 1 dia útil.',
}: CTASectionProps) {
  const ref = useRef<HTMLDivElement>(null)
  const near = useInView(ref, { once: true, margin: '800px 0px' })

  return (
    <section id="contato" className="bg-white py-6 sm:py-10" aria-labelledby="contato-title">
      <div className="container">
        <div className="on-dark relative overflow-hidden rounded-4xl bg-brand-gradient px-6 py-14 text-white sm:rounded-5xl sm:px-10 md:px-16 md:py-20">
          <div className="pointer-events-none absolute inset-0" aria-hidden>
            <LogoOutline className="absolute -right-[12%] -top-[40%] h-[150%] w-auto text-white/[0.22]" />
            <div className="absolute inset-0 bg-[radial-gradient(60%_50%_at_15%_15%,rgba(201,87,136,0.3),transparent_60%)]" />
          </div>

          <div className="relative grid gap-12 lg:grid-cols-[1fr_1.1fr] lg:gap-16">
            <div>
              <Reveal y={12} duration={0.5}>
                <Eyebrow tone="white">Agende uma demonstração</Eyebrow>
              </Reveal>
              <SplitText
                as="h2"
                id="contato-title"
                text={title}
                className="mt-5 text-3xl font-extrabold leading-[1.08] sm:text-4xl lg:text-5xl"
              />
              <Reveal delay={0.25}>
                <p className="mt-5 max-w-md text-lg leading-relaxed text-white/80">{text}</p>
              </Reveal>
              <Reveal delay={0.35}>
                <ul className="mt-8 space-y-3">
                  {bullets.map((b) => (
                    <li key={b} className="flex items-center gap-3 font-semibold">
                      <CheckCircle2 className="h-5 w-5 shrink-0 text-[#E4A9C4]" strokeWidth={2} aria-hidden />
                      {b}
                    </li>
                  ))}
                </ul>
              </Reveal>
              <Reveal delay={0.45}>
                <p className="mt-10 text-sm text-white/60">
                  Prefere e-mail?{' '}
                  <a href={`mailto:${siteConfig.email}`} className="font-semibold text-white underline-offset-4 hover:underline">
                    {siteConfig.email}
                  </a>
                </p>
              </Reveal>
            </div>

            <Reveal delay={0.2} ref={ref} className="rounded-3xl bg-white p-6 text-brand-ink shadow-glow sm:p-8">
              {near ? (
                <Suspense fallback={<FormSkeleton />}>
                  <LeadForm />
                </Suspense>
              ) : (
                <FormSkeleton />
              )}
            </Reveal>
          </div>
        </div>
      </div>
    </section>
  )
}

function FormSkeleton() {
  return (
    <div className="min-h-[560px] animate-pulse-soft space-y-4" aria-hidden>
      {[0, 1, 2, 3, 4].map((i) => (
        <div key={i} className="space-y-2">
          <div className="h-3 w-28 rounded bg-brand-mist" />
          <div className="h-11 rounded-lg bg-brand-off-white" />
        </div>
      ))}
      <div className="h-14 rounded-lg bg-brand-mist" />
    </div>
  )
}
