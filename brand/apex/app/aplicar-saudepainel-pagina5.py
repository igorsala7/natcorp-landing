"""Põe o painel "Saúde e segurança do trabalho" na EXPORTAÇÃO da página 5 do app 2937 (Dados de Funcionário).

    python3 aplicar-saudepainel-pagina5.py <entrada.sql> <saida.sql>

Se a página JÁ tem o painel (exportada depois de importar), troca só o PL/SQL do processo
NC_SAUDE_INDICADORES — é assim que uma versão nova do processo entra. O que muda (o resto da
página fica como veio: regiões, itens, relatório, ações):
  1. a página ganha os File URLs  #WORKSPACE_IMAGES#Natcorp_SaudePainel.js / .css
  2. o relatório "Dados de Funcionário" ganha o Static ID COLABORADORES (o painel se põe acima dele
     e usa a busca dele no "ver na lista")
  3. entra o processo Ajax Callback NC_SAUDE_INDICADORES (os números), com o PL/SQL de
     NC_SAUDE_INDICADORES.plsql.sql — a ficha grande fica no arquivo; no processo entra uma curta, e
     os símbolos fora do Latin-1 viram texto simples (o banco troca … por ¿).
A página é reconhecida pelo CONTEÚDO (o relatório sobre informacoes_funcionais/inf_pessoais_cad/
local_trab e os itens P5_*), nunca pelos IDs. Guia: SAUDEPAINEL-MANUTENCAO.md.
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
FONTE = os.path.join(AQUI, 'NC_SAUDE_INDICADORES.plsql.sql')
JS = "#WORKSPACE_IMAGES#Natcorp_SaudePainel.js"
CSS = "#WORKSPACE_IMAGES#Natcorp_SaudePainel.css"
ID_PROCESSO = '990005000000000002'

if len(sys.argv) != 3:
    raise SystemExit(__doc__)
ent, sai = sys.argv[1], sys.argv[2]
s = open(ent, encoding='latin-1').read()


def troca(a, b):
    global s
    if s.count(a) != 1:
        raise SystemExit('esperava 1 ocorrência de: ' + a[:80] + ' (achei %d)' % s.count(a))
    s = s.replace(a, b)


TROCA = {'─': '-', '═': '=', '…': '...', '→': '->', '≠': '<>', '≥': '>=', '≤': '<=', '—': '-', '–': '-',
         '“': '"', '”': '"', '‘': "'", '’': "'", '−': '-', '╔': '+', '╗': '+', '╚': '+', '╝': '+', '║': '|', '×': 'x', '·': '-'}


def latin1(t):
    for k, v in TROCA.items():
        t = t.replace(k, v)
    ruim = sorted({c for c in t if ord(c) > 255})
    if ruim:
        raise SystemExit('caracteres fora do Latin-1 no PL/SQL: ' + ' '.join(ruim))
    return t


def junta(texto):
    """no formato da exportação: uma linha por item, aspas dobradas; acentos em unistr (o arquivo fica ASCII)"""
    linhas = texto.rstrip('\n').split('\n')
    out = []
    for l in linhas:
        q = l.replace("'", "''")
        if any(ord(c) > 127 for c in q):
            q = q.replace('\\', '\\005C')
            q = ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in q)
            out.append("unistr('" + q + "')")
        else:
            out.append("'" + q + "'")
    return 'wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(out) + '))'


fonte = open(FONTE, encoding='utf-8').read()
corpo = latin1('/* NATCORP - painel "Saude e seguranca do trabalho" (Natcorp_SaudePainel.js). FONTE: brand/apex/app/NC_SAUDE_INDICADORES.plsql.sql\n'
               '   (guia SAUDEPAINEL-MANUTENCAO.md). Mude la e aplique de novo com aplicar-saudepainel-pagina5.py. */\n'
               + fonte[fonte.index('\ndeclare\n') + 1:])

if "p_process_name=>'NC_SAUDE_INDICADORES'" in s:
    if JS not in s or CSS not in s:
        raise SystemExit('a página tem o processo mas não os File URLs do painel: conferir à mão')
    i = s.index("p_process_name=>'NC_SAUDE_INDICADORES'\n,p_process_sql_clob=>")
    i = s.index(',p_process_sql_clob=>', i) + len(',p_process_sql_clob=>')
    j = s.index("\n,p_error_display_location=>", i)
    s = s[:i] + junta(corpo) + s[j:]
    open(sai, 'w', encoding='latin-1').write(s)
    print(os.path.basename(sai), len(s.encode('latin-1')) // 1024, 'KB · NC_SAUDE_INDICADORES trocado (a página já tinha o painel)')
    raise SystemExit(0)
if 'Natcorp_SaudePainel' in s:
    raise SystemExit('esta exportação tem os File URLs do painel mas não o processo: conferir à mão')
if 'from informacoes_funcionais infu' not in s or "p_name=>'P5_SITUACAO'" not in s or "p_name=>'P5_MATRICULA'" not in s:
    raise SystemExit('este arquivo não parece a página 5 (Dados de Funcionário): conferir')

# 1. os arquivos da página
troca(",p_autocomplete_on_off=>'OFF'\n,p_inline_css=>",
      ",p_autocomplete_on_off=>'OFF'\n,p_javascript_file_urls=>'%s'\n,p_css_file_urls=>'%s'\n,p_inline_css=>" % (JS, CSS))

# 2. o Static ID do relatório (o create_page_plug cujo SQL é o da lista)
i = s.index("'select infu.cod_empresa cod_empresa_dsp',")
k = s.rindex('wwv_flow_api.create_page_plug(', 0, i)
bloco = s[k:i]
if 'p_region_name=>' in bloco:
    raise SystemExit('o relatório já tem Static ID: conferir (o painel espera COLABORADORES)')
a = bloco.index("\n,p_plug_name=>")
a = bloco.index('\n', a + 1)
s = s[:k] + bloco[:a] + "\n,p_region_name=>'COLABORADORES'" + bloco[a:] + s[i:]

# 3. o processo dos números (o único processo da página), antes do fim do último bloco
processo = """wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(%s)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_SAUDE_INDICADORES'
,p_process_sql_clob=>%s
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""" % (ID_PROCESSO, junta(corpo))
troca("end;\n/\nprompt --application/end_environment", processo + "end;\n/\nprompt --application/end_environment")

open(sai, 'w', encoding='latin-1').write(s)
print(os.path.basename(sai), len(s.encode('latin-1')) // 1024, 'KB · File URLs + Static ID COLABORADORES + NC_SAUDE_INDICADORES')
