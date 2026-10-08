# OnBoarding — app 300 (Portal do Colaborador), página 2500

Onde o colaborador novo recebe as instruções iniciais da empresa. As **categorias** e as **publicações**
são cadastradas pelo cliente (tabelas `ONBOARDING_CATEGORIA` e `ONBOARDING`): nada de conteúdo é fixo
no desenho. Público: colaboradores, muitos com pouca leitura, 80% no celular (pedido de 04/10).

Arquivos: `Natcorp_Onboarding.src.js` / `.src.css` → `../login/Natcorp_Onboarding.js` / `.css`.
JS: `python3 gerar-onboarding.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-onboarding-pagina2500.py f300_page_2500.sql` (aplicada em 04/10; original
em `f300_page_2500.ORIGINAL.sql`). Só as File URLs e o comentário da página.

## Como ficou

| Onde | O quê |
|---|---|
| O alto | "Seus primeiros passos" (no lugar de "OnBoarding \| categoria") + a frase original. No celular, ícone e título na mesma linha |
| O caminho | Cada categoria é uma **parte**: "Parte 1 de 5", o nome em destaque, uma barra com uma fatia por parte (roxa = atual, mais clara = vista). Celular: "Ver todas as partes" abre a lista logo abaixo. Computador: a lista fica numa coluna à esquerda e acompanha a rolagem |
| Vista | A parte conta como vista quando a pessoa chega ao fim dela (o "Próxima parte" aparece na tela). Fica no aparelho (`localStorage`, por empresa) |
| Publicação | Cartão com título e subtítulo separados (o original juntava "Título - <i>subtítulo</i>"), "Ouvir", letra de 17 px, espaço entre parágrafos (a página tinha `p { margin: 0 !important }`), listas com marcador da marca, vídeo do YouTube na largura (16:9), imagem inteira, tabela que rola dentro dela, links externos em aba nova |
| PDF | Botão grande "Documento em PDF — Abrir o documento" (celular não mostra PDF dentro da página). No computador, o PDF continua dentro da página, abaixo do botão |
| Arquivos | "Arquivos para baixar" uma vez só (o original repetia "Anexos:"), cada arquivo um cartão com o tipo, o nome e "Baixar" |
| Ouvir | A voz do aparelho lê título, subtítulo e texto (em frases, para não parar no meio). Tocar de novo para; sair da página para. Sem voz no aparelho, o botão não aparece |
| Equipe | Quando a página mostra a região "Time": cartões com foto (ou iniciais), nome, papel (Superior, Suplente, Responsável…), cargo, e telefones e e-mail que **ligam / abrem o e-mail** com um toque |
| Fim | "Próxima parte: <nome>" (botão grande) e "Parte anterior". Na última: "Você chegou ao fim!" ou "Faltam N partes" com o atalho para a primeira que falta |
| Vazio | "Ainda não há instruções para você" |

## Regras da página (conferidas)

- Não muda o que aparece: as consultas (filtros por empresa, filial, setor, unidade, cargo e painel;
  validade; `postar = 'S'`), a categoria escolhida (processo "Categoria"), as publicações (região
  PL/SQL), os arquivos (`getBlogImg`, `RENDER_PDF`) e a região "Time" (condição dela).
- Os links das partes são os **mesmos** da lista "Categorias" original (com o checksum dela).
- A lista original tem `distinct` com o `seq` da publicação: a mesma categoria podia vir repetida.
  No desenho fica uma vez só, na ordem da página.
- A coluna da esquerda sai (a página passa a "sem coluna lateral" pelas classes do tema).
- JS e CSS embutidos da página continuam (o bloqueio do botão direito no vídeo também).

## Cuidados

- O que a região PL/SQL escreve (`.publicacao`, `.titulo h2` com `<i><font>` do subtítulo, `.video`,
  `.imagem`, `h8` + `.download`, `.descricao`) é a base do desenho. Mudou o PL/SQL → conferir.
- Os blocos do tema têm `overflow: hidden` (folha global): a lista das partes só gruda no computador
  porque nesta página eles ficam com `overflow: clip`.
- **Corrigido junto (Natcorp_Trilha):** a faixa "Voltar · páginas" entrava DENTRO da publicação,
  acima do vídeo do YouTube — a trilha achava que o vídeo era a moldura (casca) do painel. Agora só
  conta iframe de página do sistema (mesmo endereço, `f?p=`).
- **Testar:** só com o mesmo app/sessão da aba do usuário; conteúdo de exemplo NUNCA com endereço do
  APEX (um iframe de PDF de exemplo sem sessão derrubou a sessão em 04/10).
- **Não visto com dados reais:** PDF, arquivo para baixar e equipe foram vistos com exemplo (a
  categoria aberta só tinha vídeo e texto). Conferir numa categoria com PDF e com "mostrar time".
