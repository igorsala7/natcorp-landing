"""Monta ../login/Natcorp_Acidente.js a partir do Natcorp_Acidente.src.js.

    python3 gerar-acidente.py

Sem ilustração embutida (a figura do corpo é SVG no próprio .js): hoje é uma cópia, mas mantém o mesmo caminho
das outras páginas (.src.js → login/).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Acidente.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Acidente.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Acidente.js', len(js.encode()) // 1024, 'KB')
