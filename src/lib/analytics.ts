import { consentimentoAtual, EVENTO, type Consentimento } from './consent'

/**
 * Carrega as tags de marketing — e só depois do aceite.
 *
 * Os IDs vêm de variáveis de ambiente. Sem ID, nada é carregado: assim um
 * ambiente de homologação não polui os dados de produção só por rodar o mesmo
 * código.
 *
 * Não há "descarregar": uma vez que o GTM entrou na página, ele fica até o
 * próximo carregamento. Por isso a recusa é respeitada ANTES, não depois.
 */

const GTM = import.meta.env.VITE_GTM_ID as string | undefined
const META_PIXEL = import.meta.env.VITE_META_PIXEL_ID as string | undefined

let carregado = false

function carregarGTM(id: string) {
  window.dataLayer = window.dataLayer ?? []
  window.dataLayer.push({ 'gtm.start': Date.now(), event: 'gtm.js' })
  const s = document.createElement('script')
  s.async = true
  s.src = `https://www.googletagmanager.com/gtm.js?id=${encodeURIComponent(id)}`
  document.head.appendChild(s)
}

function carregarMetaPixel(id: string) {
  /* Trecho oficial da Meta, reescrito legível: a versão minificada deles é a
     mesma coisa com nomes de uma letra. */
  const fbq: FbqFn = function (...args: unknown[]) {
    if (fbq.callMethod) fbq.callMethod(...args)
    else fbq.queue.push(args)
  } as FbqFn
  fbq.queue = []
  fbq.loaded = true
  fbq.version = '2.0'
  window.fbq = window.fbq ?? fbq
  window._fbq = window._fbq ?? fbq

  const s = document.createElement('script')
  s.async = true
  s.src = 'https://connect.facebook.net/en_US/fbevents.js'
  document.head.appendChild(s)

  window.fbq('init', id)
  window.fbq('track', 'PageView')
}

function ativar() {
  if (carregado) return
  carregado = true
  if (GTM) carregarGTM(GTM)
  if (META_PIXEL) carregarMetaPixel(META_PIXEL)
}

/** Liga o carregamento ao consentimento, agora e a cada mudança. */
export function iniciarAnalytics() {
  if (typeof window === 'undefined') return
  if (consentimentoAtual() === 'aceito') ativar()
  window.addEventListener(EVENTO, (e) => {
    if ((e as CustomEvent<Consentimento | null>).detail === 'aceito') ativar()
  })
}

interface FbqFn {
  (...args: unknown[]): void
  callMethod?: (...args: unknown[]) => void
  queue: unknown[][]
  loaded: boolean
  version: string
}

declare global {
  interface Window {
    dataLayer?: unknown[]
    fbq: FbqFn
    _fbq?: FbqFn
  }
}
