# Referência visual: aplicação SaaS com a identidade Natcorp

`natcorp-app.html` é uma página única, sem dependências, que mostra como uma aplicação
Natcorp ficaria com a mesma identidade do site: menu lateral no gradiente da marca,
barra superior, fundo lavanda (sem cinza), cartões brancos com o raio e a sombra do site,
Manrope em tudo e o losango dos módulos como grafismo.

Telas (navegação pelo menu lateral, rotas com `#/`):

- `#/inicio`: boas-vindas com a análise do dia da NATI, indicadores, admissões e
  desligamentos, fila de aprovações, folha por centro de custo, colaboradores por
  unidade, absenteísmo e horas extras, atalhos dos módulos
- `#/colaboradores`: lista com filtros, situação e ponto do mês
- `#/cadastro`: admissão em etapas, com conferência da NATI e documentos
- `#/ponto`: marcações do dia, inconsistências com sugestão e o NatPonto no celular
- `#/relatorios`: filtros, custo da folha, rotatividade, painéis prontos e tabela
- `#/nati`: conversa com fontes, aprovação de ações e pontos de atenção

Dados fictícios (Vale Verde Alimentos, o grupo da jornada de contratação do site).
Cores de gráfico validadas para daltonismo: roxo `#6E3796` e rosa `#C95788`.
O logotipo e os ícones de módulo vêm de `src/components/brand/logo-paths.ts` e
`brand/modulos/icones/svg`.
