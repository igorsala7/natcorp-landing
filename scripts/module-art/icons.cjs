/**
 * Glifos dos ícones de módulo, na grade de 24 (traço branco fino, pontas redondas, muito ar).
 * Cada glifo é uma marca mínima e própria do módulo, como um produto: poucas linhas, geometria limpa,
 * sem preenchimentos pesados. Assinatura: (k) => string SVG interna; k é o kit (moduleOutline, dot, rr...).
 */
const { moduleOutline, dot, rr } = require('./kit.cjs')

/** Doze marcas de relógio entre os raios r0 e r1 (o mostrador do NatPonto). */
function ticks(cx, cy, r0, r1, n = 12) {
  const out = []
  for (let i = 0; i < n; i++) {
    const a = (i / n) * Math.PI * 2
    const x0 = +(cx + Math.sin(a) * r0).toFixed(2)
    const y0 = +(cy - Math.cos(a) * r0).toFixed(2)
    const x1 = +(cx + Math.sin(a) * r1).toFixed(2)
    const y1 = +(cy - Math.cos(a) * r1).toFixed(2)
    out.push(`<path d="M${x0} ${y0}L${x1} ${y1}"/>`)
  }
  return out.join('\n')
}
/** Pessoa mínima: cabeça e ombros. */
function person(cx, cy, s = 1) {
  return `<circle cx="${cx}" cy="${+(cy - 2.6 * s).toFixed(2)}" r="${+(2.1 * s).toFixed(2)}"/>
<path d="M${+(cx - 4.2 * s).toFixed(2)} ${+(cy + 4.4 * s).toFixed(2)}a${+(4.2 * s).toFixed(2)} ${+(4.2 * s).toFixed(2)} 0 0 1 ${+(8.4 * s).toFixed(2)} 0"/>`
}

const icons = {
  // Folha de Pagamento: o holerite com a borda picotada e a linha do valor.
  'folha-de-pagamento': () => `
<path d="M6.5 3h11v17.5l-2.2-1.6-2.2 1.6-2.2-1.6-2.2 1.6-2.2-1.6z"/>
<path d="M9.5 8.5h5"/>
<path d="M9.5 12h3"/>
<path d="M12.5 15.5h2"/>`,

  // Administração de Pessoal: o quadro de posições, uma delas ainda aberta.
  'administracao-de-pessoal': () => `
${[6.5, 12, 17.5].map((y) => [6.5, 12, 17.5].map((x) => (x === 17.5 && y === 17.5 ? `<circle cx="${x}" cy="${y}" r="1.6"/>` : dot(x, y, 1.6))).join('')).join('\n')}`,

  // Cargos e Salários: três faixas salariais e o ponto do salário atual.
  'cargos-e-salarios': () => `
${rr(3.5, 10, 4.2, 10.5, 2.1)}
${rr(9.9, 3.5, 4.2, 17, 2.1)}
${rr(16.3, 7.5, 4.2, 13, 2.1)}
${dot(12, 11, 1.2)}`,

  // Gestão de Benefícios: o cartão do colaborador com o coração dos benefícios.
  'gestao-de-beneficios': () => `
<path d="M12 20.5c-4.5-3.3-8.5-6.4-8.5-10.6A4.4 4.4 0 0 1 12 7.6a4.4 4.4 0 0 1 8.5 2.3c0 4.2-4 7.3-8.5 10.6z"/>
${dot(12, 12.6, 1.1)}`,

  // NatPay: o celular com o Pix em forma de módulo.
  natpay: () => `
${rr(7, 2, 10, 20, 2.8)}
${moduleOutline(12, 11, 5.2)}
<path d="M10.5 18.5h3"/>`,

  // eSocial: ida e volta, envio e retorno, em uma só diagonal.
  esocial: () => `
<path d="M6 18L18 6"/>
<path d="M10.5 6H18v7.5"/>
<path d="M13.5 18H6v-7.5"/>`,

  // Jurídico Trabalhista: a balança em poucas linhas.
  'juridico-trabalhista': () => `
<path d="M12 4v16.5"/><path d="M8 20.5h8"/>
<path d="M4.5 7.5h15"/>
<path d="M4.5 7.5v5.5"/><path d="M19.5 7.5v5.5"/>
<path d="M2 13.5a2.5 2.5 0 0 0 5 0"/>
<path d="M17 13.5a2.5 2.5 0 0 0 5 0"/>`,

  // Ponto Eletrônico: o mostrador aberto, com as horas que se acumulam.
  'ponto-eletronico': () => `
<path d="M12 3.5a8.5 8.5 0 1 0 8.5 8.5"/>
<path d="M18.2 14.2L20.5 12l2.3 2.3"/>
<path d="M12 12V7.3"/><path d="M12 12l3.4 1.9"/>`,

  // NatPonto: o mostrador de doze marcas e os ponteiros em L (referência aprovada).
  natponto: () => `
${ticks(12, 12, 9.6, 12)}
<path d="M12 12V5.4"/><path d="M12 12h6.6"/>`,

  // Medicina Ocupacional: a prancheta do ASO com a cruz.
  'medicina-ocupacional': () => `
${rr(5, 4, 14, 17, 2.6)}
<path d="M9.5 4V3a1 1 0 0 1 1-1h3a1 1 0 0 1 1 1v1"/>
<path d="M12 9.5v6"/><path d="M9 12.5h6"/>`,

  // Segurança do Trabalho: o capacete.
  'seguranca-do-trabalho': () => `
<path d="M3 16.5h18"/>
<path d="M6 16.5v-2.5a6 6 0 0 1 12 0v2.5"/>
<path d="M12 8v3"/>`,

  // Recrutamento e Seleção: a pessoa certa dentro da lupa.
  'recrutamento-e-selecao': () => `
<circle cx="10.5" cy="10.5" r="7.5"/>
${person(10.5, 11, 0.85)}
<path d="M16 16l5 5"/>`,

  // Quadro de Vagas: o mural com as vagas publicadas.
  'quadro-de-vagas': () => `
${rr(3, 7.5, 18, 12.5, 2.6)}
<path d="M9 7.5V6a1.5 1.5 0 0 1 1.5-1.5h3A1.5 1.5 0 0 1 15 6v1.5"/>
<path d="M3 12.5h18"/>
${dot(12, 12.5, 1)}`,

  // Admissão Digital: o documento já conferido.
  'admissao-digital': () => `
<path d="M7 3h7.5l4 4v12.5a1.5 1.5 0 0 1-1.5 1.5H8.5A1.5 1.5 0 0 1 7 19.5V4.5A1.5 1.5 0 0 1 8.5 3"/>
<path d="M14.5 3v4h4"/>
<path d="M9.5 14l2 2 4-4.5"/>`,

  // Onboarding: a porta aberta e a entrada.
  onboarding: () => `
<path d="M5 21V4.5a1.5 1.5 0 0 1 1.5-1.5h6A1.5 1.5 0 0 1 14 4.5V21"/>
<path d="M2.5 21h19"/>
<path d="M21.5 12h-7"/><path d="M17 9.5L14.5 12l2.5 2.5"/>
${dot(11.3, 12.5, 0.8)}`,

  // Offboarding: a mesma porta, a saída resolvida.
  offboarding: () => `
<path d="M5 21V4.5a1.5 1.5 0 0 1 1.5-1.5h6A1.5 1.5 0 0 1 14 4.5V21"/>
<path d="M2.5 21h19"/>
<path d="M11 12h10.5"/><path d="M19 9.5l2.5 2.5-2.5 2.5"/>
${dot(11.3, 12.5, 0.8)}`,

  // Avaliações, Pesquisas e Feedbacks: a volta completa em torno da pessoa.
  'avaliacoes-e-feedbacks': () => `
<path d="M4 12A8 8 0 1 1 16 18.93"/>
<path d="M13.6 19.8l2.6-.9-.9-2.6"/>
${person(12, 12.4, 0.85)}`,

  // Metas e Resultados: o alvo feito de módulos.
  'metas-e-resultados': () => `
${moduleOutline(12, 12, 18)}
${moduleOutline(12, 12, 10.5)}
${dot(12, 12, 1.5)}`,

  // Treinamento e Desenvolvimento: o capelo.
  'treinamento-e-desenvolvimento': () => `
<path d="M2.5 9.5L12 5l9.5 4.5L12 14z"/>
<path d="M7 12v3.5c0 1.4 2.2 2.5 5 2.5s5-1.1 5-2.5V12"/>
<path d="M21.5 9.5v4"/>`,

  // Carreira e Sucessão: a escada que sobe.
  'carreira-e-sucessao': () => `
<path d="M3 20.5h4.5V15H12V9.5h4.5V4H21"/>
${dot(21, 4, 1)}`,

  // Portais: o arco de entrada.
  portais: () => `
<path d="M5 21V11.5a7 7 0 0 1 14 0V21"/>
<path d="M2.5 21h19"/>
${dot(12, 14.5, 1)}`,

  // Requisições com Workflow: o pedido passa de módulo em módulo até ser efetivado.
  'requisicoes-com-workflow': () => `
${moduleOutline(4.5, 12, 5)}
<path d="M7 12h2.5"/>
${moduleOutline(12, 12, 5)}
<path d="M14.5 12H17"/>
${moduleOutline(19.5, 12, 5)}
${dot(19.5, 12, 1)}`,

  // Chamado Interno: a conversa em andamento.
  'chamado-interno': () => `
<path d="M3.5 6a2 2 0 0 1 2-2h13a2 2 0 0 1 2 2v9a2 2 0 0 1-2 2h-7.5L6 20.5V17H5.5a2 2 0 0 1-2-2z"/>
${dot(8.5, 10.5, 0.9)}${dot(12, 10.5, 0.9)}${dot(15.5, 10.5, 0.9)}`,

  // Blog Corporativo: o post da intranet.
  'blog-corporativo': () => `
<path d="M3 10.5v3a1.5 1.5 0 0 0 1.5 1.5H8l7.5 4.5v-15L8 9H4.5A1.5 1.5 0 0 0 3 10.5z"/>
<path d="M18.5 9.2a4 4 0 0 1 0 5.6"/>
<path d="M8 15v4"/>`,

  // Assinatura Eletrônica: a assinatura sobre a linha.
  'assinatura-eletronica': () => `
<path d="M3 16c1.5-4 3-5 4-2.5s2 5.5 3.5.5 2.5-5 4-2 2.5 3.5 4.5 2"/>
<path d="M3 20h18"/>`,

  // GED: a pasta com o documento guardado.
  ged: () => `
<path d="M3 7.5a2 2 0 0 1 2-2h4.5l2 2.5H19a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
<path d="M3 11h18"/>`,

  // People Analytics: os cruzamentos como pontos sobre os eixos.
  'people-analytics': () => `
<path d="M4 3.5V20h16.5"/>
${dot(8, 15.5, 1.3)}${dot(11.5, 10, 1.3)}${dot(15, 12.5, 1.3)}${dot(18.5, 6.5, 1.3)}`,

  // Business Intelligence: as barras que sobem.
  'business-intelligence': () => `
<path d="M6.5 20v-6"/><path d="M12 20V6"/><path d="M17.5 20v-9.5"/>
<path d="M3 20h18"/>`,

  // NATI: a faísca de quatro pontas, e uma menor ao lado.
  nati: () => `
<path d="M12 3l1.6 7.4L21 12l-7.4 1.6L12 21l-1.6-7.4L3 12l7.4-1.6z"/>
<path d="M19.5 3l.6 2 2 .6-2 .6-.6 2-.6-2-2-.6 2-.6z"/>`,

  // Conexão com Outros Sistemas: dois sistemas ligados.
  'conexao-com-outros-sistemas': () => `
${moduleOutline(5.5, 12, 6.5)}
${moduleOutline(18.5, 12, 6.5)}
<path d="M8.75 12h6.5"/>`,

  // Infraestrutura e Segurança: a nuvem com o cadeado.
  'infraestrutura-e-seguranca': () => `
<path d="M7 18.5h10a4 4 0 0 0 .6-7.95A5.5 5.5 0 0 0 7 12.2 3.2 3.2 0 0 0 7 18.5z"/>
${rr(10, 12, 4, 3.4, 0.9)}
<path d="M10.8 12v-1.2a1.2 1.2 0 0 1 2.4 0V12"/>`,
}

module.exports = icons
