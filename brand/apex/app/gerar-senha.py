"""Monta ../login/Natcorp_Senha.js a partir do Natcorp_Senha.src.js.

    python3 gerar-senha.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS está no login
(../login/Natcorp_Login.src.css, bloco "Ver a senha") e sai do gerar-login.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Senha.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Senha.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Senha.js', len(js.encode()) // 1024, 'KB')
