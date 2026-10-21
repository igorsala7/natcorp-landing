"""Monta o painel "Saúde e segurança do trabalho" da 2937:5 para subir.

    python3 gerar-saudepainel.py      (depois do node gerar-app.mjs, que gera o CSS)

  ../login/Natcorp_SaudePainel.js   = cópia do Natcorp_SaudePainel.src.js
  ../login/Natcorp_SaudePainel.css  = cópia do ../login/Natcorp_Afastamentos.css (a MESMA roupa dos
                                     painéis: mexa no Natcorp_Afastamentos.src.css, seção [A18])
"""
import os
import shutil

AQUI = os.path.dirname(os.path.abspath(__file__))
LOGIN = os.path.join(AQUI, '..', 'login')
js = open(os.path.join(AQUI, 'Natcorp_SaudePainel.src.js'), encoding='utf-8').read()
open(os.path.join(LOGIN, 'Natcorp_SaudePainel.js'), 'w', encoding='utf-8').write(js)
shutil.copyfile(os.path.join(LOGIN, 'Natcorp_Afastamentos.css'), os.path.join(LOGIN, 'Natcorp_SaudePainel.css'))
print('Natcorp_SaudePainel.js', len(js.encode()) // 1024, 'KB · Natcorp_SaudePainel.css (cópia do Afastamentos)')
