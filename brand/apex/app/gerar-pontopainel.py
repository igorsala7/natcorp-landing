"""Monta o painel "Conferência do ponto" da 9503:204 para subir.

    python3 gerar-pontopainel.py      (depois do node gerar-app.mjs, que gera o CSS)

  ../login/Natcorp_PontoPainel.js   = cópia do Natcorp_PontoPainel.src.js
  ../login/Natcorp_PontoPainel.css  = cópia do ../login/Natcorp_Afastamentos.css (a MESMA roupa dos
                                     painéis: mexa no Natcorp_Afastamentos.src.css, seção [A16])
"""
import os
import shutil

AQUI = os.path.dirname(os.path.abspath(__file__))
LOGIN = os.path.join(AQUI, '..', 'login')
js = open(os.path.join(AQUI, 'Natcorp_PontoPainel.src.js'), encoding='utf-8').read()
open(os.path.join(LOGIN, 'Natcorp_PontoPainel.js'), 'w', encoding='utf-8').write(js)
shutil.copyfile(os.path.join(LOGIN, 'Natcorp_Afastamentos.css'), os.path.join(LOGIN, 'Natcorp_PontoPainel.css'))
print('Natcorp_PontoPainel.js', len(js.encode()) // 1024, 'KB · Natcorp_PontoPainel.css (cópia do Afastamentos)')
