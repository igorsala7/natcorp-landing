"""Aplica o desenho da Linha do Tempo (Férias) numa EXPORTAÇÃO da página 26 do app 200 ("Férias").

    python3 aplicar-linhatempo-pagina26.py f200_page_26.sql [saida.sql]

O script reconhece a página pelo CONTEÚDO (nunca pelos IDs): um Interactive Report sobre a
VW_CONSULTA_FERIAS. O que muda (tudo visível no Page Designer; nenhuma região, item, validação ou
ação dinâmica existente é tocada — a região antiga do plugin "Linha do Tempo" fica como está):
  · a URL do Natcorp_LinhaTempo.js e a do Natcorp_LinhaTempo.css;
  · o comentário da página (o que o desenho faz e como desligar);
  · um processo NOVO, Processing › Ajax Callback › NC_LINHA_TEMPO_DADOS: entrega ao desenho, em
    JSON, TODOS os períodos aquisitivos que o relatório traria (não só a página aberta da Tabela):
    o FROM e o WHERE são COPIADOS do relatório desta exportação — os mesmos filtros (pendentes,
    situação, empresa, filial, centro de custo, unidade, atividade, cargo, matrícula, datas) e o
    colaborador escolhido. As três parcelas: PARC1, PARC2 e PARC4 (a 3ª parcela é a coluna 4 no
    banco, como no relatório). Mudou o filtro do relatório? Exporte de novo e rode este script:
    o processo acompanha. Corta em LIMITE períodos (o desenho avisa).
Roda de novo sobre um arquivo já alterado: não altera duas vezes (só atualiza o comentário).
Guia: LINHATEMPO-MANUTENCAO.md (Página 26 — Férias).
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f200_page_26.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
LIMITE = 20000
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_LinhaTempo' in s

if "p_plug_source_type=>'NATIVE_IR'" not in s or 'VW_CONSULTA_FERIAS' not in s:
    sys.exit('este arquivo não é a página de Férias (Interactive Report sobre a VW_CONSULTA_FERIAS)')
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
          if "p_plug_source_type=>'NATIVE_IR'" in b.group(0) and 'VW_CONSULTA_FERIAS' in b.group(0))
fonte = re.search(r'p_plug_source=>wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n(.*?)\)\)\n', ir, re.S).group(1)
sql = [des_uni(l) for l in re.findall(r"^(?:unistr\()?'.*'\)?(?=,?$)", fonte, re.M)]
ini = next(k for k, l in enumerate(sql) if re.match(r'\s*from\s+VW_CONSULTA_FERIAS\s+F\b', l, re.I))
fim = max(k for k, l in enumerate(sql) if re.match(r'\s*order\s+by\b', l, re.I))
DE_ONDE = ['    ' + l for l in sql[ini:fim]]
if not any(':p26_emp' in l.lower() for l in DE_ONDE):
    sys.exit('o WHERE do relatório não tem os filtros da página (P26_…): confira a exportação antes')

LINHAS = [
    'DESENHO DA TELA (Natcorp_LinhaTempo.css / Natcorp_LinhaTempo.js)',
    '',
    'No alto do relatório, um seletor com três jeitos de ver as mesmas férias:',
    '  Tabela      o Interactive Report de sempre;',
    '  Trajetória  um Gantt com uma linha por colaborador e, dentro, uma faixa por período aquisitivo:',
    '              a faixa clara é o período aquisitivo; o contorno tracejado, o período para gozar',
    '              (até a data limite de início); as barras cheias, as parcelas (saída -> retorno);',
    '              o losango, o prazo para iniciar (vermelho vencido com saldo, âmbar até 60 dias).',
    '              Abre em ordem de urgência, com busca, zoom de anos a dias e arrastar para rolar;',
    '  Cronologia  as parcelas e os prazos por ano, com o nome de quem é cada um.',
    'Os dados vêm do processo Ajax Callback NC_LINHA_TEMPO_DADOS desta página, com o FROM e o WHERE',
    'copiados do relatório (os filtros do último Pesquisar, que estão na sessão): TODOS os períodos,',
    'não só a página aberta da Tabela. Até %d períodos.' % LIMITE,
    'Mudou o filtro do relatório? Rode de novo aplicar-linhatempo-pagina26.py na exportação.',
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
    PARC = [('1', '1'), ('2', '2'), ('3', '4')]   # (como aparece, coluna no banco): a 3ª parcela é a PARC4
    PLSQL = [
        '-- Entrega os períodos de férias ao Natcorp_LinhaTempo.js (Trajetória e Cronologia), em JSON.',
        '-- O FROM e o WHERE são os do relatório (copiados pelo aplicar-linhatempo-pagina26.py): os filtros',
        '-- do último Pesquisar (na sessão). Todos os períodos, não só a página aberta da Tabela.',
        'declare',
        '  c_limite constant pls_integer := %d;' % LIMITE,
        '  v_n      pls_integer := 0;',
        '  v_cortou boolean := false;',
        "  function d(p_data date) return varchar2 is begin return to_char(p_data, 'dd/mm/yyyy'); end;",
        '  procedure parcela(p_n number, p_sai date, p_ret date, p_pag date, p_dias number, p_abono number, p_13 varchar2) is',
        '  begin',
        '    if p_sai is null then return; end if;',
        '    apex_json.open_object;',
        "    apex_json.write('n', p_n);",
        "    apex_json.write('saida', d(p_sai));",
        "    apex_json.write('retorno', d(p_ret));",
        "    apex_json.write('pagto', d(p_pag));",
        "    apex_json.write('dias', p_dias);",
        "    apex_json.write('abono', p_abono);",
        "    apex_json.write('dec', p_13);",
        '    apex_json.close_object;',
        '  end;',
        'begin',
        '  apex_json.open_object;',
        "  apex_json.open_array('ferias');",
        '  for r in (',
        '    select f.cod_empresa, f.matricula, initcap(fnct_nome_func(f.cod_empresa, f.matricula)) nome,',
        "           f.scr_ccusto ccusto, i.situacao||' - '||initcap(fnct_nome_situacao(i.situacao)) sit_func,",
        '           f.scr_situacao sit, f.dt_inic_per_ferias aq_ini, f.dt_fim_per_ferias aq_fim,',
        '           f.dt_lim_inic_ferias lim_ini, f.dt_lim_prog_ferias lim_prog, f.saldo,',
    ] + [
        '           f.dt_saida_parc%s s%s, f.dt_retorno_parc%s r%s, f.dt_pagto_parc%s p%s, f.num_dias_parc%s d%s, f.dias_abono_pec%s a%s, f.opcao_13sal%s o%s%s'
        % (b, n, b, n, b, n, b, n, b, n, b, n, '' if n == '3' else ',') for n, b in PARC
    ] + DE_ONDE + [
        '     order by f.cod_empresa, f.matricula, f.dt_inic_per_ferias desc) loop',
        '    if v_n >= c_limite then',
        '      v_cortou := true;',
        '      exit;',
        '    end if;',
        '    v_n := v_n + 1;',
        '    apex_json.open_object;',
        "    apex_json.write('emp', r.cod_empresa);",
        "    apex_json.write('mat', r.matricula);",
        "    apex_json.write('nome', r.nome);",
        "    apex_json.write('ccusto', r.ccusto);",
        "    apex_json.write('sit_func', r.sit_func);",
        "    apex_json.write('sit', r.sit);",
        "    apex_json.write('aq_ini', d(r.aq_ini));",
        "    apex_json.write('aq_fim', d(r.aq_fim));",
        "    apex_json.write('lim_ini', d(r.lim_ini));",
        "    apex_json.write('lim_prog', d(r.lim_prog));",
        "    apex_json.write('saldo', r.saldo);",
        "    apex_json.open_array('parcelas');",
    ] + [
        '    parcela(%s, r.s%s, r.r%s, r.p%s, r.d%s, r.a%s, r.o%s);' % (n, n, n, n, n, n, n) for n, b in PARC
    ] + [
        '    apex_json.close_array;',
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
             ',p_process_comment=>' + uni('Natcorp_LinhaTempo.js: a Trajetória e a Cronologia de Férias pedem os períodos aqui (apex.server.process). FROM/WHERE copiados do relatório pelo aplicar-linhatempo-pagina26.py. Guia: LINHATEMPO-MANUTENCAO.md.') + '\n'
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
