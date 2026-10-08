"""Monta ../login/Natcorp_Registros.js a partir do Natcorp_Registros.src.js.

    python3 gerar-registros.py

Cópia do .src.js para login/ (mesmo caminho das outras páginas). O CSS sai do gerar-app.mjs.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
js = open(os.path.join(AQUI, 'Natcorp_Registros.src.js'), encoding='utf-8').read()
# 08/10: o bloco do marcador + "página pronta" (gerado pelo gerar-app.mjs) vai também aqui, para os apps
# que carregam o Registros e não o Allow_Unload (ex.: 9180). Rode o gerar-app.mjs depois de mudar o CSS.
bloco = os.path.join(AQUI, 'nc-marcas.bloco.js')
if os.path.exists(bloco):
    js = js.rstrip() + '\n\n' + open(bloco, encoding='utf-8').read().strip() + '\n'
open(os.path.join(AQUI, '..', 'login', 'Natcorp_Registros.js'), 'w', encoding='utf-8').write(js)
print('Natcorp_Registros.js', len(js.encode()) // 1024, 'KB')
