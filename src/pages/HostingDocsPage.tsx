import source from '../../HOSPEDAGEM.md?raw'
import { DocPage } from '@/components/docs/DocPage'
import { useSeo } from '@/hooks/useSeo'
import { siteConfig } from '@/content/site'

/**
 * Documentação técnica de publicação dentro do site (/hospedagem).
 *
 * Lê `HOSPEDAGEM.md` na raiz do repositório — o mesmo arquivo que a empresa de
 * hospedagem recebe. Não há segunda cópia do texto: quem corrige o `.md` corrige
 * a página junto.
 *
 * A entrega principal, porém, é o arquivo autônomo `HOSPEDAGEM.html`
 * (`npm run hospedagem`), que abre com duplo clique e não depende de o site estar
 * publicado. Esta rota é a mesma leitura, para quando o site já estiver no ar.
 *
 * Fora do menu, do sitemap e dos robôs (`noindex`): é material compartilhado por
 * link, e traz configuração de servidor que não interessa a buscador nenhum.
 */
export default function HostingDocsPage() {
  useSeo({
    title: 'Documentação técnica de publicação | Natcorp',
    description:
      'Guia para a equipe de hospedagem publicar o site www.natcorp.com.br: requisitos, regras de servidor, configuração para Apache, Nginx e IIS, e checklist de validação.',
    path: '/hospedagem',
    noindex: true,
  })

  return (
    <DocPage
      source={source}
      label="Documentação técnica de publicação"
      siteUrl={siteConfig.url}
      note={
        <>
          Documento mantido junto com o código do site. A versão em Markdown é o arquivo{' '}
          <code className="font-mono text-brand-graphite">HOSPEDAGEM.md</code>, na raiz do repositório — esta página é a leitura dele.
        </>
      }
    />
  )
}
