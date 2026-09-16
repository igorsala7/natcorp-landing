# `/email/` e `/natdocs/` — os arquivos que o site serve mas ninguém edita

Duas pastas de imagens estáticas servidas na raiz do domínio:

| pasta | endereço | o que é |
|---|---|---|
| `public/email/` | `https://www.natcorp.com.br/email/…` | assinaturas de e-mail, ícones de rede social, cabeçalhos/rodapés de campanha, PDFs de e-book e folder institucional |
| `public/natdocs/` | `https://www.natcorp.com.br/natdocs/…` | marca por cliente do NatDocs — `clients/<cliente>/{header,logo,logo-gray,footer}.png` |

Tudo em `public/` é copiado cru para `dist/` na build, sem processamento e sem
renomear. **O caminho do arquivo aqui é o endereço lá.**

## A regra que não pode ser quebrada: isto é append-only

Estes arquivos são apontados por e-mails **já enviados**. Uma campanha de 2019 na
caixa de entrada de alguém ainda pede `/email/TOP_OF_MIND_RH_2019.png` hoje.
Apagar um arquivo daqui quebra uma imagem numa mensagem que não dá para editar.

Por isso os arquivos com sufixo `_ant` (anterior) e `-old` **ficam**. Eles parecem
lixo e são exatamente o contrário: são os mais antigos, logo os mais referenciados
por material que ninguém controla mais. Acrescentar, sempre; remover, nunca — a
não ser com certeza de que nenhum e-mail enviado aponta para lá.

Observação: `TOP_OF_MIND_RH_teste.png` é byte a byte igual a `TOP_OF_MIND_RH.png`
(70.775 bytes). É duplicata de teste, e mesmo assim vale a regra acima.

## Peso, e por que ele é aceitável

São ~19 MB, dos quais ~15 MB são quatro PDFs em `email/presentation/` e
`email/ebook/`. Isso sobe em todo deploy.

A alternativa — deixar os PDFs só no servidor — é justamente o que causou o susto
de 16/09: conteúdo sem dono, sem histórico e sem cópia. O peso é o preço de o
deploy ser autossuficiente, e é barato perto de um folder institucional que some
numa sincronia em espelho.

## COMO ISTO CHEGOU AQUI — e o erro que custou meia hora

16/09/2026. `natcorp.com.br/email/Assinatura-Carlos-Alberto.png` não abria.

**A causa era o nome do arquivo.** O arquivo real é
`Assinatura_Carlos_Alberto.png`, com **sublinhado**; a URL tinha **hífen**. O
servidor estava certo o tempo todo. Trocado o separador, a imagem abre:
`image/png`, 44.077 bytes.

**O erro de método, que é a parte que interessa.** Eu testei seis variações do
nome — maiúsculas, minúsculas, `.PNG`, `.jpg`, a pasta com `E` maiúsculo — e nas
seis mantive os hífens. Variei tudo menos a variável que importava. Como as seis
falharam igual, concluí "não é nome" e construí em cima disso uma hipótese de
permissão de arquivo, com comandos de `chmod` e tudo. Estava errada.

Seis testes que não tocam na variável certa não são seis evidências. São uma só,
repetida seis vezes — e a convicção que eles produzem é falsa, porque cresce com a
repetição em vez de crescer com a cobertura.

**O que teria evitado:** pedir o nome real em vez de deduzi-lo. Um `ls` da pasta
resolveria em dez segundos o que seis medições remotas não resolveram.

**O que passou perto de encobrir:** o fallback de SPA devolvia a home com status
200 para o arquivo inexistente. "Existe mas está bloqueado" e "não existe" tinham
resposta idêntica. A regra `R=404` em `scripts/generate-redirects.mjs` (seção 2b)
nasceu daí: arquivo ausente agora devolve 404 de verdade, e essa confusão
específica não acontece de novo.

## Se um arquivo destes não abrir

Na ordem, do mais provável para o menos:

1. **Confira o nome caractere a caractere** — hífen vs. sublinhado, acento,
   espaço, maiúscula. Linux diferencia tudo isso. Compare com o `ls`, não com a
   memória.
2. Peça a URL com `?v=` e um número aleatório, para descartar cache da CDN.
3. Veja o cabeçalho `NOC-CDN-CacheStatus`: `MISS` significa que a resposta veio da
   origem, então o problema não é cache.
4. Só então suspeite de permissão — e compare com uma pasta que funciona:
   `ls -la /app/html/ | grep -iE 'email|natdocs'`
