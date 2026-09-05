export const siteConfig = {
  name: 'Natcorp',
  tagline: 'Todo o RH em um único sistema.',
  url: 'https://natcorp.com.br',
  email: 'contato@natcorp.com.br',
  city: 'São Paulo · SP',
  defaultTitle: 'Natcorp — Todo o RH em um único sistema | Sistema de RH para grandes empresas',
  defaultDescription:
    'Folha de pagamento, ponto eletrônico, eSocial, admissão digital, saúde e segurança do trabalho, people analytics e a NATI, nossa inteligência artificial: mais de 30 módulos integrados em um único sistema de RH para grandes empresas. Há mais de 30 anos.',
}

/** Links do menu principal. `hash` aponta para seções da página inicial. */
export const navLinks = [
  { hash: '#plataforma', label: 'Plataforma' },
  { hash: '#nati', label: 'NATI' },
  { hash: '#seguranca', label: 'Segurança' },
  { hash: '#por-que-natcorp', label: 'Por que Natcorp' },
  { hash: '#faq', label: 'FAQ' },
] as const
