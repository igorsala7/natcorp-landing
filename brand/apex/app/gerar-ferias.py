"""Monta ../login/Natcorp_Ferias.js: o Natcorp_Ferias.src.js com a ilustração embutida.

    python3 gerar-ferias.py

A ilustração sai de ../ilustracoes/geradas/fer_ferias-v1.png (gerar_openai.py b-fer_ferias):
recorta o transparente, reduz a 224 px (2× os 112 da tela) e comprime com o pngquant.
"""
import base64
import json
import os
import subprocess

from PIL import Image

AQUI = os.path.dirname(os.path.abspath(__file__))
ent = os.path.join(AQUI, '..', 'ilustracoes', 'geradas', 'fer_ferias-v1.png')
dest = os.path.join(AQUI, '..', 'ilustracoes', 'beneficios', 'ferias.png')
mapa = {}
if os.path.exists(ent):
    im = Image.open(ent).convert('RGBA')
    im = im.crop(im.getchannel('A').point(lambda a: 255 if a > 8 else 0).getbbox())
    lado = int(max(im.size) * 1.06)
    tela = Image.new('RGBA', (lado, lado), (0, 0, 0, 0))
    tela.paste(im, ((lado - im.width) // 2, (lado - im.height) // 2))
    tela.resize((224, 224), Image.LANCZOS).save(dest)
    subprocess.run(['pngquant', '--force', '--skip-if-larger', '--strip', '--speed', '1', '--quality', '65-92', '--output', dest, '128', dest], check=False)
    mapa['ferias'] = 'data:image/png;base64,' + base64.b64encode(open(dest, 'rb').read()).decode()
src = open(os.path.join(AQUI, 'Natcorp_Ferias.src.js'), encoding='utf-8').read()
marca = '/*@@ILUSTRACOES@@*/ {}'
assert marca in src
js = src.replace(marca, json.dumps(mapa))
saida = os.path.join(AQUI, '..', 'login', 'Natcorp_Ferias.js')
open(saida, 'w', encoding='utf-8').write(js)
print('Natcorp_Ferias.js', len(js.encode()) // 1024, 'KB,', len(mapa), 'ilustração')
