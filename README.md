# Natcorp — Landing Page

Landing page institucional da **Natcorp**, HR Tech brasileira com mais de 35 anos de tecnologia para a gestão de
pessoas de grandes empresas: Departamento Pessoal, Recursos Humanos e Medicina e Segurança do Trabalho em um
único sistema, com mais de 30 módulos integrados e a **NATI**, a inteligência artificial que trabalha dentro do sistema.

> "Todo o RH. Um único sistema."

## Stack

- [Vite 8](https://vite.dev) + React 19 + TypeScript
- Tailwind CSS 3 + [shadcn/ui](https://ui.shadcn.com) (accordion, select, form, sonner)
- [Motion](https://motion.dev) (`motion/react`, `LazyMotion` + `m`) para animações e coreografia de rolagem
- [Lenis](https://lenis.darkroom.engineering) para rolagem suave (desligada com `prefers-reduced-motion`)
- react-hook-form + zod (formulário de leads)
- Fonte **Manrope** (variável, 200–800) self-hosted em `public/fonts`

## Rodando localmente

```bash
npm install
npm run dev      # servidor de desenvolvimento
npm run build    # typecheck + build de produção em dist/
npm run preview  # serve o build localmente
npm run lint     # oxlint
```

## Páginas e rotas

| Rota | Página |
| --- | --- |
| `/` | Landing page institucional |
| `/modulos` | Índice com os 7 grupos e todos os módulos |
| `/modulos/:slug` | Página dedicada de cada módulo (31 páginas) |
| `/segmentos` | Índice dos 9 segmentos atendidos |
| `/segmentos/:slug` | Página por segmento: realidade, dores, respostas e o paralelo com todos os módulos |
| `/sistema` | Visão geral (fora do menu por enquanto): sete frentes em abas com telas, People Analytics, NatPonto, multiplataforma, comparativo, personas e FAQ completo |
| `/seguranca` | Segurança e infraestrutura: nuvem Oracle, ambientes, backups, SaaS e LGPD |
| `/sobre` | Sobre a Natcorp: história, missão, visão e valores, reconhecimentos e clientes, serviços e vídeos |
| `/contato` | Canais de contato, formulário, escritórios e como funciona o atendimento |
| `/portais` | Portais do Gestor, do Colaborador e do Candidato, requisições com workflow, módulos de autoatendimento e multiplataforma |
| `/estruturas` | Como é a sua estrutura? Seletor de três perguntas (empresas, unidades, RH) que leva a uma das cinco estruturas, os cinco cartões e o centro de serviços compartilhados. `/grupos` redireciona para cá |
| `/estruturas/:slug` | Página por estrutura (empresa única, várias unidades, grupo com RH central, RH por unidade, equipes em clientes): como o RH costuma funcionar, dores e respostas, quem faz o quê, o fluxo animado do centro de serviços, os 31 módulos aplicados, o caminho para o CSC, personas e FAQ |
| `/perguntas-frequentes` | Todas as perguntas frequentes, gerais e para grupos, com atalhos para as páginas que aprofundam (a seção de grupos leva a `/estruturas`) |
| `/modelo-comercial` | Modular, em nuvem e pelo número de colaboradores: os três pilares, histórico completo na implantação, contabilização integrada ao ERP, diferenciais frente a outros sistemas, comparativo e como funciona a contratação |
| `/portais/natcorp/` | Página estática de acesso aos portais do cliente (gerada em `public/portais/<cliente>/` por `scripts/build-portais.mjs` a partir de `src/content/clientPortals.json`): Gestor, Operador, Colaborador, Cadastro de Currículo, Assinatura Eletrônica e Chamado, com "continuar de onde parou" e ajuda para entrar. Autônoma, pode ser copiada para o servidor atual |
| `/apresentacao` | Apresentação executiva em tela cheia (fora do menu e do sitemap): 24 slides do deck comercial, com navegação por teclado, índice, notas do apresentador, tela cheia e exportação em PDF. `?s=N` abre direto no slide N |
| `/jornada-da-contratacao` | Jornada do colaborador em 24 etapas e 4 fases, em uma indústria fictícia. Duas visões (`?modo=pratico` alterna): a história completa, com personagens 3D, mini mockups e o mapa que acompanha a rolagem, e a visão prática, um diagrama por raias (gestor, candidato, colaborador, RH, SESMT, sistema). Fecha com o diagrama animado dos módulos se integrando |
| qualquer outra | Página 404 |

O roteamento é feito no cliente com [React Router](https://reactrouter.com) (`BrowserRouter`). Por isso o servidor
precisa devolver `index.html` para qualquer caminho: já estão incluídos `vercel.json` (Vercel) e `public/_redirects`
(Netlify/Cloudflare Pages). Em outros provedores, configure o "SPA fallback" equivalente.

Os mesmos dois arquivos trazem **redirecionamentos permanentes (301)** dos endereços do site anterior em WordPress
(`/solucao-de-rh/` → `/modulos`, `/sobre-nos/` → `/sobre`, `/fale-conosco/` → `/contato`, `/servicos/` → `/sobre#servicos`,
`/folha-de-pagamento/` → `/modulos/folha-de-pagamento` etc.) para as rotas novas,
para que os links já indexados pelo Google e salvos por clientes continuem funcionando. O `/blog/` ficou de fora:
depende de onde o WordPress vai continuar publicado.

`npm run build` roda antes `scripts/generate-sitemap.mjs`, que gera `public/sitemap.xml` e `public/robots.txt`
a partir dos registros em `src/content/modulePages`, `src/content/segments` e `src/content/structures` (use `VITE_SITE_URL`
para o domínio final).

## Portais de acesso dos clientes

`/portais/<cliente>/` é a página que colaboradores, gestores e candidatos usam para entrar no sistema (a atual fica em
`www.natcorp.com.br/portais/natcorp/`). Cada cliente é uma entrada em `src/content/clientPortals.json` (nome, título, os
portais com descrição, público, ilustração e URL, textos de ajuda); `npm run portais` (também executado antes do build)
gera `public/portais/<cliente>/index.html` com CSS e JS embutidos, favicon em data URI e as ilustrações de marca de
`brand/modulos/ilustracoes` copiadas para `img/`. Por ser autônoma, a pasta pode ser copiada para o servidor atual sem
depender do site novo. A página guarda o último portal usado no navegador e oferece "continuar de onde parou"; portais
sem URL aparecem como "Em configuração" e apontam para a ajuda. As URLs dos portais devem ser confirmadas com o time
antes de publicar (o campo `confirmar` marca as que vieram por dedução).

## Apresentação executiva

`/apresentacao` é o deck comercial do sistema, em tela cheia e sem a moldura do site: 24 slides que seguem a
seção 14 do manual (um assunto por slide, até três números de destaque, seção de produto em Azul Profundo,
rodapé com o símbolo e o número do slide). O roteiro vai do momento do RH e do custo da operação manual até a
plataforma (as sete frentes, módulo a módulo, e a NATI), segurança na Oracle Cloud, resultados, comparativo,
modelo comercial, implantação, clientes, o custo de esperar e o convite para a demonstração.

- **Apresentar**: setas, espaço ou Page Up/Down trocam de slide; `F` tela cheia; `N` notas do apresentador;
  `G` índice; `Esc` fecha. Em tela cheia a barra some depois de alguns segundos sem mexer o mouse.
- **Compartilhar**: a posição fica na URL (`/apresentacao?s=12`), e o índice tem "Copiar o link deste slide".
- **PDF**: o botão "Baixar em PDF" entrega `public/natcorp-apresentacao.pdf`, gerado a partir dos próprios
  slides (um por página, 16:9, igual à tela). Depois de mudar o conteúdo, gere de novo: `npm run build && npm run preview`
  e, em outro terminal, `npm run export:deck` (`--png pasta` salva também um PNG por slide; requer o pacote
  `playwright`). A impressão pelo navegador (`Ctrl/Cmd+P`) sai em paisagem, um slide por página, mas com o
  layout de tela estreita; prefira o PDF gerado.
- **Conteúdo**: textos, números e notas em `src/content/presentation.ts`; o roteiro (ordem, capítulos, títulos)
  em `src/components/presentation/slides/index.ts`; a moldura (rolagem com encaixe, teclado, barra, índice,
  notas, exportação) em `src/components/presentation/Deck.tsx`; os blocos de slide (`Slide`, `SlideTitle`,
  `Big`, `Card`, `Chip`, `Rise`, `Stagger`) em `Slide.tsx`. Os tamanhos de texto são fluidos (variáveis
  `--dk-*` em `src/index.css`), para caber de um projetor 1280x720 a um monitor 4K e no celular.
- Os módulos, personas, comparativo, resultados e clientes vêm dos mesmos arquivos de conteúdo do site
  (`modules.ts`, `personas.ts`, `recognition.ts`, `nati.ts`), então uma correção vale para os dois.

## Conteúdo dos módulos

Cada módulo é um arquivo em `src/content/modulePages/<slug>.ts` que exporta um objeto `ModulePage`
(tipo em `types.ts`): título, resumo, SEO, números de destaque, benefícios, funcionalidades (com ícone de
`icons.ts`), fluxo "como funciona", conformidade, personas, perguntas e módulos relacionados. O conteúdo foi
escrito a partir das 33 apresentações comerciais de natcorprh.app e do briefing; o campo `sources` registra quais.

- `registry.json` define slug, nome, grupo, ícone e resumo curto de cada módulo. É a fonte do mega-menu, do
  índice, do rodapé e do sitemap.
- Para adicionar um módulo: inclua a entrada no `registry.json`, crie `<slug>.ts` e, se quiser, aponte itens
  de `src/content/modules.ts` (cards da landing) para ele com `slug` e `hash`.
- O conteúdo de cada módulo é carregado sob demanda (um chunk por página).

## Estrutura

```
src/
  pages/        LandingPage, ModulesIndexPage, ModulePage (template data-driven), NatiModulePage, NatPontoModulePage e
                PeopleAnalyticsModulePage (páginas dedicadas com as telas do produto), SegmentsIndexPage e SegmentPage,
                StructuresIndexPage e StructurePage (templates data-driven de content/structures), HiringJourneyPage,
                PresentationPage (a apresentação executiva em tela cheia), NotFoundPage
  components/
    brand/      Logo.tsx (símbolo + wordmark em vetor), logo-paths.ts (geometria gerada do manual),
                LogoMotion.tsx (a assinatura em movimento: os losangos se encaixam, o raio rosa acende o X
                e o wordmark aparece; usada na abertura), motion/ (peças da mesma família: SystemMotion,
                NatiMotion e CloudMotion, reunidas na página interna /motion, fora do menu e do sitemap),
                NatiAvatar e EmployeeAvatar (os personagens 3D em disco claro, com anel opcional), NatPontoIcon (ícone em vetor)
                HumanModule.tsx: fotografia recortada pelos módulos do símbolo, gradiente da marca por cima e
                linhas de luz nas arestas (hero, banner "Por que Natcorp", retratos das personas)
    hero/       HeroScene (a cena natcorp_hero_v2 com a arte da marca animada por cima, alinhada à imagem:
                o módulo do símbolo em contorno de luz com brilho percorrendo a borda, linhas de fluxo com
                pacotes de luz, um módulo menor em vidro, véu para o texto e cartões do sistema) e HeroStage
                (a pessoa recortada entre o humano e o sistema). A constante VARIANT em sections/Hero.tsx
                escolhe qual abre a home.
    motion/     Intro (abertura), SmoothScroll, ScrollManager (rotas + âncoras), PageTransition,
                Reveal/Stagger, SplitText, Counter, Marquee, Magnetic, SpotlightCard, Parallax, ScrollProgress
    presentation/ Deck (a moldura da apresentação: rolagem com encaixe, teclado, progresso, índice, notas, tela cheia e
                exportação em PDF), Slide (o slide 16:9 e os blocos de texto, número, cartão e etiqueta) e slides/ (os 24
                slides em cinco arquivos: abertura, frentes, plataforma, negócio e fechamento; a ordem em index.ts)
    mockups/    Telas do produto construídas em código: dashboard, DevicesShowcase (notebook, tablet e
                celular), nati/ (chat, gráficos, WhatsApp, painel do operador), natponto/ (as cinco telas
                do app) e analytics/ (Painel do Operador: indicadores de medicina, comparativo financeiro em
                gráfico e tabela, modal de recrutamento, gráficos SVG reutilizáveis)
    journey/    Página da jornada: JourneyMap (mapa lateral e barra de fases), EffectivationHub, visuals (mini mockups por etapa),
                scenes/ (cenas montadas por camadas: palco escalado ao contêiner, cenário em SVG com paralaxe, figuras 3D recortadas e a interface animada por fases; descobertas pelo nome EtapaNNScene.tsx),
                Cast (avatares e figuras 3D dos personagens), JourneyDiagram (visão prática por raias, com conectores medidos
                por useNodeRects) e IntegrationDiagram (SVG dos módulos se integrando; geometria em integration-layout.ts)
    nati/       A NATI como agente: NeuralHub (a NATI no centro, 7 frentes e 31 módulos com pulsos de dados), InsightStream
                (análises cruzando módulos, digitadas), NetworkField (fundo de rede em canvas), FrontsMatrix (7 frentes x 5
                capacidades), NatiStats, NatiPipeline; conteúdo em content/nati.ts
    sections/   Navbar (menus Sistema, Segmentos e Empresa), Hero (foto em tela cheia + HeroSymbol), ProofStrip (números e
                prêmios), Problem (pergunta em fundo escuro + cena "hoje / com a Natcorp"), Platform (símbolo interativo por
                área), Journey (história da Ana com tela fixa que troca ao rolar), NatiTeaser (prévia da NATI logo após os números), Nati (a NATI se apresenta digitando, hub neural, análise contínua, números, capacidades e chat),
                Segments (faixa de fotos com a dor de cada segmento), Why (manifesto tipográfico + "o que não cobramos" +
                banner humano), Comparison, Services, Recognition, Videos, Modules, GroupTabs, Analytics, NatPonto, Portals,
                Responsive, Security, Personas, FAQ (com itens e link "ver todas"), FaqAccordion, StructureChooserSection
                (o seletor compacto na home) e StructureStrip (faixa com as cinco estruturas, fecha segmentos, jornada e portais),
                CTA (+ LeadForm lazy, canais e escritórios), Footer
    structure/  Página "Como é a sua estrutura?": StructureChooser (três perguntas com papel de rádio e resultado ao vivo),
                ResponsibilityMap (quem faz o quê: tabela em telas largas, cartões no celular), ServiceCenterDiagram
                (entradas, centro e saídas com conectores medidos e animados; empilhado no celular) e ModuleChip
    seo/        JsonLd, Breadcrumb
    ui/         primitivos shadcn/ui
  content/      textos e dados (módulos da landing, FAQ, personas, navegação e contato em site.ts, reconhecimentos, vídeos),
                hiringJourney.ts (as 24 etapas da jornada, com ator e personagem por etapa), journeyArt.ts (figuras, retratos e
                cenas opcionais, descobertos pelo nome do arquivo), modulePages/ (páginas de módulo), segments/ (páginas por segmento)
                e structures/ (as cinco estruturas: registro, perguntas do seletor e o conteúdo de cada página)
  assets/avatars nati.png (a NATI, personagem 3D oficial, renderizada em alta resolução a partir do avatar do material
                da Natcorp) e ana.png (a colaboradora Ana, no mesmo estilo 3D); PNG com fundo transparente, 512 px.
                Para usar o arquivo original, basta substituir nati.png
  assets/journey figure-<personagem>.png (corpo inteiro, recortado), bust-<personagem>.png (retrato) e scene-<etapa>.jpg (cena,
                opcional) dos personagens da jornada, no mesmo estilo 3D da NATI. Basta adicionar um arquivo com esse nome
                para ele aparecer na página; personagens sem retrato mostram as iniciais
  assets/videos miniaturas dos vídeos (960x540), servidas pelo próprio site
  assets/people fotos provisórias de banco (Unsplash) para o hero, o banner, as personas e as capas dos segmentos;
                substituir por fotos da Natcorp (créditos em CREDITS.md)
  hooks/        useMediaQuery, useScrolled, useIntroDone, useBrandGradientId, useSeo
  lib/          motion.ts (curvas e variantes), lenisStore.ts, leadSchema.ts, submitLead.ts, utils.ts
scripts/        generate-sitemap.mjs, export-presentation.mjs (PDF e PNG da apresentação, via Playwright)
  module-art/   kit.cjs (paleta, módulo, primitivas), icons.cjs (31 glifos), scenes/<slug>.cjs (31 cenas),
                build.cjs (gera brand/modulos em SVG e PNG via Playwright)
brand/
  modulos/      ícones e ilustrações dos 31 módulos (icones/ e ilustracoes/, em svg/ e png/), folhas de contato
                e LEIA-ME.md com as regras aplicadas
public/
  brand/        SVGs oficiais gerados (horizontal, vertical, símbolo; colorido, chapado, negativo)
  fonts/        Manrope woff2 (latin, latin-ext)
  favicon.svg / favicon.png / apple-touch-icon.png / icon-512.png / og-image.png / site.webmanifest
  sitemap.xml / robots.txt (gerados) · _redirects (SPA fallback)
```

## Identidade visual

Tokens do **Manual de Identidade Visual Natcorp v1.2** (setembro de 2026), definidos em `tailwind.config.js`
(`colors.brand`) e `src/index.css` (variáveis semânticas shadcn):

| Token | Cor | Uso |
| --- | --- | --- |
| Roxo Natcorp | `#511C76` | cor primária, botões, títulos de destaque |
| Azul Profundo | `#2C1A63` | fundos escuros, navegação de produto, rodapé |
| Rosa Natcorp | `#C95788` | acento, dados de destaque (nunca em texto corrido) |
| Ameixa | `#9A408A` | início do gradiente |
| Tinta / Grafite / Cinza | `#1B1238` / `#4A4460` / `#8E88A3` | texto principal / secundário / legendas |
| Névoa / Off-white | `#E9E5F1` / `#F4F2F7` | bordas / fundos de tela |

- **Gradiente**: linear 135°, Ameixa 0% → Roxo 50% → Azul Profundo 100% (`.bg-brand-gradient`). Apenas em fundos e
  no símbolo; nunca em texto pequeno nem em botões.
- **Símbolo**: 4 módulos (quadrado rotacionado 45°, raio 0,17x, junta 0,11x) construídos em `logo-paths.ts` a partir
  da especificação do manual. O wordmark usa os contornos da Manrope 640 com entreletras −2%.
- **Tipografia**: Manrope em toda a página; títulos com entreletras −2% (`tracking-brand`).
- **Grafismos**: contorno do símbolo em 1 px (`LogoOutline`) e trilha de módulos (`ModuleTrail`).
- **Ícones e ilustrações dos módulos**: `brand/modulos/` guarda, para cada um dos 31 módulos, um ícone de app
  (um módulo do símbolo em gradiente, com cada família de módulos em um trecho do gradiente da marca, e o glifo
  branco em traço fino na grade de 24, sem moldura nem acento) e uma ilustração plana na
  grade a 45° (cartões, avatares, gráficos e módulos, com o contorno do símbolo no canto). Tudo é gerado por código em
  `scripts/module-art/` (`node scripts/module-art/build.cjs`), em SVG e PNG.

## Sistema de movimento

- Curva da marca `cubic-bezier(0.22, 1, 0.36, 1)`; cenas com `cubic-bezier(0.65, 0, 0.35, 1)`.
- Abertura: os quatro losangos chegam girando e se encaixam, o raio rosa cresce do centro pelo X vazado,
  o símbolo desliza e o wordmark aparece ao lado; depois a cortina sobe (uma vez por sessão). A mesma peça
  (`LogoMotion`) e as irmãs do sistema, da NATI e da nuvem ficam em `/motion`, em fundo escuro e claro.
- Revelações por palavra com máscara (`SplitText`), blocos escalonados (`Stagger`), contadores, parallax leve,
  seção de módulos com navegação fixa que acompanha a rolagem, chat da NATI que troca por perfil, faixa contínua.
- Transição de cena entre rotas (`PageTransition`) e rolagem para âncoras entre páginas (`ScrollManager`).
- Cursor: botões magnéticos e foco de luz nos cartões apenas com `pointer: fine`.
- `prefers-reduced-motion`: sem abertura, sem Lenis, sem parallax/transform; faixas viram listas estáticas.

## Formulário de leads

O formulário da seção **Agende uma demonstração** envia um `POST` JSON para o endpoint configurado em variável de
ambiente. Sem configuração, opera em **modo demonstração**: o payload vai para o console do navegador e um toast
avisa. Copie `.env.example` para `.env` e defina:

- `VITE_LEAD_WEBHOOK_URL` — URL que recebe os leads (webhook de automação ou proxy serverless próprio).
- `VITE_LEAD_WEBHOOK_TOKEN` (opcional) — enviado como `Authorization: Bearer`.

Payload:

```json
{
  "nome": "…", "email": "…", "telefone": "…", "empresa": "…",
  "cargo": "…", "colaboradores": "…", "mensagem": "…",
  "origem": "landing-natcorp", "pagina": "https://…", "timestamp": "2026-01-01T12:00:00.000Z"
}
```

> Variáveis `VITE_*` são embutidas no bundle público. Nunca coloque um segredo real nelas; guarde-o em um
> webhook/proxy no servidor.

## SEO e acessibilidade

- `index.html` com título, descrição, Open Graph/Twitter, canonical, tema, manifest e JSON-LD (Organization,
  WebSite, SoftwareApplication). Cada rota atualiza título, descrição, canonical e Open Graph (`useSeo`) e injeta
  JSON-LD próprio: `FAQPage` (landing e módulos) e `BreadcrumbList` (módulos).
- Antes de publicar, ajuste o domínio em `src/content/site.ts` (`url`) e as URLs absolutas em `index.html`.
- Marcação semântica (landmarks, cabeçalhos por seção, `aria-labelledby`), link "Pular para o conteúdo", foco visível,
  tabs com `role="tablist"`, textos animados com `aria-label` completo, mockups com descrição alternativa.

## Deploy

Site estático: `npm run build` gera `dist/`. Publique em qualquer CDN (Vercel, Netlify, Cloudflare Pages, S3 +
CloudFront). Configure as variáveis `VITE_*` no provedor antes do build.

## Referência de aplicação (SaaS)

`brand/app-referencia/natcorp-app.html` mostra como uma aplicação Natcorp ficaria com a identidade do site: menu lateral, barra superior, início com painéis, colaboradores, cadastro, ponto, relatórios e NATI. Página única, abre direto no navegador. Detalhes em `brand/app-referencia/LEIA-ME.md`.

## Modernização das aplicações Oracle APEX 19.2

`brand/apex/` traz a máscara de CSS que aproxima as aplicações Natcorp em APEX 19.2 (Universal Theme 42, estilo Vita)
desse app de referência sem mudar templates, páginas ou JavaScript: `Natcorp_Style_Modern.css` (legível, 17 seções),
a versão minificada, a Manrope self-hosted (`Natcorp_Fonts.css` + `fonts/`), as capturas antes/depois de nove telas e
o guia de implantação e teste em `brand/apex/LEIA-ME.md`.
