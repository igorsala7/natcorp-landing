"""Monta ../login/Natcorp_IndMovimentacao.js a partir do Natcorp_IndMovimentacao.src.js.

    python3 gerar-indmovimentacao.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_IndMovimentacao.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_IndMovimentacao.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_IndMovimentacao.js', len(js.encode()) // 1024, 'KB')
