"""Põe o painel "Conferência do ponto" na EXPORTAÇÃO da página 204 do app 9503 (Abono Individual).

    python3 aplicar-pontopainel-pagina204.py <entrada.sql> <saida.sql>

Funciona sobre a exportação da página OU sobre o bloco da página dentro do app inteiro (o
montar-f9503.py usa assim). Se a página JÁ tem o painel (exportada depois de importar), troca só o
PL/SQL do processo NC_PONTO_INDICADORES — é assim que uma versão nova do processo entra. O que muda (o resto da página fica como veio: regiões, itens,
relatório, ações, processos):
  1. a página ganha os File URLs  #WORKSPACE_IMAGES#Natcorp_PontoPainel.js / .css
  2. entra o processo Ajax Callback NC_PONTO_INDICADORES (os números), com o PL/SQL de
     NC_PONTO_INDICADORES.plsql.sql — a ficha grande fica no arquivo; no processo entra uma curta, e
     os símbolos fora do Latin-1 viram texto simples (o banco troca … por ¿).
A página é reconhecida pelo CONTEÚDO (o relatório "Colaboradores" sobre pe_escalas_excecoes e o
processo SETA_USER), nunca pelos IDs. Guia: PONTOPAINEL-MANUTENCAO.md.
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
FONTE = os.path.join(AQUI, 'NC_PONTO_INDICADORES.plsql.sql')
JS = "#WORKSPACE_IMAGES#Natcorp_PontoPainel.js"
CSS = "#WORKSPACE_IMAGES#Natcorp_PontoPainel.css"
ID_PROCESSO = '990204000000000002'

if len(sys.argv) != 3:
    raise SystemExit(__doc__)
ent, sai = sys.argv[1], sys.argv[2]
s = open(ent, encoding='utf-8').read()


def troca(a, b):
    global s
    if s.count(a) != 1:
        raise SystemExit('esperava 1 ocorrência de: ' + a[:80] + ' (achei %d)' % s.count(a))
    s = s.replace(a, b)


TROCA = {'─': '-', '═': '=', '…': '...', '→': '->', '≠': '<>', '≥': '>=', '≤': '<=', '—': '-', '–': '-',
         '“': '"', '”': '"', '‘': "'", '’': "'", '−': '-', '╔': '+', '╗': '+', '╚': '+', '╝': '+', '║': '|'}


def latin1(t):
    for k, v in TROCA.items():
        t = t.replace(k, v)
    ruim = sorted({c for c in t if ord(c) > 255})
    if ruim:
        raise SystemExit('caracteres fora do Latin-1 no PL/SQL: ' + ' '.join(ruim))
    return t


def junta(texto):
    """no formato da exportação: uma linha por item, aspas dobradas"""
    linhas = texto.rstrip('\n').split('\n')
    return 'wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join("'" + l.replace("'", "''") + "'" for l in linhas) + '))'


fonte = open(FONTE, encoding='utf-8').read()
corpo = latin1('/* NATCORP - painel "Conferencia do ponto" (Natcorp_PontoPainel.js). FONTE: brand/apex/app/NC_PONTO_INDICADORES.plsql.sql\n'
               '   (guia PONTOPAINEL-MANUTENCAO.md). Mude la e aplique de novo com aplicar-pontopainel-pagina204.py. */\n'
               + fonte[fonte.index('\ndeclare\n') + 1:])

# a página JÁ tem o painel (exportada depois de importar): troca só o PL/SQL do processo
if "p_process_name=>'NC_PONTO_INDICADORES'" in s:
    if JS not in s or CSS not in s:
        raise SystemExit('a página tem o processo mas não os File URLs do painel: conferir à mão')
    i = s.index("p_process_name=>'NC_PONTO_INDICADORES'\n,p_process_sql_clob=>")
    i = s.index(',p_process_sql_clob=>', i) + len(',p_process_sql_clob=>')
    j = s.index("\n,p_error_display_location=>", i)
    s = s[:i] + junta(corpo) + s[j:]
    open(sai, 'w', encoding='utf-8').write(s)
    print(os.path.basename(sai), len(s.encode()) // 1024, 'KB · NC_PONTO_INDICADORES trocado (a página já tinha o painel)')
    raise SystemExit(0)
if 'Natcorp_PontoPainel' in s:
    raise SystemExit('esta exportação tem os File URLs do painel mas não o processo: conferir à mão')
if 'pe_escalas_excecoes e' not in s or "p_process_name=>'SETA_USER'" not in s or "p_region_name=>'COLABORADORES'" not in s:
    raise SystemExit('este arquivo não parece a página 204 (Abono Individual): conferir')

# 1. os arquivos da página
troca(",p_autocomplete_on_off=>'ON'\n,p_javascript_code=>",
      ",p_autocomplete_on_off=>'ON'\n,p_javascript_file_urls=>'%s'\n,p_javascript_code=>" % JS)
troca("\n,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'td[headers=FOTO] img { height: 50px }',",
      "\n,p_css_file_urls=>'%s'\n,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'td[headers=FOTO] img { height: 50px }'," % CSS)

# 2. o processo dos números, logo depois do processo SETA_USER
processo = """wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(%s)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_PONTO_INDICADORES'
,p_process_sql_clob=>%s
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""" % (ID_PROCESSO, junta(corpo))
troca("""'v_usuario := usuario.busca_user;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""", """'v_usuario := usuario.busca_user;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""" + processo)

open(sai, 'w', encoding='utf-8').write(s)
print(os.path.basename(sai), len(s.encode()) // 1024, 'KB · File URLs + NC_PONTO_INDICADORES')
