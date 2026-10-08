"""Monta ../login/Natcorp_Beneficios.js: o Natcorp_Beneficios.src.js com as ilustrações dos
benefícios embutidas (data URI), para subir UM arquivo só no APEX.

    python3 gerar-beneficios.py

As ilustrações saem de ../ilustracoes/geradas/ben_<categoria>-v1.png (gerar_openai.py
b-ben_<categoria>): recorta o transparente, põe margem, reduz a 192 px (2× os 96 da tela)
e comprime com o pngquant. Falta alguma? O cartão usa a de "outro".
"""
import base64
import io
import json
import os
import subprocess
import tempfile

from PIL import Image

AQUI = os.path.dirname(os.path.abspath(__file__))
GERADAS = os.path.join(AQUI, '..', 'ilustracoes', 'geradas')
SAIDA_ILU = os.path.join(AQUI, '..', 'ilustracoes', 'beneficios')
CATS = ['carro', 'previdencia', 'refeicao', 'academia', 'combustivel', 'educacao',
        'saude', 'odonto', 'transporte', 'seguro', 'outro']
LADO = 192

os.makedirs(SAIDA_ILU, exist_ok=True)
mapa = {}
for c in CATS:
    ent = os.path.join(GERADAS, f'ben_{c}-v1.png')
    if not os.path.exists(ent):
        print('falta', c)
        continue
    im = Image.open(ent).convert('RGBA')
    caixa = im.getchannel('A').point(lambda a: 255 if a > 8 else 0).getbbox()
    im = im.crop(caixa)
    lado = max(im.size)
    tela = Image.new('RGBA', (int(lado * 1.08), int(lado * 1.08)), (0, 0, 0, 0))
    tela.paste(im, ((tela.width - im.width) // 2, (tela.height - im.height) // 2))
    tela = tela.resize((LADO, LADO), Image.LANCZOS)
    dest = os.path.join(SAIDA_ILU, f'{c}.png')
    tela.save(dest)
    subprocess.run(['pngquant', '--force', '--skip-if-larger', '--strip', '--speed', '1',
                    '--quality', '65-92', '--output', dest, '128', dest], check=False)
    dados = open(dest, 'rb').read()
    mapa[c] = 'data:image/png;base64,' + base64.b64encode(dados).decode()
    print(f'{c}: {len(dados) // 1024} KB')

src = open(os.path.join(AQUI, 'Natcorp_Beneficios.src.js'), encoding='utf-8').read()
marca = '/*@@ILUSTRACOES@@*/ {}'
assert marca in src
js = src.replace(marca, json.dumps(mapa))
destino = os.path.join(AQUI, '..', 'login', 'Natcorp_Beneficios.js')
open(destino, 'w', encoding='utf-8').write(js)
print('Natcorp_Beneficios.js', len(js.encode()) // 1024, 'KB,', len(mapa), 'ilustrações')
