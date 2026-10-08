"""Aplica o desenho dos CURSOS DO CARGO (Natcorp_Cursos.js/.css) DIRETO na exportação COMPLETA do app 300
(f300.sql): página 90 (Cursos Realizados — o que o cargo pede e o que o colaborador já fez).

    python3 aplicar-cursos-app300.py f300.sql [saida.sql]

O que muda, só dentro da página 90:
  · as duas URLs de arquivo e o comentário da página (create_page);
  · um processo NOVO, Processing › Ajax Callback › NC_CURSOS_DADOS: as MESMAS consultas das três listas
    (curso_cargo pelo cargo + centro de custo; curriculum_v com ind_conclusao = 'S') numa resposta só, o nome
    do cargo e o estudo: o que o cargo pede (pc_parametro_formacao.cod_instrucao, como no app 202) e o que a
    pessoa tem (inf_pessoais.instrucao) — as duas na tabela instrucao.
    (O item original "Escolaridade Exigida" compara cod_cargo com a MATRÍCULA e vem sempre vazio; ele fica
    como está, só sai da vista com o desenho.)
As listas, os itens e o processo popula_colab ficam como estão. Guia: CURSOS-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f300.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
JS = '#WORKSPACE_IMAGES#Natcorp_Cursos.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Cursos.css'
LINHAS = [
    'DESENHO DA TELA (Natcorp_Cursos.css / Natcorp_Cursos.js) - o que o cargo pede, para quem le com dificuldade',
    '',
    'No alto, a resposta: "Faltam 2 cursos" / "Voce tem tudo o que o seu cargo pede", uma trilha de um passo por',
    'curso e Ouvir. Abaixo, UMA lista dos cursos do cargo com a situacao escrita (Falta fazer / Feito), o estudo',
    '(o cargo pede x voce tem) e os outros cursos ja feitos, recolhidos. "Ver tabela completa" mostra as tres',
    'listas originais. Os dados vem do processo Ajax Callback NC_CURSOS_DADOS desta pagina (sem ele, o desenho',
    'le as tres listas). Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/CURSOS-MANUTENCAO.md.',
]
PLSQL = [
    '-- Entrega ao Natcorp_Cursos.js, em JSON, o que o cargo pede e o que o colaborador ja fez: as MESMAS consultas',
    '-- das listas "Cursos Exigidos", "Cursos do Colaborador" e "Cursos a Realizar", o nome do cargo e o estudo.',
    'declare',
    '  v_cargo  varchar2(100) := :p90_cargo;',
    '  v_cc     varchar2(100) := :p90_cod_ccusto;',
    '  v_nome   varchar2(400);',
    '  v_ex_cod varchar2(30);',
    '  v_ex     varchar2(400);',
    '  v_at_cod varchar2(30);',
    '  v_at     varchar2(400);',
    '  v_json   clob;',
    '  v_pos    pls_integer := 1;',
    'begin',
    '  -- cargo e centro de custo: os mesmos do processo popula_colab (se a sessao nao os tiver, le de novo)',
    '  if v_cargo is null then',
    '    begin',
    '      select i.cargo, i.cod_ccusto into v_cargo, v_cc',
    '        from informacoes_funcionais i',
    '       where i.cod_empresa = :p90_emp',
    '         and i.matricula = :p90_mat;',
    '    exception',
    '      when others then null;',
    '    end;',
    '  end if;',
    '  begin',
    "    v_nome := v_cargo || ' - ' || initcap(fnct_nome_cargo(v_cargo));",
    '  exception',
    '    when others then v_nome := null;',
    '  end;',
    '  -- o estudo que o cargo pede (como no app 202) e o que a pessoa tem: os dois na tabela instrucao',
    '  begin',
    '    select min(f.cod_instrucao) into v_ex_cod',
    '      from pc_parametro_formacao f',
    '     where f.cod_empresa = :p90_emp',
    '       and f.cod_cargo = v_cargo;',
    '    if v_ex_cod is not null then',
    '      select initcap(g.nome) into v_ex from instrucao g where g.cod = v_ex_cod;',
    '    end if;',
    '  exception',
    '    when others then',
    '      v_ex_cod := null;',
    '      v_ex := null;',
    '  end;',
    '  begin',
    '    select a.instrucao, initcap(b.nome) into v_at_cod, v_at',
    '      from inf_pessoais a, instrucao b',
    '     where b.cod = a.instrucao',
    '       and a.cod_empresa = :p90_emp',
    '       and a.matricula = :p90_mat;',
    '  exception',
    '    when others then',
    '      v_at_cod := null;',
    '      v_at := null;',
    '  end;',
    '  apex_json.free_output;',
    '  apex_json.initialize_clob_output;',
    '  apex_json.open_object;',
    "  apex_json.write('cargo', v_nome);",
    "  apex_json.open_object('escolaridade');",
    "  apex_json.write('exigida_cod', v_ex_cod);",
    "  apex_json.write('exigida', v_ex);",
    "  apex_json.write('atual_cod', v_at_cod);",
    "  apex_json.write('atual', v_at);",
    '  apex_json.close_object;',
    "  apex_json.open_array('exigidos');",
    '  for x in (select distinct c.cod_curso cod, initcap(cv.nome_curso) nome,',
    '                   case when exists (select 1',
    '                                       from curriculum_v a',
    '                                      where a.cod_empresa = :p90_emp',
    '                                        and a.matricula = :p90_mat',
    "                                        and a.ind_conclusao = 'S'",
    "                                        and a.cod_curso = c.cod_curso) then 'S' else 'N' end feito",
    '              from curso_cargo c, curso_v cv',
    '             where c.cod_cargo = v_cargo',
    '               and c.cod_ccusto = v_cc',
    '               and c.cod_curso = cv.cod_curso',
    '             order by 2) loop',
    '    apex_json.open_object;',
    "    apex_json.write('cod', to_char(x.cod));",
    "    apex_json.write('nome', x.nome);",
    "    apex_json.write('feito', x.feito);",
    '    apex_json.close_object;',
    '  end loop;',
    '  apex_json.close_array;',
    "  apex_json.open_array('outros');",
    '  for x in (select distinct c.cod_curso cod, initcap(cv.nome_curso) nome',
    '              from curriculum_v c, curso_v cv',
    '             where c.cod_empresa = :p90_emp',
    '               and c.matricula = :p90_mat',
    "               and c.ind_conclusao = 'S'",
    '               and c.cod_curso = cv.cod_curso',
    '               and not exists (select 1',
    '                                 from curso_cargo k',
    '                                where k.cod_cargo = v_cargo',
    '                                  and k.cod_ccusto = v_cc',
    '                                  and k.cod_curso = c.cod_curso)',
    '             order by 2) loop',
    '    apex_json.open_object;',
    "    apex_json.write('cod', to_char(x.cod));",
    "    apex_json.write('nome', x.nome);",
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
    (90, 'NC_CURSOS_DADOS', PLSQL, LINHAS, ('CURSO_CARGO', 'P90_VA_INSTR1'), None,
     'Natcorp_Cursos.js: a pagina pede o que o cargo exige e o que o colaborador fez aqui (apex.server.process). Guia: CURSOS-MANUTENCAO.md.'),
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
    if 'Natcorp_Cursos' in pg:
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
