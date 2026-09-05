import { History, List, RotateCcw, Search } from 'lucide-react'
import { cn } from '@/lib/utils'
import { ChipRow, PanelShell, ReportToolbar, SubNav } from './shell'
import { VBars } from './charts'

export type ComparisonMode = 'chart' | 'table'

const bars = [
  { label: 'TOTAL DE PROVENTOS', value: 22.5 },
  { label: 'BASE CALCULO SALARIO', value: 18.3 },
  { label: 'BS SALARIO - SEM REDUCAO', value: 18.3 },
  { label: 'SAL CONTR INSS SEM TETO', value: 16.2 },
  { label: 'BASE DE CALCULO FGTS', value: 16.2 },
  { label: 'SAL CONTR INSS ATE TETO', value: 15.6 },
  { label: 'HORAS NORMAIS', value: 14.5 },
  { label: 'BASE SAL.MINIMO INTEGRAL', value: 12.6 },
  { label: 'BASE SALARIO MINIMO PROP', value: 12.2 },
  { label: 'BASE MINIMO REGIONAL', value: 11.4 },
  { label: 'TOTAL DE DESCONTOS', value: 11.3 },
  { label: 'TOTAL LIQUIDO', value: 10.8 },
  { label: 'BASE DE CALCULO IRRF', value: 7.5 },
  { label: 'EMPRESTIMO INSUFICIENCIA', value: 6.0 },
]

const ticks = ['R$ 24.000.000,00', 'R$ 20.000.000,00', 'R$ 16.000.000,00', 'R$ 12.000.000,00', 'R$ 8.000.000,00', 'R$ 4.000.000,00', 'R$ 0,00']

interface Row {
  ger: string
  nome: string
  p1: string
  p2?: string
  dif?: string
  origem: string
  pct: string
  neg?: boolean
}

const rows: Row[] = [
  { ger: '20', nome: 'SALÁRIOS E ORDENADOS', p1: 'R$14.650.888,42', p2: 'R$9.487.081,37', dif: '-R$5.163.807,05', origem: 'Folha', pct: '-35,25', neg: true },
  { ger: '20', nome: 'SALÁRIOS E ORDENADOS', p1: 'R$690,02', origem: 'Folha', pct: '-' },
  { ger: '20', nome: 'SALÁRIOS E ORDENADOS', p1: 'R$4.150,00', p2: 'R$1.000,00', dif: '-R$3.150,00', origem: 'Folha', pct: '-75,90', neg: true },
  { ger: '2', nome: 'ADICIONAIS, AUXÍLIOS, GRATIFIC', p1: 'R$872.684,44', p2: 'R$946.944,98', dif: 'R$74.260,54', origem: 'Folha', pct: '8,51' },
  { ger: '20', nome: 'SALÁRIOS E ORDENADOS', p1: 'R$233,30', p2: 'R$69,50', dif: '-R$163,80', origem: 'Folha', pct: '-70,21', neg: true },
  { ger: '2', nome: 'ADICIONAIS, AUXÍLIOS, GRATIFIC', p1: 'R$40.331,39', p2: 'R$21.109,40', dif: '-R$19.221,99', origem: 'Folha', pct: '-47,66', neg: true },
  { ger: '2', nome: 'ADICIONAIS, AUXÍLIOS, GRATIFIC', p1: 'R$199.465,97', p2: 'R$61.662,56', dif: '-R$137.803,41', origem: 'Folha', pct: '-69,09', neg: true },
  { ger: '20', nome: 'SALÁRIOS E ORDENADOS', p1: 'R$7.365,48', origem: 'Rescisão', pct: '-' },
  { ger: '13', nome: 'HORAS EXTRAS, BANCO DE HORAS E', p1: 'R$259,93', p2: 'R$319.747,68', dif: 'R$319.487,75', origem: 'Folha', pct: '122.913,00' },
  { ger: '10', nome: 'EVENTOS DE ATESTADOS E AFASTAM', p1: 'R$3.629,77', p2: 'R$1.568,60', dif: '-R$2.061,17', origem: 'Folha', pct: '-56,79', neg: true },
  { ger: '20', nome: 'SALÁRIOS E ORDENADOS', p1: 'R$590,91', p2: 'R$648,21', dif: 'R$57,30', origem: 'Folha', pct: '9,70' },
]

const filters = [
  ['Tipo histórico', 'Empresa'],
  ['Empresa', '700 - NATCORP DO BR'],
  ['Período 1', 'ABR/2025'],
  ['Período 2', 'MAI/2025'],
]

function Check() {
  return <span className="inline-flex h-4 w-4 items-center justify-center rounded-[3px] border-2 border-[#2E9E6B] text-[10px] font-bold leading-none text-[#2E9E6B]">✓</span>
}

function ComparisonTable() {
  const head = ['Tipo Rubrica', 'Gerencial', 'Nome Gerencial', 'ABR/2025', 'MAI/2025', 'Diferença', 'Origem', '%', 'Incide INSS', 'Incide FGTS', 'Incide IR', 'Incide Líquido']
  return (
    <table className="w-full border-collapse text-[12.5px]">
      <thead>
        <tr className="text-left text-brand-ink">
          {head.map((h) => (
            <th key={h} className="border-b border-brand-mist px-2.5 py-2.5 align-bottom font-bold leading-tight">
              {h}
            </th>
          ))}
        </tr>
      </thead>
      <tbody>
        {rows.map((r, i) => (
          <tr key={i} className={cn('border-b border-brand-mist', r.neg && 'bg-[#FADBD8]')}>
            <td className="px-2.5 py-2">Provento</td>
            <td className="px-2.5 py-2">{r.ger}</td>
            <td className="whitespace-nowrap px-2.5 py-2">{r.nome}</td>
            <td className="whitespace-nowrap px-2.5 py-2 tabular">{r.p1}</td>
            <td className="whitespace-nowrap px-2.5 py-2 tabular">{r.p2}</td>
            <td className="whitespace-nowrap px-2.5 py-2 tabular">{r.dif}</td>
            <td className="px-2.5 py-2">{r.origem}</td>
            <td className="px-2.5 py-2 tabular">{r.pct}</td>
            {[0, 1, 2, 3].map((k) => (
              <td key={k} className="px-2.5 py-2 text-center">
                <Check />
              </td>
            ))}
          </tr>
        ))}
      </tbody>
    </table>
  )
}

/** Comparativo de Históricos Financeiros entre dois períodos, em modo gráfico ou tabela. Use dentro de um ScaledFrame com ANALYTICS_SIZE. */
export function FinancialComparison({ mode = 'chart' }: { mode?: ComparisonMode }) {
  return (
    <PanelShell
      subnav={<SubNav items={[{ label: 'Administração de Pessoal' }, { label: 'Folha de Pagamento', caret: true }, { label: 'Histórico Financeiro', caret: true, active: true }]} />}
      activeRail={8}
    >
      <div className="flex h-full flex-col">
        <div className="flex items-center gap-4 px-3 pb-2 pt-3">
          <span className="flex h-[74px] w-[74px] items-center justify-center rounded-md bg-[#C4507F] text-white">
            <History className="h-9 w-9" strokeWidth={1.8} />
          </span>
          <div>
            <p className="text-[31px] leading-tight text-brand-ink">Comparativos de Históricos Financeiros</p>
            <p className="text-[15px] italic text-brand-graphite">Comparativo de Históricos Financeiros entre dois períodos</p>
          </div>
          <span className="ml-auto flex h-9 w-9 items-center justify-center rounded border border-brand-mist bg-white">
            <RotateCcw className="h-4 w-4" strokeWidth={1.8} />
          </span>
        </div>

        <div className="flex min-h-0 flex-1 border-t border-brand-mist">
          <aside className="w-[270px] shrink-0 border-r border-brand-mist bg-white">
            <p className="border-l-4 border-l-brand-purple px-4 py-3 text-[19px]">Filtros</p>
            <div className="space-y-3 px-3 pt-1">
              {filters.map(([k, v]) => (
                <div key={k} className="flex overflow-hidden rounded border border-brand-mist">
                  <span className="relative min-w-0 flex-1 px-3 py-1.5">
                    <span className="absolute left-0 top-0 h-2 w-2 bg-[#EF5A4A] [clip-path:polygon(0_0,100%_0,0_100%)]" />
                    <span className="block text-[10.5px] uppercase text-brand-graphite">{k}</span>
                    <span className="block truncate text-[14px] text-brand-ink">{v}</span>
                  </span>
                  <span className="flex w-11 shrink-0 items-center justify-center border-l border-brand-mist">
                    <List className="h-4 w-4 text-brand-graphite" strokeWidth={1.8} />
                  </span>
                </div>
              ))}
              <span className="mt-2 flex h-10 items-center justify-center gap-2 rounded bg-brand-blue text-[14px] font-bold text-white">
                <Search className="h-4 w-4" strokeWidth={2.2} /> Pesquisar
              </span>
            </div>
          </aside>

          <div className="flex min-w-0 flex-1 flex-col overflow-hidden bg-white p-3">
            <ReportToolbar mode={mode} highlightActions={mode === 'table'} />
            <ChipRow kind={mode === 'chart' ? 'edit' : 'highlight'} />
            <div className="mt-2 min-h-0 flex-1 overflow-hidden">
              {mode === 'chart' ? (
                <VBars items={bars} max={24} ticks={ticks} labels="vertical" labelHeight={150} gap="3%" />
              ) : (
                <div className="overflow-hidden">
                  <ComparisonTable />
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </PanelShell>
  )
}
