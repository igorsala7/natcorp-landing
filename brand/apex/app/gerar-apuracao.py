"""Monta ../login/Natcorp_Apuracao.js a partir do Natcorp_Apuracao.src.js.

    python3 gerar-abono.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Apuracao.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Apuracao.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Apuracao.js', len(js.encode()) // 1024, 'KB')
