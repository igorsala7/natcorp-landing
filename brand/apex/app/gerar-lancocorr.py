"""Monta o desenho da 9132:5 (Lançamentos de ocorrências) para subir.

    python3 gerar-lancocorr.py      (depois do node gerar-app.mjs, que gera os CSS)

  ../login/Natcorp_LancOcorr.js   = cópia do Natcorp_LancOcorr.src.js
  ../login/Natcorp_LancOcorr.css  e ../login/Natcorp_HistFiltros.css saem do node gerar-app.mjs
"""
import os
AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_LancOcorr.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_LancOcorr.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_LancOcorr.js', len(js.encode()) // 1024, 'KB')
