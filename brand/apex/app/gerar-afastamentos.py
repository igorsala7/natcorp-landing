"""Monta ../login/Natcorp_Afastamentos.js a partir do Natcorp_Afastamentos.src.js.

    python3 gerar-afastamentos.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai pelo gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Afastamentos.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Afastamentos.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Afastamentos.js', len(js.encode()) // 1024, 'KB')
