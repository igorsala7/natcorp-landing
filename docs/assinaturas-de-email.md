# Assinaturas de e-mail

Imagens servidas em `https://www.natcorp.com.br/email/`.

O QUE VAI AQUI
Só as imagens usadas nas assinaturas de e-mail da equipe, com o nome EXATO
que o HTML da assinatura pede. Exemplo:

    public/email/Assinatura-Carlos-Alberto.png
        -> https://www.natcorp.com.br/email/Assinatura-Carlos-Alberto.png

Tudo que está em public/ é copiado para dist/ na build, sem processamento e
sem renomear. O nome do arquivo aqui é o endereço lá. Linux diferencia
maiúsculas: "Assinatura" e "assinatura" são dois arquivos distintos.

POR QUE A PASTA ENTROU NO PROJETO — 16/09/2026
As assinaturas paravam de abrir ("Essa página não existe"), mesmo com os
arquivos presentes em /app/html/email/ no servidor. O diagnóstico, medido:

  · a resposta trazia NOC-CDN-CacheStatus: MISS   -> não era cache da CDN
  · devolvia text/html com 400.120 bytes           -> era o fallback de SPA
  · o fallback só roda sob !-f e !-d               -> o LiteSpeed não via o arquivo
  · seis variações de nome, caso e extensão        -> todas iguais

Ou seja: os arquivos existiam para o "ls" do dono e não existiam para o
processo do servidor web. Isso é permissão, não nome. No servidor:

    chmod 755 /app/html/email
    chmod 644 /app/html/email/*

A LIÇÃO QUE FICA, e a razão desta pasta existir:
conteúdo que mora SÓ no servidor não tem dono nem histórico. Some numa
sincronia em espelho, quebra numa troca de permissão, e ninguém percebe
porque o site responde 200. Aqui, a pasta sobe junto com o site toda vez.

/natdocs/ ainda está nessa situação: existe apenas no servidor.

