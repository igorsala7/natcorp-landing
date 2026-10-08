"""Monta ../login/Natcorp_Empregos.js a partir do Natcorp_Empregos.src.js.

    python3 gerar-empregos.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Empregos.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Empregos.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Empregos.js', len(js.encode()) // 1024, 'KB')
