import { AnimatePresence, m } from 'motion/react'
import { Sparkles } from 'lucide-react'
import { Logo } from '@/components/brand/Logo'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

export interface Conversation {
  id: string
  user: string
  reply: string[]
  actions: string[]
}

export function NatiChatMockup({ conversation, className }: { conversation: Conversation; className?: string }) {
  return (
    <div
      className={cn('overflow-hidden rounded-2xl border border-white/15 bg-white text-brand-ink shadow-glow', className)}
      role="img"
      aria-label={`Conversa com a NATI. Pergunta: ${conversation.user}. Resposta: ${conversation.reply.join(' ')}`}
    >
      <div className="flex items-center gap-3 border-b border-brand-mist px-4 py-3">
        <span className="flex h-8 w-8 items-center justify-center rounded-lg bg-brand-gradient">
          <Logo variant="symbol" tone="white" className="h-4 w-4" decorative />
        </span>
        <div className="flex-1">
          <p className="text-[13px] font-bold">NATI</p>
          <p className="text-[11px] text-brand-graphite">Inteligência artificial · dentro do sistema</p>
        </div>
        <span className="flex items-center gap-1.5 text-[11px] font-semibold text-emerald-700">
          <span className="h-1.5 w-1.5 rounded-full bg-emerald-500 animate-pulse-soft" aria-hidden />
          24/7
        </span>
      </div>

      <div className="min-h-[300px] space-y-3 bg-brand-off-white/60 p-4 sm:min-h-[320px]">
        <AnimatePresence mode="wait">
          <m.div
            key={conversation.id}
            className="space-y-3"
            initial="hidden"
            animate="visible"
            exit="exit"
            variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.35 } }, exit: { opacity: 0, transition: { duration: 0.2 } } }}
          >
            <m.div
              className="ml-auto max-w-[82%] rounded-2xl rounded-br-md bg-brand-purple px-3.5 py-2.5 text-[13px] leading-snug text-white"
              variants={{ hidden: { opacity: 0, y: 10, scale: 0.98 }, visible: { opacity: 1, y: 0, scale: 1, transition: { duration: 0.45, ease: EASE } } }}
            >
              {conversation.user}
            </m.div>

            <m.div
              className="flex items-center gap-1 px-1 text-brand-graphite"
              variants={{ hidden: { opacity: 0 }, visible: { opacity: [0, 1, 1, 0], transition: { duration: 0.9, times: [0, 0.2, 0.8, 1] } } }}
              aria-hidden
            >
              {[0, 1, 2].map((i) => (
                <m.span
                  key={i}
                  className="h-1.5 w-1.5 rounded-full bg-brand-gray"
                  animate={{ y: [0, -3, 0] }}
                  transition={{ duration: 0.6, repeat: Infinity, delay: i * 0.12 }}
                />
              ))}
            </m.div>

            <m.div
              className="max-w-[92%] rounded-2xl rounded-bl-md border border-brand-mist bg-white px-3.5 py-3 text-[13px] leading-relaxed text-brand-ink shadow-soft"
              variants={{ hidden: { opacity: 0, y: 10, scale: 0.98 }, visible: { opacity: 1, y: 0, scale: 1, transition: { duration: 0.5, ease: EASE, delay: 0.5 } } }}
            >
              <p className="mb-1.5 flex items-center gap-1.5 text-[11px] font-semibold text-brand-purple">
                <Sparkles className="h-3 w-3" strokeWidth={2} />
                NATI
              </p>
              {conversation.reply.map((line, i) => (
                <p key={i} className={cn(i > 0 && 'mt-1.5')}>
                  {line}
                </p>
              ))}
              <div className="mt-3 flex flex-wrap gap-1.5">
                {conversation.actions.map((a) => (
                  <span key={a} className="rounded-full border border-brand-purple/30 px-2.5 py-1 text-[11px] font-semibold text-brand-purple">
                    {a}
                  </span>
                ))}
              </div>
            </m.div>
          </m.div>
        </AnimatePresence>
      </div>

      <div className="flex items-center gap-2 border-t border-brand-mist px-4 py-3">
        <span className="flex-1 rounded-lg border border-brand-mist bg-white px-3 py-2 text-[12px] text-brand-graphite">Pergunte à NATI…</span>
        <span className="rounded-lg bg-brand-purple px-3 py-2 text-[12px] font-semibold text-white">Enviar</span>
      </div>
    </div>
  )
}
