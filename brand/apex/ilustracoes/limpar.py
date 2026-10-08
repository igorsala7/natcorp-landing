"""Tira o xadrez pintado do fundo (o gpt-image-2 pela ElevenLabs devolve RGB com um
quadriculado cinza no lugar da transparência). PNG que já vem transparente (API da OpenAI)
pula essa parte. Depois recorta, reduz a 1000 px e quantiza em 256 cores com o pngquant.

    python3 limpar.py geradas/<nome>.png ilustra-<modulo>.png
"""
import os
import subprocess
import sys
from collections import deque

from PIL import Image, ImageFilter

ent, sai = sys.argv[1], sys.argv[2]
orig = Image.open(ent)
w, h = orig.size


def terminar(rgba, alfa):
    caixa = alfa.point(lambda a: 255 if a > 8 else 0).getbbox()
    rgba = rgba.crop(caixa)
    m = 40
    tela = Image.new('RGBA', (rgba.width + 2 * m, rgba.height + 2 * m), (0, 0, 0, 0))
    tela.paste(rgba, (m, m))
    # na página a ilustração aparece com ~411 px: 1000 px cobre tela retina com folga
    tela.thumbnail((1000, 1000), Image.LANCZOS)
    tela.save(sai)
    # 256 cores pelo pngquant: o quantize() do Pillow transformava a sombra suave (alfa em
    # muitos níveis) em granulado de pontinhos brancos
    subprocess.run(['pngquant', '--force', '--skip-if-larger', '--strip', '--speed', '1',
                    '--quality', '70-95', '--output', sai, '256', sai], check=False)
    print(sai, tela.size, os.path.getsize(sai) // 1024, 'KB')
    sys.exit()


# a API da OpenAI já devolve transparência de verdade: só recorta e reduz
if orig.mode == 'RGBA' and orig.getchannel('A').getextrema()[0] == 0:
    rgba = orig.convert('RGBA')
    terminar(rgba, rgba.getchannel('A'))

im = orig.convert('RGB')
px = im.load()


def neutro(p):
    return max(p) - min(p) <= 5 and min(p) >= 226


# o fundo é o cinza/branco neutro que toca a borda, inundado a partir dela
fundo = bytearray(w * h)
fila = deque()
for x in range(w):
    for y in (0, h - 1):
        fila.append((x, y))
for y in range(h):
    for x in (0, w - 1):
        fila.append((x, y))
while fila:
    x, y = fila.popleft()
    i = y * w + x
    if fundo[i] or not neutro(px[x, y]):
        continue
    fundo[i] = 1
    if x > 0: fila.append((x - 1, y))
    if x < w - 1: fila.append((x + 1, y))
    if y > 0: fila.append((x, y - 1))
    if y < h - 1: fila.append((x, y + 1))

alfa = Image.frombytes('L', (w, h), bytes(0 if f else 255 for f in fundo))
alfa = alfa.filter(ImageFilter.GaussianBlur(1.2))
rgba = im.convert('RGBA')
rgba.putalpha(alfa)
terminar(rgba, alfa)
