# Natcorp — Documentação técnica de publicação

Guia para a equipe de hospedagem publicar o site **www.natcorp.com.br**.
Sem Docker, sem contêiner, sem runtime no servidor.

---

## 1. Resumo em uma página

| | |
| --- | --- |
| **O que é** | Site **100% estático**. HTML, CSS, JavaScript, fontes e imagens. |
| **Backend no servidor** | **Nenhum.** Não há PHP, Node, Python, banco de dados nem processo em execução. |
| **O que o servidor faz** | Serve arquivos e aplica as regras de reescrita das seções 5.1 a 5.4. |
| **Onde ficam os arquivos** | Uma pasta `dist/`, resultado do build. Basta copiá-la para a raiz do site. |
| **Peso aproximado** | Cerca de 40–60 MB (fontes, imagens, ilustrações de marca e dois PDFs). |
| **Domínio canônico** | **`https://www.natcorp.com.br`** (com `www`). O domínio sem `www` redireciona para ele. |

**Os dois pontos que exigem atenção**, e que não são óbvios num site estático comum:

1. O site é uma *Single Page Application*: **o servidor precisa devolver `index.html` para caminhos que não existem em disco** (seção 5.1). Sem isso tudo funciona ao navegar, mas dá 404 ao recarregar a página ou abrir um link direto.
2. **A pasta `/portais/` do servidor atual precisa ser migrada junto** (seção 5.4). Ela não sai do nosso build e não é WordPress: é o acesso dos clientes ao sistema, em uso todos os dias.

---

## 2. Requisitos do servidor

### 2.1 Para servir o site (obrigatório)

- Servidor web capaz de servir arquivos estáticos: **Apache, Nginx, LiteSpeed, IIS, Caddy** — qualquer um serve.
- **HTTPS** com certificado válido para `www.natcorp.com.br` **e** `natcorp.com.br`.
- Suporte a **reescrita de URL** (mod_rewrite no Apache, `try_files` no Nginx, URL Rewrite no IIS).
- Compressão **gzip** (ideal: **brotli**) para HTML, CSS, JS, SVG, JSON e XML.
- Capacidade de definir **cabeçalhos `Cache-Control`** por padrão de arquivo (seção 5.7).

### 2.2 Para compilar o site (só no Modelo B da seção 3)

- **Node.js 22 LTS** (mínimo absoluto: 20.19). O `npm` vem junto.
- Cerca de **2 GB de RAM** livres durante o build e **1,5 GB** de disco para as dependências.
- Acesso à internet para `registry.npmjs.org` no momento da instalação.

O build **não** precisa rodar no servidor de produção. Pode ser feito em qualquer máquina.

---

## 3. Como obter os arquivos — escolham um modelo

### Modelo A — Nós entregamos a pasta pronta (mais simples, recomendado)

Entregamos um `.zip` com o conteúdo já compilado. A equipe de hospedagem **não precisa instalar nada**: descompacta e publica.

```
natcorp-site-AAAA-MM-DD.zip
└── (conteúdo da pasta dist/ — index.html, assets/, fonts/, brand/, portais_beta/, …)
```

Vantagem: nenhum requisito de Node no servidor.
Contrapartida: cada atualização de conteúdo exige um novo `.zip` da nossa parte.

### Modelo B — Vocês compilam a partir do código

```bash
npm ci        # instala exatamente as versões travadas no lockfile
npm run build # compila; resultado em dist/
```

O que o `npm run build` faz, em ordem:

1. `scripts/generate-sitemap.mjs` → gera `sitemap.xml` e `robots.txt`;
2. `scripts/build-portais.mjs` → gera as páginas `portais_beta/<cliente>/index.html`;
3. `tsc -b` → verificação de tipos;
4. `vite build` → empacota tudo em `dist/`.

Antes do build, definir as variáveis da seção 7.

---

## 4. Publicação dos arquivos

1. Copiar **o conteúdo** de `dist/` (não a pasta em si) para a raiz do documento do site — `public_html/`, `htdocs/`, `/var/www/natcorp/` ou equivalente.
2. Preservar a estrutura de subpastas exatamente como está (`assets/`, `fonts/`, `brand/`, `portais_beta/`, `img/`…).
3. **Copiar a pasta `/portais/` do servidor atual** para o mesmo caminho, e nunca apagá-la ao publicar (seção 5.4).
4. Permissões: `644` para arquivos, `755` para pastas. Nada precisa ser gravável pelo servidor.
5. Em atualizações, substituir os arquivos da entrega. O site não grava dados no servidor, então nada precisa ser preservado entre versões — **exceto `/portais/`**, que vem do servidor atual (seção 5.4).

> **Sobre os nomes com hash.** Os arquivos em `assets/` têm nomes como `index-B7xK2p.js`. É intencional: a cada publicação o nome muda, então o cache antigo nunca é servido por engano. É o que permite o cache de 1 ano da seção 5.7.

---

## 5. Configuração do servidor web

Quatro regras obrigatórias (5.1 a 5.4) e três de qualidade (5.5 a 5.8).

### 5.1 SPA fallback — **obrigatório**

O site usa roteamento no cliente (React Router). Existe **um único `index.html`**; caminhos como `/modulos/folha-de-pagamento` ou `/segmentos/industria` **não existem como arquivo em disco**.

**Regra:** se o caminho pedido não corresponder a um arquivo ou pasta existente, devolver `/index.html` com **HTTP 200** (não 302, não 404).

> ⚠️ **A ordem importa.** O fallback só pode valer **depois** de tentar o arquivo real. Se a regra for aplicada antes, ela engole a pasta `/portais/` migrada do servidor atual, o `sitemap.xml`, o `robots.txt` e os PDFs. No Apache isso são as duas condições `!-f` / `!-d`; no Nginx, o `try_files $uri $uri/` antes do `/index.html`.

### 5.2 Domínio canônico e HTTPS — **obrigatório**

O canônico é **`https://www.natcorp.com.br`**. É esse endereço que está no `<link rel="canonical">`, no Open Graph, no JSON-LD e no `sitemap.xml`.

- **HTTP → HTTPS**, com 301.
- **`natcorp.com.br` → `www.natcorp.com.br`**, com 301, preservando o caminho.
- **HSTS** depois de confirmar que todo o site responde em HTTPS.

### 5.3 Redirecionamentos 301 dos endereços que deixam de existir — **obrigatório**

O site novo substitui um WordPress que **sai do ar por completo** — não fica no ar em lugar nenhum, nem em subdomínio. Estas regras existem por causa disso, não apesar disso.

Os endereços da tabela estão indexados no Google, aparecem em links de terceiros e estão salvos nos favoritos e em e-mails de clientes. O site novo não tem esses caminhos: onde havia `/fale-conosco`, agora há `/contato`. Sem as regras, cada um desses links vira 404 no dia da virada.

Com o **301**, o servidor do site novo responde "este endereço mudou de lugar" e entrega a página certa: o visitante nem percebe, e o Google transfere o ranqueamento do endereço antigo para o novo em vez de descartá-lo. É configuração do servidor novo — **não depende do WordPress estar rodando**, e pode ser aplicada com ele já desligado.

Todos **permanentes (301)** — não 302, que faria o Google manter o endereço antigo no índice esperando ele voltar. Válidos **com e sem barra final**:

| De | Para |
| --- | --- |
| `/solucao-de-rh` | `/modulos` |
| `/sistema-de-rh-hcm` | `/modulos` |
| `/sistema-de-gestao-de-rh-completo` | `/modulos` |
| `/sistema-de-rh-completo-2-0` | `/modulos` |
| `/folha-de-pagamento` | `/modulos/folha-de-pagamento` |
| `/sobre-nos` | `/sobre` |
| `/servicos` | `/sobre#servicos` |
| `/fale-conosco` | `/contato` |
| `/fale-conosco-2` | `/contato` |

> **`/blog/` não entra na lista.** Não há blog hoje, e nenhum endereço `/blog/*` precisa ser redirecionado. Se um blog for publicado no futuro, tratamos como um caso novo.

### 5.4 A pasta `/portais/` tem de ser migrada junto — **obrigatório**

Este é o ponto mais fácil de errar na migração, e o único que pode tirar clientes do ar.

**A situação.** `www.natcorp.com.br/portais/<cliente>/` é a página por onde colaboradores, gestores e candidatos entram no sistema Natcorp, todos os dias. Ela **está no ar hoje** e **continua sendo o endereço em uso** depois da publicação do site novo.

Ela **não é WordPress** e **não faz parte do build** descrito na seção 3: é uma pasta de HTML estático que vive no servidor atual, ao lado do WordPress. Quando o WordPress for desligado, ela **não pode ir junto**.

**O que fazer:**

- **Copiar a pasta `/portais/` do servidor atual** para o servidor novo, no mesmo caminho e no mesmo domínio, com o conteúdo intacto.
- Publicá-la **junto** com o site novo, não depois — qualquer janela sem ela é uma janela com os clientes sem acesso.
- **Não** apagá-la, movê-la nem sobrescrevê-la ao publicar atualizações do site.
- Confirmar, depois da virada, que `https://www.natcorp.com.br/portais/natcorp/` abre a página de acesso, e não a home do site novo.

> Se a migração for feita por cópia integral do servidor atual, isso acontece sozinho. Se for feita publicando só a entrega do site novo, **esta pasta precisa ser copiada à parte** — é o caso em que ela some sem ninguém notar até um cliente reclamar.

**Por que isso funciona sem regra extra.** Com o SPA fallback escrito corretamente (5.1), o servidor tenta o arquivo real primeiro. Como `/portais/natcorp/` é uma **pasta de verdade com `index.html` dentro**, ela é servida diretamente. O fallback nem chega a ser consultado.

**Duas ressalvas:**

1. **Barra final.** `/portais/natcorp/` funciona porque o servidor resolve `pasta/` → `pasta/index.html`. Não criem regra global que **remova** ou **force** barra final — qualquer uma das duas quebra este caso. Basta o `DirectoryIndex index.html` / `index index.html` padrão.
2. **`/portais` sozinho é do site novo.** Sem nada depois, `/portais` é uma **página de marketing** do site novo ("Portais e autoatendimento"), que está no menu e no sitemap. Ou seja: `/portais` → site novo; `/portais/<qualquer-coisa>/` → pasta migrada do servidor atual. A regra 5.1 já separa os dois corretamente, desde que **não exista** uma regra de proxy ou redirecionamento capturando o prefixo `/portais/*` inteiro.

**E o `/portais_beta/`?** O site novo traz a sua própria versão dessas páginas, em `/portais_beta/<cliente>/`. É uma prévia para aprovação interna: sai com `noindex`, está fora do `sitemap.xml` e **não deve ser divulgada**. Não requer configuração nenhuma — é arquivo estático comum. Quando decidirmos fazer a virada, avisaremos e o conteúdo passa a `/portais/`.

### 5.5 Compressão

Ativar gzip e, se disponível, brotli para: `text/html`, `text/css`, `application/javascript`, `image/svg+xml`, `application/json`, `application/xml`.

**Não comprimir** `.woff2`, `.png`, `.jpg`, `.webp` e `.pdf` — já são formatos comprimidos; recomprimir só gasta CPU.

### 5.6 Tipos MIME

| Extensão | Content-Type |
| --- | --- |
| `.js`, `.mjs` | `text/javascript` |
| `.css` | `text/css` |
| `.woff2` | `font/woff2` |
| `.svg` | `image/svg+xml` |
| `.webmanifest` | `application/manifest+json` |
| `.json` | `application/json` |
| `.xml` | `application/xml` |
| `.pdf` | `application/pdf` |

Um `.woff2` servido com o tipo errado faz o navegador recusar a fonte e o site aparece com a tipografia de fallback. O `.webmanifest` é o que mais costuma faltar.

### 5.7 Cache

| Caminho | `Cache-Control` | Por quê |
| --- | --- | --- |
| `/assets/*` | `public, max-age=31536000, immutable` | Nome com hash: muda a cada publicação. |
| `/fonts/*`, `/brand/*`, `/*.png`, `/*.svg`, `/*.jpg`, `/*.webp` | `public, max-age=2592000` (30 dias) | Estáveis, mas o nome não muda. |
| `/*.pdf` | `public, max-age=86400` (1 dia) | Apresentações comerciais, atualizadas de vez em quando. |
| `/index.html` e demais `.html` | `no-cache` | Precisam refletir a publicação nova imediatamente. |
| `/sitemap.xml`, `/robots.txt`, `/site.webmanifest` | `public, max-age=3600` (1 hora) | — |

> `no-cache` **não** significa "não guardar". Significa "guardar, mas revalidar com o servidor antes de usar". É exatamente o que se quer no `index.html`: ele é pequeno e é ele que aponta para os arquivos com hash da versão nova.

### 5.8 Cabeçalhos de segurança (recomendado)

```
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Content-Type-Options: nosniff
Referrer-Policy: strict-origin-when-cross-origin
X-Frame-Options: SAMEORIGIN
Permissions-Policy: geolocation=(), microphone=(), camera=()
```

**Content-Security-Policy (opcional).** Se a política de vocês exigir CSP, esta é a mínima que mantém o site funcionando. Pedimos que seja **testada em homologação antes de produção** — uma CSP apertada demais quebra o formulário e os vídeos em silêncio:

```
Content-Security-Policy:
  default-src 'self';
  script-src 'self' 'unsafe-inline' blob: https://www.googletagmanager.com https://connect.facebook.net;
  style-src 'self' 'unsafe-inline' https://fonts.googleapis.com;
  font-src 'self' data: https://fonts.gstatic.com;
  img-src 'self' data: blob: https:;
  connect-src 'self' https://pwvybfbfoikaahqplned.supabase.co https://www.googletagmanager.com https://*.google-analytics.com https://*.analytics.google.com https://connect.facebook.net;
  frame-src https://www.youtube-nocookie.com;
  worker-src 'self' blob:;
  object-src 'none'; base-uri 'self'; form-action 'self'
```

O `'unsafe-inline'` em `script-src` é necessário: o `index.html` traz um script inline (controle de posição de rolagem) e o bloco JSON-LD de SEO.

---

## 6. Configurações prontas por servidor

### 6.1 Apache — `.htaccess` na raiz

```apache
# ── HTTPS e domínio canônico (www) ──────────────────────────────────────
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://www.natcorp.com.br/$1 [R=301,L]
RewriteCond %{HTTP_HOST} ^natcorp\.com\.br$ [NC]
RewriteRule ^(.*)$ https://www.natcorp.com.br/$1 [R=301,L]

# ── Redirecionamentos do site anterior (WordPress) ──────────────────────
RewriteRule ^solucao-de-rh/?$                    /modulos [R=301,L]
RewriteRule ^sistema-de-rh-hcm/?$                /modulos [R=301,L]
RewriteRule ^sistema-de-gestao-de-rh-completo/?$ /modulos [R=301,L]
RewriteRule ^sistema-de-rh-completo-2-0/?$       /modulos [R=301,L]
RewriteRule ^folha-de-pagamento/?$               /modulos/folha-de-pagamento [R=301,L]
RewriteRule ^sobre-nos/?$                        /sobre [R=301,L]
RewriteRule ^servicos/?$                         /sobre#servicos [R=301,L]
RewriteRule ^fale-conosco/?$                     /contato [R=301,L]
RewriteRule ^fale-conosco-2/?$                   /contato [R=301,L]

# ── SPA fallback: SÓ quando não existe arquivo nem pasta ────────────────
#    As duas condições abaixo são o que preservam a pasta /portais/<cliente>/ migrada do servidor atual.
DirectoryIndex index.html
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^ /index.html [L]

# ── Tipos MIME ─────────────────────────────────────────────────────────
AddType font/woff2 .woff2
AddType application/manifest+json .webmanifest
AddType image/svg+xml .svg

# ── Compressão ─────────────────────────────────────────────────────────
<IfModule mod_deflate.c>
  AddOutputFilterByType DEFLATE text/html text/css text/javascript \
    application/javascript image/svg+xml application/json application/xml
</IfModule>

# ── Cache e segurança ──────────────────────────────────────────────────
<IfModule mod_headers.c>
  <FilesMatch "\.(js|css|woff2)$">
    Header set Cache-Control "public, max-age=31536000, immutable"
  </FilesMatch>
  <FilesMatch "\.(png|jpe?g|webp|svg|ico)$">
    Header set Cache-Control "public, max-age=2592000"
  </FilesMatch>
  <FilesMatch "\.(html|xml|txt|webmanifest)$">
    Header set Cache-Control "no-cache"
  </FilesMatch>
  Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
  Header always set X-Content-Type-Options "nosniff"
  Header always set Referrer-Policy "strict-origin-when-cross-origin"
  Header always set X-Frame-Options "SAMEORIGIN"
</IfModule>
```

> O cache de 1 ano em `.js` e `.css` vale porque **no nosso build todos eles têm hash no nome**, e as fontes nunca mudam de nome. Se um dia isso deixar de ser verdade, o bloco precisa casar só com `/assets/`.

### 6.2 Nginx

```nginx
server {
    listen 443 ssl http2;
    server_name www.natcorp.com.br;
    root /var/www/natcorp;
    index index.html;

    # ── Redirecionamentos do site anterior ─────────────────────────────
    location ~ ^/(solucao-de-rh|sistema-de-rh-hcm|sistema-de-gestao-de-rh-completo|sistema-de-rh-completo-2-0)/?$ {
        return 301 /modulos;
    }
    location ~ ^/folha-de-pagamento/?$ { return 301 /modulos/folha-de-pagamento; }
    location ~ ^/sobre-nos/?$          { return 301 /sobre; }
    location ~ ^/servicos/?$           { return 301 /sobre#servicos; }
    location ~ ^/fale-conosco(-2)?/?$  { return 301 /contato; }

    # ── Cache ──────────────────────────────────────────────────────────
    location /assets/ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
    location ~* \.(woff2|png|jpe?g|webp|svg|ico)$ {
        expires 30d;
        add_header Cache-Control "public";
    }
    location ~* \.(html|xml|txt|webmanifest)$ {
        add_header Cache-Control "no-cache";
    }

    # ── SPA fallback: arquivo real, depois pasta, e só então index.html ─
    #    O "$uri/" é o que faz a pasta /portais/<cliente>/, migrada do servidor atual, continuar servida.
    location / {
        try_files $uri $uri/ /index.html;
    }

    # ── Compressão ─────────────────────────────────────────────────────
    gzip on;
    gzip_types text/css text/javascript application/javascript image/svg+xml application/json application/xml;
    gzip_min_length 1024;

    # ── Segurança ──────────────────────────────────────────────────────
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
}

# HTTP → HTTPS e domínio sem www → www
server {
    listen 80;
    server_name natcorp.com.br www.natcorp.com.br;
    return 301 https://www.natcorp.com.br$request_uri;
}
server {
    listen 443 ssl http2;
    server_name natcorp.com.br;
    return 301 https://www.natcorp.com.br$request_uri;
}
```

> **`try_files $uri $uri/ /index.html`** resolve tudo: tenta o arquivo, depois a pasta (que serve o `index.html` dela — é assim que `/portais/natcorp/` continua funcionando), e só então cai no `index.html` da raiz.

### 6.3 IIS — `web.config` na raiz

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <system.webServer>
    <staticContent>
      <remove fileExtension=".woff2" />
      <mimeMap fileExtension=".woff2" mimeType="font/woff2" />
      <remove fileExtension=".webmanifest" />
      <mimeMap fileExtension=".webmanifest" mimeType="application/manifest+json" />
    </staticContent>

    <httpProtocol>
      <customHeaders>
        <add name="X-Content-Type-Options" value="nosniff" />
        <add name="Referrer-Policy" value="strict-origin-when-cross-origin" />
      </customHeaders>
    </httpProtocol>

    <rewrite>
      <rules>
        <rule name="Canonico: www" stopProcessing="true">
          <match url="(.*)" />
          <conditions>
            <add input="{HTTP_HOST}" pattern="^natcorp\.com\.br$" />
          </conditions>
          <action type="Redirect" url="https://www.natcorp.com.br/{R:1}" redirectType="Permanent" />
        </rule>

        <rule name="WP: modulos" stopProcessing="true">
          <match url="^(solucao-de-rh|sistema-de-rh-hcm|sistema-de-gestao-de-rh-completo|sistema-de-rh-completo-2-0)/?$" />
          <action type="Redirect" url="/modulos" redirectType="Permanent" />
        </rule>
        <rule name="WP: folha" stopProcessing="true">
          <match url="^folha-de-pagamento/?$" />
          <action type="Redirect" url="/modulos/folha-de-pagamento" redirectType="Permanent" />
        </rule>
        <rule name="WP: sobre" stopProcessing="true">
          <match url="^sobre-nos/?$" />
          <action type="Redirect" url="/sobre" redirectType="Permanent" />
        </rule>
        <rule name="WP: servicos" stopProcessing="true">
          <match url="^servicos/?$" />
          <action type="Redirect" url="/sobre#servicos" redirectType="Permanent" />
        </rule>
        <rule name="WP: contato" stopProcessing="true">
          <match url="^fale-conosco(-2)?/?$" />
          <action type="Redirect" url="/contato" redirectType="Permanent" />
        </rule>

        <!-- SPA fallback: as duas condições preservam a pasta /portais/<cliente>/ migrada do servidor atual -->
        <rule name="SPA fallback" stopProcessing="true">
          <match url=".*" />
          <conditions logicalGrouping="MatchAll">
            <add input="{REQUEST_FILENAME}" matchType="IsFile"      negate="true" />
            <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
          </conditions>
          <action type="Rewrite" url="/index.html" />
        </rule>
      </rules>
    </rewrite>
  </system.webServer>
</configuration>
```

---

## 7. Variáveis de ambiente

> **Só importam para quem roda o build.** Elas são **embutidas no JavaScript** no momento da compilação — o servidor de hospedagem não as lê em tempo de execução. Se vocês receberem a pasta pronta (Modelo A), **podem pular esta seção inteira**.

| Variável | Obrigatória | O que faz |
| --- | --- | --- |
| `VITE_SITE_URL` | Recomendada | Domínio canônico no `sitemap.xml`, no `robots.txt` e nas páginas de portais. Padrão: `https://www.natcorp.com.br`. |
| `VITE_GTM_ID` | Não | ID do Google Tag Manager. **Sem ID, nada é carregado** — é assim que homologação não polui os dados de produção. |
| `VITE_META_PIXEL_ID` | Não | ID do Meta Pixel. Mesma regra. |
| `VITE_LEAD_WEBHOOK_URL` | Não | Sobrescreve o endpoint do formulário. **Deixar vazia** — o padrão já aponta para o CRM correto. |
| `VITE_ROUTER` | Não | `hash` só para prévias hospedadas fora da raiz de um domínio. **Não usar em produção.** |

⚠️ **Nunca coloquem segredo em variável `VITE_*`.** Todas vão para dentro do bundle público e ficam legíveis para qualquer visitante.

**Tags de marketing e LGPD:** GTM e Meta Pixel só são carregados **depois do aceite** na barra de cookies — a requisição em si já identificaria o visitante, então ela nem é feita antes. É comportamento do código; nada a configurar no servidor.

---

## 8. Conexões de saída (para regras de firewall e CSP)

O site é estático, mas o **navegador do visitante** faz chamadas a estes domínios. Se houver proxy, WAF ou CSP corporativa no caminho, precisam estar liberados:

| Domínio | Quando | Se bloquear |
| --- | --- | --- |
| `pwvybfbfoikaahqplned.supabase.co` | Envio do formulário "Agende uma demonstração" | **Leads deixam de chegar ao comercial.** |
| `www.youtube-nocookie.com` | Só depois do clique em um vídeo | Vídeos não abrem. |
| `fonts.googleapis.com` / `fonts.gstatic.com` | Páginas de portais (`/portais/` e `/portais_beta/`) | Portais aparecem com fonte de fallback. |
| `www.googletagmanager.com`, `*.google-analytics.com` | Só com `VITE_GTM_ID` **e** cookies aceitos | Sem medição. |
| `connect.facebook.net` | Só com `VITE_META_PIXEL_ID` **e** cookies aceitos | Sem medição. |
| `api.github.com` | Apenas na página administrativa `/admin/portais`, no navegador do administrador | Administrador não consegue salvar o cadastro de portais. |

A fonte **Manrope** do site principal é servida pelo próprio domínio (`/fonts/`). Só as páginas de portais usam o Google Fonts.

---

## 9. Checklist de validação depois de publicar

Percorrer na ordem. Os cinco primeiros pegam quase todos os erros de configuração.

**As regras obrigatórias**

- [ ] `https://www.natcorp.com.br/` abre a home com a animação de abertura.
- [ ] **Link direto:** colar `https://www.natcorp.com.br/modulos/folha-de-pagamento` na barra de endereços (não navegar até lá) → abre a página, **não** um 404. *Falha aqui = SPA fallback (5.1) inativo.*
- [ ] **Recarregar (F5)** numa página interna qualquer → continua na mesma página.
- [ ] **`https://www.natcorp.com.br/portais/natcorp/`** (com barra final) abre a **página de acesso aos portais migrada do servidor atual** — **não** a home do site novo. *Falha aqui = o fallback está engolindo os arquivos reais (5.1/5.4).*
- [ ] **`https://www.natcorp.com.br/portais`** (sem barra, sem cliente) abre a **página de marketing "Portais e autoatendimento"** do site novo.
- [ ] `https://natcorp.com.br/sobre` (sem `www`) redireciona com **301** para `https://www.natcorp.com.br/sobre`.
- [ ] `https://www.natcorp.com.br/sobre-nos` redireciona com **301** para `/sobre` (verificar o código, não só o destino).

**Conteúdo e qualidade**

- [ ] `/sitemap.xml` devolve XML com URLs em `https://www.natcorp.com.br`.
- [ ] `/robots.txt` devolve o texto e aponta para o sitemap correto.
- [ ] **Tipografia:** a página usa Manrope (títulos arredondados e compactos), não Arial. *Falha aqui = MIME do `.woff2` (5.6).*
- [ ] **Console do navegador (F12):** nenhum erro vermelho ao carregar a home.
- [ ] **Formulário:** preencher "Agende uma demonstração" em `/contato` e enviar → mensagem de sucesso, e o lead chega ao comercial. *Confirmar com o time comercial, não só pela tela.*
- [ ] **Vídeos:** em `/sobre#videos`, clicar num vídeo → o player abre.
- [ ] **Rodapé:** o link "Acesso aos portais (clientes)" leva à página de acesso migrada, funcionando.
- [ ] **Página inexistente:** `/qualquer-coisa` mostra a página 404 do site (com a identidade da Natcorp), não a do servidor.
- [ ] **HTTP → HTTPS** redireciona com 301.
- [ ] **Celular:** abrir a home num aparelho real; menu e rolagem funcionam.

---

## 10. Anexo — mapa de rotas

Nenhuma destas existe como arquivo em disco. Todas dependem da regra 5.1.

| Rota | Página |
| --- | --- |
| `/` | Home institucional |
| `/sistema` | Visão geral do sistema |
| `/modulos` · `/modulos/:slug` | Índice e as 31 páginas de módulo |
| `/segmentos` · `/segmentos/:slug` | Segmentos atendidos (9 páginas) |
| `/estruturas` · `/estruturas/:slug` | "Como é a sua estrutura?" (5 páginas) |
| `/grupos` | Redireciona (no cliente) para `/estruturas` |
| `/seguranca` | Segurança e infraestrutura |
| `/sobre` | Sobre a Natcorp |
| `/contato` | Contato e formulário |
| `/portais` | **Página de marketing** "Portais e autoatendimento" |
| `/perguntas-frequentes` | FAQ completo |
| `/modelo-comercial` | Modelo comercial |
| `/jornada-da-contratacao` | Jornada do colaborador |
| `/apresentacao` · `/apresentacao/reduzida` | Apresentação comercial em tela cheia |
| `/portais_beta/:cliente` | Prévia da porta de entrada dos portais (`noindex`, não divulgar) |
| `/admin/portais` | Administração do cadastro de portais |
| qualquer outra | Página 404 do site |

**Arquivos reais em disco** (existem e devem ser servidos diretamente, antes do fallback):

```
/index.html
/assets/…                            JS e CSS com hash no nome
/fonts/manrope-*.woff2               fonte do site
/brand/…                             logotipos e ilustrações SVG
/portais_beta/<cliente>/index.html   prévia das páginas de acesso (noindex)
/portais_beta/<cliente>/img/*.svg    ilustrações dessa prévia
/sitemap.xml  /robots.txt  /site.webmanifest
/favicon.svg  /favicon.png  /apple-touch-icon.png  /icon-512.png  /og-image.png
/natcorp-apresentacao.pdf  /natcorp-apresentacao-reduzida.pdf
```

**Fora do nosso build, e que precisa ser migrado do servidor atual (seção 5.4):**

```
/portais/<cliente>/…                 páginas de acesso dos clientes, EM USO — migradas do servidor atual
```

---

## 11. Contato técnico

Dúvidas sobre este documento, sobre o build ou sobre o comportamento do site:

**Natcorp** · contato@natcorp.com.br · +55 11 5096-0711
