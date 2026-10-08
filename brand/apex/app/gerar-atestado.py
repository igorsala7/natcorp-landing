"""Monta ../login/Natcorp_Atestado.js a partir do Natcorp_Atestado.src.js.

    python3 gerar-carta.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Atestado.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Atestado.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Atestado.js', len(js.encode()) // 1024, 'KB')
