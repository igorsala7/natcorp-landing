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
| `/modulos/:slug` | Página dedicada de cada módulo (30 páginas) |
| qualquer outra | Página 404 |

O roteamento é feito no cliente com [React Router](https://reactrouter.com) (`BrowserRouter`). Por isso o servidor
precisa devolver `index.html` para qualquer caminho: já estão incluídos `vercel.json` (Vercel) e `public/_redirects`
(Netlify/Cloudflare Pages). Em outros provedores, configure o "SPA fallback" equivalente.

`npm run build` roda antes `scripts/generate-sitemap.mjs`, que gera `public/sitemap.xml` e `public/robots.txt`
a partir de `src/content/modulePages/registry.json` (use `VITE_SITE_URL` para o domínio final).

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
  pages/        LandingPage, ModulesIndexPage, ModulePage (template data-driven), NotFoundPage
  components/
    brand/      Logo.tsx (símbolo + wordmark em vetor), logo-paths.ts (geometria gerada do manual)
    motion/     Intro (abertura), SmoothScroll, ScrollManager (rotas + âncoras), PageTransition,
                Reveal/Stagger, SplitText, Counter, Marquee, Magnetic, SpotlightCard, Parallax, ScrollProgress
    mockups/    Telas do produto construídas em código (dashboard, NatPonto, NATI, fluxos)
    sections/   Navbar (mega-menu de módulos), Hero, ProofStrip, Problem, Platform, Modules, Journey, Nati,
                Portals, Security, Why, Personas, FAQ, FaqAccordion, CTA (+ LeadForm lazy), Footer
    seo/        JsonLd, Breadcrumb
    ui/         primitivos shadcn/ui
  content/      textos e dados (módulos da landing, FAQ, personas, navegação) e modulePages/ (páginas de módulo)
  hooks/        useMediaQuery, useScrolled, useIntroDone, useBrandGradientId, useSeo
  lib/          motion.ts (curvas e variantes), lenisStore.ts, leadSchema.ts, submitLead.ts, utils.ts
scripts/        generate-sitemap.mjs
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

## Sistema de movimento

- Curva da marca `cubic-bezier(0.22, 1, 0.36, 1)`; cenas com `cubic-bezier(0.65, 0, 0.35, 1)`.
- Abertura: os módulos do símbolo se encaixam, o wordmark surge e a cortina sobe (uma vez por sessão).
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
