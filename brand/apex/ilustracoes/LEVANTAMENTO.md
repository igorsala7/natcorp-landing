# Ilustrações dos módulos — levantamento (28/09/2026)

Hoje TODAS as páginas abaixo mostram a mesma ilustração genérica, `docs_cad.png`
(3018×2910, pessoas montando um quebra-cabeça), exibida em 411×396 à esquerda dos cartões
do menu. Objetivo: uma ilustração por módulo, na mesma série (mesmo estilo), ligada ao tema.

| Módulo | Aplicação:página (alias) | Página | Tem também |
|---|---|---|---|
| eSocial | 9600:1 (ESOCIAL_MENU_NATCORP) | menu do eSocial | — |
| Administração de Pessoal | 9180:1 (ADMPESSOAL_NATCORP) | Home | marca `natcorp_modulo_AP.png` |
| Administração de Pessoal › Inf. Cadastrais e Funcionais | 9180:2 | menu | marca AP |
| Administração de Pessoal › Movimentações | 9180:3 | menu | marca AP |
| Administração de Pessoal › Controle de Frequência | 9180:5 | menu | marca AP |
| Administração de Pessoal › Movimentações Funcionais e Cadastrais | 9180:8 | menu | — |
| Folha de Pagamento | 9181:1 (ADMPESS_FOLHA_NATCORP) | Home | marca AP |
| Benefícios | 9182:1 (ADMPESS_BENEF_NATCORP) | Home | marca AP |
| Cargos e Salários | 9134:1 (CARGOS_SAL_NATCORP) | Home | `logomarca.png` |
| Termos | 9170:1 (TERMOS_NATCORP) | Home | — |
| Jurídico — Causas Trabalhistas | 2977:1 (JUR_CAUSAS_TRAB_MENU_NATCORP) | Home | — |

Sem ilustração: Importação — Carga de Dados (200:1000 › IMP_CARGA_NATCORP).

## Série decidida pelo cliente (28/09) — 18 ilustrações

Com ilustração hoje (a genérica, a trocar):
1. eSocial — eventos trabalhistas transmitidos à nuvem, escudo com visto, calendário de prazos
2. Administração de Pessoal (Home) — fichas de colaborador, pastas, organograma simples
3. Movimentações Funcionais — pessoa mudando de cadeira/posição, setas de transferência, crachá
4. Informações Cadastrais e Funcionais — ficha cadastral grande, foto 3x4, documentos pessoais
5. Folha de Pagamento — holerite, calculadora, moedas e barras
6. Benefícios dos Funcionários — cartão de benefício, saúde (coração/cruz), cesta, vale-transporte
7. Controle de Frequência — relógio de ponto, calendário, crachá aproximando
8. Políticas — livro/regulamento, balança de regras, escudo
9. NatPay — pagamento no celular, cartão, transferência instantânea

Sem ilustração hoje (a criar):
10. Cargos e Salários — degraus de carreira, faixa salarial, troféu
11. Recrutamento e Seleção — lupa sobre currículos, entrevista, candidato
12. Treinamento — sala de aula, telão, capelo/certificado
13. Avaliações — formulário com estrelas, feedback, metas
14. Medicina Ocupacional — consultório, estetoscópio, prontuário (ASO)
15. Segurança do Trabalho — capacete, colete, cone, EPI
16. Jurídico — balança da justiça, pasta de processo, martelo
17. Acessos — cadeado, chave, perfis de usuário, escudo
18. Termos — documento com assinatura, selo de aceite

Arquivos: ilustra-<modulo>.png (esocial, adm-pessoal, movimentacoes, inf-cadastrais, folha,
beneficios, frequencia, politicas, natpay, cargos-salarios, recrutamento, treinamento,
avaliacoes, medicina, seguranca, juridico, acessos, termos).

Geração: ElevenLabs, fluxo "Natcorp — Ilustrações dos módulos"
(https://elevenlabs.io/app/flows/40ML9RCjwa5df5IGeGvS), modelo gpt-image-2, 1:1, com
docs_cad.png ligada como referência de estilo (um nó por módulo; ids em nos.json).
Custo medido: piloto em 2K ~US$ 1,03 por imagem; série em 1K/alta ~1.525 créditos
(US$ 0,56) por imagem.

Pós (limpar.py): o modelo devolve RGB com um xadrez PINTADO no lugar da transparência;
o script inunda a partir da borda o cinza neutro, recorta, reduz e quantiza em 256 cores.
Sobre fundo escuro aparecem pontinhos claros soltos — invisíveis no fundo #FCFBFE.

## Estado (28/09, 00:50)
Prontas: esocial, adm-pessoal, movimentacoes.
Paradas por cota: as outras 15. O plano da ElevenLabs tem teto de 12.383 créditos e
restavam ~837; cada imagem pede ~1.525. Os nós estão montados no fluxo — basta
rodá-los de novo depois de recarregar a cota (1 variação cada = ~22.900 créditos).

## Guia de estilo (valer para todas)
- Isométrico plano, como a atual: personagens no mesmo traço (proporções alongadas, rosto
  simplificado), objetos grandes e legíveis, sombra suave no chão.
- Paleta Natcorp: Roxo #511C76, Rosa #C95788, Azul Profundo #2C1A63, Ameixa #9A408A, lilás
  claro (#E9E5F1 / #D6CFE4) e branco; pele e cabelo variados. Nada de verde/amarelo
  "bandeira" dominante.
- Fundo transparente (ou #FCFBFE, o fundo da página), PNG ~1600 px de lado, sem texto.
- Nome do arquivo por módulo: `ilustra-esocial.png`, `ilustra-adm-pessoal.png`,
  `ilustra-folha.png`, `ilustra-beneficios.png`, `ilustra-cargos-salarios.png`,
  `ilustra-termos.png`, `ilustra-juridico.png`.

## Depois de aprovadas
Subir em Workspace Files e, em cada página acima, trocar a referência `docs_cad.png` pela
do módulo.

Opção C tentada (28/09, 00:55): prompt de estilo detalhado em PROMPT-ESTILO.md (15 cenas
prontas, 3,6–3,7 mil caracteres cada). Morphix: plano gratuito, 1 crédito. Gamma: plano
gratuito, 50 créditos, recusou a primeira imagem (402). Nenhuma imagem gerada.

## Estado (28/09, 01:35) — série completa pela API da OpenAI
As 18 geradas pelo gpt-image-2 da API da OpenAI (gerar_openai.py + chatgpt/*.COMPLETO.txt),
com chatgpt/00-anexar-referencia.png como imagem de estilo. PNG já vem transparente.
As três da ElevenLabs estão guardadas em geradas/elevenlabs/.
limpar.py agora reduz a 1000 px e quantiza com pngquant (o quantize do Pillow granulava a
sombra suave). 18 arquivos, 3,2 MB, 150–200 KB cada.
seguranca: capacetes amarelos recoloridos para rosa em pós (geradas/seguranca-v1-rosa.png).
Defeitos vistos: natpay com a palavra "NatPay" e um logo inventado no notebook; cifrão "$"
em moedas/documentos de folha, beneficios, natpay e adm-pessoal; letra "E" na tabela de
visão de medicina.
