"""Monta ../login/Natcorp_PPP.js a partir do Natcorp_PPP.src.js.

    python3 gerar-carta.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_PPP.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_PPP.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_PPP.js', len(js.encode()) // 1024, 'KB')
