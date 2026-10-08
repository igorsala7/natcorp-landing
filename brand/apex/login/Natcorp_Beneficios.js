/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · REQUISIÇÃO DE BENEFÍCIOS  —  o "arrumador" da tela (JavaScript)                ║
   ║  App 200 · Página 168 (colaborador)  ·  App 200 · Página 116 (Alteração Funcional)        ║
   ║  App 600 · Página 168 (portal do candidato, "Conhecendo Você")                            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   Primeira vez num arquivo destes? Leia antes o manual: brand/apex/MANUAL-APEX.md (parte 1,
   "Como tudo funciona", 10 minutos). Ele explica, sem pressupor nada, o que é CSS, o que é JS
   e como fazer as mudanças mais comuns. Guia desta página: brand/apex/app/BENEFICIOS-MANUTENCAO.md

   ── O QUE ESTE ARQUIVO FAZ ────────────────────────────────────────────────────────────────
   Quando a página abre, ele REDESENHA o que o APEX já desenhou, para a pessoa montar o pacote
   de benefícios sem se perder:
     • no alto, um cartão com o colaborador (iniciais ou foto, nome, matrícula, situação…);
     • o SALDO como uma barra colorida: quanto já foi usado e quanto ainda sobra;
     • a escolha em botões e cartões ilustrados, no lugar das listas;
     • "Quanto você quer?" com os botões − e +, uma régua e atalhos (Mínimo, Tudo o que sobra);
     • o pacote novo em cartões, comparado com o de hoje ("Novo", "Igual a hoje", "+ R$ …");
     • no pedido já gravado: a faixa do pedido (nº, situação, quem pediu) e o caminho da
       aprovação, com os botões Aprovar/Reprovar;
     • um resumo do pacote ao lado dos botões, na barra presa ao pé da tela.

   ── O QUE ELE NÃO FAZ ─────────────────────────────────────────────────────────────────────
     • Não muda ordem, colunas, títulos, rótulos nem botões: tudo isso continua vindo do Page
       Designer e aparece na tela do mesmo jeito. Não move, não renomeia, não duplica nada.
     • Não valida e não grava: as validações continuam no servidor.
     • A lista/campo continua sendo o item de verdade. Clicar num botão ou cartão faz
       apex.item(…).setValue(…), que dispara as MESMAS ações dinâmicas e cascatas de sempre.
     • Tirou a classe de uma região ou item no APEX: aquele pedaço volta ao normal.
       Tirou as URLs de arquivo da página: a página toda volta ao padrão do APEX.

   ── ONDE ELE ENTRA NO APEX ────────────────────────────────────────────────────────────────
     Página 168 (e 116) › JavaScript › File URLs:  #WORKSPACE_IMAGES#Natcorp_Beneficios.js
     Página 168 (e 116) › CSS › File URLs:         #WORKSPACE_IMAGES#Natcorp_Beneficios.css
     (este arquivo sobe com as ilustrações embutidas; o visual fica no Natcorp_Beneficios.css)
     ATENÇÃO: o MESMO arquivo serve à página 116 (Alteração Funcional) e ao app 600. Ao mudar
     algo aqui, confira as três telas.

   ── O "COMBINADO" COM O APEX: o que a página precisa ter ──────────────────────────────────
   Classes nas REGIÕES (Page Designer › clique na região › Appearance › CSS Classes):
     nc-ben-perfil-regiao  "Colaborador Solicitado"  → cartão do colaborador (lê os itens de Colab Info)
     nc-ben-medidor        "Seu valor para benefícios" → a barra do saldo (lê TOTAL, SALDO e o pacote)
     nc-ben-pacote         "Seu novo pacote"          → cada linha vira um cartão + o que muda
     nc-ben-hoje           "O que você tem hoje"      → os mesmos cartões, mais discretos
     nc-ben-acoes          região dos botões          → o resumo do pacote ao lado dos botões
   Classes nos ITENS (Page Designer › clique no item › Advanced › CSS Classes):
     nc-ben-segmento       P168_OPCAO            → dois botões lado a lado
     nc-ben-chips          P168_BENEFICIO        → botões pequenos (com UMA opção só, já escolhe)
     nc-ben-cartoes        P168_TIPO_BENEFICIO   → cartões ilustrados
     nc-ben-valor          P168_VALOR            → campo grande com − / +, régua e o aviso de saldo
   Achados SEM classe (pelo conteúdo), só no pedido já gravado:
     a região que tem P168_COD_REQ   → a faixa do pedido
     a tabela com a coluna APROVADOR → o caminho da aprovação
     a região de ID estático BENEFICIOS_REQUISITADOS (ou título "Benefícios Requisitados…")
   O desenho de cada item entra DENTRO do item, logo abaixo do rótulo: quando uma ação
   dinâmica esconde o item, o desenho some junto.

   ── ÍNDICE: as partes deste arquivo ───────────────────────────────────────────────────────
   Para pular para uma parte, use Ctrl+F (no Mac, Cmd+F) e procure o código entre colchetes.
     [J0]  Começo: qual página, qual prefixo ...... P168_ ou P116_, candidato ou colaborador
     [J1]  Ferramentas ............................ funções pequenas usadas no arquivo todo
     [J2]  Textos, categorias e cores ............. acentos, ilustração de cada benefício  PODE MEXER
     [J3]  Achar regiões e itens pela classe
     [J4]  Ler as linhas dos relatórios ........... nome, tipo e valor de cada benefício  CUIDADO
     [J5]  O cartão do colaborador ................ nome, matrícula, situação, desde quando
     [J6]  A barra do saldo ....................... usado, livre, a frase do que falta      PODE MEXER
     [J7]  A máscara de dinheiro .................. R$ 1.234,56 na tela, 1234,56 no banco  CUIDADO
     [J8]  Opção, Benefício e Tipo ................ botões e cartões no lugar das listas   PODE MEXER
     [J9]  O valor ................................ − / +, régua, atalhos, aviso de saldo  PODE MEXER
     [J10] Os cartões do pacote e de hoje ......... "Novo", "Igual a hoje", "Sai do pacote" PODE MEXER
     [J11] O pedido já gravado .................... nº, situação, quem pediu              PODE MEXER
     [J12] O caminho da aprovação ................. quem aprovou, quem falta, Aprovar/Reprovar
     [J13] O resumo na barra dos botões ........... "3 benefícios no pacote · …"           PODE MEXER
     [J14] O maestro .............................. decide QUANDO cada parte é montada     CUIDADO

   ── RECEITAS RÁPIDAS ──────────────────────────────────────────────────────────────────────
     Quero trocar um texto que aparece na tela
       → Ctrl+F por um pedaço do texto. Troque SÓ o que está entre as aspas '…', sem apagar
         as aspas. Exemplo:  'Ainda pode usar'  →  'Ainda livre'
     Um benefício novo aparece com a ilustração "genérica"
       → [J2], lista CATEGORIAS: acrescente uma palavra dele no padrão de busca da categoria
         certa (ex.: "wellhub" já leva à academia). Leia o CUIDADO de [J2] antes.
     Uma palavra aparece sem acento ("Combustivel")
       → [J2], lista ACENTO: acrescente  palavra: 'palavra com acento',  no mesmo formato.
     Quero mudar o texto embaixo dos botões de Opção ("Escolha livre, dentro do seu valor")
       → [J8], a lista "dicas" em montarSegmento.
     Uma coluna do relatório foi renomeada e os cartões sumiram
       → [J4]: os cartões leem as colunas pelo nome (BENEFICIO, TIPO_BENEFICIO, VALOR_TOTAL).
     A tela ficou "crua" (sem o desenho)
       → abra o Console do navegador (F12 › Console) e procure [Natcorp benefícios].
         O manual, parte 5, explica o que fazer com a mensagem.

   ── LEGENDA DAS MARCAS NOS COMENTÁRIOS ────────────────────────────────────────────────────
     PODE MEXER   trecho feito para ser mudado por você: textos, listas, títulos.
     CUIDADO      leia o comentário antes; uma mudança aqui pode quebrar a tela.
     (sem marca)  funciona sozinho; só mexa se souber o que está fazendo.

   ── COMO LER UM ARQUIVO JS EM 30 SEGUNDOS ─────────────────────────────────────────────────
     comentário             tudo entre barra-asterisco e asterisco-barra, e o resto da linha
                            depois de duas barras. O navegador ignora: é só para pessoas.
     function nome() { … }  uma "receita" com nome. Ela só roda quando alguém a chama: nome().
     var x = …;             guarda um valor com um nome, para usar depois.
     'texto'  ou  "texto"   um texto. Muitas vezes, é o que aparece na tela.
     P + 'SALDO'            junta os textos: vira 'P168_SALDO', o nome do item no APEX.
     val(…)                 lê o que está num item do APEX (veja [J1]).
     Toda linha termina em ;   e todo { abre um bloco que um } fecha. Não apague esses sinais.
*/
(function () {
  'use strict';

  /* ═══ [J0] COMEÇO: QUAL PÁGINA, QUAL PREFIXO ═════════════════════════════════════════════
     O QUE FAZ  Descobre em que página está (168 ou 116) e monta o começo do nome dos itens:
                P = 'P168_' ou 'P116_'. Por isso este arquivo NÃO tem o número da página
                escrito: serve às duas sem mudança.
                Também descobre se é o portal do candidato (app 600): lá existe o item
                COD_CANDIDATO e não existe MATRICULA.
     NOME       Os poucos itens que têm nome DIFERENTE em cada página (matrícula, admissão,
                vigência, cargo). Se um deles for renomeado no APEX, troque aqui.
     CUIDADO    A primeira linha abaixo impede que o arquivo rode duas vezes (URL repetida na
                página, por exemplo) e que rode fora do APEX. Não apague.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  if (window.__ncBeneficios || !window.apex || !window.apex.jQuery) return;
  /* o número da página só dá o prefixo dos itens (P168_… ou P116_…) */
  var pag = (document.getElementById('pFlowStepId') || {}).value;
  window.__ncBeneficios = true;
  /* os itens têm o mesmo nome nas duas páginas, com o prefixo dela; o que muda de nome: */
  var P = 'P' + pag + '_';
  /* o portal do candidato (app 600) escolhe os benefícios pelo CANDIDATO, não pela matrícula */
  var CANDIDATO = !!document.getElementById(P + 'COD_CANDIDATO') && !document.getElementById(P + 'MATRICULA');
  var NOME = pag === '116'
    ? { matricula: 'MAT_SOLICITADO', admissao: 'DT_ADMISSAO_DISPLAY', vigencia: '', cargo: 'CARGO_1' }
    : CANDIDATO ? { matricula: 'COD_CANDIDATO', admissao: '', vigencia: '', cargo: '' }
    : { matricula: 'MATRICULA', admissao: 'DT_ADMISSAO', vigencia: 'DT_VIGENCIA', cargo: '' };

  var $ = apex.jQuery;
  var ILU = {"carro": "data:image/png;base64,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", "previdencia": "data:image/png;base64,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", "refeicao": "data:image/png;base64,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", "academia": "data:image/png;base64,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", "combustivel": "data:image/png;base64,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", "educacao": "data:image/png;base64,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", "saude": "data:image/png;base64,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", "odonto": "data:image/png;base64,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", "transporte": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMAAAADACAMAAABlApw1AAABgFBMVEVHcEyZte2atu7h7/BzkNfe1fBcMItvjNacuO9uitXc1O/q5PXihbs1F29wjdbs5fbn4PNyj9aYtO18l9p2kthpiNTk8vPp4vTk2/Lg7e/l3vNWK4fg2PG5mMuQrep0lN2Useyju+7v5/fvu9swEGlSJYTO3upfeceCnN0nBWO8OnaKouCbtu3y6/hGJXxmg9HHyuyMqObnisB/QJHKS4WYqeBsTpvut9hiPpVQSZvQz+xZbLvggLc8HXVYWKrBxOmjseP38f3d3vHV1e+1v+mtt+XVVI6zwuRmYrOAYKa+xumyyO9zkdmZhbqMdrLVZJn2yOTS3/O5rtLn9PZIN4qwoMqqRoTjlsXo9PbXd6vo9PaeuvKiuvHjqdDo9Pbo8/Z6Noe4OHTPU41bMYymu/CxX56euvJ8hsx2j9ZdMYyfu/LjhbybT5PBu9iok8RXLog9HXZjNYliNo3UX5iaTZJaMo1xjtjQiLqJpuTb3epfNI7p+fjw/v6fvPN3mOGjwfsPwYeMAAAAenRSTlMA/v7+/v7+/v7+/v7+/v7+/v7+/v7+/v7+/f7+/gH+//8C/v7+/gT+/v7+/vr+/v7+/v8D/f7+/f7+/v7+/v7+/v7+/v7++xH+/iAypP7+/v5G/s3+/g/+qf6C4Gv76F/+5aj7iP6n/mOkxc7+/v5+zERZYy/E2Znc8+1We8wAACAASURBVHja7FpNb9tIFgwbFNgUAX40SZAgaI+kg4cAZVjCjC66SGPJCZDsHuZsnxYezyDnPeyF0V/f99HdouQ5eBJ/Au7Elp1YSFV31Xv1mvnw4X29r/f1vt7X+3pf7+t9va/39b5eeJ2Mx+OTNwz/jF7G47cL/+zzl8/48hZPAbb90+21lNPr28/03RuDf/Lh7OZ610kput31zdkb0xGivfm666ZTKYSYyt3172/JCieA9MudgY8Mpl139+XNWAFM+/lO7qZTIaSwFHbd3duwAnl3uhNTRxABRzhMQeymt6/fCoBvDN6VsPuOkLCEWZKscPO6rYDi/x29y7ilZAqSTwJOodt9fcVWwMb15a7rUPyGgFDKkWwFIjXdSbTC2SsW/3TqWNVIp5vNpEOnoOUEVpC3n+isXl3j+gTiFyh+w8CRsyqIqplURkxCd4VXZwVqXOxdu5QD8OMqjoN664g+BclWeD0xlcSP3hW26EjH2dYEP46rolh25hDYDNjYXk1XOKHG1e0AvsXvqO2mKAg+raIiK+x/QFvhNVCwjUuatgulp1sS/MpQqOKoXAmn3xeAwvXN+MWtoEOnET8JRKF3q/3260OI6u1I9Bd2hd9ftiuMuXEdeFfIVaXFz3tvVxBtpDiiQBnvlxf3Lqre4q8nuPsEvOhzKCbV9vSYwZS7wkscArYiEzr7+982q+i+gMAExapJ5pgonD5fssLJCzCw3j3cUiBwkS+WEVWgvY6qIJjNszRt5R684QCN7e5s/PziP9N9d7+ZtLrWT3J/XU166q+CyXKRAf4MT8DB386hjm6et56eGO8ymsMTmOe+5+fZFiSv4ReTzZrgN6cI3TmED99Nu//98owisqETkahDNLjmWe4n/kUzAysQ/PIqBfhpOneEcu4zUKJzvn15viNA796CdxGLUuoYDnQrZ575fpjni82kiCfxtiH4rZKOxd97C3S30/TbX89VS9G7IH4HQ6dCBvh7LyMqME4n29APwzxcV8GqcdMG4I8kyeeehhB+mHz71/OcAHj3hL0r1Uh2BF9pPFQfDTQ5anwPdJS2IW5/cyq1W+7BHzVh6LrPQ8A2LkAAcaGMN91ohAwUE2CE+iRgY32oRyF4N0X4tnDa84Lo1DltAvDdZzmB/sA4gqhfVFURz8RIsZHpV19LUs5d34fq0zqyLzFLUnaizRC+mzzHCZB3uXEpiPoQNmHFQbliHdExHNlZitbP2pEQpvY7e7WR+DMvcZ+JAF/UkvghK28KDspAoQhAR0xBFyRLApPpCLyr9J84B9sPEksY/jNIqHfZQ1mZdx/xx6QjqSkcV1QskX152b9G7yZJljF6WE9KwF720KC4usSkhkdQMQGgUK5GI81AHLc14ViHa/2APVTr8u5nmsETEuh5F7wIg2KF0WBWRJWmgGoKuB45fxMt9jWWPQLwndYNcfczXMzgyQic9LyLgyJt+eW2adZLtjEeAuaFeCmRgcZ4eAC6evKSEDVC3vlMU0iezsS67zJ8AeIvSziAZZO2TbrYRDHDp+BcXK6k0kB7CXV/R0TUoLZC33UtfDdEAT1VI4N5d2zuqrB0xlUZ47AYVdsW4kGzrSI7Nlbw9VUvKBxbgUwApadJ9uLPMi+9Grae+zQE7LwL+6pG2w2NJRsGHUE+BgrtLAA30yEEMG+lJmyy8PuBjVsblh6GzvCTdX0erZ+GAD1k+YreBTgjuSSvDtZN1s6iqCqLYjZPm+anRUl1KIhwYGmUSZtHkYdOBEtPaAo/wg8Xm/NJVa/9JzCxnnc7BfAhtdEtCRDYLDAXL8i/k2ILPphRJ4ADSVFT/bR86GTsyqbvEvzQa5fn50FU14snIKDnXYd231mVgDeYgIHjaIbiz9aXODBGNd99RvWaBxZNYN/Q7PCLI0KYJKb1ZqHfzibnQRDFwxIJhI9KQN9VAXxHjRTEHqr8V0t4jSMaT0BH1MBASxU4GhI/rUYc7b/uAbr0GAKZ66erCOEHwQAI5I9LYNybd0fgXYo9FUgkXde07yCXpskWZWXuSjT8LJ2Lw4FLF34oPVT4E83AT7fFeVAA/kk1RALJIxJg70JsUCj+bqNDJ+wy7vAqCMC/YNhmvYnJu7PWzRh+ZmYuM7XQZ4Wlx6XUQ0cARJJ1eR4B+iiKguEjE+DYICjyA/xlXJi8gIM5+RdEX03iDYahIuK7EoLf0J2b6QH2HPahDfFj8wpnv0UFoodVPjIB9m6H865SPfis9+UcC83VBvkUeBDQC1g98HKKsVP09l7Q7lPlNJkTvZskDWw87X8QFUND4FGqkI0NJJ5l1YdPFLBVpdkVV9So1nclLH4p9olN46fUw5WTpJ8lebrIvKbAvQ/wDOrhYPBoBHRs4MjPE0t/0bdQL0FD+FeTapsmBj6OjIfBDb9i+CYug4Dy7KquFnmKxQc/ogrwDwZUhX6YwNhEfvr3T2e/FeUBdPN1EBRUPaFyZqx9vi+xecfpDVy2b4EL3DxZX57XAyZABggGg8ciMB6bqzaNI11T0ry/MFBAimiTjPZelx5z5WAJ6NDGVR8PwQ8h9UxK1EtaaAGVw0ciwI+4JFZObUOZXiRbmljuCykKepWzOdVziuhlUBPajPShb3mYeoJiqAnQGRRDewI/VIUI/q2kvmurd+b7Pt/yH60gmJnKSVe1Qjn7tK8pcOE30s8wNizPJ1A56+GwZgLIoH4UAif7/1pC97QMRLlQ7ny62jysQ/vCD/DnZkixxZPEr/CqynjXpJ6CPWsIRMbBgx+LErj7n7j0OP2lEg9+JeC7arKXUVEsdWhD8cxxwO+FZiaAhd9j8VNwCPEgz0ny6Fkk0BRk4nqgV/XdBHD3z47hc57Eq9kkDL2LbBtEZvf5jl8Xfrpscw7mL5rWIeW7bmL2P3G3wXlUcNdFtHXLJp6YAwAJfec8sN/93pWx4YD3miGuPG9mUUHXDuvU7cGHNisO7rEw8c8z38BnCyczCm2wJjEhthIa2FXBRPbPT8DAh9KjnKOFt4RCAhgv9EK65Y+iwRXC59o5V/qy7eBdAD8NQxuZ3czz/TCLsWkRg8FQS4gIlBb/8HtOYKxTg9S3aWK/90rLCECCjoBA6F+E7YJ2P6O2q6ToT438BoTvceLn2unl7arNs8sJ5x5d9IkAfMvHMajBCGXZev+wCln4U/uAxYpf2a+oHMIm+r7nX+Q2Nei2a++p6D5O8O67ZmbJ0Ltlsc1dJoCDlz2BJpqwg2vAX5fLhYdv+fd/HvqEZkw3VQyfhj+legSc/lCL18e5j8u1ib8XGviHePf5qkcn/gQmlmAyrK/4BI6KfqMdDCTqargG24Tun398fCABDg1TDZ+fEakeenUwlAOF1r/wvTyh3T/VTzLEPjbzA65Ew2fj5jhwAeRybSVU2ZKDEtIOrqvBFbo+TP78+OsDCWj4ggtnfwQ3+I+fwknV+DkSaEfCUX3x41Ma2P1TKx5kkGHmrKD04Ky4NidQWMuihAL2QwmFIfegWIfuH79+fBiBMWQeC985dG5f/gcMutOfcn5KceAQrp9Qbr3EBmZIPS5eVRVBMegTqNkB+gSwIw/KepvmfgJ1Dig8lMD4w1/znZru69/fKufeg1ApR1w4nd5zVR7WU88n13L1ASgQ2qKiYMil9gCnhiF9KqGRwRRW16sG4YcAH14eSADwf6MyaKam/W72xqgDSvZRy56bURndNXi2bkL+SfwGMmfBsccSKFBAiJ4+sBND9Vm1PiY4eM/Fzz8n3sMIjD/8F97j/Z9x8/1NW0vCcEIMB2NxwI4dDDYxRaaAEDiIJuKHIEmb3JK7N5G2TVerfti7UrRq+6FpU20rLSncf31n5hwbO2mTWtW9VVuR9zkz886MbdRtmmKi/SO1voWzmYonUyphOEYi5Qx6uCvlk/esTMvkL7ooH5YelIsAaKPh3E9RgAiY43FHVVE+TFvNyYQAnv0SwB8r3fMUzgkhmsDi6XK/lCXlndrYXJ8+EWybk8uRp9jUd0kyiEYAu1BYTz0iAhy2My5PfwL6Vc5+tQa+ed58pqx0xvEmQnIHSaUSCEYsvZJWZVDucx6p5+ZKmV/m2yNPd+sYAJqbsWBPAx1SKLcGyKXdFmY+1a41Qfm6Ajb9SxGobjz95gV5vzfxPEBoRfdBkrfyw8eNcU9K+JOQH9UtM1fqrOfnpz5E4HmBMigccgjAjQDAenJHePZ0KZg9qhJMJtavAvzjm9fMT/P+ZXPlwSe0atHj8/W9zJQcDkSTDmXLficmzm0WDT2cm14wmvr+NJ/3RyssWS0a1MBGAQBv/YTywfgp9yVAUzcDyiHrP7/99uzDYwBPBi85AMDl50fByuRMuX87ZDMV80nx6NoIBx4cUbMgH5JH5A/Xve3mCD4ODgUBPGma6zEzMJ9jAHJpYfzgnKSdCQI8fUwiAHj278UjANXBYOOlKgAIwUIEs5/NRveQZQCM2K94h8bbbP1t1M6pALi+8oR8vz092xu2MYXqsa5LAC/QjtBSbWH8jIUI5ECTJlOYyufO1SMA+Hc3Xy0zyMvLn850KAWG1WwkXzYJbSjRlekuIQwuInEQYQXG4/v4Ub2L8fH3AwFQisY2kUJjF83TtffA+FE3Y4TAZA1wSKImV2aPAVQ3Bl++NhbMbOajC6rZ9GBYpjdJEneUUwkLlaO1gcuiziWBqigof4ofdK4dF+y6ACiIFhYBKACA8vdRPhfyRQy43sQSxiiwRwGqG18+O43eELIOszUkgGr2FNVSsZqTj3WjKMiHW9laR4GxkfIHA8DMCRpPvg3508NbDqX6SEZApAwmPaXQmCZ+1RLmA0sa7kj0e9g0mlQDgWUePAwwGHxyGg0A8BifTP1YEPKjpgc1xDuxN5rFrmKsnxPhaw2KGvN9OMjVrC1S/6Ldg14FABgBk0xTrF4SIF0ZH3FLJj6sRzosC7KSRQlbMIfMM1cPAcCffwb5TuMAmrBnze4gWCKPltnEywHCNun0oemqevyCU1zNfN85d4+PAcCF9luSKVTKpUPbJAD16EiPTt9s9WuGUUMjwxQi+Yx7wYHzIEB1478frno95+vNe4VZAV9Zo3wcYTpTAIG1jGX47nnkm2j70LVip4/ritVqqRCBi8JxtyIAIIWKIgJYsum0jEHxyOKWmPghY8x+Te6f2b6sAagLJZgvnEwmc7X49BOAQfVmCBf8/cZ7zzo51QPoBpdrBGxsE8+EsbhPb/dHQ7Mhd8WYepCvss6Jvad6M//jsV0qHp8TQMG2KQLjdDj308RsynrlOoNCM2q1Wmq5NGrGso9pCIHxLCEfAW5+BrDxKXM1vOp9fjp477W6x+5+ECiA4N+pZigFk6aLTfnyEto+Gk9MPrf4/rgAyjACr45LWgUBbIhAriIBQv3oPNC2WOj7nc3arvHXsmNu9//KbmZhDVK5p86HQv4i89MAEIDTy+c/P4UIdOrFen2vY1mehzYSu0aBh35kZMUgZKRSYDzyNo8c+bmlHL2o1+2ce2hJgCKmkF2H6TMCEFM/yGcWpD3qhxzS+6A/W2teQv315ujJULskf7EA+Qvn6tNPv0QAAE4MQCuVuvVD2EVXSrKapzMOpcA7sOii/N0W3uJU1vKZtX3qduu4z9oRQKlLAFpaAOgYAWpb++g8ZJpo/KyfqtWW72TU25e7xq7CJyQfr4Zz8b+3P/0yCgE0JMA+DVsV2z1VLAWmyEQ1w5gKebRdy+LIwLm+Pn20vtZJEbctHBRiESgQgA2LCgKwPSmfhfIJQIXzN5Zzko9jU3u03GwOMXHo9J2zw9ud76//hHH5yQ8BPgDAVAJAz8FHg2l7DPamrIKkIY1UDHinj+97ho+2ZOXuFbo0KuOuCwAeARTsIvWBXAQAn4ynD1WLFwFwSEzYqUfwg3pw5pkegLSWB45MnsbZx9udcrm8c/v6x19GuQtQ0MIwd8CZV/FqnrbnHhQttHguX0kSqW/uj+u06ortcA2g5UoIANODSCE+FrmPMxuIV/G/0LXBfbKjdj5PmjOLXt6fL2eUPtCbXu3clstbW1vl8u3OP//2g68oEoADKQQbpXcEEaBeiecIm7Vlmd5kjeDPPKazZjPQuR49njCPXJBfpF29mEsAVHIaAKQxKgJgf1/4PltfnO/WdpdzGDooZYigPcrOsXwbB2+2hHwiKH/fwlK4D5AhgCoBaHa0YOSgFExL9ZR5aEgAgBNKs8nlqg72fVKpF0riwjcz6N6OrIFimgDGCKBRClk48IuRE7MHBx+1tbmbfecL/SIEjn8JACi/fAu6tyQBMGx9/9efT+98j2Cw8eUq40AKbQDAabcSNUrqlUVsbCsmDSkCkPs66xyWuloR3AaGhRIGLx0HgFgiwB4++jpGAJX6kxg5mdDP2a5h7MIJOai80aAY5C+X88bwGuUL3RFAeef727tuhKOEM/18gyl0Uo8v2Dm7VOi6kLSKF4jNBACYBQCieNUjsE3KnRLpF/enIoBuLgJwi10CCKWLEFARmJhAfr4BZ984O7+gHPJ72YtzcfrJCwhuX1d/MMzdfBnA//7gJ4lbHDbKqnfHUApgSJciAggQ0M6oqHv1Ip29OP9iNKQJADQftNHDdA6ay30AJOB6q1brT/0p6Hau4YddQwyGZwd7ZbSexPFTGexADt3vBwNs0gOIADtd3yJA/SI1oDe3LOZhNUMRcwCY6B76EACI3Bcl4OZk4ok+8AbNpwCjxKFb0dYRiOtnejDv1LKTNiTQwrnuuq7twuiZeX5LNbt1JwAo/+3vG9UfbgRV+PNvCBAFwNbkBcdXODEBgU2g+8OqNXSGgQIxoAiQfvxl59JrAHChN2BJOZiFpod4EPcBVBzVMkOjlrrEADhnBde27cJZIzN8jsZ/P33AhB74fmt140kCwNZKWnRV3DG2H5wl4Ic2nGkPvBwi0JXuo1EByF0xjEARaxcAxrjJCwAu3Ifkm9Z8CE5jbHamvgMV8FETAI5zsBXmTjkp/8Ev2+N9LXbi5tb5E120x+LeCv0XWvzQgZwNohqQIUiHCZRbA9hFAugCIAEw2QHUcNJcOHMDPRR+c1CxYYSpjIeLxvltaP1h5YJ80cWePHxjjh26uYT+ktQvBuDDlsVHvYWDTTlQKIVKZKGadFC57YYALo3T9wAg9z0+p1ln4VxsZuft6dVV46LgViqudg129PG2HM8c0P+4fAR4SQCkwdakMrzsWGNjwx7q9y8VEYGSKPT1v5ERgBq4LhQ1EYF6SUukEGxZQ5wU0PnfZbOzdg8AzutQwYXxAophJ2q91MZQ/t8fk08AnB+SC6F/yszQ1u8s0Pm+OOg1oKnNTGGjXdEDtMS/CYv4OAYgXQgjoNCWJQbljPMuBWNQD2r4QCtW6vaZs2i8igKA6v9Pyrk+pZEtATwVXhlFRGFGyCAgMr4oZoAojgoSn5GkAJdolFtlkvtIeas0ftjcqlQxuvuv3+7TZ2bOGFQwp3a/7LN/p9/dh8ESaKjPxsy9eBeaKqUc+ce5Epw3F+xEq3UV/vdGhjXvThgNCADwDx3cA4hGJykTh+wui8oGBvA3AwiqrcDYKdSgWlNx5EfxrfMhv3oz9+K9RC3f63G6Vtt+xhzxsagEANNUWVkqowmhmlLChiKQGDuYkhjAjA2Q20m16ugDcXLdYJAXbmBCd5f6BAIEVfjPwuVgDHXkt1gNPdxv0hFAKkHoe+26r7s8sQESVV3VgmoehCGAmXHPhgXFj8mSB2DsNtXSl3E67TSJvOzsa9pasomFKCPA8j9Y4gbkiD/sBzIQQI7hr6f4FggfYSQ8poH+CQDQgDoAWAlF+YLOFl8GR7UBiq3liS6In4dOa2OL3z4XH/JJs+FTlBt9We/zv2I2rCQ3fhD/i/MRsaEAPhTislHYK1JghONZXv0CECEA3HfxBAxtHG5GsVchgJnoLQBMLFMpqwdF8anXsrDK323rugZNCfS+u7z8T1rQQy6M9IUVAMim/5KM0Nvd4jipwX0xQqNADqBxgAiZUIqGbSh+HLsV1uUygNc7xe6J25LqovFAp/ud9VpYIlu7p03TrLZLrHlkNduo4nOANLS7Rnx/suh1zYC9Bx0LOBqAiCKXilGWAXBKRa0u1fkM4OY2eloVpksTel+8fbtVpCITVLHrsxgQlZwLI3/fBgHK5XS6kJGNpRI0iR75uQ4Crgbwx7SQB/hWHfe6oYjTKyJA6/Rk2TNaqvcd8aHTvVUUyycETEVh5T8THxvHkb8lQRrAU/Ab4ApRe4wsNDgAYHo18BpNP7C/JLFBAy8UGEC+vrw84Tl63xEfLnusVpsXEMSK+d2zPoWBa/oyR1gCV1jbTAScXYS7h27WNQCgpCQ3oIFL7GHgidByKMRHPQgwcf/orHZgcwZl5mwVTm/e50HgBf/zvuQBAH5piQCy6Ar+g1SCua6rAqwStk90feLEkJgGJsdKb+P0piFC3fojABq7fWzUfYlKrddBhM66z+kcQXzfs8VnAJmlmAEdHhJky3HDWGqkUmKPjEO3UkbePtn2MzHlA9v03UOjHumvXwD0IDceNPOLWiUc5ggX2D2ygp9Kzud+uwABNosHhkR2lE0vhQy5UEp4YxHUaZJhGJI9WLOn+2hCaD7UqEcy8Q0RIF/X+1AnYOSh6z6rhWvhSqXmIkC/cv57HwdDgEaxuFcwYhwB7Uh+u5cIuM6M/TpOJchQQhF3qyuF4kuFcrkQQ/FDR6Y4265rdty3DR4AwoAQthHOZoYo+J84b178N9TIzRR3SlMRsiNA8Mty/CCQCLiLRdDAAAApFCuD3eHvVdNUsLkAUP1BidNuCHHfV0ENMAZCWDn8+ek35WcAb3eK45M7awaue5grQEjFAilhDyvGEvsCgCs/Uxr7QWJ6OlvFqswGQPG1PuRYS+zSmQbCIsLq4b8+sdHIbwD8uZjZnynO5NaMKUmK3XMF24REABb4MXYugeD4kYKppem77N2lijN9BqCrWKC19qhEcPPWGb9/OoBwuIoPav73O182A4D+kZw5mNl5K7NYspTmdgQlHmUF9sCEAciUr9hWOhQpT6dfvbzcgPw2cXJ5ly2baDRQROisvrzZ5TMqrwa8COGei/DMD3i8mf2z/2/zSC7vrcmsHsOHfFmemrHGA1dgL2QEJ2b3HypPZ+9iJ3l6VpDfms5uo9mQ+NVTW3xxvsY14MjvIqwiwuxzEKDuBgCI1IafLhdjomhHRqwBrvCaAGR7tInyZ7N3Wyh9vY4vC/KXf7dx0G9nLeWXCZUbhSoiRKWCiYG0ANf5jJfqP4Pq9TV014Y/IlFRI7mpGUo8dIVJVwMS7YgK2fSrbbQX3CequMZhABB4ml3fgPmsDVDpraz2AEHUgo3wY1QEFP/L54aufut1vmr9I2i9eVaSpwrcFbDbkddSb7kGJFKBHEP5oSmkdSgS6FnwYi1IYX+g+ATQWVlZWe1gShYOC0mIsDACAmS/hS8fb61dU7vudDrXatBcxL2XRLccd0q8iCxDfOJRiM5UmrYrvFdRg9rEROyy3m9vsmZrsPhJBU0IARAh7D2OFoZFwM8ZovhQoXRV9eu33rUKaXPDyEQke4gcS9sIfgOsHzXA5ZfK6Ze4XeFTHjz1/OUlie8bKD+OCcGJaxwAEO4ThGs9zAuHPz4NhzD3x0d2W9BGf4d25fqaGTPZEZX3UgRDKnQ7WfweDdMAK3ogUEGc0vP1INvHafgv9ieWF3cHe649pIWq4aqCAKtEUPMC1Crrxxc9JCCEp+7/w0cnSSatZCuo8cZPJTuiXZYMAYm8OR2TbQAJy+87HO7j5be7NzixUqvNfcsejnuWE3T9NCYEAOYDjKF2T/75+fljhkBaePNECXd+664Skj6r1NRUPuMIVo0MRRrot+JGhhtSgQBC/tDiEYQnUAAGzW4ut9PVgn3t5lb5RXhnSEtztoW5qwo5MUPoiZGodjaPZ91FePyHGwQgGKilnJpakCNAamZZIWLs7+zHILMhQxmXfP6MvLWhHb16tZVHBYD8gVQiASlYO7Uecl1hTHiF7QBXwEpNyAZcfnaO1zusRnqUYHb2/fmt5UXYbakaJ1DNrSk/XLa8X8zNNGJGvEwAkUWsONXLl9MneR3SbquYSqRS0Sr4/3cr+ZD47pgQAaChIYSee/3hi3nhXFB2/vGUH0AMUjyNqdVoas4MqrqY8UeMg1x0cqdY8stQIsmLRxtBFvfjrwp13I+am9EEnADO/PeU5EDxb8U5GwNgQV/0AXDf+XXn/ucxVNWeVAGOHhf+8fnW50ZtvCzHjuBsGxm5UCzmoNKGNCbHcTdBA9rC3SWGII2tt1KTXZwtD1BAks/Z3DHhVcUOmWAlrvmT/MRwAYEKVNJZPfznpxezT+Xh9+eKGLjBmV076kNIlfxrezvFaA46Tili2vNZswwxiFkQ28/lmpo43Bd3ox+/vPMMqhCgxhGcc4ayr7MD8tfo7/dWV54EYDcDyUARUifZkROPzC3/VKE0vrMvRyTJ5D6umum7bQLIpVKp4qnWV6vKAPE/f7k/6bmqhH85FyA8/QF/8oahUvm2MgQAuNYCcwWhdsF41K068Qi8GYq51AEUQTIHgJCPZRDbruQmx4tdXHndc+GH5mwDAJjx8Ptn5sOcpPp1OAD6KDS4gjceJVvQDtqGVF2MTLEEbHLfAIC7bdqutL9326And78oiD9o0nPlqUJt83fkp79ZCX/rB4cGEF1BsKPNtsrsqN+5hu5kEfqc0JQAML2RZ9sVDZ9pmFrT3YxS0fPQnO2+BgT5bfMB68F1wggAtitYoh0pUB+hK/Q7ncPrYL+66M8sOjNa8+W+zjRAKy+tmVSSYs32kPhzpAG3qbywL98xH2gNqiru0kYBcFxB8diRD0NqEAvtDnQp1W17u8XewzRO0IupmPPI73tkTDj34kelJhQ/JD9BnHHjv6ZMo44G4LiCZ8cPIbWvqV8BAWRX2tMaegAAArNJREFUqXNRWbMO5Z+vdaJBHaqp1VPF59ZUj44JZ+feXVXc4mFdOHT9YPwqv5TeiAAPuMJeW0UEe0HBZ7Q00Ux2W81mu5t0a9AkHxPOPbKPc7zgQhCfeS+zHgp91Zvjs5EBuCvc3nOFzXZQ422j5rwFI1u3LEuxLLbVZToY4l3AHHTgLIdVBPMn761AR4VOh/MkKKufAcBd4bM3K9gIEG6q95r1JB37Yd5Q7wLwJ7+AIJgPeW+l9o09lsZh5PoxAPSeA8BdQfFmBUBoVU2z/X3AXoVU4Rthsc6+0fUTZHSCJxk/PddV1ebFMZzT6tfnATBX+HBuWfcQfLvJh7rdpG/4Zw3u78b/Qwgs+PPITwMlJn5TVZ8NYLuCp9BO+pQHu93/t3ctqQ3DUNCrnKEhaKFFfAFtcoOSLkpKIQkFQ6m6CV0EuzYFJYePnj5W6thGtuSWwJsLaCa8X6yx3zBfwNWr7/IvAGRvXfnhaSTQz9aQC+MFqFRoTBfdsBfrNB38K6Uv2Q5Kj6n8OneBvhrEQgS4kupB/zzMF/BLAvv+gtyFqWsJuevozxZhAtriqI0/0Kdj6Nt0TvJK0udLnbvZelabKgIFqJhIe+NoPsLWcCNBEswPfFXTd6aEYAFt9eiG/mPw3ht4Alf+bB42mew2V56QGAJsHLXUTlmVjK2h9wSvr77DvcbT57NYcOFcLTyKgK448rc1+J3PWELK40oIzp2nKI4AU4+afW20raFvhtk6CVwiloBmPZqCvrVxb48VSACIeAJ0HOkRbz4Vff1is5RQGAlaAIt1CsSRHPFOp3OAqcRPAitUY1AhVMRbPKA+Ffm2f91PSN9KkL0NBrv3jzKJeRBIIOZeakoQpnpbdcijL2OiKSX0L3YLgQRCCPuvJUBxStI900cgEAgEAoFAIBCILlwAvF8Dc39DGy4AAAAASUVORK5CYII=", "seguro": "data:image/png;base64,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", "outro": "data:image/png;base64,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"};

  /* ═══ [J1] FERRAMENTAS ═══════════════════════════════════════════════════════════════════
     O QUE É    Funções pequenas, usadas pelo arquivo todo. Não desenham nada sozinhas.
     AS MAIS USADAS (vale conhecer, para ler o resto do arquivo):
       val(P + 'ITEM')    o que o APEX GUARDA no item (ex.: o código da opção escolhida)
       num('R$ 1.234,56') transforma o texto num número (1234.56) para fazer contas
       brl(1234.56)       o contrário: o número como dinheiro, "R$ 1.234,56"
       bonito('REEMBOLSO COMBUSTIVEL')  → "Reembolso combustível" (veja [J2])
       codDesc('700 - NATCORP DO BRASIL') → "700 - Natcorp do Brasil" (código e descrição)
     QUANDO MEXER  Quase nunca.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  var MOEDA = new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' });
  function brl(n) { return isFinite(n) ? MOEDA.format(n).replace(/ /g, ' ') : '—'; }
  function num(t) {
    if (t === null || t === undefined) return NaN;
    t = String(t).replace(/[^\d,.\-]/g, '');
    if (t.indexOf(',') > -1) t = t.replace(/\./g, '').replace(',', '.');
    return parseFloat(t);
  }
  function val(id) { var it = apex.item(id); return it && it.node ? String(it.getValue() || '') : ''; }
  function el(tag, cls, html) { var e = document.createElement(tag); if (cls) e.className = cls; if (html !== undefined) e.innerHTML = html; return e; }
  function esc(t) { return String(t).replace(/[&<>"]/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]; }); }
  function cap(s) { return s ? s.charAt(0).toUpperCase() + s.slice(1) : s; }

  /* ═══ [J2] TEXTOS, CATEGORIAS E CORES ═══════════════════════════════════════════════════
     O QUE FAZ  • ACENTO: os nomes vêm do cadastro em MAIÚSCULAS e sem acento ("REEMBOLSO
                  COMBUSTIVEL"); bonito() os escreve em letra normal, com acento.
                • CATEGORIAS: decide qual ILUSTRAÇÃO cada benefício ganha (carro, refeição,
                  academia, saúde…), procurando palavras no nome dele.
                • CORES: a cor de cada benefício na barra do saldo e nos cartões, na ordem.
     IMPORTANTE Só muda o que aparece na tela. O nome gravado no banco continua o mesmo.
     PODE MEXER • ACENTO: cada linha é  palavra-sem-acento: 'palavra com acento',  (em
                  minúsculas). Para acrescentar uma, copie um par e troque as duas palavras.
                • CATEGORIAS: o nome da categoria (1º texto) é o nome da ilustração — não mude.
                  O 2º é um padrão de busca entre barras: palavras separadas por | ("ou").
                  Para um benefício novo cair numa categoria, acrescente |palavra no padrão.
                • CORES: códigos de cor (#RRGGBB). Prefira as cores da marca (manual, parte 3).
     CUIDADO    • A ORDEM das CATEGORIAS importa: a primeira que combinar vence (por isso
                  odontológico vem antes de saúde). Benefício que não combina com nenhuma
                  ganha a ilustração "outro".
                • Os padrões de busca (expressões regulares) têm sinais especiais: [ií] quer
                  dizer "i ou í"; \b quer dizer "começo/fim de palavra". Só troque se souber.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* PODE MEXER: palavra sem acento (em minúsculas): 'como deve aparecer' */
  /* textos que chegam do cadastro em MAIÚSCULAS e sem acento ("REEMBOLSO COMBUSTIVEL") */
  var ACENTO = {
    combustivel: 'combustível', educacao: 'educação', locacao: 'locação', veiculo: 'veículo', beneficio: 'benefício',
    beneficios: 'benefícios', previdencia: 'previdência', refeicao: 'refeição', alimentacao: 'alimentação', saude: 'saúde',
    odontologico: 'odontológico', medico: 'médico', medica: 'médica', assistencia: 'assistência', obrigatorios: 'obrigatórios',
    obrigatorio: 'obrigatório', seguranca: 'segurança', manutencao: 'manutenção', academia: 'academia', onibus: 'ônibus',
    remuneracao: 'remuneração', 'remuneraçao': 'remuneração', basica: 'básica'
  };
  function bonito(t) {
    t = String(t || '').replace(/_/g, ' ').replace(/\s+/g, ' ').trim();
    if (!t) return t;
    var letras = t.replace(/[^A-Za-zÀ-ÿ]/g, '');
    var caixaAlta = letras.length > 2 && letras === letras.toUpperCase();
    var s = caixaAlta ? t.toLowerCase() : t;
    s = s.replace(/[A-Za-zÀ-ÿ]+/g, function (w) {
      var k = w.toLowerCase();
      if (!ACENTO[k]) return w;
      return w.charAt(0) === w.charAt(0).toUpperCase() && w.charAt(0) !== w.charAt(0).toLowerCase() ? cap(ACENTO[k]) : ACENTO[k];
    });
    return caixaAlta ? cap(s) : s;
  }
  function semCodigo(t) { return String(t || '').replace(/^\s*\d+\s*-\s*/, '').trim(); }
  /* "700 - NATCORP DO BRASIL" → "700 - Natcorp do Brasil": o código fica (o RH procura por ele) */
  function codDesc(t) {
    var m = /^\s*([\w.]+)\s+-\s+(.+)$/.exec(String(t || ''));
    var d = bonito(m ? m[2] : t).replace(/\s(De|Da|Do|Das|Dos|E|Em|Para)(?=\s)/g, function (x) { return x.toLowerCase(); });
    return m && d ? m[1] + ' - ' + d : d;
  }

  /* PODE MEXER: [nome da ilustração, /palavras|que|levam|a|ela/i] — leia o CUIDADO de [J2] */
  /* categoria → ilustração e cor; a ordem importa (odontológico antes de saúde) */
  var CATEGORIAS = [
    ['carro', /carro|ve[ií]culo|loca[cç][aã]o/i],
    ['previdencia', /previd|aposent|\bpp\b/i],
    ['refeicao', /ticket|refei|aliment|restaur|cesta|\bv\.?[ar]\b|vale.?(ref|alim)/i],
    ['academia', /gym|academ|wellhub|totalpass|fitness/i],
    ['combustivel', /combust|gasolin|quilometr/i],
    ['educacao', /educa|curso|escola|faculd|idioma|bolsa/i],
    ['odonto', /odont|dent/i],
    ['saude', /sa[uú]de|m[eé]dic|plano|assist|farm/i],
    ['transporte', /transp|[oô]nibus|metr[oô]|\bvt\b|mobilid/i],
    ['seguro', /seguro|vida|prote/i]
  ];
  function categoria(txt) {
    for (var i = 0; i < CATEGORIAS.length; i++) if (CATEGORIAS[i][1].test(txt)) return CATEGORIAS[i][0];
    return 'outro';
  }
  /* PODE MEXER: a cor de cada benefício, na ordem em que aparecem (depois do último, repete) */
  var CORES = ['#511C76', '#C95788', '#9CB4D8', '#9A408A', '#2C1A63', '#D884B4', '#544884', '#E4A9C4'];
  function ilustra(cat, cls) {
    var s = el('span', 'nc-ben-ilu' + (cls ? ' ' + cls : ''));
    s.setAttribute('aria-hidden', 'true');
    s.setAttribute('data-cat', cat);
    if (ILU[cat] || ILU.outro) s.style.backgroundImage = 'url(' + (ILU[cat] || ILU.outro) + ')';
    return s;
  }

  function dataBR(t) { var m = String(t || '').match(/(\d{2})\/(\d{2})\/(\d{4})/); return m ? new Date(+m[3], +m[2] - 1, +m[1]) : null; }
  var MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  function dataExtenso(d) { return d ? (d.getDate() === 1 ? '1º' : d.getDate()) + ' de ' + MESES[d.getMonth()] + ' de ' + d.getFullYear() : ''; }
  function anosDesde(d) { if (!d) return 0; var h = new Date(), a = h.getFullYear() - d.getFullYear(); if (h < new Date(h.getFullYear(), d.getMonth(), d.getDate())) a--; return a; }


  /* ═══ [J3] ACHAR REGIÕES E ITENS PELA CLASSE ═════════════════════════════════════════════
     O QUE FAZ  regiao('nc-ben-pacote') acha a região do APEX que tem essa classe.
                item('nc-ben-valor') acha o CAMPO do item que tem essa classe.
                caixaDoItem() cria, dentro do item, o lugar onde entra o desenho novo
                (logo abaixo do campo de verdade, que fica fora da vista).
     QUANDO MEXER  Nunca, em geral. Para ligar/desligar uma parte, ponha/tire a classe no APEX.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function regiao(cls) { return document.querySelector('.t-Region.' + cls + ', .t-ButtonRegion.' + cls); }
  /* a classe do item (Avançado › Classes CSS) vai, no Universal Theme, para o CONTÊINER do
     item (.t-Form-fieldContainer), não para a lista/campo: aceita os dois e devolve o campo */
  function item(cls) {
    var e = document.querySelector('.' + cls);
    if (!e) return null;
    if (/^(SELECT|INPUT|TEXTAREA)$/.test(e.tagName)) return e;
    /* o campo de VERDADE: a caixa da máscara de dinheiro (nc-moeda) vem antes dele e a régua
       depois — nenhuma das duas é o item do APEX */
    return e.querySelector('select, textarea, input:not([type="hidden"]):not(.nc-moeda):not(.nc-ben-regua)');
  }
  function containerDe(el) { return el && el.closest('.t-Form-fieldContainer'); }
  /* o desenho do item entra dentro do contêiner dele, depois do campo (o campo real fica
     lá, fora da vista quando o desenho o substitui) */
  function caixaDoItem(campo, id) {
    var box = document.getElementById(id);
    if (box) return box;
    var c = containerDe(campo);
    var alvo = c && (c.querySelector('.t-Form-inputContainer') || c);
    if (!alvo) return null;
    box = el('div', 'nc-ben-ctrl');
    box.id = id;
    var wrap = alvo.querySelector('.t-Form-itemWrapper');
    if (wrap && wrap.nextSibling) alvo.insertBefore(box, wrap.nextSibling); else alvo.appendChild(box);
    return box;
  }
  function rotuloId(elItem) { var l = document.getElementById(elItem.id + '_LABEL'); return l ? l.id : ''; }

  /* ═══ [J4] LER AS LINHAS DOS RELATÓRIOS ══════════════════════════════════════════════════
     O QUE FAZ  Lê cada linha de "Seu novo pacote", "O que você tem hoje" e "Benefícios
                Requisitados": o benefício, o tipo e o valor. Tudo o que vem depois (barra do
                saldo, cartões, "Novo", "Igual a hoje") usa esta leitura.
     LÊ DAS COLUNAS (pelo nome da coluna no relatório do APEX):
                BENEFICIO (ou BENEFÍCIO), TIPO_BENEFICIO (ou TIPO_BENEFÍCIO), VALOR_TOTAL,
                e no pedido gravado também TIPO (a operação) e VALOR_ANTERIOR.
                A linha do "Total do relatório" é reconhecida e tratada à parte.
                No portal (app 600) o pacote vem como lista (MediaList): o texto é lido do
                título ("<b>Academia</b> | R$ 109,00") e da descrição ("Tipo de Benefício: …").
     CUIDADO    Se uma dessas colunas for RENOMEADA no relatório, os cartões e a barra do saldo
                não acham os dados. Renomeie também aqui (procure  c('  logo abaixo).
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function chaveDe(bene, tipo) { return (bene + '|' + tipo).toLowerCase().replace(/\s+/g, ' '); }
  function linhas(reg) {
    var out = [];
    if (!reg) return out;
    reg.querySelectorAll('table.t-Report-report tbody tr').forEach(function (tr) {
      var c = function (h) { return tr.querySelector('td[headers="' + h + '"]'); };
      var b = c('BENEFICIO') || c('BENEFÍCIO'), t = c('TIPO_BENEFICIO') || c('TIPO_BENEFÍCIO'), v = c('VALOR_TOTAL');
      if (!b || !v) { tr.classList.add('nc-ben-linha-total'); return; }
      var bene = (b.getAttribute('data-nc-txt') || b.textContent).trim();
      var tipo = t ? (t.getAttribute('data-nc-txt') || t.textContent).trim() : '';
      if (/total do relat|^total\b/i.test(bene) || (!bene && /total/i.test(tr.textContent))) { tr.classList.add('nc-ben-linha-total'); return; }
      /* "Benefícios Requisitados" traz a operação (Inserido / Removido / -) e o valor de antes */
      var op = c('TIPO'), ant = c('VALOR_ANTERIOR');
      out.push({ tr: tr, cb: b, ct: t, cv: v, bene: bene, tipo: tipo, valor: num(v.getAttribute('data-nc-txt') || v.textContent), chave: chaveDe(bene, tipo),
        op: op ? (op.getAttribute('data-nc-txt') || op.textContent).trim() : '', anterior: ant ? num(ant.textContent) : NaN });
    });
    /* o portal (app 600) mostra o pacote em MediaList: o texto vem pronto do SQL —
       "<b>Academia</b> | R$ 109,00" no título e "Tipo de Benefício: <b>Plano Platinum</b>…" */
    reg.querySelectorAll('li.t-MediaList-item').forEach(function (li) {
      if (li.__ncBen) { out.push(li.__ncBen); return; }
      var tit = li.querySelector('.t-MediaList-title'), desc = li.querySelector('.t-MediaList-desc');
      if (!tit) return;
      var h = desc ? desc.innerHTML : '';
      function campo(rot) { var m = new RegExp(rot + ':\\s*<b>([\\s\\S]*?)</b>', 'i').exec(h); return m ? limpoHtml(m[1]) : ''; }
      var nomeTit = limpoHtml(((tit.querySelector('b') || {}).innerHTML) || tit.textContent.split('|')[0]);
      var valor = num((tit.textContent.split('|')[1] || '').replace(/R\$/, ''));
      var tipo = campo('Tipo de Benef[ií]cio');
      var i = { tr: li, lista: true, bene: nomeTit, tipo: tipo === nomeTit ? '' : tipo, valor: valor, qtd: campo('Quantidade'), escolhido: num(campo('Valor Escolhido').replace(/R\$/, '')),
        remover: li.querySelector('a.apagarBeneficio'), op: '', anterior: NaN };
      i.chave = chaveDe(i.bene, i.tipo);
      li.__ncBen = i;
      out.push(i);
    });
    return out;
  }
  function limpoHtml(t) { var d = document.createElement('div'); d.innerHTML = String(t || ''); return (d.textContent || '').replace(/\s+/g, ' ').trim(); }

  /* ═══ [J5] O CARTÃO DO COLABORADOR ═══════════════════════════════════════════════════════
     O QUE FAZ  Na região nc-ben-perfil-regiao, monta o cartão: iniciais (ou a foto), nome,
                matrícula, empresa ("700 - Natcorp do Brasil"), cargo (só na 116), situação,
                "Na empresa desde" com os anos de casa e "As escolhas valem a partir de".
                Sem colaborador escolhido, o cartão não aparece.
     LÊ DOS ITENS  P168_MATRICULA_DISPLAY, P168_COD_EMPRESA_DISPLAY, P168_SITUACAO_COLAB,
                P168_FOTO_COLAB e os da lista NOME de [J0] (admissão, vigência, cargo).
     PODE MEXER os rótulos entre aspas: 'Cargo hoje', 'Situação', 'Na empresa desde',
                'As escolhas valem a partir de', 'Matrícula '.
     VISUAL     Natcorp_Beneficios.css › [C2]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarPerfil() {
    var reg = regiao('nc-ben-perfil-regiao');
    if (!reg) return;
    var corpo = reg.querySelector('.t-Region-body');
    var col = val(P + 'MATRICULA_DISPLAY');
    var nome = semCodigo(col);
    var p = document.getElementById('nc-ben-perfil');
    /* 04/10: sem o colaborador escolhido (o item real vazio) não há cartão — na 116, "Selecionar
       colaborador" limpa a matrícula e MOSTRA os campos de escolha, mas o _DISPLAY guarda o nome
       de antes: o cartão ficava e escondia (fora da vista) os campos que a página acabou de mostrar */
    if (!nome || !val(P + NOME.matricula)) { if (p) p.hidden = true; reg.classList.remove('nc-ben-com-perfil'); return; }
    if (!p) { p = el('div', 'nc-ben-perfil'); p.id = 'nc-ben-perfil'; corpo.insertBefore(p, corpo.firstChild); }
    p.hidden = false;
    reg.classList.add('nc-ben-com-perfil');
    var mat = (col.match(/^\s*(\d+)/) || [])[1] || '';
    var emp = codDesc(val(P + 'COD_EMPRESA_DISPLAY'));
    var sit = val(P + 'SITUACAO_COLAB').split(/\s+-\s+/);
    var situacao = bonito(sit[1] || sit[0] || '');
    var adm = dataBR(val(P + NOME.admissao));
    var vig = NOME.vigencia ? dataBR(val(P + NOME.vigencia)) : null;
    var cargo = NOME.cargo ? codDesc((document.getElementById(P + NOME.cargo) || {}).value || '') : '';  // o texto da lista (popup): "624 - Supervisor de Setor"
    var foto = document.querySelector('#' + P + 'FOTO_COLAB_CONTAINER img');
    var ini = nome.split(/\s+/).filter(Boolean);
    ini = (ini[0] || '').charAt(0) + (ini.length > 1 ? ini[ini.length - 1].charAt(0) : '');
    var anos = anosDesde(adm);
    p.innerHTML =
      '<div class="nc-ben-avatar">' + (foto && foto.getAttribute('src') ? '<img alt="" src="' + esc(foto.getAttribute('src')) + '">' : '<span>' + esc(ini.toUpperCase()) + '</span>') + '</div>' +
      '<div class="nc-ben-quem"><p class="nc-ben-nome">' + esc(nome) + '</p>' +
        '<p class="nc-ben-meta">' + [mat ? 'Matrícula ' + esc(mat) : '', esc(emp)].filter(Boolean).join('<span aria-hidden="true"> · </span>') + '</p></div>' +
      '<dl class="nc-ben-fatos">' +
        (cargo ? '<div><dt>Cargo hoje</dt><dd>' + esc(cargo) + '</dd></div>' : '') +
        (situacao ? '<div><dt>Situação</dt><dd><span class="nc-ben-chip' + (/ativo/i.test(situacao) ? ' nc-ben-chip--ok' : '') + '">' + esc(situacao) + '</span></dd></div>' : '') +
        (adm ? '<div><dt>Na empresa desde</dt><dd>' + MESES[adm.getMonth()] + ' de ' + adm.getFullYear() + (anos > 0 ? ' <span class="nc-ben-sutil">· ' + anos + (anos === 1 ? ' ano' : ' anos') + '</span>' : '') + '</dd></div>' : '') +
        (vig ? '<div class="nc-ben-vigencia"><dt>As escolhas valem a partir de</dt><dd>' + dataExtenso(vig) + '</dd></div>' : '') +
      '</dl>';
  }

  /* ═══ [J6] A BARRA DO SALDO ══════════════════════════════════════════════════════════════
     O QUE FAZ  Na região nc-ben-medidor, desenha: o valor total, quanto "Ainda pode usar",
                uma barra com um pedaço colorido por benefício (e o pedaço livre), a legenda
                e uma frase do que fazer ("Você já distribuiu… Ainda pode usar…").
                Os itens da região continuam lá, fora da vista: são a fonte dos números.
                Sem colaborador, a região não aparece (volta sozinha depois).
     LÊ DOS ITENS  P168_TOTAL, P168_SALDO e as linhas do pacote (veja [J4]).
                Se SALDO vier vazio, a conta é feita aqui: total menos o que está no pacote.
     PODE MEXER as frases entre aspas: 'Você já distribuiu', 'Tudo distribuído',
                'O pacote passou', 'Ainda pode usar', 'Passou do valor'…
     VISUAL     Natcorp_Beneficios.css › [C3]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* o pacote que vale: o "Seu novo pacote"; no pedido gravado em que ele vem escondido e vazio
     (Alteração Funcional, 116), o que foi pedido — sem os que saem */
  function itensDoPacote() {
    var pac = regiao('nc-ben-pacote'), p = linhas(pac);
    var req = regiaoRequisitados(), q = req ? linhas(req) : [];
    if (pac && !(req && q.length && (pac.style.display === 'none' || !p.length))) return p;
    return q.filter(function (x) { return !/remov/i.test(x.op); });
  }
  function montarSaldo() {
    var reg = regiao('nc-ben-medidor');
    if (!reg) return;
    var corpo = reg.querySelector('.t-Region-body') || reg;
    var s = document.getElementById('nc-ben-saldo');
    if (!s) { s = el('div', 'nc-ben-saldo'); s.id = 'nc-ben-saldo'; s.setAttribute('aria-live', 'polite'); corpo.insertBefore(s, corpo.firstChild); }
    var total = num(val(P + 'TOTAL'));
    var saldo = num(val(P + 'SALDO'));
    /* sem colaborador escolhido não há o que medir: a região some (volta sozinha depois) */
    var semDados = !isFinite(total) || !val(P + NOME.matricula);
    reg.classList.toggle('nc-ben-sem-dados', semDados);
    if (semDados) return;
    var itens = itensDoPacote();
    var usado = itens.reduce(function (a, i) { return a + (isFinite(i.valor) ? i.valor : 0); }, 0);
    if (!isFinite(saldo)) saldo = total - usado;
    var seg = itens.map(function (i, k) {
      return '<span class="nc-ben-seg" style="flex-grow:' + Math.max(i.valor, 0) + ';background:' + CORES[k % CORES.length] + '" title="' + esc(bonito(i.bene)) + ': ' + brl(i.valor) + '"></span>';
    }).join('') + (saldo > 0 ? '<span class="nc-ben-seg nc-ben-seg--livre" style="flex-grow:' + saldo + '" title="Ainda livre: ' + brl(saldo) + '"></span>' : '');
    var leg = itens.map(function (i, k) {
      return '<li><i style="background:' + CORES[k % CORES.length] + '"></i>' + esc(bonito(i.bene)) + ' <b>' + brl(i.valor) + '</b></li>';
    }).join('') + (saldo > 0 ? '<li class="nc-ben-leg-livre"><i></i>Ainda livre <b>' + brl(saldo) + '</b></li>' : '');
    var estado = saldo > 0.004 ? 'livre' : (saldo < -0.004 ? 'passou' : 'completo');
    var frase = estado === 'livre'
      ? 'Você já distribuiu <b>' + brl(usado) + '</b> de <b>' + brl(total) + '</b>. Ainda pode usar <b>' + brl(saldo) + '</b> em outro benefício.'
      : estado === 'completo' ? 'Tudo distribuído: os <b>' + brl(total) + '</b> estão no seu pacote.'
        : 'O pacote passou <b>' + brl(-saldo) + '</b> do seu valor. Remova um benefício ou diminua um valor.';
    s.setAttribute('data-estado', estado);
    s.innerHTML =
      '<div class="nc-ben-saldo-topo">' +
        '<div><p class="nc-ben-rot">Seu valor para benefícios</p><p class="nc-ben-total">' + brl(total) + '</p></div>' +
        '<div class="nc-ben-sobra"><p class="nc-ben-rot">' + (estado === 'passou' ? 'Passou do valor' : 'Ainda pode usar') + '</p><p class="nc-ben-sobra-valor">' + brl(Math.abs(saldo)) + '</p></div>' +
      '</div>' +
      '<div class="nc-ben-barra" role="img" aria-label="' + esc('Usado ' + brl(usado) + ' de ' + brl(total)) + '">' + seg + '</div>' +
      (leg ? '<ul class="nc-ben-legenda">' + leg + '</ul>' : '') +
      '<p class="nc-ben-frase">' + frase + '</p>';
    montarResumo(itens, total, saldo);
  }

  /* ═══ [J7] A MÁSCARA DE DINHEIRO ═════════════════════════════════════════════════════════
     O QUE FAZ  A pessoa vê e digita "R$ 1.234,56", mas o banco continua recebendo o número
                no formato de sempre ("1234,56", sem ponto de milhar e sem R$).
     COMO       Uma caixa de EXIBIÇÃO é posta por cima do campo de verdade. Ela não tem nome,
                então NÃO é enviada ao servidor. Quando a pessoa sai dela, o número puro vai
                para o campo de verdade (apex.item().setValue) — e as ações dinâmicas, as
                validações e o Salvar leem só o campo de verdade.
     CUIDADO    Não mude esta parte sem testar o Salvar: um erro aqui pode mandar um valor
                errado para o banco. Ela também é usada pela página 116 (window.ncMoeda, lida
                pelo Natcorp_Movimentacao.js).
     VISUAL     Natcorp_Beneficios.css › [C13] (máscara de dinheiro)
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- máscara de dinheiro: R$ 999.999.990,90 ----------
     O campo de VERDADE do APEX continua com o número puro, no formato que a página já usa e o
     Oracle recebe hoje (vírgula decimal, sem ponto de milhar e sem "R$": 5200, 4028,85). A
     pessoa vê e digita numa caixa de exibição por cima (sem name: não é enviada); ao sair dela,
     o número puro vai para o campo de verdade por apex.item().setValue — as ações dinâmicas,
     as validações e o Salvar leem só ele. Quando o servidor muda o campo (o % que calcula o
     salário), a caixa se atualiza. window.ncMoeda serve à 116 (Natcorp_Movimentacao) também. */
  var MIL = new Intl.NumberFormat('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  function moedaTexto(n, prefixo) { return (prefixo ? 'R$ ' : '') + MIL.format(n); }
  /* o número puro no formato da página: inteiro sem decimais (5200) ou com vírgula (4028,85) */
  function moedaCru(n) { var c = Math.round(n * 100); return c % 100 === 0 ? String(c / 100) : (c / 100).toFixed(2).replace('.', ','); }
  /* o que a pessoa digitou: só dígitos e UMA vírgula (os pontos são de milhar, a máscara põe) */
  function moedaDigitado(t) {
    t = String(t || '').replace(/R\$\s?/g, '').replace(/\./g, '').replace(/[^\d,]/g, '');
    var i = t.indexOf(','), inteiro = (i < 0 ? t : t.slice(0, i)).replace(/^0+(?=\d)/, '').slice(0, 9), dec = i < 0 ? null : t.slice(i + 1).replace(/,/g, '').slice(0, 2);
    return { inteiro: inteiro, dec: dec };
  }
  function moedaAoDigitar(p, prefixo) {
    if (!p.inteiro && p.dec === null) return '';
    return (prefixo ? 'R$ ' : '') + (p.inteiro || '0').replace(/\B(?=(\d{3})+(?!\d))/g, '.') + (p.dec !== null ? ',' + p.dec : '');
  }
  function moedaSync(real) {
    var vis = real && real.__ncVis;
    if (!vis || document.activeElement === vis) return;
    var n = num(real.value);
    var t = real.value !== '' && isFinite(n) ? moedaTexto(n, vis.__ncPrefixo) : '';
    if (vis.value !== t) vis.value = t;
    var so = real.readOnly || real.disabled || real.classList.contains('apex_disabled');
    if (vis.readOnly !== so) vis.readOnly = so;
    vis.classList.toggle('apex_disabled', real.classList.contains('apex_disabled'));
  }
  function moedaAplicar(real, prefixo) {
    if (!real || real.tagName !== 'INPUT' || real.__ncVis) return;
    var vis = document.createElement('input');
    vis.type = 'text';
    vis.id = 'nc-moeda-' + real.id;
    vis.className = real.className.replace(/\b(number_field|text_field)\b/g, '') + ' nc-moeda';
    vis.setAttribute('inputmode', 'decimal');
    vis.setAttribute('autocomplete', 'off');
    vis.__ncPrefixo = !!prefixo;
    vis.placeholder = prefixo ? 'R$ 0,00' : '0,00';
    var lab = document.getElementById(real.id + '_LABEL');
    if (lab) { lab.htmlFor = vis.id; vis.setAttribute('aria-labelledby', lab.id); }
    real.parentNode.insertBefore(vis, real);
    real.classList.add('nc-moeda-real');
    real.tabIndex = -1;
    real.setAttribute('aria-hidden', 'true');
    real.__ncVis = vis;
    /* entrar no campo seleciona o valor (digitar já troca) — na hora do foco, antes do 1º dígito;
       o mouseup do clique desfaria a seleção, por isso é barrado uma vez */
    vis.addEventListener('focus', function () { try { vis.select(); } catch (e) {} vis.__ncSel = true; });
    vis.addEventListener('mouseup', function (e) { if (vis.__ncSel) { vis.__ncSel = false; e.preventDefault(); } });
    vis.addEventListener('keydown', function () { vis.__ncSel = false; });
    vis.addEventListener('input', function () {
      /* a máscara enquanto digita, com o cursor no mesmo dígito */
      var pos = vis.selectionStart, antes = vis.value.slice(0, pos).replace(/[^\d,]/g, '').length;
      var novo = moedaAoDigitar(moedaDigitado(vis.value), vis.__ncPrefixo);
      if (novo === vis.value) return;
      vis.value = novo;
      var k = 0, i = 0;
      for (; i < novo.length && k < antes; i++) if (/[\d,]/.test(novo[i])) k++;
      try { vis.setSelectionRange(i, i); } catch (e) {}
    });
    vis.addEventListener('change', function () {
      var p = moedaDigitado(vis.value), cru = '';
      if (p.inteiro || p.dec) { var n = parseFloat((p.inteiro || '0') + '.' + (p.dec || '0')); cru = moedaCru(n); vis.value = moedaTexto(n, vis.__ncPrefixo); }
      else vis.value = '';
      if (cru !== real.value) apex.item(real.id).setValue(cru);
    });
    vis.addEventListener('blur', function () { setTimeout(function () { moedaSync(real); }, 0); });
    $(real).on('change', function () { moedaSync(real); });
    moedaSync(real);
  }
  function moedaSyncTudo() { [].forEach.call(document.querySelectorAll('input.nc-moeda-real'), moedaSync); }
  window.ncMoeda = { aplicar: moedaAplicar, sync: moedaSync, syncTudo: moedaSyncTudo, cru: moedaCru };

  /* ═══ [J8] OPÇÃO, BENEFÍCIO E TIPO: BOTÕES E CARTÕES NO LUGAR DAS LISTAS ═════════════════
     O QUE FAZ  montarSegmento  item nc-ben-segmento (P168_OPCAO): dois botões lado a lado,
                                cada um com uma explicação curta embaixo.
                montarChips     item nc-ben-chips (P168_BENEFICIO): botões pequenos com
                                ilustração. Com UMA opção só, a pessoa toca nela (04/10).
                montarCartoes   item nc-ben-cartoes (P168_TIPO_BENEFICIO): cartões ilustrados;
                                o tipo que já está no pacote ganha o selo "Já no pacote".
     COMO       Os botões são feitos a partir das OPÇÕES da lista do APEX. Para mudar uma
                opção, mude a lista (LOV) no APEX. Clicar faz setValue na lista de verdade:
                as ações dinâmicas e cascatas disparam como antes.
     PODE MEXER • a lista "dicas" em montarSegmento: o texto pequeno de cada botão, pelo
                  VALOR da opção (C = Complementares, O = Obrigatórios).
                • 'Já no pacote'.
     VISUAL     Natcorp_Beneficios.css › [C4]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function opcoes(sel) { return [].slice.call(sel.options).filter(function (o) { return o.value !== ''; }); }
  function escolher(sel, v) { if (v !== sel.value) apex.item(sel.id).setValue(v); }

  function montarSegmento() {
    var sel = item('nc-ben-segmento');
    if (!sel || sel.tagName !== 'SELECT') return;
    var box = caixaDoItem(sel, 'nc-ben-ctrl-' + sel.id);
    if (!box) return;
    if (!box.getAttribute('role')) {
      box.setAttribute('role', 'radiogroup');
      box.setAttribute('aria-labelledby', rotuloId(sel));
      box.classList.add('nc-ben-segmento-ctrl');
      box.addEventListener('click', function (e) { var b = e.target.closest('button[data-v]'); if (b) escolher(sel, b.getAttribute('data-v')); });
    }
    var dicas = { C: 'Escolha livre, dentro do seu valor', O: 'Os que a empresa exige' };
    box.innerHTML = opcoes(sel).map(function (o) {
      return '<button type="button" role="radio" aria-checked="' + (o.value === sel.value) + '" data-v="' + esc(o.value) + '"><span>' + esc(bonito(o.text)) + '</span>' + (dicas[o.value] ? '<small>' + dicas[o.value] + '</small>' : '') + '</button>';
    }).join('');
  }

  function montarChips() {
    var sel = item('nc-ben-chips');
    if (!sel || sel.tagName !== 'SELECT') return;
    var ops = opcoes(sel);
    var c = containerDe(sel);
    /* 04/10 (cliente): com uma opção só, ela NÃO é escolhida sozinha — a pessoa toca nela */
    var box = caixaDoItem(sel, 'nc-ben-ctrl-' + sel.id);
    if (!box) return;
    if (!box.getAttribute('role')) {
      box.setAttribute('role', 'radiogroup');
      box.setAttribute('aria-labelledby', rotuloId(sel));
      box.classList.add('nc-ben-chips-ctrl');
      box.addEventListener('click', function (e) { var b = e.target.closest('button[data-v]'); if (b) escolher(sel, b.getAttribute('data-v')); });
    }
    if (c) c.classList.toggle('nc-ben-uma-opcao', ops.length < 2);
    box.innerHTML = ops.map(function (o) {
      var img = ILU[categoria(o.text)] || ILU.outro;
      return '<button type="button" role="radio" aria-checked="' + (o.value === sel.value) + '" data-v="' + esc(o.value) + '">' +
        (img ? '<span class="nc-ben-ilu nc-ben-ilu--chip" aria-hidden="true" style="background-image:url(' + img + ')"></span>' : '') + esc(bonito(o.text)) + '</button>';
    }).join('');
  }

  function montarCartoes() {
    var sel = item('nc-ben-cartoes');
    if (!sel || sel.tagName !== 'SELECT') return;
    var box = caixaDoItem(sel, 'nc-ben-ctrl-' + sel.id);
    if (!box) return;
    if (!box.getAttribute('role')) {
      box.setAttribute('role', 'radiogroup');
      box.setAttribute('aria-labelledby', rotuloId(sel));
      box.classList.add('nc-ben-cartoes-ctrl');
      box.addEventListener('click', function (e) { var b = e.target.closest('button[data-v]'); if (b) escolher(sel, b.getAttribute('data-v')); });
    }
    var grupo = item('nc-ben-chips');
    var noPacote = {};
    linhas(regiao('nc-ben-pacote')).forEach(function (i) { noPacote[(i.tipo || i.bene).toLowerCase()] = true; });
    box.innerHTML = '';
    opcoes(sel).forEach(function (o) {
      var b = el('button', 'nc-ben-cartao');
      b.type = 'button';
      b.setAttribute('role', 'radio');
      b.setAttribute('aria-checked', String(o.value === sel.value));
      b.setAttribute('data-v', o.value);
      b.appendChild(ilustra(categoria(o.text + ' ' + (grupo ? grupo.options[grupo.selectedIndex] && grupo.options[grupo.selectedIndex].text : ''))));
      b.appendChild(el('span', 'nc-ben-cartao-nome', esc(bonito(o.text))));
      if (noPacote[o.text.toLowerCase()]) b.appendChild(el('span', 'nc-ben-cartao-selo', 'Já no pacote'));
      box.appendChild(b);
    });
  }

  /* ═══ [J9] O VALOR: − / +, RÉGUA, ATALHOS E O AVISO DE SALDO ════════════════════════════
     O QUE FAZ  No item nc-ben-valor (P168_VALOR): botões − e + ao lado do campo, uma régua
                para arrastar, atalhos de um toque ("Mínimo", "Máximo" ou "Tudo o que sobra")
                e uma frase com a faixa permitida. Avisa ANTES quando o mínimo do benefício
                não cabe no saldo livre, e segura o "Adicionar" com um valor que o servidor
                recusaria (em vez da caixa de erro do APEX).
     LÊ DOS ITENS  P168_VALOR_MIN, P168_VALOR_MAX, P168_SALDO, P168_TIPO_BENEFICIO, e o botão
                de ID estático ADICIONAR.
     REGRAS     • O teto é o menor entre o máximo do benefício e o saldo livre.
                • Mínimo igual ao máximo (ex.: Gympass R$ 117,00) = valor fixo: já preenchido,
                  sem − e +.
                • O − e o + só avisam o servidor quando a pessoa para de tocar (450 ms): cada
                  aviso dispara as ações dinâmicas do valor.
     PODE MEXER as frases entre aspas ('Escolha um valor de', 'Valor fixo deste benefício',
                'Este benefício começa em', 'Mínimo', 'Tudo o que sobra'…).
     CUIDADO    As contas de centavos (arredondar o saldo PARA BAIXO) evitam que "Tudo o que
                sobra" seja recusado pelo servidor. Não mude.
     VISUAL     Natcorp_Beneficios.css › [C5] e [C13]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function limites() {
    var min = num(val(P + 'VALOR_MIN')), max = num(val(P + 'VALOR_MAX')), saldo = num(val(P + 'SALDO'));
    var teto = isFinite(max) ? max : NaN;
    if (isFinite(saldo) && saldo > 0 && isFinite(teto)) teto = Math.min(teto, saldo);
    /* centavos: o saldo pode vir com mais casas (751,40399) e o servidor compara arredondado —
       o teto é o saldo arredondado PARA BAIXO, assim "tudo o que sobra" sempre cabe */
    if (isFinite(teto)) teto = Math.floor(teto * 100 + 1e-6) / 100;
    var mn = isFinite(min) ? min : 0;
    /* valor fixo: mínimo igual ao máximo, ou só o mínimo (sem máximo) — o servidor responde
       "O Valor escolhido deve ser 117" (Gympass) */
    var fixo = isFinite(min) && min > 0 && (!isFinite(max) || Math.abs(max - min) < 0.005);
    return { min: mn, max: max, saldo: saldo, teto: fixo ? min : teto, fixo: fixo };
  }
  function centavos(v) { return Math.round(v * 100) / 100; }
  function emTexto(v) { return centavos(v).toFixed(2).replace('.', ','); }
  /* o valor válido para este benefício: dentro da faixa e do que sobra */
  function valorValido(v, lim) {
    if (!isFinite(v) || v <= 0) return false;
    if (v < lim.min - 0.004) return false;
    if (isFinite(lim.teto) && v > lim.teto + 0.004) return false;
    return true;
  }
  var T_VALOR = null, VALOR_PENDENTE = null;
  function mandarValor(input) { clearTimeout(T_VALOR); if (VALOR_PENDENTE !== null) { var v = VALOR_PENDENTE; VALOR_PENDENTE = null; apex.item(input.id).setValue(v); } }

  function montarValor() {
    var input = item('nc-ben-valor');
    if (!input || input.tagName !== 'INPUT') return;
    var wrap = input.closest('.t-Form-itemWrapper');
    if (wrap && !wrap.classList.contains('nc-ben-valor-linha')) {
      /* − e + ao lado do campo, dentro da mesma moldura; o campo não sai do lugar */
      wrap.classList.add('nc-ben-valor-linha');
      var menos = el('button', 'nc-ben-passo', '−'); menos.type = 'button'; menos.setAttribute('data-d', '-1'); menos.setAttribute('aria-label', 'Diminuir o valor');
      var mais = el('button', 'nc-ben-passo', '+'); mais.type = 'button'; mais.setAttribute('data-d', '1'); mais.setAttribute('aria-label', 'Aumentar o valor');
      var rs = el('span', 'nc-ben-rs', 'R$'); rs.setAttribute('aria-hidden', 'true');
      wrap.insertBefore(menos, wrap.firstChild);
      input.parentNode.insertBefore(rs, input);
      wrap.appendChild(mais);
      input.setAttribute('inputmode', 'decimal');
      moedaAplicar(input, false);
      /* − e + mudam o número na hora e só mandam ao servidor quando a pessoa para de tocar
         (cada envio dispara as ações dinâmicas do valor: antes eram ~8 chamadas por toque) */
      wrap.addEventListener('click', function (e) {
        var b = e.target.closest('.nc-ben-passo');
        if (!b || input.readOnly) return;
        var lim = limites();
        var faixa = (isFinite(lim.teto) ? lim.teto : lim.min + 1000) - lim.min;
        var passo = faixa > 1000 ? 50 : (faixa > 100 ? 10 : 1);
        var atual = num(input.value);
        var v = isFinite(atual) ? atual + passo * +b.getAttribute('data-d') : lim.min;
        if (isFinite(lim.teto)) v = Math.min(lim.teto, v);
        v = Math.max(lim.min, v);
        input.value = emTexto(v);
        VALOR_PENDENTE = input.value;
        if (input.__ncVis) input.__ncVis.value = moedaTexto(v, false);
        clearTimeout(T_VALOR);
        T_VALOR = setTimeout(function () { mandarValor(input); }, 450);
        montarValor();
      });
    }
    var box = caixaDoItem(input, 'nc-ben-ctrl-' + input.id);
    if (!box) return;
    if (!box.querySelector('.nc-ben-regua')) {
      box.innerHTML = '<input type="range" class="nc-ben-regua" aria-label="Valor do benefício" tabindex="-1"><div class="nc-ben-atalhos-valor"></div><ul class="nc-ben-limites"></ul>';
      var regua = box.querySelector('.nc-ben-regua');
      regua.addEventListener('input', function () { var v = num(regua.value); input.value = emTexto(v); if (input.__ncVis) input.__ncVis.value = moedaTexto(v, false); });
      regua.addEventListener('change', function () { var l = limites(), v = centavos(num(regua.value)); if (isFinite(l.teto)) v = Math.min(v, l.teto); apex.item(input.id).setValue(emTexto(v)); });
      /* atalhos: o mínimo, o máximo e "tudo o que sobra" — um toque e o valor está certo */
      box.querySelector('.nc-ben-atalhos-valor').addEventListener('click', function (e) {
        var b = e.target.closest('[data-v]'); if (!b) return;
        clearTimeout(T_VALOR); VALOR_PENDENTE = null;
        apex.item(input.id).setValue(b.getAttribute('data-v'));
      });
    }
    var lim = limites();
    var c = containerDe(input);
    /* o mínimo não cabe no que sobra: o servidor recusaria ("Este valor 117 está acima do
       saldo de 54") — a tela diz antes, e diz o que fazer */
    var naoCabe = isFinite(lim.min) && isFinite(lim.saldo) && lim.min > lim.saldo + 0.004;
    c.classList.toggle('nc-ben-nao-cabe', naoCabe);
    /* valor fixo (mínimo = máximo, ex.: Gympass R$ 117,00): já preenchido, sem − e + */
    var fixo = lim.fixo && !naoCabe;
    c.classList.toggle('nc-ben-valor-fixo', fixo);
    input.readOnly = fixo;
    var tipo = val(P + 'TIPO_BENEFICIO');
    if (tipo && input.__ncTipo !== tipo + '|' + lim.min + '|' + lim.max) {
      input.__ncTipo = tipo + '|' + lim.min + '|' + lim.max;
      /* um benefício novo escolhido: o campo já começa num valor que o servidor aceita */
      if (!naoCabe && isFinite(lim.min) && lim.min > 0 && (fixo || !valorValido(num(input.value), lim))) apex.item(input.id).setValue(emTexto(lim.min));
    }
    var r = box.querySelector('.nc-ben-regua');
    r.hidden = fixo || naoCabe || !(isFinite(lim.teto) && lim.teto > lim.min);
    if (!r.hidden) { r.min = lim.min; r.max = lim.teto; r.step = (lim.teto - lim.min) > 100 ? 1 : 0.5; var v = num(input.value); if (isFinite(v)) r.value = v; }
    var at = [];
    if (!fixo && !naoCabe && tipo) {
      if (lim.min > 0) at.push(['Mínimo', lim.min]);
      if (isFinite(lim.teto) && lim.teto > lim.min) at.push([isFinite(lim.max) && lim.teto < lim.max - 0.004 ? 'Tudo o que sobra' : 'Máximo', lim.teto]);
    }
    var atal = box.querySelector('.nc-ben-atalhos-valor');
    var hA = at.map(function (a) { return '<button type="button" class="nc-ben-atalho-valor" data-v="' + emTexto(a[1]) + '"><span>' + a[0] + '</span><b>' + brl(a[1]) + '</b></button>'; }).join('');
    if (atal.__h !== hA) { atal.__h = hA; atal.innerHTML = hA; }
    var frases = [];
    if (naoCabe) frases.push('<span class="nc-ben-aviso">Este benefício começa em <b>' + brl(lim.min) + '</b> e você tem <b>' + brl(Math.max(lim.saldo, 0)) + '</b> livres. Para escolhê-lo, remova ou diminua outro benefício do seu pacote.</span>');
    else if (fixo) frases.push('Valor fixo deste benefício: <b>' + brl(lim.min) + '</b>. É só tocar em Adicionar.');
    else if (tipo && isFinite(lim.teto)) frases.push('Escolha um valor de <b>' + brl(lim.min) + '</b> até <b>' + brl(lim.teto) + '</b>' + (isFinite(lim.max) && lim.teto < lim.max - 0.004 ? ' (o que sobra no seu saldo; o benefício vai até ' + brl(lim.max) + ')' : '') + '.');
    if (c.__ncInvalido) frases.push('<span class="nc-ben-aviso">' + c.__ncInvalido + '</span>');
    var hL = frases.map(function (t) { return '<li>' + t + '</li>'; }).join('');
    var ul = box.querySelector('.nc-ben-limites');
    if (ul.__h !== hL) { ul.__h = hL; ul.innerHTML = hL; }
    moedaSync(input);
  }
  /* "Adicionar" só com um valor que o servidor aceita: a caixa de OK do APEX ("O Valor
     escolhido deve estar entre 39 e 60") virava uma tentativa e erro — o aviso fica no campo */
  function guardarAdicionar() {
    document.addEventListener('click', function (e) {
      var b = e.target.closest && e.target.closest('#ADICIONAR');
      if (!b) return;
      var input = item('nc-ben-valor');
      if (!input || !input.offsetParent) return;
      mandarValor(input);
      var lim = limites(), v = num(input.value), c = containerDe(input), msg = '';
      if (!val(P + 'TIPO_BENEFICIO')) return;
      if (c.classList.contains('nc-ben-nao-cabe')) msg = 'Não cabe no saldo: remova ou diminua outro benefício antes.';
      else if (!valorValido(v, lim)) msg = isFinite(lim.teto) ? 'Para adicionar, escolha um valor de ' + brl(lim.min) + ' até ' + brl(lim.teto) + '.' : 'Para adicionar, escolha um valor a partir de ' + brl(lim.min) + '.';
      c.__ncInvalido = msg;
      if (!msg) { montarValor(); return; }
      e.preventDefault(); e.stopPropagation(); e.stopImmediatePropagation();
      montarValor();
      var alvo = input.__ncVis || input;
      try { alvo.focus({ preventScroll: true }); } catch (x) { alvo.focus(); }
      c.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }, true);
    $(document).on('change input', '#' + P + 'VALOR', function () { var c = containerDe(this); if (c && c.__ncInvalido) { c.__ncInvalido = ''; montarValor(); } });
  }


  /* ═══ [J10] OS CARTÕES DO PACOTE E DE HOJE ═══════════════════════════════════════════════
     O QUE FAZ  Cada linha de "Seu novo pacote", "O que você tem hoje" e "Benefícios
                Requisitados" vira um cartão: ilustração, nome, tipo embaixo, valor, e um selo
                com o que muda:
                  no pacote novo   "Novo" · "Igual a hoje" · "+ R$ …" · "− R$ …"
                  em hoje          "Sai do pacote" (o que não está no pacote novo)
                  no pedido gravado "Novo" · "Continua" · "Sai do pacote" (valor de antes riscado)
                O "Remover" do APEX (o mesmo link, que abre a confirmação) vai para o cartão.
                A linha do total vira "Total do novo pacote" / "Total hoje".
     PODE MEXER os textos dos selos e dos totais, entre aspas.
     CUIDADO    O candidato do portal (app 600) não tem "o que você tem hoje": por isso, lá,
                nada recebe "Novo" (veja o comentário de decorar).
     VISUAL     Natcorp_Beneficios.css › [C6] e [C10]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* o item de MediaList (portal) vira o mesmo cartão: nome e tipo, valor, e o "Remover" do
     APEX (o mesmo link, movido para o cartão) */
  function cartaoDaLista(i) {
    if (i.card) return;
    var li = i.tr;
    var card = el('div', 'nc-ben-li-card');
    var tipoTxt = bonito(i.tipo);
    var extra = [];
    if (i.qtd && +i.qtd > 1) extra.push(i.qtd + ' × ' + brl(i.escolhido));
    card.innerHTML = '<span class="nc-ben-li-bene"><span class="nc-ben-txt"><span class="nc-ben-txt-nome">' + esc(bonito(i.bene)) + '</span>' +
        (tipoTxt && tipoTxt.toLowerCase() !== bonito(i.bene).toLowerCase() ? '<small>' + esc(tipoTxt) + '</small>' : '') +
        (extra.length ? '<small>' + esc(extra.join(' · ')) + '</small>' : '') + '</span></span>' +
      '<span class="nc-ben-li-valor">' + (isFinite(i.valor) ? brl(i.valor) : '') + '</span>' +
      '<span class="nc-ben-li-remover"></span>';
    card.querySelector('.nc-ben-li-bene').insertBefore(ilustra(categoria(i.bene + ' ' + i.tipo), 'nc-ben-ilu--linha'), card.querySelector('.nc-ben-txt'));
    if (i.remover) {
      i.remover.classList.remove('t-Button--stretch');
      card.querySelector('.nc-ben-li-remover').appendChild(i.remover);
    }
    li.appendChild(card);
    li.classList.add('nc-ben-item', 'nc-ben-li');
    i.card = card;
    i.cv = card.querySelector('.nc-ben-li-valor');
  }
  /* outros = as linhas com que comparar; null = não há com que comparar (o candidato do portal
     não tem "o que você tem hoje": nada de "Novo" em tudo) */
  function decorar(reg, outros, modo) {
    if (!reg) return [];
    var semBase = outros === null;
    outros = outros || [];
    var itens = linhas(reg);
    var mapa = {};
    outros.forEach(function (o) { mapa[o.chave] = o; });
    itens.forEach(function (i, k) {
      if (i.lista) cartaoDaLista(i);
      else if (!i.cb.getAttribute('data-nc-txt')) {
        i.cb.setAttribute('data-nc-txt', i.bene);
        if (i.ct) i.ct.setAttribute('data-nc-txt', i.tipo);
        i.cv.setAttribute('data-nc-txt', i.cv.textContent.trim());
        var tipoTxt = bonito(i.tipo);
        /* nome e tipo na mesma célula, o tipo embaixo; a célula do tipo fica fora da vista */
        i.cb.innerHTML = '<span class="nc-ben-txt"><span class="nc-ben-txt-nome">' + esc(bonito(i.bene)) + '</span>' +
          (tipoTxt && tipoTxt.toLowerCase() !== bonito(i.bene).toLowerCase() ? '<small>' + esc(tipoTxt) + '</small>' : '') + '</span>';
        if (i.ct) i.ct.classList.add('nc-ben-tipo-junto');
        i.cv.textContent = brl(i.valor);
        i.cb.insertBefore(ilustra(categoria(i.bene + ' ' + i.tipo), 'nc-ben-ilu--linha'), i.cb.firstChild);
        i.tr.classList.add('nc-ben-item');
      }
      var velho = i.tr.querySelector('.nc-ben-selo');
      if (velho) velho.remove();
      var ant = i.tr.querySelector('.nc-ben-antes');
      if (ant) ant.remove();
      var par = mapa[i.chave], selo;
      var comparar = !semBase && (modo === 'pacote' || (modo === 'pedido' && outros.length));
      if (modo === 'pedido' && /remov/i.test(i.op)) {
        /* sai do pacote: o valor dele hoje riscado, no lugar do R$ 0,00 */
        selo = ['sai', 'Sai do pacote'];
        if (isFinite(i.anterior)) { i.cv.firstChild && i.cv.firstChild.nodeType === 3 && (i.cv.firstChild.textContent = ''); i.cv.insertBefore(el('s', 'nc-ben-antes', brl(i.anterior)), i.cv.firstChild); }
      } else if (modo === 'pedido' && /inser/i.test(i.op)) selo = ['novo', 'Novo'];
      else if (comparar) {
        if (!par) selo = ['novo', 'Novo'];     /* "-" que não existe hoje: é troca (Silver → Platinum) */
        else if (Math.abs(par.valor - i.valor) < 0.005) selo = ['igual', modo === 'pedido' ? 'Continua' : 'Igual a hoje'];
        else selo = [i.valor > par.valor ? 'mais' : 'menos', (i.valor > par.valor ? '+ ' : '− ') + brl(Math.abs(i.valor - par.valor))];
      } else if (modo === 'hoje' && !par) selo = ['sai', 'Sai do pacote'];
      if (selo) i.cv.appendChild(el('span', 'nc-ben-selo nc-ben-selo--' + selo[0], selo[1]));
      i.tr.classList.toggle('nc-ben-item--sai', !!selo && selo[0] === 'sai');
      if (i.tr.style.getPropertyValue('--nc-cor') !== CORES[k % CORES.length]) i.tr.style.setProperty('--nc-cor', CORES[k % CORES.length]);
    });
    var totalHoje = outros.reduce(function (a, o) { return a + (isFinite(o.valor) ? o.valor : 0); }, 0);
    reg.querySelectorAll('tr.nc-ben-linha-total td').forEach(function (td) {
      var t = td.textContent.trim();
      if (/total do relat/i.test(t)) td.textContent = modo === 'hoje' ? 'Total hoje' : 'Total do novo pacote';
      else if (/^R\$\s?[\d.,]+$/.test(t)) {
        var v = num(t), dif = v - totalHoje;
        td.innerHTML = esc(brl(v)) + (modo === 'pedido' && outros.length && Math.abs(dif) > 0.004
          ? ' <span class="nc-ben-dif nc-ben-dif--' + (dif > 0 ? 'mais' : 'menos') + '">' + (dif > 0 ? '+ ' : '− ') + esc(brl(Math.abs(dif))) + ' em relação a hoje</span>' : '');
      }
    });
    reg.querySelectorAll('a.apagarBeneficio').forEach(function (a) {
      if (a.__ncRot) return;
      var tr = a.closest('tr, li'), n = tr && (tr.querySelector('.nc-ben-txt small') || tr.querySelector('.nc-ben-txt-nome'));
      a.__ncRot = true;
      a.setAttribute('aria-label', 'Remover ' + (n ? n.textContent.trim() : bonito(a.getAttribute('data-id') || 'benefício')) + ' do pacote');
    });
    reg.classList.toggle('nc-ben-vazio', !itens.length);
    return itens;
  }
  /* "Benefícios Requisitados" (o pedido já gravado): pela classe ou, nas páginas que ainda não
     a têm, pelo ID estático / título da região — o JS põe a classe */
  function regiaoRequisitados() {
    var r = regiao('nc-ben-requisitados') || document.getElementById('BENEFICIOS_REQUISITADOS');
    if (!r) r = [].filter.call(document.querySelectorAll('.t-Region'), function (x) {
      var t = x.querySelector(':scope > .t-Region-header .t-Region-title');
      return t && /^benef[ií]cios requisitados/i.test(t.textContent.trim()) && !/\bold\b/i.test(t.textContent);
    })[0];
    if (r && !r.classList.contains('nc-ben-requisitados')) r.classList.add('nc-ben-requisitados');
    return r;
  }
  function montarRelatorios() {
    var pac = regiao('nc-ben-pacote'), hoje = regiao('nc-ben-hoje'), req = regiaoRequisitados();
    var a = linhas(hoje), p = linhas(pac), q = linhas(req);
    decorar(pac, hoje ? a : null, 'pacote');
    decorar(req, hoje ? a : null, 'pedido');
    /* o de hoje compara com o pacote novo; no pedido gravado ("Seu novo pacote" não existe),
       com o que foi pedido — sem os que saem */
    /* na Alteração Funcional (116) o "Novo pacote" existe também no pedido gravado, escondido e
       vazio: com os requisitados à vista, a comparação é com eles (senão tudo "sairia") */
    var novo = itensDoPacote();
    decorar(hoje, (pac || req) ? novo : [], 'hoje');
  }

  /* ═══ [J11] O PEDIDO JÁ GRAVADO ══════════════════════════════════════════════════════════
     O QUE FAZ  Só com a requisição já criada (P168_ROWID preenchido). A região que tem
                P168_COD_REQ vira uma faixa: "Pedido nº …", a situação em cor, "Aberto em …
                por …" e o botão de ver os dados de quem pediu. Não vale na página 116.
     LÊ DOS ITENS  P168_COD_REQ, P168_COD_SIT_REQ, P168_DT_REQ, P168_SOLICITANTE, P168_ROWID.
     PODE MEXER a lista SIT: para cada CÓDIGO de situação, [cor, texto].
                As cores possíveis: 'espera', 'bom', 'ruim', 'neutro' (definidas no CSS).
                Se o APEX mandar o texto da situação, ele vale no lugar do texto da lista.
     VISUAL     Natcorp_Beneficios.css › [C11]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- o pedido já gravado: nº, situação e quem pediu ----------
     A região do título ("Requisição de Benefícios: Nº 55808 - 19/05/2021 (Cancelada)", com
     Requisição / Situação / Data / Solicitante) vira uma faixa. Os campos continuam na região,
     fora da vista; o botão do solicitante (abre os dados dele) vai junto do nome. */
  /* PODE MEXER: código da situação: [cor, 'texto que aparece'] */
  var SIT = { '1': ['espera', 'Em aberto'], '2': ['bom', 'Concluída'], '3': ['neutro', 'Cancelada'], '4': ['ruim', 'Reprovada'], '5': ['bom', 'Aprovada'], '6': ['neutro', 'Suspensa'] };
  function txtItem(n) {
    var e = document.getElementById(P + n);
    if (!e) return '';
    if (e.tagName === 'SELECT') return e.selectedIndex >= 0 && e.value ? e.options[e.selectedIndex].text.trim() : '';
    if (/^(INPUT|TEXTAREA)$/.test(e.tagName)) return (e.value || '').trim();
    return (e.textContent || '').trim();
  }
  function montarPedido() {
    if (!val(P + 'ROWID') || !document.getElementById(P + 'COD_REQ')) return null;
    var reg = document.getElementById(P + 'COD_REQ').closest('.t-Region');
    if (!reg || reg.classList.contains('nc-ben-requisitados')) return null;
    reg.classList.add('nc-ben-pedido');
    var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body');
    var f = document.getElementById('nc-ben-pedido');
    if (!f) {
      f = el('div', 'nc-ben-pedido-faixa', '<div class="nc-ben-pedido-conteudo"></div>'); f.id = 'nc-ben-pedido';
      (corpo || reg).insertBefore(f, (corpo || reg).firstChild);
    }
    var cod = val(P + 'COD_SIT_REQ');
    var sitTxt = txtItem('COD_SIT_REQ');
    var sit = SIT[cod] || ['neutro', ''];
    if (sitTxt && !/^\d+$/.test(sitTxt)) sit = [sit[0] === 'neutro' && /abert/i.test(sitTxt) ? 'espera' : sit[0], bonito(sitTxt)];
    if (!sit[1]) { var m = /\(([^)]+)\)\s*$/.exec((reg.querySelector('.t-Region-title') || {}).textContent || ''); sit[1] = m ? m[1] : 'Situação'; }
    var sol = txtItem('SOLICITANTE').split(/\s+\/\s+/);
    var quem = bonito(semCodigo(sol[1] || sol[0] || '')), cargo = sol[2] ? bonito(semCodigo(sol[2])) : '';
    var data = txtItem('DT_REQ');
    var h = '<div class="nc-ben-pedido-topo"><p class="nc-ben-pedido-n">Pedido nº <b>' + esc(val(P + 'COD_REQ')) + '</b></p>' +
      '<span class="nc-ben-sit nc-ben-sit--' + sit[0] + '">' + esc(sit[1]) + '</span></div>' +
      '<p class="nc-ben-pedido-quem">' + (data ? 'Aberto em <b>' + esc(data.replace(/\s.*$/, '')) + '</b>' : 'Aberto') +
        (quem ? ' por <b>' + esc(quem) + '</b>' + (cargo ? ' <span class="nc-ben-sutil">· ' + esc(cargo) + '</span>' : '') : '') + '</p>';
    var cx = f.querySelector('.nc-ben-pedido-conteudo');   /* o botão do solicitante mora fora dele */
    if (cx.__h !== h) { cx.__h = h; cx.innerHTML = h; }
    var btn = document.getElementById('p168_btn_solicitante') || [].filter.call(reg.querySelectorAll('button.t-Button, a.t-Button'), function (b) { return !f.contains(b); })[0] || f.querySelector('.nc-ben-pedido-ver');
    if (btn && btn.parentNode !== f) { btn.classList.add('nc-ben-pedido-ver'); btn.setAttribute('title', 'Ver os dados de quem pediu'); f.appendChild(btn); }
    return reg;
  }

  /* ═══ [J12] O CAMINHO DA APROVAÇÃO ═══════════════════════════════════════════════════════
     O QUE FAZ  Transforma o relatório "Aprovadores" numa faixa logo abaixo do pedido: o resumo
                ("1 de 2 · aguardando Fulano", "é a sua vez"), cada aprovador com um sinal
                (aprovou, reprovou, aguardando, na fila) e o que cada um escreveu.
                Os botões Aprovar/Reprovar do APEX vão para dentro da faixa — os mesmos botões,
                com os mesmos cliques. No celular, a lista abre por "Ver o caminho".
     LÊ DAS COLUNAS  APROVADOR, DATA, STATUS, JUSTIFICATIVA (pelo nome da coluna).
     CUIDADO    Se uma dessas colunas for renomeada no relatório, a faixa não acha os dados.
                Os botões são achados pelo TEXTO: precisam se chamar "Aprovar" e "Reprovar".
     PODE MEXER os textos entre aspas: 'Aprovação', 'Ver o caminho', 'é a sua vez',
                'Confira o pedido e decida.', 'Na fila'…
     VISUAL     Natcorp_Beneficios.css › [C12]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  /* ---------- o caminho da aprovação (o mesmo desenho da Requisição, do Desligamento, do
     Treinamento e do Atestado) ----------
     O relatório "Aprovadores" vira uma faixa logo abaixo do pedido: o resumo ("1 de 2 ·
     aguardando Fulano"), os aprovadores em linha ligados por um fio e o que cada um escreveu.
     Os botões Aprovar/Reprovar do APEX (só para quem aprova) vão para dentro dela — os mesmos
     botões, com os mesmos cliques e ações. A tabela continua na região, fora da vista. */
  var AP = null, AP_ABERTO = false, AP_ASSIN = '';
  function limpo(t) { t = String(t || '').replace(/\s+/g, ' ').trim(); return /^[-–—]?$/.test(t) ? '' : t; }
  function nomeAprovador(t) {
    var m = /^\s*\d+\s*-\s*\d+\s*-\s*(.+)$/.exec(t || '');
    return bonito(m ? m[1] : t).replace(/(^|\s)(\S)/g, function (x, a, b) { return a + b.toUpperCase(); }).replace(/\s(De|Da|Do|Das|Dos|E)(?=\s)/g, function (x) { return x.toLowerCase(); });
  }
  function montarAprovacao(pedido) {
    if (!AP) {
      var th = document.querySelector('table.t-Report-report th#APROVADOR, td[headers="APROVADOR"]');
      var reg = th && th.closest('.t-Region');
      if (!reg) return;
      /* 04/10: TODOS os Aprovar/Reprovar que o servidor desenhou, mesmo os que uma ação dinâmica
         escondeu na abertura: se outra ação os mostrar depois (a situação volta a 1), eles têm de
         aparecer — a região de onde vêm fica fora da vista. Quem decide a vista é o style da página */
      AP = { reg: reg, botoes: [].slice.call(document.querySelectorAll('button.t-Button, a.t-Button')).filter(function (b) {
        return /^(aprovar|reprovar)$/i.test(b.textContent.trim());
      }) };
      reg.classList.add('nc-ben-aprov');
      /* sobe para logo abaixo do pedido, na largura toda; a coluna de onde saiu some */
      var ancora = pedido && (pedido.closest('.row') || pedido);
      if (ancora && ancora.parentNode) {
        var col = reg.parentElement && reg.parentElement.classList.contains('col') ? reg.parentElement : null;
        ancora.parentNode.insertBefore(reg, ancora.nextSibling);
        if (col && !col.querySelector('.t-Region')) {
          col.classList.add('nc-ben-col-vazia');
          var vizinha = pedido.parentElement && pedido.parentElement.classList.contains('col') ? pedido.parentElement : null;
          if (vizinha) vizinha.classList.add('nc-ben-col-cheia');
        }
      }
      var corpo = reg.querySelector(':scope > .t-Region-bodyWrap > .t-Region-body') || reg;
      AP.box = el('div', 'nc-ben-caminho');
      corpo.insertBefore(AP.box, corpo.firstChild);
      AP.box.addEventListener('click', function (e) { if (e.target.closest('.nc-ben-caminho-ver')) { AP_ABERTO = !AP_ABERTO; AP_ASSIN = ''; agendar(); } });
    }
    var passos = [].slice.call(AP.reg.querySelectorAll('table.t-Report-report tbody tr')).filter(function (tr) { return tr.querySelector('td[headers="APROVADOR"]'); }).map(function (tr) {
      function c(h) { var td = tr.querySelector('td[headers="' + h + '"]'); return td ? limpo(td.textContent) : ''; }
      var st = c('STATUS');
      return { nome: nomeAprovador(c('APROVADOR')), data: c('DATA'), just: c('JUSTIFICATIVA'), status: st,
        estado: /^r$|reprov|recus/i.test(st) ? 'nao' : /^a$|aprov/i.test(st) ? 'ok' : 'pend' };
    }).filter(function (x) { return x.nome || x.status; });
    var n = passos.length;
    AP.reg.classList.toggle('nc-ben-aprov--vazio', !n);
    var reprovado = passos.some(function (x) { return x.estado === 'nao'; });
    var atual = -1;
    if (!reprovado) for (var i = 0; i < n; i++) if (passos[i].estado === 'pend') { atual = i; break; }
    var aprovados = passos.filter(function (x) { return x.estado === 'ok'; }).length;
    var sit = val(P + 'COD_SIT_REQ') || '';
    var cancelado = sit === '3' || sit === '6' || /cancel|suspens/i.test(txtItem('COD_SIT_REQ'));
    var bts = AP.botoes.filter(function (b) { return b.style.display !== 'none'; });
    var vez = bts.length > 0 && !cancelado && atual >= 0;   /* só há o que decidir com uma etapa pendente */
    var assin = JSON.stringify([passos, atual, bts.length, cancelado, AP_ABERTO]);
    if (assin === AP_ASSIN) return;
    AP_ASSIN = assin;
    if (!n) { AP.box.innerHTML = ''; return; }
    var quemNao = passos.filter(function (x) { return x.estado === 'nao'; })[0];
    var estado = reprovado ? 'nao' : cancelado ? 'neutro' : atual < 0 ? 'ok' : vez ? 'vez' : 'pend';
    var resumo = reprovado ? '<b>Reprovado</b> por ' + esc(quemNao.nome)
      : cancelado ? '<b>Pedido ' + (sit === '6' ? 'suspenso' : 'cancelado') + '</b> · ' + aprovados + ' de ' + n + ' aprovaram'
      : atual < 0 ? '<b>Aprovado</b> por ' + (n === 1 ? esc(passos[0].nome) : 'todos')
      : vez ? '<b>' + aprovados + ' de ' + n + '</b> · <b>é a sua vez</b>'
      : '<b>' + aprovados + ' de ' + n + '</b> · aguardando <b>' + esc(passos[atual].nome) + '</b>';
    var justs = passos.filter(function (x) { return x.just; });
    AP.reg.classList.toggle('nc-ben-ap-aberto', AP_ABERTO);
    AP.box.className = 'nc-ben-caminho nc-ben-caminho--' + estado;
    AP.box.innerHTML =
      '<p class="nc-ben-caminho-rot">Aprovação</p><div class="nc-ben-caminho-cab"><p class="nc-ben-caminho-resumo">' + resumo + '</p>' +
        '<button type="button" class="nc-ben-caminho-ver" aria-expanded="' + AP_ABERTO + '">' + (AP_ABERTO ? 'Esconder o caminho' : 'Ver o caminho') + '</button></div>' +
      '<ol class="nc-ben-passos-ap">' + passos.map(function (x, i) {
        var cls = x.estado === 'ok' ? 'is-ok' : x.estado === 'nao' ? 'is-nao' : i === atual && !cancelado ? 'is-vez' : 'is-fila';
        var dia = x.data.replace(/\s.*$/, '');
        var st = x.estado === 'ok' ? (dia || 'Aprovou') : x.estado === 'nao' ? 'Reprovou' + (dia ? ' · ' + dia : '') : cls === 'is-vez' ? (vez ? 'Sua vez' : 'Aguardando') : 'Na fila';
        var ic = x.estado === 'ok' ? '<path d="M6.5 12.5l3.5 3.5 7.5-8"/>' : x.estado === 'nao' ? '<path d="M8 8l8 8M16 8l-8 8"/>' : cls === 'is-vez' ? '<path d="M12 8v4l2.5 1.5"/>' : '';
        var dica = x.nome + ' — ' + (x.estado === 'ok' ? 'aprovou' + (x.data ? ' em ' + x.data : '') : x.estado === 'nao' ? 'reprovou' + (x.data ? ' em ' + x.data : '') : cls === 'is-vez' ? 'aguardando a aprovação' : 'na fila') + (x.just ? ': "' + x.just + '"' : '');
        return '<li class="nc-ben-ap ' + cls + '" title="' + esc(dica) + '"><span class="nc-ben-ap-marca" aria-hidden="true"><svg viewBox="0 0 24 24">' + ic + '</svg></span>' +
          '<span class="nc-ben-ap-texto"><span class="nc-ben-ap-nome">' + esc(x.nome || 'Aprovador') + '</span><span class="nc-ben-ap-estado">' + esc(st) + '</span></span></li>';
      }).join('') + '</ol>' +
      /* 04/10: os botões que a PÁGINA mostra vão sempre para cá (antes, só com "é a sua vez" pela
         leitura da tabela — fora disso ficavam na região escondida e sumiam) */
      (bts.length ? '<div class="nc-ben-decisao"><p class="nc-ben-decisao-txt">Confira o pedido e decida.</p><div class="nc-ben-decisao-botoes" aria-label="Sua decisão"></div></div>' : '') +
      (justs.length ? '<div class="nc-ben-ap-justs">' + justs.map(function (x) {
        return '<blockquote class="nc-ben-ap-just' + (x.estado === 'nao' ? ' is-nao' : '') + '"><b>' + esc(x.nome) + (x.estado === 'nao' ? ' reprovou' : x.estado === 'ok' ? ' aprovou' : '') + ':</b> ' + esc(x.just) + '</blockquote>';
      }).join('') + '</div>' : '');
    var dest = AP.box.querySelector('.nc-ben-decisao-botoes');
    if (dest) bts.slice().sort(function (a) { return /reprovar/i.test(a.textContent) ? -1 : 1; }).forEach(function (b) {
      b.classList.add(/reprovar/i.test(b.textContent) ? 'nc-ben-reprovar' : 'nc-ben-aprovar');
      dest.appendChild(b);
    });
  }

  /* ═══ [J13] O RESUMO NA BARRA DOS BOTÕES ═════════════════════════════════════════════════
     O QUE FAZ  Na região nc-ben-acoes (presa ao pé da tela), ao lado dos botões:
                "3 benefícios no pacote · R$ … de R$ … · R$ … livres", ou
                "Seu pacote ainda está vazio".
     PODE MEXER os textos entre aspas.
     VISUAL     Natcorp_Beneficios.css › [C7]
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function montarResumo(itens, total, saldo) {
    var reg = regiao('nc-ben-acoes');
    if (!reg) return;
    var r = document.getElementById('nc-ben-resumo');
    if (!r) {
      r = el('p', 'nc-ben-resumo'); r.id = 'nc-ben-resumo';
      var meio = reg.querySelector('.t-ButtonRegion-col--content') || reg.querySelector('.t-ButtonRegion-wrap') || reg;
      meio.insertBefore(r, meio.firstChild);
    }
    var n = itens.length;
    r.hidden = !val(P + NOME.matricula);
    r.innerHTML = n
      ? '<b>' + n + (n === 1 ? ' benefício' : ' benefícios') + '</b> no pacote · ' + brl(total - (isFinite(saldo) ? saldo : 0)) + ' de ' + brl(total) + (saldo > 0.004 ? ' · <span class="nc-ben-sutil">' + brl(saldo) + ' livres</span>' : '')
      : 'Seu pacote ainda está vazio';
  }

  /* ═══ [J14] O MAESTRO: QUANDO CADA PARTE É MONTADA ══════════════════════════════════════
     O QUE FAZ  tudo() chama as partes acima, nesta ordem. iniciar() roda uma vez quando a
                página abre e depois manda montar tudo de novo sempre que algo muda: um item
                muda de valor, um relatório é recarregado, uma ação dinâmica traz valores do
                servidor, uma janela (o "Remover") fecha.
     CUIDADO    Não mude a ordem das chamadas em tudo(): o saldo precisa dos cartões já lidos.
                As remontagens esperam um "respiro" de 100 ms: as ações dinâmicas disparam
                dezenas de chamadas seguidas, e redesenhar a cada uma travava o navegador.
     SE DER ERRO  O erro não derruba a página: aparece no Console (F12 › Console) como
                [Natcorp benefícios] seguido da mensagem. Veja o manual, parte 5.
     ════════════════════════════════════════════════════════════════════════════════════════ */
  function tudo() {
    montarPerfil();
    /* o pedido e a aprovação: só na Requisição de Benefícios (a 116 tem a tela dela) */
    if (pag !== '116') montarAprovacao(montarPedido());
    montarRelatorios();
    montarSegmento();
    montarChips();
    montarCartoes();
    montarValor();
    montarSaldo();
  }
  /* uma passada por "respiro": as ações dinâmicas disparam dezenas de chamadas seguidas e
     redesenhar a cada uma ocupava o navegador junto com elas (o mesmo da Alteração Funcional) */
  var T_AGENDA = null;
  function agendar() {
    clearTimeout(T_AGENDA);
    T_AGENDA = setTimeout(function () { try { tudo(); } catch (e) { if (window.console) console.warn('[Natcorp benefícios]', e); } }, 100);
  }
  function iniciar() {
    document.body.classList.add('nc-ben');
    guardarAdicionar();
    tudo();
    /* o que o APEX muda chega por aqui: valores postos pelas ações dinâmicas (change),
       listas em cascata e relatórios recarregados (apexafterrefresh), diálogo de remover */
    $(document).on('change', '[id^="' + P + '"]', agendar);
    $(document).on('apexafterrefresh', agendar);
    /* valores trazidos do servidor por ação dinâmica (Executar PL/SQL, "itens a retornar")
       chegam SEM o evento change: sem isto a tela ficava com a leitura de antes da resposta */
    $(document).ajaxStop(agendar);
    $(document).ajaxStop(moedaSyncTudo);
    $(document).on('apexafterclosedialog dialogclose', function () { setTimeout(agendar, 60); });
    /* 04/10: de novo depois das ações dinâmicas de abertura (esconder/mostrar/desabilitar com
       "Executar na inicialização"): a primeira passada pode ter lido o estado de antes delas */
    $(window).on('apexreadyend', agendar);
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { $(iniciar); });
  else $(iniciar);
})();
