"""Monta ../login/Natcorp_Agenda.js a partir do Natcorp_Agenda.src.js.

    python3 gerar-agenda.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Agenda.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Agenda.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Agenda.js', len(js.encode()) // 1024, 'KB')
