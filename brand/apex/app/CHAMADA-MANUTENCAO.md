# Chamada de pacientes — app 2936, página 1 (manutenção)

O painel da TV da sala de espera da Medicina Ocupacional (04/10/2026). Pedido: "muito feio e imagem de
coisa antiga, além da animação; o som também está muito antigo".

Arquivos: `Natcorp_Chamada.src.js` → `../login/Natcorp_Chamada.js` (`python3 gerar-chamada.py`);
`Natcorp_Chamada.src.css` → `../login/…css` (`node gerar-app.mjs`, lista AVULSAS; o logo branco entra pelo
marcador `@@LOGO_BRANCO@@`). Exportação: `python3 aplicar-chamada-pagina1.py f2936_page_1.sql` (aplicada
em 04/10; original em `f2936_page_1.ORIGINAL.sql`).

**Para subir:** importar `f2936_page_1.sql` e pôr `Natcorp_Chamada.js` e `.css` no Workspace Images.
Na TV: abrir a página, **clicar uma vez** (o navegador só libera som depois de um clique) e deixar em tela
cheia (F11 ou Ajustes › Tela cheia). Ao vivo a página não recarrega: o som fica ligado o dia todo.

## Como era

Duas regiões PL/SQL (Cadastro = status C, guichê; Atendimento médico = status M, local) com a senha dos
últimos 5 min e as 4 últimas da hora; `apex.submit()` a cada 10 s e recarregar a cada 5 min; ao carregar,
as ações "get_lock_time" marcavam a chamada nova (flag 1 → 0) e tocavam dois bipes de onda pura; a senha
"chamando" pulsava (escala 0,9↔1) em verde.

## Como ficou

| Parte | O quê |
|---|---|
| Painel | **Claro por padrão** (pedido 04/10): fundo lavanda claro, painéis brancos, logo roxo (o logo branco vira máscara pintada com `--ch-logo`); o escuro é opção nos Ajustes (`.is-escuro`, só troca as variáveis). Logo, título e relógio; as duas filas lado a lado: "Chamando agora" (senha em tamanho de placa, números de largura fixa, → Guichê/Local) ou "Aguarde a sua senha"; "Anteriores" (até 4, com a hora). Tudo medido em `--ch-u` (1% da altura 16:9): o mesmo desenho de 1366×768 a 4K. |
| Chamada | Tela cheia: a cor da marca abre do centro, a senha sobe e entra em foco; **sino** de três notas (mi–sol#–si, sintetizado, com eco curto — sem arquivo de áudio) e a **voz** do computador: "Senha 0 4 0 0 0 1. Local 3." (dígito a dígito, duas vezes). Uma chamada por vez, na ORDEM em que foram chamadas, juntando as duas filas (o processo devolve `seg` também nas novas). Depois, a senha fica com a borda rosa respirando por 30 s. |
| Som | Faixa "Clique em qualquer lugar da tela para ligar o som" (regra dos navegadores) enquanto o som não estiver liberado; ícone de som no pé. Voz: prefere as naturais (Google, Microsoft Maria/Francisca/Thalita, Luciana); as de brincadeira (Eddy, Grandma…) nunca. |
| Ajustes | Ao mexer o mouse (o cursor some parado): Som, Falar a senha, Tema escuro, Volume, Testar chamada (000000 / Guichê 1), Tela cheia. Guardados no navegador da TV. |
| Rede | 3 falhas seguidas: "Sem conexão, tentando de novo…"; ~2 min sem resposta: recarrega. |

## Como lê

- **Ao vivo (com a exportação):** `NC_CHAMADA_ESTADO` a cada 4 s. Para cada fila: `novas` (flag 1 —
  devolve e marca flag 0, como a ação antiga) e `ultimas` (a última hora, com `seg` desde a chamada; a 1ª
  com `seg` ≤ 300 é a "chamando agora"). Mesma regra das regiões (registro mais recente por senha/seq/data).
- **Reserva (arquivos sem a exportação):** a página antiga continua recarregando a cada 10 s; o painel lê
  as regiões (CADASTRO, MEDICO e as duas HISTORICO, na ordem) e anuncia a senha dos itens P1_SENHA_*
  (voz uma vez, 7 s, para caber antes do recarregar).

## Cuidados

- `window.__ncChamada` (posta pelo JS no `<head>`) é a chave: a exportação condiciona a ela o "Execute when
  Page Loads" (recarregar) e as duas ações do bipe/marcar. Sem o JS, tudo volta como era.
- O "Play" antigo vira mudo (propriedade sem efeito no `window`): o som é só o do painel.
- **Marcar como anunciada é por TV:** a primeira TV/aba que ler a chamada nova a anuncia e marca; outra
  aberta ao mesmo tempo não a anuncia (era assim também). Ao testar, NÃO deixar a página aberta em outro
  lugar enquanto a TV estiver em uso.
- CSS: o gerador põe `!important` em tudo, e `!important` vence animação — o ponto de partida das
  animações mora só no `@keyframes` (com `both`). O zerar das margens dos textos é `:where(...)` (peso
  zero), senão as pílulas (`<p>`) perdem o recuo.
- Nome do paciente: a página nunca mostrou (só senha) e o painel também não.

## Não visto funcionando

O processo no Oracle (a prévia leu a própria página, sem marcar nada: as gravações vindas dela foram
bloqueadas no navegador de teste; as chamadas da tela cheia foram simuladas). Depois de importar: chamar
uma senha de teste no guichê e conferir na TV (som, voz e a marca no painel).

## Simulações (04/10)

Na prévia, um "dia simulado" (só visual, nada no banco): as duas filas com a chamada de agora e 4 anteriores com
horário; chamada nova no Cadastro (tela cheia → painel com a borda rosa); duas seguidas, uma de cada fila (anunciadas
na ordem em que foram chamadas, as duas ficam destacadas); TV de 1366×768 (mesmo desenho, sem rolagem).

## Regras da página (auditoria 04/10)

Conferido contra `f2936_page_1.ORIGINAL.sql`: 2 ações dinâmicas ("get_lock_time" do Cadastro e do
Médico: marcar flag 0 + bipe, na abertura e no change), 1 processo (Senha, antes do corpo), o código
de recarregar da página. A exportação condiciona as duas ações e o recarregar a `!window.__ncChamada`
(posta pelo JS no `<head>`, antes da inicialização das ações) e cria `NC_CHAMADA_ESTADO`, que marca
flag 0 com o mesmo `update` da ação antiga. Sem mudanças no JS/CSS.

**Divergências / riscos — para decidir, nada alterado:**
- A página antiga anunciava UMA senha nova por carga (a mais recente com flag 1) e só marcava essa;
  `NC_CHAMADA_ESTADO` devolve e marca TODAS as pendentes de cada fila (anunciadas da mais antiga à
  mais nova).
- Com a exportação importada, se a PRIMEIRA leitura do `NC_CHAMADA_ESTADO` falhar (rede, erro no
  banco), o JS cai na "reserva" — que conta com o recarregar da página, desligado pela própria
  exportação: o painel fica parado até alguém recarregar. Pede uma regra de nova tentativa na reserva.
