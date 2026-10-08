"""Leva para o app 300 (exportação COMPLETA, f300.sql) os desenhos já feitos nas MESMAS páginas de
outros apps, rodando o script de aplicação de cada um sobre o trecho da página dentro do app.

    python3 aplicar-redesenhos-app300.py f300.sql [saida.sql]

Como: para cada par da lista PARES, recorta o trecho da página ("prompt --application/pages/page_NNNNN"
até o próximo "prompt --application/"), monta um arquivo de página temporário (o cabeçalho do app,
com o nº do app que o script espera, + o trecho), roda o script de sempre, e devolve o trecho
alterado ao lugar. Página com outro número (863 ↔ 865, 54 ↔ 132) é RENOMEADA no temporário e
desfeita na volta (só se o trecho original não tiver o nome de destino — senão para).
Nada fora das páginas da lista é tocado (conferido no fim, byte a byte). Página que já tem o
desenho fica como está. Script que recusa a página: a página fica como está e o motivo é contado.
Guia: CONSULTA-MANUTENCAO.md › "Desenhos de outros apps no 300".
"""
import os
import re
import subprocess
import sys
import tempfile

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f300.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
AQUI = os.path.dirname(os.path.abspath(__file__))

# (página do 300, script, app que o script espera, página que o script espera, marca do desenho
#  [, regiões opcionais "A|B", nomes alternativos "Nome=Outro|…"])
# 863 GED = a pasta da 2210:865 (pedido de 04/10), sem as regiões Terceiro/Outros.
# Fora de propósito: 140/144 Avaliação (a do 300 é outra página: metade das regiões difere); 38 e 53 (cópias antigas
# da 136/134 que nada no app abre — só o breadcrumb).
PARES = [
    (17, 'aplicar-ficha-pagina17.py', 200, 17, 'Natcorp_Ficha', 'Benefícios Relatório|Benefícios|Dependentes|Dependentes - IR'),
    (54, 'aplicar-dependentes-pagina132.py', 200, 132, 'Natcorp_Dependentes', 'Documentos'),
    (108, 'aplicar-linhatempo-pagina108.py', 300, 108, 'Natcorp_LinhaTempo'),
    (118, 'aplicar-treinamento-pagina118.py', 200, 118, 'Natcorp_Treinamento'),
    (120, 'aplicar-treinamento-pagina120.py', 200, 120, 'Natcorp_Treinamento', 'Aprovadores', 'Solicitante=Colaborador Solicitante'),
    (132, 'aplicar-dependentes-pagina132.py', 200, 132, 'Natcorp_Dependentes'),
    (168, 'aplicar-beneficios-pagina168.py', 200, 168, 'Natcorp_Beneficios'),
    (714, 'aplicar-abono-pagina714.py', 9503, 714, 'Natcorp_Abono'),
    (716, 'aplicar-horaextra.py', 9503, 716, 'Natcorp_HoraExtra'),
    (863, 'aplicar-documentos-pagina865.py', 2210, 865, 'Natcorp_Documentos', 'Documentos Terceiro|Documentos Outros'),
]

s = open(ENTRADA, encoding='utf-8').read()
if 'p_default_application_id=>300\n' not in s or 'Export Type:     Application Export' not in s:
    sys.exit('este arquivo não é a exportação completa do app 300')
fim_cab = s.index('end;\n/\n', s.index('wwv_flow_api.import_begin')) + len('end;\n/\n')
CAB = s[:fim_cab]
ROD = ('\nprompt --application/end_environment\nbegin\n'
       'wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));\n'
       'commit;\nend;\n/\nset verify on feedback on define on\nprompt  ...done\n')


def trecho(t, n):
    a = t.index('prompt --application/pages/page_%05d\n' % n)
    b = t.find('\nprompt --application/', a + 10)
    return a, b


def renomear(blk, de, para):
    """página `de` → `para` (p_id, delete/page prompts e prefixo dos itens Pde_ → Ppara_)"""
    if de == para:
        return blk
    if re.search(r'\bP%d_' % para, blk) or ('page_%05d' % para) in blk:
        raise ValueError('o trecho já tem nomes da página %d: renomear seria ambíguo' % para)
    blk = blk.replace('page_%05d' % de, 'page_%05d' % para)
    blk = re.sub(r'(\n p_id=>)%d\n' % de, r'\g<1>%d\n' % para, blk, count=1)
    return re.sub(r'\bP%d_' % de, 'P%d_' % para, blk)


def renumerar(blk, pag, todo):
    """Os scripts das páginas criam componentes (regiões, itens, ações) com ids FIXOS — os mesmos que
    já entraram no app de origem (ex.: 200:168). O id do APEX é único na instância INTEIRA, não por app:
    levar o mesmo id para o 300 dá ORA-00001 WWV_FLOW_PAGE_PLUGS_PK no import (visto em 05/10, 168).
    Então todo id que o script criou (não existe em nenhum lugar do app) ganha um número do 300 e
    desta página: 28299 0300 PPPP 8 NNNNNN, na ordem em que aparece (mesmo resultado a cada rodada)."""
    vistos = []
    for i in re.findall(r'wwv_flow_api\.id\((\d+)\)', blk):
        if i not in vistos and ('wwv_flow_api.id(%s)' % i) not in todo:
            vistos.append(i)
    for k, i in enumerate(vistos, 1):
        nid = '28299%04d%04d8%06d' % (300, pag, k)
        if ('wwv_flow_api.id(%s)' % nid) in todo or ('wwv_flow_api.id(%s)' % nid) in blk:
            sys.exit('ERRO: o id %s (renumeração da %d) já existe — nada foi gravado' % (nid, pag))
        blk = blk.replace('wwv_flow_api.id(%s)' % i, 'wwv_flow_api.id(%s)' % nid)
    return blk, len(vistos)


relat, novo = [], s
for par in PARES:
    pag, script, app_esp, pag_esp, marca = par[:5]
    opc = par[5] if len(par) > 5 else ''
    ali = par[6] if len(par) > 6 else ''
    a, b = trecho(novo, pag)
    blk = novo[a:b]
    if marca in blk:
        relat.append('%5d já tinha %s' % (pag, marca)); continue
    try:
        tmp_blk = renomear(blk, pag, pag_esp)
    except ValueError as e:
        relat.append('%5d PULADA: %s' % (pag, e)); continue
    cab = re.sub(r'p_default_application_id=>\d+', 'p_default_application_id=>%d' % app_esp, CAB, count=1)
    with tempfile.TemporaryDirectory() as d:
        ent, sai = os.path.join(d, 'ent.sql'), os.path.join(d, 'sai.sql')
        open(ent, 'w', encoding='utf-8').write(cab + tmp_blk + ROD)
        amb = dict(os.environ, NC_REGIOES_OPCIONAIS=opc, NC_REGIOES_ALIAS=ali)
        r = subprocess.run([sys.executable, os.path.join(AQUI, script), ent, sai], capture_output=True, text=True, cwd=AQUI, env=amb)
        if r.returncode != 0 or not os.path.exists(sai):
            relat.append('%5d RECUSADA por %s: %s' % (pag, script, (r.stderr or r.stdout).strip().splitlines()[-1:] or '?'))
            continue
        out = open(sai, encoding='utf-8').read()
    oa = out.index('prompt --application/pages/page_%05d\n' % pag_esp)
    ob = out.index('\nprompt --application/end_environment', oa)
    blk2 = out[oa:ob]
    if pag != pag_esp:
        blk2 = blk2.replace('page_%05d' % pag_esp, 'page_%05d' % pag)
        blk2 = re.sub(r'(\n p_id=>)%d\n' % pag_esp, r'\g<1>%d\n' % pag, blk2, count=1)
        blk2 = re.sub(r'\bP%d_' % pag_esp, 'P%d_' % pag, blk2)
    if marca not in blk2:
        relat.append('%5d SEM EFEITO (%s rodou mas o desenho não entrou)' % (pag, script)); continue
    blk2, n_ren = renumerar(blk2, pag, novo)
    novo = novo[:a] + blk2 + novo[b:]
    relat.append('%5d aplicado (%s)%s' % (pag, script, ' · %d id(s) novos renumerados' % n_ren if n_ren else ''))

# ---------- conferências ----------
def fora(t, paginas):
    partes, p0 = [], 0
    for n in sorted(paginas, key=lambda n: t.index('prompt --application/pages/page_%05d\n' % n)):
        a, b = trecho(t, n); partes.append(t[p0:a]); p0 = b
    partes.append(t[p0:])
    return ''.join(partes)
pags = [p[0] for p in PARES]
if fora(novo, pags) != fora(s, pags):
    sys.exit('ERRO: algo fora das páginas da lista mudou — nada foi gravado')
from collections import Counter
antes = Counter(re.findall(r'\n p_id=>(wwv_flow_api\.id\(\d+\))\n', s))
depois = Counter(re.findall(r'\n p_id=>(wwv_flow_api\.id\(\d+\))\n', novo))
rep = sorted(i for i in depois if depois[i] > 1 and depois[i] > antes.get(i, 0))   # só repetição NOVA
if rep:
    sys.exit('ERRO: identificador repetido no app: %s — nada foi gravado' % rep[:5])
open(SAIDA, 'w', encoding='utf-8').write(novo)
print('\n'.join(relat))
print('ok → %s (fora das %d páginas, igual; nenhum identificador repetido)' % (SAIDA, len(pags)))
