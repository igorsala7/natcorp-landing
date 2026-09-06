import { m, type MotionValue } from 'motion/react'
import { Building2, Calculator, ChartColumn, Check, Clock, Send } from 'lucide-react'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { EASE } from '@/lib/motion'
import { cn } from '@/lib/utils'
import { SceneStage, type StageContext } from './SceneStage'
import { useScenePhases } from './hooks'
import { ActionButton, Backdrop, Caption, EventStack, FarBlock, Figure, People, Ping, Room, Sign, UiCard, type SceneEvent } from './parts'

/**
 * Etapa 23, "Enquanto Ana trabalha, o RH fecha 10.000 folhas em 4 minutos": Paulo, no RH da matriz,
 * vê o corte de cada filial, roda a folha por empresa e a NATI confere antes do pagamento.
 * Escritório aberto do RH em SVG, a figura 3D do Paulo e a tela escura da Folha de Pagamento
 * com o cálculo avançando, os números do fechamento e as integrações chegando.
 */
export function Etapa23Scene() {
  return (
    <SceneStage label="Paulo Mendes, analista de folha, no escritório do RH na matriz da Vale Verde Alimentos, com a caneca e o celular na mão. Na tela da Folha de Pagamento, as seis unidades concluem ponto, benefícios e movimentações até a data de corte, a folha dos 10.000 colaboradores é calculada em cerca de 4 minutos e a NATI confere folha, ponto e benefícios antes do pagamento. Em seguida chegam a contabilização por CNPJ para o ERP, o retorno do eSocial e os painéis de Business Intelligence.">
      {(ctx) => <Composition {...ctx} />}
    </SceneStage>
  )
}

/* Fases: 0 nada, 1 tela da folha, 2 ponto fechado, 3 benefícios conferidos e cálculo rodando, 4 cálculo concluído e ERP, 5 NATI confere, 6 folha fechada e eSocial, 7 painéis. */
const PHASES = [0, 500, 1300, 2100, 3000, 3900, 4700, 5500]

const events: SceneEvent[] = [
  { phase: 4, icon: Building2, name: 'Contabilização para o ERP', role: 'Folha por empresa', text: 'Folha rodada por empresa, com a contabilização de cada CNPJ para o ERP.' },
  { phase: 6, icon: Send, name: 'eSocial', role: 'Envio e retorno dos eventos', text: 'Cada evento recebido, com o retorno no mesmo lugar.', tone: 'pink' },
  { phase: 7, icon: ChartColumn, name: 'Business Intelligence', role: 'Painéis da diretoria', text: 'Turnover, absenteísmo e custo por unidade, sem exportar planilha.', tone: 'green' },
]

function Composition({ reduced, on, far, mid, near }: StageContext) {
  const phase = useScenePhases(on, reduced, PHASES)
  const pct = phase >= 4 ? 100 : phase >= 3 ? 45 : 0
  return (
    <>
      <Office far={far} mid={mid} />
      <Figure who="paulo" x={60} y={58} height={470} on={on} reduced={reduced} near={near} />
      <Ping x={222} y={225} active={phase === 3 || phase === 6} reduced={reduced} />
      <UiCard x={322} y={44} width={300} product="Folha de Pagamento" tag="Fechamento" tone="dark" on={on} reduced={reduced}>
        <p className="mt-2.5 text-[15px] font-extrabold leading-snug text-white">Folha por empresa · 6 unidades</p>
        <p className="mt-0.5 text-[10.5px] font-semibold text-white/60">Calendário de fechamento por filial, até a data de corte</p>
        <div className="mt-3 flex flex-wrap gap-1.5">
          <Chip ok={phase >= 2} label={phase >= 2 ? 'Ponto fechado' : 'Ponto'} />
          <Chip ok={phase >= 3} label={phase >= 3 ? 'Benefícios conferidos' : 'Benefícios'} />
          <Chip ok={phase >= 3} label="Movimentações" />
        </div>
        <div className="mt-3">
          <div className="flex items-center justify-between text-[9.5px] font-semibold uppercase tracking-[0.12em] text-white/70">
            <span>Cálculo da folha</span>
            <span className={phase >= 4 ? 'text-emerald-300' : 'text-[#E4A9C4]'}>{phase >= 4 ? 'Pronto · cerca de 4 min' : phase >= 3 ? '2.500 por minuto' : 'Aguardando o corte'}</span>
          </div>
          <div className="mt-1.5 h-2 overflow-hidden rounded-full bg-white/10">
            <m.div
              className="h-full w-full rounded-full bg-gradient-to-r from-brand-plum to-brand-pink"
              initial={reduced ? false : { x: '-100%' }}
              animate={{ x: `${pct - 100}%` }}
              transition={{ duration: 0.9, ease: EASE }}
            />
          </div>
        </div>
        <div className="mt-3 grid grid-cols-3 gap-1.5">
          <Stat value="10.000" label="colaboradores" />
          <Stat value="6" label="unidades" />
          <Stat value="4 min" label="cálculo" />
        </div>
        <m.div
          className="mt-3 flex items-start gap-2 rounded-xl border border-[#E4A9C4]/30 bg-white/5 p-2"
          initial={reduced ? false : { opacity: 0, y: 6 }}
          animate={phase >= 5 ? { opacity: 1, y: 0 } : undefined}
          transition={{ duration: 0.5, ease: EASE }}
        >
          <NatiAvatar ring className="h-8 w-8 shrink-0" />
          <p className="text-[11px] leading-snug text-white/85">
            <span className="font-extrabold text-[#E4A9C4]">NATI</span> conferiu folha, ponto e benefícios: inconsistências apontadas antes do pagamento, em segundos.
          </p>
        </m.div>
        <ActionButton done={phase >= 6} idleLabel="Fechar a folha" doneLabel="Folha fechada" icon={Calculator} className="mt-3" />
      </UiCard>
      <EventStack x={680} y={150} width={256} title="Depois do cálculo" items={events} shown={phase} reduced={reduced} />
      <Caption when="Todo mês · fechamento" where="RH · Matriz Vale Verde Alimentos" />
    </>
  )
}

/** Etapa do corte por filial, dentro da tela escura. */
function Chip({ ok, label }: { ok: boolean; label: string }) {
  return (
    <span
      className={cn(
        'inline-flex items-center gap-1 whitespace-nowrap rounded-full border px-2 py-0.5 text-[10px] font-semibold transition-colors duration-500',
        ok ? 'border-emerald-400/40 bg-emerald-500/20 text-emerald-200' : 'border-white/15 bg-white/5 text-white/70',
      )}
    >
      {ok ? <Check className="h-3 w-3" strokeWidth={3} aria-hidden /> : <Clock className="h-3 w-3" aria-hidden />}
      {label}
    </span>
  )
}

/** Um número grande do fechamento. */
function Stat({ value, label }: { value: string; label: string }) {
  return (
    <div className="rounded-lg border border-white/10 bg-white/5 px-1.5 py-1.5">
      <p className="text-[17px] font-extrabold leading-none tabular-nums text-white">{value}</p>
      <p className="mt-1 truncate text-[9.5px] font-semibold text-white/60">{label}</p>
    </div>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Cenário: o escritório aberto do RH na matriz, com a parede de vidro e as mesas com notebooks.
 * ---------------------------------------------------------------------------------------------- */

function Office({ far, mid }: { far: MotionValue<number>; mid: MotionValue<number> }) {
  return (
    <Backdrop>
      <defs>
        <linearGradient id="e23-glass" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#FFFFFF" stopOpacity="0.75" />
          <stop offset="1" stopColor="#E4DCEC" stopOpacity="0.35" />
        </linearGradient>
      </defs>
      <Room />

      {/* fundo: luminárias, as salas atrás do vidro, a parede de vidro e a placa (paralaxe lenta) */}
      <m.g style={{ x: far }}>
        {[80, 380, 680].map((x) => (
          <rect key={x} x={x} y="18" width="130" height="7" rx="3.5" fill="#FFFFFF" stroke="#DDD8E6" />
        ))}
        <FarBlock x={548} y={196} w={120} h={140} rows={2} />
        <FarBlock x={800} y={186} w={140} h={150} rows={3} />
        <rect x="520" y="40" width="440" height="296" fill="url(#e23-glass)" />
        {[520, 632, 744, 856].map((x) => (
          <rect key={x} x={x - 3} y="40" width="6" height="296" rx="2" fill="#C7C0D5" />
        ))}
        <rect x="514" y="36" width="446" height="7" rx="3.5" fill="#C7C0D5" />
        <rect x="520" y="190" width="440" height="3" fill="#FFFFFF" fillOpacity="0.7" />
        <Sign x={700} y={58} w={220} title="RH · MATRIZ" subtitle="VALE VERDE ALIMENTOS" />
        <FarBlock x={238} y={160} w={100} h={176} rows={4} />
      </m.g>

      {/* meio: colegas do RH sentados às mesas e a fileira da frente com notebooks (paralaxe média) */}
      <m.g style={{ x: mid }}>
        <People spots={[{ x: 424, y: 226, h: 110 }, { x: 684, y: 232, h: 104, w: 44 }, { x: 872, y: 224, h: 112 }]} hair="#3B2E4A" coat="#F1ECF6" />
        {[380, 640, 826].map((x) => (
          <Desk key={x} x={x} y={292} w={136} legs={44} />
        ))}
        {[286, 500, 714].map((x) => (
          <Desk key={x} x={x} y={358} w={172} legs={64} />
        ))}
        <ellipse cx="600" cy="432" rx="330" ry="9" fill="#1B1238" fillOpacity="0.06" />
      </m.g>
    </Backdrop>
  )
}

/** Uma mesa do escritório com um notebook aberto (visto por trás) e uma folha de papel. */
function Desk({ x, y, w, legs }: { x: number; y: number; w: number; legs: number }) {
  const lx = x + w / 2 - 22
  return (
    <g>
      <rect x={lx + 4} y={y - 27} width="36" height="25" rx="3" fill="#1B1238" />
      <circle cx={lx + 22} cy={y - 15} r="2.5" fill="#C95788" />
      <rect x={lx} y={y - 4} width="44" height="5" rx="2" fill="#4A4460" />
      <rect x={x} y={y} width={w} height="9" rx="4" fill="#E6E1EE" stroke="#C9C2D6" />
      <rect x={x + 8} y={y + 9} width="6" height={legs} rx="2" fill="#B9B1C8" />
      <rect x={x + w - 14} y={y + 9} width="6" height={legs} rx="2" fill="#B9B1C8" />
      <rect x={x + 16} y={y - 8} width="20" height="8" rx="2" fill="#FFFFFF" stroke="#D7D0E2" />
    </g>
  )
}
