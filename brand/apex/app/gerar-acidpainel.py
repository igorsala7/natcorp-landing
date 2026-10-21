"""Monta o painel de ACIDENTES DE TRABALHO da 200:150 para subir.

    python3 gerar-acidpainel.py      (depois do node gerar-app.mjs, que gera o CSS)

  ../login/Natcorp_AcidPainel.js   = cópia do Natcorp_AcidPainel.src.js
  ../login/Natcorp_AcidPainel.css  = cópia do ../login/Natcorp_Afastamentos.css (a MESMA roupa do
                                     painel de afastamentos: mexa no Natcorp_Afastamentos.src.css,
                                     seção [A11] para as peças só dos acidentes)
"""
import os
import shutil

AQUI = os.path.dirname(os.path.abspath(__file__))
LOGIN = os.path.join(AQUI, '..', 'login')
js = open(os.path.join(AQUI, 'Natcorp_AcidPainel.src.js'), encoding='utf-8').read()
open(os.path.join(LOGIN, 'Natcorp_AcidPainel.js'), 'w', encoding='utf-8').write(js)
shutil.copyfile(os.path.join(LOGIN, 'Natcorp_Afastamentos.css'), os.path.join(LOGIN, 'Natcorp_AcidPainel.css'))
print('Natcorp_AcidPainel.js', len(js.encode()) // 1024, 'KB · Natcorp_AcidPainel.css (cópia do Afastamentos)')
