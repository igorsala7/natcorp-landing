"""Aplica o QUESTIONÁRIO DO TREINAMENTO NA TELA (Natcorp_QuestTreinamento.js/.css) numa EXPORTAÇÃO da
página 2 do app 9104 ("Respostas de Questionário").

    python3 aplicar-questtreinamento-pagina2.py f9104_page_2.sql [saida.sql]

Reconhece a página pelo CONTEÚDO: a lista sobre a TR_QUESTIONARIO_PERGUNTAS e o item P2_QUESTIONARIO.
O que muda (tudo visível no Page Designer):
  · as URLs do Natcorp_QuestTreinamento.js e .css e o comentário da página;
  · DOIS processos NOVOS (Processing › Ajax Callback):
      NC_QUEST_PERGUNTAS — as perguntas do questionário (texto, tipo), as respostas possíveis de cada
                           uma e a resposta já dada, em JSON (mesmas tabelas da lista e da janela 3);
      NC_QUEST_SALVAR    — grava UMA resposta com a regra da janela 3 (nota da resposta, data, usuário):
                           atualiza; sem a linha, cria. x01 pergunta, x02 resposta, x03 texto.
    Os dois conferem que a pessoa é participante da turma (a mesma regra de acesso da lista
    "Matrícula") e que a pergunta e a resposta são deste questionário — a janela 3 tinha essa
    garantia pelo checksum dos parâmetros.
NENHUMA região, item, botão, ação dinâmica ou processo existente é tocado. A lista original e a
janela 3 continuam (o desenho usa a lista se os processos faltarem).
Roda de novo sobre um arquivo já alterado: não altera duas vezes. Guia: QUESTTREINAMENTO-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f9104_page_2.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_QuestTreinamento' in s

if 'tr_questionario_perguntas' not in s or "p_name=>'P2_QUESTIONARIO'" not in s:
    sys.exit('este arquivo não é a página do questionário do treinamento (lista sobre a TR_QUESTIONARIO_PERGUNTAS e o item P2_QUESTIONARIO)')
APP = int(re.search(r'p_default_application_id=>(\d+)', s).group(1))

JS = '#WORKSPACE_IMAGES#Natcorp_QuestTreinamento.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_QuestTreinamento.css'

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



LINHAS = [
    'DESENHO DA TELA (Natcorp_QuestTreinamento.css / Natcorp_QuestTreinamento.js)',
    '',
    'Primeiro os parâmetros, como sempre: os 5 campos originais (empresa, curso, turma, matrícula, questionário)',
    'com a roupa nova e o botão Começar (o Pesquisar original). Depois, as perguntas uma por tela ("Pergunta 3',
    'de 14"), com carinhas nas escalas, Ouvir (voz do celular) e um toque que grava e passa para a próxima; no',
    'fim, "Obrigado!" com a lista para conferir; Trocar (o Filtrar original) volta aos parâmetros. Lê e grava',
    'pelos processos NC_QUEST_PERGUNTAS e NC_QUEST_SALVAR (regra da janela 3). Sem eles, a lista original volta.',
    'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/QUESTTREINAMENTO-MANUTENCAO.md.',
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
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_QuestTreinamento)')
    t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")
    t = poe(t, 'javascript_file_urls', ",p_css_file_urls=>'" + CSS + "'")
    return comentario(t)


m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + (comentario(m.group(0)) if JA else pagina(m.group(0))) + s[m.end():]


# ---------- os dois processos (Ajax Callback) ----------
# a pessoa é participante da turma, com a MESMA regra de acesso da lista "Matrícula" (P2_MATRICULA)
CONFERE = [
    '  select count(*) into v_ok',
    '    from tr_turma_participantes tq',
    '   where tq.cod_empresa = :P2_EMPRESA',
    '     and tq.cod_turma   = :P2_TURMA',
    '     and tq.cod_curso   = :P2_CURSO',
    '     and tq.matricula   = :P2_MATRICULA',
    "     and F_Acesso_Emp_PG_APEX(tq.cod_empresa, :P_USUARIO, :P_PAINEL) = 'S'",
    "     and ((tq.tipo_participante = 'F'",
    '           and exists (select 1 from informacoes_funcionais f',
    '                        where f.cod_empresa = tq.cod_empresa and f.matricula = tq.matricula',
    "                          and f_acesso_pg_apex(f.cod_empresa, f.matricula, f.filial, f.cd_nivel, :P_USUARIO, :P_PAINEL) = 'S'))",
    "          or tq.tipo_participante = 'C')",
    '     and exists (select 1 from tr_turma_questionarios x',
    '                  where x.cod_questionario = :P2_QUESTIONARIO and x.cod_turma = tq.cod_turma and x.cod_curso = tq.cod_curso);',
]
LER = [
    '-- Natcorp_QuestTreinamento.js: as perguntas do questionário, as respostas possíveis e a resposta já dada.',
    '-- Mesmas tabelas da lista "Perguntas do questionário" e da janela 3. Guia: QUESTTREINAMENTO-MANUTENCAO.md.',
    'declare',
    '  v_ok number;',
    'begin',
] + CONFERE + [
    '  apex_json.open_object;',
    '  if v_ok = 0 then',
    "    apex_json.write('erro', 'participante');",
    '    apex_json.close_object;',
    '    return;',
    '  end if;',
    "  apex_json.open_array('perguntas');",
    '  for q in (select qp.cod_pergunta, qp.peso, p.descricao, p.tipo_pergunta',
    '              from tr_questionario_perguntas qp, tr_perguntas p',
    '             where p.cod_pergunta = qp.cod_pergunta',
    '               and qp.cod_questionario = :P2_QUESTIONARIO',
    '             order by qp.cod_pergunta) loop',
    '    apex_json.open_object;',
    "    apex_json.write('cod', q.cod_pergunta);",
    "    apex_json.write('texto', q.descricao);",
    "    apex_json.write('tipo', q.tipo_pergunta);",
    "    apex_json.write('peso', q.peso);",
    '    for r in (select qpp.resposta_alt, qpp.resposta_dis',
    '                from tr_questionario_participante qpp',
    '               where qpp.cod_empresa      = :P2_EMPRESA',
    '                 and qpp.matricula        = :P2_MATRICULA',
    '                 and qpp.cod_turma        = :P2_TURMA',
    '                 and qpp.cod_curso        = :P2_CURSO',
    '                 and qpp.cod_questionario = :P2_QUESTIONARIO',
    '                 and qpp.cod_pergunta     = q.cod_pergunta',
    '                 and rownum = 1) loop',
    "      apex_json.write('alt', r.resposta_alt);",
    "      apex_json.write('dis', r.resposta_dis);",
    '    end loop;',
    "    apex_json.open_array('opcoes');",
    "    if q.tipo_pergunta = 'M' then",
    '      for o in (select r.cod_resposta, r.descricao',
    '                  from tr_questionario_respostas qr, tr_respostas r',
    '                 where r.cod_resposta     = qr.cod_resposta',
    '                   and qr.cod_questionario = :P2_QUESTIONARIO',
    '                   and qr.cod_pergunta     = q.cod_pergunta',
    '                 order by r.cod_resposta) loop',
    '        apex_json.open_object;',
    "        apex_json.write('c', o.cod_resposta);",
    "        apex_json.write('d', o.descricao);",
    '        apex_json.close_object;',
    '      end loop;',
    '    end if;',
    '    apex_json.close_array;',
    '    apex_json.close_object;',
    '  end loop;',
    '  apex_json.close_array;',
    '  apex_json.close_object;',
    'end;',
]
SALVAR = [
    '-- Natcorp_QuestTreinamento.js: grava UMA resposta, com a regra da janela 3 (a nota vem do valor da resposta',
    '-- no questionário; data da resposta, usuário e atualização = agora). Atualiza; sem a linha, cria.',
    '-- x01 = cod_pergunta, x02 = cod_resposta (múltipla escolha), x03 = texto (dissertativa).',
    'declare',
    '  v_ok   number;',
    '  v_nota number;',
    '  v_data date := sysdate;',
    'begin',
] + CONFERE + [
    '  if v_ok = 0 then',
    "    raise_application_error(-20001, 'Participante, turma ou questionário não conferem.');",
    '  end if;',
    '  select count(*) into v_ok from tr_questionario_perguntas',
    '   where cod_questionario = :P2_QUESTIONARIO and cod_pergunta = to_number(apex_application.g_x01);',
    '  if v_ok = 0 then',
    "    raise_application_error(-20002, 'A pergunta não é deste questionário.');",
    '  end if;',
    '  if apex_application.g_x02 is not null then',
    '    select count(*), max(qr.valor_resposta) into v_ok, v_nota',
    '      from tr_questionario_respostas qr',
    '     where qr.cod_questionario = :P2_QUESTIONARIO',
    '       and qr.cod_pergunta     = to_number(apex_application.g_x01)',
    '       and qr.cod_resposta     = to_number(apex_application.g_x02);',
    '    if v_ok = 0 then',
    "      raise_application_error(-20003, 'A resposta não é desta pergunta.');",
    '    end if;',
    '  end if;',
    '  update tr_questionario_participante',
    '     set resposta_alt   = to_number(apex_application.g_x02),',
    '         resposta_dis   = substr(apex_application.g_x03, 1, 1000),',
    '         nota_resposta  = v_nota,',
    '         data_resposta  = v_data,',
    '         usuario        = :APP_USER,',
    '         dt_atualizacao = v_data',
    '   where cod_empresa      = :P2_EMPRESA',
    '     and matricula        = :P2_MATRICULA',
    '     and cod_turma        = :P2_TURMA',
    '     and cod_curso        = :P2_CURSO',
    '     and cod_questionario = :P2_QUESTIONARIO',
    '     and cod_pergunta     = to_number(apex_application.g_x01);',
    '  if sql%rowcount = 0 then',
    '    insert into tr_questionario_participante',
    '      (cod_empresa, matricula, cod_turma, cod_curso, cod_questionario, cod_pergunta,',
    '       resposta_alt, resposta_dis, data_resposta, nota_resposta, usuario, dt_atualizacao)',
    '    values',
    '      (:P2_EMPRESA, :P2_MATRICULA, :P2_TURMA, :P2_CURSO, :P2_QUESTIONARIO, to_number(apex_application.g_x01),',
    '       to_number(apex_application.g_x02), substr(apex_application.g_x03, 1, 1000), v_data, v_nota, :APP_USER, v_data);',
    '  end if;',
    '  apex_json.open_object;',
    "  apex_json.write('ok', true);",
    "  apex_json.write('data', to_char(v_data, 'dd/mm/yyyy'));",
    '  apex_json.close_object;',
    'exception when others then',
    '  apex_json.open_object;',
    "  apex_json.write('ok', false);",
    "  apex_json.write('erro', sqlerrm);",
    '  apex_json.close_object;',
    'end;',
]



seqs = [int(x) for x in re.findall(r"^,p_process_sequence=>(\d+)$", s, re.M)] or [0]
for k, (nome, corpo_pl, coment) in enumerate([
        ('NC_QUEST_PERGUNTAS', LER, 'Natcorp_QuestTreinamento.js lê aqui as perguntas, as respostas possíveis e as já dadas. Guia: QUESTTREINAMENTO-MANUTENCAO.md.'),
        ('NC_QUEST_SALVAR', SALVAR, 'Natcorp_QuestTreinamento.js grava aqui uma resposta (regra da janela 3). Guia: QUESTTREINAMENTO-MANUTENCAO.md.')]):
    if ("p_process_name=>'" + nome + "'") in s:
        continue
    ID = 'wwv_flow_api.id(%s)' % ('28299%04d%04d%07d' % (APP, 2, k + 1))
    if ID in s:
        sys.exit('o id novo já existe neste arquivo: ' + ID)
    bloco = ('wwv_flow_api.create_page_process(\n'
             ' p_id=>' + ID + '\n'
             ',p_process_sequence=>' + str(max(seqs) + 10 * (k + 1)) + '\n'
             ",p_process_point=>'ON_DEMAND'\n"
             ",p_process_type=>'NATIVE_PLSQL'\n"
             ",p_process_name=>'" + nome + "'\n"
             ',p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in corpo_pl) + '))\n'
             ",p_error_display_location=>'INLINE_IN_NOTIFICATION'\n"
             ',p_process_comment=>' + uni(coment) + '\n'
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
print('ok (página 2 do app 9104' + (', só o comentário' if JA else '') + ') →', SAIDA)
