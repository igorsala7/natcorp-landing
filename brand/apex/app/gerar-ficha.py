"""Monta ../login/Natcorp_Ficha.js a partir do Natcorp_Ficha.src.js.

    python3 gerar-ficha.py

Sem ilustração embutida (a foto é a do colaborador): hoje é uma cópia, mas mantém o mesmo caminho
das outras páginas (.src.js → login/).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Ficha.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Ficha.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Ficha.js', len(js.encode()) // 1024, 'KB')
