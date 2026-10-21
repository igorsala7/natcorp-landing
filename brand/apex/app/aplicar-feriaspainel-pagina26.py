"""Acrescenta o painel "Resumo das férias" a uma EXPORTAÇÃO da página 26 do app 200 ("Férias") que já
tem o desenho da Linha do Tempo.

    python3 aplicar-linhatempo-pagina26.py f200_page_26.ORIGINAL.sql /tmp/p26-lt.sql
    python3 aplicar-feriaspainel-pagina26.py /tmp/p26-lt.sql f200_page_26.sql

O que muda (o resto da página fica como veio — regiões, itens, relatório, ações, o LinhaTempo):
  1. os File URLs ganham, AO LADO do Natcorp_LinhaTempo, o Natcorp_FeriasPainel.js / .css
  2. entra o processo Ajax Callback NC_FERIAS_INDICADORES (os números), com o PL/SQL de
     NC_FERIAS_INDICADORES.plsql.sql — no processo entra uma ficha curta e os símbolos fora do
     Latin-1 viram texto simples (o banco troca … por ¿).
Guia: FERIASPAINEL-MANUTENCAO.md.
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
FONTE = os.path.join(AQUI, 'NC_FERIAS_INDICADORES.plsql.sql')
ID_PROCESSO = '990026000000000002'

if len(sys.argv) != 3:
    raise SystemExit(__doc__)
ent, sai = sys.argv[1], sys.argv[2]
s = open(ent, encoding='utf-8').read()

def troca(a, b):
    global s
    if s.count(a) != 1:
        raise SystemExit('esperava 1 ocorrência de: ' + a[:90] + ' (achei %d)' % s.count(a))
    s = s.replace(a, b)

TROCA = {'─': '-', '═': '=', '…': '...', '→': '->', '≠': '<>', '≥': '>=', '≤': '<=', '—': '-', '–': '-',
         '“': '"', '”': '"', '‘': "'", '’': "'", '•': '-'}
def latin1(t):
    for k, v in TROCA.items():
        t = t.replace(k, v)
    ruim = sorted({c for c in t if ord(c) > 255})
    if ruim:
        raise SystemExit('caracteres fora do Latin-1 no PL/SQL: ' + ' '.join(ruim))
    return t

def junta(texto):
    linhas = texto.rstrip('\n').split('\n')
    return 'wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join("'" + l.replace("'", "''") + "'" for l in linhas) + '))'

if 'NC_FERIAS_INDICADORES' in s or 'Natcorp_FeriasPainel' in s:
    raise SystemExit('esta exportação já tem o painel: rode sobre a saída do aplicar-linhatempo-pagina26.py')
if 'NC_LINHA_TEMPO_DADOS' not in s:
    raise SystemExit('esta exportação ainda não tem a Linha do Tempo: rode antes o aplicar-linhatempo-pagina26.py')

# 1. os arquivos, ao lado do LinhaTempo
troca(",p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_LinhaTempo.js'\n",
      ",p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'#WORKSPACE_IMAGES#Natcorp_LinhaTempo.js',\n'#WORKSPACE_IMAGES#Natcorp_FeriasPainel.js'))\n")
troca(",p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_LinhaTempo.css'\n",
      ",p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'#WORKSPACE_IMAGES#Natcorp_LinhaTempo.css',\n'#WORKSPACE_IMAGES#Natcorp_FeriasPainel.css'))\n")

# 2. o processo dos números, no fim do último bloco (antes do end_environment)
fonte = open(FONTE, encoding='utf-8').read()
corpo = latin1('/* NATCORP - painel de ferias (Natcorp_FeriasPainel.js). FONTE: brand/apex/app/NC_FERIAS_INDICADORES.plsql.sql\n'
               '   (guia FERIASPAINEL-MANUTENCAO.md). Mude la e aplique de novo com aplicar-feriaspainel-pagina26.py. */\n'
               + fonte[fonte.index('\ndeclare\n') + 1:])   # a LINHA 'declare' (a ficha do arquivo também cita a palavra)
processo = """wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(%s)
,p_process_sequence=>30
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_FERIAS_INDICADORES'
,p_process_sql_clob=>%s
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""" % (ID_PROCESSO, junta(corpo))
fim = "end;\n/\nprompt --application/end_environment\n"
troca(fim, processo + fim)

open(sai, 'w', encoding='utf-8').write(s)
print(os.path.basename(sai), len(s.encode()) // 1024, 'KB · File URLs + NC_FERIAS_INDICADORES')
