/** Injeta um bloco JSON-LD na página (lido por buscadores após a renderização). */
export function JsonLd({ data }: { data: object }) {
  return <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }} />
}
