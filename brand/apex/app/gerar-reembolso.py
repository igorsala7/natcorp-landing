"""Monta ../login/Natcorp_Reembolso.js a partir do Natcorp_Reembolso.src.js.

    python3 gerar-carta.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Reembolso.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Reembolso.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Reembolso.js', len(js.encode()) // 1024, 'KB')
