# Ver a senha — páginas 900 (login) e 901 (Alterar Minha Senha) do app 200

Um olho dentro de cada campo de senha. Um toque mostra o que foi digitado (o olho fica riscado), outro esconde.

| Peça | Onde |
|---|---|
| Comportamento | `Natcorp_Senha.src.js` → `python3 gerar-senha.py` → `../login/Natcorp_Senha.js` |
| Aparência | `../login/Natcorp_Login.src.css`, bloco "Ver a senha" → `node ../login/gerar-login.mjs` → `Natcorp_Style_Min.css` |
| Ligar na página | `python3 aplicar-senha-paginas.py f200_page_900.sql` (e 901): só põe JavaScript › File URLs `#WORKSPACE_IMAGES#Natcorp_Senha.js` |

## Como subir (nesta ordem)
1. Workspace Images: `Natcorp_Senha.js` e o `Natcorp_Style_Min.css`.
2. Depois, importar `f200_page_900.sql` e `f200_page_901.sql`.
A ordem importa: com a página importada antes, o primeiro acesso pede um arquivo que ainda não existe, e o CDN guarda esse 404 por 24 h.

## O que foi cuidado
- **O cursor e o foco ficam no campo** ao tocar no olho (`mousedown` sem efeito). No celular, o teclado não fecha.
- **Teclado do celular**: aberto, o campo vira texto. Por isso ganha `autocapitalize/autocorrect/spellcheck` desligados, senão o celular põe maiúscula e "corrige" a senha.
- **A ação `key-next-item` da 900** (ao sair da senha, o foco vai para o Entrar) continua igual. A única exceção é quando o foco vai da senha para o próprio olho: senão o Tab nunca chegaria nele. O jQuery do APEX simula o `focusout` a partir de um `blur` capturado no `document`, por isso o filtro fica na `window`, em captura, e pega os dois eventos.
- **Antes de enviar** (`apexbeforepagesubmit` e `submit`), todo campo volta a ser de senha.
- **Na 901, o "?" da Nova Senha** (as regras da senha) ganhava 200 px de outra folha e espremia o campo. Isso já acontecia antes do olho. Agora o "?" é um botão de 40 px, e o olho é medido pela borda do campo (variável `--nc-senha-dir`).
- O olho próprio do Edge (`::-ms-reveal`) sai, para não ficarem dois.

## Conferido em 19/10
Teste no servidor dev, em um Chrome isolado com os arquivos locais, nas páginas 900 e 901, a 1440 e 390 px:
- o olho fica a 4 px da borda nos 4 campos;
- digitar, mostrar e seguir digitando mantém o cursor no lugar;
- o Tab segue senha → olho → Entrar, e o Espaço alterna;
- a ação original da 900 continua levando o foco ao Entrar;
- nenhum erro de JS.

**Não testado:** o envio de verdade (login e troca de senha), por causa da regra de não gravar.
