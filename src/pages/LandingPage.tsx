import { Hero } from '@/components/sections/Hero'
import { NatiTeaser } from '@/components/sections/NatiTeaser'
import { ProblemSection } from '@/components/sections/ProblemSection'
import { PlatformSection } from '@/components/sections/PlatformSection'
import { StructureChooserSection } from '@/components/sections/StructureChooserSection'
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
import { CTAInline } from '@/components/sections/CTAInline'

/** Página inicial: convence e encaminha. O detalhe de cada assunto vive nas páginas. */
export default function LandingPage() {
  useSeo({ title: siteConfig.defaultTitle, description: siteConfig.defaultDescription, path: '/' })
  return (
    <PageTransition>
      <Hero />
      <NatiTeaser />
      <ProblemSection />
      <PlatformSection />
      <StructureChooserSection />
      <JourneySection />
      <CTAInline titulo="Já dá para ver o seu RH assim?" tom="marca" />
      <NatiSection />
      <SegmentsSection />
      <WhySection />
      <FAQSection
        items={faqs.slice(0, 4)}
        lead="As quatro perguntas mais comuns. A lista completa está na página de perguntas frequentes."
        more={{ to: paths.faq, label: 'Ver todas as perguntas' }}
      />
      <CTASection />
    </PageTransition>
  )
}
