import { m, type MotionValue } from 'motion/react'
import { Archive, BadgeCheck, PackageCheck, PenLine, ShieldCheck } from 'lucide-react'
import { SceneStage, type StageContext } from './SceneStage'
import { useScenePhases, useSteel } from './hooks'
import { ActionButton, Backdrop, Caption, EventStack, Field, Figure, Ping, Room, SafetyStripe, Sign, UiCard, type SceneEvent } from './parts'

/**
 * Etapa 17, "Os EPIs certos já estavam separados": no almoxarifado de EPIs, Rafael entrega à Ana os itens
 * que o sistema definiu pelo cargo e pelo local de trabalho. Cenário do almoxarifado em SVG (prateleiras com
 * capacetes, luvas e óculos, o balcão em inox com o kit separado), as figuras 3D do Rafael e da Ana e a
 * ficha de EPI com os CAs validados e a assinatura na tela.
 */
export function Etapa17Scene() {
  return (
    <SceneStage label="No almoxarifado de EPIs, Rafael Duarte entrega a Ana Ribeiro os itens que o sistema já tinha separado pelo cargo e pelo local de trabalho: protetor auricular, óculos de proteção, botina antiderrapante e touca, cada um com o CA validado. Ana assina a ficha de EPI na tela e a ficha vai para o GED.">
      {(ctx) => <Composition {...ctx} />}
    </SceneStage>
  )
}

/* Fases: 0 nada, 1 ficha, 2 EPIs definidos pela vaga, 3 estoque reservado, 4 CAs validados, 5 ficha assinada, 6 GED. */
const PHASES = [0, 500, 1300, 2000, 2700, 3500, 4300]

const events: SceneEvent[] = [
  { phase: 2, icon: ShieldCheck, name: 'EPIs definidos pela vaga', role: 'Segurança do Trabalho', text: 'Cargo, setor e local de trabalho, a partir do PGR e do GHE.' },
  { phase: 3, icon: PackageCheck, name: 'Estoque reservado', role: 'SESMT', text: 'Estoque planejado pelo SESMT.' },
  { phase: 4, icon: BadgeCheck, name: 'CA validado', role: 'Base do governo', text: 'CA conferido automaticamente.', tone: 'green' },
  { phase: 6, icon: Archive, name: 'Ficha no GED', role: 'NatDocs · GED', text: 'Assinada na tela, com auditoria.', tone: 'pink' },
]

/* Os EPIs do cargo e a fase em que o CA de cada um aparece conferido. */
const EPIS = [
  { item: 'Protetor auricular', phase: 3 },
  { item: 'Óculos de proteção', phase: 3 },
  { item: 'Botina antiderrapante', phase: 4 },
  { item: 'Touca', phase: 4 },
]

function Composition({ reduced, on, far, mid, near }: StageContext) {
  const phase = useScenePhases(on, reduced, PHASES)
  return (
    <>
      <Storeroom far={far} mid={mid} />
      <Figure who="rafael" x={6} y={72} height={456} on={on} reduced={reduced} near={near} />
      <Figure who="ana" x={520} y={108} height={420} flip from="right" delay={0.3} on={on} reduced={reduced} near={near} />
      <UiCard x={270} y={52} width={244} product="Segurança do Trabalho" on={on} reduced={reduced}>
        <div className="mt-2.5 flex items-center justify-between gap-2">
          <p className="text-[15px] font-extrabold leading-snug text-brand-ink">Ficha de EPI</p>
          <span className="whitespace-nowrap rounded-full bg-brand-off-white px-2 py-0.5 text-[9.5px] font-semibold text-brand-graphite">Ana Ribeiro</span>
        </div>
        <p className="mt-0.5 text-[10.5px] font-semibold text-brand-graphite">Supervisora de Produção · Linha 2</p>
        <div className="mt-3 space-y-2">
          {EPIS.map((epi) => (
            <Field key={epi.item} label={epi.item} value={phase >= epi.phase ? 'CA validado' : 'Conferindo CA'} tone={phase >= epi.phase ? 'ok' : 'default'} />
          ))}
        </div>
        <ActionButton done={phase >= 5} idleLabel="Assinar na tela" doneLabel="Ficha assinada" icon={PenLine} className="mt-3" />
      </UiCard>
      <Ping x={392} y={388} active={phase === 5} reduced={reduced} />
      <EventStack x={680} y={96} width={256} title="Antes da admissão" items={events} shown={phase} reduced={reduced} />
      <Caption when="Dia 22 · Seg 28/09 · 07:30" where="Almoxarifado de EPIs · Vale Verde Alimentos" />
    </>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Cenário: o almoxarifado de EPIs, com as prateleiras e o balcão em inox.
 * ---------------------------------------------------------------------------------------------- */

type ShelfItem = { kind: 'helmet' | 'box' | 'goggles' | 'gloves' | 'boots' | 'earmuff'; x: number; color?: string }

/* Prateleira alta, o comprimento todo: capacetes, caixas e óculos. */
const TOP_SHELF: ShelfItem[] = [
  { kind: 'helmet', x: 20, color: '#FFFFFF' },
  { kind: 'helmet', x: 76, color: '#FFFFFF' },
  { kind: 'helmet', x: 132, color: '#F0B27A' },
  { kind: 'box', x: 196 },
  { kind: 'box', x: 240 },
  { kind: 'goggles', x: 296 },
  { kind: 'helmet', x: 352, color: '#FFFFFF' },
  { kind: 'helmet', x: 408, color: '#F0B27A' },
  { kind: 'earmuff', x: 470 },
  { kind: 'box', x: 520 },
  { kind: 'gloves', x: 570 },
  { kind: 'helmet', x: 616, color: '#FFFFFF' },
  { kind: 'goggles', x: 674 },
]

/* Estantes do fundo, em três alturas: luvas, botinas, caixas e óculos. */
const BACK_SHELVES: { y: number; items: ShelfItem[] }[] = [
  {
    y: 150,
    items: [
      { kind: 'gloves', x: 24 },
      { kind: 'box', x: 70 },
      { kind: 'boots', x: 236 },
      { kind: 'goggles', x: 296 },
      { kind: 'gloves', x: 560 },
      { kind: 'box', x: 610 },
      { kind: 'earmuff', x: 650 },
      { kind: 'box', x: 900 },
    ],
  },
  {
    y: 230,
    items: [
      { kind: 'boots', x: 20 },
      { kind: 'earmuff', x: 76 },
      { kind: 'box', x: 236 },
      { kind: 'gloves', x: 560 },
      { kind: 'boots', x: 646 },
      { kind: 'gloves', x: 900 },
    ],
  },
  {
    y: 310,
    items: [
      { kind: 'box', x: 20 },
      { kind: 'box', x: 64 },
      { kind: 'boots', x: 236 },
      { kind: 'box', x: 560 },
      { kind: 'goggles', x: 646 },
      { kind: 'boots', x: 900 },
    ],
  },
]

/** Um item de EPI desenhado com formas simples, apoiado na prateleira `y`. */
function Item({ kind, x, y, color = '#FFFFFF' }: ShelfItem & { y: number }) {
  switch (kind) {
    case 'helmet':
      return (
        <g>
          <path d={`M${x} ${y - 4} a20 22 0 0 1 40 0 z`} fill={color} stroke="#B9B1C8" />
          <rect x={x - 4} y={y - 6} width="48" height="6" rx="3" fill={color} stroke="#B9B1C8" />
        </g>
      )
    case 'box':
      return (
        <g>
          <rect x={x} y={y - 28} width="36" height="28" rx="3" fill="#F1E9F5" stroke="#D7C7E3" />
          <rect x={x + 6} y={y - 20} width="24" height="6" rx="2" fill="#C95788" />
          <rect x={x + 6} y={y - 11} width="16" height="3" rx="1.5" fill="#D7C7E3" />
        </g>
      )
    case 'goggles':
      return (
        <g>
          <path d={`M${x + 2} ${y - 12} q18 -14 36 0`} fill="none" stroke="#4A4460" strokeWidth="2" />
          <ellipse cx={x + 10} cy={y - 8} rx="10" ry="7" fill="#FFFFFF" fillOpacity="0.85" stroke="#9A408A" strokeWidth="1.5" />
          <ellipse cx={x + 30} cy={y - 8} rx="10" ry="7" fill="#FFFFFF" fillOpacity="0.85" stroke="#9A408A" strokeWidth="1.5" />
        </g>
      )
    case 'gloves':
      return (
        <g>
          <rect x={x} y={y - 24} width="15" height="24" rx="5" fill="#E4A9C4" stroke="#C95788" />
          <rect x={x + 19} y={y - 24} width="15" height="24" rx="5" fill="#E4A9C4" stroke="#C95788" />
          <rect x={x - 3} y={y - 14} width="6" height="9" rx="3" fill="#E4A9C4" stroke="#C95788" />
          <rect x={x + 31} y={y - 14} width="6" height="9" rx="3" fill="#E4A9C4" stroke="#C95788" />
        </g>
      )
    case 'boots':
      return (
        <g>
          <path d={`M${x} ${y - 22} h14 v10 h10 a6 6 0 0 1 6 6 v6 h-30 z`} fill="#4A4460" />
          <path d={`M${x + 34} ${y - 22} h14 v10 h10 a6 6 0 0 1 6 6 v6 h-30 z`} fill="#4A4460" />
          <rect x={x} y={y - 4} width="30" height="4" rx="1" fill="#1B1238" />
          <rect x={x + 34} y={y - 4} width="30" height="4" rx="1" fill="#1B1238" />
        </g>
      )
    case 'earmuff':
      return (
        <g>
          <path d={`M${x + 4} ${y - 4} a14 16 0 0 1 28 0`} fill="none" stroke="#4A4460" strokeWidth="3" />
          <circle cx={x + 4} cy={y - 6} r="6" fill="#C95788" />
          <circle cx={x + 32} cy={y - 6} r="6" fill="#C95788" />
        </g>
      )
  }
}

function Storeroom({ far, mid }: { far: MotionValue<number>; mid: MotionValue<number> }) {
  const steel = useSteel()
  return (
    <Backdrop>
      {steel.defs}
      <Room wall={['#F4F1F8', '#E4E0EC']} />

      {/* fundo: a prateleira alta, as estantes e a placa do almoxarifado */}
      <m.g style={{ x: far }}>
        <rect x="0" y="52" width="704" height="7" rx="2" fill="#B9B1C8" />
        {[40, 220, 400, 580].map((x) => (
          <polygon key={x} points={`${x},59 ${x + 14},59 ${x},76`} fill="#A89FBA" />
        ))}
        {TOP_SHELF.map((it) => (
          <Item key={`top-${it.x}`} {...it} y={52} />
        ))}

        {[236, 556, 896].map((x) => (
          <g key={x}>
            <rect x={x - 12} y="96" width="8" height="240" rx="2" fill="#C7C0D5" />
            <rect x={x + 116} y="96" width="8" height="240" rx="2" fill="#C7C0D5" />
          </g>
        ))}
        {[10, 640].map((x) => (
          <rect key={x} x={x} y="96" width="8" height="240" rx="2" fill="#C7C0D5" />
        ))}
        {BACK_SHELVES.map((row) => (
          <g key={row.y}>
            <rect x="0" y={row.y} width="960" height="6" rx="2" fill="#CFC8DB" />
            {row.items.map((it) => (
              <Item key={`${row.y}-${it.x}`} {...it} y={row.y} />
            ))}
          </g>
        ))}

        <Sign x={740} y={14} title="EPI" subtitle="ALMOXARIFADO" />
      </m.g>

      {/* meio: o balcão em inox com o kit da Ana já separado */}
      <m.g style={{ x: mid }}>
        <ellipse cx="400" cy="478" rx="190" ry="8" fill="#1B1238" fillOpacity="0.08" />
        <rect x="236" y="430" width="330" height="42" rx="6" fill="#B3ABC4" />
        <rect x="236" y="470" width="330" height="4" fill="#9C93AE" />
        <rect x="230" y="418" width="342" height="14" rx="5" fill={steel.fill} stroke="#A89FBA" />

        <g>
          <rect x="300" y="396" width="176" height="24" rx="5" fill="#F1E9F5" stroke="#D7C7E3" />
          <path d="M308 402 h10 v6 h6 a4 4 0 0 1 4 4 v4 h-20 z" fill="#4A4460" />
          <path d="M332 402 h10 v6 h6 a4 4 0 0 1 4 4 v4 h-20 z" fill="#4A4460" />
          <ellipse cx="376" cy="410" rx="8" ry="5.5" fill="#FFFFFF" fillOpacity="0.9" stroke="#9A408A" strokeWidth="1.5" />
          <ellipse cx="394" cy="410" rx="8" ry="5.5" fill="#FFFFFF" fillOpacity="0.9" stroke="#9A408A" strokeWidth="1.5" />
          <path d="M414 414 q6 -10 12 0 q6 -10 12 0" fill="none" stroke="#C95788" strokeWidth="1.5" />
          <circle cx="414" cy="410" r="3.5" fill="#C95788" />
          <circle cx="438" cy="410" r="3.5" fill="#C95788" />
          <ellipse cx="460" cy="410" rx="12" ry="7" fill="#FFFFFF" stroke="#D7C7E3" />
          <rect x="446" y="410" width="28" height="4" rx="2" fill="#E9E5F1" stroke="#D7C7E3" />
        </g>
        <g>
          <rect x="248" y="438" width="86" height="18" rx="4" fill="#FFFFFF" stroke="#C95788" />
          <text x="291" y="450.5" textAnchor="middle" fontFamily="Manrope, sans-serif" fontWeight="800" fontSize="9.5" fill="#511C76" letterSpacing="0.8">
            ANA RIBEIRO
          </text>
        </g>
      </m.g>

      <SafetyStripe y={482} />
    </Backdrop>
  )
}
