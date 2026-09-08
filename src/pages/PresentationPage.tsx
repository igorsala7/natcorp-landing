import { Deck } from '@/components/presentation/Deck'
import { deckSlidesFor } from '@/components/presentation/slides'
import { deckMeta, deckVersions, type DeckVersion } from '@/content/presentation'
import { paths } from '@/content/site'
import { useSeo } from '@/hooks/useSeo'

/**
 * Apresentação comercial do sistema, em tela cheia: completa (/apresentacao) e reduzida
 * (/apresentacao/reduzida). Fora do menu e do sitemap: é um material compartilhado por link.
 */
export default function PresentationPage({ version = 'completa' }: { version?: DeckVersion }) {
  const short = version === 'reduzida'
  useSeo({
    title: short ? `${deckMeta.seoTitle} (versão reduzida)` : deckMeta.seoTitle,
    description: `${deckMeta.seoDescription} Versão ${deckVersions[version].label.toLowerCase()}, ${deckVersions[version].duration}.`,
    path: short ? paths.presentationShort : paths.presentation,
    noindex: true,
  })
  return <Deck key={version} slides={deckSlidesFor(version)} version={version} />
}
