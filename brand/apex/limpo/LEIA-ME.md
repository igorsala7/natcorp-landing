# Versão limpa (07/10/2026) — só o original do cliente + o que a Natcorp (Claude) fez

Montada por `python3 brand/apex/app/montar-limpo.py` (rode de novo sempre que as fontes mudarem — ele não escreve em `login/`).
A versão que estava publicada antes está inteira em `brand/apex/versoes/atual-0710/`.

| Arquivo | O que tem |
|---|---|
| `Natcorp_Style_Min.css` | a Skin ORIGINAL (`login/Natcorp_Style_Min.current.css`) + o divisor + o nosso CSS. Sai a camada "Natcorp_Style_New" do time (185 KB). |
| `Natcorp_Allow_Unload_Iframes.js` | o ORIGINAL (unload nas molduras + limpeza de Popup LOV) com `DEBUG = false` + o **marcador** dos `:has()` caros (bloco NC-MARCAS, gerado). Saem os 7 módulos do time. |
| `iframe_handling.js` | igual ao atual (o original + os blocos "Natcorp —"). |
| `Natcorp_Temas.js` | repassa o tema às molduras a cada navegação e põe "Cores · Desktop · Tablet · Smartphone" no menu do usuário sem depender do arquivo do time. |

Suba também `login/Natcorp_Requisicao.css` (ganhou a base do menu de etapas, que vinha da folha do time).

## O que some (era do time)
Stepper "Página única / Etapas", "Maximizar", "Preview de dispositivo", "Ícones dos Cards (pedido do chefe)", rádio padrão,
a barra flutuante e o cabeçalho grudento do time (há equivalentes nossos no `iframe_handling.js`), o seletor de tema do time.

## O que muda na tela (conferido 07/10 na casca 200:791, lista 2010:51 e requisição 2010:52)
- Sem erros de JavaScript; menu do usuário igual; o tema chega às molduras (e agora também à casca).
- Requisição: saem os botões "Página única / Etapas" e o cabeçalho repetido da etapa; o nosso menu de etapas fica igual,
  com as cores do NOSSO tema (#511C76 no lugar do #5B2A86 do time).
- O botão NATI (IA da Natcorp) volta a aparecer, com o desenho da Skin original (círculo rosa com o avatar): na versão
  atual uma regra do time escondia a região inteira em que ele mora.

## Desempenho (requisição 2010:52, CPU 4× mais lenta, para imitar máquina fraca)
| Versão | Estilo | Scripts | Tempo ocupado | Página pronta |
|---|---|---|---|---|
| publicada antes | 35,7 s | 2,8 s | 41,8 s | não ficou pronta em 30 s |
| atual + marcador (`login/`) | 6,7 s | 6,9 s | 16,8 s | — |
| **limpa + marcador** | **2,0 s** | 3,2 s | **8,5 s** | **2,8 s** |

## A página abre só quando está pronta (07/10, pedido do usuário)
- CSS [C14b] no `Natcorp_Style_Min.css`: toda página interna nasce coberta (véu opaco + símbolo da Natcorp animado +
  "Carregando…"), antes da 1ª pintura. Trava: a própria animação tira a cobertura aos 12 s se nenhum script rodar.
- JS no bloco NC-MARCAS do `Natcorp_Allow_Unload_Iframes.js`: põe `html.nc-pronto` (a cobertura sai em 0,25 s) quando o
  APEX terminou (apexreadyend), não há Ajax pendente, a página passou 250 ms sem inserir/remover elementos e as fontes
  carregaram — no máximo 8 s.
- `iframe_handling.js` (bloco do carregando, fonte `app/Natcorp_Carregando.js`): na troca DENTRO da moldura, o véu da
  casca cobre só a moldura — o símbolo fica no mesmo lugar da cobertura da página nova (não dobra).
- Medido (requisição 2010:52, CPU normal): só o carregando de 0,17 s a 1,8 s; a página aparece pronta aos ~1,9 s.
  Depois de revelada, os cliques chegam normalmente.
- ATENÇÃO: página que carregue o Style_Min SEM o Allow_Unload fica coberta até a trava (12 s).
