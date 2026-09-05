import bensIndustriais from '@/assets/people/segments/bens-industriais.jpg'
import bensDeConsumo from '@/assets/people/segments/bens-de-consumo.jpg'
import servicosAoConsumidor from '@/assets/people/segments/servicos-ao-consumidor.jpg'
import saude from '@/assets/people/segments/saude-e-ciencias-biologicas.jpg'
import recursosNaturais from '@/assets/people/segments/recursos-naturais.jpg'
import setorPublico from '@/assets/people/segments/setor-publico-e-social.jpg'
import servicosFinanceiros from '@/assets/people/segments/servicos-financeiros.jpg'
import varejo from '@/assets/people/segments/varejo.jpg'
import telecom from '@/assets/people/segments/telecom.jpg'

/**
 * Capa de cada segmento na home: a pessoa do segmento e a dor em uma frase.
 * Fotos provisórias de banco (Unsplash), a substituir por fotos de clientes. Créditos em src/assets/people/CREDITS.md.
 */
export interface SegmentCover {
  photo: string
  alt: string
  /** A dor do segmento e a resposta, em uma frase curta. */
  pain: string
  /** object-position da foto no cartão. */
  position?: string
}

export const segmentCovers: Record<string, SegmentCover> = {
  'bens-industriais': {
    photo: bensIndustriais,
    alt: 'Foto ilustrativa: engenheira com notebook em uma linha de produção',
    pain: 'Turnos, horas extras e treinamentos de NR em dia. Sem planilha de apoio.',
    position: '50% 30%',
  },
  'bens-de-consumo': {
    photo: bensDeConsumo,
    alt: 'Foto ilustrativa: equipe reunida em volta de um notebook',
    pain: 'Safra, sazonalidade e temporários. A folha acompanha o ritmo da fábrica.',
    position: '50% 35%',
  },
  'servicos-ao-consumidor': {
    photo: servicosAoConsumidor,
    alt: 'Foto ilustrativa: gerente sorrindo em um restaurante',
    pain: 'Rotatividade alta e escala por demanda. Admissão em minutos, não em dias.',
    position: '50% 25%',
  },
  'saude-e-ciencias-biologicas': {
    photo: saude,
    alt: 'Foto ilustrativa: enfermeiro de jaleco azul sorrindo',
    pain: 'Escala 12x36 por setor e por unidade. Folha apurada sem planilha.',
    position: '50% 20%',
  },
  'recursos-naturais': {
    photo: recursosNaturais,
    alt: 'Foto ilustrativa: trabalhador de boné ao ar livre, com montanhas ao fundo',
    pain: 'Equipes em campo, sem sinal. O ponto registra e sincroniza depois.',
    position: '50% 30%',
  },
  'setor-publico-e-social': {
    photo: setorPublico,
    alt: 'Foto ilustrativa: gestora de blazer listrado em um escritório',
    pain: 'Transparência, controle e prestação de contas por padrão, não por esforço.',
    position: '50% 25%',
  },
  'servicos-financeiros': {
    photo: servicosFinanceiros,
    alt: 'Foto ilustrativa: executivo de óculos em um escritório envidraçado',
    pain: 'Jornada bancária, auditoria e LGPD sem retrabalho entre sistemas.',
    position: '50% 25%',
  },
  varejo: {
    photo: varejo,
    alt: 'Foto ilustrativa: atendente de camisa laranja ajudando um cliente no balcão',
    pain: 'Escala de domingo e feriado loja a loja. Banco de horas certo na folha.',
    position: '60% 30%',
  },
  telecom: {
    photo: telecom,
    alt: 'Foto ilustrativa: profissional de tecnologia em uma sala de servidores',
    pain: 'Técnicos em campo e operação 24 horas. Ponto com geolocalização e periculosidade na folha.',
    position: '70% 40%',
  },
}
