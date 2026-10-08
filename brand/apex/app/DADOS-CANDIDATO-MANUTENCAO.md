# Dados do candidato — app 2937, página 29

A janela "Dados do candidato" da Agenda (página 10, painel do paciente → Paciente): a prévia de
QUEM o médico vai atender. Antes: 28 campos de formulário em grade, metade vazios, com sobras das
junções do banco (" - 36420361", " -  -  - ") e botões Sim/Não que pareciam editáveis. Agora, uma
ficha de leitura. (O botão "Dados do colaborador" abre a página 6 — ver HISTORICOCOLABORADOR-MANUTENCAO.md.)

Arquivos: `Natcorp_DadosCandidato.src.js` / `.src.css` → `../login/…js` / `.css`.
JS: `python3 gerar-dadoscandidato.py`. CSS: `gerar-app.mjs` (lista AVULSAS).
Exportação: `python3 aplicar-dadoscandidato-pagina29.py f2937_page_29.sql` (aplicada em 03/10;
original em `f2937_page_29.ORIGINAL.sql`).

## Como ficou

| Onde | O quê |
|---|---|
| Alto | `código - nome`, "Candidato · 37 anos · Masculino · para 244 - Repositor", selo da situação (Ativo verde, Pendente âmbar, Reprovado vermelho) |
| Atenção | PCD e Restrição para admissão em destaque — ou, em verde, "Sem restrição para admissão · não é PCD" |
| Seções | Vaga pretendida · Contato (telefone formatado, liga no celular; "sem DDD" quando falta) · Identificação (nascimento com idade, cadastro "há N anos") · Documentos (CPF com máscara e zeros, CTPS "nº · série") · Indicação e vínculos ("matrícula - Nome · empresa") · Uniforme |
| Vazios | só aparece o preenchido; o resto vira "Sem informação: …"; seção toda vazia fica baixa e cinza |
| Sem cadastro | "Não encontramos o cadastro do candidato N." no lugar do formulário vazio |

Ordem e rótulos: `[D1] SECOES` no topo do JS (tirar uma linha tira o campo da ficha).

## O que a exportação muda

- URLs de arquivo, comentário, título da janela ("Dados do candidato").
- **Correção do processo `CARREGA_DADOS`** (antes, a janela abria VAZIA com "Ocorreu um erro ao
  tentar processar as informações" — visto com o candidato 17223 em 03/10):
  - junção com `INF_FUNC_CANDIDATO` vira externa (`(+)`): candidato sem essa linha não quebra mais;
  - toda busca por código (filial, cargo, local, **função do cargo**, referências) pega uma linha
    (`rownum = 1`): cargo com várias funções devolvia "mais de uma linha";
  - `when no_data_found then null`: candidato inexistente → ficha avisa, sem erro.
  A causa exata do 17223 não foi confirmada no banco; a correção cobre as duas hipóteses.

## Defeitos do original que continuam (não mexi — decidir com quem cuida do Recrutamento)

- **Local pretendido** compara `loc.cod_Local_Trab = IFC.cargo_pretendido` (cargo, não local) — o
  local mostrado pode estar errado ou vir vazio.
- **Função pretendida** é "uma função do cargo pretendido", não a função escolhida pelo candidato.

## Cuidados

- Só lê. O formulário original fica na página, fora da vista (os botões são "Never").
- Aberta solta numa aba, a 29 não abre (é janela): testar Agenda → candidato → Dados do candidato.

## Regras da página (auditoria 04/10)

Conferido contra `f2937_page_29.ORIGINAL.sql`: 1 ação dinâmica (Cancel Dialog, de um botão Never),
2 processos (CARREGA_DADOS e fechar janela), 4 botões todos "Never" — a página não grava nada.
Todos os itens lidos aparecem na ficha (Eximido só quando marcado). Sem mudanças.

**Para saber:** a exportação aplicada altera o processo `CARREGA_DADOS` (junção externa, `rownum = 1`,
`no_data_found`) — correção já descrita acima; os dois defeitos de Local/Função pretendida continuam.
