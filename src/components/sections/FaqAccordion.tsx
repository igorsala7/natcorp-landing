import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from '@/components/ui/accordion'
import { JsonLd } from '@/components/seo/JsonLd'
import type { FaqItem } from '@/content/faq'

/** Acordeão de perguntas com JSON-LD FAQPage. */
export function FaqAccordion({ items, className }: { items: FaqItem[]; className?: string }) {
  const data = {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: items.map((f) => ({
      '@type': 'Question',
      name: f.q,
      acceptedAnswer: { '@type': 'Answer', text: f.a },
    })),
  }
  return (
    <>
      <JsonLd data={data} />
      <Accordion
        type="single"
        collapsible
        className={className ?? 'divide-y divide-brand-mist rounded-3xl border border-brand-mist bg-white px-6 shadow-soft sm:px-8'}
      >
        {items.map((f, i) => (
          <AccordionItem key={f.q} value={`item-${i}`} className="border-0">
            <AccordionTrigger className="py-5 text-left text-[16px] font-bold text-brand-ink hover:no-underline hover:text-brand-purple [&>svg]:h-5 [&>svg]:w-5 [&>svg]:text-brand-purple">
              {f.q}
            </AccordionTrigger>
            <AccordionContent className="pb-6 text-[15px] leading-relaxed text-brand-graphite">{f.a}</AccordionContent>
          </AccordionItem>
        ))}
      </Accordion>
    </>
  )
}
