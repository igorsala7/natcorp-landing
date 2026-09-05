import { m } from 'motion/react'
import type { Variants } from 'motion/react'
import { cn } from '@/lib/utils'
import { DUR, EASE, viewportOnce } from '@/lib/motion'

type Tag = 'h1' | 'h2' | 'h3' | 'p' | 'span' | 'div'

interface SplitTextProps {
  /** Texto; trechos entre [[ ]] recebem `highlightClassName`. */
  text: string
  as?: Tag
  className?: string
  highlightClassName?: string
  delay?: number
  stagger?: number
  /** 'inView' (padrão) anima ao entrar na tela; 'controlled' usa `visible`. */
  mode?: 'inView' | 'controlled'
  visible?: boolean
  id?: string
}

const tags = { h1: m.h1, h2: m.h2, h3: m.h3, p: m.p, span: m.span, div: m.div } as const

const word: Variants = {
  hidden: { y: '110%', opacity: 0 },
  visible: { y: '0%', opacity: 1, transition: { duration: DUR.scene, ease: EASE } },
}

interface Segment {
  text: string
  highlight: boolean
}

type Word = Segment[]

/** Quebra em palavras preservando trechos [[destacados]]; pontuação colada à palavra fica na mesma palavra. */
function tokenize(text: string): Word[] {
  const words: Word[] = []
  let current: Word = []
  let highlight = false
  let buffer = ''

  const flushSegment = () => {
    if (buffer) current.push({ text: buffer, highlight })
    buffer = ''
  }
  const flushWord = () => {
    flushSegment()
    if (current.length) words.push(current)
    current = []
  }

  for (let i = 0; i < text.length; i++) {
    const two = text.slice(i, i + 2)
    if (two === '[[') {
      flushSegment()
      highlight = true
      i++
      continue
    }
    if (two === ']]') {
      flushSegment()
      highlight = false
      i++
      continue
    }
    const ch = text[i]
    if (/\s/.test(ch)) {
      flushWord()
      continue
    }
    buffer += ch
  }
  flushWord()
  return words
}

/**
 * Revelação palavra a palavra com máscara (cada palavra sobe de dentro de um recorte).
 * O texto completo fica acessível via aria-label; as palavras animadas são decorativas.
 */
export function SplitText({
  text,
  as = 'h2',
  className,
  highlightClassName = 'text-brand-gradient',
  delay = 0,
  stagger = 0.045,
  mode = 'inView',
  visible = true,
  id,
}: SplitTextProps) {
  const Comp = tags[as]
  const tokens = tokenize(text)
  const plain = text.replace(/\[\[|\]\]/g, '')
  const container: Variants = {
    hidden: {},
    visible: { transition: { staggerChildren: stagger, delayChildren: delay } },
  }
  const controlled = mode === 'controlled'

  return (
    <Comp
      id={id}
      className={cn(className)}
      aria-label={plain}
      variants={container}
      initial="hidden"
      {...(controlled ? { animate: visible ? 'visible' : 'hidden' } : { whileInView: 'visible', viewport: viewportOnce })}
    >
      {tokens.map((w, i) => (
        <span key={i} aria-hidden>
          <span className="inline-block overflow-hidden align-bottom pb-[0.14em] -mb-[0.14em] pr-[0.02em]">
            <m.span variants={word} className="inline-block will-change-transform">
              {w.map((seg, j) => (
                <span key={j} className={cn(seg.highlight && highlightClassName)}>
                  {seg.text}
                </span>
              ))}
            </m.span>
          </span>
          {i < tokens.length - 1 ? ' ' : null}
        </span>
      ))}
    </Comp>
  )
}
