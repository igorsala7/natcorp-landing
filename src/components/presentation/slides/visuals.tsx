import type { ReactNode } from 'react'
import { m } from 'motion/react'
import { FitFrame, ScaledFrame } from '@/components/motion/ScaledFrame'
import { DashboardMockup } from '@/components/mockups/DashboardMockup'
import { SesmtMockup } from '@/components/mockups/SesmtMockup'
import { AdmissionMockup } from '@/components/mockups/AdmissionMockup'
import { DevelopmentMockup } from '@/components/mockups/DevelopmentMockup'
import { RequestMockup } from '@/components/mockups/RequestMockup'
import { NATPONTO_SIZE } from '@/components/mockups/natponto/NatPontoFrame'
import { NatPontoPhone } from '@/components/mockups/natponto/screens'
import { Conversation, NatiBubble, NatiChatWindow, UserBubble } from '@/components/mockups/nati/NatiChatWindow'
import { NatiChartCard } from '@/components/mockups/nati/NatiChartCard'
import type { GroupId } from '@/content/modulePages/types'
import { EASE } from '@/lib/motion'

/**
 * O visual de cada frente na apresentação: uma tela real do sistema, a mesma que a home usa
 * nas abas das frentes. O slide mostra o sistema fazendo o trabalho, em vez de descrevê-lo.
 */
export interface DeckVisual {
  /** Descrição para leitores de tela. */
  label: string
  /** Legenda curta sob o visual. */
  caption: string
  render: () => ReactNode
}

/** Média salarial de exemplo para o gráfico gerado pela NATI. */
const payByRole = {
  labels: ['Supervisor de Setor', 'Analista de Operações', 'Técnico de Segurança', 'Assistente de DP', 'Auxiliar Administrativo'],
  values: [8900, 6400, 5200, 3900, 2800],
}

const chartIn = { hidden: { opacity: 0, y: 12 }, visible: { opacity: 1, y: 0, transition: { duration: 0.5, ease: EASE } } }

export const groupVisuals: Record<GroupId, DeckVisual> = {
  'pessoal-e-folha': {
    label: 'Tela do sistema Natcorp com a visão geral do mês: headcount, custo de folha, turnover, admissões digitais, requisições no prazo e sugestões da NATI',
    caption: 'Painel do Operador: a visão geral do mês, com a folha pronta para fechar.',
    render: () => (
      <FitFrame width={880}>
        <DashboardMockup className="border-brand-mist shadow-soft" />
      </FitFrame>
    ),
  },
  'ponto-e-jornada': {
    label: 'App NatPonto na tela de reconhecimento facial, com a câmera enquadrando o rosto e a localização confirmada',
    caption: 'NatPonto: reconhecimento facial e geolocalização. Marca até sem internet e sincroniza depois.',
    render: () => (
      <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height} className="mx-auto w-[min(230px,22vh)]">
        <NatPontoPhone screen="face" />
      </ScaledFrame>
    ),
  },
  'saude-e-seguranca': {
    label: 'Tela do SESMT: exames dos próximos 15 dias, a cadeia que vai do ASO ao eSocial e os eventos de saúde e segurança já enviados',
    caption: 'Medicina Ocupacional: os próximos exames e os eventos de SST do eSocial, na mesma base da folha.',
    render: () => <SesmtMockup className="shadow-soft" />,
  },
  talentos: {
    label: 'Tela da Admissão Digital: etapas da admissão de Ana Ribeiro, com dados, documentos e o contrato de trabalho pronto para assinar',
    caption: 'Admissão Digital: etapas concluídas e o contrato pronto para assinar no celular.',
    render: () => <AdmissionMockup className="shadow-soft" />,
  },
  desenvolvimento: {
    label: 'Tela de Desenvolvimento: ciclo de avaliação, metas com pesos e a trilha de treinamento da colaboradora',
    caption: 'Avaliação, metas e treinamento sobre os mesmos dados de cargo, equipe e histórico.',
    render: () => <DevelopmentMockup className="shadow-soft" />,
  },
  autoatendimento: {
    label: 'Requisição de férias no fluxo de aprovação: pedido do colaborador, aprovação do gestor, conferência do RH e efetivação na folha',
    caption: 'Requisição de férias: aprovada no fluxo e efetivada na folha. Aprovou, efetivou.',
    render: () => <RequestMockup className="shadow-soft" />,
  },
  'dados-ia-plataforma': {
    label: 'Conversa com a NATI: pergunta sobre a média salarial por cargo e resposta com análise e gráfico de barras gerado na hora',
    caption: 'NATI: uma pergunta em português, a análise e o gráfico na hora, com as fontes.',
    render: () => (
      <NatiChatWindow bare bodyClassName="p-4">
        <Conversation stagger={0.4} delay={0.1}>
          <UserBubble time="09:41">Qual é a média salarial por cargo na Filial 97?</UserBubble>
          <NatiBubble>
            <p className="pr-6">
              Aqui está a média salarial dos cinco maiores cargos da Filial 97, com base na folha de agosto. <b>Ponto de atenção:</b> o cargo de Supervisor de Setor está 6% acima da
              mediana das outras filiais.
            </p>
          </NatiBubble>
          <m.div variants={chartIn} className="pl-[42px]">
            <NatiChartCard title="Média Salarial por Cargo - Filial 97" data={payByRole} types={['bar']} labelHeader="Cargo" valueLabel="Média salarial" />
          </m.div>
        </Conversation>
      </NatiChatWindow>
    ),
  },
}
