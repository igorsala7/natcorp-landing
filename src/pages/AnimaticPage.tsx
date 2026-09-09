/**
 * PÁGINA TEMPORÁRIA — animatic do filme institucional de 30s.
 *
 * Existe só para ser fotografada quadro a quadro e virar vídeo. Não entra no
 * menu, no sitemap nem em produção; a rota é removida junto com este arquivo
 * assim que o animatic estiver montado.
 *
 * A razão de ela existir: as telas do sistema que aparecem no filme são estas,
 * de verdade, renderizadas pelos mesmos componentes do site. Nenhum modelo de
 * IA precisa inventar interface da Natcorp — e é justamente aí que filme feito
 * com IA costuma se entregar.
 */
import { Logo } from '@/components/brand/Logo'
import { FitFrame, ScaledFrame } from '@/components/motion/ScaledFrame'
import { DashboardMockup } from '@/components/mockups/DashboardMockup'
import { SesmtMockup } from '@/components/mockups/SesmtMockup'
import { AdmissionMockup } from '@/components/mockups/AdmissionMockup'
import { EMPLOYEE_CARD_SIZE, EmployeeCardMockup } from '@/components/mockups/EmployeeCardMockup'
import { RequestMockup } from '@/components/mockups/RequestMockup'
import { NATPONTO_SIZE } from '@/components/mockups/natponto/NatPontoFrame'
import { NatPontoPhone } from '@/components/mockups/natponto/screens'
import { NatiBubble, NatiChatWindow, UserBubble } from '@/components/mockups/nati/NatiChatWindow'
import { NatiChartCard } from '@/components/mockups/nati/NatiChartCard'
import { moduleIcons } from '@/content/modulePages/icons'
import { cn } from '@/lib/utils'

const turnover = {
  labels: ['Suape', 'Camaçari', 'Betim', 'Cabo', 'Matriz'],
  values: [18.4, 9.2, 8.7, 7.9, 5.1],
}

/** Origem de cada quadro: o que é tela nossa e o que precisa ser filmado. */
type Origem = 'real' | 'ia' | 'misto'

const selo: Record<Origem, { texto: string; classe: string }> = {
  real: { texto: 'TELA REAL DO SISTEMA', classe: 'bg-[#1F7A4D] text-white' },
  ia: { texto: 'PLANO A GERAR', classe: 'bg-[#8A4B12] text-white' },
  misto: { texto: 'PLANO GERADO + TELA REAL', classe: 'bg-brand-purple text-white' },
}

function Quadro({
  n,
  estilo,
  tc,
  titulo,
  origem,
  fala,
  quemFala,
  acao,
  claro = false,
  children,
}: {
  n: number
  estilo?: React.CSSProperties
  tc: string
  titulo: string
  origem: Origem
  fala?: string
  quemFala?: string
  acao: string
  claro?: boolean
  children: React.ReactNode
}) {
  const s = selo[origem]
  const nu = typeof window !== 'undefined' && new URLSearchParams(window.location.search).get('nu') === '1'
  if (nu) {
    // Só o conteúdo, sobre transparente: é o que se compõe sobre a filmagem.
    return (
      <div data-quadro={n} style={estilo} className="flex h-[1080px] w-[1920px] items-center justify-center">
        {children}
      </div>
    )
  }
  return (
    <div
      data-quadro={n}
      style={estilo}
      className={cn('relative flex h-[1080px] w-[1920px] flex-col overflow-hidden', claro ? 'bg-[#F4F2F7]' : 'bg-[#120B22]')}
    >
      <div className="flex items-center gap-4 px-12 pt-8">
        <span className={cn('rounded px-3 py-1 text-[20px] font-bold tracking-[0.08em]', claro ? 'bg-brand-ink text-white' : 'bg-white/15 text-white')}>
          {tc}
        </span>
        <span className={cn('text-[26px] font-extrabold uppercase tracking-[0.14em]', claro ? 'text-brand-ink' : 'text-white')}>{titulo}</span>
        <span className={cn('ml-auto rounded px-3 py-1 text-[17px] font-bold tracking-[0.08em]', s.classe)}>{s.texto}</span>
      </div>

      <div className="flex min-h-0 flex-1 items-center justify-center px-16 py-8">{children}</div>

      <div className={cn('px-12 pb-10', claro ? 'text-brand-ink' : 'text-white')}>
        {fala && (
          <p className="text-[34px] font-extrabold leading-tight">
            {quemFala && <span className={cn('mr-3 text-[24px] font-bold uppercase tracking-[0.1em]', claro ? 'text-brand-purple' : 'text-[#F3C9DA]')}>{quemFala}</span>}
            “{fala}”
          </p>
        )}
        <p className={cn('mt-2 text-[24px] leading-snug', claro ? 'text-brand-graphite' : 'text-white/70')}>{acao}</p>
      </div>
    </div>
  )
}

/** Cartela para o que ainda vai ser filmado: descreve o plano em vez de fingir que existe. */
function Plano({ linhas }: { linhas: string[] }) {
  return (
    <div className="flex w-full max-w-[1500px] flex-col items-center gap-6 rounded-[28px] border-2 border-dashed border-white/25 px-16 py-14 text-center">
      {linhas.map((l, i) => (
        <p key={l} className={cn('leading-tight text-white', i === 0 ? 'text-[52px] font-extrabold' : 'text-[30px] text-white/70')}>
          {l}
        </p>
      ))}
    </div>
  )
}

const modulosDaConvergencia = [
  'Folha', 'Ponto', 'Admissão', 'NatDocs', 'Requisições', 'SESMT',
  'Benefícios', 'eSocial', 'Talentos', 'Desenvolvimento', 'Analytics', 'Recrutamento',
]


/** Interpolação suave: começa e termina devagar. */
const suave = (t: number) => (t < 0.5 ? 4 * t * t * t : 1 - (-2 * t + 2) ** 3 / 2)
const entre = (a: number, b: number, t: number) => a + (b - a) * t
const faixa = (t: number, a: number, b: number) => Math.min(1, Math.max(0, (t - a) / (b - a)))

/** As quatro casas do símbolo da Natcorp, onde os módulos se encaixam. */
const CASAS = [
  { x: 0, y: -92 },
  { x: 92, y: 0 },
  { x: 0, y: 92 },
  { x: -92, y: 0 },
]

/**
 * Os módulos se encaixam e viram a marca — e o encaixe ACENDE a tela.
 *
 * É o único plano do filme sem nenhuma imagem gerada: as peças são losangos da
 * própria identidade e o símbolo do fim é o SVG real. Renderiza um instante `t`
 * (0 a 1) para ser fotografado; a animação sai da sequência de fotos.
 *
 * Os doze módulos não colapsam num ponto: cada um vai para UMA DAS QUATRO CASAS
 * do símbolo, três por casa. É o que faz o losango parecer construído a partir
 * do produto, e não apenas aplicado no fim.
 */
function Convergencia({ t }: { t: number }) {
  const e = suave(faixa(t, 0, 0.78))
  // a tela só acende no instante do encaixe, e passa pelo rosa da marca —
  // um cruzamento linear até o claro passaria por um cinza sujo.
  const acende = suave(faixa(t, 0.7, 0.92))
  const rosa = Math.sin(Math.PI * faixa(t, 0.66, 0.98))
  const fundo =
    `radial-gradient(60% 70% at 50% 50%, rgba(236,92,156,${(rosa * 0.55).toFixed(3)}), transparent 70%), ` +
    `rgb(${Math.round(entre(18, 244, acende))},${Math.round(entre(11, 242, acende))},${Math.round(entre(34, 247, acende))})`
  const marca = suave(faixa(t, 0.8, 1))
  const escuro = acende < 0.5

  return (
    <div data-quadro="conv" className="relative flex h-[1080px] w-[1920px] items-center justify-center overflow-hidden" style={{ background: fundo }}>
      {modulosDaConvergencia.map((m, i) => {
        const casa = CASAS[i % CASAS.length]
        const ang = (i / modulosDaConvergencia.length) * Math.PI * 2 - Math.PI / 2
        const x = entre(Math.cos(ang) * 780, casa.x, e)
        const y = entre(Math.sin(ang) * 480, casa.y, e)
        const tam = entre(148, 128, e)
        return (
          <div key={m} className="absolute flex flex-col items-center gap-3" style={{ transform: `translate(${x}px, ${y}px)`, opacity: 1 - marca }}>
            <div
              className="rounded-[26px] bg-brand-gradient"
              style={{ width: tam, height: tam, transform: `rotate(${entre(45 + (i % 3) * 42, 45, e)}deg)` }}
            />
            <span className="text-[24px] font-bold" style={{ opacity: (1 - e) * 0.9, color: escuro ? '#ffffff' : '#1B1238' }}>
              {m}
            </span>
          </div>
        )
      })}
      <Logo variant="symbol" tone="gradient" className="absolute h-[320px] w-[320px]" style={{ opacity: marca }} />
    </div>
  )
}

/**
 * A marca isolada, para ser fotografada em PNG com fundo transparente e
 * composta no peito da polo. O logotipo NUNCA é gerado por IA: sai daqui, do
 * mesmo SVG do site, e por isso chega ao filme sem deformação.
 * ?marca=simbolo | horizontal
 */
/**
 * Assinatura eletrônica: token de 6 dígitos, Confirmar, e o aviso de sucesso.
 *
 * É a única tela do filme que não existia como mockup — o AdmissionMockup cita
 * a assinatura numa lista de etapas, mas não mostra o ato. E o ato é o que foi
 * pedido: sem ele o filme fala de assinatura eletrônica sem nunca assiná-la.
 */
function AssinaturaMockup({ assinado = false }: { assinado?: boolean }) {
  const digitos = ['4', '7', '2', '9', '1', '5']
  return (
    <div className="w-[420px] rounded-2xl border border-brand-mist bg-white p-6 shadow-soft">
      <p className="text-[11px] font-semibold uppercase tracking-wider text-brand-plum">
        Assinatura eletrônica
      </p>
      <p className="mt-1 text-[15px] font-semibold text-brand-ink">Contrato de trabalho</p>

      {assinado ? (
        <div className="mt-5 flex items-center gap-3 rounded-xl bg-emerald-50 p-4">
          <span
            aria-hidden
            className="grid h-9 w-9 shrink-0 place-items-center rounded-full bg-emerald-500 text-[18px] font-bold text-white"
          >
            ✓
          </span>
          <p className="text-[14px] font-semibold leading-snug text-emerald-800">
            Documento assinado com sucesso
          </p>
        </div>
      ) : (
        <>
          <p className="mt-4 text-[12px] text-brand-slate">
            Informe o token enviado para o seu celular
          </p>
          <div className="mt-3 flex gap-2" aria-label="Token de seis dígitos">
            {digitos.map((d, i) => (
              <span
                key={i}
                className="grid h-12 w-[58px] place-items-center rounded-lg border-2 border-brand-mist bg-brand-cloud text-[20px] font-bold tabular-nums text-brand-ink"
              >
                {d}
              </span>
            ))}
          </div>
          <div className="mt-5 rounded-lg bg-brand-plum py-3 text-center text-[14px] font-semibold text-white">
            Confirmar
          </div>
        </>
      )}
    </div>
  )
}

/**
 * ?painel=<nome> — UM mockup isolado, sobre transparente.
 *
 * É o que se compõe sobre a filmagem: no filme a interface aparece FLUTUANDO no
 * ar ao lado da pessoa, não colada no vidro do aparelho. Some assim a
 * necessidade de rastrear os cantos da tela quadro a quadro, e a linguagem fica
 * igual à do plano da NATI, que já foi montado desse jeito.
 */
const PAINEIS = {
  natponto: (
    <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height} className="w-[300px]">
      <NatPontoPhone screen="success" />
    </ScaledFrame>
  ),
  assinatura: <AssinaturaMockup />,
  assinado: <AssinaturaMockup assinado />,
  requisicao: <RequestMockup className="w-[560px] shadow-soft" />,
  // Sem FitFrame aqui: ele é `w-full` e mede o pai, que num `inline-block` sem
  // largura dá 0 — a captura vinha inteiramente transparente. Largura fixa.
  folha: (
    <div className="w-[760px]">
      <DashboardMockup className="border-brand-mist shadow-soft" />
    </div>
  ),
  portal: (
    <ScaledFrame
      width={EMPLOYEE_CARD_SIZE.width}
      height={EMPLOYEE_CARD_SIZE.height}
      className="w-[280px]"
    >
      <EmployeeCardMockup />
    </ScaledFrame>
  ),
  sesmt: <SesmtMockup className="w-[560px] shadow-soft" />,
} as const

function MarcaPeito({ variante, tom }: { variante: 'symbol' | 'horizontal'; tom: 'white' | 'gradient' }) {
  return (
    <div className="flex h-[600px] w-[1200px] items-center justify-center">
      <Logo variant={variante} tone={tom} className={variante === 'symbol' ? 'h-[420px] w-auto' : 'h-[220px] w-auto'} />
    </div>
  )
}

export default function AnimaticPage() {
  // ?q=N renderiza um quadro só. É o que permite fotografar cada um em
  // 1920x1080 exatos — e, principalmente, o que faz os mockups aparecerem:
  // eles animam com `whileInView`, então precisam estar sozinhos na viewport.
  const busca = new URLSearchParams(window.location.search)
  const q = Number(busca.get('q') || 0)
  // ?conv=0..1 renderiza UM instante da convergência dos módulos, para ser
  // fotografado quadro a quadro e virar vídeo. Não usa IA: são os vetores da
  // própria marca.
  const conv = busca.has('conv') ? Number(busca.get('conv')) : null
  const nu = busca.get('nu') === '1'
  const so = (n: number) => (q > 0 && q !== n ? { display: 'none' as const } : undefined)
  if (conv !== null) return <Convergencia t={Math.min(1, Math.max(0, conv))} />
  // ?painel=<nome> devolve só o mockup, sobre transparente, encostado no canto
  // superior esquerdo. A captura vem numa tela folgada e o recorte pelo canal
  // alfa acha a caixa exata depois — mais confiável do que acertar o tamanho da
  // janela para cada painel.
  const painel = busca.get('painel') as keyof typeof PAINEIS | null
  if (painel && painel in PAINEIS) {
    return (
      <>
        <style>{'html,body,#root{background:transparent !important;margin:0}'}</style>
        <div className="inline-block p-6">{PAINEIS[painel]}</div>
      </>
    )
  }

  const marca = busca.get('marca')
  if (marca === 'simbolo' || marca === 'horizontal') {
    return (
      <>
        <style>{'html,body,#root{background:transparent !important}'}</style>
        <MarcaPeito variante={marca === 'simbolo' ? 'symbol' : 'horizontal'} tom={busca.get('tom') === 'cor' ? 'gradient' : 'white'} />
      </>
    )
  }

  return (
    <div className={cn('w-[1920px]', nu ? 'bg-transparent' : 'bg-black')} data-so={q || 'todos'}>
      {/* No modo nu o fundo da página também precisa sair, senão a captura vem opaca. */}
      {nu && <style>{'html,body,#root{background:transparent !important}'}</style>}
      <Quadro
        estilo={so(1)}
        n={1}
        tc="00,00s"
        titulo="A operação"
        origem="ia"
        fala="Numa empresa grande, o RH não é um departamento. É uma operação."
        quemFala="NARRADOR"
        acao="Andar corporativo amplo, pé-direito alto, muita gente em movimento. Câmera baixa avançando devagar. Luz de dia pelo vidro."
      >
        <Plano linhas={['SEDE CORPORATIVA · INTERIOR · DIA', 'Plano de abertura. Estabelece porte pelo olho, não pela palavra.']} />
      </Quadro>

      <Quadro
        estilo={so(2)}
        n={2}
        tc="05,14s"
        titulo="Ponto + EPI"
        origem="misto"
        acao="Portaria da fábrica: o operário aproxima o celular e o rosto é reconhecido. Corte para o balcão do almoxarifado: o almoxarife entrega o EPI e registra a entrega na tela."
      >
        <div className="flex items-center gap-16">
          <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height} className="w-[300px] shrink-0">
            <NatPontoPhone screen="face" />
          </ScaledFrame>
          <div className="w-[980px]">
            <SesmtMockup className="shadow-soft" />
          </div>
        </div>
      </Quadro>

      <Quadro
        estilo={so(3)}
        n={3}
        tc="07,64s"
        titulo="Admissão + assinatura"
        origem="misto"
        acao='Sala de casa: o candidato toca "Enviar documentação para admissão". Corte para o token de 6 dígitos já preenchido, o polegar em Confirmar, e o verde de assinado com sucesso.'
      >
        <div className="w-[1180px]">
          <AdmissionMockup className="shadow-soft" />
        </div>
      </Quadro>

      <Quadro
        estilo={so(4)}
        n={4}
        tc="10,14s"
        titulo="O gestor aprova"
        origem="misto"
        fala="Sem papel."
        quemFala="NARRADOR"
        acao="Corredor: o gestor aprova a requisição no tablet com um toque. Adiante, o fluxo segue acendendo sozinho."
      >
        <div className="w-[1180px]">
          <RequestMockup className="shadow-soft" />
        </div>
      </Quadro>

      <Quadro
        estilo={so(5)}
        n={5}
        tc="11,26s"
        titulo="A folha fecha"
        origem="misto"
        fala="Sem fila. Sem esperar o RH."
        quemFala="NARRADOR"
        acao="Sala do DP: unidade após unidade marcando folha fechada. Na mesma fração de segundo, o holerite chega no celular da colaboradora, no ônibus."
      >
        <div className="flex items-center gap-14">
          <div className="w-[1100px]">
            <FitFrame width={880}>
              <DashboardMockup className="border-brand-mist shadow-soft" />
            </FitFrame>
          </div>
          <ScaledFrame width={EMPLOYEE_CARD_SIZE.width} height={EMPLOYEE_CARD_SIZE.height} className="w-[280px] shrink-0">
            <EmployeeCardMockup />
          </ScaledFrame>
        </div>
      </Quadro>

      <Quadro
        estilo={so(6)}
        n={6}
        tc="14,25s"
        titulo="A NATI acorda"
        origem="misto"
        fala="A NATI vive dentro do sistema."
        quemFala="NARRADOR"
        acao="Tudo escurece. A gestora entra na mesma sala da abertura, caminhando, sem olhar para nenhuma tela. A luz rosa da marca acende atrás dela. A NATI não tem rosto: ela é a luz."
      >
        <div className="relative flex h-[560px] w-full items-center justify-center">
          <div
            className="absolute h-[520px] w-[520px] rotate-45 rounded-[80px] blur-[90px]"
            style={{ background: 'radial-gradient(closest-side, rgba(230,90,150,0.95), rgba(180,60,140,0.35) 60%, transparent)' }}
            aria-hidden
          />
          <Logo className="relative h-[190px] w-auto" tone="white" />
        </div>
      </Quadro>

      <Quadro
        estilo={so(7)}
        n={7}
        tc="16,59s"
        titulo="A pergunta"
        origem="misto"
        fala="Por que o turnover subiu em Suape?"
        quemFala="A GESTORA"
        acao="Ela pergunta em voz alta, natural, de costas para a câmera, caminhando. O dado começa a se montar ANTES de ela terminar a frase."
      >
        <div className="w-[1180px]">
          <NatiChatWindow bare bodyClassName="p-6">
            <UserBubble time="09:41">Por que o turnover subiu em Suape neste trimestre?</UserBubble>
          </NatiChatWindow>
        </div>
      </Quadro>

      <Quadro
        estilo={so(8)}
        n={8}
        tc="18,87s"
        titulo="A resposta se monta"
        origem="misto"
        acao="Sem locução. O número se materializa primeiro; o gráfico se desdobra ao redor; a análise aparece ao lado. Ela atravessa a informação, que acompanha o passo dela com paralaxe."
      >
        <div className="w-[1280px]">
          <NatiChatWindow bare bodyClassName="p-6">
            <NatiBubble>
              <p className="pr-6">
                O turnover de Suape fechou o trimestre em <b>18,4%</b>, contra 9,2% na média das outras unidades. <b>Ponto de atenção:</b> 62% dos
                desligamentos são de gente com menos de seis meses de casa, concentrados no turno da noite.
              </p>
            </NatiBubble>
            <div className="pl-[42px] pt-4">
              <NatiChartCard title="Turnover por unidade — 3º trimestre" data={turnover} types={['bar']} labelHeader="Unidade" valueLabel="Turnover" />
            </div>
          </NatiChatWindow>
        </div>
      </Quadro>

      <Quadro
        estilo={so(9)}
        n={9}
        tc="21,07s"
        titulo="Automatiza"
        origem="misto"
        fala="Automatiza."
        quemFala="A GESTORA"
        acao="Uma palavra. A luz rosa contrai para dentro do losango e dispara. A resposta vira ação — é o que separa a NATI de um chatbot."
      >
        <div className="flex w-full max-w-[1400px] items-center gap-10 rounded-[28px] border border-white/15 bg-white/[0.06] px-14 py-12">
          <div className="relative h-[190px] w-[190px] shrink-0">
            <div
              className="absolute inset-0 rotate-45 rounded-[40px] blur-[40px]"
              style={{ background: 'radial-gradient(closest-side, rgba(240,100,160,1), transparent)' }}
              aria-hidden
            />
            <Logo className="relative h-full w-full" tone="white" variant="symbol" />
          </div>
          <div className="text-white">
            <p className="text-[40px] font-extrabold leading-tight">Plano de ação criado</p>
            <p className="mt-3 text-[28px] text-white/70">
              Entrevista de permanência aos 30 dias · turno da noite · Suape
              <br />
              Responsável: gestor da unidade · Prazo: 5 dias
            </p>
          </div>
        </div>
      </Quadro>

      <Quadro
        estilo={so(10)}
        n={10}
        tc="22,03s"
        titulo="No chão de fábrica"
        origem="ia"
        acao="Corte seco para o mundo físico: o celular de um gestor apita no chão de fábrica com a tarefa que a NATI acabou de criar. Prova, sem dizer, que o sistema é um só."
      >
        <Plano linhas={['CHÃO DE FÁBRICA · O CELULAR APITA', 'A resposta da IA chega como tarefa, em outro lugar da operação.']} />
      </Quadro>

      <Quadro
        estilo={so(11)}
        n={11}
        tc="22,73s"
        titulo="Uma plataforma só"
        origem="real"
        fala="Tudo numa plataforma só."
        quemFala="NARRADOR"
        acao="Os módulos entram como peças de losango, rápido demais para dar tempo de ler todos — e é essa impossibilidade que comunica amplitude. Eles se encaixam formando o losango da Natcorp, e o encaixe ACENDE a tela: é aqui que o filme vira do escuro para o claro. Super: “e isso é uma fração”."
      >
        <div className="grid max-w-[1560px] grid-cols-6 gap-x-10 gap-y-8">
          {modulosDaConvergencia.map((m, i) => {
            const Icone = Object.values(moduleIcons)[i % Object.values(moduleIcons).length]
            return (
              <div key={m} className="flex flex-col items-center gap-3">
                <div className="flex h-[112px] w-[112px] rotate-45 items-center justify-center rounded-[22px] bg-brand-gradient">
                  <span className="-rotate-45 text-white">{Icone ? <Icone className="h-11 w-11" strokeWidth={1.6} /> : null}</span>
                </div>
                <span className="text-[22px] font-bold text-white/85">{m}</span>
              </div>
            )
          })}
        </div>
      </Quadro>

      <Quadro
        estilo={so(12)}
        n={12}
        tc="24,42s"
        titulo="Escala"
        origem="ia"
        acao="Quatro planos de ~0,6s, corte seco, em luz de dia. O losango recém-formado aparece em cada cenário. Os nomes entram como super, não como locução — quatro cortes se leem melhor do que se ouvem."
      >
        <div className="grid w-full max-w-[1700px] grid-cols-4 gap-8">
          {[
            ['INDÚSTRIA', '10.000 pessoas · 3 turnos'],
            ['SAÚDE', 'um hospital que não para · 24/7'],
            ['AGRO', 'operação em 12 estados'],
            ['CORPORAÇÕES', '340 centros de custo'],
          ].map(([t, s]) => (
            <div key={t} className="flex h-[420px] flex-col items-center justify-center gap-4 rounded-[24px] border-2 border-dashed border-white/25 px-6 text-center">
              <span className="text-[40px] font-extrabold tracking-[0.06em] text-white">{t}</span>
              <span className="text-[24px] text-white/60">{s}</span>
            </div>
          ))}
        </div>
      </Quadro>

      <Quadro
        estilo={so(13)}
        n={13}
        tc="26,42s"
        titulo="Cartão final"
        origem="real"
        claro
        fala="Natcorp. Todo o RH, em um só sistema."
        quemFala="NARRADOR"
        acao="Fundo claro, logo colorido animado. Nada mais: sem credenciais, sem selos, sem lista. É o quadro mais claro do filme, logo depois do mais escuro."
      >
        <div className="flex flex-col items-center gap-12">
          <Logo className="h-[150px] w-auto" tone="gradient" />
          <p className="text-[44px] font-extrabold text-brand-ink">Todo o RH, em um só sistema.</p>
        </div>
      </Quadro>
    </div>
  )
}
