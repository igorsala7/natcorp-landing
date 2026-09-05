import type { ReactNode } from 'react'
import { m } from 'motion/react'
import {
  Bookmark,
  ChevronRight,
  Columns2,
  Copy,
  Database,
  History,
  Info,
  Maximize2,
  Mic,
  Minus,
  Paperclip,
  Plug,
  Send,
  ThumbsDown,
  ThumbsUp,
  Trash2,
} from 'lucide-react'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

interface NatiChatWindowProps {
  children: ReactNode
  className?: string
  /** Esconde barra de ferramentas e campo de entrada (versões compactas). */
  bare?: boolean
  dbCount?: number
  bodyClassName?: string
}

/** Janela do assistente NATI como aparece no sistema (cabeçalho, conversa, ferramentas e entrada). */
export function NatiChatWindow({ children, className, bare = false, dbCount = 1, bodyClassName }: NatiChatWindowProps) {
  return (
    <div className={cn('min-w-0 overflow-hidden rounded-2xl border border-brand-mist bg-white text-brand-ink shadow-lift', className)}>
      <div className="flex items-center gap-3 bg-[linear-gradient(90deg,#6A2E8E_0%,#B4568F_100%)] px-4 py-3 text-white">
        <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-white/95">
          <NatiAvatar ring className="h-10 w-10" />
        </span>
        <div className="min-w-0 flex-1">
          <p className="truncate text-[15px] font-bold leading-tight">NATI - Assistente de RH</p>
          <p className="text-[12px] text-white/80">Faça sua pergunta</p>
        </div>
        <div className="flex gap-1.5" aria-hidden>
          {[Columns2, Trash2, Maximize2, Minus].map((Icon, i) => (
            <span key={i} className="flex h-8 w-8 items-center justify-center rounded-full bg-white/20">
              <Icon className="h-3.5 w-3.5" strokeWidth={2} />
            </span>
          ))}
        </div>
      </div>

      <div className={cn('space-y-3 bg-[#F7F5FA] p-4', bodyClassName)}>{children}</div>

      {!bare && (
        <>
          <div className="flex flex-wrap items-center gap-x-5 gap-y-1.5 border-t border-brand-mist px-4 py-2.5 text-[12.5px] font-semibold text-brand-graphite">
            <span className="inline-flex items-center gap-1.5">
              <Bookmark className="h-4 w-4" strokeWidth={1.8} aria-hidden />
              Prompts salvos
            </span>
            <span className="inline-flex items-center gap-1.5">
              <Database className="h-4 w-4" strokeWidth={1.8} aria-hidden />
              Base de Dados ({dbCount})
            </span>
            <span className="inline-flex items-center gap-1.5">
              <History className="h-4 w-4" strokeWidth={1.8} aria-hidden />
              Histórico
            </span>
            <span className="inline-flex items-center gap-1.5 text-emerald-700">
              <Plug className="h-4 w-4" strokeWidth={1.8} aria-hidden />
              Microsoft ✓
            </span>
          </div>
          <div className="flex items-center gap-2 px-4 pb-2 pt-1">
            {[Paperclip, Mic].map((Icon, i) => (
              <span key={i} className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-[linear-gradient(135deg,#6A2E8E,#B4568F)] text-white" aria-hidden>
                <Icon className="h-4 w-4" strokeWidth={2} />
              </span>
            ))}
            <span className="flex h-10 flex-1 items-center rounded-full border-2 border-brand-purple/60 bg-white px-4 text-[13px] text-brand-graphite">Escreva ou fale…</span>
            <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-[linear-gradient(135deg,#6A2E8E,#B4568F)] text-white" aria-hidden>
              <Send className="h-4 w-4" strokeWidth={2} />
            </span>
          </div>
          <p className="px-4 pb-3 text-center text-[11px] leading-snug text-brand-graphite">
            Sou uma IA e posso cometer enganos — sempre valide as informações.
            <span className="block text-[10.5px] text-brand-graphite">Powered by Natcorp</span>
          </p>
        </>
      )}
    </div>
  )
}

const bubbleIn = {
  hidden: { opacity: 0, y: 10, scale: 0.98 },
  visible: { opacity: 1, y: 0, scale: 1, transition: { duration: 0.45, ease: EASE } },
}

/** Mensagem do usuário (à direita, degradê). */
export function UserBubble({ children, time }: { children: ReactNode; time?: string }) {
  return (
    <m.div variants={bubbleIn} className="ml-auto flex max-w-[86%] flex-col items-end">
      <div className="rounded-2xl rounded-br-md bg-[linear-gradient(135deg,#6A2E8E,#B4568F)] px-3.5 py-2.5 text-[13px] leading-snug text-white">{children}</div>
      {time && <span className="mt-1 text-[10.5px] tabular text-brand-graphite">{time}</span>}
    </m.div>
  )
}

/** Resposta da NATI (à esquerda, com avatar). */
export function NatiBubble({ children, className }: { children: ReactNode; className?: string }) {
  return (
    <m.div variants={bubbleIn} className="flex items-start gap-2.5">
      <NatiAvatar ring className="mt-1 h-8 w-8 shrink-0" />
      <div className={cn('relative min-w-0 max-w-[92%] flex-1 rounded-2xl rounded-bl-md border border-brand-mist bg-white px-3.5 py-3 text-[13px] leading-relaxed text-brand-ink shadow-soft', className)}>
        <Copy className="absolute right-3 top-3 h-3.5 w-3.5 text-brand-graphite" strokeWidth={1.8} aria-hidden />
        {children}
      </div>
    </m.div>
  )
}

/** Rodapé de resposta: base de dados usada, fontes e utilidade. */
export function NatiAnswerFooter({ sources = 4, note = 'Resposta baseada nos arquivos e relatórios que você escolheu.' }: { sources?: number; note?: string }) {
  return (
    <m.div variants={bubbleIn} className="space-y-1.5 pl-[42px] text-[12px] text-brand-graphite">
      <p className="flex items-center gap-1.5 italic">
        <Info className="h-3.5 w-3.5 shrink-0" strokeWidth={1.8} aria-hidden />
        {note}
      </p>
      <p className="flex items-center gap-1 font-semibold">
        <ChevronRight className="h-3.5 w-3.5" strokeWidth={2} aria-hidden />
        Fontes ({sources})
      </p>
      <p className="flex items-center gap-2">
        Foi útil?
        <ThumbsUp className="h-4 w-4 text-brand-purple" strokeWidth={1.8} aria-hidden />
        <ThumbsDown className="h-4 w-4 text-brand-graphite" strokeWidth={1.8} aria-hidden />
      </p>
    </m.div>
  )
}

/** Indicador de digitação. */
export function TypingDots() {
  return (
    <m.div variants={bubbleIn} className="flex items-center gap-1 pl-[42px]" aria-hidden>
      {[0, 1, 2].map((i) => (
        <m.span key={i} className="h-1.5 w-1.5 rounded-full bg-brand-gray" animate={{ y: [0, -3, 0] }} transition={{ duration: 0.6, repeat: Infinity, delay: i * 0.12 }} />
      ))}
    </m.div>
  )
}

/** Contêiner que orquestra a entrada das mensagens em sequência. */
export function Conversation({ children, className, stagger = 0.35, delay = 0.2, inView = true }: { children: ReactNode; className?: string; stagger?: number; delay?: number; inView?: boolean }) {
  return (
    <m.div
      className={cn('space-y-3', className)}
      initial="hidden"
      {...(inView ? { whileInView: 'visible', viewport: { once: true, margin: '0px 0px -10% 0px' } } : { animate: 'visible' })}
      variants={{ hidden: {}, visible: { transition: { staggerChildren: stagger, delayChildren: delay } } }}
    >
      {children}
    </m.div>
  )
}
