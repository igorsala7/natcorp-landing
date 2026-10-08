"""Monta ../login/Natcorp_Chamada.js a partir do Natcorp_Chamada.src.js.

    python3 gerar-chamada.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Chamada.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Chamada.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Chamada.js', len(js.encode()) // 1024, 'KB')
