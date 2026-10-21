"""Monta o desenho da 200:21 (Histórico Financeiro) para subir.

    python3 gerar-histfin.py      (depois do node gerar-app.mjs, que gera os CSS)

  ../login/Natcorp_HistFin.js   = cópia do Natcorp_HistFin.src.js
  ../login/Natcorp_HistFin.css  = a roupa dos painéis (../login/Natcorp_Afastamentos.css, a MESMA das
                                  páginas 16, 25, 26 e 164) + a da coluna de filtros
                                  (../login/Natcorp_HistFiltros.css, de Natcorp_HistFiltros.src.css)
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
LOGIN = os.path.join(AQUI, '..', 'login')
js = open(os.path.join(AQUI, 'Natcorp_HistFin.src.js'), encoding='utf-8').read()
open(os.path.join(LOGIN, 'Natcorp_HistFin.js'), 'w', encoding='utf-8').write(js)
css = open(os.path.join(LOGIN, 'Natcorp_Afastamentos.css'), encoding='utf-8').read() + '\n' + \
      open(os.path.join(LOGIN, 'Natcorp_HistFiltros.css'), encoding='utf-8').read()
open(os.path.join(LOGIN, 'Natcorp_HistFin.css'), 'w', encoding='utf-8').write(css)
print('Natcorp_HistFin.js', len(js.encode()) // 1024, 'KB · Natcorp_HistFin.css', len(css.encode()) // 1024, 'KB (painéis + filtros)')
