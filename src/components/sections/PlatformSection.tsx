import { m } from 'motion/react'
import { Database, LayoutPanelTop, UserRound } from 'lucide-react'
import { Section, SectionHeader } from './Section'
import { Stagger, StaggerItem } from '@/components/motion/Reveal'
import { BrandGradient } from '@/components/brand/Logo'
import { useBrandGradientId } from '@/hooks/useBrandGradientId'
import { MODULES, SYMBOL_BOX } from '@/components/brand/logo-paths'
import { EASE, viewportOnce } from '@/lib/motion'

const pillars = [
  {
    icon: UserRound,
    title: 'Um cadastro',
    text: 'O colaborador entra uma vez, na admissão digital, e já existe na folha, no ponto, nos benefícios e no SESMT.',
  },
  {
    icon: Database,
    title: 'Uma base',
    text: 'O mesmo dado em todos os módulos. People Analytics cruza folha, frequência, saúde e talentos sem exportar nada.',
  },
  {
    icon: LayoutPanelTop,
    title: 'Uma experiência',
    text: 'Portais por perfil, no celular ou no computador, com a mesma linguagem para gestor, colaborador e candidato.',
  },
]

const areas = ['Departamento Pessoal', 'Recursos Humanos', 'Medicina e Segurança do Trabalho', 'NATI · inteligência artificial']

/* Direção de entrada de cada módulo (topo, direita, esquerda, base) na grade a 45°. */
const offsets = [
  { x: 0, y: -2.2 },
  { x: 2.2, y: 0 },
  { x: -2.2, y: 0 },
  { x: 0, y: 2.2 },
]

export function PlatformSection() {
  const gradId = useBrandGradientId()
  return (
    <Section id="plataforma" tone="off" aria-labelledby="plataforma-title">
      <div className="container grid items-center gap-14 lg:grid-cols-2 lg:gap-20">
        <div>
          <SectionHeader
            id="plataforma-title"
            eyebrow="A plataforma"
            title="Um sistema. Uma base. [[Uma experiência.]]"
            lead="Departamento Pessoal, Recursos Humanos e Medicina e Segurança do Trabalho operando no mesmo sistema, com a NATI dentro de tudo. Não é integração entre produtos: é um produto só."
          />
          <Stagger className="mt-10 space-y-6" delay={0.2}>
            {pillars.map(({ icon: Icon, title, text }) => (
              <StaggerItem key={title} className="flex gap-4">
                <span className="mt-0.5 inline-flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-white text-brand-purple shadow-soft">
                  <Icon className="h-5 w-5" strokeWidth={1.6} />
                </span>
                <div>
                  <h3 className="text-lg font-bold text-brand-ink">{title}</h3>
                  <p className="mt-1 text-[15px] leading-relaxed text-brand-graphite">{text}</p>
                </div>
              </StaggerItem>
            ))}
          </Stagger>
        </div>

        <div className="relative mx-auto w-full max-w-[520px]">
          <m.div
            aria-hidden
            className="absolute inset-[12%] rounded-full bg-[radial-gradient(circle,rgba(154,64,138,0.22),transparent_65%)] blur-2xl"
            animate={{ scale: [1, 1.08, 1] }}
            transition={{ duration: 7, repeat: Infinity, ease: 'easeInOut' }}
          />
          <m.svg
            viewBox={`0 0 ${SYMBOL_BOX} ${SYMBOL_BOX}`}
            className="relative mx-auto w-[62%]"
            role="img"
            aria-label="Símbolo Natcorp: quatro módulos que juntos formam um único sistema"
            initial="hidden"
            whileInView="visible"
            viewport={viewportOnce}
          >
            <defs>
              <BrandGradient id={gradId} />
            </defs>
            {MODULES.map((d, i) => (
              <m.path
                key={i}
                d={d}
                fill={`url(#${gradId})`}
                variants={{
                  hidden: { opacity: 0, x: offsets[i].x, y: offsets[i].y },
                  visible: { opacity: 1, x: 0, y: 0, transition: { duration: 1.1, ease: EASE, delay: 0.15 + i * 0.1 } },
                }}
              />
            ))}
          </m.svg>

          <ul className="mt-8 flex flex-wrap justify-center gap-2" aria-label="Áreas atendidas">
            {areas.map((a, i) => (
              <m.li
                key={a}
                className="rounded-full border border-brand-mist bg-white px-3.5 py-1.5 text-[13px] font-semibold text-brand-ink shadow-soft"
                initial={{ opacity: 0, y: 10 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={viewportOnce}
                transition={{ duration: 0.6, ease: EASE, delay: 0.6 + i * 0.08 }}
              >
                {a}
              </m.li>
            ))}
          </ul>
          <p className="mt-4 text-center text-sm text-brand-graphite">
            Módulos distintos que, juntos, formam um único sistema.
          </p>
        </div>
      </div>
    </Section>
  )
}
