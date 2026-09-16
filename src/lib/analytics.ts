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

/* As tags CONTRATADAS têm o ID embutido; as não contratadas, não.
   Não existe .env neste projeto, então variável vazia significa "nunca
   carrega". Para o GTM isso é o certo — não está contratado. Para o GA4 e o
   Pixel da Meta seria uma tag que o cliente pediu e que nunca subiria, sem erro
   em lugar nenhum: a falha silenciosa que já custou dias aqui.

   A variável continua valendo e VENCE o padrão: um ID diferente troca de
   propriedade, string vazia desliga. */
const comPadrao = (v: string | undefined, padrao: string) => (v === undefined ? padrao : v).trim()

const GA4 = comPadrao(import.meta.env.VITE_GA4_ID as string | undefined, 'G-BBE99E2LWM')
const META_PIXEL = comPadrao(import.meta.env.VITE_META_PIXEL_ID as string | undefined, '856605322636853')
const GTM = import.meta.env.VITE_GTM_ID as string | undefined

let carregado = false

function carregarGTM(id: string) {
  window.dataLayer = window.dataLayer ?? []
  window.dataLayer.push({ 'gtm.start': Date.now(), event: 'gtm.js' })
  const s = document.createElement('script')
  s.async = true
  s.src = `https://www.googletagmanager.com/gtm.js?id=${encodeURIComponent(id)}`
  document.head.appendChild(s)
}

/**
 * Google Analytics 4.
 *
 * `G-XXXXXXX` é Measurement ID do GA4 e NÃO é contêiner do GTM (`GTM-XXXXXXX`):
 * são produtos diferentes, com scripts diferentes. Por isso o GA4 tem a sua
 * própria função em vez de reaproveitar `carregarGTM`.
 */
function carregarGA4(id: string) {
  window.dataLayer = window.dataLayer ?? []
  /* A forma oficial empurra o próprio `arguments`, não um array — o gtag.js lê
     a aridade de cada item para separar comando de parâmetros. Um array comum
     passa na maioria dos casos e falha em alguns; não vale o risco. */
  const gtag = function (this: unknown, ..._args: unknown[]) {
    /* Empurra o próprio `arguments`, e não `_args`: o gtag.js lê a aridade de
       cada item do dataLayer para separar comando de parâmetros, e um array
       comum não tem a mesma forma. Os rest params existem só para o TypeScript
       aceitar as chamadas abaixo. */
    // eslint-disable-next-line prefer-rest-params
    window.dataLayer!.push(arguments)
  }
  window.gtag = gtag
  gtag('js', new Date())
  gtag('config', id)

  const s = document.createElement('script')
  s.async = true
  s.src = `https://www.googletagmanager.com/gtag/js?id=${encodeURIComponent(id)}`
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
  if (GA4) carregarGA4(GA4)
  if (GTM) carregarGTM(GTM)
  if (META_PIXEL) carregarMetaPixel(META_PIXEL)
}

/**
 * Conta uma página nova na navegação do SPA.
 *
 * O `config` do GA4 dispara UM page_view, no carregamento. Como aqui a troca de
 * rota não recarrega a página, sem isto o relatório mostraria só por onde a
 * pessoa entrou — /modulos/folha-de-pagamento nunca apareceria, e a tag daria a
 * impressão de funcionar enquanto mede um sexto do site.
 *
 * Silencioso quando não há consentimento: `window.gtag` só existe depois do
 * aceite, e sem ele a função não faz nada.
 */
export function registrarPagina(caminho: string, titulo?: string) {
  window.gtag?.('event', 'page_view', {
    page_path: caminho,
    page_location: window.location.href,
    page_title: titulo ?? document.title,
  })
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
    gtag?: (...args: unknown[]) => void
    dataLayer?: unknown[]
    fbq: FbqFn
    _fbq?: FbqFn
  }
}
