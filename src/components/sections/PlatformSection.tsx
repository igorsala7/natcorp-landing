import { ArrowRight } from 'lucide-react'
import { Link } from 'react-router'
import { Button } from '@/components/ui/button'
import { Reveal } from '@/components/motion/Reveal'
import { SplitText } from '@/components/motion/SplitText'
import { ModuleField } from '@/components/platform/ModuleField'
import { ModuleFieldCompact } from '@/components/platform/ModuleFieldCompact'
import { CategoryCards } from '@/components/platform/CategoryCards'
import { useIsDesktop } from '@/hooks/useMediaQuery'
import { moduleRegistry } from '@/content/modulePages'
import { paths } from '@/content/site'
import { Eyebrow, Section } from './Section'

/* Os dois pilares, em texto corrido ao lado do título. */
const pillars = [
  { title: 'Um cadastro', text: 'O colaborador entra uma vez e já existe na folha, no ponto, nos benefícios e no SESMT.' },
  { title: 'Uma experiência', text: 'Portais por perfil, no celular ou no computador, com a mesma linguagem para gestor, colaborador e candidato.' },
]

/**
 * A plataforma: o produto principal do site. Abre com o título e o argumento, mostra os 31 módulos
 * em volta de uma única base (o palco), resume as sete frentes em cartões que levam à página de
 * módulos e fecha com os dois caminhos: todos os módulos e os portais.
 */
export function PlatformSection() {
  const desktop = useIsDesktop()
  const count = moduleRegistry.length

  return (
    <Section id="plataforma" tone="off" className="overflow-x-clip" aria-labelledby="plataforma-title">
      <div className="container">
        {/* Abertura */}
        <div className="grid gap-8 lg:grid-cols-[minmax(0,1.3fr)_minmax(0,1fr)] lg:items-end lg:gap-16">
          <div>
            <Reveal y={12} duration={0.5}>
              <Eyebrow>A plataforma</Eyebrow>
            </Reveal>
            <SplitText
              as="h2"
              id="plataforma-title"
              text="Um sistema. [[Uma experiência.]]"
              className="mt-5 text-[2rem] font-extrabold leading-[1.08] text-brand-ink sm:text-4xl lg:text-5xl"
              highlightClassName="text-brand-purple"
            />
            <Reveal delay={0.25} y={16}>
              <p className="mt-5 max-w-2xl text-lg leading-relaxed text-brand-graphite sm:text-xl">
                {count} módulos nativos, um só cadastro, uma só base de dados e a mesma experiência no computador e no celular.
              </p>
            </Reveal>
          </div>
          <Reveal delay={0.3} y={16}>
            <ul className="grid gap-3 sm:grid-cols-2 lg:grid-cols-1 lg:gap-2.5 lg:pb-1" aria-label="Os pilares da plataforma">
              {pillars.map((p) => (
                <li key={p.title} className="flex gap-2.5 text-[14.5px] leading-snug text-brand-graphite">
                  <span aria-hidden className="mt-[7px] h-1.5 w-1.5 shrink-0 rotate-45 rounded-[1px] bg-brand-gradient" />
                  <span>
                    <strong className="font-bold text-brand-ink">{p.title}.</strong> {p.text}
                  </span>
                </li>
              ))}
            </ul>
          </Reveal>
        </div>

        {/* O palco: os 31 módulos em volta de uma única base */}
        <div className="mt-12 lg:mt-16">
          {desktop ? <ModuleField /> : <ModuleFieldCompact />}
          <p className="mt-3 text-center text-[12.5px] text-brand-graphite">
            {desktop ? 'Passe o mouse sobre um módulo para ver o que ele faz. Cada um tem a sua página.' : 'Cada módulo tem a sua página. Escolha uma frente abaixo.'}
          </p>
        </div>

        {/* As sete frentes */}
        <div className="mt-14 lg:mt-20">
          <Reveal y={16}>
            <div className="flex flex-wrap items-end justify-between gap-x-10 gap-y-4">
              <div>
                <Eyebrow>Sete frentes</Eyebrow>
                <h3 className="mt-3 text-2xl font-extrabold leading-tight text-brand-ink sm:text-3xl">Escolha por onde começar.</h3>
              </div>
              <p className="max-w-md text-[15px] leading-relaxed text-brand-graphite">
                Cada frente reúne os módulos que trabalham juntos. Abra a frente para ver os detalhes ou vá direto ao módulo.
              </p>
            </div>
          </Reveal>
          <CategoryCards className="mt-8" />
        </div>

        <Reveal delay={0.15} className="mt-12 flex flex-wrap gap-3 lg:mt-14">
          <Button asChild size="lg">
            <Link to={paths.modules}>
              Ver os {count} módulos
              <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
            </Link>
          </Button>
          <Button asChild size="lg" variant="secondary">
            <Link to={paths.portals}>Portais e autoatendimento</Link>
          </Button>
        </Reveal>
      </div>
    </Section>
  )
}
