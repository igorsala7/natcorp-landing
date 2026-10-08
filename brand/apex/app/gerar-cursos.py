"""Monta ../login/Natcorp_Cursos.js (página 90 do app 300) a partir do Natcorp_Cursos.src.js.

    python3 gerar-cursos.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Cursos.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Cursos.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Cursos.js', len(js.encode()) // 1024, 'KB')
