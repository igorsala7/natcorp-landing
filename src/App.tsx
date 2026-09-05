import { Toaster } from '@/components/ui/sonner'
import { MotionProvider } from '@/components/motion/MotionProvider'
import { IntroProvider } from '@/components/motion/Intro'
import { SmoothScroll } from '@/components/motion/SmoothScroll'
import { ScrollProgress } from '@/components/motion/ScrollProgress'
import { Navbar } from '@/components/sections/Navbar'
import { Hero } from '@/components/sections/Hero'
import { ProofStrip } from '@/components/sections/ProofStrip'
import { ProblemSection } from '@/components/sections/ProblemSection'
import { PlatformSection } from '@/components/sections/PlatformSection'
import { ModulesSection } from '@/components/sections/ModulesSection'
import { JourneySection } from '@/components/sections/JourneySection'
import { NatiSection } from '@/components/sections/NatiSection'
import { PortalsSection } from '@/components/sections/PortalsSection'
import { SecuritySection } from '@/components/sections/SecuritySection'
import { WhySection } from '@/components/sections/WhySection'
import { PersonasSection } from '@/components/sections/PersonasSection'
import { FAQSection } from '@/components/sections/FAQSection'
import { CTASection } from '@/components/sections/CTASection'
import { Footer } from '@/components/sections/Footer'

function App() {
  return (
    <MotionProvider>
      <IntroProvider>
        <a
          href="#conteudo"
          className="sr-only focus:not-sr-only focus:fixed focus:left-4 focus:top-4 focus:z-[80] focus:rounded-lg focus:bg-white focus:px-4 focus:py-2 focus:text-sm focus:font-semibold focus:text-brand-purple focus:shadow-lift"
        >
          Pular para o conteúdo
        </a>
        <SmoothScroll />
        <ScrollProgress />
        <Navbar />
        <main id="conteudo">
          <Hero />
          <ProofStrip />
          <ProblemSection />
          <PlatformSection />
          <ModulesSection />
          <JourneySection />
          <NatiSection />
          <PortalsSection />
          <SecuritySection />
          <WhySection />
          <PersonasSection />
          <FAQSection />
          <CTASection />
        </main>
        <Footer />
        <Toaster position="bottom-right" />
      </IntroProvider>
    </MotionProvider>
  )
}

export default App
