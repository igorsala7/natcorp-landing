"""Monta ../login/Natcorp_Contrato.js (páginas 106 e 109 do app 300) a partir do Natcorp_Contrato.src.js.

    python3 gerar-contrato.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Contrato.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Contrato.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Contrato.js', len(js.encode()) // 1024, 'KB')
