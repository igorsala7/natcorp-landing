"""Aplica o desenho da FOLHA DE PAGAMENTO DO MÊS (Natcorp_Folha.js/.css) DIRETO na exportação COMPLETA
do app 300 (f300.sql): página 74 (Folha do Mês — a consulta do holerite) e, no modo "ocorrências",
página 104 (Ocorrência de Pagamento — os lançamentos para o cálculo, processo NC_OCORR_DADOS).

    python3 aplicar-folha-app300.py f300.sql [saida.sql]

O que muda, só dentro da página 74:
  · as duas URLs de arquivo e o comentário da página (create_page);
  · um processo NOVO, Processing › Ajax Callback › NC_FOLHA_DADOS: entrega ao desenho, em JSON, a
    MESMA consulta do relatório + o TIPO de cada verba pela FAIXA do código (P74_QUATRO_DIGITOS:
    N = 1-499 provento, 500-899 desconto, 900+ base, 997/998/999 totais; S = 1-4999, 5000-8999,
    9000+, 9997/9998/9999) e roda ANTES a mesma validação da ação "Valida Dt Ref"
    (pkg_executa_f011544.valida_parametros). Mês não liberado → { bloqueado, msg } e nenhuma verba.
O relatório, as ações dinâmicas e o processo popula_colab ficam como estão.
No fim, confere: fora da página 74 o arquivo ficou igual byte a byte; nenhum atributo repetido;
nenhum texto com acento fora de unistr. Guia: FOLHA-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f300.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
JS = '#WORKSPACE_IMAGES#Natcorp_Folha.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Folha.css'
LINHAS = [
    'DESENHO DA TELA (Natcorp_Folha.css / Natcorp_Folha.js) - o holerite do mes, para quem le com dificuldade',
    '',
    'O mes no alto (setas e lista; escolhem uma opcao em P74_DATA_REF e a acao Valida Dt Ref roda como antes).',
    'O recibo: Voce ganhou - Foi descontado = Voce recebe, a barra e "De cada R$ 100...", com Ouvir. As listas',
    '"O que voce ganhou" e "O que foi descontado" (a maior verba primeiro; "O que e isso?" nas conhecidas) e as',
    'Bases de calculo recolhidas. "Ver tabela completa" mostra este relatorio.',
    'Os dados vem do processo Ajax Callback NC_FOLHA_DADOS desta pagina: a mesma consulta do relatorio + o tipo da',
    'verba pela faixa do codigo (P74_QUATRO_DIGITOS: N = 1-499/500-899/900+, totais 997-999; S = 1-4999/5000-8999/',
    '9000+, totais 9997-9999) e a mesma validacao do mes (pkg_executa_f011544.valida_parametros).',
    'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/FOLHA-MANUTENCAO.md.',
]
PLSQL = [
    '-- Entrega as verbas do mes ao Natcorp_Folha.js, em JSON. A MESMA consulta do relatorio "Folha do Mes",',
    '-- mais o tipo da verba pela FAIXA do codigo, e a MESMA validacao da acao "Valida Dt Ref".',
    '-- Faixas (P74_QUATRO_DIGITOS, de configuracoes.quatro_digitos_ocorr):',
    '--   N: 1-499 provento, 500-899 desconto, 900 em diante base; 997/998/999 = Total de Proventos/Descontos/Liquido',
    '--   S: 1-4999 provento, 5000-8999 desconto, 9000 em diante base; 9997/9998/9999 = os mesmos totais',
    'declare',
    '  v_flg    varchar2(1);',
    '  v_msg    varchar2(4000);',
    '  v_4dig   varchar2(1) := :p74_quatro_digitos;',
    '  v_fim_pr number;',
    '  v_fim_ds number;',
    '  v_total  number;',
    '  v_tipo   number;',
    '  v_tot    varchar2(1);',
    '  v_json   clob;',
    '  type t_inc is table of varchar2(1) index by pls_integer;',
    '  v_inc    t_inc;',
    '  v_pos    pls_integer := 1;',
    'begin',
    '  -- o JSON e montado num CLOB e escrito no fim: se algo antes (a validacao do mes, por exemplo) deixar',
    '  -- o apex_json desviado ou pela metade, a resposta nao sai vazia (05/10: saia, e a tela dava erro).',
    '  -- o item vem do processo de abertura; se a sessao nao o tiver, le direto da configuracao',
    '  if v_4dig is null then',
    '    begin',
    '      select quatro_digitos_ocorr into v_4dig from configuracoes;',
    '    exception',
    '      when others then',
    "        v_4dig := 'N';",
    '    end;',
    '  end if;',
    "  if v_4dig = 'S' then",
    '    v_fim_pr := 4999; v_fim_ds := 8999; v_total := 9997;',
    '  else',
    '    v_fim_pr := 499;  v_fim_ds := 899;  v_total := 997;',
    '  end if;',
    '  -- incide no liquido? (a mesma coluna da pagina 21 e do recibo): na faixa de provento/desconto, so conta',
    "  -- como ganho/desconto a verba com incid_liq = 'S'; com 'N' ela e base (ex.: 807 Capital Segurado).",
    '  -- Se a view nao responder, vale so a faixa.',
    '  begin',
    '    for x in (select v.cod_ocorr, max(v.incid_liq) incid',
    '                from vw_historicos v',
    '               where v.cod_empresa = :p74_emp',
    '                 and v.matricula = :p74_mat',
    '                 and v.data_ref = :p74_data_ref',
    '               group by v.cod_ocorr) loop',
    '      v_inc(x.cod_ocorr) := x.incid;',
    '    end loop;',
    '  exception',
    '    when others then',
    '      v_inc.delete;',
    '  end;',
    '  -- a mesma validacao da acao "Valida Dt Ref". Se ELA falhar (excecao), vale o que a pagina faz hoje:',
    '  -- a acao so mostra o aviso de erro, P74_MSG fica vazio e o relatorio aparece. Aqui: as verbas vao.',
    '  begin',
    '  pkg_executa_f011544.valida_parametros(:p74_emp,',
    '                                        :p74_mat,',
    "                                        'HF',",
    '                                        :p74_data_ref,',
    '                                        :p_usuario,',
    '                                        :p_empresa_user,',
    '                                        :p_matricula_user,',
    '                                        v_flg,',
    '                                        v_msg);',
    '  exception',
    '    when others then',
    '      v_flg := null;',
    '      v_msg := null;',
    '  end;',
    '  apex_json.free_output;',
    '  apex_json.initialize_clob_output;',
    '  apex_json.open_object;',
    "  if v_flg = 'N' and trim(v_msg) is not null then",
    "    apex_json.write('bloqueado', true);",
    "    apex_json.write('msg', v_msg);",
    '  else',
    "    apex_json.write('quatro_digitos', v_4dig);",
    "    apex_json.open_array('itens');",
    "    for r in (select h.cod_ocorr||' - '||h.dc_ocorr codigo, h.cod_ocorr cod, initcap(o.nome) descricao,",
    '                     h.unidade1 qtde, h.unidade2 dias, h.valor, h.faixa, h.dt_inic_val, h.dt_fin_val',
    '                from hist_financeiro h, ocorr_pagto o',
    '               where h.cod_empresa = o.cod_empresa',
    '                 and h.cod_ocorr = o.cod',
    '                 and h.dc_ocorr = o.dc_cod',
    '                 and h.cod_empresa = :p74_emp',
    '                 and h.matricula = :p74_mat',
    '                 and h.data_ref = :p74_data_ref',
    '               order by 1) loop',
    '      -- 1 provento, 2 desconto, 3 base; os 3 ultimos codigos sao os totais da folha',
    '      v_tot := case r.cod',
    "                 when v_total     then 'g'",
    "                 when v_total + 1 then 'd'",
    "                 when v_total + 2 then 'l'",
    '               end;',
    '      v_tipo := case',
    "                  when v_inc.exists(r.cod) and v_inc(r.cod) = 'N' then 3",
    '                  when r.cod <= v_fim_pr then 1',
    '                  when r.cod <= v_fim_ds then 2',
    '                  else 3',
    '                end;',
    '      apex_json.open_object;',
    "      apex_json.write('codigo', r.codigo);",
    "      apex_json.write('descricao', r.descricao);",
    "      apex_json.write('tipo', v_tipo);",
    "      apex_json.write('total', v_tot);",
    "      apex_json.write('qtde', r.qtde);",
    "      apex_json.write('dias', r.dias);",
    "      apex_json.write('valor', r.valor);",
    "      apex_json.write('faixa', r.faixa);",
    "      apex_json.write('inicio', to_char(r.dt_inic_val, 'dd/mm/yyyy'));",
    "      apex_json.write('fim', to_char(r.dt_fin_val, 'dd/mm/yyyy'));",
    '      apex_json.close_object;',
    '    end loop;',
    '    apex_json.close_array;',
    '  end if;',
    '  apex_json.close_object;',
    '  v_json := apex_json.get_clob_output;',
    '  apex_json.free_output;',
    '  while v_pos <= dbms_lob.getlength(v_json) loop',
    '    htp.prn(dbms_lob.substr(v_json, 8000, v_pos));',
    '    v_pos := v_pos + 8000;',
    '  end loop;',
    'exception',
    '  when others then',
    '    begin',
    '      apex_json.free_output;',
    '    exception',
    '      when others then null;',
    '    end;',
    "    htp.prn('{\"erro\":\"' || apex_escape.json(sqlerrm) || '\"}');",
    'end;',
]

LINHAS_OCORR = [
    'DESENHO DA TELA (Natcorp_Folha.css / Natcorp_Folha.js, modo "ocorrencias") - os lancamentos do mes',
    '',
    'O mes no alto (setas e lista, com "Todos os meses"; escolhem uma opcao em P104_DATA_REF, que recarrega a',
    'pagina como antes). Mes escolhido: Ganhos e Descontos lancados (sem "voce recebe": ocorrencia nao e o',
    'pagamento) e as listas como na Folha do Mes (74), com "O que e isso?" e as Bases recolhidas. Todos os meses:',
    'uma faixa por mes com os totais, o mais novo aberto. "Ver tabela completa" mostra este relatorio.',
    'Os dados vem do processo Ajax Callback NC_OCORR_DADOS desta pagina: a mesma consulta do relatorio + o tipo da',
    'verba pela faixa do codigo (configuracoes.quatro_digitos_ocorr) e incid_liq (vw_historicos).',
    'O modo e ligado em JavaScript > Function and Global Variable Declaration (ncFolha). Para desligar: tire as',
    'duas URLs de arquivo. Guia: brand/apex/app/FOLHA-MANUTENCAO.md.',
]
PLSQL_OCORR = [
    '-- Entrega os lancamentos (ocorrencia_calculo) ao Natcorp_Folha.js (modo ocorrencias), em JSON. A MESMA',
    '-- consulta do relatorio "Ocorrencia de Pagamento", mais o tipo de cada verba, com a regra da Folha do Mes:',
    '--   quatro_digitos_ocorr N: 1-499 provento, 500-899 desconto, 900 em diante base',
    '--   quatro_digitos_ocorr S: 1-4999 provento, 5000-8999 desconto, 9000 em diante base',
    "--   e, na faixa de provento/desconto, incid_liq = 'N' (nao incide no liquido) e base.",
    '-- P104_DATA_REF vazio ("Todas") = todos os meses, o mais novo primeiro.',
    'declare',
    "  v_4dig   varchar2(1) := 'N';",
    '  v_fim_pr number;',
    '  v_fim_ds number;',
    '  v_tipo   number;',
    '  v_json   clob;',
    '  v_pos    pls_integer := 1;',
    '  type t_inc is table of varchar2(1) index by pls_integer;',
    '  v_inc    t_inc;',
    'begin',
    '  begin',
    '    select quatro_digitos_ocorr into v_4dig from configuracoes;',
    '  exception',
    '    when others then',
    "      v_4dig := 'N';",
    '  end;',
    "  if v_4dig = 'S' then",
    '    v_fim_pr := 4999; v_fim_ds := 8999;',
    '  else',
    '    v_fim_pr := 499;  v_fim_ds := 899;',
    '  end if;',
    '  -- incide no liquido? lido do que o sistema ja calculou para este colaborador (qualquer mes);',
    '  -- verba nunca calculada para ele: vale so a faixa',
    '  begin',
    '    for x in (select v.cod_ocorr, max(v.incid_liq) incid',
    '                from vw_historicos v',
    '               where v.cod_empresa = :p104_emp',
    '                 and v.matricula = :p104_mat',
    '               group by v.cod_ocorr) loop',
    '      v_inc(x.cod_ocorr) := x.incid;',
    '    end loop;',
    '  exception',
    '    when others then',
    '      v_inc.delete;',
    '  end;',
    '  apex_json.free_output;',
    '  apex_json.initialize_clob_output;',
    '  apex_json.open_object;',
    "  apex_json.write('quatro_digitos', v_4dig);",
    "  apex_json.open_array('itens');",
    "  for r in (select h.cod_ocorr||' - '||h.dc_ocorr codigo, h.cod_ocorr cod, initcap(o.nome) descricao,",
    '                   h.unidade1 qtde, h.unidade2 dias, h.valor, h.faixa, h.dt_inic_val, h.dt_fin_val, h.data_ref',
    '              from ocorrencia_calculo h, ocorr_pagto o',
    '             where h.cod_empresa = o.cod_empresa',
    '               and h.cod_ocorr = o.cod',
    '               and h.dc_ocorr = o.dc_cod',
    '               and h.cod_empresa = :p104_emp',
    '               and h.matricula = :p104_mat',
    '               and h.data_ref = nvl(:p104_data_ref, h.data_ref)',
    '             order by h.data_ref desc, h.cod_ocorr) loop',
    '    v_tipo := case',
    "                when v_inc.exists(r.cod) and v_inc(r.cod) = 'N' then 3",
    '                when r.cod <= v_fim_pr then 1',
    '                when r.cod <= v_fim_ds then 2',
    '                else 3',
    '              end;',
    '    apex_json.open_object;',
    "    apex_json.write('ref', to_char(r.data_ref, 'dd/mm/yyyy'));",
    "    apex_json.write('codigo', r.codigo);",
    "    apex_json.write('descricao', r.descricao);",
    "    apex_json.write('tipo', v_tipo);",
    "    apex_json.write('qtde', r.qtde);",
    "    apex_json.write('dias', r.dias);",
    "    apex_json.write('valor', r.valor);",
    "    apex_json.write('faixa', r.faixa);",
    "    apex_json.write('inicio', to_char(r.dt_inic_val, 'dd/mm/yyyy'));",
    "    apex_json.write('fim', to_char(r.dt_fin_val, 'dd/mm/yyyy'));",
    '    apex_json.close_object;',
    '  end loop;',
    '  apex_json.close_array;',
    '  apex_json.close_object;',
    '  v_json := apex_json.get_clob_output;',
    '  apex_json.free_output;',
    '  while v_pos <= dbms_lob.getlength(v_json) loop',
    '    htp.prn(dbms_lob.substr(v_json, 8000, v_pos));',
    '    v_pos := v_pos + 8000;',
    '  end loop;',
    'exception',
    '  when others then',
    '    begin',
    '      apex_json.free_output;',
    '    exception',
    '      when others then null;',
    '    end;',
    "    htp.prn('{\"erro\":\"' || apex_escape.json(sqlerrm) || '\"}');",
    'end;',
]

PAGINAS = [
    # (página, processo, PL/SQL, comentário da página, o que a página TEM de ter, JS da página)
    (74, 'NC_FOLHA_DADOS', PLSQL, LINHAS, ('hist_financeiro', 'P74_DATA_REF'), None,
     'Natcorp_Folha.js: o holerite do mes pede as verbas aqui (apex.server.process). Guia: FOLHA-MANUTENCAO.md.'),
    (104, 'NC_OCORR_DADOS', PLSQL_OCORR, LINHAS_OCORR, ('ocorrencia_calculo', 'P104_DATA_REF'),
     "var ncFolha = { modo: 'ocorrencias', processo: 'NC_OCORR_DADOS' };   /* Natcorp_Folha.js no modo ocorrencias */",
     'Natcorp_Folha.js (modo ocorrencias): a pagina pede os lancamentos aqui (apex.server.process). Guia: FOLHA-MANUTENCAO.md.'),
]

s = open(ENTRADA, encoding='utf-8').read()
if 'p_default_application_id=>300\n' not in s or 'Export Type:     Application Export' not in s:
    sys.exit('este arquivo não é a exportação completa do app 300')


def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]


def aplicar(s, PAG, PROC, PL, LIN, CHECA, JSCODE, COMENT):
    a = s.index('prompt --application/pages/page_%05d\n' % PAG)
    b = s.find('\nprompt --application/', a + 10)
    blk = s[a:b]
    if any(x not in blk for x in CHECA):
        sys.exit('a página %d não é a esperada (%s)' % (PAG, ' / '.join(CHECA)))

    # ---------- a create_page: URLs e comentário ----------
    m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', blk, re.S)
    pg = m.group(0)
    if 'Natcorp_Folha' in pg:
        como = 'já tinha as URLs'
    else:
        if re.search(r'^,p_(javascript|css)_file_urls=>', pg, re.M):
            if 'Natcorp_Consulta' not in pg:
                sys.exit('a página %d já tem outra URL de arquivo: juntar à mão' % PAG)
            # o motor das consultas saiu desta página: a Folha tem desenho próprio
            pg = re.sub(r"^,p_(javascript|css)_file_urls=>'[^']*Natcorp_Consulta[^']*'\n", '', pg, flags=re.M)
        pg = re.sub(r"^,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)|'(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))\n", '', pg, flags=re.M | re.S)
        ancora = next(k for k in ('autocomplete_on_off', 'step_title', 'name') if re.search(r'^,?p_' + k + r'=>', pg, re.M))
        pg = poe(pg, ancora, ",p_javascript_file_urls=>'" + JS + "'")
        pg = poe(pg, 'javascript_file_urls', ",p_css_file_urls=>'" + CSS + "'")
        pg = poe(pg, 'css_file_urls', ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LIN) + '))')
        if JSCODE:
            if re.search(r'^,p_javascript_code=>', pg, re.M):
                sys.exit('a página %d já tem JavaScript próprio: juntar à mão' % PAG)
            pg = poe(pg, 'css_file_urls', ',p_javascript_code=>' + uni(JSCODE))
        como = 'URLs postas'
    blk = blk[:m.start()] + pg + blk[m.end():]

    # ---------- o processo que entrega as verbas ao desenho (Ajax Callback) ----------
    if ("p_process_name=>'" + PROC + "'") not in blk:
        ID_PROC = 'wwv_flow_api.id(%s)' % ('28299%04d%04d%07d' % (300, PAG, 1))
        if ID_PROC in s:
            sys.exit('o id novo já existe neste arquivo: ' + ID_PROC)
        seqs = [int(x) for x in re.findall(r"^,p_process_sequence=>(\d+)$", blk, re.M)] or [0]
        bloco = ('wwv_flow_api.create_page_process(\n'
                 ' p_id=>' + ID_PROC + '\n'
                 ',p_process_sequence=>' + str(max(seqs) + 10) + '\n'
                 ",p_process_point=>'ON_DEMAND'\n"
                 ",p_process_type=>'NATIVE_PLSQL'\n"
                 ",p_process_name=>'" + PROC + "'\n"
                 ',p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in PL) + '))\n'
                 ",p_error_display_location=>'INLINE_IN_NOTIFICATION'\n"
                 ',p_process_comment=>' + uni(COMENT) + '\n'
                 ');\n')
        fim = blk.rfind('end;\n/')
        if fim < 0:
            sys.exit('não achei o fim da página para pôr o processo')
        blk = blk[:fim] + bloco + blk[fim:]
        como += ', processo ' + PROC + ' criado'

    r = s[:a] + blk + s[b:]
    if r[:a] != s[:a] or r[a + len(blk):] != s[b:]:
        sys.exit('ERRO: algo fora da página %d mudou — nada foi gravado' % PAG)
    for mm in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', blk, re.S):
        ks = re.findall(r'^,?p_([a-z0-9_]+)=>', mm.group(2), re.M)
        if len(ks) != len(set(ks)):
            sys.exit('atributo repetido em ' + mm.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
    fora = [l for l in blk.split('\n') if re.match(r"^,?p_[a-z0-9_]+=>'", l) and any(ord(c) > 127 for c in l)]
    if fora:
        sys.exit('texto com acento sem unistr: ' + fora[0][:80])
    print('%5d %s' % (PAG, como))
    return r


for pag_cfg in PAGINAS:
    s = aplicar(s, *pag_cfg)
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok →', SAIDA)
