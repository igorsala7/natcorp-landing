"""Monta ../login/Natcorp_Espelho.js (página 45 do app 9506) a partir do Natcorp_Espelho.src.js.

    python3 gerar-espelho.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Espelho.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Espelho.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Espelho.js', len(js.encode()) // 1024, 'KB')
