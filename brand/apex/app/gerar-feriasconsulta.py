"""Monta ../login/Natcorp_FeriasConsulta.js a partir do Natcorp_FeriasConsulta.src.js.

    python3 gerar-feriasconsulta.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_FeriasConsulta.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_FeriasConsulta.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_FeriasConsulta.js', len(js.encode()) // 1024, 'KB')
