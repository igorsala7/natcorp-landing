"""Monta ../login/Natcorp_HoraExtra.js a partir do Natcorp_HoraExtra.src.js.

    python3 gerar-horaextra.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_HoraExtra.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_HoraExtra.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_HoraExtra.js', len(js.encode()) // 1024, 'KB')
