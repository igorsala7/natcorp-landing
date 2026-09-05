import { createContext, useContext } from 'react'

export const IntroContext = createContext(true)

/** true quando a abertura terminou (ou não foi exibida) — usado para sincronizar o hero. */
export function useIntroDone() {
  return useContext(IntroContext)
}
