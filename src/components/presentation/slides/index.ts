import type { DeckSlideDef } from '../Deck'
import { notes, type DeckVersion } from '@/content/presentation'
import { CoverSlide, CustoSlide, MomentoSlide, PlataformaSlide, RespostaSlide } from './opening'
import {
  AutoatendimentoSlide,
  DadosPlataformaSlide,
  DesenvolvimentoSlide,
  PessoalFolhaSlide,
  PontoJornadaSlide,
  SaudeSegurancaSlide,
  TalentosSlide,
} from './groups'
import { AnalyticsSlide, AntesDepoisSlide, DiaNoRhSlide, FechamentoSlide, JornadaSlide, NatiCanaisSlide, PortaisSlide } from './story'
import { ConexoesSlide, NatiSlide, SegurancaSlide } from './platform'
import { CadeirasSlide, ComercialSlide, ComparativoSlide, ConfiancaSlide, ImplantacaoSlide, ResultadosSlide } from './business'
import { ContatoSlide, EsperaSlide, ProximosSlide } from './closing'

/**
 * A sequência da apresentação comercial: id, capítulo (índice), título (eyebrow e índice),
 * componente e se entra na versão reduzida (`short`). A ordem conta a história do RH:
 * o dia de hoje, o sistema resolvendo frente a frente, a tecnologia, os resultados e o convite.
 */
const all: DeckSlideDef[] = (
  [
    { id: 'capa', chapter: 'Abertura', title: 'A transformação que seu RH precisa', Component: CoverSlide, short: true },
    { id: 'dia-no-rh', chapter: 'Abertura', title: 'Um dia no seu RH', Component: DiaNoRhSlide, short: true },
    { id: 'custo', chapter: 'O problema', title: 'O custo do RH operacional', Component: CustoSlide },
    { id: 'momento', chapter: 'O problema', title: 'O momento', Component: MomentoSlide },
    { id: 'resposta', chapter: 'A resposta', title: 'Todo o RH. Um único sistema.', Component: RespostaSlide, short: true },
    { id: 'plataforma', chapter: 'A resposta', title: 'Sete frentes, mais de 30 módulos', Component: PlataformaSlide, short: true },
    { id: 'pessoal-e-folha', chapter: 'O sistema no dia a dia', title: 'Pessoal e Folha', Component: PessoalFolhaSlide },
    { id: 'fechamento', chapter: 'O sistema no dia a dia', title: 'O fechamento em quatro minutos', Component: FechamentoSlide, short: true },
    { id: 'ponto-e-jornada', chapter: 'O sistema no dia a dia', title: 'Ponto e Jornada', Component: PontoJornadaSlide, short: true },
    { id: 'saude-e-seguranca', chapter: 'O sistema no dia a dia', title: 'Saúde e Segurança', Component: SaudeSegurancaSlide },
    { id: 'talentos', chapter: 'O sistema no dia a dia', title: 'Talentos', Component: TalentosSlide },
    { id: 'jornada', chapter: 'O sistema no dia a dia', title: 'Da vaga à promoção: a jornada de Ana', Component: JornadaSlide, short: true },
    { id: 'desenvolvimento', chapter: 'O sistema no dia a dia', title: 'Desenvolvimento', Component: DesenvolvimentoSlide },
    { id: 'autoatendimento', chapter: 'O sistema no dia a dia', title: 'Autoatendimento', Component: AutoatendimentoSlide, short: true },
    { id: 'portais', chapter: 'O sistema no dia a dia', title: 'Portais e NatPonto', Component: PortaisSlide, short: true },
    { id: 'dados-ia-plataforma', chapter: 'Dados e inteligência artificial', title: 'Dados, IA e Plataforma', Component: DadosPlataformaSlide },
    { id: 'analytics', chapter: 'Dados e inteligência artificial', title: 'People Analytics', Component: AnalyticsSlide },
    { id: 'nati', chapter: 'Dados e inteligência artificial', title: 'NATI, a inteligência artificial', Component: NatiSlide, short: true },
    { id: 'nati-canais', chapter: 'Dados e inteligência artificial', title: 'A NATI onde o colaborador está', Component: NatiCanaisSlide },
    { id: 'antes-e-depois', chapter: 'Dados e inteligência artificial', title: 'A mesma rotina, antes e depois', Component: AntesDepoisSlide, short: true },
    { id: 'seguranca', chapter: 'Tecnologia', title: 'Segurança e infraestrutura', Component: SegurancaSlide },
    { id: 'conexoes', chapter: 'Tecnologia', title: 'Conexões e performance', Component: ConexoesSlide },
    { id: 'resultados', chapter: 'Resultados', title: 'Resultados', Component: ResultadosSlide, short: true },
    { id: 'cadeiras', chapter: 'Resultados', title: 'Para cada cadeira na mesa', Component: CadeirasSlide },
    { id: 'comparativo', chapter: 'Por que Natcorp', title: 'Natcorp x outros sistemas', Component: ComparativoSlide, short: true },
    { id: 'comercial', chapter: 'Por que Natcorp', title: 'Modelo comercial', Component: ComercialSlide, short: true },
    { id: 'implantacao', chapter: 'Por que Natcorp', title: 'Implantação e acompanhamento', Component: ImplantacaoSlide },
    { id: 'confianca', chapter: 'Por que Natcorp', title: 'Quem confia', Component: ConfiancaSlide, short: true },
    { id: 'espera', chapter: 'Fechamento', title: 'O custo de esperar', Component: EsperaSlide },
    { id: 'proximos', chapter: 'Fechamento', title: 'Próximos passos', Component: ProximosSlide, short: true },
    { id: 'contato', chapter: 'Fechamento', title: 'Vamos conversar', Component: ContatoSlide, short: true },
  ] satisfies Omit<DeckSlideDef, 'notes'>[]
).map((s) => ({ ...s, notes: notes[s.id] }))

/** Os slides de uma versão: a completa leva todos; a reduzida, os marcados com `short`. */
export function deckSlidesFor(version: DeckVersion): DeckSlideDef[] {
  return version === 'reduzida' ? all.filter((s) => s.short) : all
}

/** Compatibilidade: a lista completa. */
export const deckSlides = all
