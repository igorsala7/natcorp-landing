import { BarChart3, X } from 'lucide-react'
import { ChipRow, PanelShell, ReportToolbar, SubNav } from './shell'
import { VBars } from './charts'

const candidates = [
  { label: '0003 - ASSISTENTE ADMINISTRATIVO', value: 50 },
  { label: 'TI001 - ANALISTA DE SISTEMAS JUNIOR', value: 44 },
  { label: '0057 - ASSISTENTE DE SETOR', value: 15 },
  { label: '0083 - ANALISTA DE SUPORTE', value: 13 },
  { label: '0014 - COORDENADOR ADMINISTRATIVOS', value: 12 },
  { label: '0048 - GERENTE DE DEPARTAMENTO PESSOAL', value: 11 },
  { label: '0018 - DIRETOR', value: 2 },
  { label: '202 - GERENTE DE RECURSOS HUMANOS', value: 1 },
  { label: '273 - AÇOUGUEIRO', value: 1 },
  { label: '568 - ENCARREGADO FINANCEIRO', value: 1 },
  { label: '0212 - GERENTE DE SISTEMAS', value: 1 },
]

/** Modal "Recrutamento e Seleção": candidatos por cargo, gerado a partir da listagem com o botão Ações. */
export function RecruitmentModal() {
  return (
    <PanelShell
      subnav={<SubNav items={[{ label: 'Talentos' }, { label: 'Recrutamento e Seleção', caret: true, active: true }]} />}
      activeRail={1}
      overlay={
        <div className="absolute inset-0 bg-black/45">
          <div className="absolute inset-x-4 bottom-0 top-4 flex flex-col overflow-hidden rounded-t-lg bg-white shadow-lift">
            <div className="flex shrink-0 items-center justify-between border-b-[3px] border-brand-purple px-4 py-3">
              <p className="text-[21px] text-brand-ink">Recrutamento e Seleção</p>
              <X className="h-5 w-5 text-brand-ink" strokeWidth={2} />
            </div>
            <div className="flex min-h-0 flex-1 flex-col px-4 pb-3">
              <div className="flex items-center gap-4 py-4">
                <span className="flex h-[74px] w-[74px] items-center justify-center rounded-md bg-[#C4507F] text-white">
                  <BarChart3 className="h-10 w-10" strokeWidth={1.8} />
                </span>
                <p className="text-[31px] text-brand-ink">Recrutamento e Seleção</p>
              </div>
              <div className="rounded border border-brand-mist p-3">
                <ReportToolbar mode="chart" highlightActions />
              </div>
              <ChipRow kind="edit" />
              <div className="mt-2 min-h-0 flex-1">
                <VBars items={candidates} max={60} ticks={['60', '50', '40', '30', '20', '10', '0']} labels="wrap" labelHeight={64} gap="2%" />
              </div>
            </div>
          </div>
        </div>
      }
    >
      <div className="h-full p-4">
        <div className="h-full rounded-md border border-brand-mist bg-white" />
      </div>
    </PanelShell>
  )
}
