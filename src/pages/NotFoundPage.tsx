import { Link } from 'react-router'
import { ArrowRight } from 'lucide-react'
import { Section } from '@/components/sections/Section'
import { PageTransition } from '@/components/motion/PageTransition'
import { Logo } from '@/components/brand/Logo'
import { Button } from '@/components/ui/button'
import { useSeo } from '@/hooks/useSeo'

export default function NotFoundPage() {
  useSeo({ title: 'Página não encontrada | Natcorp', description: 'A página que você procura não existe.', path: '/404', noindex: true })
  return (
    <PageTransition>
      <Section tone="off" className="min-h-[70vh] pt-[calc(var(--nav-h)+4rem)]" aria-labelledby="nf-title">
        <div className="container max-w-2xl text-center">
          <Logo variant="symbol" className="mx-auto h-14 w-14" decorative />
          <h1 id="nf-title" className="mt-8 text-4xl font-extrabold text-brand-ink sm:text-5xl">
            Essa página não existe.
          </h1>
          <p className="mt-4 text-lg text-brand-graphite">
            O endereço pode ter mudado. Volte para a página inicial ou veja a lista completa de módulos.
          </p>
          <div className="mt-8 flex flex-wrap justify-center gap-3">
            <Button asChild size="lg">
              <Link to="/">
                Página inicial
                <ArrowRight />
              </Link>
            </Button>
            <Button asChild size="lg" variant="secondary">
              <Link to="/modulos">Todos os módulos</Link>
            </Button>
          </div>
        </div>
      </Section>
    </PageTransition>
  )
}
