"""Aplica o HISTÓRICO DE CONSULTAS (Natcorp_HistoricoConsultas.js/.css) numa EXPORTAÇÃO da página 26 do
app 2937 ("Consulta Matricula", a janela aberta pela Agenda).

    python3 aplicar-historicoconsultas-pagina26.py f2937_page_26.sql [saida.sql]

(NÃO confundir com aplicar-linhatempo-pagina26.py, que é a página 26 do app 200 — Férias.)

Reconhece a página pelo CONTEÚDO: os itens P26_COD_PACIENTE e P26_TIPO_PACIENTE e o relatório sobre
AGENDAS_MEDICOS_HORARIOS. O que muda (tudo visível no Page Designer):
  • as duas URLs de arquivo e o comentário da página;
  • o título da janela: "Consulta Matricula" → "Histórico de consultas";
  • o relatório "Horários" passa a respeitar Data Inicial / Data final (os campos existiam, a ação
    dinâmica atualizava o relatório, mas a consulta não os usava) e manda as datas junto;
  • um processo novo (Ajax Callback) NC_HIST_CONSULTAS: o histórico do paciente em JSON.
NENHUM item, ação dinâmica ou outro processo é tocado. Roda de novo sem alterar duas vezes.
Guia: HISTORICOCONSULTAS-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2937_page_26.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_HistoricoConsultas' in s

if "p_name=>'P26_COD_PACIENTE'" not in s or "p_name=>'P26_TIPO_PACIENTE'" not in s or 'from agendas_medicos_horarios' not in s:
    sys.exit('este arquivo não é a janela "Consulta Matricula" (itens P26_COD_PACIENTE/P26_TIPO_PACIENTE e relatório sobre AGENDAS_MEDICOS_HORARIOS)')
APP = int(re.search(r'p_default_application_id=>(\d+)', s).group(1))

JS = '#WORKSPACE_IMAGES#Natcorp_HistoricoConsultas.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_HistoricoConsultas.css'

LINHAS_26 = [
    'DESENHO DA TELA (Natcorp_HistoricoConsultas.css / Natcorp_HistoricoConsultas.js)',
    '',
    'O HISTÓRICO DE CONSULTAS do paciente: quem é (código - nome, funcionário ou candidato, empresa), o resumo',
    'em uma frase e a faixa de comparecimento (uma marca por consulta, na cor da situação); a próxima consulta;',
    'a lista por ano com data, tipo, profissional, situação (Realizada / Veio, não foi atendido / Faltou /',
    'Agendada / Sem registro) e os horários numa frase; filtros de período, situação, tipo, profissional e',
    'busca. "Trocar paciente" abre a pesquisa; "Tabela" mostra o relatório original. Só LÊ, pelo processo',
    'NC_HIST_CONSULTAS. Vinda da Agenda (botão "Histórico de consultas"), já abre com o paciente.',
    'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/HISTORICOCONSULTAS-MANUTENCAO.md.',
]

def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def des_uni(lit):
    """uma linha do wwv_flow_t_varchar2 ('...' ou unistr('...')) de volta para texto"""
    m = re.match(r"^(unistr\()?'(.*)'\)?$", lit.strip())
    t = m.group(2).replace("''", "'")
    if m.group(1):
        t = re.sub(r'\\([0-9A-Fa-f]{4})', lambda x: chr(int(x.group(1), 16)), t)
    return t


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]



LINHAS = LINHAS_26


def comentario(t):
    novo = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))\n'
    m = re.search(r"^,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)|'(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))\n", t, re.M | re.S)
    if m:
        return t[:m.start()] + novo + t[m.end():]
    ancora = next((k for k in ('help_text', 'protection_level', 'autocomplete_on_off') if re.search(r'^,p_' + k + r'=>', t, re.M)), 'name')
    return poe(t, ancora, novo.rstrip('\n'))


def pagina(t):
    if re.search(r'^,p_(javascript|css)_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_HistoricoConsultas)')
    t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")
    t = poe(t, 'javascript_file_urls', ",p_css_file_urls=>'" + CSS + "'")
    return comentario(t)



m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
pg = comentario(m.group(0)) if JA else pagina(m.group(0))
pg = pg.replace(",p_step_title=>'Consulta Matricula'", ",p_step_title=>unistr('Hist\\00F3rico de consultas')")
s = s[:m.start()] + pg + s[m.end():]

# ---------- o relatório "Horários" passa a respeitar as datas ----------
VELHA = "' order by data_agenda desc'))"
NOVA = "\n".join([
    "'   and (:P26_DATA_INICIAL is null or data_agenda >= to_date(:P26_DATA_INICIAL, ''dd/mm/yyyy''))',",
    "'   and (:P26_DATA_FINAL is null or data_agenda < to_date(:P26_DATA_FINAL, ''dd/mm/yyyy'') + 1)',",
    "' order by data_agenda desc'))",
])
if 'P26_DATA_INICIAL is null' not in s:
    if s.count(VELHA) != 1:
        sys.exit('a consulta do relatório "Horários" mudou: junte o filtro de datas à mão')
    s = s.replace(VELHA, NOVA)
s = s.replace(",p_ajax_items_to_submit=>'P26_COD_EMPRESA,P26_TIPO_PACIENTE,P26_COD_PACIENTE'\n,p_plug_query_options",
              ",p_ajax_items_to_submit=>'P26_COD_EMPRESA,P26_TIPO_PACIENTE,P26_COD_PACIENTE,P26_DATA_INICIAL,P26_DATA_FINAL'\n,p_plug_query_options")

# ---------- o processo (Ajax Callback) ----------
LER = [
    '-- Natcorp_HistoricoConsultas.js: o histórico do paciente na agenda (mesma tabela do relatório',
    '-- "Horários", sem o filtro de datas: o período é filtrado na tela). Guia: HISTORICOCONSULTAS-MANUTENCAO.md.',
    'begin',
    '  apex_json.open_object;',
    "  apex_json.open_array('consultas');",
    '  for c in (select to_char(h.data_agenda, \'dd/mm/yyyy\') dt,',
    '                   to_char(h.hora_inic_previsto, \'hh24:mi\') ini_prev,',
    '                   to_char(h.hora_fim_previsto, \'hh24:mi\') fim_prev,',
    '                   to_char(h.hora_chegada, \'hh24:mi\') chegada,',
    '                   to_char(h.hora_inicio_consulta, \'hh24:mi\') ini_real,',
    '                   to_char(h.hora_fim_consulta, \'hh24:mi\') fim_real,',
    '                   h.compareceu, h.realizou, h.cod_tipo_consulta,',
    '                   (select t.descricao from tipo_consulta t',
    '                     where t.cod_tipo_consulta = h.cod_tipo_consulta and rownum = 1) tipo_desc,',
    '                   h.cod_prestr_serv,',
    '                   (select p.nome from prestador_servico p',
    '                     where p.cod_prest_serv = h.cod_prestr_serv and p.tipo_prest_serv = \'1\' and rownum = 1) prof_nome',
    '              from agendas_medicos_horarios h',
    '             where h.cod_empresa   = :P26_COD_EMPRESA',
    '               and h.tipo_paciente = :P26_TIPO_PACIENTE',
    '               and h.cod_paciente  = :P26_COD_PACIENTE',
    '             order by h.data_agenda desc, h.hora_inic_previsto desc) loop',
    '    apex_json.open_object;',
    "    apex_json.write('data', c.dt);",
    "    apex_json.write('ini_prev', c.ini_prev);",
    "    apex_json.write('fim_prev', c.fim_prev);",
    "    apex_json.write('chegada', c.chegada);",
    "    apex_json.write('ini_real', c.ini_real);",
    "    apex_json.write('fim_real', c.fim_real);",
    "    apex_json.write('compareceu', c.compareceu);",
    "    apex_json.write('realizou', c.realizou);",
    "    apex_json.write('tipo', c.cod_tipo_consulta);",
    "    apex_json.write('tipo_desc', c.tipo_desc);",
    "    apex_json.write('prof', c.cod_prestr_serv);",
    "    apex_json.write('prof_nome', c.prof_nome);",
    '    apex_json.close_object;',
    '  end loop;',
    '  apex_json.close_array;',
    '  apex_json.close_object;',
    'end;',
]
seqs = [int(x) for x in re.findall(r"^,p_process_sequence=>(\d+)$", s, re.M)] or [0]
if "p_process_name=>'NC_HIST_CONSULTAS'" not in s:
    ID = 'wwv_flow_api.id(%s)' % ('28299%04d%04d%07d' % (APP, 26, 1))
    if ID in s:
        sys.exit('o id novo já existe neste arquivo: ' + ID)
    bloco = ('wwv_flow_api.create_page_process(\n'
             ' p_id=>' + ID + '\n'
             ',p_process_sequence=>' + str(max(seqs) + 10) + '\n'
             ",p_process_point=>'ON_DEMAND'\n"
             ",p_process_type=>'NATIVE_PLSQL'\n"
             ",p_process_name=>'NC_HIST_CONSULTAS'\n"
             ',p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LER) + '))\n'
             ",p_error_display_location=>'INLINE_IN_NOTIFICATION'\n"
             ',p_process_comment=>' + uni('Natcorp_HistoricoConsultas.js lê aqui o histórico do paciente. Guia: HISTORICOCONSULTAS-MANUTENCAO.md.') + '\n'
             ');\n')
    fim = s.rfind('end;\n/\nprompt --application/end_environment')
    if fim < 0:
        sys.exit('não achei o fim da página para pôr o processo')
    s = s[:fim] + bloco + s[fim:]

# ---------- conferência: nenhum atributo repetido em nenhum bloco ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
fora = [l for l in s.split('\n') if re.match(r"^,?p_[a-z0-9_]+=>'", l) and any(ord(c) > 127 for c in l)]
if fora:
    sys.exit('texto com acento sem unistr: ' + fora[0][:80])
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok (página 26 do app 2937' + (', só o comentário' if JA else '') + ') →', SAIDA)
