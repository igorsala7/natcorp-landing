"""Monta ../login/Natcorp_Cadastro.js: o Natcorp_Cadastro.src.js com a ilustração embutida.

    python3 gerar-cadastro.py

A ilustração é um recorte da ilustra-inf-cadastrais.png (../ilustracoes/cadastro/ficha.png).
"""
import base64
import json
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
mapa = {}
ilu = os.path.join(AQUI, '..', 'ilustracoes', 'cadastro', 'ficha.png')
if os.path.exists(ilu):
    mapa['ficha'] = 'data:image/png;base64,' + base64.b64encode(open(ilu, 'rb').read()).decode()
src = open(os.path.join(AQUI, 'Natcorp_Cadastro.src.js'), encoding='utf-8').read()
marca = '/*@@ILUSTRACOES@@*/ {}'
assert marca in src
js = src.replace(marca, json.dumps(mapa))
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Cadastro.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Cadastro.js', len(js.encode()) // 1024, 'KB,', len(mapa), 'ilustração')
