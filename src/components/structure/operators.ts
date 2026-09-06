import type { Operator } from '@/content/structures'

/** Ordem em que os operadores aparecem nas legendas: de quem pede a quem fecha. */
export const operatorOrder: Operator[] = ['gestores', 'rh-unidade', 'rh-central', 'nati']

/** Operadores presentes em uma lista de rotinas ou de entradas do fluxo, na ordem oficial. */
export const operatorsIn = (items: { by?: Operator; operator?: Operator }[]) =>
  operatorOrder.filter((op) => items.some((i) => (i.by ?? i.operator) === op))

/** Cor do operador a 12%, para o fundo das pílulas (mantém o texto em tinta, com contraste AA). */
export const operatorTint = (hex: string) => `${hex}1F`
