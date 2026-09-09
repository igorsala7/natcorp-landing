import { ArrowRight } from 'lucide-react'
import { Link } from 'react-router'
import { Section, SectionHeader } from './Section'
import { FaqAccordion } from './FaqAccordion'
import { Reveal } from '@/components/motion/Reveal'
import { faqs, type FaqItem } from '@/content/faq'

interface FAQSectionProps {
  id?: string
  tone?: 'white' | 'off'
  items?: FaqItem[]
  eyebrow?: string
  title?: string
  lead?: string
  /** Link para a lista completa, quando a seção mostra só uma parte. */
  more?: { to: string; label: string }
  /** `false` quando a página já emite o próprio FAQPage com estas perguntas. */
  schema?: boolean
}

export function FAQSection({
  id = 'faq',
  tone = 'white',
  items = faqs,
  eyebrow = 'Perguntas frequentes',
  title = 'O que as empresas [[perguntam antes]] de escolher.',
  lead = 'Respostas diretas sobre abrangência, estrutura, volume, eSocial, ponto, NATI, segurança e implantação.',
  more,
  schema = true,
}: FAQSectionProps) {
  return (
    <Section id={id} tone={tone} aria-labelledby={`${id}-title`}>
      <div className="container grid gap-10 lg:grid-cols-[1fr_1.6fr] lg:gap-16">
        <div className="lg:sticky lg:top-32 lg:self-start">
          <SectionHeader id={`${id}-title`} eyebrow={eyebrow} title={title} lead={lead} />
          <Reveal delay={0.3} className="mt-8 flex flex-col gap-3">
            {more && (
              <Link to={more.to} className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
                {more.label}
                <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" />
              </Link>
            )}
            <Link to="#contato" className="group inline-flex items-center gap-2 text-[15px] font-semibold text-brand-purple">
              Não encontrou a sua dúvida? Fale com a gente
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" />
            </Link>
          </Reveal>
        </div>

        <Reveal delay={0.15}>
          <FaqAccordion items={items} schema={schema} />
        </Reveal>
      </div>
    </Section>
  )
}
