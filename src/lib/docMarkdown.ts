/**
 * Leitor do subconjunto de Markdown usado em HOSPEDAGEM.md.
 *
 * A página /hospedagem NÃO tem uma cópia do texto: ela lê o próprio arquivo que a
 * empresa de hospedagem recebe. Uma correção no `.md` aparece na página no build
 * seguinte, e as duas versões nunca divergem — que é o erro clássico de manter
 * documentação em dois lugares.
 *
 * Por isso o leitor é deliberadamente pequeno: cobre o que aquele arquivo usa e
 * nada além. Se um dia o documento precisar de algo novo (lista aninhada, imagem),
 * o lugar de resolver é aqui, e o parser avisa por não renderizar — não por
 * quebrar a página.
 */

export interface TableBlock {
  type: 'table'
  /** Cabeçalho vazio acontece: algumas tabelas do documento abrem com `| |`. */
  head: string[]
  rows: string[][]
}

export type Block =
  | { type: 'heading'; level: 1 | 2 | 3; text: string; id: string; number: string | null }
  | { type: 'paragraph'; text: string }
  | { type: 'code'; lang: string; code: string }
  | TableBlock
  | { type: 'quote'; text: string }
  | { type: 'list'; ordered: boolean; items: string[] }
  | { type: 'tasks'; items: { id: string; text: string }[] }
  | { type: 'hr' }
  | { type: 'tabs'; tabs: { title: string; blocks: Block[] }[] }

/**
 * Separa a numeração do título: `### 5.4 A pasta...` → `5.4` + `A pasta...`.
 *
 * O `\.?` existe porque o documento escreve as seções como `## 1. Resumo` e as
 * subseções como `### 5.1 SPA fallback` — com e sem ponto. Sem ele, só as
 * subseções ganhariam âncora numerada, e as duas metades do índice não
 * combinariam.
 *
 * O número vira âncora (`#s-5-4`), que é estável: reordenar ou reescrever um
 * título não quebra um link já compartilhado com a hospedagem.
 */
function splitNumber(text: string): { number: string | null; title: string } {
  const m = /^(\d+(?:\.\d+)*)\.?\s+(.*)$/.exec(text)
  return m ? { number: m[1], title: m[2].trim() } : { number: null, title: text }
}

function slug(text: string): string {
  return text
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/`[^`]*`/g, ' ')
    .replace(/\*\*/g, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '')
    .slice(0, 60)
}

/** Uma linha `| a | b |` vira `['a', 'b']`. */
function cells(line: string): string[] {
  return line
    .replace(/^\s*\|/, '')
    .replace(/\|\s*$/, '')
    .split('|')
    .map((c) => c.trim())
}

const isTableSeparator = (line: string) => /^\s*\|(\s*:?-{3,}:?\s*\|)+\s*$/.test(line)

export function parseMarkdown(source: string): Block[] {
  const lines = source.split('\n')
  const blocks: Block[] = []
  let i = 0
  /* Âncoras precisam ser únicas: dois títulos iguais não podem disputar o mesmo id. */
  const usedIds = new Set<string>()

  const pushHeading = (level: 1 | 2 | 3, raw: string) => {
    const { number, title } = splitNumber(raw)
    let id = number ? `s-${number.replace(/\./g, '-')}` : slug(title)
    let n = 2
    while (usedIds.has(id)) id = `${id}-${n++}`
    usedIds.add(id)
    // `text` já vem sem a numeração: quem renderiza não precisa fatiar string.
    blocks.push({ type: 'heading', level, text: title, id, number })
  }

  while (i < lines.length) {
    const line = lines[i]

    // Linha em branco: nada a fazer, o espaçamento é do layout.
    if (!line.trim()) {
      i++
      continue
    }

    // Bloco de código: tudo lá dentro é literal, inclusive `#`, `|` e `---`.
    const fence = /^```(\w*)\s*$/.exec(line)
    if (fence) {
      const lang = fence[1]
      const code: string[] = []
      i++
      while (i < lines.length && !/^```\s*$/.test(lines[i])) code.push(lines[i++])
      i++ // fecha a cerca
      blocks.push({ type: 'code', lang, code: code.join('\n') })
      continue
    }

    // Marcador de abas: agrupa os `###` seguintes até o fechamento.
    if (/^<!--\s*tabs\s*-->$/.test(line.trim())) {
      const inner: string[] = []
      i++
      while (i < lines.length && !/^<!--\s*\/tabs\s*-->$/.test(lines[i].trim())) inner.push(lines[i++])
      i++
      const parsed = parseMarkdown(inner.join('\n'))
      const tabs: { title: string; blocks: Block[] }[] = []
      for (const b of parsed) {
        if (b.type === 'heading' && b.level === 3) tabs.push({ title: b.text, blocks: [] })
        else if (tabs.length) tabs[tabs.length - 1].blocks.push(b)
      }
      if (tabs.length) blocks.push({ type: 'tabs', tabs })
      continue
    }

    const heading = /^(#{1,3})\s+(.*)$/.exec(line)
    if (heading) {
      pushHeading(heading[1].length as 1 | 2 | 3, heading[2].trim())
      i++
      continue
    }

    if (/^---+\s*$/.test(line)) {
      blocks.push({ type: 'hr' })
      i++
      continue
    }

    // Tabela: cabeçalho + separador + linhas.
    if (line.trim().startsWith('|') && isTableSeparator(lines[i + 1] ?? '')) {
      const head = cells(line)
      const rows: string[][] = []
      i += 2
      while (i < lines.length && lines[i].trim().startsWith('|')) rows.push(cells(lines[i++]))
      blocks.push({ type: 'table', head, rows })
      continue
    }

    // Citação: no documento é sempre de uma linha só, mas linhas seguidas se juntam.
    if (line.startsWith('> ')) {
      const parts: string[] = []
      while (i < lines.length && lines[i].startsWith('> ')) parts.push(lines[i++].slice(2))
      blocks.push({ type: 'quote', text: parts.join(' ') })
      continue
    }

    // Checklist: vira caixa marcável de verdade, e por isso precisa de id estável.
    if (/^- \[[ x]\]\s/.test(line)) {
      const items: { id: string; text: string }[] = []
      while (i < lines.length && /^- \[[ x]\]\s/.test(lines[i])) {
        const text = lines[i++].replace(/^- \[[ x]\]\s+/, '')
        items.push({ id: slug(text), text })
      }
      blocks.push({ type: 'tasks', items })
      continue
    }

    if (/^- \s*/.test(line) && line.startsWith('- ')) {
      const items: string[] = []
      while (i < lines.length && lines[i].startsWith('- ') && !/^- \[[ x]\]\s/.test(lines[i])) items.push(lines[i++].slice(2))
      blocks.push({ type: 'list', ordered: false, items })
      continue
    }

    if (/^\d+\.\s/.test(line)) {
      const items: string[] = []
      while (i < lines.length && /^\d+\.\s/.test(lines[i])) items.push(lines[i++].replace(/^\d+\.\s+/, ''))
      blocks.push({ type: 'list', ordered: true, items })
      continue
    }

    // Parágrafo: junta até a próxima linha em branco ou início de outro bloco.
    const parts: string[] = []
    while (i < lines.length && lines[i].trim() && !/^(#{1,3}\s|```|>\s|-\s|\d+\.\s|---+\s*$|\||<!--)/.test(lines[i])) {
      parts.push(lines[i++].trim())
    }
    if (parts.length) blocks.push({ type: 'paragraph', text: parts.join(' ') })
    else i++ // linha que nenhum caso reconheceu: segue adiante em vez de travar
  }

  return blocks
}

export interface TocEntry {
  id: string
  text: string
  number: string | null
  level: 2 | 3
}

/** Índice lateral: só `##` e `###`, que é a granularidade que a pessoa navega. */
export function buildToc(blocks: Block[]): TocEntry[] {
  return blocks
    .filter((b): b is Extract<Block, { type: 'heading' }> => b.type === 'heading' && b.level > 1)
    .map((b) => ({ id: b.id, text: b.text, number: b.number, level: b.level as 2 | 3 }))
}

/** Título do documento: o único `#` do arquivo. */
export function documentTitle(blocks: Block[]): string {
  const h1 = blocks.find((b) => b.type === 'heading' && b.level === 1)
  return h1 && h1.type === 'heading' ? h1.text : 'Documentação'
}
