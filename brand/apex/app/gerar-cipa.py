"""Monta ../login/Natcorp_Cipa.js a partir do Natcorp_Cipa.src.js.

    python3 gerar-cipa.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Cipa.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Cipa.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Cipa.js', len(js.encode()) // 1024, 'KB')
