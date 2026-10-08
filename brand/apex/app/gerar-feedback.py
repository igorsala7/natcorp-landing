"""Monta ../login/Natcorp_Feedback.js a partir do Natcorp_Feedback.src.js.

    python3 gerar-feedback.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Feedback.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Feedback.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Feedback.js', len(js.encode()) // 1024, 'KB')
