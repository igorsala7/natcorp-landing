"""Monta ../login/Natcorp_Editor.js a partir do Natcorp_Editor.src.js.

    python3 gerar-editor.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Editor.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Editor.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Editor.js', len(js.encode()) // 1024, 'KB')
