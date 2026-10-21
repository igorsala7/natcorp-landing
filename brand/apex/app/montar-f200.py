"""Monta o app 200 INTEIRO (f200.sql) com os desenhos que a exportação nova perdeu.

    python3 montar-f200.py              (lê f200.ORIGINAL.sql, escreve f200.sql)

Parte da exportação completa do app, intocada: f200.ORIGINAL.sql (14/10 22:36, 281 páginas). Ela
veio de uma versão importada por cima do app: os desenhos até 07/10 continuam nela, iguais ao que
foi entregue (17, 59, 76, 78, 116, 118, 120, 121, 126, 132, 134, 136, 168), mas os painéis feitos
de 08/10 em diante voltaram ao original. Este script devolve só esses:

   16  Quadro de pessoas ........ aplicar-quadro-pagina16.py       (Natcorp_Quadro + NC_QUADRO_INDICADORES)
   21  Histórico Financeiro ..... aplicar-histfin-pagina21.py      (Natcorp_HistFin + NC_HISTFIN_INDICADORES)
   25  Afastamentos ............. aplicar-afastamentos-pagina25.py (Natcorp_Afastamentos + NC_AFAST_INDICADORES)
   26  Férias (painel) .......... aplicar-feriaspainel-pagina26.py (a Linha do Tempo já está no app)
   30  Headcount ................ aplicar-posicoes-pagina30.py     (Natcorp_Posicoes + NC_POSICOES_INDICADORES)
  150  Acidentes de trabalho .... aplicar-acidpainel-pagina150.py (Natcorp_AcidPainel + NC_ACID_INDICADORES)
  164  Benefícios (painel) ...... aplicar-beneficios-pagina164.py (Natcorp_BenefPainel + NC_BENEF_INDICADORES)
  108  Linha do Tempo ........... a correção de 02/10 18:44 (headline = descrição, text = título), que
                                  ficou de fora da versão importada

Cada página é recortada ("prompt --application/pages/page_NNNNN" até o próximo "prompt
--application/"), vestida com o cabeçalho e o rodapé da exportação avulsa dela (os scripts esperam
uma exportação de página), passa pelo script e volta ao lugar.

A 21 é a única cujo script traz IDs fixos (PERFIS['200'], da base das exportações avulsas). Esta
exportação está em outra base: todos os IDs dela = avulsa + DESLOCAMENTO_21, de forma uniforme (os
modelos do tema também). Por isso a página 21 é deslocada para a base do script, alterada e
devolvida — o processo novo fica com um ID também deslocado, sem colisão.

CUIDADO: importar o app inteiro substitui tudo. Só importar se ninguém mexeu no 200 depois da
exportação (22:36 de 14/10); se passou tempo, pedir uma exportação nova, salvá-la como
f200.ORIGINAL.sql e rodar de novo.
"""
import os
import re
import subprocess
import sys
import tempfile

AQUI = os.path.dirname(os.path.abspath(__file__))
ENT = os.path.join(AQUI, 'f200.ORIGINAL.sql')
SAI = os.path.join(AQUI, 'f200.sql')
PAGINAS = [(16, 'aplicar-quadro-pagina16.py', 'NC_QUADRO_INDICADORES'),
           (21, 'aplicar-histfin-pagina21.py', 'NC_HISTFIN_INDICADORES'),
           (25, 'aplicar-afastamentos-pagina25.py', 'NC_AFAST_INDICADORES'),
           (26, 'aplicar-feriaspainel-pagina26.py', 'NC_FERIAS_INDICADORES'),
           (30, 'aplicar-posicoes-pagina30.py', 'NC_POSICOES_INDICADORES'),
           (150, 'aplicar-acidpainel-pagina150.py', 'NC_ACID_INDICADORES'),
           (164, 'aplicar-beneficios-pagina164.py', 'NC_BENEF_INDICADORES')]
DESLOCAMENTO_21 = 379179224163283603
ID = re.compile(r'wwv_flow_api\.id\((\d+)\)')

app = open(ENT, encoding='utf-8').read()


def limites(t, n):
    a = t.index('prompt --application/pages/page_%05d\n' % n)
    return a, t.index('prompt --application/', a + 10)


def desloca(t, d):
    return ID.sub(lambda m: 'wwv_flow_api.id(%d)' % (int(m.group(1)) + d), t)


def rodar(args):
    r = subprocess.run([sys.executable] + args, cwd=AQUI, capture_output=True, text=True)
    if r.returncode:
        sys.exit('falhou: %s\n%s%s' % (' '.join(args), r.stdout, r.stderr))


conferir = []
with tempfile.TemporaryDirectory() as tmp:
    for n, script, marca in PAGINAS:
        a, b = limites(app, n)
        bloco = app[a:b]
        if marca in bloco:
            sys.exit('a página %d do app já tem %s: conferir à mão' % (n, marca))
        avulsa = open(os.path.join(AQUI, 'f200_page_%d.ORIGINAL.sql' % n), encoding='utf-8').read()
        cab = avulsa[:avulsa.index('prompt --application/pages/page_%05d\n' % n)]
        rod = avulsa[avulsa.index('prompt --application/end_environment'):]
        d = DESLOCAMENTO_21 if n == 21 else 0
        arq = os.path.join(tmp, 'p%d.sql' % n)
        open(arq, 'w', encoding='utf-8').write(cab + desloca(bloco, -d) + rod)
        rodar([script, arq, arq])
        t = open(arq, encoding='utf-8').read()
        novo = desloca(t[t.index('prompt --application/pages/page_%05d\n' % n):t.index('prompt --application/end_environment')], d)
        if marca not in novo:
            sys.exit('a página %d não saiu como esperado' % n)
        app = app[:a] + novo + app[b:]
        conferir.append((n, marca, len(novo) - len(bloco)))

# 108: a correção que ficou de fora (o plugin usava DESCRICAO como texto da barra)
a, b = limites(app, 108)
bloco = app[a:b]
velho = "'    apex_json.write(''headline'', r.titulo);',\n'    apex_json.write(''text'', r.descricao);',"
certo = "'    apex_json.write(''headline'', r.descricao);',\n'    apex_json.write(''text'', r.titulo);',"
if bloco.count(velho) != 1 and bloco.count(certo) != 1:
    sys.exit('a página 108 não está como esperado (headline/text): conferir à mão')
novo = bloco.replace(velho, certo)
app = app[:a] + novo + app[b:]
conferir.append((108, 'headline = descricao', len(novo) - len(bloco)))

fora = sorted({c for c in app if ord(c) > 255})
if fora:
    sys.exit('caractere fora do Latin-1 na exportação (o banco não guarda): %r' % fora)
open(SAI, 'w', encoding='utf-8').write(app)
for n, marca, d in conferir:
    print('página %d: %s (%+d caracteres)' % (n, marca, d))
print('ok ->', SAI)
