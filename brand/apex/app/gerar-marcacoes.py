"""Monta ../login/Natcorp_Marcacoes.js (páginas 28 e 9998 do app 300) a partir do Natcorp_Marcacoes.src.js.

    python3 gerar-marcacoes.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Marcacoes.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Marcacoes.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Marcacoes.js', len(js.encode()) // 1024, 'KB')
