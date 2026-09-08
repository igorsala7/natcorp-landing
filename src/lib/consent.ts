/**
 * Consentimento de cookies.
 *
 * A regra que este módulo existe para cumprir: nada de rastreamento ANTES do
 * aceite. GTM e Meta Pixel só são carregados depois — não basta carregá-los e
 * "desligar" depois, porque a requisição em si já identifica o visitante.
 *
 * Guardamos em localStorage e não em cookie: a escolha é do navegador, não
 * precisa ir ao servidor, e um cookie para lembrar da recusa de cookies é uma
 * ironia que a LGPD tolera mas ninguém precisa.
 */

export type Consentimento = 'aceito' | 'recusado'

const CHAVE = 'natcorp:consentimento'
export const EVENTO = 'natcorp:consentimento-mudou'

/** Quanto tempo a escolha vale antes de perguntar de novo. */
const VALIDADE_DIAS = 180

interface Registro {
  valor: Consentimento
  em: number
}

function ler(): Registro | null {
  if (typeof window === 'undefined') return null
  try {
    const bruto = window.localStorage.getItem(CHAVE)
    if (!bruto) return null
    const r = JSON.parse(bruto) as Registro
    if (r.valor !== 'aceito' && r.valor !== 'recusado') return null
    // Escolha vencida volta a ser pergunta: consentimento não é para sempre.
    if (Date.now() - r.em > VALIDADE_DIAS * 864e5) return null
    return r
  } catch {
    return null
  }
}

export const consentimentoAtual = (): Consentimento | null => ler()?.valor ?? null

/** `null` = ainda não respondeu, e é por isso que a barra aparece. */
export function registrarConsentimento(valor: Consentimento) {
  try {
    window.localStorage.setItem(CHAVE, JSON.stringify({ valor, em: Date.now() } satisfies Registro))
  } catch {
    /* navegação privada com armazenamento bloqueado: a barra volta na próxima visita */
  }
  window.dispatchEvent(new CustomEvent<Consentimento>(EVENTO, { detail: valor }))
}

/** Reabre a pergunta — usado pelo link "Cookies" do rodapé. */
export function reabrirConsentimento() {
  try {
    window.localStorage.removeItem(CHAVE)
  } catch {
    /* idem */
  }
  window.dispatchEvent(new CustomEvent(EVENTO, { detail: null }))
}
