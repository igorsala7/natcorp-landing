/**
 * Entrada do arquivo autônomo `HOSPEDAGEM.html`.
 *
 * O build desta entrada (`npm run hospedagem`) gera UM arquivo com React, CSS e a
 * fonte Manrope embutidos. Ele abre com duplo clique, sem servidor e sem internet
 * — que é o ponto: a empresa de hospedagem precisa ler a documentação ANTES de o
 * site existir no ar, e o documento não pode depender daquilo que ele mesmo
 * ensina a publicar.
 *
 * A mesma moldura monta a rota /hospedagem dentro do site. O texto é o
 * HOSPEDAGEM.md da raiz, nos dois casos.
 */
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import source from '../../HOSPEDAGEM.md?raw'
import { DocPage } from '@/components/docs/DocPage'
import '@/index.css'

const SITE = 'https://www.natcorp.com.br'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <DocPage
      source={source}
      label="Documentação técnica de publicação"
      siteUrl={SITE}
      note={
        <>
          Arquivo autônomo: não precisa de servidor, de internet nem de instalação — pode ser aberto com um duplo clique, copiado para uma pasta de rede ou anexado em e-mail. Gerado a partir de{' '}
          <code className="font-mono text-brand-graphite">HOSPEDAGEM.md</code>, mantido junto com o código do site. Em caso de dúvida sobre a versão, confirme conosco a data do arquivo.
        </>
      }
    />
  </StrictMode>,
)
