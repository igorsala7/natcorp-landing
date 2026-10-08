"""Monta ../login/Natcorp_Carta.js a partir do Natcorp_Carta.src.js.

    python3 gerar-carta.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Carta.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Carta.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Carta.js', len(js.encode()) // 1024, 'KB')
