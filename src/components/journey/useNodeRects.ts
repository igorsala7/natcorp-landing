import { useCallback, useEffect, useMemo, useRef, useState } from 'react'

/** Caixa de um nó, em px, relativa ao contêiner medido. */
export interface NodeRect {
  x: number
  y: number
  w: number
  h: number
}

/**
 * Posição de layout do elemento em relação ao contêiner, somando os offsets
 * até chegar nele. Ignora transforms (as animações de entrada não deslocam a medida).
 */
function layoutRect(el: HTMLElement, container: HTMLElement): NodeRect {
  let x = 0
  let y = 0
  let node: HTMLElement | null = el
  while (node && node !== container) {
    x += node.offsetLeft
    y += node.offsetTop
    node = node.offsetParent as HTMLElement | null
  }
  if (node !== container) {
    // O contêiner não está na cadeia de offsetParent: cai para a diferença de bounding boxes.
    const c = container.getBoundingClientRect()
    const r = el.getBoundingClientRect()
    return { x: r.left - c.left, y: r.top - c.top, w: r.width, h: r.height }
  }
  return { x, y, w: el.offsetWidth, h: el.offsetHeight }
}

const sameRect = (a: NodeRect | null, b: NodeRect | null) =>
  a === b || (!!a && !!b && a.x === b.x && a.y === b.y && a.w === b.w && a.h === b.h)

/**
 * Mede `count` nós em relação a um contêiner e reage a mudanças de tamanho
 * (ResizeObserver no contêiner e em cada nó, mais o resize da janela e o carregamento das fontes).
 *
 * Uso: `const { containerRef, setNodeRef, rects } = useNodeRects<HTMLLIElement>(25)`;
 * `ref={containerRef}` no contêiner (precisa ser `position: relative`) e `ref={setNodeRef(i)}` em cada nó.
 */
export function useNodeRects<T extends HTMLElement = HTMLElement>(count: number) {
  const containerRef = useRef<HTMLDivElement | null>(null)
  const nodesRef = useRef<(T | null)[]>([])
  const observerRef = useRef<ResizeObserver | null>(null)
  const [rects, setRects] = useState<(NodeRect | null)[]>([])

  const measure = useCallback(() => {
    const container = containerRef.current
    if (!container) return
    const next: (NodeRect | null)[] = []
    for (let i = 0; i < count; i++) {
      const el = nodesRef.current[i]
      next.push(el ? layoutRect(el, container) : null)
    }
    setRects((prev) => {
      if (prev.length === next.length && prev.every((r, i) => sameRect(r, next[i]))) return prev
      return next
    })
  }, [count])

  /** Callbacks de ref estáveis por índice, para não reanexar a cada render. */
  const refCallbacks = useMemo(
    () =>
      Array.from({ length: count }, (_, i) => (el: T | null) => {
        const prev = nodesRef.current[i]
        if (prev && prev !== el) observerRef.current?.unobserve(prev)
        nodesRef.current[i] = el
        if (el) observerRef.current?.observe(el)
      }),
    [count],
  )

  const setNodeRef = useCallback((i: number) => refCallbacks[i], [refCallbacks])

  useEffect(() => {
    const container = containerRef.current
    if (!container) return
    const ro = new ResizeObserver(() => measure())
    observerRef.current = ro
    ro.observe(container)
    for (const el of nodesRef.current) if (el) ro.observe(el)

    window.addEventListener('resize', measure)
    // Fontes carregadas depois do primeiro layout mudam a altura dos cartões.
    let cancelled = false
    document.fonts?.ready.then(() => {
      if (!cancelled) measure()
    })
    measure()

    return () => {
      cancelled = true
      window.removeEventListener('resize', measure)
      ro.disconnect()
      observerRef.current = null
    }
  }, [measure])

  return { containerRef, setNodeRef, rects }
}
