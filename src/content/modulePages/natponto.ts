import type { ModulePage } from './types'

const page: ModulePage = {
  slug: 'natponto',
  name: 'NatPonto',
  group: 'ponto-e-jornada',
  tagline: 'O ponto no celular, com [[rosto, local e hora]].',
  summary:
    'O NatPonto é o aplicativo oficial de marcação de ponto da Natcorp. O colaborador registra a jornada com reconhecimento facial e geolocalização, no celular ou no tablet, mesmo sem internet. A marcação chega em segundos ao Ponto Eletrônico, pronta para apurar.',
  seo: {
    title: 'NatPonto: app de ponto com reconhecimento facial | Natcorp',
    description:
      'App de ponto da Natcorp para iOS e Android: reconhecimento facial, geolocalização, modo multiusuário e uso offline, integrado ao Ponto Eletrônico e à folha.',
  },
  highlights: [
    { value: '1 raio', label: 'por unidade: cada filial com o seu perímetro de marcação' },
    { value: '0', label: 'marcações perdidas sem internet: guarda no aparelho e sincroniza depois' },
    { value: 'REP-P', label: 'conforme a Portaria MTP 671/2021, com AFD, AEJ e espelho assinado' },
  ],
  benefits: [
    {
      title: 'Marcação confiável, sem fraude',
      text: 'O reconhecimento facial confirma quem está marcando e a geolocalização registra onde. Proteção para a empresa e para o colaborador.',
    },
    {
      title: 'Um app para a unidade e para o campo',
      text: 'Um tablet no modo multiusuário serve a equipe inteira de uma unidade. Quem está em campo marca no próprio celular, com o local registrado.',
    },
    {
      title: 'Nada se perde sem internet',
      text: 'Sem sinal, o app guarda as marcações e sincroniza sozinho quando reconecta. A jornada fica completa e o RH não precisa corrigir nada depois.',
    },
    {
      title: 'Do toque no celular à folha',
      text: 'A marcação chega em segundos ao Ponto Eletrônico, a apuração aplica as regras e o resultado segue para a folha e para o eSocial sem digitação.',
    },
  ],
  features: [
    {
      title: 'Reconhecimento facial',
      text: 'Validação biométrica automática na hora da marcação. O colaborador toca, olha para a câmera e o ponto é registrado com segurança e precisão.',
      icon: 'scan-face',
    },
    {
      title: 'Geolocalização',
      text: 'Cada marcação guarda o local exato onde foi feita, com o endereço visível na tela. Prova para a empresa e para o colaborador.',
      icon: 'map-pin',
    },
    {
      title: 'Modo multiusuário',
      text: 'Vários colaboradores marcam ponto no mesmo tablet ou smartphone, um após o outro, cada um identificado pelo próprio rosto.',
      icon: 'users',
    },
    {
      title: 'Funciona offline',
      text: 'Sem conexão, as marcações ficam armazenadas no aparelho e sincronizam automaticamente assim que a internet volta.',
      icon: 'refresh',
    },
    {
      title: 'iOS e Android',
      text: 'Disponível para iOS e Android, em smartphones e tablets. O colaborador marca o ponto no aparelho que já usa, com a mesma experiência nos dois sistemas.',
      icon: 'smartphone',
    },
    {
      title: 'Integração automática com o ponto',
      text: 'As marcações chegam em segundos ao Ponto Eletrônico, prontas para análise, gestão e cálculo. Nenhum arquivo para importar.',
      icon: 'zap',
    },
    {
      title: 'Frequência em tempo real',
      text: 'Entradas, saídas, banco de horas, horas extras e ocorrências visíveis para o RH e para o gestor no mesmo dia, direto no painel.',
      icon: 'eye',
    },
    {
      title: 'Consulta pelo colaborador',
      text: 'Depois de marcar, o colaborador consulta o espelho de ponto e o saldo do banco de horas no Portal do Colaborador, no celular ou no computador.',
      icon: 'clipboard',
    },
  ],
  flow: {
    title: 'Do toque no celular ao eSocial',
    steps: [
      { title: 'Colaborador marca o ponto', text: 'Reconhecimento facial e geolocalização no NatPonto, com ou sem internet.' },
      { title: 'Marcação chega ao sistema', text: 'Em segundos, o registro entra no Ponto Eletrônico, pronto para apuração.' },
      { title: 'Regras de frequência aplicadas', text: 'Escala, tolerâncias, banco de horas e horas extras tratados automaticamente.' },
      { title: 'Folha calculada', text: 'Os eventos apurados seguem para a folha, processada a 2.500 colaboradores por minuto.' },
      { title: 'Envio ao eSocial', text: 'Os dados validados são enviados ao eSocial sem intervenção manual.' },
    ],
  },
  compliance: [
    'Registro de ponto conforme a Portaria MTP 671/2021 (REP-P)',
    'Arquivos AFD e AEJ e espelho de ponto assinado digitalmente',
    'Comprovante de cada marcação com QR e código de verificação (hash)',
    'Dados biométricos tratados como dados sensíveis (LGPD), com consentimento registrado e template facial criptografado',
    'Registro de programa de computador no INPI',
  ],
  personas: [
    { role: 'Colaborador', text: 'Marca o ponto no próprio celular em segundos, mesmo sem internet, e consulta o espelho e o banco de horas no portal.' },
    { role: 'Gestor', text: 'Acompanha entradas, saídas, horas extras e ocorrências da equipe em tempo real e aprova o que precisa pelo portal.' },
    { role: 'RH e Departamento Pessoal', text: 'Recebe as marcações já no sistema, sem coletar arquivo de relógio, e parte direto para a apuração e a folha.' },
  ],
  faq: [
    {
      q: 'O NatPonto funciona sem internet?',
      a: 'Sim. Sem conexão, as marcações ficam armazenadas no aparelho e sincronizam automaticamente assim que a internet volta. Nenhum registro se perde.',
    },
    {
      q: 'Vários colaboradores podem usar o mesmo aparelho?',
      a: 'Sim. No modo multiusuário, um tablet ou smartphone fixo na unidade atende toda a equipe. Cada pessoa é identificada pelo reconhecimento facial na hora de marcar.',
    },
    {
      q: 'Como a marcação chega à folha?',
      a: 'O NatPonto é integrado ao Ponto Eletrônico da Natcorp. A marcação chega em segundos ao sistema, a apuração aplica as regras de jornada e banco de horas e os eventos seguem para a folha e para o eSocial sem digitação.',
    },
    {
      q: 'Em quais aparelhos o app está disponível?',
      a: 'O NatPonto está disponível para iOS e Android e funciona em smartphones e tablets. O colaborador pode usar o próprio celular, e a empresa pode usar tablets compartilhados no modo multiusuário.',
    },
    {
      q: 'O NatPonto atende à Portaria 671 (REP-P)?',
      a: 'Sim. O NatPonto é um registrador eletrônico de ponto por programa (REP-P), conforme a Portaria MTP 671/2021, com registro de programa de computador no INPI. Cada marcação gera um comprovante com QR e código de verificação, e o Ponto Eletrônico gera o AFD, o AEJ e o espelho de ponto assinado digitalmente, prontos para a fiscalização.',
    },
    {
      q: 'Como funciona em um grupo com 25 unidades?',
      a: 'Cada unidade tem o seu raio de marcação, e quem transita entre filiais marca em qualquer uma delas. A marcação fora do raio entra sinalizada para o gestor justificar. Ajustes, abonos e horas extras seguem a alçada de cada filial, e o RH central vê a fila por unidade e fecha o ponto de todas.',
    },
  ],
  related: ['ponto-eletronico', 'folha-de-pagamento', 'portais', 'esocial'],
  sources: ['apresentacao-natcorp', 'paineis-inteligentes', 'performance-e-seguranca', 'pagadoria', 'abrangencia-do-sistema'],
}

export default page
