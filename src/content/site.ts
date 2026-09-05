export const siteConfig = {
  name: 'Natcorp',
  tagline: 'Todo o RH em um único sistema.',
  url: 'https://natcorp.com.br',
  email: 'contato@natcorp.com.br',
  phone: '+55 11 5096-0711',
  phoneHref: 'tel:+551150960711',
  whatsapp: '+55 11 97446-6729',
  whatsappHref: 'https://wa.me/5511974466729',
  city: 'Barueri e São Paulo · SP',
  coverage: 'Atendemos todo o território nacional.',
  youtube: 'https://www.youtube.com/@natcorpbr',
  defaultTitle: 'Natcorp — Todo o RH em um único sistema | Sistema de RH para grandes empresas',
  defaultDescription:
    'Folha de pagamento, ponto eletrônico, eSocial, admissão digital, saúde e segurança do trabalho, people analytics e a NATI, nossa inteligência artificial: mais de 30 módulos integrados em um único sistema de RH para grandes empresas. Há mais de 30 anos.',
}

/** Escritórios da Natcorp, como constam na página "Fale conosco" do site anterior. */
export const offices = [
  {
    name: 'Matriz',
    lines: ['Av. Marcos Penteado de Ulhoa Rodrigues, 939', 'Ed. Jacarandá, 8º andar · Tamboré', 'Barueri · SP · CEP 06460-040'],
  },
  {
    name: 'Brooklin',
    lines: ['Av. das Nações Unidas, 12495', 'Nações Unidas Tower, 15º andar · Brooklin Novo', 'São Paulo · SP · CEP 04578-000'],
  },
  {
    name: 'Centro Operacional',
    lines: ['Rua Américo Brasiliense, 1923', '10º andar · Chácara Santo Antônio', 'São Paulo · SP · CEP 04715-005'],
  },
]

/** Página da jornada do colaborador (história etapa por etapa). */
export const journeyPath = '/jornada-da-contratacao'

/** Links do menu principal. `hash` aponta para seções da página inicial. */
export const navLinks = [
  { hash: '#plataforma', label: 'Plataforma' },
  { hash: '#nati', label: 'NATI' },
  { hash: '#seguranca', label: 'Segurança' },
  { hash: '#por-que-natcorp', label: 'Por que Natcorp' },
  { hash: '#faq', label: 'FAQ' },
] as const
