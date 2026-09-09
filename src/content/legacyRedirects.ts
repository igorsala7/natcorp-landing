/**
 * Endereços do site institucional antigo (WordPress) e para onde cada um passa a apontar.
 *
 * POR QUE ISTO EXISTE
 *
 * O site antigo não tinha só as páginas de produto: tinha ~90 artigos publicados na raiz,
 * no padrão de permalink do WordPress (`/titulo-do-artigo/`, sem prefixo `/blog/`). Eles
 * estão indexados, recebem links de fora e respondem por buscas que interessam — eSocial,
 * FGTS Digital, NR, folha de pagamento, ponto eletrônico.
 *
 * Sem regra, cada um deles vira 404 no dia da virada, e o Google descarta a autoridade que
 * levaram anos para juntar. Com 301, essa autoridade é transferida para a página nova que
 * trata do mesmo assunto.
 *
 * A REGRA QUE GUIOU O MAPEAMENTO
 *
 * Cada endereço aponta para a página que fala do MESMO assunto — nunca para a home. Um 301
 * em massa para a raiz é lido pelo Google como soft-404: ele descarta o endereço antigo em
 * vez de transferir o valor dele. É por isso que "/erros-comuns-na-folha-de-pagamento/" vai
 * para o módulo de folha, e não para "/".
 *
 * QUANDO O BLOG VOLTAR
 *
 * As entradas marcadas com `republicar: true` são artigos que valem mais republicados do que
 * redirecionados: eles atendem buscas informativas que o site novo não cobre com nenhuma
 * página. Enquanto não existirem, o 301 temático segura o valor. Ao republicar, troque o
 * destino para o endereço novo do artigo — o 301 continua válido, só muda para onde aponta.
 *
 * Este arquivo é a ÚNICA fonte: `scripts/generate-redirects.mjs` gera a partir dele o
 * `public/_redirects`, os redirects do `vercel.json` e os blocos de Apache, Nginx e IIS.
 */

export interface LegacyRedirect {
  /** Caminho antigo, sem barra final. A barra final é tratada na geração. */
  from: string
  /** Caminho novo. */
  to: string
  /** Artigo que merece ser republicado no site novo em vez de só redirecionado. */
  republicar?: boolean
}

export const legacyRedirects: LegacyRedirect[] = [
  /* ── Páginas institucionais do site antigo ─────────────────────────────── */
  { from: '/solucao-de-rh', to: '/modulos' },
  { from: '/solucao-de-rh-old', to: '/modulos' },
  { from: '/solucao-de-rh/testefolha', to: '/modulos/folha-de-pagamento' },
  { from: '/sistema-de-rh-hcm', to: '/modulos' },
  { from: '/sistema-de-gestao-de-rh-completo', to: '/modulos' },
  { from: '/sistema-de-gestao-de-rh-completo-1', to: '/modulos' },
  { from: '/sistema-de-rh-completo-2-0', to: '/modulos' },
  { from: '/teste-nova-lp-sistema-completo', to: '/modulos' },
  { from: '/folha-de-pagamento', to: '/modulos/folha-de-pagamento' },
  { from: '/folha-de-pagamento1-0', to: '/modulos/folha-de-pagamento' },
  { from: '/folha-de-pagamento-2-0-2', to: '/modulos/folha-de-pagamento' },
  { from: '/folha-de-pagamento-2-1', to: '/modulos/folha-de-pagamento' },
  { from: '/folha-de-pagamento-teste-prototipo', to: '/modulos/folha-de-pagamento' },
  { from: '/sobre-nos', to: '/sobre' },
  { from: '/servicos', to: '/sobre#servicos' },
  { from: '/jobs', to: '/sobre' },
  { from: '/congerhi', to: '/sobre' },
  { from: '/fale-conosco', to: '/contato' },
  { from: '/fale-conosco-2', to: '/contato' },
  { from: '/agradecimento', to: '/contato' },
  { from: '/formulario-lgpd', to: '/contato' },
  { from: '/infrastructure', to: '/seguranca' },
  { from: '/oracle-cloud-natcorp', to: '/seguranca' },
  { from: '/carrossel', to: '/' },
  { from: '/landing-page', to: '/' },
  { from: '/1234-2', to: '/' },

  /* ── Índice e arquivos do blog ────────────────────────────────────────────
     Não há equivalente no site novo. Enquanto não houver, apontam para a visão
     geral do sistema, que é o assunto que reúne todos eles.                    */
  { from: '/blog', to: '/sistema' },
  { from: '/blog/2', to: '/sistema' },
  { from: '/blog/3', to: '/sistema' },
  { from: '/blog/4', to: '/sistema' },
  { from: '/blog/5', to: '/sistema' },
  { from: '/blog/6', to: '/sistema' },
  { from: '/blog/7', to: '/sistema' },
  { from: '/blog/8', to: '/sistema' },
  { from: '/blog/9', to: '/sistema' },
  { from: '/blog/10', to: '/sistema' },
  { from: '/category/gestao', to: '/sistema' },
  { from: '/category/gestao-estrategica', to: '/sistema' },
  { from: '/category/gestao-estrategica/page/2', to: '/sistema' },
  { from: '/category/gestao-estrategica/page/3', to: '/sistema' },
  { from: '/category/novidades', to: '/sistema' },
  { from: '/category/novidades/page/2', to: '/sistema' },
  { from: '/category/sistema', to: '/modulos' },
  { from: '/category/tributario', to: '/modulos/esocial' },
  { from: '/category/curiosidades', to: '/sistema' },
  { from: '/category/uncategorized', to: '/sistema' },

  /* ── eSocial, FGTS Digital, DIRF e obrigações ─────────────────────────────
     O conteúdo de conformidade é o que mais traz diretor de RH por busca.      */
  { from: '/atualizacao-do-esocial-natcorp', to: '/modulos/esocial', republicar: true },
  { from: '/saiba-mais-sobre-o-novo-esocial', to: '/modulos/esocial', republicar: true },
  { from: '/mudancas-no-esocial-a-partir-de-julho', to: '/modulos/esocial', republicar: true },
  { from: '/suspensao-do-evento-s-1200-no-esocial-o-que-isso-significa-para-sua-empresa', to: '/modulos/esocial', republicar: true },
  { from: '/esocial-corrige-calculo-da-contribuicao-patronal-veja-o-impacto', to: '/modulos/esocial', republicar: true },
  { from: '/dae-alteracao-no-vencimento-do-documento-de-arrecadacao-do-esocial', to: '/modulos/esocial', republicar: true },
  { from: '/entenda-a-nota-orientativa-fgts-digital', to: '/modulos/esocial', republicar: true },
  { from: '/fgts-digital-o-que-o-rh-precisa-saber-e-ficar-por-dentro-das-mudancas', to: '/modulos/esocial', republicar: true },
  { from: '/fique-por-dentro-multa-rescisoria-no-fgts-digital', to: '/modulos/esocial', republicar: true },
  { from: '/saque-do-fgts-no-rio-grande-do-sul-agora-esta-liberado', to: '/modulos/esocial' },
  { from: '/entenda-o-fim-da-dirf', to: '/modulos/esocial', republicar: true },
  { from: '/fim-da-dirf-veja-o-que-muda', to: '/modulos/esocial', republicar: true },
  { from: '/alteracoes-importantes-nas-normas-fiscais-entenda-o-que-mudou', to: '/modulos/esocial' },
  { from: '/legislacao-para-o-rh-2021-quais-as-principais-mudancas', to: '/modulos/esocial' },
  { from: '/news-lei-no14-151-21-afastamento-da-gestante', to: '/modulos/administracao-de-pessoal' },

  /* ── Folha de pagamento e remuneração ─────────────────────────────────── */
  { from: '/erros-comuns-na-folha-de-pagamento-e-como-evita-los', to: '/modulos/folha-de-pagamento', republicar: true },
  { from: '/os-beneficios-do-sistema-de-remuneracao-variavel', to: '/modulos/metas-e-resultados', republicar: true },
  { from: '/igualdade-salarial', to: '/modulos/cargos-e-salarios', republicar: true },
  { from: '/departamento-pessoal-e-recursos-humanos-voce-sabe-a-diferenca-entre-as-areas', to: '/modulos/administracao-de-pessoal', republicar: true },

  /* ── Ponto eletrônico e jornada ───────────────────────────────────────── */
  { from: '/ponto-eletronico-com-reconhecimento-facial-como-funciona', to: '/modulos/natponto', republicar: true },
  { from: '/escala-996', to: '/modulos/ponto-eletronico', republicar: true },
  { from: '/home-office-tudo-o-que-voce-precisa-saber', to: '/modulos/ponto-eletronico', republicar: true },
  { from: '/politica-de-home-office-como-implementar', to: '/modulos/ponto-eletronico', republicar: true },
  { from: '/quais-sao-as-vantagens-da-flexibilidade-no-trabalho', to: '/modulos/ponto-eletronico' },
  { from: '/o-modelo-de-trabalho-ideal-nao-e-remoto-nem-presencial-e-eficiente', to: '/modulos/ponto-eletronico' },
  { from: '/engajamento-e-gestao-de-times-remotos-o-novo-desafio-continuo', to: '/portais' },
  { from: '/reunioes-online-de-sucesso', to: '/portais' },

  /* ── Saúde, segurança do trabalho e NRs ───────────────────────────────── */
  { from: '/voce-sabe-o-que-muda-com-as-alteracoes-simplificacoes-das-normas-regulamentadoras-nrs', to: '/modulos/seguranca-do-trabalho', republicar: true },
  { from: '/empresas-terao-que-se-responsabilizar-pela-saude-mental-dos-colaboradores-a-partir-de-maio', to: '/modulos/medicina-ocupacional', republicar: true },
  { from: '/saude-mental-no-trabalho-como-o-software-de-rh-transforma-o-bem-estar-em-2026', to: '/modulos/medicina-ocupacional', republicar: true },
  { from: '/saude-mental-no-trabalho-em-2025-como-antecipar-mudancas-e-garantir-bem-estar-corporativo', to: '/modulos/medicina-ocupacional', republicar: true },
  { from: '/a-felicidade-no-trabalho', to: '/modulos/avaliacoes-e-feedbacks' },
  { from: '/estresse-e-solidao-no-rh', to: '/modulos/avaliacoes-e-feedbacks' },
  { from: '/sobrecarga-dos-profissionais-de-rh', to: '/modulos/nati' },

  /* ── Recrutamento, seleção e retenção ─────────────────────────────────── */
  { from: '/kpis-relevantes-para-a-area-de-recrutamento-e-selecao', to: '/modulos/recrutamento-e-selecao', republicar: true },
  { from: '/ghosting-no-recrutamento', to: '/modulos/recrutamento-e-selecao', republicar: true },
  { from: '/fit-cultural-sua-importancia-e-como-aplicar-este-conceito-no-rh', to: '/modulos/recrutamento-e-selecao', republicar: true },
  { from: '/futuro-da-contratacao-tendencias-2025', to: '/jornada-da-contratacao' },
  { from: '/como-reter-talentos-e-diminuir-turnover-da-sua-empresa', to: '/modulos/carreira-e-sucessao', republicar: true },

  /* ── Carreira, treinamento e desenvolvimento ──────────────────────────── */
  { from: '/a-importancia-do-plano-de-carreira', to: '/modulos/carreira-e-sucessao', republicar: true },
  { from: '/a-relevancia-do-treinamento-para-o-desenvolvimento-das-pessoas-nas-organizacoes', to: '/modulos/treinamento-e-desenvolvimento', republicar: true },
  { from: '/requalificar-ou-demitir-o-dilema-do-rh-na-era-da-eficiencia', to: '/modulos/treinamento-e-desenvolvimento' },

  /* ── Indicadores e People Analytics ───────────────────────────────────── */
  { from: '/indicadores-estrategicos-de-rh', to: '/modulos/people-analytics', republicar: true },
  { from: '/people-analytics-transforme-dados-em-estrategias-com-sistemas-de-rh', to: '/modulos/people-analytics', republicar: true },

  /* ── Inteligência artificial no RH ────────────────────────────────────── */
  { from: '/a-inteligencia-artificial-chegou-no-rh-com-a-natcorp', to: '/modulos/nati' },
  { from: '/como-a-ia-pode-melhorar-o-dia-a-dia-do-rh-mesmo-sem-ser-um-especialista-em-tecnologia', to: '/modulos/nati', republicar: true },
  { from: '/inteligencia-comportamental-o-diferencial-para-o-rh-em-2025', to: '/modulos/nati' },

  /* ── Assinatura eletrônica e documentos ───────────────────────────────── */
  { from: '/assinatura-eletronica-e-a-revolucao-no-rh-e-departamento-pessoal', to: '/modulos/assinatura-eletronica', republicar: true },

  /* ── Segurança da informação e LGPD ───────────────────────────────────── */
  { from: '/lgpd-como-funciona-a-nova-lei-e-como-adequar-sua-empresa-a-ela', to: '/seguranca', republicar: true },
  { from: '/seguranca-de-dados-no-rh-digital', to: '/seguranca', republicar: true },

  /* ── Tecnologia de RH e transformação digital ─────────────────────────── */
  { from: '/software-de-rh-em-2026', to: '/modulos', republicar: true },
  { from: '/quando-e-a-hora-de-trocar-seu-sistema-de-rh', to: '/perguntas-frequentes', republicar: true },
  { from: '/rh-na-era-da-transformacao-digital', to: '/sistema', republicar: true },
  { from: '/de-planilha-a-plataforma-os-estagios-da-transformacao-digital-no-rh', to: '/sistema', republicar: true },
  { from: '/como-a-tecnologia-pode-auxiliar-estrategicamente-o-rh', to: '/sistema' },
  { from: '/tecnologia-e-automacao-no-rh-nao-e-mais-questao-de-escolha', to: '/sistema' },
  { from: '/3-tendencias-em-automacao-de-rh-para-ficar-de-olho', to: '/sistema' },
  { from: '/por-que-a-area-de-rh-ainda-e-a-ultima-a-receber-tecnologia', to: '/sistema' },
  { from: '/estrategias-de-tecnologia-de-rh-focadas-em-capacidade-por-que-elas-falham', to: '/sistema' },
  { from: '/rh-4-0-transformando-a-gestao-de-recursos-humanos', to: '/sistema', republicar: true },
  { from: '/10-dicas-essenciais-para-otimizar-seu-rh', to: '/sistema' },

  /* ── Gestão, cultura e tendências ─────────────────────────────────────── */
  { from: '/o-futuro-do-rh-em-2025-principais-tendencias-e-estrategias', to: '/sistema' },
  { from: '/descubra-como-o-futuro-do-rh-esta-se-transformando', to: '/sistema' },
  { from: '/tendencias-para-o-rh-em-2020', to: '/sistema' },
  { from: '/novo-papel-do-gestor-de-rh', to: '/sistema' },
  { from: '/autonomia-do-rh-como-a-falta-de-espaco-para-decisoes-impacta-os-profissionais-e-como-mudar-esse-cenario', to: '/sistema' },
  { from: '/por-que-os-profissionais-de-rh-estao-pedindo-demissao', to: '/sistema' },
  { from: '/por-que-planejar-e-essencial-o-impacto-da-falta-de-planejamento-nas-empresas', to: '/sistema' },
  { from: '/o-estado-do-trabalho-global', to: '/sistema' },
  { from: '/60-dias-para-2024-quais-datas-o-rh-deve-levar-em-conta-no-planejamento', to: '/sistema' },
  { from: '/importante-datas-para-o-seu-rh-em-2024', to: '/sistema' },
  { from: '/dia-do-profissional-do-rh-entenda-a-historia-do-dia-3-de-junho-e-a-importancia-da-area', to: '/sobre' },

  /* ── Diversidade, gerações e experiência do colaborador ───────────────── */
  { from: '/a-importancia-da-diversidade-de-geracoes-no-ambiente-de-trabalho', to: '/modulos/avaliacoes-e-feedbacks' },
  { from: '/os-desafios-da-gestao-da-diversidade-no-trabalho', to: '/modulos/avaliacoes-e-feedbacks' },
  { from: '/a-geracao-z-chegou-a-lideranca-e-ja-esta-reclamando-da-propria-geracao', to: '/modulos/avaliacoes-e-feedbacks' },
  { from: '/geracao-z-caracteristicas-dilemas-e-impactos-no-mercado-de-trabalho', to: '/modulos/avaliacoes-e-feedbacks' },
  { from: '/employee-experience-o-que-e-suas-vantagens-e-como-aplica-lo', to: '/portais', republicar: true },

  /* ── Prêmios e reconhecimentos ────────────────────────────────────────── */
  { from: '/e-por-mais-um-ano-a-natcorp-e-indicada-ao-23o-top-of-mind-de-rh', to: '/sobre#reconhecimento' },
  { from: '/top-of-mind-de-rh-2019', to: '/sobre#reconhecimento' },

  /* ── Páginas legais ───────────────────────────────────────────────────────
     Existem no site antigo e ainda não no novo. Enquanto não existirem, apontam
     para a página de contato, onde estão os canais para pedido do titular (LGPD). */
  { from: '/privacidade', to: '/contato' },
  { from: '/politica-de-cookies', to: '/contato' },
  { from: '/termos-de-uso', to: '/contato' },
]
