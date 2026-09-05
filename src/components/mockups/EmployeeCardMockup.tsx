import { m } from 'motion/react'
import {
  BarChart3,
  Calculator,
  ChevronDown,
  Clock,
  CreditCard,
  FileText,
  History,
  Megaphone,
  MessageCircle,
  MessageSquare,
  Search,
  Star,
  User,
  UserRound,
  Wallet,
  X,
} from 'lucide-react'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

export const EMPLOYEE_CARD_SIZE = { width: 320, height: 690 } as const

const rows: [string, string][][] = [
  [
    ['Matrícula', '205818'],
    ['Cargo', 'Supervisor De Setor'],
    ['E-mail', 'ana.ribeiro@natcorp.com.br'],
    ['Telefone', '(11) 91234-5678'],
  ],
  [
    ['Situação', 'Ativo - 02/03/2026'],
    ['Vínculo', 'Contratado'],
    ['Admissão', '03/06/1996'],
  ],
  [
    ['Empresa', '700 - Natcorp Do Brasil'],
    ['Filial', '97 - Loja 97 - Escritório Rh/Mg'],
    ['Centro de Custo', '10970104 - Folha De Pagamento'],
    ['Unidade Adm.', '97 - Loja 97 - Escritório Rh/Mg'],
  ],
]

const tools = [Megaphone, FileText, User, Clock, Wallet, CreditCard, Calculator]

/**
 * "Dados do Colaborador" no Painel do Operador, no celular. Desenhado em 320 × 690; use em um ScaledFrame.
 */
export function EmployeeCardMockup({ className }: { className?: string }) {
  return (
    <div
      className={cn('relative overflow-hidden rounded-[2.2rem] border-[8px] border-brand-ink bg-[#F4F2F7] text-brand-ink shadow-lift', className)}
      style={{ width: EMPLOYEE_CARD_SIZE.width, height: EMPLOYEE_CARD_SIZE.height }}
      aria-hidden
    >
      <div className="absolute left-1/2 top-2 z-20 h-4 w-20 -translate-x-1/2 rounded-full bg-brand-ink" />

      {/* barra do sistema */}
      <div className="flex items-center gap-3 bg-brand-purple px-3 pb-2.5 pt-7 text-white">
        <span className="flex h-7 w-7 items-center justify-center rounded bg-white/15">
          <span className="block h-3 w-4 border-y-2 border-white" />
        </span>
        <span className="text-[16px] font-medium">Painel do Operador</span>
      </div>

      {/* tabela ao fundo */}
      <div className="grid grid-cols-[28px_56px_1fr_1fr] gap-px bg-brand-mist px-0 text-[9px] font-semibold text-brand-blue">
        {['', 'Foto', 'Empresa', 'Filial'].map((h, i) => (
          <span key={i} className="bg-[#F4F2F7] px-1.5 py-2">
            {h}
          </span>
        ))}
      </div>

      {/* ficha */}
      <m.div
        className="absolute inset-x-1 top-[92px] rounded-t-2xl bg-white shadow-[0_-8px_24px_rgba(27,18,56,0.15)]"
        initial={{ y: 40, opacity: 0 }}
        whileInView={{ y: 0, opacity: 1 }}
        viewport={viewportOnce}
        transition={{ duration: 0.7, ease: EASE, delay: 0.2 }}
      >
        <div className="flex items-center justify-between border-b border-brand-mist px-4 py-3">
          <p className="text-[15px] font-semibold">Dados do Colaborador</p>
          <span className="flex h-6 w-6 items-center justify-center rounded-full bg-brand-off-white">
            <X className="h-3.5 w-3.5" strokeWidth={2} />
          </span>
        </div>

        <div className="flex justify-center py-3">
          <span className="flex h-[74px] w-[74px] items-center justify-center rounded-full border-[3px] border-brand-purple bg-[#E9E5F1] text-brand-purple">
            <UserRound className="h-9 w-9" strokeWidth={1.4} />
          </span>
        </div>

        <div className="flex items-center justify-around bg-brand-blue px-2 py-2 text-white">
          {tools.map((Icon, i) => (
            <span key={i} className="flex items-center gap-0.5">
              <Icon className="h-3.5 w-3.5" strokeWidth={1.8} />
              <ChevronDown className="h-2.5 w-2.5" strokeWidth={2.5} />
            </span>
          ))}
          <BarChart3 className="h-3.5 w-3.5" strokeWidth={1.8} />
        </div>

        <div className="px-4 pt-3">
          <p className="text-[18px] text-brand-graphite">Ana</p>
          <m.dl
            className="mt-2 space-y-3 text-[11px]"
            initial="hidden"
            whileInView="visible"
            viewport={viewportOnce}
            variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.05, delayChildren: 0.6 } } }}
          >
            {rows.map((group, gi) => (
              <div key={gi} className="space-y-1">
                {group.map(([k, v]) => (
                  <m.div key={k} className="grid grid-cols-[86px_1fr] gap-2" variants={{ hidden: { opacity: 0, x: -6 }, visible: { opacity: 1, x: 0 } }}>
                    <dt className="text-brand-graphite">{k}</dt>
                    <dd className="truncate font-semibold text-brand-ink">{v}</dd>
                  </m.div>
                ))}
              </div>
            ))}
          </m.dl>
        </div>

        <div className="mt-3 border-t border-brand-mist px-3 py-3">
          <div className="flex gap-1.5">
            {[
              ['Feedback', MessageSquare],
              ['Conhecendo Você', UserRound],
              ['Linha do Tempo', History],
            ].map(([label, Icon]) => {
              const I = Icon as typeof MessageSquare
              return (
                <span key={label as string} className="flex flex-1 items-center justify-center gap-1 rounded bg-brand-blue px-1 py-2 text-[9.5px] font-semibold text-white">
                  <I className="h-3 w-3 shrink-0" strokeWidth={2} />
                  <span className="truncate">{label as string}</span>
                </span>
              )
            })}
          </div>
          <div className="mt-2 flex justify-end">
            <span className="flex h-8 w-9 items-center justify-center rounded bg-brand-blue text-white">
              <Star className="h-4 w-4" strokeWidth={2} />
            </span>
          </div>
        </div>
      </m.div>

      {/* linha da tabela atrás e botão da NATI */}
      <div className="absolute inset-x-0 bottom-0 flex items-center gap-2 border-t border-brand-mist bg-[#F4F2F7] px-3 py-2 text-[9px] text-brand-graphite">
        <Search className="h-3 w-3" />
        <span className="h-6 w-6 rounded-full bg-brand-mist" />
        <span>700 - Natcorp Do Brasil</span>
        <span>48 - Loja 48 - Floresta</span>
      </div>
      <span className="absolute bottom-3 right-3 flex h-12 w-12 items-center justify-center rounded-full bg-[linear-gradient(135deg,#6A2E8E,#B4568F)] text-white shadow-lift">
        <MessageCircle className="h-5 w-5" strokeWidth={2} />
      </span>
    </div>
  )
}
