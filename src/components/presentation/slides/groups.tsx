import { getModuleEntry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import type { GroupId } from '@/content/modulePages/types'
import { moduleGroups } from '@/content/modules'
import { groupAudience, groupHighlights, groupTitles } from '@/content/presentation'
import { Big, Chip, Item, Rise, Slide, SlideLead, SlideTitle, Stagger, type SlideMeta, type SlideTone } from '../Slide'
import { groupVisuals } from './visuals'

interface GroupSlideProps extends SlideMeta {
  group: GroupId
  tone: SlideTone
}

/* Uma frente do sistema: o que ela resolve, três números, os módulos e uma tela real do sistema. */
function GroupSlide({ group, tone, ...meta }: GroupSlideProps) {
  const g = moduleGroups.find((x) => x.id === group)!
  const position = moduleGroups.indexOf(g) + 1
  const visual = groupVisuals[group]
  return (
    <Slide {...meta} tone={tone}>
      <div className="grid gap-[clamp(1.25rem,3vw,3.5rem)] lg:grid-cols-[0.95fr_1.05fr] lg:items-center">
        <div>
          <Rise y={8} className="flex flex-wrap items-center gap-2">
            <Chip tone="purple">
              Frente {position} de {moduleGroups.length}
            </Chip>
            {groupAudience[group].map((a) => (
              <Chip key={a}>{a}</Chip>
            ))}
          </Rise>
          <SlideTitle text={groupTitles[group]} className="mt-4 text-[length:calc(var(--dk-h2)*0.86)]" />
          <SlideLead className="mt-3 max-w-[34rem]">{g.description}</SlideLead>
          <Stagger className="mt-[clamp(1rem,3vh,1.75rem)] grid grid-cols-3 gap-3" delay={0.45}>
            {groupHighlights[group].map((h, i) => (
              <Item key={h.label}>
                <Big size="md" value={h.value} label={h.label} accent={i === 0 ? 'pink' : 'purple'} />
              </Item>
            ))}
          </Stagger>
          <Stagger as="ul" className="mt-[clamp(0.75rem,2.5vh,1.5rem)] flex flex-wrap gap-2" delay={0.55} stagger={0.04} aria-label={`Módulos de ${g.name}`}>
            {g.modules.map((mod) => {
              const entry = mod.hash ? undefined : getModuleEntry(mod.slug)
              const Icon = entry ? moduleIcons[entry.icon] : moduleIcons.sparkles
              return (
                <Item key={mod.name} as="li">
                  <Chip tone={mod.hash ? 'neutral' : 'purple'}>
                    <Icon className="h-[1.1em] w-[1.1em]" strokeWidth={1.9} aria-hidden />
                    {mod.name}
                  </Chip>
                </Item>
              )
            })}
          </Stagger>
        </div>
        <Rise delay={0.3} className="min-w-0">
          <div role="img" aria-label={visual.label}>
            {visual.render()}
          </div>
          <p className="mt-2.5 text-center text-[length:var(--dk-small)] leading-snug text-brand-graphite">{visual.caption}</p>
        </Rise>
      </div>
    </Slide>
  )
}

export function PessoalFolhaSlide(meta: SlideMeta) {
  return <GroupSlide {...meta} group="pessoal-e-folha" tone="off" />
}
export function PontoJornadaSlide(meta: SlideMeta) {
  return <GroupSlide {...meta} group="ponto-e-jornada" tone="white" />
}
export function SaudeSegurancaSlide(meta: SlideMeta) {
  return <GroupSlide {...meta} group="saude-e-seguranca" tone="off" />
}
export function TalentosSlide(meta: SlideMeta) {
  return <GroupSlide {...meta} group="talentos" tone="white" />
}
export function DesenvolvimentoSlide(meta: SlideMeta) {
  return <GroupSlide {...meta} group="desenvolvimento" tone="off" />
}
export function AutoatendimentoSlide(meta: SlideMeta) {
  return <GroupSlide {...meta} group="autoatendimento" tone="white" />
}
export function DadosPlataformaSlide(meta: SlideMeta) {
  return <GroupSlide {...meta} group="dados-ia-plataforma" tone="off" />
}
