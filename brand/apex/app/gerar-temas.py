"""Gera os TEMAS DE COR do sistema (o ícone de paleta do menu superior).

    python3 gerar-temas.py

Escreve:
  · Natcorp_Temas.src.css  → entra no Natcorp_Style_Min.css pelo gerar-app.mjs (folha geral, como
                             Natcorp_Menu e Natcorp_Paginas): as cores de cada tema, as 5 superfícies
                             e a janela "Cores do sistema";
  · ../login/Natcorp_Temas.js  (de Natcorp_Temas.src.js, com a lista de temas no lugar de /*TEMAS*/).

COMO AS CORES SÃO FEITAS (pedido de 01/10: "se tiver um tema vermelho, o vermelho precisa estar no
mesmo tom do círculo cromático do roxo"): as quatro cores da marca formam um arco no círculo —
Azul #2C1A63 (288°), Roxo #511C76 (307°), Ameixa #9A408A (335°), Rosa #C95788 (356°), cada uma
mais clara que a anterior. Em OKLCH (claridade como o olho percebe), cada tema GIRA o arco inteiro
para outra posição do círculo e mantém a claridade e a saturação de cada cor: o Rubi tem o mesmo
peso do roxo; o rosa da linha das regiões vira, no Rubi, um âmbar na mesma claridade do rosa.
Fora da faixa de cores da tela, só a saturação cede (nunca a claridade). Três temas são
combinações da própria marca (Ameixa, Noite) e um é neutro com o rosa da marca (Grafite & Rosa).

Superfícies (só elas mudam): menu superior, menu lateral, botões principais (e o contorno/texto
dos secundários), o ícone do topo das regiões e a linha sob o título das regiões. O Padrão
Natcorp não põe classe nenhuma: é exatamente o que o sistema já é.
"""
import json
import os

from oklch import contraste, hex2oklch, oklch2hex

AQUI = os.path.dirname(os.path.abspath(__file__))
MARCA = {'azul': '#2C1A63', 'roxo': '#511C76', 'ameixa': '#9A408A', 'rosa': '#C95788', 'claro': '#E4A9C4', 'brilho': '#F3C9DA'}
B = {k: hex2oklch(v) for k, v in MARCA.items()}
H_ROXO = B['roxo'][2]


def girar(alvo):
    """o arco da marca inteiro, com o roxo no ângulo 'alvo' (OKLCH). O giro vai junto: os OUTROS
    roxos e rosas escritos nas páginas giram o mesmo tanto (tematizar.py, cor relativa do CSS)"""
    d = alvo - H_ROXO
    p = {k: oklch2hex(L, C, (H + d) % 360) for k, (L, C, H) in B.items()}
    p['giro'] = round(d, 1)
    return p


def cinza(hexa, c):
    L, _, H = hex2oklch(hexa)
    return oklch2hex(L, c, H)


TEMAS = [
    # id do tema (fica na classe nc-theme-<id>), nome, descrição, paleta
    ('purple', 'Padrão Natcorp', 'As cores da marca: azul profundo, roxo e rosa.', dict(MARCA)),
    ('nc2-ameixa', 'Ameixa Natcorp', 'A marca com a ameixa na frente, mais quente.',
     {'azul': '#511C76', 'roxo': oklch2hex(0.43, 0.15, 322), 'ameixa': '#9A408A', 'rosa': '#C95788', 'claro': '#E4A9C4', 'brilho': '#F3C9DA'}),
    ('nc2-noite', 'Noite Natcorp', 'A marca com o azul profundo na frente, mais sóbria.',
     {'azul': oklch2hex(0.235, 0.10, B['azul'][2]), 'roxo': '#2C1A63', 'ameixa': '#511C76', 'rosa': '#C95788', 'claro': '#E4A9C4', 'brilho': '#F3C9DA'}),
    ('nc2-fucsia', 'Fúcsia', 'Magenta e framboesa, com coral nos detalhes.', girar(345)),
    ('nc2-rubi', 'Rubi', 'Vermelho-vinho, com dourado nos detalhes.', girar(15)),
    # pedido de 01/10: "um tema baseado em #FF0000". O #FF0000 tem a claridade do Rosa da marca
    # (0,63) e entra EXATO no papel de destaque (linha das regiões, brilhos, losangos); menus e
    # botões no mesmo vermelho com a claridade da marca (texto branco 11,8:1 — sobre o #FF0000
    # seria 4,0:1). Os roxos das páginas giram para a família do vermelho.
    ('nc2-vermelho', 'Vermelho', 'Vermelho puro nos detalhes, vinho profundo no menu e nos botões.',
     {'azul': oklch2hex(0.292, 0.121, 21.2), 'roxo': oklch2hex(0.357, 0.146, 27.2), 'ameixa': oklch2hex(0.518, 0.20, 29.2),
      'rosa': '#FF0000', 'claro': oklch2hex(0.798, 0.077, 25.2), 'brilho': oklch2hex(0.87, 0.055, 25.2), 'giro': -300}),
    ('nc2-terracota', 'Terracota', 'Telha e ferrugem, com mostarda nos detalhes.', girar(42)),
    ('nc2-ambar', 'Âmbar', 'Mel queimado e ouro velho, com oliva nos detalhes.', girar(72)),
    ('nc2-oliva', 'Oliva', 'Verde-oliva e musgo, com verde-água nos detalhes.', girar(112)),
    ('nc2-esmeralda', 'Esmeralda', 'Verde profundo, com turquesa nos detalhes.', girar(150)),
    ('nc2-turquesa', 'Turquesa', 'Verde-água escuro, com azul-céu nos detalhes.', girar(182)),
    ('nc2-petroleo', 'Petróleo', 'Azul-petróleo, com azul vivo nos detalhes.', girar(208)),
    ('nc2-oceano', 'Oceano', 'Azul-marinho, com lavanda nos detalhes.', girar(236)),
    ('nc2-anil', 'Anil', 'Azul-violeta, com orquídea nos detalhes.', girar(266)),
    ('nc2-grafite', 'Grafite & Rosa', 'Cinza-grafite neutro, com o rosa da marca nos detalhes.',
     {'azul': cinza('#2C1A63', 0.018), 'roxo': cinza('#511C76', 0.022), 'ameixa': cinza('#9A408A', 0.03), 'rosa': '#C95788', 'claro': '#E4A9C4', 'brilho': '#F3C9DA', 'croma': 0.15}),
]


def rgb(h):
    return '%d, %d, %d' % tuple(int(h[i:i + 2], 16) for i in (1, 3, 5))


# conferência: texto branco nos botões/menus e a linha sobre o branco
for tid, nome, _, p in TEMAS:
    cr, ca = contraste(p['roxo'], '#FFFFFF'), contraste(p['azul'], '#FFFFFF')
    assert cr >= 4.5 and ca >= 4.5, (tid, cr, ca)

# ---------- o CSS ----------
classes = [t[0] for t in TEMAS if t[0] != 'purple']
ALGUM = 'html:is(' + ', '.join('.nc-theme-' + c for c in classes) + ')'
CORPO = ALGUM + ' body:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):not(#nc-t1)'

css = ['''/* =====================================================================
   Natcorp_Temas — os TEMAS DE COR do sistema. GERADO por gerar-temas.py: não edite à mão.
   Cada tema é uma classe no <html> (nc-theme-<id>) posta pelo Natcorp_Temas.js e repassada
   aos iframes e janelas pelo Natcorp_Allow_Unload_Iframes.js (mesma chave e mesmo formato do
   seletor antigo). Padrão Natcorp = sem classe. As cores: o arco da marca girado no círculo
   cromático (OKLCH), mesma claridade e saturação — ver gerar-temas.py.
   ===================================================================== */
''']
for tid, nome, _, p in TEMAS:
    if tid == 'purple':
        continue
    css.append(f'''/* {nome} */
html.nc-theme-{tid} {{
  --nc-azul: {p['azul']}; --nc-roxo: {p['roxo']}; --nc-roxo-hover: {p['azul']};
  --nc-ameixa: {p['ameixa']}; --nc-rosa: {p['rosa']}; --nc-rosa-claro: {p['claro']};
  --nc-t-azul-rgb: {rgb(p['azul'])}; --nc-t-roxo-rgb: {rgb(p['roxo'])}; --nc-t-rosa-rgb: {rgb(p['rosa'])}; --nc-t-ameixa-rgb: {rgb(p['ameixa'])};
  --nc-t-giro: {p.get('giro', 0)}; --nc-t-croma: {p.get('croma', 1)};
  --nc-primary: {p['roxo']}; --nc-primary-rgb: {rgb(p['roxo'])}; --nc-primary-deep: {p['azul']};
  --nc-primary-glow: {p['ameixa']}; --nc-primary-glow-rgb: {rgb(p['ameixa'])};
  --nc-icone-fundo: linear-gradient({p['roxo']}, transparent), linear-gradient(to left top, {p['rosa']}, transparent), linear-gradient(to right bottom, {p['azul']}, transparent);
}}
''')

css.append(f'''
/* ---------- as superfícies, só com um tema escolhido ---------- */
/* menu superior: Azul → Roxo do tema, com o brilho do destaque à direita */
{CORPO} .t-Header {{
  background-color: var(--nc-azul);
  background-image:
    radial-gradient(38% 260% at 88% 0%, rgba(var(--nc-t-rosa-rgb), .38), transparent 70%),
    radial-gradient(30% 220% at 45% 100%, rgba(var(--nc-t-roxo-rgb), .55), transparent 70%),
    linear-gradient(90deg, var(--nc-azul) 0%, var(--nc-roxo) 100%);
  box-shadow: 0 1px 0 rgba(255, 255, 255, .07), 0 10px 28px -18px rgba(var(--nc-t-azul-rgb), .8);
}}

/* menu lateral: as MESMAS cinco camadas do Padrão — o logo no pé, o painel animado (rede de
   pontos e losangos com a luz correndo), os dois brilhos e o degradê — nas cores do tema.
   O painel tem as cores desenhadas dentro do SVG: o Natcorp_Temas.js o recolore para o tema
   e o entrega em --nc-t-painel (uma cópia só, no .js; 13 cópias aqui pesariam ~250 KB a mais
   numa folha que toda página baixa sem cache). Sem o .js, a camada fica vazia e o resto vale. */
{CORPO} .t-Body-nav {{
  background-color: var(--nc-azul);
  background-image:
    @@LOGO_BRANCO@@,
    var(--nc-t-painel, none),
    radial-gradient(90% 40% at 0% 0%, rgba(var(--nc-t-rosa-rgb), .28), transparent 70%),
    radial-gradient(120% 45% at 100% 100%, rgba(var(--nc-t-rosa-rgb), .22), transparent 70%),
    linear-gradient(180deg, var(--nc-azul) 0%, var(--nc-roxo) 100%);
  background-size: 104px auto, cover, auto, auto, auto;
  background-position: left 24px bottom 24px, center bottom, 0 0, 0 0, 0 0;
  background-repeat: no-repeat;
}}

{ALGUM} body.js-navCollapsed:is(.t-PageBody:not(.t-PageBody--login), .t-Dialog-page):not(#nc-a1):not(#nc-a2):not(#nc-t1) .t-Body-nav {{
  background-size: 0 0, cover, auto, auto, auto;
}}

@media (prefers-reduced-motion: reduce) {{
  {CORPO} .t-Body-nav {{
    background-image:
      @@LOGO_BRANCO@@,
      var(--nc-t-painel-parado, none),
      radial-gradient(90% 40% at 0% 0%, rgba(var(--nc-t-rosa-rgb), .28), transparent 70%),
      radial-gradient(120% 45% at 100% 100%, rgba(var(--nc-t-rosa-rgb), .22), transparent 70%),
      linear-gradient(180deg, var(--nc-azul) 0%, var(--nc-roxo) 100%);
  }}
}}

/* botões: o principal na cor do tema (o hover escurece para o tom profundo) */
{CORPO} .t-Button--hot:hover {{
  box-shadow: 0 12px 28px -10px rgba(var(--nc-t-roxo-rgb), .55);
}}

{CORPO} :is(.t-Body-content, .t-Body-side, .t-Dialog-body, .t-DialogRegion, .t-Dialog-footer) .t-Button:not(.t-Button--hot):not(.t-Button--link):not(.t-Button--noUI):hover,
{CORPO} .t-Body-title .t-Button:not(.t-Button--hot):hover {{
  border-color: rgba(var(--nc-t-roxo-rgb), .4);
}}

/* topo das regiões: o ícone com o degradê do tema e a sombra no destaque */
{CORPO} .t-Region-headerIcon {{
  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, .28),
    inset 0 0 0 1px rgba(255, 255, 255, .10),
    0 2px 6px -2px rgba(var(--nc-t-roxo-rgb), .35),
    0 12px 24px -12px rgba(var(--nc-t-rosa-rgb), .75);
}}
''')

# ---------- a janela "Cores do sistema" ----------
css.append(open(os.path.join(AQUI, 'Natcorp_Temas.janela.css'), encoding='utf-8').read())
open(os.path.join(AQUI, 'Natcorp_Temas.src.css'), 'w', encoding='utf-8').write('\n'.join(css))

# ---------- o JS ----------
import subprocess
PAINEL = json.loads(subprocess.check_output(['node', '-e',
    "import('../painel-natcorp.mjs').then(m => process.stdout.write(JSON.stringify([m.painel(m.PAINEL_MENU, true), m.painel(m.PAINEL_MENU, false)])))"],
    cwd=AQUI))


def troca(p):
    """as cinco cores desenhadas no painel do menu → as do tema"""
    r = rgb(p['claro'])
    return {'#C95788': p['rosa'], '#E4A9C4': p['claro'], '#F3C9DA': p['brilho'], '#511C76': p['roxo'], 'rgba(228,169,196,.75)': 'rgba(' + r.replace(' ', '') + ',.75)'}


dados = [{'id': t[0], 'nome': t[1], 'desc': t[2], 'cores': {k: t[3][k] for k in ('azul', 'roxo', 'ameixa', 'rosa', 'claro')}, 'painel': troca(t[3])} for t in TEMAS]
js = open(os.path.join(AQUI, 'Natcorp_Temas.src.js'), encoding='utf-8').read()
js = js.replace('/*TEMAS*/[]', json.dumps(dados, ensure_ascii=False, indent=2))
js = js.replace('/*PAINEL*/[]', json.dumps(PAINEL, ensure_ascii=False))
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Temas.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Temas.src.css e ../login/Natcorp_Temas.js ·', len(TEMAS), 'temas')
for tid, nome, _, p in TEMAS:
    print('  %-15s %-16s %s %s %s %s' % (tid, nome, p['azul'], p['roxo'], p['ameixa'], p['rosa']))
