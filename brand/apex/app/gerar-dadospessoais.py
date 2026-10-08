"""Monta ../login/Natcorp_DadosPessoais.js a partir do Natcorp_DadosPessoais.src.js.

    python3 gerar-dadospessoais.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_DadosPessoais.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_DadosPessoais.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_DadosPessoais.js', len(js.encode()) // 1024, 'KB')
