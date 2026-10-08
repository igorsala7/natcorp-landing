"""Monta ../login/Natcorp_Folha.js (página 74 do app 300) a partir do Natcorp_Folha.src.js.

    python3 gerar-lancamento.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Folha.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Folha.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Folha.js', len(js.encode()) // 1024, 'KB')
