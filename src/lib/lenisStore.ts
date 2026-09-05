import type Lenis from 'lenis'

/** Instância única do Lenis (quando ativo), acessível fora do React tree. */
export const lenisStore: { current: Lenis | null } = { current: null }
