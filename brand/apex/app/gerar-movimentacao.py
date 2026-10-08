"""Monta ../login/Natcorp_Movimentacao.js a partir do Natcorp_Movimentacao.src.js.

    python3 gerar-movimentacao.py

Hoje é uma cópia (a página não tem ilustrações embutidas); fica como passo próprio para
seguir o mesmo caminho das outras páginas (gerar-beneficios.py, gerar-ferias.py).
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Movimentacao.src.js'), encoding='utf-8').read()
saida = os.path.join(AQUI, '..', 'login', 'Natcorp_Movimentacao.js')
open(saida, 'w', encoding='utf-8').write(js)
print('Natcorp_Movimentacao.js', len(js.encode()) // 1024, 'KB')
