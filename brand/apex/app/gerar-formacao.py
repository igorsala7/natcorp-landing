"""Monta ../login/Natcorp_Formacao.js a partir do Natcorp_Formacao.src.js.

    python3 gerar-formacao.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Formacao.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Formacao.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Formacao.js', len(js.encode()) // 1024, 'KB')
