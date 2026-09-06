import { Deck } from '@/components/presentation/Deck'
import { deckSlides } from '@/components/presentation/slides'
import { deckMeta } from '@/content/presentation'
import { paths } from '@/content/site'
import { useSeo } from '@/hooks/useSeo'

/**
 * Apresentação executiva do sistema, em tela cheia (/apresentacao). Fora do menu e do sitemap:
 * é um material comercial compartilhado por link, com título e descrição próprios para a prévia.
 */
export default function PresentationPage() {
  useSeo({ title: deckMeta.seoTitle, description: deckMeta.seoDescription, path: paths.presentation, noindex: true })
  return <Deck slides={deckSlides} />
}
