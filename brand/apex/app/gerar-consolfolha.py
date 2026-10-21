"""Monta o painel de CONSOLIDAÇÃO DO HISTÓRICO FINANCEIRO da 9181:50 para subir.

    python3 gerar-acidpainel.py      (depois do node gerar-app.mjs, que gera o CSS)

  ../login/Natcorp_ConsolFolha.js   = cópia do Natcorp_ConsolFolha.src.js
  ../login/Natcorp_ConsolFolha.css  = cópia do ../login/Natcorp_Afastamentos.css (a MESMA roupa do
                                     painel de afastamentos: mexa no Natcorp_Afastamentos.src.css,
                                     seção [A14] para as peças só desta página)
"""
import os
import shutil

AQUI = os.path.dirname(os.path.abspath(__file__))
LOGIN = os.path.join(AQUI, '..', 'login')
js = open(os.path.join(AQUI, 'Natcorp_ConsolFolha.src.js'), encoding='utf-8').read()
open(os.path.join(LOGIN, 'Natcorp_ConsolFolha.js'), 'w', encoding='utf-8').write(js)
shutil.copyfile(os.path.join(LOGIN, 'Natcorp_Afastamentos.css'), os.path.join(LOGIN, 'Natcorp_ConsolFolha.css'))
print('Natcorp_ConsolFolha.js', len(js.encode()) // 1024, 'KB · Natcorp_ConsolFolha.css (cópia do Afastamentos)')
