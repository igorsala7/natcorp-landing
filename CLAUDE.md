# Natcorp — instruções do projeto

## O filme institucional

### ANTES DE QUALQUER AÇÃO NUMA CENA — rodar, não lembrar

```
python3 filme/prompts/abrir-cena.py <cena>      # ex.: 03
```

**E colar a saída na conversa**, antes de escrever prompt, gerar ou montar. Ela traz o
orçamento de tempo daquela cena, os quadros que a bíblia manda, os blocos travados para
colar verbatim, as armadilhas já pagas ali e o que já existe na pasta.

Colar serve para duas coisas: garantir que eu li, e deixar o cliente corrigir uma
premissa errada ANTES de a rodada ser paga.

### ANTES DE MOSTRAR QUALQUER CHAPA

```
python3 filme/prompts/conferir-chapa.py --ref <aprovada> --novas <novas...>
```

Monta a folha com **o rosto da chapa nova ao lado do aprovado** e a lista de conferência
com ELENCO em primeiro. Mandar a folha junto com a entrega.

### POR QUE ESTES DOIS COMANDOS EXISTEM

A seção abaixo — "aplicar duas skills e uma memória" — já estava aqui, já carregava
sozinha em toda sessão, e **eu errei mesmo assim**: em 15/09 entreguei três chapas da
cena do carro com a atriz errada, depois de cinco conferências feitas de cabeça, na
ordem em que me ocorreram. O rosto não me ocorreu.

A conclusão, do cliente: *"Você começa a esquecer do que definimos, vai apagando da sua
memória coisas que decidimos há horas atrás."* Está certo. Intenção escrita depende de
eu lembrar de cumpri-la na hora certa; comando não. Detalhe em [[ritual-de-cena]].


**Em toda mensagem e toda ação relacionadas ao filme, aplicar DUAS skills e UMA
memória, nesta ordem:**

1. **`bussola-do-projeto`** (memória) — a VISÃO DO TODO: o mapa de tempo das 20 falas,
   o orçamento em segundos de cada cena, o estado de cada uma e o porquê de cada
   decisão. **É a PRIMEIRA coisa a abrir**, antes de gerar ou montar. Um plano bonito
   que estoura o tempo da locução é um plano descartado.
2. **`produtora`** (`.claude/skills/produtora/SKILL.md`) — as onze frentes de uma
   grande produtora publicitária (direção, produção, roteiro, arte, fotografia,
   iluminação, figurino, encenação, som, montagem, pós) como perguntas a responder
   antes de cada ação.
3. **`direcao-criativa`** (`.claude/skills/direcao-criativa/SKILL.md`) — o mandato, o
   checklist e todas as regras aprendidas caso a caso, com o custo de cada erro.
4. **`biblia-de-continuidade`** (memória) — **abrir a linha DA CENA que vai ser
   montada, antes de montar.** É lá que estão os quadros aprovados de cada cena, um
   por um (q1 aberto, q2 tela, q3 rosto), com o nome do arquivo escolhido. Duas vezes
   eu montei sem abrir: entreguei a CHAPA no lugar da imagem selecionada, e depois
   deixei o q3 do carro de fora do corte. **A cena não está montada enquanto todos os
   quadros aprovados dela não estiverem no corte.**

Nenhuma das três é consulta opcional: são o modo de trabalhar aqui.

Os quatro pontos que não se negociam, resumidos — o resto está na skill:

1. **Diretor criativo, padrão Itaú.** Nenhum plano existe só para ilustrar a
   locução. Luz, arte, figurino e lente são decisões explícitas. Drama positivo.
2. **Checklist de 8 itens antes de cada prompt**, inclusive nos de correção
   técnica. Citação não governa comportamento; verificação governa.
3. **Verificar antes de afirmar.** Nunca dizer que um plano ficou bom sem ter
   assistido a ele inteiro. Medir o que dá para medir e relatar o número.
   Apontar o próprio erro antes que o cliente aponte.
4. **Gasto é do cliente.** Antes de gerar: já existe? resolve em pós? o erro
   anterior foi diagnosticado? Nunca repetir uma forma que o modelo já recusou.

A memória do projeto (`~/.claude/projects/.../memory/`) guarda o histórico
detalhado: bíblia de continuidade, falhas de vídeo generativo, quadros
flutuantes, locução, e o mapa do plano-sequência.

## Código

Commitar direto na main; nada de branch sem consultar.

## O site

Site institucional da Natcorp: SPA React 19 + TypeScript + Vite + Tailwind,
**pré-renderizada em HTML estático** (Chrome headless, 75 rotas) e publicada na Vercel.
O produto que os clientes operam NÃO está aqui — roda em Oracle APEX, em outro servidor;
este repositório é o site mais as portas de entrada (`/portais/<cliente>`) que levam a ele.

**Stack**: React 19 · react-router 8 · Vite (Rolldown) · Tailwind · motion/react ·
Radix/shadcn · zod + react-hook-form · jspdf/pptxgenjs (o deck comercial exporta sozinho).

**Estrutura**: `src/content/` são DADOS (31 módulos, 9 segmentos, 5 estruturas, 3 documentos
legais), `src/pages/` são 27 rotas, `src/components/` a apresentação, `scripts/` sete
geradores que rodam antes do bundler. `filme/` e `material-interno/` estão no `.gitignore`.

**Três coisas que mordem:**

1. **Nenhum arquivo publicado pode conter a LISTA de clientes** — um `import portals.json`
   novo em qualquer módulo que o app carregue reintroduz o vazamento de 21/09/2026, em
   silêncio. Detalhe em [[carteira-de-clientes-nao-publica]].
2. **Nada anima `opacity` a partir de 0** — o site é pré-renderizado e o valor congelaria
   no HTML entregue. Está comentado em `src/lib/motion.ts`.
3. **O site não publica sozinho**: `npm run build` (precisa de Chrome no PATH) e subir o
   `dist/` à mão.

Arquitetura detalhada, fluxos e 19 armadilhas em [docs/CODEBASE_MAP.md](docs/CODEBASE_MAP.md).
