import heroOffice from '@/assets/people/hero-office.jpg'
import personaChro from '@/assets/people/persona-chro.jpg'
import personaCfo from '@/assets/people/persona-cfo.jpg'
import personaCto from '@/assets/people/persona-cto.jpg'
import personaRh from '@/assets/people/persona-rh.jpg'
import personaRhFilial from '@/assets/people/persona-rh-filial.jpg'
import personaFinanceiro from '@/assets/people/persona-financeiro.jpg'
import bannerTime from '@/assets/people/banner-time.jpg'
import type { HumanFrame } from '@/components/brand/HumanModule'

/**
 * Fotografias de pessoas usadas nas composições com o símbolo (HumanModule).
 *
 * ATENÇÃO: são imagens provisórias, de banco (Unsplash, licença livre para uso comercial),
 * escolhidas para validar o conceito. Devem ser substituídas por fotos do time e dos
 * clientes da Natcorp. Créditos em src/assets/people/CREDITS.md.
 */
export interface Portrait {
  src: string
  alt: string
  frame?: HumanFrame
}

export const people = {
  hero: {
    src: heroOffice,
    alt: 'Foto ilustrativa: profissional de RH sentada em um escritório envidraçado, sorrindo para a câmera',
  },
  chro: { src: personaChro, alt: 'Foto ilustrativa: diretora de RH sorrindo', frame: { y: -0.6 } },
  cfo: { src: personaCfo, alt: 'Foto ilustrativa: executivo de óculos em um escritório', frame: { y: -0.3 } },
  cto: { src: personaCto, alt: 'Foto ilustrativa: profissional de tecnologia em uma sala de servidores', frame: { x: -2.6, y: -0.2, scale: 1.2 } },
  rh: { src: personaRh, alt: 'Foto ilustrativa: analista de RH sorrindo à mesa de trabalho', frame: { y: -0.4 } },
  rhFilial: { src: personaRhFilial, alt: 'Foto ilustrativa: profissional de óculos consultando um tablet em um centro de distribuição', frame: { y: -0.3 } },
  financeiro: { src: personaFinanceiro, alt: 'Foto ilustrativa: analista à mesa com relatórios impressos', frame: { y: -0.4 } },
  time: { src: bannerTime, alt: 'Foto ilustrativa: equipe reunida em volta de um notebook, rindo', frame: { x: 0.2, y: -0.2, scale: 1.05 } },
} satisfies Record<string, Portrait>
