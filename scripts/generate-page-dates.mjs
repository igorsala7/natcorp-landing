// Gera src/content/pageDates.json — quando o conteúdo de cada página mudou pela última vez.
//
// POR QUE ISTO EXISTE
//
// Nenhuma das 60 páginas declarava data. Recência é sinal de peso muito alto para o
// Perplexity e alto para os resumos de IA do Google: sem data, o motor não sabe se a
// página fala do eSocial de 2026 ou de 2019 — e, entre duas fontes, escolhe a datada.
//
// POR QUE NÃO A DATA DO BUILD
//
// Seria mais fácil carimbar a data da compilação em tudo. Seria também mentira útil
// para ninguém: as 60 páginas passariam a alegar mudança a cada publicação, inclusive
// as que não mudaram. Data inflada é ruído, e o Google já disse que trata assim.
//
// Aqui a data vem do git: o commit mais recente que tocou o conteúdo daquela página.
// Se a página de folha não muda há três meses, ela diz que não muda há três meses —
// e quando mudar de verdade, a data anda sozinha.
//
// Uma rota pode depender de mais de um arquivo (a home depende do texto, do herói e
// da configuração do site). Nesse caso vale a mais recente entre elas.
import { execFileSync } from 'node:child_process'
import { readFileSync, writeFileSync, existsSync } from 'node:fs'
import { resolve } from 'node:path'

const root = resolve(import.meta.dirname, '..')
const ler = (p) => JSON.parse(readFileSync(resolve(root, p), 'utf8'))
const modulos = ler('src/content/modulePages/registry.json')
const segmentos = ler('src/content/segments/registry.json')
const estruturas = ler('src/content/structures/registry.json')

/** Arquivos que definem o conteúdo de cada rota. */
const fontes = {
  '/': ['src/pages/LandingPage.tsx', 'src/components/sections/Hero.tsx', 'src/content/site.ts'],
  '/sistema': ['src/pages/SystemPage.tsx'],
  '/modulos': ['src/pages/ModulesIndexPage.tsx', 'src/content/modulePages/registry.json'],
  '/segmentos': ['src/pages/SegmentsIndexPage.tsx', 'src/content/segments/registry.json'],
  '/estruturas': ['src/pages/StructuresIndexPage.tsx', 'src/content/structures/registry.json'],
  '/seguranca': ['src/pages/SecurityPage.tsx'],
  '/sobre': ['src/pages/AboutPage.tsx', 'src/content/recognition.ts'],
  '/contato': ['src/pages/ContactPage.tsx'],
  '/portais': ['src/pages/PortalsPage.tsx'],
  '/perguntas-frequentes': ['src/pages/FaqPage.tsx', 'src/content/faq.ts', 'src/content/structure.ts'],
  '/modelo-comercial': ['src/pages/CommercialPage.tsx'],
  '/implantacao': ['src/pages/ImplantationPage.tsx', 'src/content/implantation.ts'],
  '/jornada-da-contratacao': ['src/pages/HiringJourneyPage.tsx', 'src/content/hiringJourney.ts'],
  '/privacidade': ['src/content/legal/privacidade.ts'],
  '/termos-de-uso': ['src/content/legal/termos-de-uso.ts'],
  '/politica-de-cookies': ['src/content/legal/politica-de-cookies.ts'],
}
for (const m of modulos) fontes[`/modulos/${m.slug}`] = [`src/content/modulePages/${m.slug}.ts`]
for (const s of segmentos) fontes[`/segmentos/${s.slug}`] = [`src/content/segments/${s.slug}.ts`]
for (const e of estruturas) fontes[`/estruturas/${e.slug}`] = [`src/content/structures/${e.slug}.ts`]

const hoje = new Date().toISOString().slice(0, 10)

/** Data do último commit que tocou o arquivo, no formato YYYY-MM-DD. */
function ultimaMudanca(arquivo) {
  if (!existsSync(resolve(root, arquivo))) return null
  try {
    const saida = execFileSync('git', ['log', '-1', '--format=%cs', '--', arquivo], {
      cwd: root,
      encoding: 'utf8',
    }).trim()
    /* Vazio = arquivo ainda não commitado. Vale hoje: ele mudou agora. */
    return saida || hoje
  } catch {
    /* Sem git (uma entrega em pasta, por exemplo): a data do build é o melhor palpite. */
    return hoje
  }
}

const datas = {}
let semFonte = []
for (const [rota, arquivos] of Object.entries(fontes)) {
  const encontradas = arquivos.map(ultimaMudanca).filter(Boolean)
  if (!encontradas.length) { semFonte.push(rota); datas[rota] = hoje; continue }
  datas[rota] = encontradas.sort().at(-1) // a mais recente entre as fontes
}

writeFileSync(resolve(root, 'src/content/pageDates.json'), JSON.stringify(datas, null, 2) + '\n')

const distintas = new Set(Object.values(datas))
console.log(`page-dates: ${Object.keys(datas).length} rotas, ${distintas.size} datas distintas`)
if (semFonte.length) console.log(`page-dates: sem arquivo-fonte, usando a data de hoje — ${semFonte.join(', ')}`)
