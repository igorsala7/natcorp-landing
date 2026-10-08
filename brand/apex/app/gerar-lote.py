"""Monta ../login/Natcorp_Lote.js a partir do Natcorp_Lote.src.js.

    python3 gerar-abono.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Lote.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Lote.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Lote.js', len(js.encode()) // 1024, 'KB')
