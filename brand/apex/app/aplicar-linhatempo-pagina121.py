"""Aplica o desenho da Linha do Tempo numa EXPORTAÇÃO da página 121 do app 200
("Linha do Tempo (Colab x Fato)": vários colaboradores).

    python3 aplicar-linhatempo-pagina121.py f200_page_121.sql [saida.sql]

O script reconhece a página pelo CONTEÚDO (nunca pelos IDs): um Interactive Report sobre a
vw_BI_linha_do_tempo. O que muda (tudo visível no Page Designer; nenhuma região, item, validação ou
ação dinâmica existente é tocada):
  · a URL do Natcorp_LinhaTempo.js e a do Natcorp_LinhaTempo.css;
  · o comentário da página (o que o desenho faz e como desligar);
  · um processo NOVO, Processing › Ajax Callback › NC_LINHA_TEMPO_DADOS: entrega os fatos ao
    desenho, em JSON, com o "quem" de cada fato (empresa-matrícula, nome, centro de custo e
    situação). O FROM e o WHERE são COPIADOS do relatório desta exportação — os mesmos filtros
    (Fato, datas, empresa, filial, centro de custo, matrícula, situação, vínculo, colaboradores
    diretos) e a mesma checagem de acesso; o salário só vai para quem pode ver
    (f_acesso_salario_apex, como no relatório, calculado no servidor). Mudou o filtro do
    relatório? Exporte de novo e rode este script: o processo acompanha.
    Corta em LIMITE fatos (o desenho avisa "Mostrando os primeiros N fatos").
Roda de novo sobre um arquivo já alterado: não altera duas vezes (só atualiza o comentário).
Guia: LINHATEMPO-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f200_page_121.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
LIMITE = 20000
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_LinhaTempo' in s

if "p_plug_source_type=>'NATIVE_IR'" not in s or 'vw_BI_linha_do_tempo' not in s:
    sys.exit('este arquivo não é a página "Linha do Tempo (Colab x Fato)" (Interactive Report sobre a vw_BI_linha_do_tempo)')
PAG = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s).group(1)
APP = int(re.search(r'p_default_application_id=>(\d+)', s).group(1))

JS = '#WORKSPACE_IMAGES#Natcorp_LinhaTempo.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_LinhaTempo.css'


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


# ---------- a consulta do relatório: o FROM e o WHERE vêm daqui ----------
ir = next(b.group(0) for b in re.finditer(r'wwv_flow_api\.create_page_plug\(\n.*?\n\);\n', s, re.S)
          if "p_plug_source_type=>'NATIVE_IR'" in b.group(0) and 'vw_BI_linha_do_tempo' in b.group(0))
fonte = re.search(r'p_plug_source=>wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n(.*?)\)\)\n', ir, re.S).group(1)
sql = [des_uni(l) for l in re.findall(r"^(?:unistr\()?'.*'\)?(?=,?$)", fonte, re.M)]
ini = next(k for k, l in enumerate(sql) if re.match(r'\s*from\s+vw_BI_linha_do_tempo\s+i\b', l, re.I))
fim = max(k for k, l in enumerate(sql) if re.match(r'\s*order\s+by\b', l, re.I))
DE_ONDE = ['    ' + l for l in sql[ini:fim]]
if not any('f_acesso' in l.lower() for l in DE_ONDE):
    sys.exit('o WHERE do relatório não tem a checagem de acesso (F_ACESSO): confira a exportação antes')

LINHAS = [
    'DESENHO DA TELA (Natcorp_LinhaTempo.css / Natcorp_LinhaTempo.js)',
    '',
    'No alto do relatório, um seletor com três jeitos de ver os mesmos fatos:',
    '  Tabela      o Interactive Report de sempre;',
    '  Trajetória  um Gantt com uma linha por colaborador (código - nome, centro de custo e',
    '              situação): fechada, um tracinho por mudança; tocar no nome abre as faixas da',
    '              pessoa (uma por fato). Busca por nome ou matrícula, ordem (Nome, Mais fatos, Mais',
    '              recente), abrir/fechar todos, zoom de anos a dias;',
    '  Cronologia  os fatos por ano, com o nome de quem é cada um, a mesma busca e filtros por assunto.',
    'Os dados vêm do processo Ajax Callback NC_LINHA_TEMPO_DADOS desta página, com o FROM e o WHERE',
    'copiados do relatório (os filtros do último Pesquisar, que estão na sessão, e a checagem de',
    'acesso); o salário só para quem pode ver (f_acesso_salario_apex, no servidor). Até %d fatos.' % LIMITE,
    'Mudou o filtro do relatório? Rode de novo aplicar-linhatempo-pagina121.py na exportação.',
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
        '-- Entrega os fatos da Linha do Tempo (vários colaboradores) ao Natcorp_LinhaTempo.js, em JSON.',
        '-- O FROM e o WHERE são os do relatório (copiados pelo aplicar-linhatempo-pagina121.py): os filtros',
        '-- do último Pesquisar (na sessão) e a checagem de acesso. O salário só para quem pode ver.',
        'declare',
        '  c_limite constant pls_integer := %d;' % LIMITE,
        '  v_n      pls_integer := 0;',
        '  v_cortou boolean := false;',
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
        '  for r in (',
        '    select i.cod_empresa, i.matricula, initcap(i.nome) nome,',
        "           i.cod_ccusto||' - '||initcap(i.nome_ccusto)||' · '||initcap(i.nome_situacao) sub,",
        '           i.fato, i.data_ini, i.data_fim, i.percentual, initcap(i.motivo_movto) motivo,',
        "           case when upper(i.fato) not in ('SALÁRIO', 'SALARIO') then",
        "                     case when i.cod_valor_fato is not null then decode(i.cod_valor_fato, '0', ' ', i.cod_valor_fato||' - ')||i.valor_fato else i.valor_fato end",
        "                when f_acesso_salario_apex(i.cod_empresa, i.matricula, i.filial, :p_usuario) = 'S' then",
        '                     i.valor_fato',
        "           end descricao,",
        "           case when upper(i.fato) in ('SALÁRIO', 'SALARIO') then 'S' else 'N' end eh_salario",
    ] + DE_ONDE + [
        '     order by i.cod_empresa, i.matricula, i.data_ini, i.fato) loop',
        "    if r.eh_salario = 'S' and r.descricao is null then",
        '      continue;   -- quem não pode ver salário não recebe nenhuma linha de salário',
        '    end if;',
        '    if v_n >= c_limite then',
        '      v_cortou := true;',
        '      exit;',
        '    end if;',
        '    v_n := v_n + 1;',
        '    apex_json.open_object;',
        "    apex_json.write('group', r.fato);",
        "    data_json('start_date', r.data_ini);",
        "    data_json('end_date', r.data_fim);",
        "    apex_json.open_object('text');",
        "    apex_json.write('headline', '('||r.fato||') '||trim(r.descricao)",
        "      ||case when r.eh_salario = 'S' and r.percentual is not null then ' Percentual: '||r.percentual end",
        "      ||case when r.motivo is not null then ' Motivo: '||r.motivo end);",
        "    apex_json.write('text', r.fato);",
        '    apex_json.close_object;',
        "    apex_json.open_object('quem');",
        "    apex_json.write('id', r.cod_empresa||'-'||r.matricula);",
        "    apex_json.write('mat', to_char(r.matricula));",
        "    apex_json.write('nome', r.nome);",
        "    apex_json.write('sub', r.sub);",
        '    apex_json.close_object;',
        '    apex_json.close_object;',
        '  end loop;',
        '  apex_json.close_array;',
        "  apex_json.write('cortado', v_cortou);",
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
             ',p_process_comment=>' + uni('Natcorp_LinhaTempo.js: a Trajetória e a Cronologia pedem os fatos aqui (apex.server.process). FROM/WHERE copiados do relatório pelo aplicar-linhatempo-pagina121.py. Guia: LINHATEMPO-MANUTENCAO.md.') + '\n'
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
print('ok (página ' + PAG + (', só o comentário' if JA else '') + ') →', SAIDA)
