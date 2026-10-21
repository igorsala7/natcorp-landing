"""Monta o painel do QUADRO DE PESSOAS da 200:16 para subir.

    python3 gerar-quadro.py      (depois do node gerar-app.mjs, que gera o CSS)

  ../login/Natcorp_Quadro.js   = cópia do Natcorp_Quadro.src.js
  ../login/Natcorp_Quadro.css  = cópia do ../login/Natcorp_Afastamentos.css (a MESMA roupa dos painéis de
                                 afastamentos e férias: mexa no Natcorp_Afastamentos.src.css)
"""
import os
import shutil

AQUI = os.path.dirname(os.path.abspath(__file__))
LOGIN = os.path.join(AQUI, '..', 'login')
js = open(os.path.join(AQUI, 'Natcorp_Quadro.src.js'), encoding='utf-8').read()
open(os.path.join(LOGIN, 'Natcorp_Quadro.js'), 'w', encoding='utf-8').write(js)
shutil.copyfile(os.path.join(LOGIN, 'Natcorp_Afastamentos.css'), os.path.join(LOGIN, 'Natcorp_Quadro.css'))
print('Natcorp_Quadro.js', len(js.encode()) // 1024, 'KB · Natcorp_Quadro.css (cópia do Afastamentos)')
