import { Fragment, type ReactNode, useCallback, useEffect, useState } from 'react'
import { AlertTriangle, Check, Copy, RotateCcw } from 'lucide-react'
import type { Block } from '@/lib/docMarkdown'
import { cn } from '@/lib/utils'

/* ── Texto ─────────────────────────────────────────────────────────────────── */

/**
 * Negrito, itálico, `código` e links do Markdown viram JSX.
 *
 * O regex casa as formas de uma vez e o laço fatia o que sobra, para não depender
 * da ordem em que aparecem na frase. `**` vem antes de `*` na alternância, senão
 * um negrito seria lido como itálico vazio.
 *
 * Negrito e itálico chamam `Inline` de novo no conteúdo: o documento tem
 * **`código` dentro de negrito**, e sem a recursão as crases apareceriam na tela.
 */
const INLINE = /(\*\*[^*]+\*\*|\*[^*]+\*|`[^`]+`|\[[^\]]+\]\([^)]+\))/g

export function Inline({ text }: { text: string }) {
  const parts = text.split(INLINE).filter(Boolean)
  return (
    <>
      {parts.map((part, index) => {
        const key = `${index}-${part.slice(0, 12)}`
        if (part.startsWith('**') && part.endsWith('**')) {
          return (
            <strong key={key} className="font-bold text-brand-ink">
              <Inline text={part.slice(2, -2)} />
            </strong>
          )
        }
        if (part.startsWith('*') && part.endsWith('*')) {
          return (
            <em key={key} className="italic">
              <Inline text={part.slice(1, -1)} />
            </em>
          )
        }
        if (part.startsWith('`') && part.endsWith('`')) {
          return (
            <code key={key} className="break-words rounded-[5px] bg-brand-off-white px-1.5 py-0.5 font-mono text-[0.86em] text-brand-purple ring-1 ring-inset ring-brand-mist">
              {part.slice(1, -1)}
            </code>
          )
        }
        const link = /^\[([^\]]+)\]\(([^)]+)\)$/.exec(part)
        if (link) {
          return (
            <a key={key} href={link[2]} className="font-semibold text-brand-purple underline underline-offset-2 hover:text-brand-purple-hover" rel="noreferrer noopener" target="_blank">
              {link[1]}
            </a>
          )
        }
        return <Fragment key={key}>{part}</Fragment>
      })}
    </>
  )
}

/* ── Código ────────────────────────────────────────────────────────────────── */

const LANG_LABEL: Record<string, string> = {
  apache: 'Apache · .htaccess',
  nginx: 'Nginx',
  xml: 'IIS · web.config',
  bash: 'Terminal',
  json: 'JSON',
  '': 'Texto',
}

/**
 * Bloco de código com botão de copiar.
 *
 * É a razão principal de a documentação virar página: o time de hospedagem copia
 * o `.htaccess` inteiro em um clique, em vez de selecionar 40 linhas de um PDF e
 * arrastar espaço em branco junto.
 */
export function CodeBlock({ code, lang }: { code: string; lang: string }) {
  const [copied, setCopied] = useState(false)

  useEffect(() => {
    if (!copied) return
    const t = window.setTimeout(() => setCopied(false), 2000)
    return () => window.clearTimeout(t)
  }, [copied])

  /**
   * Copiar sem depender de contexto seguro.
   *
   * `navigator.clipboard` só existe em https e em localhost. O arquivo autônomo
   * `HOSPEDAGEM.html` é aberto de `file://`, onde ela simplesmente não está lá —
   * e é justamente ali que o botão mais importa, porque é o arquivo que a
   * hospedagem recebe. Daí o caminho antigo (`execCommand`) como reserva: feio,
   * obsoleto, mas é o que funciona fora de https.
   */
  const copy = useCallback(async () => {
    try {
      if (navigator.clipboard?.writeText) {
        await navigator.clipboard.writeText(code)
        setCopied(true)
        return
      }
    } catch {
      /* Negada ou indisponível: cai na reserva abaixo. */
    }

    const area = document.createElement('textarea')
    area.value = code
    // Fora da vista e sem rolar a página ao receber o foco.
    area.setAttribute('readonly', '')
    area.style.position = 'fixed'
    area.style.top = '0'
    area.style.opacity = '0'
    document.body.appendChild(area)
    area.select()
    try {
      setCopied(document.execCommand('copy'))
    } catch {
      /* Nem isso: o texto continua selecionável na tela, então não há o que avisar. */
    }
    document.body.removeChild(area)
  }, [code])

  return (
    <div className="group relative my-6 overflow-hidden rounded-2xl bg-brand-blue shadow-lift">
      <div className="flex items-center justify-between gap-3 border-b border-white/10 px-4 py-2.5">
        <span className="font-mono text-[11.5px] font-semibold uppercase tracking-[0.1em] text-white/55">{LANG_LABEL[lang] ?? lang}</span>
        <button
          type="button"
          onClick={copy}
          aria-label={copied ? 'Copiado' : 'Copiar o bloco de código'}
          className="inline-flex items-center gap-1.5 rounded-full bg-white/10 px-3 py-1.5 text-[12.5px] font-bold text-white/85 transition-colors hover:bg-white/20 hover:text-white focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-white print:hidden"
        >
          {copied ? <Check className="h-3.5 w-3.5" /> : <Copy className="h-3.5 w-3.5" />}
          {copied ? 'Copiado' : 'Copiar'}
        </button>
      </div>
      <pre className="overflow-x-auto px-4 py-4 text-[13px] leading-[1.65] text-white/90">
        <code className="font-mono">{code}</code>
      </pre>
    </div>
  )
}

/* ── Abas (Apache / Nginx / IIS) ───────────────────────────────────────────── */

/**
 * Cada servidor tem a sua configuração, e ninguém usa os três.
 *
 * Em papel as abas não existem, então na impressão tudo volta a aparecer
 * empilhado — o documento impresso não pode esconder duas das três opções.
 */
export function DocTabs({ tabs }: { tabs: { title: string; blocks: Block[] }[] }) {
  const [active, setActive] = useState(0)

  return (
    <div className="my-8">
      <div role="tablist" aria-label="Configuração por servidor" className="flex flex-wrap gap-2 print:hidden">
        {tabs.map((tab, index) => (
          <button
            key={tab.title}
            role="tab"
            type="button"
            aria-selected={active === index}
            onClick={() => setActive(index)}
            className={cn(
              'rounded-full px-4 py-2 text-[13.5px] font-bold transition-colors',
              active === index ? 'bg-brand-purple text-white' : 'bg-white text-brand-graphite ring-1 ring-brand-mist hover:bg-brand-off-white hover:text-brand-purple',
            )}
          >
            {/* Dentro da pílula não cabe `código` nem **negrito**: o rótulo é texto puro. */}
            {tab.title.replace(/^\d+(\.\d+)*\s+/, '').replace(/[`*]/g, '')}
          </button>
        ))}
      </div>

      {tabs.map((tab, index) => (
        <div key={tab.title} role="tabpanel" hidden={active !== index} className="print:!block">
          <h3 className="mt-6 text-[1.15rem] font-extrabold tracking-brand text-brand-ink print:mt-8">
            <Inline text={tab.title} />
          </h3>
          <Blocks blocks={tab.blocks} />
        </div>
      ))}
    </div>
  )
}

/* ── Checklist ─────────────────────────────────────────────────────────────── */

const STORAGE_KEY = 'natcorp:hospedagem:checklist'

function readChecked(): Record<string, boolean> {
  if (typeof window === 'undefined') return {}
  try {
    return JSON.parse(window.localStorage.getItem(STORAGE_KEY) ?? '{}') as Record<string, boolean>
  } catch {
    return {}
  }
}

/**
 * O checklist da seção 9 é para ser percorrido durante a virada, item a item,
 * possivelmente em duas sessões. Marcar no navegador e o progresso continuar ali
 * é a diferença entre uma lista de leitura e uma ferramenta de trabalho.
 *
 * Fica no navegador de quem marca: não vai para o servidor e ninguém mais vê.
 */
export function TaskList({ items }: { items: { id: string; text: string }[] }) {
  /* Lido já na primeira renderização: passar por um efeito faria as caixas
     piscarem de desmarcadas para marcadas ao voltar à página. */
  const [checked, setChecked] = useState<Record<string, boolean>>(readChecked)

  const toggle = (id: string) => {
    setChecked((prev) => {
      const next = { ...prev, [id]: !prev[id] }
      try {
        window.localStorage.setItem(STORAGE_KEY, JSON.stringify(next))
      } catch {
        /* navegação privada com armazenamento bloqueado: vale só nesta sessão */
      }
      return next
    })
  }

  const done = items.filter((item) => checked[item.id]).length

  return (
    <div className="my-5">
      {done > 0 && (
        <p className="mb-3 text-[13px] font-semibold text-brand-gray print:hidden">
          {done} de {items.length} verificados
        </p>
      )}
      <ul className="space-y-2.5">
        {items.map((item) => {
          const isDone = checked[item.id]
          return (
            <li key={item.id}>
              <label
                className={cn(
                  'flex cursor-pointer items-start gap-3 rounded-xl border p-3.5 transition-colors',
                  isDone ? 'border-brand-purple/25 bg-brand-purple/[0.04]' : 'border-brand-mist bg-white hover:border-brand-purple/30',
                )}
              >
                <input
                  type="checkbox"
                  checked={Boolean(isDone)}
                  onChange={() => toggle(item.id)}
                  className="mt-0.5 h-[18px] w-[18px] flex-none cursor-pointer accent-[#511C76]"
                />
                <span className={cn('min-w-0 text-[14.5px] leading-relaxed', isDone ? 'text-brand-gray line-through decoration-brand-gray/40' : 'text-brand-graphite')}>
                  <Inline text={item.text} />
                </span>
              </label>
            </li>
          )
        })}
      </ul>
    </div>
  )
}

/** Botão de recomeçar o checklist, no cabeçalho da página. */
export function ResetChecklist() {
  const [has] = useState(() => Object.values(readChecked()).some(Boolean))

  if (!has) return null

  return (
    <button
      type="button"
      onClick={() => {
        try {
          window.localStorage.removeItem(STORAGE_KEY)
        } catch {
          /* idem */
        }
        window.location.reload()
      }}
      className="inline-flex items-center gap-1.5 rounded-full px-3 py-2 text-[13px] font-semibold text-white/70 transition-colors hover:bg-white/10 hover:text-white"
    >
      <RotateCcw className="h-3.5 w-3.5" />
      Limpar checklist
    </button>
  )
}

/* ── Tabela e citação ──────────────────────────────────────────────────────── */

function DocTable({ head, rows }: { head: string[]; rows: string[][] }) {
  /* Uma tabela do documento abre com a coluna sem nome (`| |`): nesse caso o
     cabeçalho é decorativo e sai da leitura de tela. */
  const headless = head.every((cell) => !cell)

  return (
    <div className="my-6 overflow-x-auto rounded-2xl ring-1 ring-brand-mist">
      <table className="w-full min-w-[34rem] border-collapse bg-white text-left text-[14.5px]">
        {!headless && (
          <thead>
            <tr className="bg-brand-off-white">
              {head.map((cell) => (
                <th key={cell} scope="col" className="border-b border-brand-mist px-4 py-3 font-bold text-brand-ink">
                  <Inline text={cell} />
                </th>
              ))}
            </tr>
          </thead>
        )}
        <tbody>
          {rows.map((row, rowIndex) => (
            <tr key={row.join('|')} className={rowIndex % 2 ? 'bg-brand-off-white/45' : undefined}>
              {row.map((cell, cellIndex) => (
                <td key={`${cellIndex}-${cell.slice(0, 16)}`} className="border-b border-brand-mist/70 px-4 py-3 align-top leading-relaxed text-brand-graphite last:border-r-0">
                  <Inline text={cell} />
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}

/** Citação. Com ⚠️ no texto, vira aviso — é assim que o documento marca risco. */
function Quote({ text }: { text: string }) {
  const warning = text.includes('⚠️')
  const clean = text.replace('⚠️', '').trim()

  return (
    <div
      className={cn(
        'my-6 flex gap-3.5 rounded-2xl border-l-[3px] p-4 pl-4 text-[14.5px] leading-relaxed',
        warning ? 'border-brand-pink bg-brand-pink/[0.06] text-brand-graphite' : 'border-brand-purple/35 bg-brand-off-white text-brand-graphite',
      )}
    >
      {warning && <AlertTriangle className="mt-0.5 h-[18px] w-[18px] flex-none text-brand-pink" />}
      <p>
        <Inline text={clean} />
      </p>
    </div>
  )
}

/* ── Montagem ──────────────────────────────────────────────────────────────── */

/** `## 5. Configuração` → número e título separados, para o título respirar. */
function Heading({ block }: { block: Extract<Block, { type: 'heading' }> }) {
  const text = block.text

  /* O `#` do arquivo é o título do documento: abre a página, sem borda em cima. */
  if (block.level === 1) {
    return (
      <h1 id={block.id} className="scroll-mt-24 text-[2.1rem] font-extrabold leading-[1.1] tracking-brand text-brand-ink sm:text-[2.6rem]">
        <Inline text={text} />
      </h1>
    )
  }

  if (block.level === 2) {
    return (
      <h2 id={block.id} className="mt-16 scroll-mt-24 border-t border-brand-mist pt-10 text-[1.7rem] font-extrabold leading-tight tracking-brand text-brand-ink first:mt-0 first:border-0 first:pt-0 sm:text-[2rem]">
        {block.number && <span className="mb-2 block font-mono text-[13px] font-bold not-italic tracking-normal text-brand-pink">{block.number}</span>}
        <Inline text={text} />
      </h2>
    )
  }

  return (
    <h3 id={block.id} className="mt-11 scroll-mt-24 text-[1.2rem] font-extrabold leading-snug tracking-brand text-brand-ink">
      {block.number && <span className="mr-2 font-mono text-[0.85em] font-bold text-brand-purple/60">{block.number}</span>}
      <Inline text={text} />
    </h3>
  )
}

export function Blocks({ blocks }: { blocks: Block[] }): ReactNode {
  return (
    <>
      {blocks.map((block, index) => {
        const key = `${block.type}-${index}`
        switch (block.type) {
          case 'heading':
            return <Heading key={key} block={block} />
          case 'paragraph':
            return (
              <p key={key} className="mt-4 text-[15.5px] leading-[1.75] text-brand-graphite">
                <Inline text={block.text} />
              </p>
            )
          case 'code':
            return <CodeBlock key={key} code={block.code} lang={block.lang} />
          case 'table':
            return <DocTable key={key} head={block.head} rows={block.rows} />
          case 'quote':
            return <Quote key={key} text={block.text} />
          case 'tasks':
            return <TaskList key={key} items={block.items} />
          case 'tabs':
            return <DocTabs key={key} tabs={block.tabs} />
          case 'hr':
            /* No Markdown a régua separa seções; aqui quem separa é a borda do
               `##`, então ela vira só respiro. */
            return <div key={key} className="h-2" />
          case 'list':
            return block.ordered ? (
              <ol key={key} className="mt-4 space-y-2.5 text-[15.5px] leading-[1.75] text-brand-graphite">
                {block.items.map((item, itemIndex) => (
                  <li key={item.slice(0, 24)} className="flex gap-3">
                    <span className="mt-[3px] inline-flex h-[22px] w-[22px] flex-none items-center justify-center rounded-full bg-brand-purple/10 font-mono text-[12px] font-bold text-brand-purple">{itemIndex + 1}</span>
                    <span>
                      <Inline text={item} />
                    </span>
                  </li>
                ))}
              </ol>
            ) : (
              <ul key={key} className="mt-4 space-y-2.5 text-[15.5px] leading-[1.75] text-brand-graphite">
                {block.items.map((item) => (
                  <li key={item.slice(0, 24)} className="flex gap-3">
                    <span className="mt-[9px] h-[6px] w-[6px] flex-none rotate-45 rounded-[1px] bg-brand-purple/50" />
                    <span>
                      <Inline text={item} />
                    </span>
                  </li>
                ))}
              </ul>
            )
        }
      })}
    </>
  )
}
