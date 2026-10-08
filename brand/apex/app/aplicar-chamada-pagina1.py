"""Aplica o PAINEL NOVO DA CHAMADA DE PACIENTES (Natcorp_Chamada.js/.css) numa EXPORTAÇÃO da página 1 do
app 2936 ("Chamada de Pacientes: Painel" — o monitor da sala de espera).

    python3 aplicar-chamada-pagina1.py f2936_page_1.sql [saida.sql]

Reconhece a página pelo CONTEÚDO: as regiões sobre a MT_CHAMADA_PACIENTE_STATUS e os itens P1_SENHA_CAD/MED.
O que muda (tudo visível no Page Designer):
  · as URLs do Natcorp_Chamada.js e .css e o comentário da página;
  · o JavaScript "Execute when Page Loads" (recarregar a cada 10 s e a cada 5 min) fica dentro de
    if (!window.__ncChamada) { … } — com o painel novo, a página NÃO recarrega mais;
  · as duas ações "SENHA_CAD/SENHA_MED - get_lock_time" (marcar a chamada e tocar o bipe) passam a ter a
    condição $v('P1_SENHA_…') !== '' && !window.__ncChamada — com o painel novo, quem marca é o processo;
  · UM processo NOVO (Processing › Ajax Callback) NC_CHAMADA_ESTADO: para cada fila (C = cadastro,
    M = médico) as chamadas novas (flag = 1, que ele marca como anunciadas — flag = 0, como a ação antiga) e
    as da última hora, com os segundos desde a chamada.
Sem o Natcorp_Chamada.js, a marca não existe e TUDO funciona como antes (o desligar é tirar as URLs).
Regiões, itens e o processo "Senha" não são tocados. Roda de novo sem alterar duas vezes.
Guia: CHAMADA-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2936_page_1.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_Chamada' in s
if 'MT_CHAMADA_PACIENTE_STATUS' not in s or "p_name=>'P1_SENHA_CAD'" not in s:
    sys.exit('este arquivo não é o painel da chamada de pacientes (MT_CHAMADA_PACIENTE_STATUS e o item P1_SENHA_CAD)')
APP = int(re.search(r'p_default_application_id=>(\d+)', s).group(1))
JS = '#WORKSPACE_IMAGES#Natcorp_Chamada.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Chamada.css'
Q = "'"


def uni(t):
    if all(ord(c) < 128 for c in t):
        return Q + t.replace(Q, Q + Q) + Q
    return "unistr(" + Q + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace(Q, Q + Q)) + Q + ")"


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]


LINHAS = [
    'DESENHO DA TELA (Natcorp_Chamada.css / Natcorp_Chamada.js)',
    '',
    'O painel da TV da sala de espera: as duas filas (Cadastro / guichê e Atendimento médico / local), a senha',
    'chamada agora em tamanho de placa, as anteriores e o relógio. Senha nova toma a tela por alguns segundos, com',
    'um sino moderno (sintetizado) e a senha falada pela voz do computador. Lê a cada 4 s pelo processo',
    'NC_CHAMADA_ESTADO, SEM recarregar a página (o código antigo de recarregar e as ações do bipe só rodam sem o',
    'Natcorp_Chamada.js). Ajustes da TV (som, voz, volume, testar, tela cheia) ao mexer o mouse.',
    'Para desligar: tire as duas URLs de arquivo (tudo volta como era). Guia: brand/apex/app/CHAMADA-MANUTENCAO.md.',
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
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_Chamada)')
    t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>" + uni(JS))
    t = poe(t, 'javascript_file_urls', ",p_css_file_urls=>" + uni(CSS))
    # o "Execute when Page Loads" (recarregar a cada 10 s / 5 min) só sem o painel novo
    ini = ",p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(\n"
    if ini not in t:
        sys.exit('não achei o JavaScript "Execute when Page Loads"')
    a = t.index(ini) + len(ini)
    b = t.index("))\n", a)
    t = t[:a] + uni('if (!window.__ncChamada) {  // com o Natcorp_Chamada.js a TV lê sozinha, sem recarregar') + ',\n' + t[a:b] + ',\n' + uni('}') + t[b:]
    return comentario(t)


m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + (comentario(m.group(0)) if JA else pagina(m.group(0))) + s[m.end():]

# ---------- as duas ações antigas (marcar + bipe): só sem o painel novo ----------
if not JA:
    for item in ('P1_SENHA_CAD', 'P1_SENHA_MED'):
        velho = (",p_triggering_element=>'" + item + "'\n,p_condition_element=>'" + item + "'\n"
                 ",p_triggering_condition_type=>'NOT_NULL'\n")
        if velho not in s:
            sys.exit('não achei a ação de ' + item)
        expr = "$v('" + item + "') !== '' && !window.__ncChamada"
        s = s.replace(velho, ",p_triggering_element=>'" + item + "'\n,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'\n"
                      ",p_triggering_expression=>" + uni(expr) + "\n")

# ---------- o processo (Ajax Callback) ----------
ESTADO = [
    '-- Natcorp_Chamada.js: o estado das duas filas, a cada 4 s (o painel não recarrega mais a página).',
    '-- Mesma regra das regiões e das ações antigas: a chamada vale pelo registro mais recente da senha',
    '-- (max(data_status) por senha/seq/data); "novas" = flag 1 (ainda não anunciadas): devolve e marca flag 0,',
    '-- como fazia a ação "get_lock_time". "ultimas" = as da última hora (0,042 dia), da mais recente.',
    '-- Guia: CHAMADA-MANUTENCAO.md.',
    'declare',
    '  procedure fila(p_status varchar2, p_nome varchar2) is',
    '    n number := 0;',
    '  begin',
    '    apex_json.open_object(p_nome);',
    "    apex_json.open_array('novas');",
    "    for r in (select s.senha, s.local, to_char(s.data_status, 'HH24:MI') hora,",
    '                     round((sysdate - s.data_status) * 86400) seg',
    '                from mt_chamada_paciente_status s',
    '               where trunc(s.data_status) = trunc(sysdate)',
    '                 and s.status = p_status',
    '                 and s.flag = 1',
    '                 and s.data_status = (select max(x.data_status)',
    '                                        from mt_chamada_paciente_status x',
    '                                       where x.senha = s.senha',
    '                                         and x.seq = s.seq',
    '                                         and x.data = s.data)',
    '               order by s.data_status) loop',
    '      apex_json.open_object;',
    "      apex_json.write('senha', r.senha);",
    "      apex_json.write('local', r.local);",
    "      apex_json.write('hora', r.hora);",
    "      apex_json.write('seg', r.seg);",
    '      apex_json.close_object;',
    '      update mt_chamada_paciente_status',
    '         set flag = 0',
    '       where senha = r.senha',
    '         and status = p_status;',
    '    end loop;',
    '    apex_json.close_array;',
    "    apex_json.open_array('ultimas');",
    "    for r in (select s.senha, s.local, to_char(s.data_status, 'HH24:MI') hora,",
    '                     round((sysdate - s.data_status) * 86400) seg',
    '                from mt_chamada_paciente_status s',
    '               where trunc(s.data_status) = trunc(sysdate)',
    '                 and s.status = p_status',
    '                 and s.data_status between sysdate - 0.042 and sysdate',
    '                 and s.data_status = (select max(x.data_status)',
    '                                        from mt_chamada_paciente_status x',
    '                                       where x.senha = s.senha',
    '                                         and x.seq = s.seq',
    '                                         and x.data = s.data)',
    '               order by s.data_status desc) loop',
    '      n := n + 1;',
    '      exit when n > 6;',
    '      apex_json.open_object;',
    "      apex_json.write('senha', r.senha);",
    "      apex_json.write('local', r.local);",
    "      apex_json.write('hora', r.hora);",
    "      apex_json.write('seg', r.seg);",
    '      apex_json.close_object;',
    '    end loop;',
    '    apex_json.close_array;',
    '    apex_json.close_object;',
    '  end;',
    'begin',
    '  apex_json.open_object;',
    "  fila('C', 'cadastro');",
    "  fila('M', 'medico');",
    "  apex_json.write('agora', to_char(sysdate, 'HH24:MI:SS'));",
    '  apex_json.close_object;',
    '  commit;',
    'end;',
]
seqs = [int(x) for x in re.findall(r"^,p_process_sequence=>(\d+)$", s, re.M)] or [0]
for k, (nome, corpo_pl, coment) in enumerate([
        ('NC_CHAMADA_ESTADO', ESTADO, 'Natcorp_Chamada.js lê aqui as duas filas a cada 4 s e as chamadas novas (que este processo marca como anunciadas). Guia: CHAMADA-MANUTENCAO.md.')]):
    if ("p_process_name=>'" + nome + "'") in s:
        continue
    ID = 'wwv_flow_api.id(%s)' % ('28299%04d%04d%07d' % (APP, 1, k + 1))
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
    fimp = s.rfind('end;\n/\nprompt --application/end_environment')
    if fimp < 0:
        sys.exit('não achei o fim da página para pôr o processo')
    s = s[:fimp] + bloco + s[fimp:]

# ---------- conferência: nenhum atributo repetido em nenhum bloco ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
fora = [l for l in s.split('\n') if re.match(r"^,?p_[a-z0-9_]+=>'", l) and any(ord(c) > 127 for c in l)]
if fora:
    sys.exit('texto com acento sem unistr: ' + fora[0][:80])
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok (página 1 do app 2936' + (', só o comentário' if JA else '') + ') →', SAIDA)
