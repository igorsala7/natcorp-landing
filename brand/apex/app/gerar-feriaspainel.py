"""Monta o painel de FÉRIAS da 200:26 para subir.

    python3 gerar-feriaspainel.py      (depois do node gerar-app.mjs, que gera o CSS)

  ../login/Natcorp_FeriasPainel.js   = cópia do Natcorp_FeriasPainel.src.js
  ../login/Natcorp_FeriasPainel.css  = cópia do ../login/Natcorp_Afastamentos.css (a MESMA roupa do
                                       painel de afastamentos: mexa no Natcorp_Afastamentos.src.css)
"""
import os
import shutil

AQUI = os.path.dirname(os.path.abspath(__file__))
LOGIN = os.path.join(AQUI, '..', 'login')
js = open(os.path.join(AQUI, 'Natcorp_FeriasPainel.src.js'), encoding='utf-8').read()
open(os.path.join(LOGIN, 'Natcorp_FeriasPainel.js'), 'w', encoding='utf-8').write(js)
shutil.copyfile(os.path.join(LOGIN, 'Natcorp_Afastamentos.css'), os.path.join(LOGIN, 'Natcorp_FeriasPainel.css'))
print('Natcorp_FeriasPainel.js', len(js.encode()) // 1024, 'KB · Natcorp_FeriasPainel.css (cópia do Afastamentos)')
