import thumbInovacao from '@/assets/videos/mflaJIRfdkA.jpg'
import thumbRh40 from '@/assets/videos/utRv4php_rw.jpg'
import thumbNati from '@/assets/videos/GkDvRrgutGw.jpg'
import thumbOracleLasVegas from '@/assets/videos/3uhVvnzk28c.jpg'
import thumbOracleBastidores from '@/assets/videos/qhU2pu5ZrFI.jpg'

export interface Video {
  /** ID do vídeo no YouTube. */
  id: string
  title: string
  text: string
  tag: string
  /** Miniatura servida pelo próprio site (nada é carregado do YouTube antes do clique). */
  thumb: string
}

/** Vídeos publicados no canal da Natcorp no YouTube, na ordem em que aparecem na página. */
export const videos: Video[] = [
  {
    id: 'mflaJIRfdkA',
    title: 'A inovação que o seu RH precisa',
    text: 'Uma visão geral do sistema: todos os módulos integrados, um único cadastro e a NATI trabalhando dentro do RH.',
    tag: 'Institucional',
    thumb: thumbInovacao,
  },
  {
    id: 'GkDvRrgutGw',
    title: 'NATI, a sua assistente pessoal de RH',
    text: 'A inteligência artificial da Natcorp respondendo, analisando e executando tarefas do RH em linguagem natural.',
    tag: 'NATI',
    thumb: thumbNati,
  },
  {
    id: '3uhVvnzk28c',
    title: 'Natcorp no Oracle CloudWorld, em Las Vegas',
    text: 'A apresentação da Natcorp no maior evento da Oracle: inovação no RH com inteligência artificial.',
    tag: 'Evento',
    thumb: thumbOracleLasVegas,
  },
  {
    id: 'qhU2pu5ZrFI',
    title: 'Bastidores do Oracle CloudWorld',
    text: 'As considerações finais do time sobre as apresentações e o que muda no RH a partir da nuvem Oracle.',
    tag: 'Evento',
    thumb: thumbOracleBastidores,
  },
  {
    id: 'utRv4php_rw',
    title: 'Venha para o mundo do RH 4.0',
    text: 'O convite da Natcorp para um RH digital, automatizado e protagonista na estratégia da empresa.',
    tag: 'Institucional',
    thumb: thumbRh40,
  },
]

export const youtubeWatchUrl = (id: string) => `https://www.youtube.com/watch?v=${id}`

/** Player sem cookies até o clique (domínio youtube-nocookie). */
export const youtubeEmbedUrl = (id: string) =>
  `https://www.youtube-nocookie.com/embed/${id}?autoplay=1&rel=0&modestbranding=1&hl=pt-BR`
