"""Monta ../login/Natcorp_Funcional.js a partir do Natcorp_Funcional.src.js.

    python3 gerar-funcional.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Funcional.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Funcional.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Funcional.js', len(js.encode()) // 1024, 'KB')
