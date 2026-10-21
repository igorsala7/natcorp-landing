# Regras de redação e de conteúdo

Valem para todo documento técnico entregue a cliente (TI, Segurança, auditoria, jurídico).

## 1. Só o que está conforme
- O PDF do cliente descreve apenas o que existe e funciona, com fonte. **Omitir é permitido; afirmar
  sem fonte ou prometer o que não existe, não.**
- Nunca "100%", "certificado", "atende integralmente", "garantimos" sem evidência. Prefira "como a
  Natcorp apoia o cumprimento de...". Lei não é certificação (LGPD é lei).
- Texto normativo de política interna ("deve", "recomenda-se") vira "a política estabelece" ou
  "padrão da política". Só vira fato quando outra fonte confirma a prática.
- Valor informado pelo dono (prazos, RPO/RTO) vale sobre a política; registre a divergência no INTERNO.
- Lacunas, vulnerabilidades, divergências entre fontes e não conformidades vão para o relatório
  **INTERNO - NAO ENVIAR**, nunca para o PDF.

## 2. O que nunca aparece no PDF
URLs de endpoint, IPs, hostnames internos, nomes de arquivo de código, chaves e segredos, nomes de
clientes (a documentação de API e os questionários citam clientes: tirar), dados pessoais de pessoas
(exceção: o encarregado de dados publicado no site). Versão de software só se o dono pedir (em
21/10/2026 ele pediu para tirar a versão do Oracle Database).

## 3. Termos da casa
- "Modo multiusuário" em texto de cliente, nunca "totem". "Aparelho", não "tablet".
- "Empresa cliente" (controladora) e "Natcorp" (operadora) na LGPD.
- Holding: "o cliente pode ter diversas empresas e filiais cadastradas no mesmo sistema, como uma holding".
- Backups: "realizados múltiplas vezes ao dia" (sem número e sem "dump noturno").
- RPO/RTO vigentes (21/10/2026): RPO até 6 h; RTO até 4 h (falha lógica); em indisponibilidade severa
  aciona-se o disaster recovery em até 4 h. Confirmar com o dono se mudaram.

## 4. Estilo
- Português do Brasil, técnico e claro; pode ser mais técnico que o material comercial.
- **Zero travessão (—).** Use vírgula, dois-pontos, parênteses.
- Sem cadência de contraste curto ("Não é X. É Y.", "você tem X, não Y"). Frases com subordinadas.
- Sem palavras de enchimento: sinceramente, honestamente, na verdade, basicamente, simplesmente.
- Cada capítulo abre com um parágrafo-lead que responde "por que isso importa".
- Cartões: título curto (2 a 4 palavras) + 1 a 3 frases. Tabelas para comparação; passos para sequência.
- Um "Você sabia?" por capítulo no máximo, com algo que o cliente controla ou um detalhe prático.

## 5. Estrutura que funcionou (TI e Segurança)
0 capa + "Como ler" · 1 em 1 minuto (cartões + tabela dos números mais pedidos) · arquitetura com figura ·
ambientes e mudanças · identidade e acesso · proteção dos dados · APIs e integrações (figura de camadas,
tipos de credencial, portal, exemplos GET/POST, construtor com figura) · produto específico (NatPonto) ·
registros e monitoramento · backup e continuidade · vulnerabilidades e incidentes (prazos) · LGPD ·
terceiros e responsabilidade compartilhada · governança (figura de defesa em profundidade) ·
questionário de fornecedor (pergunta | resposta | capítulo), glossário, documentos sob solicitação, contatos.
