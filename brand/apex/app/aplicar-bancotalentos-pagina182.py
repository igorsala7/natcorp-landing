"""Aplica o NOVO BANCO DE TALENTOS (Natcorp_BancoTalentos.js/.css) numa EXPORTAÇÃO da página 182 do
app 9110 (Recrutamento e Seleção — "Candidatos", onde o recrutador procura no banco de talentos).

    python3 aplicar-bancotalentos-pagina182.py f9110_page_182.sql [saida.sql]

Reconhece a página pelo CONTEÚDO: os itens P182_TIPO e P182_PS e o relatório candidatos_externos. O que
muda (tudo visível no Page Designer):
  • JavaScript › File URLs: Natcorp_BancoTalentos.js
  • CSS › File URLs: a que já existia (natcorp_iframe_apex.css) + Natcorp_BancoTalentos.css
  • o comentário da página (o nosso bloco no alto)
  • o link do ARQUIVO DO CURRÍCULO nos 3 relatórios: &APP_ID. (9110, onde GET_UPLOAD_FILES/GET_TIPO_ITEM
    não existem — ERR-1002) → RS_PRC_'||:P_BASE||' (o app 9113, onde o download funciona)
  • um processo NOVO, Ajax Callback NC_BT_VAGA (SÓ LEITURA): a lista das vagas abertas (x01 = LISTA)
    e os requisitos da requisição de pessoal da vaga escolhida (mesmas tabelas da descrição da vaga,
    9113:38).
NENHUM item, região, botão, ação dinâmica, consulta ou processo existente é tocado. Roda de novo sem
alterar duas vezes. Guia: BANCOTALENTOS-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f9110_page_182.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
APP, PAGINA = 9110, 182
s = open(ENTRADA, encoding='utf-8').read()

if "p_name=>'P182_TIPO'" not in s or "p_name=>'P182_PS'" not in s or "p_static_id=>'candidatos_externos'" not in s and "p_region_name=>'candidatos_externos'" not in s:
    sys.exit('este arquivo não é o banco de talentos (itens P182_TIPO/P182_PS e relatório candidatos_externos)')

JS = '#WORKSPACE_IMAGES#Natcorp_BancoTalentos.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_BancoTalentos.css'
CSS_ANTIGA = '#WORKSPACE_IMAGES#natcorp_iframe_apex.css'

FIM = '---- (fim do bloco Natcorp; abaixo, o comentário que a página já tinha) ----'
LINHAS = [
    'DESENHO DA TELA (Natcorp_BancoTalentos.css / Natcorp_BancoTalentos.js)',
    '',
    'Coluna da esquerda: PARA QUAL VAGA? (uma das vagas abertas; os requisitos da requisição vêm do',
    'processo NC_BT_VAGA — não é o P182_PS, que continua filtrando os Selecionados), QUEM BUSCAR (Externos | Internos | Selecionados, período, indicados) e os',
    'FILTROS das 9 janelas num painel só, em grupos que abrem e fecham, com "Pesquisar" sempre à mão.',
    'Resultados: um CARTÃO por candidato com a ADERÊNCIA à vaga (estimada na tela pelo texto do cadastro),',
    'os requisitos atendidos, as ações de sempre e o detalhe (formação, idiomas, cursos, experiência).',
    'A caixa do cartão aperta a original (.checkbox_item). Cartões | Tabela devolve o relatório original.',
    'Para desligar: tire as URLs do Natcorp_BancoTalentos. Guia: brand/apex/app/BANCOTALENTOS-MANUTENCAO.md.',
    FIM,
]

VAGA = [
    'declare',
    '  l_ps number;',
    'begin',
    '  -- LISTA: as vagas abertas (mesma regra da lista "Processo Seletivo" da janela de inclusão)',
    "  if upper(trim(apex_application.g_x01)) = 'LISTA' then",
    '    apex_json.open_object;',
    "    apex_json.open_array('vagas');",
    "    for v in (select sele.cod_processo, fnc_retorna_dados_cargo(sele.cod_cargo, 'NOME') cargo,",
    "                     fnct_nome_filial(sele.cod_empresa, sele.cod_filial, 'S') filial",
    '                from ps_processo_seletivo sele, requisicao r',
    '               where r.cod_req = sele.cod_processo',
    '                 and r.cod_sit_req = 5',
    "                 and nvl(r.vaga_confidencial, 'N') = 'N'",
    '               order by sele.cod_req desc) loop',
    '      apex_json.open_object;',
    "      apex_json.write('processo', v.cod_processo); apex_json.write('cargo', v.cargo); apex_json.write('filial', v.filial);",
    '      apex_json.close_object;',
    '    end loop;',
    '    apex_json.close_array;',
    '    apex_json.close_object;',
    '    return;',
    '  end if;',
    '  -- um processo: os requisitos da requisição dele',
    '  begin',
    "    l_ps := to_number(trim(apex_application.g_x01));",
    '  exception when others then l_ps := null;',
    '  end;',
    '  apex_json.open_object;',
    '  for v in (select ps.cod_processo, ca.nome cargo, r.cod_req,',
    '                   (select i.nome from instrucao i where i.cod = r.cod_instrucao) instrucao,',
    '                   r.anos_servico, r.meses_servico,',
    '                   nvl(l.cidade, m.nome_municipio) cidade, nvl(l.uf, f.uf) uf, r.tipo_modalidade',
    '              from ps_processo_seletivo ps, requisicao r, cargos ca, filiais f, municipios m, local_trab l',
    '             where ps.cod_req = r.cod_req',
    '               and ca.cod = r.cod_cargo',
    '               and f.cod_filial = r.cod_filial',
    '               and f.cod_empresa = r.cod_empresa',
    '               and f.cod_municipio_rais = m.cod_mun_ibge (+)',
    '               and r.cod_local_trab = l.cod_local_trab (+)',
    '               and ps.cod_processo = l_ps)',
    '  loop',
    "    apex_json.write('processo', v.cod_processo);",
    "    apex_json.write('cargo', v.cargo);",
    "    apex_json.write('instrucao', v.instrucao);",
    "    apex_json.write('anos', v.anos_servico);",
    "    apex_json.write('meses', v.meses_servico);",
    "    apex_json.write('cidade', v.cidade);",
    "    apex_json.write('uf', v.uf);",
    "    apex_json.write('modalidade', v.tipo_modalidade);",
    "    apex_json.open_array('formacoes');",
    '    for x in (select f.nome, i.nome instrucao, f.exige from formacao_req_pessoal f, instrucao i',
    '               where f.cod_instrucao = i.cod and f.cod_req = v.cod_req order by f.exige desc) loop',
    '      apex_json.open_object;',
    "      apex_json.write('nome', x.nome); apex_json.write('instrucao', x.instrucao); apex_json.write('exige', x.exige);",
    '      apex_json.close_object;',
    '    end loop;',
    '    apex_json.close_array;',
    "    apex_json.open_array('cursos');",
    '    for x in (select c.nome, c.exige from curso_req_pessoal c where c.cod_req = v.cod_req order by c.exige desc) loop',
    '      apex_json.open_object;',
    "      apex_json.write('nome', x.nome); apex_json.write('exige', x.exige);",
    '      apex_json.close_object;',
    '    end loop;',
    '    apex_json.close_array;',
    "    apex_json.open_array('conhecimentos');",
    "    for x in (select c.nome, decode(c.nivel, 1, 'B'||unistr('\\00E1')||'sico', 2, 'Intermedi'||unistr('\\00E1')||'rio', 3, 'Avan'||unistr('\\00E7')||'ado') nivel, c.exige",
    '                from conhecimento_req_pessoal c where c.cod_req = v.cod_req order by c.exige desc) loop',
    '      apex_json.open_object;',
    "      apex_json.write('nome', x.nome); apex_json.write('nivel', x.nivel); apex_json.write('exige', x.exige);",
    '      apex_json.close_object;',
    '    end loop;',
    '    apex_json.close_array;',
    "    apex_json.open_array('experiencias');",
    '    for x in (select c.nome, c.exige from experiencia_req_pessoal c where c.cod_req = v.cod_req order by c.exige desc) loop',
    '      apex_json.open_object;',
    "      apex_json.write('nome', x.nome); apex_json.write('exige', x.exige);",
    '      apex_json.close_object;',
    '    end loop;',
    '    apex_json.close_array;',
    "    apex_json.open_array('idiomas');",
    '    for x in (select b.descricao nome, n.descricao nivel from idioma b, nivel_conhecimento n, idioma_req_pessoal t',
    '               where b.codigo = t.cod_idioma and n.codigo = t.cod_nivel_conh and t.cod_req = v.cod_req) loop',
    '      apex_json.open_object;',
    "      apex_json.write('nome', x.nome); apex_json.write('nivel', x.nivel);",
    '      apex_json.close_object;',
    '    end loop;',
    '    apex_json.close_array;',
    '    apex_json.close_object;',
    '    return;',
    '  end loop;',
    "  apex_json.write('erro', 'Processo seletivo ' || nvl(apex_application.g_x01, '?') || ' n'||unistr('\\00E3')||'o encontrado.');",
    '  apex_json.close_object;',
    'exception when others then',
    "  apex_json.free_output;",
    '  apex_json.open_object;',
    "  apex_json.write('erro', sqlerrm);",
    '  apex_json.close_object;',
    'end;',
]


def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]


def comentario(t):
    """o nosso bloco no alto do comentário; o que vinha depois do FIM (ou o comentário inteiro, na 1ª vez) fica"""
    m = re.search(r"^,p_page_comment=>wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n(.*?)\)\)\n", t, re.M | re.S)
    nosso = ',\n'.join(uni(l) for l in LINHAS)
    if not m:
        return poe(t, 'page_template_options', ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + nosso + '))')
    corpo = m.group(1)
    i = corpo.find(uni(FIM))
    resto = corpo[i + len(uni(FIM)):].lstrip(',\n') if i >= 0 else corpo
    novo = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + nosso + (',\n' + resto if resto else '') + '))\n'
    return t[:m.start()] + novo + t[m.end():]


def pagina(t):
    if re.search(r'^,p_javascript_file_urls=>', t, re.M):
        sys.exit('a página já tem JavaScript › File URLs: junte à mão (acrescente o Natcorp_BancoTalentos.js)')
    m = re.search(r"^,p_css_file_urls=>(.*)\n", t, re.M)
    if m and m.group(1) != "'" + CSS_ANTIGA + "'":
        sys.exit('CSS › File URLs diferente do esperado: junte à mão (acrescente o Natcorp_BancoTalentos.css)')
    t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")
    m = re.search(r"^,p_css_file_urls=>(.*)\n", t, re.M)   # de novo: a linha do JS mudou as posições
    urls = ",p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'" + CSS_ANTIGA + "',\n'" + CSS + "'))\n"
    t = t[:m.start()] + urls + t[m.end():] if m else poe(t, 'javascript_file_urls', urls.rstrip('\n'))
    return comentario(t)


JA = 'Natcorp_BancoTalentos' in s
m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + (comentario(m.group(0)) if JA else pagina(m.group(0))) + s[m.end():]

# ---------- o link do ARQUIVO DO CURRÍCULO: o processo GET_UPLOAD_FILES e os itens GET_TIPO_ITEM…
# existem no app de processos seletivos (RS_PRC_<base>, o 9113), não no 9110 — com &APP_ID. dava
# ERR-1002 "Não foi possível localizar o ID do item GET_TIPO_ITEM no aplicativo 9110" (conferido 03/10).
# Mesmo padrão que a página já usa para abrir o candidato: 'RS_PRC_'||:P_BASE.
ERRADO = "f?p=&APP_ID.:1:&APP_SESSION.:APPLICATION_PROCESS=GET_UPLOAD_FILES"
CERTO = "f?p=RS_PRC_''||:P_BASE||'':1:&APP_SESSION.:APPLICATION_PROCESS=GET_UPLOAD_FILES"
n_arq = s.count(ERRADO)
s = s.replace(ERRADO, CERTO)

# ---------- o processo NC_BT_VAGA (Ajax Callback, só leitura) ----------
if "p_process_name=>'NC_BT_VAGA'" not in s:
    ID = 'wwv_flow_api.id(%s)' % ('28299%04d%04d%07d' % (APP, PAGINA, 1))
    if ID in s:
        sys.exit('o id novo já existe neste arquivo: ' + ID)
    seqs = [int(x) for x in re.findall(r"^,p_process_sequence=>(\d+)$", s, re.M)] or [0]
    bloco = ('wwv_flow_api.create_page_process(\n'
             ' p_id=>' + ID + '\n'
             ',p_process_sequence=>' + str(max(seqs) + 10) + '\n'
             ",p_process_point=>'ON_DEMAND'\n"
             ",p_process_type=>'NATIVE_PLSQL'\n"
             ",p_process_name=>'NC_BT_VAGA'\n"
             ',p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in VAGA) + '))\n'
             ",p_error_display_location=>'INLINE_IN_NOTIFICATION'\n"
             ',p_process_comment=>' + uni('Natcorp_BancoTalentos.js lê aqui os requisitos da requisição do processo seletivo (x01). Só leitura. Guia: BANCOTALENTOS-MANUTENCAO.md.') + '\n'
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
print('ok (página 182 do app 9110' + (', já aplicada antes' if JA else '') + (', link do currículo corrigido em %d relatório(s)' % n_arq if n_arq else '') + ') →', SAIDA)
