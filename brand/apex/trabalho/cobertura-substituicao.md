# Cobertura da substituição — o que a folha antiga faz e o que a nova herda

A entrega **substitui** `Natcorp_Style_Min.css`. Tudo que a folha antiga fazia e a nova não
refizer some da tela. Esta é a conferência mecânica: 108 alvos distintos (classes e ids) na
folha de produção, cruzados com a folha nova e com as 32 páginas salvas.

Método: extrair os seletores da folha de produção sem comentários, contar o uso real de cada
classe no HTML salvo, e conferir presença na folha nova. Repetível — não é leitura a olho.

## Herdado (regra viva, agora na folha nova)

| Alvo | Uso nas páginas salvas | Como entrou |
| --- | --- | --- |
| `.floatNati` / `.my-floatNati` | 18/18 | contrato, z-index 9999 → 600 |
| `.floatChamadoInterno` / `.my-…` | 0 (mas a pilha é um conjunto) | contrato, 13rem |
| `#chatbase-bubble-button` | 0 | contrato, 7rem |
| `.nati-avatar`, `.btnNATIlive` + `@keyframes` | 0 | estado "ao vivo" da NATI |
| `.btnIA`, `.ia-natcorp-avatar`, `.fab-ia-natcorp:hover`, `.btnIAlive` + `@keyframes` | 0 | botão da IA |
| `.fotoColabSmallComments` | 0 | foto 42px com contorno |
| `.t-Region-headerIcon` | **76** | acento rosa |
| `.t-HeroRegion-icon` | 12 | fundo rosa + ícone azul |
| `.t-WizardSteps-marker` (ativo/completo) | 4 | rosa / azul |
| `.a-IG-header` | 1 | filete de 3px |
| `.t-Alert--info .t-Alert-icon .t-Icon` | 6 | ícone azul |
| `.zoom10`–`.zoom120`, `.fotoColabSmall`, `.fotoColabMed`, `td[headers=FOTO] img`, `.expandRegion`/`.collapseRegion`, `#t_TreeNav`+`.sideuserdata`, `#GLOBAL_PARAMETROS` | — | já estavam nos contratos |

## Descartado com motivo

| Alvo | Por quê |
| --- | --- |
| `.swal2-popup`, `.swal2-title`, `.swal2-html-container` | SweetAlert2 não é carregado em nenhuma das 32 páginas — morto |
| `.zoom130`, `.zoom140`, `.zoom150` | o JS trava o intervalo em [10,120]; inalcançáveis |
| `.t-Header-nav-list`, `.a-MenuBar-item` | classe inexistente nas páginas salvas |
| `.t-Form-fieldContainer--radioButtonGroup .apex-item-group--rc …` | o segundo ramo nunca casa: `--rc` aparece 21× e nunca dentro de `--radioButtonGroup` |
| `.listmanager:focus` | classe inexistente; o resto do grupo de foco foi herdado |
| `.ui-dialog-titlebar` (filete de 3px) | o tratamento de modal da folha nova já resolve o mesmo papel |
| `#BREADCRUMB` e filhos | id inexistente nas páginas salvas e nas telas alcançadas ao vivo |
| `.admitido`, `.afastado`, `.desligado`, `.pic*` | anéis de estado; classe inexistente em qualquer evidência disponível |
| de `.btnIAlive`: `box-shadow:linear-gradient(…)` | CSS inválido, o navegador já descartava |
| de `.btnIAlive`: `content:"";position:absolute;inset:-18px` | parece escrito para um `::after`; aplicado ao elemento, moveria o botão ao ligar o estado. Defeito provável — restaurar é uma linha |

## O que fica em aberto

- **Interactive Grid**: é o único widget grande sem tratamento próprio na folha nova — herda o
  Universal Theme puro. Só o filete do cabeçalho foi preservado.
- Os alvos marcados "0 ocorrências" foram herdados mesmo assim quando o custo era baixo e a
  perda seria funcional (posição fixa, animação). Herdar regra morta custa dez linhas; perder
  regra viva custa uma regressão em produção.
