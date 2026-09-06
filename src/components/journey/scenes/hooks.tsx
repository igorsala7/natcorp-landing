import { useEffect, useId, useState } from 'react'

/* Hooks das cenas montadas por camadas (separados das peças visuais por causa do Fast Refresh). */

/**
 * Fases da cena, disparadas por tempo depois que o palco entra na tela.
 * `ms[i]` é quando a fase i começa. Com movimento reduzido, a cena vai direto à última fase.
 */
export function useScenePhases(on: boolean, reduced: boolean, ms: number[]): number {
  const last = ms.length - 1
  const [phase, setPhase] = useState(reduced ? last : 0)
  useEffect(() => {
    if (!on || reduced) return
    const timers = ms.map((t, i) => window.setTimeout(() => setPhase(i), t))
    return () => timers.forEach((t) => window.clearTimeout(t))
  }, [on, reduced, ms])
  return reduced ? last : phase
}

/** Gradiente de inox para máquinas e bancadas. Use `fill={steel}` com o id devolvido. */
export function useSteel() {
  const id = useId().replace(/[^a-zA-Z0-9]/g, '')
  const defs = (
    <defs>
      <linearGradient id={`${id}-steel`} x1="0" y1="0" x2="0" y2="1">
        <stop offset="0" stopColor="#DAD5E4" />
        <stop offset="0.5" stopColor="#C7C0D5" />
        <stop offset="1" stopColor="#B3ABC4" />
      </linearGradient>
    </defs>
  )
  return { defs, fill: `url(#${id}-steel)` }
}
