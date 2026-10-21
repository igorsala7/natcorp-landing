// Cria a pasta de um documento técnico novo, já com os modelos preenchidos.
//
// Uso (a partir da raiz do natcorp-landing):
//   node .claude/skills/documento-tecnico/toolkit/novo.mjs <slug> "<Título linha 1>" "<título linha 2>"
// Exemplo:
//   node .claude/skills/documento-tecnico/toolkit/novo.mjs folha-por-dentro "Folha de pagamento" "por dentro"
//
// Cria material-interno/documentos-tecnicos/<slug>/ (fora do git, como todo material-interno/).
import { mkdirSync, writeFileSync, existsSync, copyFileSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const toolkit = dirname(fileURLToPath(import.meta.url));
const [slug, l1, l2 = ''] = process.argv.slice(2);
if (!slug || !l1) { console.error('Uso: node novo.mjs <slug> "<Título linha 1>" "<título linha 2>"'); process.exit(1); }
const doc = join(process.cwd(), 'material-interno', 'documentos-tecnicos', slug);
if (existsSync(doc)) { console.error('Já existe:', doc); process.exit(1); }
mkdirSync(join(doc, 'figuras'), { recursive: true });
mkdirSync(join(doc, 'fonte', 'raw'), { recursive: true });
mkdirSync(join(doc, 'assets'), { recursive: true });

const titulo = `${l1} ${l2}`.trim();
const meses = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
const hoje = new Date();
const data = `${meses[hoje.getMonth()][0].toUpperCase()}${meses[hoje.getMonth()].slice(1)} de ${hoje.getFullYear()}`;

writeFileSync(join(doc, 'documento.config.mjs'), `// Configuração do documento "${titulo}".
export default {
  titulo: 'Natcorp · ${titulo}',
  arquivoPdf: 'Natcorp - ${titulo}.pdf',
  rodape: 'NATCORP  ·  ${titulo.toUpperCase()}',
  capa: {
    olho: 'Documento técnico · Para TI e Segurança da Informação',
    titulo: ['${l1}', '${l2}'],
    // marcaProduto: 'natponto-marca.svg',   // SVG em assets/, aparece acima do título
    data: '${data}',
    tipo: 'Documento informativo',
  },
  contracapa: { nome: '${titulo}', sub: 'Plataforma Natcorp de gestão de RH' },
  // Ícones dos cartões ("### Título" dentro de ::: cards), por palavra do título. Nomes em referencia/figuras.md.
  icones: [
    // ['palavra do título', 'cadeado'],
  ],
  // Larguras das colunas por cabeçalho exato da tabela: 'Col1|Col2|Col3': [30, 40, 30]
  larguras: {},
  // 'nome.svg': 'fig_nome.mjs' (arquivos em figuras/)
  figuras: {
    'exemplo.svg': 'fig_exemplo.mjs',
  },
  ajustes: {
    figuras: { exemplo: { largura: '84%' } },   // pagina: true abre a figura em página nova
    quebras: [],                                // { cap: 4, antes: 'Título do ##' } força página nova
    trocas: [],                                 // [trecho do HTML, substituto] (último recurso)
  },
};
`);

writeFileSync(join(doc, 'conteudo.md'), `::: capitulo 0 | Capa | Subtítulo da capa, uma linha que diz do que o documento trata

Parágrafo de abertura: para quem é o documento e que perguntas ele responde.

## Como ler este documento

::: cards
### Para quem é
Quem vai ler e o que precisa saber antes.

### De onde vêm as informações
As fontes: política, site, documentação técnica.

### Você sabia?
Os quadros com este título trazem um detalhe prático.
:::

::: capitulo 1 | Em 1 minuto | O essencial, em cartões

Primeiro parágrafo do capítulo (vira o lead, em destaque).

::: cards
### Primeiro cartão
Texto do cartão.

### Segundo cartão
Texto do cartão.
:::

::: figura exemplo | Legenda da figura, sem ponto final

::: capitulo 2 | Consulta | Perguntas frequentes, glossário e contatos

| Termo | O que significa |
|---|---|
| Exemplo | O glossário vira lista de definições em duas colunas |
`);

writeFileSync(join(doc, 'figuras', 'fig_exemplo.mjs'), `import { C, svg, t, r, icoCirculo, setPiso } from './lib.mjs';

// Figura de exemplo: copie o padrão de uma figura dos documentos existentes
// (material-interno/documentos-tecnicos/*/figuras/) e veja referencia/figuras.md.
export default function exemplo() {
  setPiso(10.3); // piso de fonte conforme a largura impressa (84% → ~10,3)
  const W = 680, H = 120;
  let s = r(4, 4, W - 8, H - 8, { rx: 14, fill: C.m050, stroke: C.m200 });
  s += icoCirculo('escudo', 50, H / 2, 22, { fill: C.marca, cor: '#fff' });
  s += t(86, H / 2 - 4, 'Título da figura', { cls: 'ig-h', size: 16 });
  s += t(86, H / 2 + 16, 'Texto de apoio', { cls: 'ig-s' });
  return svg({ w: W, h: H, id: 'ex', titulo: 'Figura de exemplo', desc: 'Descrição completa para leitor de tela.', corpo: s });
}
`);

copyFileSync(join(toolkit, '..', 'referencia', 'modelo-briefing.md'), join(doc, 'fonte', '00_briefing.md'));
copyFileSync(join(toolkit, '..', 'referencia', 'modelo-interno.md'), join(doc, 'INTERNO - NAO ENVIAR - lacunas e divergencias.md'));
console.log('Documento criado em', doc);
console.log('Gerar: node .claude/skills/documento-tecnico/toolkit/gerar.mjs', join('material-interno', 'documentos-tecnicos', slug));
