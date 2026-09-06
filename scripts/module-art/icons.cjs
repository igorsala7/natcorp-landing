/**
 * Glifos dos ícones de módulo, desenhados na grade de 24 (traço branco, pontas redondas).
 * Cada glifo é original e leva exatamente um módulo (losango) preenchido em Rosa como acento.
 * Assinatura: (k) => string SVG interna, onde k é o kit (accent, moduleOutline, person, rr...).
 */
const kit = require('./kit.cjs')
const { accent, moduleOutline, person, rr } = kit

const icons = {
  // Folha de Pagamento: holerite com dobra e a moeda como módulo rosa.
  'folha-de-pagamento': () => `
<path d="M7 3h7l4 4v13a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 6 20V4.5A1.5 1.5 0 0 1 7.5 3"/>
<path d="M14 3v4h4"/>
<path d="M9 11.5h6"/>
<path d="M9 14.5h3.5"/>
${accent(15.4, 16.6, 4)}`,

  // Administração de Pessoal: a pessoa e o quadro de posições ao lado; a posição aberta é o módulo rosa.
  'administracao-de-pessoal': () => `
${person(8.5, 12.5, 1.25)}
${moduleOutline(18.2, 6.8, 3.8)}
${accent(18.2, 12.5, 3.8)}
${moduleOutline(18.2, 18.2, 3.8)}`,

  // Cargos e Salários: faixas salariais (mín-máx) com o salário atual marcado no módulo rosa.
  'cargos-e-salarios': () => `
${rr(3.5, 9.5, 4.2, 10, 2.1)}
${rr(9.9, 4.5, 4.2, 13, 2.1)}
${rr(16.3, 11.5, 4.2, 8, 2.1)}
<path d="M3.5 21h17"/>
${accent(12, 11, 3.6)}`,

  // Gestão de Benefícios: o cartão de benefícios com o chip em módulo rosa.
  'gestao-de-beneficios': () => `
${rr(3, 5.5, 18, 13, 2.2)}
<path d="M3 9.75h18"/>
<path d="M13 14.5h4.5"/>
${accent(8, 14.5, 3.6)}`,

  // NatPay: o celular com o adiantamento chegando por Pix (o losango do Pix vira módulo rosa).
  natpay: () => `
${rr(6.5, 2.5, 11, 19, 2.6)}
<path d="M10.5 18.25h3"/>
<path d="M12 6.5v1.6"/><path d="M12 13.9v1.6"/>
${accent(12, 11, 4.6)}`,

  // eSocial: o documento enviado e o retorno acompanhado (ida e volta).
  esocial: () => `
<path d="M4.5 3.5h5.5l3 3V19a1.5 1.5 0 0 1-1.5 1.5H4.5A1.5 1.5 0 0 1 3 19V5a1.5 1.5 0 0 1 1.5-1.5"/>
<path d="M10 3.5v3h3"/>
<path d="M15.5 9.5l5-5"/><path d="M17 4.5h3.5V8"/>
<path d="M20.5 14.5l-5 5"/><path d="M19 19.5h-3.5V16"/>
${accent(8, 13.5, 3.8)}`,

  // Jurídico Trabalhista: a balança, com o fiel em módulo rosa.
  'juridico-trabalhista': () => `
<path d="M12 6.5V20"/><path d="M8 20h8"/>
<path d="M4.5 7.5h15"/>
<path d="M5.5 7.5L3 13.5"/><path d="M5.5 7.5L8 13.5"/>
<path d="M2.5 13.5a3 3 0 0 0 6 0"/>
<path d="M18.5 7.5L16 13.5"/><path d="M18.5 7.5L21 13.5"/>
<path d="M15.5 13.5a3 3 0 0 0 6 0"/>
${accent(12, 4.6, 3.6)}`,

  // Ponto Eletrônico: relógio com ponteiros que nascem do módulo rosa.
  'ponto-eletronico': () => `
<circle cx="12" cy="12" r="8.5"/>
<path d="M12 3.5v1.6"/><path d="M12 18.9v1.6"/><path d="M3.5 12h1.6"/><path d="M18.9 12h1.6"/>
<path d="M12 12V7.2"/><path d="M12 12l3.4 2"/>
${accent(12, 12, 3.2)}`,

  // NatPonto: reconhecimento facial, o rosto dentro da moldura de leitura e o local marcado.
  natponto: () => `
<path d="M3.5 8V5.5a2 2 0 0 1 2-2H8"/><path d="M16 3.5h2.5a2 2 0 0 1 2 2V8"/>
<path d="M3.5 16v2.5a2 2 0 0 0 2 2H8"/><path d="M16 20.5h2.5a2 2 0 0 0 2-2V16"/>
${person(12, 12.4, 1.05)}
${accent(19.6, 19.6, 3.6)}`,

  // Medicina Ocupacional: a prancheta do ASO com a cruz de centro em módulo rosa.
  'medicina-ocupacional': () => `
${rr(4, 4.5, 16, 16.5, 2.2)}
<path d="M9 4.5V3.5a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v1"/>
<path d="M12 8.6v8.8"/><path d="M7.6 13h8.8"/>
${accent(12, 13, 2.6)}`,

  // Segurança do Trabalho: o capacete, com a marca frontal em módulo rosa.
  'seguranca-do-trabalho': () => `
<path d="M3 16.5h18"/>
<path d="M5.5 16.5V14a6.5 6.5 0 0 1 13 0v2.5"/>
<path d="M12 7.5v3.2"/>
${accent(12, 13, 3)}`,

  // Recrutamento e Seleção: a lupa sobre a pessoa, com o cabo terminando no módulo rosa.
  'recrutamento-e-selecao': () => `
<circle cx="10" cy="10" r="6.5"/>
${person(10, 10.6, 0.8)}
<path d="M14.8 14.8l3.2 3.2"/>
${accent(19.4, 19.4, 3.4)}`,

  // Quadro de Vagas: o mural com os cartões de vaga e a vaga nova em destaque.
  'quadro-de-vagas': () => `
${rr(3, 4.5, 18, 15, 2)}
<path d="M3 9.25h18"/>
${rr(5.75, 12, 5, 4.5, 1.2)}
${rr(13.25, 12, 5, 4.5, 1.2)}
${accent(6.6, 6.9, 2.8)}`,

  // Admissão Digital: o contrato assinado na tela, do candidato à folha em poucos cliques.
  'admissao-digital': () => `
<path d="M7 3h7l4 4v13a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 6 20V4.5A1.5 1.5 0 0 1 7.5 3"/>
<path d="M14 3v4h4"/>
<path d="M8.5 16.5c1.2-2.4 2.2-2.4 3-.6s1.6 1.8 3-.6"/>
${accent(10.6, 11, 3.6)}`,

  // Onboarding: a porta aberta e o lugar de quem chega já marcado.
  onboarding: () => `
<path d="M5 21V4.5a1.5 1.5 0 0 1 1.5-1.5h6A1.5 1.5 0 0 1 14 4.5V21"/>
<path d="M3 21h18"/>
<path d="M21 12.5h-6.5"/><path d="M17 10l-2.5 2.5 2.5 2.5"/>
${accent(9.5, 12.5, 3.8)}`,

  // Offboarding: o mesmo lugar, agora com o caminho de saída resolvido.
  offboarding: () => `
<path d="M5 21V4.5a1.5 1.5 0 0 1 1.5-1.5h6A1.5 1.5 0 0 1 14 4.5V21"/>
<path d="M3 21h18"/>
<path d="M12.5 12.5H21"/><path d="M18.5 10l2.5 2.5-2.5 2.5"/>
${accent(9.5, 12.5, 3.8)}`,

  // Avaliações, Pesquisas e Feedbacks: a volta de 360° em torno da pessoa.
  'avaliacoes-e-feedbacks': () => `
<path d="M4.5 12A7.5 7.5 0 1 1 15.75 18.5"/>
<path d="M13.4 19.4l2.35-.9-.6-2.4"/>
${person(12, 12.4, 0.8)}
${accent(4.5, 12, 3.4)}`,

  // Metas e Resultados: o alvo feito de módulos, com o centro em Rosa.
  'metas-e-resultados': () => `
${moduleOutline(12, 12, 17)}
${moduleOutline(12, 12, 10.5)}
${accent(12, 12, 4)}`,

  // Treinamento e Desenvolvimento: o capelo em forma de losango, com a borla em módulo rosa.
  'treinamento-e-desenvolvimento': () => `
<path d="M2.5 9.5L11.5 5l9 4.5-9 4.5z"/>
<path d="M6.5 11.8v3.7c0 1.6 2.2 2.9 5 2.9s5-1.3 5-2.9v-3.7"/>
<path d="M20.5 9.5v3.5"/>
${accent(20.5, 14.6, 3.2)}`,

  // Carreira e Sucessão: a trilha que sobe, módulo a módulo, até o próximo lugar.
  'carreira-e-sucessao': () => `
<path d="M7.7 16.3l2.6-2.6"/><path d="M13.7 10.3l2.6-2.6"/>
${moduleOutline(6, 18, 4.4)}
${moduleOutline(12, 12, 4.4)}
${accent(18, 6, 4.4)}
<path d="M4.5 21h15"/>`,

  // Portais: a janela do portal com a pessoa dentro e a entrada marcada.
  portais: () => `
${rr(3, 4, 18, 16, 2.2)}
<path d="M3 8.5h18"/>
${person(12, 14.6, 0.95)}
${accent(6, 6.25, 2.6)}`,

  // Requisições com Workflow: o pedido que passa pela aprovação e é efetivado.
  'requisicoes-com-workflow': () => `
${moduleOutline(5, 13, 4.4)}
<path d="M7.2 13h2.6"/>
${accent(12, 13, 4.4)}
<path d="M14.2 13h2.6"/>
<circle cx="19.3" cy="13" r="2.4"/>
<path d="M18.2 13l.8.8 1.6-1.7"/>
<path d="M12 10.8V8.6"/><path d="M9.5 6.5h5"/>`,

  // Chamado Interno: o balão do atendimento, com o chamado aberto em módulo rosa.
  'chamado-interno': () => `
<path d="M4 6a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8.5a2 2 0 0 1-2 2h-6.5L7 20.5v-4H6a2 2 0 0 1-2-2z"/>
<path d="M12.5 8.5h4"/><path d="M12.5 12h2.5"/>
${accent(8.6, 10.25, 3.6)}`,

  // Blog Corporativo: a linha do tempo da intranet, com o aviso novo no topo.
  'blog-corporativo': () => `
<path d="M5.5 3.5v17"/>
${accent(5.5, 7, 3.6)}
${moduleOutline(5.5, 12.5, 3.6)}
${moduleOutline(5.5, 18, 3.6)}
<path d="M9.5 7h11"/><path d="M9.5 12.5h7.5"/><path d="M9.5 18h9.5"/>`,

  // Assinatura Eletrônica: a assinatura sobre a linha e o selo de validade.
  'assinatura-eletronica': () => `
<path d="M3 16.2c1.5-3.6 3-4.6 4-2.1s2.1 5.1 3.6.1 2.6-4.8 4-1.6 2.5 3.2 4.4 1.7"/>
<path d="M3 20h18"/>
${moduleOutline(18, 6.5, 6.4)}
${accent(18, 6.5, 3)}`,

  // GED: os documentos digitalizados, com a etiqueta de indexação.
  ged: () => `
<path d="M8.5 6V4.5A1.5 1.5 0 0 1 10 3h8.5A1.5 1.5 0 0 1 20 4.5v11a1.5 1.5 0 0 1-1.5 1.5H17"/>
${rr(4, 6, 12, 15, 1.5)}
<path d="M7 11h6"/><path d="M7 14.5h4"/>
${accent(15.4, 16.6, 3.6)}`,

  // People Analytics: os cruzamentos como pontos em módulo sobre os eixos.
  'people-analytics': () => `
<path d="M4 3.5V20h16.5"/>
${moduleOutline(8.5, 15, 3.6)}
${moduleOutline(12.5, 9.5, 3.6)}
${moduleOutline(17.5, 13, 3.6)}
${accent(16, 5.5, 3.6)}`,

  // Business Intelligence: o painel com as barras, e o indicador principal em Rosa.
  'business-intelligence': () => `
${rr(3, 4, 18, 16, 2.2)}
<path d="M3 8.5h18"/>
<path d="M7.5 16.5v-3"/><path d="M12 16.5V11"/><path d="M16.5 16.5v-4.5"/>
${accent(12, 10.6, 2.8)}`,

  // NATI: a faísca de quatro pontas em losango, com o núcleo em Rosa e um satélite.
  nati: () => `
<path d="M12 3l1.9 7.1L21 12l-7.1 1.9L12 21l-1.9-7.1L3 12l7.1-1.9z"/>
${accent(12, 12, 3.6)}
${moduleOutline(19.5, 4.5, 2.8)}`,

  // Conexão com Outros Sistemas: a integração entre os dois lados, com o dado que passa no meio.
  'conexao-com-outros-sistemas': () => `
<path d="M8 6.5L2.5 12 8 17.5"/>
<path d="M16 6.5l5.5 5.5-5.5 5.5"/>
${accent(12, 12, 3.8)}`,

  // Infraestrutura e Segurança: o escudo com o dado protegido em módulo rosa.
  'infraestrutura-e-seguranca': () => `
<path d="M12 3l7 2.6v5.6c0 4.4-3 7.6-7 9.3-4-1.7-7-4.9-7-9.3V5.6z"/>
${accent(12, 10.6, 4.2)}
<path d="M12 12.7v3.3"/>`,
}

module.exports = icons
