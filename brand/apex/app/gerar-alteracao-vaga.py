"""Monta ../login/Natcorp_AlteracaoVaga.js: o Natcorp_AlteracaoVaga.src.js com a ilustração embutida.

    python3 gerar-alteracao-vaga.py

A ilustração é um recorte da ilustra-movimentacoes.png (../ilustracoes/alteracao-vaga/mudanca.png).
"""
import base64
import json
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
mapa = {}
ilu = os.path.join(AQUI, '..', 'ilustracoes', 'alteracao-vaga', 'mudanca.png')
if os.path.exists(ilu):
    mapa['mudanca'] = 'data:image/png;base64,' + base64.b64encode(open(ilu, 'rb').read()).decode()
src = open(os.path.join(AQUI, 'Natcorp_AlteracaoVaga.src.js'), encoding='utf-8').read()
marca = '/*@@ILUSTRACOES@@*/ {}'
assert marca in src
js = src.replace(marca, json.dumps(mapa))
open(os.path.join(AQUI, '..', 'login', 'Natcorp_AlteracaoVaga.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_AlteracaoVaga.js', len(js.encode()) // 1024, 'KB,', len(mapa), 'ilustração')
