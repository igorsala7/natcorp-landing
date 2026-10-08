"""Aplica o desenho da Linha do Tempo numa EXPORTAÇÃO da página 108 do app 200.

    python3 aplicar-linhatempo-pagina108.py f200_page_108.sql [saida.sql] [--substituir-plugin]

O script reconhece a página pelo CONTEÚDO (nunca pelos IDs): um Interactive Report sobre a
vw_linha_do_tempo. O que muda (tudo visível no Page Designer; nenhuma região, item, validação ou
ação dinâmica existente é tocada):
  · a URL do Natcorp_LinhaTempo.js e a do Natcorp_LinhaTempo.css;
  · o comentário da página (o que o desenho faz e como desligar);
  · um processo NOVO, Processing › Ajax Callback › NC_LINHA_TEMPO_DADOS: entrega os fatos ao
    desenho, em JSON, com a mesma consulta do relatório, o filtro Fato, a checagem de acesso
    (f_acesso_pg_apex) e o salário só para quem pode ver (FNCT_TRATA_VERIF_SAL_NIVEL, calculado
    no servidor). Com ele, a região antiga do plugin pode ser apagada;
  · com --substituir-plugin: a classe nc-lt-fonte na região do plugin (ela e a aba saem da vista;
    o plugin continua como a fonte dos dados — não apague a região).
Roda de novo sobre um arquivo já alterado: não altera duas vezes (só atualiza o comentário).
Guia: LINHATEMPO-MANUTENCAO.md.
"""
import re
import sys

args = [a for a in sys.argv[1:] if not a.startswith('--')]
SUBST = '--substituir-plugin' in sys.argv
ENTRADA = args[0] if args else 'f200_page_108.sql'
SAIDA = args[1] if len(args) > 1 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_LinhaTempo' in s

if "p_plug_source_type=>'NATIVE_IR'" not in s or 'vw_linha_do_tempo' not in s:
    sys.exit('este arquivo não é a página da Linha do Tempo (Interactive Report sobre a vw_linha_do_tempo)')
PAG = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s).group(1)
APP = int(re.search(r'p_default_application_id=>(\d+)', s).group(1))

JS = '#WORKSPACE_IMAGES#Natcorp_LinhaTempo.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_LinhaTempo.css'


def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]


LINHAS = [
    'DESENHO DA TELA (Natcorp_LinhaTempo.css / Natcorp_LinhaTempo.js)',
    '',
    'No alto do relatório, um seletor com três jeitos de ver os mesmos fatos:',
    '  Tabela      o Interactive Report de sempre;',
    '  Trajetória  um Gantt: uma faixa por assunto (contrato e lotação, remuneração, férias e',
    '              saúde, desenvolvimento, ponto), cada fato uma barra do começo ao fim, a régua',
    '              dos anos, o "hoje" e o zoom; tocar numa barra mostra os detalhes;',
    '  Cronologia  os fatos por ano, com filtros por assunto; o ponto resumido por mês.',
    'Os dados vêm do processo Ajax Callback NC_LINHA_TEMPO_DADOS desta página: a mesma consulta do',
    'relatório (vw_linha_do_tempo), o filtro Fato, a checagem f_acesso_pg_apex e o salário só para quem',
    'pode ver (FNCT_TRATA_VERIF_SAL_NIVEL, no servidor). O plugin Linha do Tempo não é mais necessário.',
    'Para desligar tudo: tire as duas URLs de arquivo. Guia: brand/apex/app/LINHATEMPO-MANUTENCAO.md.',
]


def comentario(t):
    novo = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))\n'
    m = re.search(r"^,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)|'(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))\n", t, re.M | re.S)
    if m:
        return t[:m.start()] + novo + t[m.end():]
    ancora = next((k for k in ('help_text', 'protection_level', 'autocomplete_on_off') if re.search(r'^,p_' + k + r'=>', t, re.M)), 'name')
    return poe(t, ancora, novo.rstrip('\n'))


def pagina(t):
    if re.search(r'^,p_(javascript|css)_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_LinhaTempo)')
    t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")
    t = poe(t, 'javascript_file_urls', ",p_css_file_urls=>'" + CSS + "'")
    return comentario(t)


m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + (comentario(m.group(0)) if JA else pagina(m.group(0))) + s[m.end():]

# ---------- o processo que entrega os fatos ao desenho (Ajax Callback) ----------
PROC = 'NC_LINHA_TEMPO_DADOS'
if ("p_process_name=>'" + PROC + "'") not in s:
    ID_PROC = 'wwv_flow_api.id(%s)' % ('28299%04d%04d%07d' % (APP, int(PAG), 1))
    if ID_PROC in s:
        sys.exit('o id novo já existe neste arquivo: ' + ID_PROC)
    seqs = [int(x) for x in re.findall(r"^,p_process_sequence=>(\d+)$", s, re.M)] or [0]
    PLSQL = [
        '-- Entrega os fatos da Linha do Tempo ao Natcorp_LinhaTempo.js (Trajetória e Cronologia), em JSON.',
        '-- A mesma consulta do relatório; o salário só para quem pode ver, calculado AQUI (não confia no navegador).',
        'declare',
        '  v_sal boolean := nvl(fnct_trata_verif_sal_nivel(:p_usuario, :p108_emp, :p108_mat), false);',
        '  procedure data_json(p_nome varchar2, p_data date) is',
        '  begin',
        '    apex_json.open_object(p_nome);',
        '    if p_data is not null then',
        "      apex_json.write('year', to_number(to_char(p_data, 'yyyy')));",
        "      apex_json.write('month', to_number(to_char(p_data, 'mm')));",
        "      apex_json.write('day', to_number(to_char(p_data, 'dd')));",
        '    end if;',
        '    apex_json.close_object;',
        '  end;',
        'begin',
        '  apex_json.open_object;',
        "  apex_json.open_array('events');",
        '  for r in (select fato, data_ini, data_fim, titulo, descricao',
        '              from vw_linha_do_tempo',
        '             where cod_empresa = :p108_emp',
        '               and matricula = :p108_mat',
        "               and ((instr(':'||:p108_fato||':', ':'||fato||':') > 0) or (:p108_fato is null))",
        "               and f_acesso_pg_apex(cod_empresa, matricula, filial, cd_nivel, :p_usuario) = 'S'",
        '             order by data_ini, fato) loop',
        "    if upper(r.fato) in ('SALÁRIO', 'SALARIO') and not v_sal then",
        '      continue;   -- quem não pode ver salário não recebe nenhuma linha de salário',
        '    end if;',
        '    apex_json.open_object;',
        "    apex_json.write('group', r.fato);",
        "    data_json('start_date', r.data_ini);",
        "    data_json('end_date', r.data_fim);",
        "    apex_json.open_object('text');",
        "    apex_json.write('headline', r.descricao);  -- como o plugin: DESCRICAO e o texto da barra",
        "    apex_json.write('text', r.titulo);",
        '    apex_json.close_object;',
        '    apex_json.close_object;',
        '  end loop;',
        '  apex_json.close_array;',
        '  apex_json.close_object;',
        'end;',
    ]
    bloco = ('wwv_flow_api.create_page_process(\n'
             ' p_id=>' + ID_PROC + '\n'
             ',p_process_sequence=>' + str(max(seqs) + 10) + '\n'
             ",p_process_point=>'ON_DEMAND'\n"
             ",p_process_type=>'NATIVE_PLSQL'\n"
             ",p_process_name=>'" + PROC + "'\n"
             ',p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in PLSQL) + '))\n'
             ",p_error_display_location=>'INLINE_IN_NOTIFICATION'\n"
             ',p_process_comment=>' + uni('Natcorp_LinhaTempo.js: a Trajetória e a Cronologia pedem os fatos aqui (apex.server.process). Guia: LINHATEMPO-MANUTENCAO.md.') + '\n'
             ');\n')
    fim = s.rfind('end;\n/\nprompt --application/end_environment')
    if fim < 0:
        sys.exit('não achei o fim da página para pôr o processo')
    s = s[:fim] + bloco + s[fim:]

if SUBST:
    for b in re.finditer(r'wwv_flow_api\.create_page_plug\(\n.*?\n\);\n', s, re.S):
        if "p_plug_source_type=>'PLUGIN_COM.SB.REGION.TIMELINE'" in b.group(0):
            t = b.group(0)
            mc = re.search(r"^,p_region_css_classes=>'([^']*)'$", t, re.M)
            if mc:
                if 'nc-lt-fonte' not in mc.group(1).split():
                    t = t[:mc.start()] + ",p_region_css_classes=>'" + (mc.group(1) + ' nc-lt-fonte').strip() + "'" + t[mc.end():]
            else:
                t = poe(t, 'parent_plug_id' if re.search(r'^,p_parent_plug_id=>', t, re.M) else 'plug_name', ",p_region_css_classes=>'nc-lt-fonte'")
            s = s[:b.start()] + t + s[b.end():]
            break

# ---------- conferência: nenhum atributo repetido em nenhum bloco ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
fora = [l for l in s.split('\n') if re.match(r"^,?p_[a-z0-9_]+=>'", l) and any(ord(c) > 127 for c in l)]
if fora:
    sys.exit('texto com acento sem unistr: ' + fora[0][:80])
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok (página 108' + (', só o comentário' if JA else '') + (', plugin como fonte' if SUBST else '') + ') →', SAIDA)
