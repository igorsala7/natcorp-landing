import { Cookie, Mail, MapPin, Phone, ShieldCheck } from 'lucide-react'
import { Link } from 'react-router'
import { Button } from '@/components/ui/button'
import { reabrirConsentimento } from '@/lib/consent'
import { cn } from '@/lib/utils'
import { Section, Eyebrow } from '@/components/sections/Section'
import { PageTransition } from '@/components/motion/PageTransition'
import { Reveal } from '@/components/motion/Reveal'
import { Breadcrumb } from '@/components/seo/Breadcrumb'
import { LogoOutline } from '@/components/brand/Logo'
import { useSeo } from '@/hooks/useSeo'
import { dpo, type Block, type LegalDoc, type ListItem } from '@/content/legal'
import { paths } from '@/content/site'

/**
 * Página de documento legal (privacidade e termos de uso).
 *
 * O documento antigo era uma parede de 42 mil caracteres. Quem chega aqui quase nunca
 * quer ler tudo: quer achar UMA coisa — normalmente como exercer um direito, ou se os
 * dados dele estão no sistema. Daí o índice fixo à esquerda, a âncora por seção e o
 * cartão do encarregado destacado em vez de escondido no rodapé do texto.
 */
export default function LegalPage({ doc }: { doc: LegalDoc }) {
  useSeo({ title: doc.seo.title, description: doc.seo.description, path: doc.path })

  return (
    <PageTransition>
      <Section
        tone="off"
        className="overflow-hidden pb-10 pt-[calc(var(--nav-h)+3rem)] sm:pt-[calc(var(--nav-h)+4rem)] lg:pb-12 lg:pt-[calc(var(--nav-h)+5rem)]"
        aria-labelledby="legal-title"
      >
        <LogoOutline className="pointer-events-none absolute -right-[14%] -top-[40%] h-[150%] w-auto text-brand-purple/[0.10]" />
        <div className="container relative">
          <Breadcrumb items={[{ label: 'Início', to: '/' }, { label: doc.title }]} />
          <Reveal y={12} duration={0.5} className="mt-8">
            <Eyebrow>Documentos legais</Eyebrow>
          </Reveal>
          <h1 id="legal-title" className="mt-5 max-w-3xl text-4xl font-extrabold leading-[1.06] text-brand-ink sm:text-5xl">
            {doc.title}
          </h1>
          <Reveal delay={0.15}>
            <p className="mt-5 max-w-2xl text-lg leading-relaxed text-brand-graphite">{doc.lead}</p>
            <p className="mt-4 text-sm font-medium text-brand-gray">Última atualização: {doc.updated}</p>
          </Reveal>
        </div>
      </Section>

      <Section tone="white" className="pt-12 sm:pt-14 lg:pt-16">
        <div className="container grid gap-12 lg:grid-cols-[240px_1fr] lg:gap-16">
          {/* Índice: some no celular, onde ocuparia a tela inteira antes do texto começar. */}
          <nav aria-label="Nesta página" className="hidden lg:block">
            <div className="sticky top-32">
              <p className="text-[11px] font-bold uppercase tracking-[0.14em] text-brand-gray">Nesta página</p>
              <ol className="mt-4 space-y-2.5 border-l border-brand-mist">
                {doc.sections.map((s) => (
                  <li key={s.id}>
                    <a
                      href={`#${s.id}`}
                      className="-ml-px block border-l-2 border-transparent pl-4 text-[13.5px] leading-snug text-brand-graphite transition-colors hover:border-brand-purple hover:text-brand-purple focus-visible:border-brand-purple focus-visible:text-brand-purple"
                    >
                      {s.title}
                    </a>
                  </li>
                ))}
              </ol>
            </div>
          </nav>

          <div className="min-w-0 max-w-[68ch]">
            <div className="space-y-5">
              {doc.intro.map((b, i) => (
                <BlockView key={i} block={b} />
              ))}
            </div>

            {doc.sections.map((s) => (
              <section key={s.id} id={s.id} className="mt-14 scroll-mt-32">
                <h2 className="text-2xl font-extrabold leading-tight text-brand-ink sm:text-[1.75rem]">{s.title}</h2>
                <div className="mt-5 space-y-5">
                  {s.blocks.map((b, i) => (
                    <BlockView key={i} block={b} />
                  ))}
                </div>
              </section>
            ))}

            <div className="mt-14 border-t border-brand-mist pt-6">
              <p className="text-[11px] font-bold uppercase tracking-[0.14em] text-brand-gray">Documentos relacionados</p>
              <ul className="mt-3 flex flex-wrap gap-x-6 gap-y-2 text-sm">
                {outrosDocumentos(doc.path).map((o) => (
                  <li key={o.to}>
                    <Link to={o.to} className="font-semibold text-brand-purple underline-offset-2 hover:underline">
                      {o.label}
                    </Link>
                  </li>
                ))}
                <li>
                  <Link to={paths.security} className="font-semibold text-brand-purple underline-offset-2 hover:underline">
                    Segurança e infraestrutura
                  </Link>
                </li>
                {/* Estas páginas não têm o formulário de demonstração, e não devem ter: quem
                    abre a política está resolvendo outra coisa. Mas ficar sem nenhuma saída
                    para falar com a empresa é pior — daí o link para /contato. */}
                <li>
                  <Link to={paths.contact} className="font-semibold text-brand-purple underline-offset-2 hover:underline">
                    Falar com a Natcorp
                  </Link>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </Section>
    </PageTransition>
  )
}

/** Os outros documentos legais, para o leitor não voltar ao rodapé para achá-los. */
function outrosDocumentos(atual: string) {
  return [
    { to: paths.privacy, label: 'Política de Privacidade' },
    { to: paths.terms, label: 'Termos de Uso' },
    { to: paths.cookies, label: 'Política de Cookies' },
  ].filter((d) => d.to !== atual)
}

function BlockView({ block }: { block: Block }) {
  if (block.t === 'p') return <p className="text-[15.5px] leading-relaxed text-brand-graphite">{block.text}</p>

  if (block.t === 'h3')
    return <h3 className="pt-3 text-[17px] font-bold leading-snug text-brand-ink">{block.text}</h3>

  if (block.t === 'ul')
    return (
      <ul className="space-y-3">
        {block.items.map((item, i) => (
          <Item key={i} item={item} />
        ))}
      </ul>
    )

  if (block.t === 'note')
    return (
      <div className="rounded-2xl border border-brand-mist bg-brand-off-white p-5 sm:p-6">
        <p className="flex items-center gap-2 text-[14px] font-bold text-brand-purple">
          <ShieldCheck className="h-4.5 w-4.5 shrink-0" strokeWidth={2} aria-hidden />
          {block.title}
        </p>
        <p className="mt-2.5 text-[15px] leading-relaxed text-brand-graphite">{block.text}</p>
      </div>
    )

  if (block.t === 'table')
    return (
      /* A tabela rola dentro do próprio quadro: no celular ela é mais larga que a
         tela, e sem isto quem rolaria de lado seria a página inteira. */
      <div className="-mx-5 overflow-x-auto px-5 sm:mx-0 sm:px-0">
        <table className="w-full min-w-[34rem] border-collapse text-left text-[14px]">
          <thead>
            <tr>
              {block.head.map((h) => (
                <th
                  key={h}
                  scope="col"
                  className="border-b border-brand-mist-strong pb-2.5 pr-4 text-[11px] font-bold uppercase tracking-[0.1em] text-brand-gray last:pr-0"
                >
                  {h}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {block.rows.map((row) => (
              <tr key={row[0]}>
                {row.map((cell, i) => (
                  <td
                    key={i}
                    className={cn(
                      'border-b border-brand-mist py-3 pr-4 align-top leading-snug text-brand-graphite last:pr-0',
                      i === 0 && 'font-mono text-[13px] font-semibold text-brand-ink',
                    )}
                  >
                    {cell}
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    )

  if (block.t === 'consent') return <ConsentButton />

  /* Cartão do encarregado: é o que a maioria vem buscar. */
  return (
    <div className="rounded-2xl border border-brand-mist bg-white p-5 shadow-soft sm:p-6">
      <p className="text-[11px] font-bold uppercase tracking-[0.14em] text-brand-gray">
        Encarregado pelo tratamento de dados pessoais
      </p>
      <p className="mt-2 text-lg font-extrabold text-brand-ink">{dpo.nome}</p>
      <ul className="mt-4 space-y-3 text-[15px]">
        <li className="flex items-start gap-2.5">
          <Mail className="mt-0.5 h-4.5 w-4.5 shrink-0 text-brand-purple" strokeWidth={1.8} aria-hidden />
          <a
            href={`mailto:${dpo.email}`}
            className="font-semibold text-brand-purple underline-offset-2 hover:underline"
          >
            {dpo.email}
          </a>
        </li>
        <li className="flex items-start gap-2.5">
          <Phone className="mt-0.5 h-4.5 w-4.5 shrink-0 text-brand-purple" strokeWidth={1.8} aria-hidden />
          <a href={dpo.telefoneHref} className="font-semibold text-brand-ink hover:text-brand-purple">
            {dpo.telefone}
          </a>
        </li>
        <li className="flex items-start gap-2.5">
          <MapPin className="mt-0.5 h-4.5 w-4.5 shrink-0 text-brand-purple" strokeWidth={1.8} aria-hidden />
          <span className="leading-relaxed text-brand-graphite">{dpo.endereco}</span>
        </li>
      </ul>
    </div>
  )
}

/**
 * Reabre a barra de consentimento a partir da própria política.
 *
 * A saída tem de estar na página que explica a entrada: mandar o leitor procurar o
 * link no rodapé depois de ler sobre revogação é transformar um direito em caça ao
 * tesouro. É o mesmo `reabrirConsentimento` do rodapé — uma função, dois lugares.
 */
function ConsentButton() {
  return (
    <div className="rounded-2xl border border-brand-mist bg-brand-off-white p-5 sm:p-6">
      <p className="text-[15px] font-bold text-brand-ink">Mudar a sua escolha agora</p>
      <p className="mt-1.5 text-[14.5px] leading-relaxed text-brand-graphite">
        Vale nos dois sentidos: quem recusou pode aceitar, quem aceitou pode recusar.
      </p>
      <Button type="button" onClick={reabrirConsentimento} variant="secondary" className="mt-4">
        <Cookie className="h-4 w-4" strokeWidth={1.8} aria-hidden />
        Rever preferências de cookies
      </Button>
    </div>
  )
}

function Item({ item }: { item: ListItem }) {
  const text = typeof item === 'string' ? item : item.text
  const sub = typeof item === 'string' ? undefined : item.items
  return (
    <li className="relative pl-5 text-[15.5px] leading-relaxed text-brand-graphite">
      <span className="absolute left-0 top-[0.62em] h-1.5 w-1.5 rounded-full bg-brand-purple/60" aria-hidden />
      {text}
      {sub && (
        <ul className="mt-2.5 space-y-2">
          {sub.map((s, i) => (
            <li key={i} className="relative pl-4 text-[15px] text-brand-graphite/90">
              <span className="absolute left-0 top-[0.68em] h-1 w-1 rounded-full bg-brand-gray" aria-hidden />
              {s}
            </li>
          ))}
        </ul>
      )}
    </li>
  )
}
