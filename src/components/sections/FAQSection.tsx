import { ArrowRight } from 'lucide-react'
import { Link } from 'react-router'
import { Section, SectionHeader } from './Section'
import { FaqAccordion } from './FaqAccordion'
import { Reveal } from '@/components/motion/Reveal'
import { faqs } from '@/content/faq'

export function FAQSection() {
  return (
    <Section id="faq" tone="white" aria-labelledby="faq-title">
      <div className="container grid gap-10 lg:grid-cols-[1fr_1.6fr] lg:gap-16">
        <div className="lg:sticky lg:top-32 lg:self-start">
          <SectionHeader
            id="faq-title"
            eyebrow="Perguntas frequentes"
            title="O que as empresas [[perguntam antes]] de escolher."
            lead="Respostas diretas sobre abrangência, eSocial, ponto, NATI, segurança e implantação."
          />
          <Reveal delay={0.3} className="mt-8">
            <Link to="#contato" className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
              Não encontrou a sua dúvida? Fale com a gente
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" />
            </Link>
          </Reveal>
        </div>

        <Reveal delay={0.15}>
          <FaqAccordion items={faqs} />
        </Reveal>
      </div>
    </Section>
  )
}
