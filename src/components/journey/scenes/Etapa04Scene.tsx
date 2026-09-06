import { m, type MotionValue } from 'motion/react'
import { Send } from 'lucide-react'
import { SceneStage, type StageContext } from './SceneStage'
import { useScenePhases } from './hooks'
import { ActionButton, Backdrop, Caption, EventStack, Field, Figure, Ping, Room, UiCard } from './parts'

/**
 * Etapa 4, "Ana se candidata do sofá": à noite, na sala de casa, Ana cria o cadastro pelo celular no
 * Portal do Candidato e se inscreve no processo. Sala em SVG (janela com o céu da noite, abajur aceso,
 * sofá e estante, com paralaxe), a figura 3D da Ana e o card do portal preenchendo campo a campo, com o
 * que o sistema faz depois do envio chegando em pilha.
 */
export function Etapa04Scene() {
  return (
    <SceneStage label="Ana Ribeiro, à noite, na sala de casa em Sorocaba, de pé ao lado do sofá e olhando o celular: ela se candidata à vaga de Supervisora de Produção da Vale Verde pelo Portal do Candidato, com dados pessoais, formação e cursos, histórico profissional e o aceite dos termos de tratamento de dados. A candidatura é enviada em doze minutos e o currículo entra no processo seletivo, no GED e no banco de talentos.">
      {(ctx) => <Composition {...ctx} />}
    </SceneStage>
  )
}

/* Fases: 0 nada, 1 card do portal, 2 dados e formação, 3 histórico e termos, 4 enviada, 5 inscrição, 6 GED, 7 banco de talentos. */
const PHASES = [0, 450, 1200, 1850, 2500, 3200, 3800, 4400]

const afterSend = [
  { phase: 5, initials: 'RS', name: 'Recrutamento e Seleção', role: 'Inscrição no processo', text: 'Ana entra no processo seletivo da vaga, com o currículo estruturado.' },
  { phase: 6, initials: 'GED', name: 'GED', role: 'Currículo e anexos guardados', text: 'Anexos vinculados ao cadastro e termos de aceite versionados.' },
  { phase: 7, initials: 'BT', name: 'Banco de talentos', role: 'Esta e as próximas vagas', text: 'O currículo fica disponível para as próximas seleções da Vale Verde.', tone: 'pink' as const },
]

function Composition({ reduced, on, far, mid, near }: StageContext) {
  const phase = useScenePhases(on, reduced, PHASES)
  const sent = phase >= 4
  return (
    <>
      <LivingRoom far={far} mid={mid} reduced={reduced} />
      <Figure who="ana" x={44} y={58} height={470} on={on} reduced={reduced} near={near} />
      <Ping x={160} y={180} active={phase === 4} reduced={reduced} />
      <UiCard x={330} y={54} width={292} product="Portal do Candidato" tag="Inscrição" on={on} reduced={reduced}>
        <p className="mt-2.5 text-[15px] font-extrabold leading-snug text-brand-ink">Supervisora de Produção</p>
        <p className="text-[11.5px] font-semibold text-brand-graphite">Vale Verde Alimentos · Sorocaba</p>
        <div className="mt-3 space-y-2">
          <Field label="Dados pessoais" value="Ana Ribeiro · pelo celular" tone={phase >= 2 ? 'ok' : 'default'} />
          <Field label="Formação e cursos" value="Técnico em Alimentos" tone={phase >= 2 ? 'ok' : 'default'} />
          <Field label="Histórico e soft skills" value="4 anos em linha de produção" tone={phase >= 3 ? 'ok' : 'default'} />
          <Field label="Termos de dados · LGPD" value="Aceite digital, com versionamento" tone={phase >= 3 ? 'ok' : 'default'} />
        </div>
        <ActionButton done={sent} idleLabel="Enviar candidatura" doneLabel="Candidatura enviada" icon={Send} className="mt-3" />
        <p className="mt-2 text-center text-[10.5px] font-semibold text-brand-graphite">{sent ? 'Em doze minutos, está dentro.' : 'Cadastro pelo celular · currículo estruturado'}</p>
      </UiCard>
      <EventStack x={684} y={184} width={252} title="Depois do envio" items={afterSend} shown={phase} reduced={reduced} />
      <Caption when="Dia 3 · Qua 09/09 · 21:15" where="Em casa · Sorocaba" />
    </>
  )
}

/* ------------------------------------------------------------------------------------------------
 * Cenário: a sala de casa à noite, em duas profundidades.
 * ---------------------------------------------------------------------------------------------- */

const STARS = [
  [196, 70, 1.6],
  [214, 96, 1.1],
  [236, 64, 1.3],
  [252, 108, 1],
  [270, 76, 1.5],
  [288, 118, 1.1],
  [318, 66, 1.2],
  [326, 100, 1.5],
  [206, 130, 1],
  [300, 138, 1.1],
] as const

const BOOKS = [
  [726, 20, '#511C76'],
  [738, 16, '#C95788'],
  [752, 22, '#9A408A'],
  [770, 14, '#E4A9C4'],
  [786, 18, '#4A4460'],
  [806, 12, '#C95788'],
  [820, 20, '#511C76'],
] as const

function LivingRoom({ far, mid, reduced }: { far: MotionValue<number>; mid: MotionValue<number>; reduced: boolean }) {
  return (
    <Backdrop>
      <defs>
        <linearGradient id="e04-sky" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#1B1238" />
          <stop offset="1" stopColor="#3B2A70" />
        </linearGradient>
        <linearGradient id="e04-night" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#1B1238" stopOpacity="0.18" />
          <stop offset="1" stopColor="#1B1238" stopOpacity="0" />
        </linearGradient>
        <radialGradient id="e04-lamp" cx="0.5" cy="0.5" r="0.5">
          <stop offset="0" stopColor="#F9D28C" stopOpacity="0.6" />
          <stop offset="0.45" stopColor="#F4BE6E" stopOpacity="0.2" />
          <stop offset="1" stopColor="#F4BE6E" stopOpacity="0" />
        </radialGradient>
        <radialGradient id="e04-phone" cx="0.5" cy="0.5" r="0.5">
          <stop offset="0" stopColor="#E4A9C4" stopOpacity="0.5" />
          <stop offset="1" stopColor="#E4A9C4" stopOpacity="0" />
        </radialGradient>
        <linearGradient id="e04-shade" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#FBEBD0" />
          <stop offset="1" stopColor="#EFCB98" />
        </linearGradient>
        <linearGradient id="e04-sofa" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor="#BDB2CE" />
          <stop offset="1" stopColor="#A196B8" />
        </linearGradient>
      </defs>
      <Room wall={['#EDE6F3', '#D9D0E6']} floor={['#D7CFE3', '#E9E5F1']} />
      <rect width="960" height="220" fill="url(#e04-night)" />

      {/* fundo: a janela com a noite, as cortinas e a estante (paralaxe lenta) */}
      <m.g style={{ x: far }}>
        <rect x="170" y="46" width="172" height="156" rx="10" fill="#F4F2F7" stroke="#CFC6DC" />
        <rect x="178" y="54" width="156" height="140" rx="6" fill="url(#e04-sky)" />
        {STARS.map(([cx, cy, r]) => (
          <circle key={`${cx}-${cy}`} cx={cx} cy={cy} r={r} fill="#FFFFFF" fillOpacity="0.85" />
        ))}
        <circle cx="300" cy="86" r="11" fill="#F4F2F7" fillOpacity="0.95" />
        <circle cx="306" cy="82" r="10" fill="url(#e04-sky)" />
        {[
          [184, 26],
          [210, 18],
          [232, 34],
          [266, 22],
          [290, 30],
          [320, 16],
        ].map(([x, h]) => (
          <rect key={x} x={x} y={194 - h} width="16" height={h} rx="1" fill="#2C1A63" />
        ))}
        {[
          [190, 178],
          [238, 170],
          [244, 184],
          [296, 176],
        ].map(([x, y]) => (
          <rect key={`${x}-${y}`} x={x} y={y} width="3" height="3" fill="#F9D28C" fillOpacity="0.9" />
        ))}
        <line x1="256" y1="54" x2="256" y2="194" stroke="#F4F2F7" strokeWidth="4" strokeOpacity="0.9" />
        <line x1="178" y1="124" x2="334" y2="124" stroke="#F4F2F7" strokeWidth="4" strokeOpacity="0.9" />
        <rect x="142" y="36" width="32" height="200" rx="9" fill="#C9BAD9" />
        <rect x="338" y="36" width="32" height="200" rx="9" fill="#C9BAD9" />
        <rect x="136" y="30" width="240" height="8" rx="4" fill="#B4A8C7" />

        {/* a estante na parede da direita: livros, uma caneca e um vaso pequeno */}
        <rect x="700" y="96" width="236" height="8" rx="3" fill="#B4A8C7" />
        <rect x="712" y="104" width="10" height="10" rx="2" fill="#A196B8" />
        <rect x="914" y="104" width="10" height="10" rx="2" fill="#A196B8" />
        {BOOKS.map(([x, w, fill]) => (
          <rect key={x} x={x} y={96 - 32 - (w % 3) * 2} width={w} height={32 + (w % 3) * 2} rx="2" fill={fill} />
        ))}
        <rect x="852" y="78" width="18" height="18" rx="3" fill="#F4F2F7" stroke="#C9BFD9" />
        <path d="M870 83 a5 5 0 0 1 0 9" fill="none" stroke="#C9BFD9" strokeWidth="2" />
        <rect x="890" y="80" width="22" height="16" rx="4" fill="#C95788" fillOpacity="0.8" />
        <ellipse cx="895" cy="70" rx="9" ry="5" fill="#6FAE81" transform="rotate(-35 895 70)" />
        <ellipse cx="907" cy="68" rx="9" ry="5" fill="#5E9E74" transform="rotate(30 907 68)" />
        <ellipse cx="901" cy="62" rx="4" ry="8" fill="#6FAE81" />
        <rect x="760" y="22" width="64" height="48" rx="5" fill="#F4F2F7" stroke="#C9BFD9" />
        <rect x="768" y="30" width="48" height="32" rx="3" fill="#E4A9C4" fillOpacity="0.7" />
        <circle cx="792" cy="44" r="8" fill="#9A408A" fillOpacity="0.7" />
      </m.g>

      {/* meio: o abajur aceso, o sofá com as almofadas, o tapete e a planta (paralaxe média) */}
      <m.g style={{ x: mid }}>
        <m.circle cx="300" cy="128" r="170" fill="url(#e04-lamp)" animate={reduced ? undefined : { opacity: [0.85, 1, 0.85] }} transition={{ duration: 3.6, ease: 'easeInOut', repeat: Infinity }} />
        <circle cx="160" cy="184" r="70" fill="url(#e04-phone)" />
        <polygon points="266,98 334,98 346,150 254,150" fill="url(#e04-shade)" stroke="#D9B98A" />
        <rect x="297" y="150" width="6" height="212" rx="3" fill="#4A4460" />
        <ellipse cx="300" cy="362" rx="26" ry="7" fill="#4A4460" />

        <ellipse cx="350" cy="404" rx="190" ry="10" fill="#1B1238" fillOpacity="0.08" />
        <rect x="196" y="262" width="300" height="84" rx="18" fill="#A99DBE" />
        <rect x="214" y="276" width="66" height="52" rx="12" fill="#E4A9C4" fillOpacity="0.9" />
        <rect x="290" y="276" width="66" height="52" rx="12" fill="#C9BAD9" />
        <rect x="366" y="276" width="66" height="52" rx="12" fill="#E4A9C4" fillOpacity="0.9" />
        <rect x="196" y="326" width="300" height="40" rx="12" fill="url(#e04-sofa)" />
        <rect x="196" y="360" width="300" height="22" rx="6" fill="#8F82A8" />
        <rect x="184" y="296" width="34" height="86" rx="14" fill="#B4A8C7" />
        <rect x="474" y="296" width="34" height="86" rx="14" fill="#B4A8C7" />
        <rect x="206" y="382" width="12" height="16" rx="3" fill="#4A4460" />
        <rect x="474" y="382" width="12" height="16" rx="3" fill="#4A4460" />

        <rect x="170" y="410" width="470" height="54" rx="27" fill="#E4A9C4" fillOpacity="0.22" />
        <rect x="186" y="422" width="438" height="30" rx="15" fill="none" stroke="#C95788" strokeOpacity="0.2" />

        <g transform="translate(10 0)">
          <rect x="632" y="346" width="48" height="10" rx="4" fill="#B4A8C7" />
          <rect x="636" y="352" width="40" height="46" rx="8" fill="#9A408A" fillOpacity="0.8" />
          <path d="M656 352 V 272" stroke="#5E9E74" strokeWidth="3" strokeLinecap="round" />
          <ellipse cx="640" cy="296" rx="24" ry="10" fill="#6FAE81" transform="rotate(-32 640 296)" />
          <ellipse cx="672" cy="304" rx="24" ry="10" fill="#5E9E74" transform="rotate(28 672 304)" />
          <ellipse cx="650" cy="266" rx="22" ry="9" fill="#5E9E74" transform="rotate(-70 650 266)" />
          <ellipse cx="668" cy="330" rx="20" ry="9" fill="#6FAE81" transform="rotate(20 668 330)" />
          <ellipse cx="642" cy="330" rx="20" ry="9" fill="#5E9E74" transform="rotate(-20 642 330)" />
        </g>
      </m.g>
    </Backdrop>
  )
}
