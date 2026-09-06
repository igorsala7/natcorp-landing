import type { DeckSlideDef } from '../Deck'
import { notes } from '@/content/presentation'
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
import { ConexoesSlide, NatiSlide, SegurancaSlide } from './platform'
import { CadeirasSlide, ComercialSlide, ComparativoSlide, ConfiancaSlide, ImplantacaoSlide, ResultadosSlide } from './business'
import { ContatoSlide, EsperaSlide, ProximosSlide } from './closing'

/** A sequência da apresentação executiva: id, capítulo (índice), título (eyebrow e índice) e componente. */
export const deckSlides: DeckSlideDef[] = (
  [
    { id: 'capa', chapter: 'Abertura', title: 'A transformação que seu RH precisa', Component: CoverSlide },
    { id: 'momento', chapter: 'Abertura', title: 'O momento', Component: MomentoSlide },
    { id: 'custo', chapter: 'O problema', title: 'O custo do RH operacional', Component: CustoSlide },
    { id: 'resposta', chapter: 'A resposta', title: 'Todo o RH. Um único sistema.', Component: RespostaSlide },
    { id: 'plataforma', chapter: 'A plataforma', title: 'Sete frentes, mais de 30 módulos', Component: PlataformaSlide },
    { id: 'pessoal-e-folha', chapter: 'A plataforma', title: 'Pessoal e Folha', Component: PessoalFolhaSlide },
    { id: 'ponto-e-jornada', chapter: 'A plataforma', title: 'Ponto e Jornada', Component: PontoJornadaSlide },
    { id: 'saude-e-seguranca', chapter: 'A plataforma', title: 'Saúde e Segurança', Component: SaudeSegurancaSlide },
    { id: 'talentos', chapter: 'A plataforma', title: 'Talentos', Component: TalentosSlide },
    { id: 'desenvolvimento', chapter: 'A plataforma', title: 'Desenvolvimento', Component: DesenvolvimentoSlide },
    { id: 'autoatendimento', chapter: 'A plataforma', title: 'Autoatendimento', Component: AutoatendimentoSlide },
    { id: 'dados-ia-plataforma', chapter: 'A plataforma', title: 'Dados, IA e Plataforma', Component: DadosPlataformaSlide },
    { id: 'nati', chapter: 'A plataforma', title: 'NATI, a inteligência artificial', Component: NatiSlide },
    { id: 'seguranca', chapter: 'Tecnologia', title: 'Segurança e infraestrutura', Component: SegurancaSlide },
    { id: 'conexoes', chapter: 'Tecnologia', title: 'Conexões e performance', Component: ConexoesSlide },
    { id: 'resultados', chapter: 'Resultados', title: 'Resultados', Component: ResultadosSlide },
    { id: 'cadeiras', chapter: 'Resultados', title: 'Para cada cadeira na mesa', Component: CadeirasSlide },
    { id: 'comparativo', chapter: 'Por que Natcorp', title: 'Natcorp x outros sistemas', Component: ComparativoSlide },
    { id: 'comercial', chapter: 'Por que Natcorp', title: 'Modelo comercial', Component: ComercialSlide },
    { id: 'implantacao', chapter: 'Por que Natcorp', title: 'Implantação e acompanhamento', Component: ImplantacaoSlide },
    { id: 'confianca', chapter: 'Por que Natcorp', title: 'Quem confia', Component: ConfiancaSlide },
    { id: 'espera', chapter: 'Fechamento', title: 'O custo de esperar', Component: EsperaSlide },
    { id: 'proximos', chapter: 'Fechamento', title: 'Próximos passos', Component: ProximosSlide },
    { id: 'contato', chapter: 'Fechamento', title: 'Vamos conversar', Component: ContatoSlide },
  ] satisfies Omit<DeckSlideDef, 'notes'>[]
).map((s) => ({ ...s, notes: notes[s.id] }))
