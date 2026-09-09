import { useState } from 'react'
import { ExternalLink, Play } from 'lucide-react'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { siteConfig } from '@/content/site'
import { videos, youtubeEmbedUrl, youtubeWatchUrl } from '@/content/videos'
import { cn } from '@/lib/utils'

/**
 * Vídeos do canal da Natcorp. Nada é carregado do YouTube antes do clique:
 * a miniatura vem do próprio site e o player só entra quando a pessoa aperta o play.
 */
export function VideosSection() {
  const [active, setActive] = useState(0)
  const [playing, setPlaying] = useState(false)
  const video = videos[active]

  const select = (i: number) => {
    setActive(i)
    setPlaying(true)
  }

  return (
    <Section id="videos" tone="dark" aria-labelledby="videos-title">
      <div className="container">
        <SectionHeader
          id="videos-title"
          tone="dark"
          eyebrow="Veja em vídeo"
          title="A Natcorp [[em movimento]]."
          lead="O sistema apresentado pelo nosso time, a NATI em ação e os bastidores do Oracle CloudWorld. Assista sem sair da página."
        />

        <div className="mt-12 grid grid-cols-1 gap-8 lg:mt-16 lg:grid-cols-[1.55fr_1fr] lg:gap-10">
          <Reveal delay={0.1} className="min-w-0">
            <div className="relative aspect-video overflow-hidden rounded-3xl bg-black shadow-glow ring-1 ring-white/10">
              {playing ? (
                <iframe
                  key={video.id}
                  src={youtubeEmbedUrl(video.id)}
                  title={video.title}
                  className="absolute inset-0 h-full w-full"
                  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                  referrerPolicy="strict-origin-when-cross-origin"
                  allowFullScreen
                />
              ) : (
                <button
                  type="button"
                  onClick={() => setPlaying(true)}
                  className="group absolute inset-0 block h-full w-full text-left focus-visible:outline-none focus-visible:ring-4 focus-visible:ring-inset focus-visible:ring-[#E4A9C4]"
                  aria-label={`Assistir: ${video.title}`}
                >
                  <img
                    src={video.thumb}
                    alt={`Miniatura do vídeo: ${video.title}`}
                    width={960}
                    height={540}
                    loading="lazy"
                    decoding="async"
                    className="h-full w-full object-cover transition-transform duration-700 ease-brand group-hover:scale-[1.03]"
                  />
                  <span className="absolute inset-0 bg-gradient-to-t from-brand-blue/85 via-brand-blue/10 to-transparent" aria-hidden />
                  <span className="absolute left-1/2 top-1/2 flex h-[4.5rem] w-[4.5rem] -translate-x-1/2 -translate-y-1/2 items-center justify-center rounded-full bg-white text-brand-purple shadow-lift transition-transform duration-500 ease-brand group-hover:scale-110 sm:h-20 sm:w-20" aria-hidden>
                    <Play className="ml-1 h-7 w-7 fill-current" strokeWidth={0} />
                  </span>
                  <span className="absolute inset-x-0 bottom-0 p-5 sm:p-7" aria-hidden>
                    <span className="inline-block rounded-full bg-white/15 px-2.5 py-1 text-[11px] font-semibold uppercase tracking-[0.14em] text-white backdrop-blur">
                      {video.tag}
                    </span>
                    <span className="mt-2 block text-xl font-extrabold leading-tight text-white sm:text-2xl">{video.title}</span>
                  </span>
                </button>
              )}
            </div>
            <div className="mt-5 flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between sm:gap-8">
              <p className="max-w-xl text-[15px] leading-relaxed text-white/75">{video.text}</p>
              <a
                href={youtubeWatchUrl(video.id)}
                target="_blank"
                rel="noreferrer noopener"
                className="inline-flex shrink-0 items-center gap-2 text-sm font-semibold text-white underline-offset-4 hover:underline"
              >
                Assistir no YouTube
                <ExternalLink className="h-4 w-4" aria-hidden />
              </a>
            </div>
          </Reveal>

          <div className="flex flex-col gap-2.5">
            <Stagger className="flex flex-col gap-2.5" stagger={0.06} delay={0.15} role="list" aria-label="Lista de vídeos">
              {videos.map((v, i) => {
                const current = i === active
                return (
                  <StaggerItem key={v.id} role="listitem">
                    <button
                      type="button"
                      onClick={() => select(i)}
                      aria-pressed={current}
                      className={cn(
                        'group flex w-full items-center gap-4 rounded-2xl border p-2.5 text-left transition-[background-color,border-color,transform] duration-300 ease-brand focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#E4A9C4]',
                        current ? 'border-[#E4A9C4]/60 bg-white/[0.1]' : 'border-white/10 bg-white/[0.04] hover:-translate-y-0.5 hover:border-white/25 hover:bg-white/[0.08]',
                      )}
                    >
                      <span className="relative aspect-video w-28 shrink-0 overflow-hidden rounded-lg bg-black sm:w-32">
                        <img src={v.thumb} alt={`Miniatura do vídeo: ${v.title}`} width={960} height={540} loading="lazy" decoding="async" className="h-full w-full object-cover" />
                        <span
                          className={cn(
                            'absolute inset-0 flex items-center justify-center bg-brand-blue/35 transition-opacity duration-300',
                            current ? 'opacity-100' : 'opacity-0 group-hover:opacity-100',
                          )}
                          aria-hidden
                        >
                          <span className="flex h-8 w-8 items-center justify-center rounded-full bg-white text-brand-purple">
                            <Play className="ml-0.5 h-3.5 w-3.5 fill-current" strokeWidth={0} />
                          </span>
                        </span>
                      </span>
                      <span className="min-w-0">
                        <span className={cn('block text-[11px] font-semibold uppercase tracking-[0.14em]', current ? 'text-[#E4A9C4]' : 'text-white/55')}>
                          {v.tag}
                        </span>
                        <span className="mt-0.5 block text-[14.5px] font-bold leading-snug text-white">{v.title}</span>
                      </span>
                    </button>
                  </StaggerItem>
                )
              })}
            </Stagger>
            <Reveal delay={0.4} className="mt-2 px-1">
              <a
                href={siteConfig.youtube}
                target="_blank"
                rel="noreferrer noopener"
                className="inline-flex items-center gap-2 text-sm font-semibold text-white/80 underline-offset-4 transition-colors hover:text-white hover:underline"
              >
                Mais vídeos no canal da Natcorp
                <ExternalLink className="h-4 w-4" aria-hidden />
              </a>
            </Reveal>
          </div>
        </div>
      </div>
    </Section>
  )
}
