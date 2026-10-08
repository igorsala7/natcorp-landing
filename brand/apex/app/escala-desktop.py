"""Gera, em cada .src.css das páginas do Portal (feitas PRIMEIRO para o celular), o bloco
"[DESK] TELAS DE MESA": a partir de 1024 px de largura, as letras e a altura dos botões ficam
menores, na proporção — no celular nada muda (pedido de 04/10: "no desktop tem fontes ficando
muito grandes, que fazem sentido no smartphone").

    python3 escala-desktop.py                 # todos os arquivos da lista ARQUIVOS
    python3 escala-desktop.py X.src.css       # só esses

Como: lê cada regra do arquivo (as de fora de @media e as de @media (min-width: N) com N < 1024,
na ordem em que valem) e, para cada font-size e min-height em px, escreve a mesma regra com o
valor reduzido, dentro de @media (min-width: 1024px), no FIM do arquivo, entre os marcadores.
Rodar de novo troca o bloco (não acumula). Depois: gerar-app.mjs.

PODE MEXER: ESCALA (as faixas e os fatores), LIMITE (a largura).
"""
import re
import sys

ARQUIVOS = ['Natcorp_Consulta.src.css', 'Natcorp_FeriasConsulta.src.css', 'Natcorp_Onboarding.src.css',
            'Natcorp_Feedback.src.css', 'Natcorp_Cipa.src.css', 'Natcorp_Contrato.src.css', 'Natcorp_Normas.src.css',
            'Natcorp_BeneficiosConsulta.src.css', 'Natcorp_Marcacoes.src.css', 'Natcorp_Espelho.src.css',
            'Natcorp_Colab.src.css', 'Natcorp_Lancamento.src.css', 'Natcorp_Folha.src.css', 'Natcorp_Cursos.src.css']
LIMITE = 1024
INICIO = '/* ═══ [DESK] TELAS DE MESA — gerado por escala-desktop.py (não editar à mão; rode o script) ═══ */'
FIM = '/* ═══ fim do [DESK] ═══ */'


def escala_letra(px):
    """as letras grandes diminuem mais; as pequenas (abaixo de 15 px) ficam como estão"""
    if px >= 24:
        n = px * 0.84
    elif px >= 18:
        n = px * 0.88
    elif px >= 15:
        n = max(14, px * 0.93)
    else:
        return None
    return round(n * 2) / 2


def escala_altura(px):
    """alvos de toque (44–56 px) viram alturas de mesa (40–48 px)"""
    if px < 44:
        return None
    return max(38, round(px * 0.86))


def regras(css):
    """(media, seletor, declarações) na ordem do arquivo; media = '' ou o N do min-width"""
    css = re.sub(r'/\*.*?\*/', '', css, flags=re.S)
    out, i, media = [], 0, ''
    pilha = []
    while i < len(css):
        a = css.find('{', i)
        if a < 0:
            break
        cab = css[i:a].strip()
        fecha_antes = css.find('}', i)
        if 0 <= fecha_antes < a:          # fecha um @media
            pilha and pilha.pop()
            i = fecha_antes + 1
            continue
        if cab.startswith('@media'):
            m = re.search(r'min-width:\s*(\d+)px', cab)
            pilha.append(m.group(1) if m else 'outra')
            i = a + 1
            continue
        b = css.find('}', a)
        out.append((pilha[-1] if pilha else '', cab, css[a + 1:b]))
        i = b + 1
    return out


def bloco(css):
    valores = {}                           # seletor → {prop: px}, na ordem de cascata até 1024
    for media, sel, decl in regras(css):
        if media == 'outra' or (media and int(media) >= LIMITE):
            continue
        for prop, val in re.findall(r'(font-size|min-height)\s*:\s*([\d.]+)px', decl):
            valores.setdefault(sel, {})[prop] = float(val)
    linhas = []
    for sel, props in valores.items():
        decls = []
        if 'font-size' in props:
            n = escala_letra(props['font-size'])
            if n and n != props['font-size']:
                decls.append('font-size: %gpx;' % n)
        if 'min-height' in props:
            n = escala_altura(props['min-height'])
            if n and n != props['min-height']:
                decls.append('min-height: %dpx;' % n)
        if decls:
            linhas.append('  ' + sel.replace('\n', '\n  ') + ' {\n' + ''.join('    ' + d + '\n' for d in decls) + '  }\n')
    if not linhas:
        return ''
    return INICIO + '\n@media (min-width: %dpx) {\n' % LIMITE + '\n'.join(linhas) + '}\n' + FIM + '\n'


for nome in sys.argv[1:] or ARQUIVOS:
    s = open(nome, encoding='utf-8').read()
    s = re.sub(re.escape(INICIO) + r'.*?' + re.escape(FIM) + r'\n?', '', s, flags=re.S).rstrip('\n') + '\n'
    b = bloco(s)
    if b:
        s += '\n' + b
    open(nome, 'w', encoding='utf-8').write(s)
    print('%-38s %3d regras de mesa' % (nome, b.count(' {\n') - 1 if b else 0))
