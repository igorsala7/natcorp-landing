# Natcorp — instruções do projeto

## O filme institucional

**Em toda mensagem e toda ação relacionadas ao filme, aplicar a skill
`direcao-criativa`** (`.claude/skills/direcao-criativa/SKILL.md`). Ela não é
consulta opcional: é o modo de trabalhar aqui.

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
