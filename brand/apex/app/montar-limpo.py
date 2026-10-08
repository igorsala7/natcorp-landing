"""Monta a VERSÃO LIMPA em ../limpo/: só o ORIGINAL do cliente + o que a Natcorp (Claude) fez.
Não escreve em ../login/ (a versão atual fica como está, para poder voltar).

    python3 montar-limpo.py

O que sai em ../limpo/ (os mesmos nomes, prontos para subir no Workspace Files):
  · Natcorp_Style_Min.css           a Skin ORIGINAL (../login/Natcorp_Style_Min.current.css) + o divisor
                                    + o nosso CSS (a parte de baixo do ../login/Natcorp_Style_Min.css,
                                    gerada pelo gerar-app.mjs). Sai a camada "Natcorp_Style_New" do time
                                    (186 KB entre a Skin e o divisor).
  · Natcorp_Allow_Unload_Iframes.js o ORIGINAL (../login/Natcorp_Allow_Unload_Iframes.current.js: unload nas
                                    molduras + limpeza de Popup LOV órfãos), com DEBUG = false e o marcador
                                    dos :has() caros (nc-marcas.bloco.js, gerado pelo gerar-app.mjs). Saem os
                                    7 módulos do time (tema, stepper, Maximizar, barra flutuante, cabeçalho
                                    grudento, rádio padrão, cabeçalho nativo).
  · iframe_handling.js              o atual (= o original + os blocos "Natcorp —"): sem mudança.
  · Natcorp_Temas.js                gerado do Natcorp_Temas.src.js: repassa o tema às molduras e põe os
                                    itens no menu sem depender do arquivo do time.
A versão atual inteira está guardada em ../versoes/atual-0710/. Guia: ../limpo/LEIA-ME.md.
"""
import os
import re
import shutil
import subprocess
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
LOGIN = os.path.join(AQUI, '..', 'login')
LIMPO = os.path.join(AQUI, '..', 'limpo')
MARCA = 'NOVAS IMPLEMENTAÇÕES — Natcorp (a partir daqui)'
os.makedirs(LIMPO, exist_ok=True)


def ler(p):
    return open(p, encoding='utf-8').read()


# ---------- CSS: Skin original + divisor + o nosso ----------
atual = ler(os.path.join(LOGIN, 'Natcorp_Style_Min.css'))
skin_original = ler(os.path.join(LOGIN, 'Natcorp_Style_Min.current.css')).rstrip()
i = atual.find(MARCA)
if i < 0:
    sys.exit('o Natcorp_Style_Min.css não tem o divisor — rode o gerar-app.mjs')
inicio_divisor = atual.rfind('/*', 0, i)
if not atual.startswith(skin_original):
    sys.exit('a Skin do Natcorp_Style_Min.css não começa com a Skin original — conferir à mão')
limpo_css = skin_original + '\n\n\n' + atual[inicio_divisor:]
open(os.path.join(LIMPO, 'Natcorp_Style_Min.css'), 'w', encoding='utf-8').write(limpo_css)

# ---------- Allow_Unload: o original, sem os logs ----------
au = ler(os.path.join(LOGIN, 'Natcorp_Allow_Unload_Iframes.current.js'))
if au.count('var DEBUG = true;') != 1:
    sys.exit('o Allow_Unload original mudou (DEBUG) — conferir à mão')
au = au.replace('var DEBUG = true;', 'var DEBUG = false;   // true só para investigar (o log manda os iframes ao console)', 1)
bloco = ler(os.path.join(AQUI, 'nc-marcas.bloco.js')).strip()   # o marcador dos :has() caros (gerado pelo gerar-app.mjs)
au = au.rstrip() + '\n\n' + bloco + '\n'
open(os.path.join(LIMPO, 'Natcorp_Allow_Unload_Iframes.js'), 'w', encoding='utf-8').write(au)

# ---------- iframe_handling: o atual (original + os nossos blocos) ----------
ih = ler(os.path.join(LOGIN, 'iframe_handling.js'))
if not ih.startswith(ler(os.path.join(LOGIN, 'iframe_handling.current.js')).strip()):
    sys.exit('o iframe_handling.js não começa com o original — conferir à mão')
shutil.copyfile(os.path.join(LOGIN, 'iframe_handling.js'), os.path.join(LIMPO, 'iframe_handling.js'))

# ---------- Temas: gerado da fonte, sem tocar no ../login/Natcorp_Temas.js ----------
destino_login = os.path.join(LOGIN, 'Natcorp_Temas.js')
guardado = ler(destino_login)
try:
    subprocess.run([sys.executable, os.path.join(AQUI, 'gerar-temas.py')], check=True, cwd=AQUI, capture_output=True)
    shutil.copyfile(destino_login, os.path.join(LIMPO, 'Natcorp_Temas.js'))
finally:
    open(destino_login, 'w', encoding='utf-8').write(guardado)   # a versão atual fica como estava

kb = lambda n: '%.0f KB' % (os.path.getsize(os.path.join(LIMPO, n)) / 1024)
print('../limpo/ ·', ' · '.join(n + ' ' + kb(n) for n in
      ['Natcorp_Style_Min.css', 'Natcorp_Allow_Unload_Iframes.js', 'iframe_handling.js', 'Natcorp_Temas.js']))
print('camada do time fora do CSS: %.0f KB' % ((inicio_divisor - len(skin_original)) / 1024))
