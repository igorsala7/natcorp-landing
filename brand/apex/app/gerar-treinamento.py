"""Monta ../login/Natcorp_Treinamento.js: o Natcorp_Treinamento.src.js com a ilustração embutida.

    python3 gerar-treinamento.py

A ilustração é um recorte da ilustra-treinamento.png (../ilustracoes/treinamento/aula.png).
"""
import base64
import json
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
mapa = {}
ilu = os.path.join(AQUI, '..', 'ilustracoes', 'treinamento', 'aula.png')
if os.path.exists(ilu):
    mapa['aula'] = 'data:image/png;base64,' + base64.b64encode(open(ilu, 'rb').read()).decode()
src = open(os.path.join(AQUI, 'Natcorp_Treinamento.src.js'), encoding='utf-8').read()
marca = '/*@@ILUSTRACOES@@*/ {}'
assert marca in src
js = src.replace(marca, json.dumps(mapa))
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Treinamento.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Treinamento.js', len(js.encode()) // 1024, 'KB,', len(mapa), 'ilustração')
