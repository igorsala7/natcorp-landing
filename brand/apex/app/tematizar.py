"""Troca as cores da marca ESCRITAS POR EXTENSO nos .src.css por cores que seguem o tema escolhido
em "Cores do sistema" — para que faixas, aberturas, ícones, bordas e sombras desenhados página a
página acompanhem o tema (pedido de 01/10: "o cabeçalho está roxo, deveria estar respeitando o
tema"). No Padrão Natcorp nada muda.

    python3 tematizar.py            # todos os *.src.css (menos os do próprio tema)
    python3 tematizar.py X.src.css  # só esses

  1. As quatro cores da marca → a variável do tema, com a cor como reserva:
       #2C1A63 → var(--nc-azul, #2C1A63)   #511C76 → var(--nc-roxo, #511C76)
       #9A408A → var(--nc-ameixa, #9A408A) #C95788 → var(--nc-rosa, #C95788)
  2. As transparências dessas cores → o RGB do tema:
       rgba(201, 87, 136, … → rgba(var(--nc-t-rosa-rgb, 201, 87, 136), …   (idem roxo, azul, ameixa)
  3. Os OUTROS roxos e rosas (saturados, fora do texto quase preto) → girados no círculo cromático
     pelo mesmo ângulo do tema, mesma claridade e saturação (cor relativa do CSS):
       #7A2E82 → oklch(from #7A2E82 l calc(c * var(--nc-t-croma, 1)) calc(h + var(--nc-t-giro, 0)))
     A declaração original fica ANTES, marcada /*reserva*/: navegador sem cor relativa usa ela.

Não toca em: comentários, url(…) (SVG embutido quebraria), DEFINIÇÕES de variável (--x: …), nem no
que já foi trocado. Rodar de novo não muda nada.
"""
import glob
import re
import sys

from oklch import hex2oklch

HEX = {'2C1A63': 'azul', '511C76': 'roxo', '9A408A': 'ameixa', 'C95788': 'rosa'}
RGB = {'201,87,136': 'rosa', '81,28,118': 'roxo', '44,26,99': 'azul', '154,64,138': 'ameixa'}
RE_HEX6 = re.compile(r'#([0-9A-Fa-f]{6})\b')
RE_RGBA = re.compile(r'rgba\(\s*(201\s*,\s*87\s*,\s*136|81\s*,\s*28\s*,\s*118|44\s*,\s*26\s*,\s*99|154\s*,\s*64\s*,\s*138)\s*,\s*', re.I)
INTOCAVEL = re.compile(r'/\*.*?\*/|url\(\s*"[^"]*"\s*\)|url\(\s*\'[^\']*\'\s*\)|url\([^)]*\)', re.S)
# o que este script já escreveu (não reprocessar)
JA = re.compile(r'var\(--nc-(?:azul|roxo|ameixa|rosa), #[0-9A-F]{6}\)'
                r'|rgba\(var\(--nc-t-(?:rosa|roxo|azul|ameixa)-rgb, [\d, ]+\),'
                r'|oklch\(from #[0-9A-F]{6} l calc\(c \* var\(--nc-t-croma, 1\)\) calc\(h \+ var\(--nc-t-giro, 0\)\)\)')
RESERVA = '/*reserva*/'


def roxo_ou_rosa(h):
    L, C, H = hex2oklch('#' + h)
    return C > 0.05 and L >= 0.25 and (H >= 265 or H <= 12)


def trocar_valor(v):
    guard = []

    def g(m):
        guard.append(m.group(0))
        return '\u0001%d\u0001' % (len(guard) - 1)
    v = JA.sub(g, v)
    relativa = [False]

    def hexa(m):
        h = m.group(1).upper()
        if h in HEX:
            return g_lit('var(--nc-%s, #%s)' % (HEX[h], h))
        if roxo_ou_rosa(h):
            relativa[0] = True
            return g_lit('oklch(from #%s l calc(c * var(--nc-t-croma, 1)) calc(h + var(--nc-t-giro, 0)))' % h)
        return m.group(0)

    def g_lit(s):
        guard.append(s)
        return '\u0001%d\u0001' % (len(guard) - 1)
    v = RE_HEX6.sub(hexa, v)
    v = RE_RGBA.sub(lambda m: g_lit('rgba(var(--nc-t-%s-rgb, %s), ' % (RGB[re.sub(r'\s', '', m.group(1))], re.sub(r'\s*,\s*', ', ', m.group(1)))), v)
    v = re.sub('\u0001(\\d+)\u0001', lambda m: guard[int(m.group(1))], v)
    return v, relativa[0]


def tematizar(css):
    guardados = []

    def guarda(m):
        guardados.append(m.group(0))
        return '\u0000%d\u0000' % (len(guardados) - 1)
    t = INTOCAVEL.sub(guarda, css)

    def decl(m):
        prop, val = m.group(1), m.group(2)
        if prop.strip().startswith('--'):
            return m.group(0)
        # a declaração de reserva (a original, antes da com cor relativa) fica como está
        if any(guardados[int(i)] == RESERVA for i in re.findall('\u0000(\\d+)\u0000', val)):
            return m.group(0)
        novo, relativa = trocar_valor(val)
        if novo == val:
            return m.group(0)
        if not relativa:
            return prop + ':' + novo
        guardados.append(RESERVA)
        marca = '\u0000%d\u0000' % (len(guardados) - 1)
        return prop + ':' + val.rstrip() + ' ' + marca + ';\n  ' + prop.strip() + ':' + novo
    t = re.sub(r'([\w-]+\s*):([^;{}]*)', decl, t)
    return re.sub('\u0000(\\d+)\u0000', lambda m: guardados[int(m.group(1))], t)


if __name__ == '__main__':
    arquivos = sys.argv[1:] or [f for f in sorted(glob.glob('*.src.css')) if not f.startswith('Natcorp_Temas')]
    n_arq = 0
    for f in arquivos:
        s = open(f, encoding='utf-8').read()
        n = tematizar(s)
        if n != s:
            open(f, 'w', encoding='utf-8').write(n)
            n_arq += 1
            print('%-32s %3d variáveis · %3d giros' % (f, len(re.findall(r'var\(--nc-(?:azul|roxo|ameixa|rosa), #|rgba\(var\(--nc-t-', n)) - len(re.findall(r'var\(--nc-(?:azul|roxo|ameixa|rosa), #|rgba\(var\(--nc-t-', s)), n.count('oklch(from') - s.count('oklch(from')))
    print(n_arq, 'arquivo(s) alterado(s)')
