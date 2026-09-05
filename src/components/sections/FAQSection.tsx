import { ArrowRight } from 'lucide-react'
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from '@/components/ui/accordion'
import { Section, SectionHeader } from './Section'
import { Reveal } from '@/components/motion/Reveal'
import { faqs } from '@/content/faq'

const faqJsonLd = JSON.stringify({
  '@context': 'https://schema.org',
  '@type': 'FAQPage',
  mainEntity: faqs.map((f) => ({
    '@type': 'Question',
    name: f.q,
    acceptedAnswer: { '@type': 'Answer', text: f.a },
  })),
})

export function FAQSection() {
  return (
    <Section id="faq" tone="white" aria-labelledby="faq-title">
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: faqJsonLd }} />
      <div className="container grid gap-10 lg:grid-cols-[1fr_1.6fr] lg:gap-16">
        <div className="lg:sticky lg:top-32 lg:self-start">
          <SectionHeader
            id="faq-title"
            eyebrow="Perguntas frequentes"
            title="O que as empresas [[perguntam antes]] de escolher."
            lead="Respostas diretas sobre abrangência, eSocial, ponto, NATI, segurança e implantação."
          />
          <Reveal delay={0.3} className="mt-8">
            <a
              href="#contato"
              className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple"
            >
              Não encontrou a sua dúvida? Fale com a gente
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" />
            </a>
          </Reveal>
        </div>

        <Reveal delay={0.15}>
          <Accordion type="single" collapsible className="divide-y divide-brand-mist rounded-3xl border border-brand-mist bg-white px-6 shadow-soft sm:px-8">
            {faqs.map((f, i) => (
              <AccordionItem key={f.q} value={`item-${i}`} className="border-0">
                <AccordionTrigger className="py-5 text-left text-[16px] font-bold text-brand-ink hover:no-underline hover:text-brand-purple [&>svg]:h-5 [&>svg]:w-5 [&>svg]:text-brand-purple">
                  {f.q}
                </AccordionTrigger>
                <AccordionContent className="pb-6 text-[15px] leading-relaxed text-brand-graphite">
                  {f.a}
                </AccordionContent>
              </AccordionItem>
            ))}
          </Accordion>
        </Reveal>
      </div>
    </Section>
  )
}
