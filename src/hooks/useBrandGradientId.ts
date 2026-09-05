import { useId } from 'react'

/** Id único e válido em `url(#…)` para o gradiente da marca em SVGs inline. */
export function useBrandGradientId() {
  const raw = useId()
  return `natcorp-grad-${raw.replace(/[^a-zA-Z0-9]/g, '')}`
}
