"""Monta o desenho da 9132:7 (Lançamentos de ocorrências — a ficha) para subir.

    python3 gerar-lancficha.py      (depois do node gerar-app.mjs, que gera o CSS)

  ../login/Natcorp_LancFicha.js   = cópia do Natcorp_LancFicha.src.js
  ../login/Natcorp_LancFicha.css  sai do node gerar-app.mjs (AVULSAS)
"""
import os
AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_LancFicha.src.js'), encoding='utf-8').read()
open(os.path.join(AQUI, '..', 'login', 'Natcorp_LancFicha.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_LancFicha.js', len(js.encode()) // 1024, 'KB')
