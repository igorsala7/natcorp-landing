import { Hero } from '@/components/sections/Hero'
import { ProofStrip } from '@/components/sections/ProofStrip'
import { ProblemSection } from '@/components/sections/ProblemSection'
import { PlatformSection } from '@/components/sections/PlatformSection'
import { JourneySection } from '@/components/sections/JourneySection'
import { NatiSection } from '@/components/sections/NatiSection'
import { SegmentsSection } from '@/components/sections/SegmentsSection'
import { WhySection } from '@/components/sections/WhySection'
import { FAQSection } from '@/components/sections/FAQSection'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { useSeo } from '@/hooks/useSeo'
import { faqs } from '@/content/faq'
import { paths, siteConfig } from '@/content/site'

/** Página inicial: convence e encaminha. O detalhe de cada assunto vive nas páginas. */
export default function LandingPage() {
  useSeo({ title: siteConfig.defaultTitle, description: siteConfig.defaultDescription, path: '/' })
  return (
    <PageTransition>
      <Hero />
      <ProofStrip />
      <ProblemSection />
      <PlatformSection />
      <JourneySection />
      <NatiSection />
      <SegmentsSection />
      <WhySection />
      <FAQSection
        items={faqs.slice(0, 4)}
        lead="As quatro perguntas mais comuns. A lista completa está na página do sistema."
        more={{ to: `${paths.system}#faq`, label: 'Ver todas as perguntas' }}
      />
      <CTASection />
    </PageTransition>
  )
}
