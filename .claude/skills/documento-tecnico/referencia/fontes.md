# Levantamento de fontes

Antes de escrever uma linha, junte as fontes em `fonte/` do documento: um arquivo de notas por fonte
(`01_site.md`, `02_politica.md`...), com **citação literal entre aspas e a origem** de cada afirmação, e
os textos brutos em `fonte/raw/`. É isso que permite cumprir "só o que está conforme".

## Fontes da Natcorp, por força
1. **Política de Segurança da Informação** (PSI-NATCORP-001; em 21/10/2026 a v2.0.1 de jun/2025, em
   `~/Desktop/Natcorp - Cybersecurity/`). Classificada para compartilhamento controlado com clientes.
   Atenção: ela é normativa ("deve") e a revisão anual venceu em jun/2026.
2. **Site natcorp.com.br**: /seguranca/, /modulos/infraestrutura-e-seguranca, /privacidade/,
   /termos-de-uso/, páginas de módulos. Afirmação publicada no site pode ir para o PDF.
3. **Portal de APIs** do cliente (`natcorpbr.com.br/natcorp/api-docs/?client=...`): padrão de
   autenticação, famílias de API, páginas de endpoint. Não copiar endpoints nem nome de cliente.
4. **Respostas do dono** em questionários anteriores (ex.: artifact do "NatPonto por dentro") e no chat.
5. **Questionários de segurança já respondidos a clientes** (`~/Desktop/Natcorp/*.xlsx`, `.doc`): úteis
   para saber o que perguntam, mas divergem entre si; nunca use como única fonte de um número.
6. Código e documentação dos projetos (ex.: `natcorp-app-ponto-1/docs/`), só em alto nível.

## Como ler cada tipo
- **Site da Natcorp**: tem verificação anti-robô; WebFetch devolve só "Verifying your browser". Use o
  navegador do Playwright (`browser_navigate` e depois `browser_evaluate` devolvendo
  `(document.querySelector('main')||document.body).innerText`, salvando com `filename` dentro de
  `.playwright-mcp/` do projeto) e mova o texto para `fonte/raw/`. FAQs em acordeão podem não abrir.
- **PDF**: ferramenta Read no arquivo inteiro (sem `pages` se o poppler não estiver instalado).
- **.doc/.docx**: `textutil -convert txt -stdout arquivo`. Se travar, o arquivo pode estar só no
  iCloud (placeholder): peça ao dono para abrir no Finder e baixar.
- **.xlsx**: Python com openpyxl, todas as abas e colunas de resposta.
- **Muitas fontes**: dispare agentes em paralelo, um por grupo de fontes, cada um gravando seu arquivo
  de notas com citações literais e uma seção "Divergências entre fontes". O limite de uso dos agentes
  pode cortar o trabalho: confira o que cada um gravou antes de confiar.

## Cruzamento
Para cada número ou afirmação forte (backup, RPO/RTO, datacenters, MFA, retenção, provedores), compare
as fontes. Quando divergirem, use a versão mais conservadora no PDF e registre a divergência no INTERNO.
Exemplos já encontrados: backup "2 por dia" (site) x "múltiplo + dump noturno" (PSI) x "restauração
todo fim de semana" (questionário); "3 datacenters" (site) x "2" (questionário) x "possibilidade de DR"
(PSI); "UOL Diveo" ainda citada na Política de Privacidade do site.
