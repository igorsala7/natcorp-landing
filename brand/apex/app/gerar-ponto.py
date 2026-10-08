"""Monta ../login/Natcorp_Ponto.js a partir do Natcorp_Ponto.src.js.

    python3 gerar-ponto.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Ponto.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Ponto.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Ponto.js', len(js.encode()) // 1024, 'KB')
