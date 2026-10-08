# Consulta de Benefícios — `Natcorp_BeneficiosConsulta` (app 300, página 89)

Pedido de 04/10: "ajuste essa página de consulta de benefícios igual foi feito anteriormente em outra
página". O modelo é a janela "Benefícios" da Ficha (`Natcorp_Ficha` [J9]): ícone por tipo, ativos na
frente, encerrados recolhidos e valores em R$. O público do Portal tem baixa instrução e ~70% usa o
celular, então o desenho mostra a conta em palavras e o valor grande. A 89 saiu do motor de consultas.

Arquivos: `Natcorp_BeneficiosConsulta.src.js` / `.src.css` → `../login/`. JS: `python3 gerar-beneficiosconsulta.py`.
CSS: `gerar-app.mjs` (AVULSAS). Exportação: `aplicar-beneficiosconsulta-app300.py` (o `montar-f300.sh` já chama).

## O que a página mostra

- **"Seus benefícios":** um cartão por BENEFÍCIO, juntando as linhas do mesmo benefício. Cada cartão tem:
  - o desenho do tipo e o valor somado;
  - a conta por lançamento quando há mais de um ("Valor 1 · 30 × R$ 20,00 = R$ 600,00");
  - "Desde 1º de março de 2018".
  Os que terminaram (fim no passado) ficam em "Ver os que terminaram (N)", com "Terminou em …".
  Fim em 2090 ou depois conta como sem fim. Valor 0 aparece como "Sem valor".
- **"Vale-transporte":** um cartão por linha, com a conta em palavras ("2 passagens por dia × 21 dias × R$ 3,85").
  Essa frase só aparece se fechar com o Valor Total; se não fechar, aparecem só a passagem e o uso por dia. O "Total do mês" soma
  as linhas ativas. Fretado e Escola viram etiquetas.
- **Nomes:** saem o código e o preço que vieram no nome ("1 - Plano Silver - R$ 54,90" → "Plano Silver").
  Os acentos vêm da mesma lista da Ficha (`ACENTOS`).
- **Colaborador:** o cartão é a peça global `Natcorp_Colab`.
- **"Ver como tabela":** devolve a região original, com as abas Benefícios/Transporte e os dois relatórios.
- **Leitura dos dados:** pelos TÍTULOS das colunas ([B4]). O relatório de Transporte é reconhecido pela coluna "Meio Locomoção".

## Conferido em 04/10 (Playwright, sessão real, Tony)

- 8 benefícios ativos e 2 que terminaram (Campanha, Cesta Básica).
- 3 linhas de vale-transporte, com total de R$ 1.035,30. As contas batem com os totais.
- Testado no desktop e no celular, e também o modo tabela.
