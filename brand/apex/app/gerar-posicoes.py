"""Monta o painel de HEADCOUNT (posições) da 200:30 para subir.

    python3 gerar-acidpainel.py      (depois do node gerar-app.mjs, que gera o CSS)

  ../login/Natcorp_Posicoes.js   = cópia do Natcorp_Posicoes.src.js
  ../login/Natcorp_Posicoes.css  = cópia do ../login/Natcorp_Afastamentos.css (a MESMA roupa do
                                     painel de afastamentos: mexa no Natcorp_Afastamentos.src.css,
                                     seção [A13] para as peças só do headcount)
"""
import os
import shutil

AQUI = os.path.dirname(os.path.abspath(__file__))
LOGIN = os.path.join(AQUI, '..', 'login')
js = open(os.path.join(AQUI, 'Natcorp_Posicoes.src.js'), encoding='utf-8').read()
open(os.path.join(LOGIN, 'Natcorp_Posicoes.js'), 'w', encoding='utf-8').write(js)
shutil.copyfile(os.path.join(LOGIN, 'Natcorp_Afastamentos.css'), os.path.join(LOGIN, 'Natcorp_Posicoes.css'))
print('Natcorp_Posicoes.js', len(js.encode()) // 1024, 'KB · Natcorp_Posicoes.css (cópia do Afastamentos)')
