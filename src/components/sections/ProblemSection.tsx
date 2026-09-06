import { useEffect, useRef, useState } from 'react'
import { AnimatePresence, m, useInView, useReducedMotion } from 'motion/react'
import { ArrowRight, FileSpreadsheet, Hourglass, Unplug } from 'lucide-react'
import { Link } from 'react-router'
import { Section, Eyebrow } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { Logo } from '@/components/brand/Logo'
import { paths } from '@/content/site'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

/**
 * O problema, com personalidade de afirmação: uma pergunta grande em fundo escuro,
 * três sintomas do RH sem a Natcorp e um objeto de antes e depois que troca de cena.
 */

const pains = [
  {
    icon: Unplug,
    title: 'Vários sistemas, nenhum integrado.',
    text: 'Folha em um, ponto em outro, recrutamento em um terceiro. Cada um faz a sua parte e nenhum conversa com o outro. O mesmo dado é digitado três vezes e a divergência aparece depois de pagar.',
  },
  {
    icon: FileSpreadsheet,
    title: 'Planilha para tudo o que o sistema não entrega.',
    text: 'Turnover, headcount, custo por centro de custo. O sistema atual não gera o relatório, então o RH exporta, cola e mantém uma planilha paralela para responder à diretoria.',
  },
  {
    icon: Hourglass,
    title: 'Horas de trabalho manual, todo mês.',
    text: 'Sem automação nem processos inteligentes, os analistas conferem, redigitam e cobram pendências por e-mail. O tempo que devia ir para as pessoas vai para o operacional.',
  },
]

/* Cena "hoje": quatro lugares, quatro versões da mesma informação. */
const today = [
  { title: 'Sistema de ponto', ext: 'ponto.exe', badge: 'Exporta, importa, confere' },
  { title: 'Sistema de folha', ext: 'folha.exe', badge: 'Horas redigitadas à mão' },
  { title: 'Planilha de indicadores', ext: 'turnover_v7.xlsx', badge: '7 versões da mesma planilha' },
  { title: 'E-mail do RH', ext: 'caixa de entrada', badge: '42 pendências cobradas à mão' },
]

/* Resultados observados na operação de clientes (material comercial Natcorp, "Produtividade de RH"). */
const gains = [
  { label: 'Fechamento da folha', natcorp: 20, note: 'até 80% mais rápido' },
  { label: 'Tratamento do ponto', natcorp: 25, note: '75% menos tempo' },
  { label: 'Dúvidas de colaboradores', natcorp: 30, note: '70% menos chamados' },
  { label: 'Gestão de benefícios', natcorp: 35, note: '65% mais eficiente' },
]

type Scene = 'hoje' | 'natcorp'

export function ProblemSection() {
  const ref = useRef<HTMLDivElement>(null)
  const inView = useInView(ref, { once: true, margin: '0px 0px -30% 0px' })
  const reduced = useReducedMotion()
  const [scene, setScene] = useState<Scene>('hoje')
  const [touched, setTouched] = useState(false)

  // Uma revelação só: mostra o "hoje", espera, e troca para "com a Natcorp".
  useEffect(() => {
    if (!inView || touched || reduced) return
    const t = window.setTimeout(() => setScene('natcorp'), 2800)
    return () => window.clearTimeout(t)
  }, [inView, touched, reduced])

  const pick = (s: Scene) => {
    setTouched(true)
    setScene(s)
  }

  return (
    <Section id="desafio" tone="dark" className="overflow-hidden bg-brand-ink" aria-labelledby="desafio-title">
      <div className="pointer-events-none absolute inset-0" aria-hidden>
        <div className="absolute inset-0 bg-[radial-gradient(55%_60%_at_10%_20%,rgba(201,87,136,0.22),transparent_65%)]" />
        <div className="absolute inset-0 bg-[radial-gradient(45%_50%_at_90%_85%,rgba(81,28,118,0.55),transparent_70%)]" />
      </div>

      <div ref={ref} className="container relative grid grid-cols-1 items-center gap-12 lg:grid-cols-[1.05fr_1fr] lg:gap-16">
        <div>
          <Reveal y={12} duration={0.5}>
            <Eyebrow tone="white">O custo do RH operacional</Eyebrow>
          </Reveal>
          <Reveal delay={0.08}>
            <h2 id="desafio-title" className="mt-5 text-[2.4rem] font-extrabold leading-[1.02] tracking-brand sm:text-5xl lg:text-[3.6rem]">
              Quanto do tempo do seu RH ainda vai para o que <span className="text-[#E4A9C4]">não é estratégico</span>?
            </h2>
          </Reveal>
          <Stagger className="mt-10 space-y-6" delay={0.2} stagger={0.12}>
            {pains.map(({ icon: Icon, title, text }) => (
              <StaggerItem key={title} className="flex gap-4">
                <span className="mt-1 flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-white/10 text-[#E4A9C4]">
                  <Icon className="h-4.5 w-4.5" strokeWidth={1.8} aria-hidden />
                </span>
                <p className="text-[16px] leading-relaxed text-white/75">
                  <strong className="font-bold text-white">{title}</strong> {text}
                </p>
              </StaggerItem>
            ))}
          </Stagger>
          <Reveal delay={0.3} className="mt-8">
            <Link to={paths.structures} className="group inline-flex items-center gap-2 text-[15px] font-semibold text-white underline-offset-4 hover:underline">
              Veja como um único time de RH opera várias empresas e filiais
              <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
            </Link>
          </Reveal>
        </div>

        <Reveal delay={0.15} className="min-w-0">
          <div role="tablist" aria-label="Antes e depois" className="inline-flex rounded-xl border border-white/15 bg-white/5 p-1">
            {(
              [
                ['hoje', 'Hoje'],
                ['natcorp', 'Com a Natcorp'],
              ] as [Scene, string][]
            ).map(([id, label]) => (
              <button
                key={id}
                role="tab"
                id={`desafio-tab-${id}`}
                aria-selected={scene === id}
                aria-controls="desafio-cena"
                onClick={() => pick(id)}
                className={cn('relative rounded-lg px-4 py-2 text-[13px] font-semibold transition-colors sm:text-sm', scene === id ? 'text-brand-blue' : 'text-white/70 hover:text-white')}
              >
                {scene === id && <m.span layoutId="desafio-tab" className="absolute inset-0 rounded-lg bg-white" transition={{ duration: 0.4, ease: EASE }} aria-hidden />}
                <span className="relative">{label}</span>
              </button>
            ))}
          </div>

          <div id="desafio-cena" role="tabpanel" aria-labelledby={`desafio-tab-${scene}`} className="relative mt-4 min-h-[400px] overflow-hidden rounded-3xl border border-white/12 bg-white/[0.04] p-4 sm:min-h-[420px] sm:p-6">
            <AnimatePresence mode="wait" initial={false}>
              {scene === 'hoje' ? (
                <m.div key="hoje" initial={{ opacity: 0, y: 14 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -10 }} transition={{ duration: 0.45, ease: EASE }}>
                  <TodayScene />
                </m.div>
              ) : (
                <m.div key="natcorp" initial={{ opacity: 0, y: 14 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -10 }} transition={{ duration: 0.45, ease: EASE }}>
                  <NatcorpScene />
                </m.div>
              )}
            </AnimatePresence>
          </div>
          <p className="mt-3 text-xs leading-relaxed text-white/45">
            Resultados observados na operação de clientes Natcorp. Valores máximos; variam conforme o porte e o processo de cada empresa.
          </p>
        </Reveal>
      </div>
    </Section>
  )
}

function TodayScene() {
  return (
    <div className="relative">
      <div className="grid grid-cols-2 gap-3 sm:gap-4">
        {today.map((w, i) => (
          <m.div
            key={w.title}
            className="rounded-xl border border-white/12 bg-brand-blue/70 shadow-soft"
            initial={{ opacity: 0, y: 10, rotate: 0 }}
            animate={{ opacity: 1, y: 0, rotate: i % 2 === 0 ? -1.2 : 1.2 }}
            transition={{ duration: 0.5, ease: EASE, delay: 0.1 + i * 0.1 }}
          >
            <div className="flex items-center gap-1.5 border-b border-white/10 px-3 py-2">
              <span className="h-1.5 w-1.5 rounded-full bg-white/30" />
              <span className="h-1.5 w-1.5 rounded-full bg-white/30" />
              <span className="h-1.5 w-1.5 rounded-full bg-white/30" />
              <span className="ml-2 truncate text-[11px] font-semibold text-white/80">{w.title}</span>
            </div>
            <div className="space-y-2 p-3">
              <p className="truncate text-[10px] text-white/40">{w.ext}</p>
              <span className="block h-1.5 w-[80%] rounded bg-white/10" />
              <span className="block h-1.5 w-[60%] rounded bg-white/10" />
              <span className="block h-1.5 w-[70%] rounded bg-white/10" />
              <span className="mt-1 inline-block rounded-md bg-[#C95788]/25 px-2 py-1 text-[10.5px] font-semibold text-[#F3C9DA]">{w.badge}</span>
            </div>
          </m.div>
        ))}
      </div>
      <svg className="pointer-events-none absolute inset-x-0 top-0 h-[84%] w-full" viewBox="0 0 100 100" preserveAspectRatio="none" aria-hidden>
        <line x1="25" y1="25" x2="75" y2="75" stroke="#E4A9C4" strokeWidth="0.4" strokeDasharray="2 2" opacity="0.6" vectorEffect="non-scaling-stroke" />
        <line x1="75" y1="25" x2="25" y2="75" stroke="#E4A9C4" strokeWidth="0.4" strokeDasharray="2 2" opacity="0.6" vectorEffect="non-scaling-stroke" />
      </svg>
      <p className="mt-4 text-[12.5px] font-semibold leading-relaxed text-white/60">
        Todo mês, dias de conferência manual para descobrir qual versão está certa. E o eSocial esperando.
      </p>
      <m.p
        className="pointer-events-none absolute left-1/2 top-[42%] -translate-x-1/2 -translate-y-1/2 whitespace-nowrap rounded-full border border-[#E4A9C4]/50 bg-brand-ink px-3.5 py-1.5 text-[11.5px] font-bold text-[#F3C9DA] shadow-lift"
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.4, ease: EASE, delay: 0.6 }}
      >
        4 sistemas, 4 versões da verdade
      </m.p>
    </div>
  )
}

function NatcorpScene() {
  return (
    <div className="rounded-xl border border-white/12 bg-brand-blue/70 shadow-soft">
      <div className="flex items-center justify-between border-b border-white/10 px-4 py-2.5">
        <span className="flex items-center gap-2 text-[11px] font-semibold text-white/85">
          <Logo variant="symbol" tone="white" decorative className="h-3.5 w-3.5" />
          Natcorp · Painel do Operador
        </span>
        <span className="text-[10.5px] font-semibold uppercase tracking-[0.12em] text-white/45">Tempo da rotina</span>
      </div>
      <ul className="space-y-5 p-4 sm:p-5">
        {gains.map((g, i) => (
          <li key={g.label}>
            <div className="flex items-baseline justify-between gap-4 text-[13.5px]">
              <span className="font-semibold">{g.label}</span>
              <span className="font-extrabold tabular text-[#E4A9C4]">{g.note}</span>
            </div>
            <div className="mt-2 space-y-1.5">
              <Bar width={100} delay={0.1 + i * 0.1} tone="gray" label="Modelo tradicional" />
              <Bar width={g.natcorp} delay={0.3 + i * 0.1} tone="purple" label="Natcorp" />
            </div>
          </li>
        ))}
      </ul>
      <p className="border-t border-white/10 px-4 py-3 text-[12px] font-semibold text-emerald-300 sm:px-5">Um lugar, uma versão da verdade. O ponto vira folha, a folha vira eSocial.</p>
    </div>
  )
}

function Bar({ width, delay, tone, label }: { width: number; delay: number; tone: 'gray' | 'purple'; label: string }) {
  return (
    <div className="flex items-center gap-3">
      <span className="w-[7.5rem] shrink-0 text-[11px] text-white/55">{label}</span>
      <div className="h-2 flex-1 overflow-hidden rounded-full bg-white/10">
        <m.div
          className={tone === 'purple' ? 'h-full rounded-full bg-gradient-to-r from-brand-plum to-[#E4A9C4]' : 'h-full rounded-full bg-white/30'}
          initial={{ width: 0 }}
          animate={{ width: `${width}%` }}
          transition={{ duration: 1, ease: EASE, delay }}
        />
      </div>
    </div>
  )
}
