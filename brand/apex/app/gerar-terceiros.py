"""Monta ../login/Natcorp_Terceiros.js a partir do Natcorp_Terceiros.src.js.

    python3 gerar-terceiros.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Terceiros.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Terceiros.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Terceiros.js', len(js.encode()) // 1024, 'KB')
