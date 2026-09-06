import { ArrowRight, Check, Globe, Mail, MessageCircle, Phone } from 'lucide-react'
import { Link } from 'react-router'
import { Logo } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { contato, espera, proximos } from '@/content/presentation'
import { paths, siteConfig } from '@/content/site'
import { Big, Card, Chip, IconBox, Item, Rise, Slide, SlideLead, SlideTitle, Stagger, type SlideMeta } from '../Slide'

/* 20 · O custo de esperar (gradiente, contorno). */
export function EsperaSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="gradient" contour>
      <div className="max-w-[56rem]">
        <SlideTitle dark text={espera.title} />
      </div>
      <Stagger className="mt-[clamp(1.25rem,4vh,2.5rem)] grid gap-3 sm:grid-cols-2" delay={0.35} stagger={0.1}>
        {espera.items.map((it) => (
          <Item key={it.title}>
            <Card dark className="flex h-full gap-4">
              <span className="text-[length:var(--dk-mid)] font-extrabold leading-none tracking-brand text-[#E4A9C4]" aria-hidden>
                +1
              </span>
              <div className="min-w-0">
                <p className="text-[length:var(--dk-body)] font-bold leading-snug text-white">{it.title}</p>
                <p className="mt-1 text-[length:var(--dk-small)] leading-snug text-white/72">{it.text}</p>
              </div>
            </Card>
          </Item>
        ))}
      </Stagger>
      <Rise delay={0.8} className="mt-[clamp(1.25rem,4vh,2.5rem)] border-l-[3px] border-[#E4A9C4] pl-5">
        <p className="max-w-[46rem] text-[length:var(--dk-lead)] font-bold leading-snug text-white">{espera.punch}</p>
      </Rise>
    </Slide>
  )
}

/* 21 · Próximos passos. */
export function ProximosSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="white">
      <div className="max-w-[52rem]">
        <SlideTitle text={proximos.title} />
      </div>
      <div className="mt-[clamp(1.25rem,4vh,2.5rem)] grid gap-[clamp(1rem,2.5vw,3rem)] lg:grid-cols-[1.5fr_0.8fr] lg:items-start">
        <Stagger className="grid gap-3 sm:grid-cols-3" delay={0.3} stagger={0.1}>
          {proximos.steps.map((s, i) => (
            <Item key={s.title}>
              <Card className="flex h-full flex-col">
                <div className="flex items-center justify-between gap-2">
                  <Big size="md" value={`0${i + 1}`} label="" className="[&>p:last-child]:hidden" />
                  <Chip tone="pink">{s.when}</Chip>
                </div>
                <p className="mt-2 text-[length:var(--dk-body)] font-bold leading-snug text-brand-ink">{s.title}</p>
                <p className="mt-1.5 text-[length:var(--dk-small)] leading-relaxed text-brand-graphite">{s.text}</p>
              </Card>
            </Item>
          ))}
        </Stagger>
        <Rise delay={0.6} className="min-w-0">
          <Card accent className="h-full">
            <p className="text-[length:var(--dk-eyebrow)] font-extrabold uppercase tracking-[0.14em] text-brand-pink">{proximos.ask.title}</p>
            <ul className="mt-3 space-y-2">
              {proximos.ask.items.map((t) => (
                <li key={t} className="flex items-start gap-2 text-[length:var(--dk-body)] leading-snug text-brand-ink">
                  <span className="mt-[0.15em] flex h-[1.2em] w-[1.2em] shrink-0 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
                    <Check className="h-[0.65em] w-[0.65em]" strokeWidth={3} aria-hidden />
                  </span>
                  {t}
                </li>
              ))}
            </ul>
          </Card>
        </Rise>
      </div>
    </Slide>
  )
}

const channels = [
  { icon: Phone, label: 'Telefone', value: siteConfig.phone, href: siteConfig.phoneHref, external: false },
  { icon: MessageCircle, label: 'WhatsApp', value: siteConfig.whatsapp, href: siteConfig.whatsappHref, external: true },
  { icon: Mail, label: 'E-mail', value: siteConfig.email, href: `mailto:${siteConfig.email}`, external: false },
  { icon: Globe, label: 'Site', value: 'natcorp.com.br', href: siteConfig.url, external: true },
]

/* 22 · Contato: assinatura negativa sobre gradiente, o convite e os canais. */
export function ContatoSlide(meta: SlideMeta) {
  return (
    <Slide {...meta} tone="gradient" contour>
      <div className="grid gap-[clamp(1.25rem,3vw,4rem)] lg:grid-cols-[1.15fr_0.85fr] lg:items-center">
        <div>
          <Rise y={0}>
            <Logo variant="horizontal" tone="white" className="h-[clamp(1.6rem,3.6vh,2.4rem)] w-auto" decorative />
          </Rise>
          <SlideTitle dark text={contato.title} className="mt-[clamp(1rem,3vh,1.75rem)] max-w-[16ch]" />
          <SlideLead dark className="mt-4 max-w-[32rem]">
            {contato.lead}
          </SlideLead>
          <Rise delay={0.5} className="mt-[clamp(1.25rem,3.5vh,2rem)] flex flex-wrap gap-3">
            <Button asChild size="lg" variant="inverse">
              <Link to={`${paths.contact}#contato`}>
                Agendar uma demonstração
                <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
              </Link>
            </Button>
            <Button asChild size="lg" variant="outline-inverse">
              <a href={siteConfig.whatsappHref} target="_blank" rel="noopener noreferrer">
                Falar no WhatsApp
              </a>
            </Button>
          </Rise>
        </div>
        <Stagger className="grid gap-2.5" delay={0.4} stagger={0.08}>
          {channels.map((c) => (
            <Item key={c.label}>
              <a
                href={c.href}
                target={c.external ? '_blank' : undefined}
                rel={c.external ? 'noopener noreferrer' : undefined}
                className="flex items-center gap-4 rounded-2xl border border-white/15 bg-white/[0.06] p-[calc(var(--dk-card)*0.85)] transition-colors hover:bg-white/[0.12]"
              >
                <IconBox dark>
                  <c.icon strokeWidth={1.7} />
                </IconBox>
                <span className="min-w-0">
                  <span className="block text-[length:var(--dk-eyebrow)] font-semibold uppercase tracking-[0.12em] text-white/60">{c.label}</span>
                  <span className="block truncate text-[length:var(--dk-body)] font-bold text-white">{c.value}</span>
                </span>
              </a>
            </Item>
          ))}
          <Item>
            <p className="px-1 pt-1 text-[length:var(--dk-small)] leading-snug text-white/65">
              {siteConfig.city}. {siteConfig.coverage}
            </p>
          </Item>
        </Stagger>
      </div>
    </Slide>
  )
}
