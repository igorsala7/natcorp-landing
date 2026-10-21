# Checklist antes de entregar o PDF

## Conteúdo
- [ ] Cada afirmação tem fonte em `fonte/` (citação literal). Nada de "certificado" ou "100%".
- [ ] Normativo da política escrito como "a política estabelece", salvo prática confirmada.
- [ ] Nenhuma URL de endpoint, IP, hostname, chave, nome de cliente ou dado pessoal (fora o encarregado).
- [ ] Números conferidos entre fontes; divergências registradas no INTERNO.
- [ ] Referências cruzadas ("capítulo N") e coluna "Capítulo" do questionário batem com a numeração
      atual (renumerar ao inserir capítulo).
- [ ] Caixas âmbar e `[preencher:]`: o dono quer o PDF sem elas? (padrão: sem). `grep -c "confirmar\|preencher" conteudo.md`.
- [ ] Termos da casa (referencia/redacao.md §3).

## Geração
- [ ] `node .claude/skills/documento-tecnico/toolkit/gerar.mjs <doc>` sem AVISO de travessão nem de fonte.
- [ ] Abrir `build/png/folha-1.png` (e `folha-2.png`) e olhar o documento inteiro de uma vez.
- [ ] Abrir em tamanho real cada página com figura nova ou alterada.
- [ ] Sem página quase vazia (uma caixa sozinha no topo): mover ou fundir o bloco que transbordou.
- [ ] Rodapé com o nome do documento, capa e contracapa corretas.

## Entrega
- [ ] PDF final em `<doc>/<arquivoPdf>`; relatório INTERNO atualizado e citado na mensagem.
- [ ] Na mensagem: o que mudou, o que foi verificado, o que ficou para o dono decidir.
