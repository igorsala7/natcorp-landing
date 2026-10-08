# Marcações de Ponto — `Natcorp_Marcacoes` (app 300, páginas 28 e 9998)

Pedido de 04/10: a página onde o colaborador confere as marcações de ponto dia a dia. Tocar no horário abre a janela
com o mapa da marcação. O público tem baixa instrução e ~70% usa o celular. O propósito é **conferir o próprio
ponto**: a que horas bateu e se bateu no lugar certo. A 28 saiu do motor de consultas.

Arquivos: `Natcorp_Marcacoes.src.js` / `.src.css` → `../login/`. JS: `python3 gerar-marcacoes.py`. CSS: `gerar-app.mjs`
(AVULSAS). Exportação: `aplicar-marcacoes-app300.py` (o `montar-f300.sh` já chama).

## 28 · os dias

- **Topo:**
  - "Suas marcações de ponto" e o período por extenso;
  - "Seu horário": a jornada mais comum no período, escrita por extenso ("Das 09:00 às 13:00 e das 14:40 às 18:00"), com o local de trabalho;
  - a dica "Toque no horário para ver no mapa".
- **Filtros de um toque, com contagem:** Todos · Com marcação · Sem marcação · Fora do raio. Os que dão zero somem.
- **Dias:** os mais novos primeiro, separados por mês. Cada dia tem:
  - a data grande, com o dia da semana;
  - as **posições** ("Posição 1 · 06:30"): a empresa NÃO chama de entrada/saída, e o desenho não soma horas;
  - a bolinha de cada posição: verde = "Dentro do Raio", laranja = "Fora do Raio" (com fundo laranja), roxa = só a coordenada, cinza = sem localização;
  - "Sem marcação" nos dias vazios. Sábado e domingo têm fundo mais claro;
  - "Exceção de escala" e a justificativa, quando houver.
- **Tocar no horário:** clica no link ORIGINAL da coluna "Batida N" (ou "Local N"), que abre a janela 9998. A posição, a hora,
  o dia e a situação vão junto por `sessionStorage` (`nc-mc-abrindo`).
- **Todas as linhas de uma vez:** o relatório vinha de 50 em 50. Agora é `currentRowsPerPage = 1000` + `_search`, o mesmo do Natcorp_Documentos.
- **Filtros da página:** Data Inicial/Final, Batidas, Exceção e Pesquisar são os ORIGINAIS, na região Filtros.
- **"Ver como tabela":** devolve o relatório.
- **Cartão do colaborador:** é o global (`Natcorp_Colab`). Nesta página, P28_MATRICULA é filtro (lista), então o Colab passou
  a aceitar P<n>_MATRICULA_DESC e P<n>_SITUACAO_DESC (04/10).

## 9998 · a janela do mapa

- **Topo:**
  - "Posição 3 · 23:20" e o dia por extenso;
  - a situação, vinda do campo Status da página ou da 28. Quando aparece, o campo Status original sai da vista;
  - "Abrir no mapa do celular", que abre o Google Maps em P9998_LAT/LNG. Esses valores chegam por ação dinâmica, e o link é refeito no change.
- O título da janela vira "Onde a marcação foi feita". O mapa é o plugin original.

## Conferido em 04/10 (Playwright, sessão real, Tony)

- 118 dias carregados de uma vez: 110 com marcação, 8 sem e 23 fora do raio.
- A janela abriu na posição 3, às 23:20, fora do raio, com o link para o mapa.
- Testado no desktop e no celular.
