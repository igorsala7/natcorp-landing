"""Monta ../login/Natcorp_Colab.js a partir do Natcorp_Colab.src.js.

    python3 gerar-colab.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Colab.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Colab.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Colab.js', len(js.encode()) // 1024, 'KB')
