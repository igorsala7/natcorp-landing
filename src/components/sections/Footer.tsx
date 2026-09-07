import { ArrowUp, Mail, MapPin, MessageCircle, Phone } from 'lucide-react'
import { Link } from 'react-router'
import { Logo } from '@/components/brand/Logo'
import { groups } from '@/content/modulePages'
import { paths, siteConfig } from '@/content/site'
import { segmentPath, segmentRegistry, segmentsPath } from '@/content/segments'

const footerLinks = [
  { to: paths.home, label: 'Início' },
  { to: paths.modules, label: 'Todos os módulos' },
  { to: paths.portals, label: 'Portais e autoatendimento' },
  { to: '/portais/natcorp', label: 'Acesso aos portais (clientes)' },
  { to: paths.structures, label: 'Como é a sua estrutura?' },
  { to: paths.nati, label: 'NATI' },
  { to: paths.segments, label: 'Segmentos' },
  { to: paths.journey, label: 'Jornada do colaborador' },
  { to: paths.security, label: 'Segurança e infraestrutura' },
  { to: paths.commercial, label: 'Modelo comercial' },
  { to: paths.faq, label: 'Perguntas frequentes' },
  { to: paths.about, label: 'Sobre a Natcorp' },
  { to: paths.contact, label: 'Contato' },
]

export function Footer() {
  return (
    <footer className="on-dark bg-brand-blue pb-8 pt-16 text-white sm:pt-20">
      <div className="container">
        <div className="grid gap-12 sm:grid-cols-2 lg:grid-cols-[1.3fr_1fr_1fr_1fr_1fr]">
          <div>
            <Logo variant="horizontal" tone="white" className="h-10 w-auto" />
            <p className="mt-6 max-w-xs text-[15px] font-semibold leading-snug">{siteConfig.tagline}</p>
            <p className="mt-2 max-w-xs text-sm leading-relaxed text-white/60">
              HR Tech brasileira. Há mais de 35 anos, tecnologia para a gestão de pessoas de grandes empresas:
              Departamento Pessoal, Recursos Humanos, Medicina e Segurança do Trabalho.
            </p>
            <p className="mt-6 inline-flex items-center gap-2 rounded-full border border-white/15 px-3 py-1 text-[11px] font-semibold uppercase tracking-[0.14em] text-white/70">
              Parceiro Oracle
            </p>
          </div>

          <nav aria-label="Seções do site">
            <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-white/50">Navegue</p>
            <ul className="mt-4 space-y-2.5">
              {footerLinks.map((l) => (
                <li key={l.to}>
                  <Link to={l.to} className="text-sm font-medium text-white/80 transition-colors hover:text-white">
                    {l.label}
                  </Link>
                </li>
              ))}
              <li>
                <Link to="#contato" className="text-sm font-semibold text-white transition-colors hover:text-[#E4A9C4]">
                  Agendar demonstração
                </Link>
              </li>
            </ul>
          </nav>

          <nav aria-label="Módulos">
            <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-white/50">Módulos</p>
            <ul className="mt-4 space-y-2.5">
              {groups.map((g) => (
                <li key={g.id}>
                  <Link to={`${paths.modules}#${g.id}`} className="text-sm font-medium text-white/80 transition-colors hover:text-white">
                    {g.name}
                  </Link>
                </li>
              ))}
              <li>
                <Link to={paths.modules} className="text-sm font-semibold text-white transition-colors hover:text-[#E4A9C4]">
                  Todos os módulos
                </Link>
              </li>
            </ul>
          </nav>

          <nav aria-label="Segmentos">
            <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-white/50">Segmentos</p>
            <ul className="mt-4 space-y-2.5">
              {segmentRegistry.map((s) => (
                <li key={s.slug}>
                  <Link to={segmentPath(s.slug)} className="text-sm font-medium text-white/80 transition-colors hover:text-white">
                    {s.label}
                  </Link>
                </li>
              ))}
              <li>
                <Link to={segmentsPath} className="text-sm font-semibold text-white transition-colors hover:text-[#E4A9C4]">
                  Todos os segmentos
                </Link>
              </li>
            </ul>
          </nav>

          <div>
            <p className="text-[12px] font-semibold uppercase tracking-[0.16em] text-white/50">Contato</p>
            <ul className="mt-4 space-y-3 text-sm text-white/80">
              <li className="flex items-start gap-2.5">
                <Phone className="mt-0.5 h-4 w-4 shrink-0 text-white/50" strokeWidth={1.6} aria-hidden />
                <a href={siteConfig.phoneHref} className="transition-colors hover:text-white">
                  <span className="sr-only">Telefone: </span>
                  {siteConfig.phone}
                </a>
              </li>
              <li className="flex items-start gap-2.5">
                <MessageCircle className="mt-0.5 h-4 w-4 shrink-0 text-white/50" strokeWidth={1.6} aria-hidden />
                <a href={siteConfig.whatsappHref} target="_blank" rel="noreferrer noopener" className="transition-colors hover:text-white">
                  <span className="sr-only">WhatsApp: </span>
                  {siteConfig.whatsapp}
                </a>
              </li>
              <li className="flex items-start gap-2.5">
                <Mail className="mt-0.5 h-4 w-4 shrink-0 text-white/50" strokeWidth={1.6} aria-hidden />
                <a href={`mailto:${siteConfig.email}`} className="break-all transition-colors hover:text-white">
                  {siteConfig.email}
                </a>
              </li>
              <li className="flex items-start gap-2.5">
                <MapPin className="mt-0.5 h-4 w-4 shrink-0 text-white/50" strokeWidth={1.6} aria-hidden />
                <span>
                  {siteConfig.city}
                  <span className="mt-0.5 block text-[12.5px] text-white/55">{siteConfig.coverage}</span>
                </span>
              </li>
              <li>
                <a href={siteConfig.url} className="font-semibold text-white transition-colors hover:text-[#E4A9C4]">
                  natcorp.com.br
                </a>
              </li>
            </ul>
          </div>
        </div>

        <div className="mt-14 flex flex-col gap-4 border-t border-white/10 pt-6 text-xs text-white/50 md:flex-row md:items-center md:justify-between">
          <p>© {new Date().getFullYear()} Natcorp. Todos os direitos reservados.</p>
          <p>Dados tratados em conformidade com a LGPD (Lei nº 13.709/2018).</p>
          <div className="flex flex-wrap items-center gap-x-5 gap-y-2">
            <Link to={paths.motion} className="font-semibold text-white/70 transition-colors hover:text-white">
              Motion da marca
            </Link>
            <Link to="#top" className="inline-flex items-center gap-1.5 font-semibold text-white/70 transition-colors hover:text-white">
              Voltar ao topo
              <ArrowUp className="h-3.5 w-3.5" aria-hidden />
            </Link>
          </div>
        </div>
      </div>
    </footer>
  )
}
