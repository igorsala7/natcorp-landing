"""Monta ../login/Natcorp_Requisicao.js: o Natcorp_Requisicao.src.js com a ilustração embutida.

    python3 gerar-requisicao.py

A ilustração é um recorte da ilustra-recrutamento.png (../ilustracoes/beneficios/recrutamento.png).
"""
import base64
import json
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
mapa = {}
ilu = os.path.join(AQUI, '..', 'ilustracoes', 'beneficios', 'recrutamento.png')
if os.path.exists(ilu):
    mapa['recrutamento'] = 'data:image/png;base64,' + base64.b64encode(open(ilu, 'rb').read()).decode()
src = open(os.path.join(AQUI, 'Natcorp_Requisicao.src.js'), encoding='utf-8').read()
marca = '/*@@ILUSTRACOES@@*/ {}'
assert marca in src
js = src.replace(marca, json.dumps(mapa))
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Requisicao.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Requisicao.js', len(js.encode()) // 1024, 'KB,', len(mapa), 'ilustração')
