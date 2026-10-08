"""Aplica a AVALIAÇÃO NA TELA (Natcorp_AvaliacaoMedica.js/.css) numa EXPORTAÇÃO da página 105 do app 2937
("Avaliação Médica").

    python3 aplicar-avaliacaomedica-pagina105.py f2937_page_105.sql [saida.sql]

Reconhece a página pelo CONTEÚDO: a lista de perguntas sobre a QUESTIONARIO_QUESTOES2_1 e o item
P105_COD_QUESTIONARIO. O que muda (tudo visível no Page Designer):
  · as URLs do Natcorp_AvaliacaoMedica.js e .css e o comentário da página;
  · DOIS processos NOVOS (Processing › Ajax Callback):
      NC_AVAL_PERGUNTAS — as perguntas do questionário (ordem, texto, tipo), as alternativas de cada
                          uma e a resposta já dada, em JSON (mesmas tabelas da lista e da janela 102);
      NC_AVAL_SALVAR    — grava UMA resposta com a regra da janela 102 (atualiza a alternativa e o
                          texto; sem a linha, cria). x01 questão, x02 alternativa, x03 texto, x04 ordem.
NENHUMA região, item, botão, ação dinâmica ou processo existente é tocado. A lista original e a
janela 102 continuam (o desenho usa a lista se os processos faltarem).
Roda de novo sobre um arquivo já alterado: não altera duas vezes. Guia: AVALIACAOMEDICA-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2937_page_105.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_AvaliacaoMedica' in s

if 'questionario_questoes2_1' not in s or "p_name=>'P105_COD_QUESTIONARIO'" not in s:
    sys.exit('este arquivo não é a página da Avaliação Médica (lista sobre a QUESTIONARIO_QUESTOES2_1 e o item P105_COD_QUESTIONARIO)')
APP = int(re.search(r'p_default_application_id=>(\d+)', s).group(1))

JS = '#WORKSPACE_IMAGES#Natcorp_AvaliacaoMedica.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_AvaliacaoMedica.css'

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
    'DESENHO DA TELA (Natcorp_AvaliacaoMedica.css / Natcorp_AvaliacaoMedica.js)',
    '',
    'O questionário inteiro na tela: quem é avaliado e a avaliação no alto (com o Relatório), a barra de',
    'progresso ("12 de 17 respondidas", Todas | Faltam, Próxima sem resposta) e cada pergunta com a resposta',
    'ali mesmo: alternativas em botões (um toque salva e vai para a próxima; teclas 1 a 9) ou texto (salva',
    'sozinho). Subperguntas recuadas. Lê e grava pelos processos NC_AVAL_PERGUNTAS e NC_AVAL_SALVAR (mesma',
    'regra da janela 102). Sem eles, a lista original continua, com a janela de sempre.',
    'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/AVALIACAOMEDICA-MANUTENCAO.md.',
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
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_AvaliacaoMedica)')
    t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")
    t = poe(t, 'javascript_file_urls', ",p_css_file_urls=>'" + CSS + "'")
    return comentario(t)


m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + (comentario(m.group(0)) if JA else pagina(m.group(0))) + s[m.end():]




# ---------- os dois processos (Ajax Callback) ----------
LER = [
    '-- Natcorp_AvaliacaoMedica.js: as perguntas do questionário, as alternativas e a resposta já dada.',
    '-- Mesmas tabelas da lista "Perguntas" e da janela 102. Guia: AVALIACAOMEDICA-MANUTENCAO.md.',
    'begin',
    '  apex_json.open_object;',
    "  apex_json.open_array('perguntas');",
    '  for q in (select x.numero_ordem, x.cod_questao, p.nome_questao, nvl(p.ind_livre, \'N\') livre',
    '              from questionario_questoes2_1 x, questoes_1 p',
    '             where p.cod_questao      = x.cod_questao',
    '               and p.cod_formacao     = x.cod_formacao',
    '               and x.cod_questionario = :P105_COD_QUESTIONARIO',
    '               and x.cod_formacao     = :P105_COD_FORMACAO',
    '             order by x.numero_ordem) loop',
    '    apex_json.open_object;',
    "    apex_json.write('ordem', q.numero_ordem);",
    "    apex_json.write('questao', q.cod_questao);",
    "    apex_json.write('texto', q.nome_questao);",
    "    apex_json.write('livre', q.livre);",
    '    for r in (select a.cod_resposta, a.resp_texto_livre',
    '                from avaliacao_medica_respostas a',
    '               where a.cod_empresa      = :P105_COD_EMPRESA',
    '                 and a.matricula        = :P105_MATRICULA',
    "                 and trunc(a.data_avaliacao) = to_date(:P105_DATA_AVALIACAO, 'dd/mm/yyyy')",
    '                 and a.cod_formacao     = :P105_COD_FORMACAO',
    '                 and a.cod_questionario = :P105_COD_QUESTIONARIO',
    '                 and a.cod_questao      = q.cod_questao',
    '                 and rownum = 1) loop',
    "      apex_json.write('resposta', r.cod_resposta);",
    "      apex_json.write('texto_resp', r.resp_texto_livre);",
    '    end loop;',
    "    apex_json.open_array('opcoes');",
    "    if q.livre = 'N' then",
    '      for o in (select resp.cod_resposta, resp.nome_resposta',
    '                  from resposta_1 resp, questionario_questoes_1 qure',
    '                 where resp.cod_resposta     = qure.cod_resposta',
    '                   and resp.cod_formacao     = qure.cod_formacao',
    '                   and qure.cod_questionario = :P105_COD_QUESTIONARIO',
    '                   and qure.cod_questao      = q.cod_questao',
    '                   and qure.cod_formacao     = :P105_COD_FORMACAO',
    '                 order by qure.numero_ordem) loop',
    '        apex_json.open_object;',
    "        apex_json.write('c', o.cod_resposta);",
    "        apex_json.write('d', o.nome_resposta);",
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
    '-- Natcorp_AvaliacaoMedica.js: grava UMA resposta com AS MESMAS AÇÕES da janela 102 ("SALVAR ALTERNATIVA",',
    '-- change com valor; "Salvar Dissertativa", focusout com valor): sem valor, nada; sem a linha, cria pela',
    '-- pergunta conferida no questionário (ordem vinda do banco); depois atualiza alternativa e texto.',
    '-- x01 = cod_questao, x02 = cod_resposta (alternativa), x03 = texto (dissertativa). (04/10: igual à 102)',
    'declare',
    '  v_cod number(15);',
    '  cursor t is',
    '    select cod_questao from avaliacao_medica_respostas',
    '     where cod_empresa = :P105_COD_EMPRESA',
    '       and matricula = :P105_MATRICULA',
    '       and data_avaliacao = :P105_DATA_AVALIACAO',
    '       and cod_formacao = :P105_COD_FORMACAO',
    '       and cod_questionario = :P105_COD_QUESTIONARIO',
    '       and cod_questao = apex_application.g_x01;',
    'begin',
    '  if apex_application.g_x02 is null and apex_application.g_x03 is null then',
    '    apex_json.open_object;',
    "    apex_json.write('ok', true);",
    "    apex_json.write('nada', true);",
    '    apex_json.close_object;',
    '    return;',
    '  end if;',
    '  open t; fetch t into v_cod; close t;',
    '  if v_cod is null then',
    '    for i in (select ques.cod_questionario, perg.cod_questao, qupe.numero_ordem',
    '                from questionario_1 ques, formacao form, questionario_questoes2_1 qupe, questoes_1 perg',
    '               where ques.cod_formacao = form.cod_formacao',
    '                 and qupe.cod_formacao = ques.cod_formacao',
    '                 and qupe.cod_questionario = ques.cod_questionario',
    '                 and perg.cod_formacao = qupe.cod_formacao',
    '                 and perg.cod_questao = qupe.cod_questao',
    '                 and qupe.cod_formacao = :P105_COD_FORMACAO',
    '                 and qupe.cod_questionario = :P105_COD_QUESTIONARIO',
    '                 and qupe.cod_questao = apex_application.g_x01',
    '               order by qupe.numero_ordem)',
    '    loop',
    '      insert into avaliacao_medica_respostas',
    '        (cod_empresa, matricula, data_avaliacao, cod_formacao, cod_questionario, cod_questao,',
    '         cod_resposta, resp_texto_livre, requer_atencao, observacao, ordem_pergunta, tipo_avaliado)',
    "      values (:P105_COD_EMPRESA, :P105_MATRICULA, to_date(:P105_DATA_AVALIACAO, 'dd/mm/yyyy'), :P105_COD_FORMACAO,",
    "              i.cod_questionario, i.cod_questao, null, null, 'N', null, i.numero_ordem, :P105_TIPO_AVALIADO);",
    '    end loop;',
    '    commit;',
    '  end if;',
    '  update avaliacao_medica_respostas',
    '     set cod_resposta     = nvl(apex_application.g_x02, null)',
    '        ,resp_texto_livre = nvl(apex_application.g_x03, null)',
    '   where cod_empresa      = :P105_COD_EMPRESA',
    '     and matricula        = :P105_MATRICULA',
    "     and to_date(data_avaliacao, 'dd/mm/yyyy') = to_date(:P105_DATA_AVALIACAO, 'dd/mm/yyyy')",
    '     and cod_formacao     = :P105_COD_FORMACAO',
    '     and cod_questionario = :P105_COD_QUESTIONARIO',
    '     and cod_questao      = apex_application.g_x01;',
    '  commit;',
    '  apex_json.open_object;',
    "  apex_json.write('ok', true);",
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
        ('NC_AVAL_PERGUNTAS', LER, 'Natcorp_AvaliacaoMedica.js lê aqui as perguntas, as alternativas e as respostas. Guia: AVALIACAOMEDICA-MANUTENCAO.md.'),
        ('NC_AVAL_SALVAR', SALVAR, 'Natcorp_AvaliacaoMedica.js grava aqui uma resposta (regra da janela 102). Guia: AVALIACAOMEDICA-MANUTENCAO.md.')]):
    if ("p_process_name=>'" + nome + "'") in s:
        # já existe (arquivo aplicado antes): troca só o corpo PL/SQL pelo atual (04/10)
        m = re.search(r"(p_process_name=>'" + nome + r"'\n,p_process_sql_clob=>)wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)\n", s, re.S)
        if not m:
            sys.exit('não achei o corpo do processo ' + nome)
        s = s[:m.start()] + m.group(1) + 'wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in corpo_pl) + '))\n' + s[m.end():]
        continue
    ID = 'wwv_flow_api.id(%s)' % ('28299%04d%04d%07d' % (APP, 105, k + 1))
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
print('ok (página 105 do app 2937' + (', só o comentário' if JA else '') + ') →', SAIDA)
