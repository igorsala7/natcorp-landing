"""Monta ../login/Natcorp_Dependentes.js a partir do Natcorp_Dependentes.src.js.

    python3 gerar-dependentes.py

Sem ilustração embutida (os ícones são SVG no próprio código): hoje é uma cópia, mas mantém o
mesmo caminho das outras páginas (.src.js → login/), para quem for mexer não precisar pensar.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Dependentes.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Dependentes.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Dependentes.js', len(js.encode()) // 1024, 'KB')
