import { Hero } from '@/components/sections/Hero'
import { ProofStrip } from '@/components/sections/ProofStrip'
import { ProblemSection } from '@/components/sections/ProblemSection'
import { PlatformSection } from '@/components/sections/PlatformSection'
import { ModulesSection } from '@/components/sections/ModulesSection'
import { JourneySection } from '@/components/sections/JourneySection'
import { NatiSection } from '@/components/sections/NatiSection'
import { NatPontoSection } from '@/components/sections/NatPontoSection'
import { PortalsSection } from '@/components/sections/PortalsSection'
import { ResponsiveSection } from '@/components/sections/ResponsiveSection'
import { SecuritySection } from '@/components/sections/SecuritySection'
import { WhySection } from '@/components/sections/WhySection'
import { PersonasSection } from '@/components/sections/PersonasSection'
import { FAQSection } from '@/components/sections/FAQSection'
import { CTASection } from '@/components/sections/CTASection'
import { PageTransition } from '@/components/motion/PageTransition'
import { useSeo } from '@/hooks/useSeo'
import { siteConfig } from '@/content/site'

export default function LandingPage() {
  useSeo({ title: siteConfig.defaultTitle, description: siteConfig.defaultDescription, path: '/' })
  return (
    <PageTransition>
      <Hero />
      <ProofStrip />
      <ProblemSection />
      <PlatformSection />
      <ModulesSection />
      <JourneySection />
      <NatiSection />
      <NatPontoSection />
      <PortalsSection />
      <ResponsiveSection />
      <SecuritySection />
      <WhySection />
      <PersonasSection />
      <FAQSection />
      <CTASection />
    </PageTransition>
  )
}
