import { useEffect, useRef, useState } from 'react'
import { useInView, useReducedMotion } from 'motion/react'

interface TypedTextProps {
  text: string
  /** Milissegundos por caractere. */
  speed?: number
  delay?: number
  className?: string
}

/** Texto que aparece como se estivesse sendo digitado, uma vez, ao entrar na viewport. */
export function TypedText({ text, speed = 28, delay = 300, className }: TypedTextProps) {
  const ref = useRef<HTMLSpanElement>(null)
  const inView = useInView(ref, { once: true, margin: '0px 0px -15% 0px' })
  const reduced = useReducedMotion()
  const [count, setCount] = useState(0)
  const done = reduced || count >= text.length

  useEffect(() => {
    if (!inView || reduced) return
    let i = 0
    let timer = 0
    const start = window.setTimeout(() => {
      timer = window.setInterval(() => {
        i += 1
        setCount(i)
        if (i >= text.length) window.clearInterval(timer)
      }, speed)
    }, delay)
    return () => {
      window.clearTimeout(start)
      window.clearInterval(timer)
    }
  }, [inView, reduced, text, speed, delay])

  return (
    <span ref={ref} className={className}>
      <span className="sr-only">{text}</span>
      <span aria-hidden>{done ? text : text.slice(0, count)}</span>
      {!done && <span aria-hidden className="ml-0.5 inline-block h-[0.9em] w-[2px] translate-y-[0.12em] animate-pulse-soft bg-current" />}
    </span>
  )
}
