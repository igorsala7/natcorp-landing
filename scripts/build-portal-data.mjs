// Publica o cadastro dos portais QUEBRADO POR CLIENTE, um arquivo cada.
//
// POR QUE ISTO EXISTE
//
// Até 21/09/2026 o site importava src/content/portals.json direto no código do
// React. Como o rodapé (que está em toda página) importava @/content/portals só
// para usar hubPath(), o empacotador arrastava o cadastro INTEIRO para o pacote
// principal. Qualquer visitante da home abria o DevTools e lia, em texto puro:
//
//   {slug:`redeflex`, name:`Redeflex`, code:`REDEFLEX`, apex:`rh`, ...}
//
// Os sete clientes, com nome, código, servidor do APEX e endereço de cada
// portal. O dono, na mesma noite: "JAMAIS pode expor essas informações".
//
// A REGRA QUE FICA: nenhum arquivo publicado pode conter a LISTA de clientes.
// Um cliente pode servir o próprio cadastro — ele já sabe quem é — mas ninguém
// pode enumerar os outros. Por isso um arquivo por cliente, com o nome do
// próprio cliente no caminho: quem não souber o nome não acha, e quem souber só
// acha aquele.
//
// O mesmo vale para os logotipos: o import.meta.glob antigo listava os arquivos
// (realfood.png, redeflex.png...) dentro do pacote. Agora eles são copiados para
// public/ e referidos por URL, que só aparece no JSON do dono.
//
// Roda no prebuild, antes do vite, porque grava dentro de public/.
import { copyFileSync, existsSync, mkdirSync, readFileSync, readdirSync, rmSync, writeFileSync } from 'node:fs'
import { resolve } from 'node:path'

const root = resolve(import.meta.dirname, '..')
const registro = JSON.parse(readFileSync(resolve(root, 'src/content/portals.json'), 'utf8'))
const origemLogos = resolve(root, 'src/assets/portals/logos')
const destinoDados = resolve(root, 'public/portais/dados')
const destinoLogos = resolve(root, 'public/portais/logos')

/* Apagar antes de escrever: um cliente removido do cadastro tem de sumir de
   public/ também, senão o arquivo dele continua no ar depois de sair. */
for (const dir of [destinoDados, destinoLogos]) {
  if (existsSync(dir)) rmSync(dir, { recursive: true })
  mkdirSync(dir, { recursive: true })
}

/** O arquivo de logotipo deste cliente em src/assets/portals/logos/, se existir. */
function acharLogo(client) {
  const arquivos = existsSync(origemLogos) ? readdirSync(origemLogos).filter((f) => /\.(svg|png|webp|jpe?g)$/i.test(f)) : []
  if (client.logo) {
    const exato = arquivos.find((f) => f === client.logo)
    if (exato) return exato
  }
  /* Sem nome no cadastro vale <slug>.<ext>, a mesma convenção de antes. */
  return arquivos.find((f) => f.replace(/\.(svg|png|webp|jpe?g)$/i, '') === client.slug)
}

let publicados = 0
const inativos = []

for (const client of registro.clients ?? []) {
  if (client.active === false) {
    inativos.push(client.slug)
    continue
  }
  const arquivo = acharLogo(client)
  let logoUrl
  if (arquivo) {
    copyFileSync(resolve(origemLogos, arquivo), resolve(destinoLogos, arquivo))
    logoUrl = `/portais/logos/${arquivo}`
  }
  /* Só o que a página de acesso usa. O cadastro tem campos que não precisam
     sair daqui; o que não é publicado não pode vazar. */
  const dados = {
    slug: client.slug,
    name: client.name,
    code: client.code,
    apex: client.apex,
    logoUrl,
    apps: client.apps,
    natponto: client.natponto,
    urls: client.urls,
  }
  writeFileSync(resolve(destinoDados, `${client.slug}.json`), JSON.stringify(dados, null, 2) + '\n')
  publicados += 1
}

console.log(`portal-data: ${publicados} clientes, um arquivo cada, em public/portais/dados/`)
if (inativos.length) console.log(`portal-data: fora do ar (active:false), sem arquivo publicado: ${inativos.join(', ')}`)
console.log('portal-data: nenhum arquivo publicado contem a LISTA de clientes — so o proprio cliente, pelo nome dele')
