"""Monta o painel do SESMT da 2937:39 (Pesquisa Consulta Médica) para subir.

    python3 gerar-sesmtpainel.py      (depois do node gerar-app.mjs, que gera o CSS)

  ../login/Natcorp_SesmtPainel.js   = cópia do Natcorp_SesmtPainel.src.js
  ../login/Natcorp_SesmtPainel.css  = cópia do ../login/Natcorp_Afastamentos.css (a MESMA roupa dos
                                     painéis: mexa no Natcorp_Afastamentos.src.css, seção [A15])
"""
import os
import shutil

AQUI = os.path.dirname(os.path.abspath(__file__))
LOGIN = os.path.join(AQUI, '..', 'login')
js = open(os.path.join(AQUI, 'Natcorp_SesmtPainel.src.js'), encoding='utf-8').read()
open(os.path.join(LOGIN, 'Natcorp_SesmtPainel.js'), 'w', encoding='utf-8').write(js)
shutil.copyfile(os.path.join(LOGIN, 'Natcorp_Afastamentos.css'), os.path.join(LOGIN, 'Natcorp_SesmtPainel.css'))
print('Natcorp_SesmtPainel.js', len(js.encode()) // 1024, 'KB · Natcorp_SesmtPainel.css (cópia do Afastamentos)')
