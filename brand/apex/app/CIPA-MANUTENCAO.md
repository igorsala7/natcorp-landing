# Eleição da CIPA — app 2942, páginas 34 (lista) e 35 (Confirmar Votação)

Onde o colaborador vota em quem vai compor a CIPA. Público: colaboradores, muitos com pouca
instrução, 70% no celular (pedido de 04/10). Abre dentro do Painel do Colaborador (322, "CIPA -
Eleição", moldura com `P_PAINEL = PC`, que esconde o cabeçalho e os Filtros).

Arquivos: `Natcorp_Cipa.src.js` / `.src.css` → `../login/Natcorp_Cipa.js` / `.css` — o MESMO par nas
duas páginas (o JS reconhece cada uma pelos itens). JS: `python3 gerar-cipa.py`. CSS: `gerar-app.mjs`
(lista AVULSAS). Exportações: `python3 aplicar-cipa-paginas.py f2942_page_34.sql` e `… f2942_page_35.sql`
(aplicadas em 04/10; originais em `*.ORIGINAL.sql`). Só as File URLs e o comentário da página.

## Como ficou

| Onde | O quê |
|---|---|
| 34 · o alto | Na região Hero "CIPA": "Eleição da CIPA", uma frase do que é a CIPA, **como votar em 3 passos** (Escolha · Confira · Confirme) e "Você vota uma vez só". "Toque" no celular, "Clique" no computador |
| 34 · inscrição | Só quando o botão **Inscrever-se** original está na página (a condição dele: período de inscrição, tipo INSCRICAO, ainda não inscrito): cartão "Quer ser candidato? As inscrições estão abertas." com o botão original dentro |
| 34 · candidatos | Cada linha da lista vira um cartão-botão: iniciais num círculo (cor fixa por nome), nome sem caixa alta, "Conhecido como…", cargo, setor (centro de custo) e unidade (filial); a empresa só quando há mais de uma na lista; "Votar". Mais de 6: busca pelo nome. Vazio: "Nenhum candidato por enquanto" |
| 34 · depois de votar | Quando a janela fecha com "Voto Confirmado com Sucesso!": faixa verde "Pronto! Seu voto foi registrado." e o selo "Seu voto" no cartão escolhido (guardado na sessão do navegador, por CIPA) |
| 35 · pode votar | O cartão de quem recebe o voto (o mesmo da lista), "Você quer votar nesta pessoa?", "Depois de confirmar, não dá para trocar o voto", e os botões originais: **Confirmar meu voto** (verde) e **Voltar e escolher outra pessoa** |
| 35 · já votou | "Você já votou — Seu voto nesta eleição já foi registrado." + Voltar |
| 35 · fora do período | "A votação não está aberta agora — Você pode votar de X até Y." (as datas que a página calcula) + Voltar |

## Regras da página (conferidas)

- **34:** a consulta (elegível em `vw_elegiveis_cipa`, desistentes fora, filial do colaborador no
  painel), a paginação de 15, o link de cada linha para a 35 com os 5 itens, o botão Inscrever-se
  com a condição dele e a ação "Dialog Closed" (reenvia a página), a ação que esconde os Filtros com
  `P_PAINEL = PC`, o processo "Colaborador" (preenche CIPA e filial). O toque no cartão é o **clique
  no link original**; o botão Inscrever-se é o **original**, só mudado de lugar.
- **35:** o processo "Inicio" calcula o texto (`P35_TEXTO`); o desenho só lê esse texto. O botão
  Confirmar aparece só quando a página deixa (período de votação = 15 dias até a apuração, candidato
  existe, ainda não votou). Gravar = o processo CONFIRMAR VOTO + Close Dialog, pelo botão original.
- **Única trava nova:** o 2º toque no Confirmar é ignorado enquanto a página envia. O processo faz
  `insert` sem conferir voto anterior: dois toques rápidos gravariam dois votos.
- O nome social, quando existe, é o nome mostrado no cartão (o original mostrava "NOME (NOME SOCIAL: …)").

## Cuidados

- A lista é lida da Media List: título "NOME (APELIDO: x) (NOME SOCIAL: y)", descrição com os rótulos
  "Empresa", "Filial", "Centro de Custo", "Cargo" seguidos de `<b>`. Mudou a consulta → conferir.
- Se algum item da lista vier sem link, a lista original volta (o desenho não troca o que não leu).
- A 35 mostra cargo/setor porque a 34 guarda os dados de quem foi tocado no `sessionStorage`
  (`nc-cipa-cand:<empresa>-<matrícula>`). Aberta de outro jeito, mostra só o nome (vindo do texto).
- **Testar:** a página só é segura de abrir PELA CASCA (322:799). Aberta solta em outra aba, cai no
  login e derruba a sessão do usuário (aconteceu em 04/10).
- **Não testado com dados reais:** em 04/10 a eleição não tinha candidatos. Conferir com uma eleição
  de teste: os cartões, a janela 35 nos três estados, e o voto (de um usuário de teste).
