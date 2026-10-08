"""Monta ../login/Natcorp_Desligamento.js: o Natcorp_Desligamento.src.js com as ilustrações embutidas.

    python3 gerar-desligamento.py

As ilustrações são recortes de ilustra-termos.png (a carta) e ilustra-movimentacoes.png (o
caminho), em ../ilustracoes/desligamento/.
"""
import base64
import json
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
mapa = {}
for nome in ('carta', 'caminho'):
    ilu = os.path.join(AQUI, '..', 'ilustracoes', 'desligamento', nome + '.png')
    if os.path.exists(ilu):
        mapa[nome] = 'data:image/png;base64,' + base64.b64encode(open(ilu, 'rb').read()).decode()
src = open(os.path.join(AQUI, 'Natcorp_Desligamento.src.js'), encoding='utf-8').read()
marca = '/*@@ILUSTRACOES@@*/ {}'
assert marca in src
js = src.replace(marca, json.dumps(mapa))
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Desligamento.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Desligamento.js', len(js.encode()) // 1024, 'KB,', len(mapa), 'ilustrações')
