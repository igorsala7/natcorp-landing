"""Monta ../login/Natcorp_Consulta.js a partir do Natcorp_Consulta.src.js.

    python3 gerar-consulta.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Consulta.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Consulta.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Consulta.js', len(js.encode()) // 1024, 'KB')
