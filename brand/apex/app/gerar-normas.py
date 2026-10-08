"""Monta ../login/Natcorp_Normas.js (páginas 56 e 57 do app 300) a partir do Natcorp_Normas.src.js.

    python3 gerar-normas.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Normas.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Normas.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Normas.js', len(js.encode()) // 1024, 'KB')
