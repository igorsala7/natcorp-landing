/**
 * Documentos legais (Política de Privacidade e Termos de Uso).
 *
 * O texto é o mesmo publicado em www.natcorp.com.br, transcrito na íntegra. O que muda
 * é a apresentação: o documento antigo era uma parede de texto de 42 mil caracteres, e
 * quem chega nele quer resolver UMA coisa — normalmente exercer um direito ou entender
 * se os dados dele estão ali. Por isso o formato é estruturado: índice lateral, âncora
 * por seção e os canais do encarregado destacados, em vez de escondidos no fim.
 */

/** Item de lista: texto simples, ou texto com sub-itens (o documento usa dois níveis). */
export type ListItem = string | { text: string; items: string[] }

export type Block =
  | { t: 'p'; text: string }
  | { t: 'ul'; items: ListItem[] }
  | { t: 'h3'; text: string }
  /** Destaque para o que o leitor precisa entender antes do resto. */
  | { t: 'note'; title: string; text: string }
  /** Bloco de contato do encarregado, renderizado como cartão. */
  | { t: 'contact' }
  /** Inventário de cookies: nome, quem define, para quê, quanto dura. */
  | { t: 'table'; head: string[]; rows: string[][] }
  /** Botão que reabre a barra de consentimento (a saída tem de existir na própria página). */
  | { t: 'consent' }

export interface LegalSection {
  /** Âncora da seção (usada no índice e no endereço). */
  id: string
  title: string
  blocks: Block[]
}

export interface LegalDoc {
  path: string
  /** Título na página (H1). */
  title: string
  /** Linha que explica, em uma frase, o que o documento resolve. */
  lead: string
  updated: string
  seo: { title: string; description: string }
  /** Parágrafos de abertura, antes da primeira seção. */
  intro: Block[]
  sections: LegalSection[]
}

/** Encarregado pelo tratamento de dados pessoais (DPO), conforme Art. 41 da LGPD. */
export const dpo = {
  nome: 'Igor Sala',
  email: 'protecaodedados@natcorp.com.br',
  telefone: '(11) 5096-0711',
  telefoneHref: 'tel:+551150960711',
  endereco: 'Rua Américo Brasiliense, 1923 — 10º andar — Chácara Santo Antônio — São Paulo/SP — CEP 04715-005',
}

/** Dados da empresa, como constam nos Termos de Uso. */
export const empresa = {
  razaoSocial: 'Natcorp Tecnologia Ltda.',
  cnpj: '09.538.744/0001-39',
  endereco:
    'Av. Marcos Penteado de Ulhoa Rodrigues, 939 — Ed. Jacarandá, 8º andar — Tamboré — Barueri/SP — CEP 06460-040',
  foro: 'Barueri/SP',
}
