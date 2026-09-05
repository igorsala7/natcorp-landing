import { m } from 'motion/react'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import { OperatorPanel, PANEL_SIZE } from '@/components/mockups/nati/OperatorPanel'
import { EMPLOYEE_CARD_SIZE, EmployeeCardMockup } from './EmployeeCardMockup'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

const rise = (delay: number) => ({
  initial: { opacity: 0, y: 40 },
  whileInView: { opacity: 1, y: 0 },
  viewport: viewportOnce,
  transition: { duration: 0.9, ease: EASE, delay },
})

/**
 * O mesmo sistema no notebook, no tablet e no celular: três molduras com o Painel do Operador
 * (desktop e tablet) e a ficha do colaborador (celular), tudo em HTML/CSS.
 */
export function DevicesShowcase({ className }: { className?: string }) {
  return (
    <div
      className={cn('relative', className)}
      role="img"
      aria-label="O sistema Natcorp aberto em um notebook, em um tablet e em um celular: Painel do Operador com indicadores demográficos e ficha do colaborador"
    >
      <div className="grid gap-6 lg:block lg:pb-[14%]">
        {/* notebook */}
        <m.div {...rise(0)} className="relative z-10 lg:w-[78%]">
          <div className="rounded-[14px] border-[10px] border-[#1F1640] bg-[#1F1640] shadow-lift">
            <ScaledFrame width={PANEL_SIZE.desktop.width} height={PANEL_SIZE.desktop.height} className="rounded-[6px]">
              <OperatorPanel />
            </ScaledFrame>
          </div>
          <div className="mx-auto h-3 w-[92%] rounded-b-[10px] bg-[#2B2D36]" />
          <div className="mx-auto h-1 w-[30%] rounded-b-md bg-[#4A4460]" />
        </m.div>

        <div className="grid grid-cols-[1.45fr_1fr] items-end gap-4 lg:contents">
          {/* tablet */}
          <m.div {...rise(0.15)} className="relative z-20 lg:absolute lg:right-[3%] lg:top-[22%] lg:w-[38%]">
            <div className="rounded-[18px] border-[9px] border-[#1F1640] bg-[#1F1640] shadow-lift">
              <ScaledFrame width={PANEL_SIZE.tablet.width} height={PANEL_SIZE.tablet.height} className="rounded-[8px]">
                <OperatorPanel layout="tablet" />
              </ScaledFrame>
            </div>
          </m.div>

          {/* celular */}
          <m.div {...rise(0.3)} className="relative z-30 lg:absolute lg:bottom-0 lg:right-[-1%] lg:w-[19%]">
            <ScaledFrame width={EMPLOYEE_CARD_SIZE.width} height={EMPLOYEE_CARD_SIZE.height}>
              <EmployeeCardMockup />
            </ScaledFrame>
          </m.div>
        </div>
      </div>
    </div>
  )
}
