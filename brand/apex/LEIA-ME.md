# Modernização da UI das aplicações Oracle APEX 19.2

Máscara global de CSS que aproxima as aplicações Natcorp em APEX 19.2 (Universal Theme 42, estilo
"Vita (NATCORP)") do layout de referência `brand/app-referencia/natcorp-app.html`, com o mínimo de alterações:
**nenhum template, página, item ou JavaScript precisa mudar**. É um único arquivo de CSS carregado por cima do
`Natcorp_Style_Min.css` atual, que continua no ar.

| Arquivo | O que é |
| --- | --- |
| `Natcorp_Style_Modern.css` | A máscara, legível e comentada (17 seções). É a fonte da verdade. |
| `Natcorp_Style_Modern.min.css` | A mesma máscara minificada, para produção. |
| `Natcorp_Fonts.css` + `fonts/` | Manrope self-hosted, para ambientes sem acesso ao Google Fonts. |
| `antes-depois/` | Capturas das telas atuais e com a máscara aplicada (renderizadas a partir das páginas salvas). |

## O que muda na tela

- **Tipografia**: Manrope em toda a aplicação (era Helvetica/Segoe/Arial). Só existe uma declaração de fonte no tema
  inteiro, então uma regra propaga para tudo.
- **Cabeçalho**: barra branca com borda em Névoa, o símbolo da Natcorp antes do nome da aplicação, botões em pílula.
  Sai a barra escura com o filete rosa.
- **Menu lateral**: gradiente da marca (Azul Profundo → Roxo → Ameixa), item ativo em pílula translúcida, ícones em
  rosa-claro, subitens em um bloco mais escuro. A largura (240 px) e o comportamento de recolher não mudam.
- **Regiões**: cartões brancos com cantos de 16 px, borda em Névoa e sombra suave. Sai a barra roxa à esquerda de
  toda região; o ícone do título ganha um quadrado roxo-claro.
- **Botões**: pílulas. Ação principal ("hot") em gradiente roxo; secundárias brancas com borda; "simple" em contorno;
  link em roxo. Os botões do Interactive Report (`a-Button`) entram no mesmo sistema, acabando com os dois estilos de
  botão na mesma tela.
- **Formulários**: rótulos pequenos e fortes em Grafite, campos de 40 px com cantos de 10 px, foco com anel roxo,
  LOV pop-up e campo de data como uma peça só, opções marcadas em roxo (era rosa). Rótulos flutuantes (app NatDocs)
  mantêm a medida original.
- **Interactive Report, relatório clássico e Interactive Grid**: barra de busca em pílula, cabeçalhos em caixa alta
  pequenos e alinhados à esquerda, sem grade vertical, linhas separadas por um fio, destaque ao passar o mouse,
  paginação em pílula. Cabeçalhos não quebram linha (a tabela rola dentro do relatório quando há muitas colunas).
- **Abas (Region Display Selector)**: seletor em pílula com a aba ativa branca.
- **Modais**: cantos de 20 px, barra de título branca, botão de fechar redondo e **escurecimento do fundo** (hoje o
  fundo fica claro e as modais se sobrepõem sem contraste).
- **Alertas**: fundos suaves por tipo (sucesso, aviso, erro, informação) em vez dos blocos saturados.
- **Cartões (t-Cards), listas de selo (Badge List) e listas de mídia**: cantos, sombra, ícone em gradiente da marca
  (sai o gradiente triplo com `blend-mode`), valores em Roxo.
- **Assistente (Wizard)**: marcadores numerados; concluído com um check verde; ativo em roxo.
- **Login**: fundo com o gradiente da marca, cartão branco de 24 px, campos de 46 px, "Entrar" em gradiente,
  "Entrar SSO" em contorno.
- **Menus suspensos, SweetAlert2, Select2, calendário, toastr**: no mesmo sistema (cantos, sombra, roxo).
- **Botões flutuantes (NATI, chamados)**: sombra consistente; o `box-shadow` inválido de `.btnIAlive` ganha o halo
  rosa que ele pretendia.
- **Organograma (Google Charts)**: nós brancos com borda e sombra, no lugar do gradiente.

O que **não** muda: estrutura das páginas, larguras, altura do cabeçalho (48 px), comportamento de recolher o menu,
JavaScript, plugins, ícones (Font APEX continua), cores dos gráficos JET (definidas nos atributos de cada gráfico).

## Como aplicar (APEX 19.2)

1. **Suba os arquivos** em *Shared Components → Static Workspace Files* (ou *Static Application Files* de cada
   aplicação): `Natcorp_Style_Modern.min.css` (ou a versão legível). Se o ambiente não alcança o Google Fonts, suba
   também `Natcorp_Fonts.css` e a pasta `fonts/` e remova a linha `@import` do início da máscara.
2. **Registre o CSS** em *Shared Components → User Interface Attributes → Desktop → Cascading Style Sheets → File
   URLs*, **depois** da linha de `Natcorp_Style_Min.css`:
   ```
   #WORKSPACE_IMAGES#Natcorp_Style_Min.css
   #WORKSPACE_IMAGES#Natcorp_Style_Modern.min.css
   ```
   (com `Natcorp_Fonts.css` antes da máscara, se for o caso). A ordem importa: a máscara conta com vir por último.
   Faça isso em cada aplicação (100, 200, 700, 9113, 9610 e 9300).
3. **Cache**: mude o número de versão dos arquivos estáticos (ou o parâmetro `?v=`) para os navegadores baixarem a
   versão nova.
4. **Valide em homologação** com o roteiro abaixo, depois promova.

**Rollback**: remova a linha do arquivo em *File URLs*. Nada mais foi alterado.

**Aplicação 9300 (NatDocs)**: ela carrega `Natcorp_Style.css` e `Natcorp_Zoom_Mobile.css`, que não vieram no
pacote analisado. A máscara foi escrita para funcionar em cima do tema puro (Vita 1.4) e foi validada nas páginas
salvas de login, cadastro de usuário, assistente e processos de assinatura; confira essas duas folhas depois.

## Roteiro de teste (homologação)

Uma passada de 30 minutos, em Chrome e Edge (desktop) e no celular:

- [ ] Login: entrar, SSO, esqueci a senha; mensagem de erro de senha.
- [ ] Painel do Gestor (app 100, página 1): cartões, badge list, listas de aniversário, organograma, modal do blog.
- [ ] Colaboradores (app 200, página 2 e 13): filtros laterais, Interactive Report (buscar, ordenar, Ações → filtro,
  quebra, agregação, download), Interactive Grid (editar célula, salvar), modal "Dados do Colaborador" e modal sobre
  modal (feedback).
- [ ] Requisição de Alteração Funcional (app 100, páginas 115 e 116): trilha, IR, formulário grande com abas (RDS),
  LOV pop-up, data, select, checkbox, botões Voltar/Salvar, relatório de aprovadores.
- [ ] Linha do Tempo (app 200, página 108): Select2 múltiplo, abas, timeline.
- [ ] Recrutamento (apps 700/9113/9610): as páginas-moldura com iframe continuam escondendo cabeçalho, menu e rodapé.
- [ ] NatDocs (app 9300): cadastro de usuário (rótulos flutuantes), assistente de assinatura (wizard), lista de
  processos (media list), alertas de sucesso/erro, configurações LDAP.
- [ ] Menu lateral recolhido (botão de menu): só os ícones aparecem, sem o brilho rosa solto na tela.
- [ ] Botões flutuantes da NATI e do chamado interno; chat da NATI abre normalmente.
- [ ] Impressão de uma página (Ctrl+P) e zoom do navegador em 90% e 125%.
- [ ] Leitor de tela / navegação por teclado: foco visível em botões, links e itens do menu.

Se alguma tela específica precisar voltar ao visual antigo, envolva-a com uma classe na página (*Page → CSS Classes*)
e adicione regras de exceção no fim da máscara; não altere o `Natcorp_Style_Min.css`.

## Como a máscara foi construída

- **Escopo**: toda regra começa com `body.t-PageBody` (páginas da aplicação) ou `body.t-PageBody--login` (login). Isso
  dá especificidade suficiente para vencer o Theme Roller e o `Theme-Standard.min.css` (as classes `a-*` do Interactive
  Report, do menu e do Interactive Grid) sem `!important`.
- **`!important` só onde já existia**: `Natcorp_Style_Min.css` usa 91 deles (barra roxa das regiões, título das regiões,
  foco rosa dos campos, margem dos campos, gradiente dos cartões, raio das modais…); a máscara repete a marcação nesses
  pontos para conseguir sobrescrever. O cabeçalho (`.t-Header-branding`) e o fundo do login vêm gravados **inline** pelo
  tema, por isso também levam `!important`.
- **Nada de layout**: largura do menu (240 px), altura do cabeçalho (48 px) e os deslocamentos do `t-Body-nav` e
  `t-Body-side` são calculados pelo tema e pelo `theme42.js`; a máscara não toca neles.
- **Rótulos flutuantes**: a altura nova dos campos (40 px) é aplicada só fora de `t-Form-fieldContainer--floatingLabel`,
  que depende da medida original.
- **`:has()`**: usado em três pontos de acabamento (logo em imagem no cabeçalho, filete da barra de botões, pílula do
  menu). Navegadores sem suporte ignoram só essas regras.
- **Tokens** (`--nc-*`) no `:root`, com os valores do Manual de Identidade v1.2 e do app de referência: Roxo `#511C76`,
  Azul Profundo `#2C1A63`, Rosa `#C95788`, Ameixa `#9A408A`, Tinta `#1B1238`, Grafite `#4A4460`, Cinza `#8E88A3`,
  Névoa `#E9E5F1`, Off-white `#F4F2F7`, gradiente 135° Azul → Roxo → Ameixa.

## Próximos passos sugeridos (fora da máscara)

1. **Gráficos JET**: definir as cores das séries nos atributos de cada gráfico (Roxo `#511C76` para a série principal,
   Rosa `#C95788` para o destaque, Cinza `#8E88A3` para comparativos), como pede o manual. Hoje cada gráfico usa uma cor.
2. **Foto padrão** (`PROFILE.jpg`, 267 referências): trocar o clipart por um avatar neutro na paleta (um SVG de 2 KB).
3. **Ícones**: os apelidos antigos do Font Awesome 4 (`fa-clock-o`, `fa-gear`, `fa-bank`, `fa-pencil-square-o`)
   podem ser trocados pelos nomes atuais do Font APEX nas listas de navegação, sem mexer em código.
4. **Interactive Reports densos** (Colaboradores, 12 colunas): guardar um relatório padrão com menos colunas e mover
   o restante para o detalhe; a máscara ajuda, mas não substitui essa decisão.
5. **Limpar o `Natcorp_Style_Min.css`** depois da estabilização: remover os blocos comentados e os utilitários de
   `zoom`, ou fundir o que ficou nesta máscara (ele não é minificado, apesar do nome).
6. **Mensagens do servidor**: manter só um sistema (SweetAlert2 já está estilizado); Alertify e toastr podem sair.
