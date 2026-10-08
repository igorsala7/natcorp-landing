"""Monta ../login/Natcorp_ManutencaoAtestados.js a partir do Natcorp_ManutencaoAtestados.src.js.

    python3 gerar-preatendimento.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_ManutencaoAtestados.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_ManutencaoAtestados.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_ManutencaoAtestados.js', len(js.encode()) // 1024, 'KB')
