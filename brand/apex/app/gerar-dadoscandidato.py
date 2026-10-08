"""Monta ../login/Natcorp_DadosCandidato.js a partir do Natcorp_DadosCandidato.src.js.

    python3 gerar-avaliacaomedica.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_DadosCandidato.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_DadosCandidato.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_DadosCandidato.js', len(js.encode()) // 1024, 'KB')
