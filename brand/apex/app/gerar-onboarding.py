"""Monta ../login/Natcorp_Onboarding.js a partir do Natcorp_Onboarding.src.js.

    python3 gerar-onboarding.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Onboarding.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Onboarding.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Onboarding.js', len(js.encode()) // 1024, 'KB')
