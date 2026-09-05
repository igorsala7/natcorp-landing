import { m } from 'motion/react'
import { Camera, Check, CheckCheck, ChevronLeft, FileText, Mic, Plus, Share2, Smile } from 'lucide-react'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { cn } from '@/lib/utils'
import { EASE } from '@/lib/motion'

const item = {
  hidden: { opacity: 0, y: 10 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.45, ease: EASE } },
}

function Out({ children, time }: { children: React.ReactNode; time: string }) {
  return (
    <m.div variants={item} className="ml-auto max-w-[84%] rounded-lg rounded-tr-sm bg-[#005C4B] px-3 py-2 text-[12.5px] leading-snug text-white">
      {children}
      <span className="mt-1 flex items-center justify-end gap-1 text-[10px] text-white/75">
        {time}
        <CheckCheck className="h-3 w-3 text-sky-300" strokeWidth={2} aria-hidden />
      </span>
    </m.div>
  )
}

function In({ children, time }: { children: React.ReactNode; time: string }) {
  return (
    <m.div variants={item} className="max-w-[88%] rounded-lg rounded-tl-sm bg-[#202C33] px-3 py-2 text-[12.5px] leading-snug text-white/95">
      {children}
      <span className="mt-1 block text-right text-[10px] text-white/75">{time}</span>
    </m.div>
  )
}

/** Conversa da NATI no WhatsApp: holerite em PDF e dados de férias. */
export function WhatsAppMockup({ className }: { className?: string }) {
  return (
    <div
      className={cn('relative aspect-[9/19] w-[300px] overflow-hidden rounded-[2.4rem] border-[8px] border-brand-ink bg-[#0B141A] shadow-lift', className)}
      role="img"
      aria-label="Conversa no WhatsApp: o colaborador pede o holerite de março de 2025 e a NATI envia o PDF; depois pede os dados de férias e recebe período aquisitivo, status, saldo e prazo"
    >
      <div className="absolute left-1/2 top-2 h-4 w-20 -translate-x-1/2 rounded-full bg-brand-ink" aria-hidden />
      <div className="flex items-center gap-2 bg-[#1F2C34] px-3 pb-2.5 pt-8 text-white">
        <span className="flex items-center gap-0.5 text-[12px] text-white/90">
          <ChevronLeft className="h-4 w-4" strokeWidth={2} aria-hidden />
          79
        </span>
        <span className="flex h-8 w-8 items-center justify-center rounded-full bg-white/95">
          <NatiAvatar className="h-7 w-7" />
        </span>
        <span className="text-[14px] font-semibold">Natcorp</span>
      </div>

      <m.div
        className="space-y-2 px-3 py-3"
        initial="hidden"
        whileInView="visible"
        viewport={{ once: true, margin: '0px 0px -10% 0px' }}
        variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.4, delayChildren: 0.3 } } }}
      >
        <Out time="15:49">Quero meu holerite de março de 2025</Out>
        <m.div variants={item} className="flex max-w-[88%] items-center gap-2 rounded-lg rounded-tl-sm bg-[#202C33] p-2 text-white">
          <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-md bg-[#E5322D]">
            <FileText className="h-5 w-5" strokeWidth={2} aria-hidden />
          </span>
          <span className="min-w-0 flex-1">
            <span className="block truncate text-[12px] font-medium">RECIBO_DE_PAGAMENTO.pdf</span>
            <span className="block text-[10.5px] text-white/75">21 KB · pdf</span>
          </span>
          <span className="flex h-7 w-7 items-center justify-center rounded-full bg-white/10" aria-hidden>
            <Share2 className="h-3.5 w-3.5" strokeWidth={2} />
          </span>
        </m.div>
        <In time="15:49">
          Seu <b>holerite de Março/2025</b> já foi gerado e enviado pra você.
          <Check className="ml-1 inline h-3.5 w-3.5 text-emerald-400" strokeWidth={3} aria-hidden />
          <span className="mt-2 block">
            Se quiser, posso gerar também de <b>outro mês/ano</b> ou seu <b>informe de rendimentos</b>.
          </span>
        </In>
        <Out time="15:50">Quais são meus dados de férias deste ano?</Out>
        <In time="15:50">
          Pelos seus registros de férias deste ano:
          <ul className="mt-1.5 list-disc space-y-0.5 pl-4">
            <li>
              <b>Período aquisitivo:</b> 03/06/2025 a 02/06/2026
            </li>
            <li>
              <b>Status:</b> PENDENTE (ainda não programadas)
            </li>
            <li>
              <b>Saldo disponível:</b> 30 dias
            </li>
            <li>
              <b>Data limite para programar:</b> 02/06/2027
            </li>
          </ul>
        </In>
      </m.div>

      <div className="absolute inset-x-0 bottom-0 flex items-center gap-2 bg-[#0B141A] px-3 pb-4 pt-2 text-white/80" aria-hidden>
        <Plus className="h-5 w-5" strokeWidth={2} />
        <span className="flex h-9 flex-1 items-center justify-end rounded-full bg-[#202C33] px-3">
          <Smile className="h-4 w-4 text-white/75" strokeWidth={2} />
        </span>
        <Camera className="h-5 w-5" strokeWidth={2} />
        <Mic className="h-5 w-5" strokeWidth={2} />
      </div>
    </div>
  )
}
