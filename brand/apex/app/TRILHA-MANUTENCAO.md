# Trilha — o caminho que a pessoa fez (sistema todo)

Logo abaixo do menu superior: **‹ Voltar** à esquerda e o caminho — as 3 últimas páginas
visitadas e a atual (em negrito), com o **nome da página** (o título que o APEX dá a ela). É o
histórico desta aba, não a estrutura do menu.

Arquivos: `Natcorp_Trilha.src.js` → `../login/Natcorp_Trilha.js` (`python3 gerar-trilha.py`);
`Natcorp_Trilha.src.css` entra no `Natcorp_Style_Min.css` (`gerar-app.mjs`, lista **FOLHAS**).
Quem carrega: o `Natcorp_Temas.js` ([J0], lista `PECAS`) — que já está em todas as páginas da
casca (app 200). **Nenhuma página precisa de URL de arquivo.**

Para subir: `Natcorp_Trilha.js` (novo), `Natcorp_Temas.js` e `Natcorp_Style_Min.css`.

## Como funciona

| Situação | O que acontece |
|---|---|
| Casca (200:762) | a faixa fica logo acima do iframe; cada página que carrega no iframe entra no caminho; o iframe encolhe a altura da faixa (CSS `[C4]`) |
| Página direta do app 200 | a faixa entra dentro da barra de título fixa do APEX (no começo dela); o APEX recalcula o recuo do conteúdo |
| Voltar | vai para a página anterior do caminho (a anterior fica em "Voltar para …" ao parar o mouse) |
| Tocar num item | vai direto para ele |
| Voltar a uma página do caminho | o caminho é CORTADO ali (Home › A › Home vira só Home) |
| Mais de 3 anteriores | aparece "…" no começo (o caminho guarda 15) |
| Celular | "Voltar" vira só a seta; ficam a anterior e a atual |
| De página direta para página da casca | abre a casca e ela carrega a página pedida no iframe (`nc-trilha-abrir`) |

Título genérico: a página cujo título é "Menu - Módulo" (sem maiúsculas/acentos) leva o **nome da aba** do
navegador (o título da casca, ex.: "Medicina Ocupacional"). Lista `GENERICOS` em `[T1]`.

Fica de fora: janelas (diálogos), tela de login, páginas de fora do sistema.

## Cuidados

- **Sessão:** o caminho fica na aba (sessionStorage `nc-trilha`) e zera quando a sessão muda.
  Todo endereço é aberto com o número da sessão ATUAL (abrir com sessão antiga derruba a da
  pessoa).
- Qual página é: `pFlowId:pFlowStepId` (campos ocultos do APEX), não o endereço.
- Ajustes: `[T1]` do JS (`MOSTRA` = anteriores visíveis, `GUARDA`), `--nc-tr-alt` no CSS (altura).
- **Rodapé da casca (04/10):** a 200:766 "esconde" o próprio rodapé com `height:0`, mas o conteúdo
  vazava e o corpo (overflow:hidden) rolava ~90px: o rodapé ("Termos De Uso", "Release 67")
  ficava fixo embaixo do iframe, por cima da página, e a faixa sumia atrás do menu. `[C4]`
  fecha o rodapé com `overflow:hidden` (não `display:none`: o `#BTN_NATI` fixo mora nele). O
  rodapé que aparece é o da página de dentro do iframe, no fim dela.

## Regras da página (auditoria 04/10)

Conferido: a faixa só navega por `location.href` (na casca, o do iframe), então o aviso de
"alterações não salvas" da página (beforeunload) continua valendo; não entra em diálogos nem no login;
não envia formulário nem grava. Nada mudou.
