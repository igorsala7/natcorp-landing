"""Monta o painel de BENEFÍCIOS da 200:164 para subir.

    python3 gerar-benefpainel.py      (depois do node gerar-app.mjs, que gera o CSS)

  ../login/Natcorp_BenefPainel.js   = cópia do Natcorp_BenefPainel.src.js
  ../login/Natcorp_BenefPainel.css  = cópia do ../login/Natcorp_Afastamentos.css (a MESMA roupa dos painéis
                                      16, 25 e 26: mexa no Natcorp_Afastamentos.src.css)
"""
import os
import shutil

AQUI = os.path.dirname(os.path.abspath(__file__))
LOGIN = os.path.join(AQUI, '..', 'login')
js = open(os.path.join(AQUI, 'Natcorp_BenefPainel.src.js'), encoding='utf-8').read()
open(os.path.join(LOGIN, 'Natcorp_BenefPainel.js'), 'w', encoding='utf-8').write(js)
shutil.copyfile(os.path.join(LOGIN, 'Natcorp_Afastamentos.css'), os.path.join(LOGIN, 'Natcorp_BenefPainel.css'))
print('Natcorp_BenefPainel.js', len(js.encode()) // 1024, 'KB · Natcorp_BenefPainel.css (cópia do Afastamentos)')
