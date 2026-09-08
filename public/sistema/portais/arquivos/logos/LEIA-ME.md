# Logotipos dos clientes

Uma pasta por cliente, nomeada pelo **slug** — o mesmo que aparece na URL
`/portais/<slug>`. O arquivo daqui aparece no quadro do hero, no lugar da
marca Natcorp.

```
public/sistema/portais/arquivos/logos/
├── natcorp/
├── incor/
├── leadec/      ← leadec.svg
└── …
```

## Como adicionar

1. Salve o arquivo na pasta do cliente.
2. Em `/admin/portais`, escreva **só o nome do arquivo** no campo Logo — o
   rótulo do campo já mostra em que pasta ele vai cair. A prévia aparece ao
   lado; se não aparecer, o arquivo não está lá.
3. Copie ou baixe o `portais.ts` gerado e comite.

## Formato

- **SVG é o ideal**: nítido em qualquer tela e leve.
- PNG com fundo transparente serve; mire em 400 px de largura.
- O quadro exibe no máximo **48 px de altura** e centraliza. Prefira a versão
  horizontal da marca: logotipo muito vertical fica pequeno.
- O fundo do quadro é **branco** — logotipo com letra branca some. Use a
  versão positiva.

## Por que aqui e não em `src/assets/`

O Vite serve como arquivo estático só o que está em `public/`. O que fica em
`src/assets/` passa pelo empacotador e ganha nome com hash: ótimo para arte do
site, ruim para um arquivo que uma pessoa troca sem recompilar.

Guardamos só o **nome do arquivo** no `portais.ts`; a pasta sai do slug. Assim
o caminho não se repete em cada cliente, e renomear um cliente não deixa o
logotipo para trás.
