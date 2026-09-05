import type { ReactNode } from 'react'
import { BarChart3, Camera, ChevronRight, Eraser, List, Maximize2, PieChart, Search } from 'lucide-react'
import { PanelShell, SubNav } from './shell'
import { Pie, PercentRows, VBars, type Slice } from './charts'

const procedures = [
  { label: 'Atestado Medico', value: 11800, color: '#EF5A4A' },
  { label: 'Consulta Medica', value: 4100, color: '#F0872C' },
  { label: 'Exame Funcionario', value: 2200, color: '#F5C242' },
  { label: 'Controle De Doencas', value: 90, color: '#2E9E6B' },
  { label: 'Atendimento Ambulatorial', value: 40, color: '#3B82F6' },
]

const types: Slice[] = [
  { label: '008 - Licença', value: 48, color: '#3B82F6' },
  { label: '007 - Licença Se…', value: 14, color: '#2E9E6B' },
  { label: 'ASO - Atestado D…', value: 9, color: '#F5C242' },
  { label: '01 - Periodico', value: 8, color: '#EF5A4A' },
  { label: '06 - Abono De At…', value: 6, color: '#8E5AAE' },
  { label: '006 - Licença Od…', value: 3, color: '#2FB5A8' },
  { label: '08 - Avaliação', value: 2.5, color: '#F0872C' },
  { label: '07 - Mudança De…', value: 2, color: '#F26D86' },
  { label: '003 - Licença Ac…', value: 1.5, color: '#1E9E9E' },
  { label: '09 - Retorno Ao T…', value: 1.5, color: '#4CAF50' },
  { label: '001 - Licença Ma…', value: 1, color: '#C85BA1' },
  { label: '009 - Epf', value: 1, color: '#C9D63B' },
  { label: '02 - Consulta Oc…', value: 1, color: '#2E86DE' },
]

const units = [
  { label: '018 - Sistema Unico De Saude', pct: 26.79, color: '#F26D6D' },
  { label: '001 - Saúde Ocupacional Natcorp', pct: 22.71, color: '#F0872C' },
  { label: '999 - Clínica Externa', pct: 21.11, color: '#F5C242' },
  { label: '', pct: 10.91, color: '#4CAF50' },
  { label: '012 - Clínica Vida Ocupacional Ltda', pct: 7.7, color: '#6CB4EE' },
  { label: '021 - Centro Médico Norte', pct: 5.79, color: '#2E86DE' },
  { label: '35 -', pct: 1.31, color: '#8E5AAE' },
]

const professionals = [
  { label: '030 - Medico Externo', pct: 64.55, color: '#F26D6D' },
  { label: '016 - Dra. Marina Castro', pct: 9.38, color: '#F0872C' },
  { label: '021 - Dr. Paulo Mendes', pct: 7.1, color: '#F5C242' },
]

function CardTools() {
  return (
    <span className="flex shrink-0 items-center gap-1 text-[11px] text-brand-ink">
      <span className="flex h-8 items-center gap-1 rounded border border-brand-mist bg-white px-1.5">
        % <List className="h-3.5 w-3.5" strokeWidth={1.8} />
      </span>
      <span className="flex h-8 items-center gap-1 rounded border border-brand-mist bg-white px-1.5">
        Qtd. <List className="h-3.5 w-3.5" strokeWidth={1.8} />
      </span>
      <span className="flex h-8 w-8 items-center justify-center rounded border border-brand-mist bg-white">
        <PieChart className="h-3.5 w-3.5" strokeWidth={1.8} />
      </span>
      <span className="flex h-8 w-8 items-center justify-center rounded border border-brand-mist bg-white">
        <BarChart3 className="h-3.5 w-3.5" strokeWidth={1.8} />
      </span>
      <span className="flex h-8 w-8 items-center justify-center rounded border border-brand-mist bg-white">
        <Camera className="h-3.5 w-3.5" strokeWidth={1.8} />
      </span>
    </span>
  )
}

function Card({ title, children, className, bodyClassName }: { title: string; children: ReactNode; className?: string; bodyClassName?: string }) {
  return (
    <div className={`flex min-h-0 flex-col overflow-hidden rounded-md border border-brand-mist bg-white ${className ?? ''}`}>
      <div className="flex min-h-[54px] shrink-0 items-center gap-2 border-b border-brand-mist border-l-4 border-l-brand-purple py-1.5 pl-3 pr-2.5">
        <p className="min-w-0 flex-1 text-[15px] leading-tight text-brand-ink">{title}</p>
        <CardTools />
        <Maximize2 className="ml-1 h-4 w-4 shrink-0 text-brand-ink" strokeWidth={1.8} />
      </div>
      <div className={`min-h-0 flex-1 ${bodyClassName ?? 'p-4'}`}>{children}</div>
    </div>
  )
}

/** Indicadores de Medicina Ocupacional (painel pronto), reproduzido em HTML/CSS. Use dentro de um ScaledFrame com ANALYTICS_SIZE. */
export function MedicineIndicators() {
  return (
    <PanelShell subnav={<SubNav items={[{ label: 'Indicadores', caret: true, active: true }]} />} activeRail={8}>
      <div className="flex h-full flex-col gap-3 p-3">
        <p className="flex items-center gap-2 px-2 text-[15px] text-brand-ink">
          Indicadores <span className="text-brand-graphite">\</span> Medicina Ocupacional <span className="text-brand-graphite">\</span>
        </p>

        <div className="flex items-center gap-3 rounded-md border border-brand-mist border-l-4 border-l-brand-purple bg-white px-4 py-2">
          <span className="flex h-7 w-7 items-center justify-center rounded border border-brand-mist text-brand-ink">
            <ChevronRight className="h-3.5 w-3.5" strokeWidth={2.5} />
          </span>
          <span className="text-[19px]">Filtros</span>
          <span className="ml-auto flex overflow-hidden rounded border border-brand-mist text-[13.5px] text-brand-ink">
            <span className="flex items-center gap-2 border-r border-brand-mist bg-white px-4 py-2">
              Pesquisar <Search className="h-4 w-4" strokeWidth={1.8} />
            </span>
            <span className="flex items-center gap-2 bg-white px-4 py-2">
              Limpar Filtros <Eraser className="h-4 w-4" strokeWidth={1.8} />
            </span>
          </span>
        </div>

        <div className="flex items-center justify-between rounded-md border border-brand-mist border-l-4 border-l-brand-purple bg-white px-4 py-2">
          <p className="text-[19px]">Indicadores: Medicina</p>
          <span className="flex items-center gap-2">
            <span className="flex h-9 w-11 items-center justify-center rounded border border-brand-mist">
              <Camera className="h-4 w-4" strokeWidth={1.8} />
            </span>
            <Maximize2 className="ml-2 h-4 w-4" strokeWidth={1.8} />
          </span>
        </div>

        <div className="grid min-h-0 flex-1 grid-cols-3 gap-3">
          <Card title="Procedimentos" bodyClassName="p-4 pb-2">
            <VBars items={procedures} max={12000} ticks={['12K', '10K', '8K', '6K', '4K', '2K', '0']} labels="diagonal" labelHeight={96} gap="8%" />
          </Card>
          <Card title="Tipo de Procedimentos">
            <Pie slices={types} size={215} />
          </Card>
          <Card title="Unidade de Atendimento" bodyClassName="px-4 py-1">
            <PercentRows rows={units} dense />
          </Card>
        </div>

        <div className="shrink-0 rounded-md border border-brand-mist bg-white">
          <div className="flex items-center gap-3 border-b border-brand-mist border-l-4 border-l-brand-purple py-2 pl-4 pr-3">
            <p className="text-[17px]">Profissionais</p>
            <CardTools />
            <Maximize2 className="ml-auto h-4 w-4 text-brand-ink" strokeWidth={1.8} />
          </div>
          <div className="px-4 py-1">
            <PercentRows rows={professionals} dense className="[&>li]:grid-cols-[260px_160px_64px] [&>li]:justify-start" />
          </div>
        </div>
      </div>
    </PanelShell>
  )
}
