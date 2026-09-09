import { useEffect } from 'react'
import { siteConfig } from '@/content/site'
import pageDates from '@/content/pageDates.json'

interface SeoInput {
  title: string
  description: string
  /** Caminho da página (ex.: "/modulos/folha-de-pagamento"). */
  path: string
  image?: string
  noindex?: boolean
}

function upsertMeta(attr: 'name' | 'property', key: string, content: string) {
  let el = document.head.querySelector<HTMLMetaElement>(`meta[${attr}="${key}"]`)
  if (!el) {
    el = document.createElement('meta')
    el.setAttribute(attr, key)
    document.head.appendChild(el)
  }
  el.setAttribute('content', content)
}

function upsertLink(rel: string, href: string) {
  let el = document.head.querySelector<HTMLLinkElement>(`link[rel="${rel}"]`)
  if (!el) {
    el = document.createElement('link')
    el.setAttribute('rel', rel)
    document.head.appendChild(el)
  }
  el.setAttribute('href', href)
}

/**
 * Bloco `WebPage` da página atual.
 *
 * POR QUE ELE EXISTE
 *
 * O site declarava `Organization`, `WebSite` e `SoftwareApplication` — quem é a empresa
 * e o que é o produto. Faltava dizer o que é CADA PÁGINA, e com isso faltavam dois
 * sinais que os motores de resposta usam para escolher quem citar:
 *
 *   - `dateModified`: sem data, a IA não sabe se a página fala do eSocial de 2026 ou de
 *     2019. Entre duas fontes, ela cita a datada. A data vem do git, pelo commit que
 *     mudou o conteúdo daquela página — não da data do build, que faria as 60 páginas
 *     alegarem mudança a cada publicação.
 *   - `author` e `publisher`: texto sem dono é tratado como material genérico. Em site
 *     institucional, quem assina é a empresa — e ela já está declarada em `#org`, no
 *     index.html. Aqui a página só aponta para lá.
 *
 * É um bloco só, atualizado a cada navegação em vez de acumulado: a SPA troca de página
 * sem recarregar, e sem o `id` fixo sobraria um `WebPage` por página visitada.
 */
const ID_WEBPAGE = 'ld-webpage'

function upsertWebPage(input: { url: string; title: string; description: string; image: string; path: string }) {
  const dates = pageDates as Record<string, string | undefined>
  const data = {
    '@context': 'https://schema.org',
    '@type': 'WebPage',
    '@id': `${input.url}#page`,
    url: input.url,
    name: input.title,
    description: input.description,
    inLanguage: 'pt-BR',
    isPartOf: { '@id': `${siteConfig.url}/#site` },
    about: { '@id': `${siteConfig.url}/#org` },
    author: { '@id': `${siteConfig.url}/#org` },
    publisher: { '@id': `${siteConfig.url}/#org` },
    primaryImageOfPage: input.image,
    ...(dates[input.path] ? { dateModified: dates[input.path] } : {}),
  }
  let el = document.head.querySelector<HTMLScriptElement>(`script#${ID_WEBPAGE}`)
  if (!el) {
    el = document.createElement('script')
    el.type = 'application/ld+json'
    el.id = ID_WEBPAGE
    document.head.appendChild(el)
  }
  el.textContent = JSON.stringify(data)
}

/** Atualiza título, descrição, canonical, Open Graph e o bloco `WebPage` da página atual. */
export function useSeo({ title, description, path, image, noindex }: SeoInput) {
  useEffect(() => {
    const url = `${siteConfig.url}${path}`
    const img = image ?? `${siteConfig.url}/og-image.png`
    document.title = title
    upsertMeta('name', 'description', description)
    upsertMeta('name', 'robots', noindex ? 'noindex, nofollow' : 'index, follow, max-image-preview:large')
    upsertLink('canonical', url)
    upsertMeta('property', 'og:title', title)
    upsertMeta('property', 'og:description', description)
    upsertMeta('property', 'og:url', url)
    upsertMeta('property', 'og:image', img)
    upsertMeta('name', 'twitter:title', title)
    upsertMeta('name', 'twitter:description', description)
    upsertMeta('name', 'twitter:image', img)
    /* Página fora do índice não declara WebPage: não há por que descrever para um
       motor de busca uma página que se pediu para ele ignorar. */
    if (noindex) document.head.querySelector(`script#${ID_WEBPAGE}`)?.remove()
    else upsertWebPage({ url, title, description, image: img, path })
  }, [title, description, path, image, noindex])
}
