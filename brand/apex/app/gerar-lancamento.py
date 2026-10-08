"""Monta ../login/Natcorp_Lancamento.js (página 11 do app 2060) a partir do Natcorp_Lancamento.src.js.

    python3 gerar-lancamento.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Lancamento.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Lancamento.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Lancamento.js', len(js.encode()) // 1024, 'KB')
