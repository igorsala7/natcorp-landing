import { getModuleEntry } from '@/content/modulePages'
import { moduleIcons } from '@/content/modulePages/icons'
import type { GroupId } from '@/content/modulePages/types'
import { moduleGroups } from '@/content/modules'
import { groupAudience, groupHighlights, groupTitles } from '@/content/presentation'
import { Big, Card, Chip, IconBox, Item, Rise, Slide, SlideLead, SlideTitle, Stagger, type SlideMeta, type SlideTone } from '../Slide'

interface GroupSlideProps extends SlideMeta {
  group: GroupId
  tone: SlideTone
}

/* Uma frente do sistema: título, o que ela entrega, três números e os módulos em cartões. */
function GroupSlide({ group, tone, ...meta }: GroupSlideProps) {
  const g = moduleGroups.find((x) => x.id === group)!
  const position = moduleGroups.indexOf(g) + 1
  const mods = g.modules.filter((m) => !m.hash)
  const feats = g.modules.filter((m) => m.hash)
  return (
    <Slide {...meta} tone={tone}>
      <div className="grid gap-[clamp(1.25rem,3vw,3.5rem)] lg:grid-cols-[0.95fr_1.2fr] lg:items-center">
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
          <SlideLead className="mt-4 max-w-[34rem]">{g.description}</SlideLead>
          <Stagger className="mt-[clamp(1.25rem,3.5vh,2.25rem)] grid grid-cols-3 gap-3" delay={0.45}>
            {groupHighlights[group].map((h, i) => (
              <Item key={h.label}>
                <Big size="md" value={h.value} label={h.label} accent={i === 0 ? 'pink' : 'purple'} />
              </Item>
            ))}
          </Stagger>
        </div>
        <div className="min-w-0">
          <Stagger className={mods.length > 4 ? 'grid gap-2.5 sm:grid-cols-2' : 'grid gap-2.5 sm:grid-cols-2'} delay={0.3} stagger={0.06}>
            {mods.map((mod) => {
              const entry = getModuleEntry(mod.slug)
              const Icon = entry ? moduleIcons[entry.icon] : moduleIcons.sparkles
              return (
                <Item key={mod.name}>
                  <Card className="flex h-full gap-3">
                    <IconBox>
                      <Icon strokeWidth={1.7} />
                    </IconBox>
                    <div className="min-w-0">
                      <p className="text-[length:var(--dk-body)] font-bold leading-tight text-brand-ink">{mod.name}</p>
                      <p className="mt-1 text-[length:var(--dk-small)] leading-snug text-brand-graphite">{mod.desc}</p>
                    </div>
                  </Card>
                </Item>
              )
            })}
          </Stagger>
          {feats.length > 0 && (
            <Rise delay={0.6} y={8} className="mt-3 flex flex-wrap items-center gap-2">
              <span className="text-[length:var(--dk-small)] font-semibold text-brand-graphite">Também nesta frente:</span>
              {feats.map((f) => (
                <Chip key={f.name} tone="purple">
                  {f.name}
                </Chip>
              ))}
            </Rise>
          )}
        </div>
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
