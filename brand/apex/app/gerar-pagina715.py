"""Gera a EXPORTAÇÃO da página NOVA 715 do app 9503 ("Ajustar vários dias"): f9503_page_715.sql.

    python3 gerar-pagina715.py

A página 715 é uma JANELA (modal) aberta pelo botão "Ajustar vários dias" da Tratativa de Abono
(9503:203, posto pelo aplicar-ponto-pagina203.py). Ela recebe o colaborador e o período da 203
(P715_EMP, P715_MAT, P715_DT_INI, P715_DT_FIM e P715_OPCAO, a visão de Marcações da 203 —
P/Q = plantão; todos protegidos por checksum) e mostra os dias com os
horários de cada posição. A pessoa muda os horários que quiser, escolhe o motivo e toca em "Salvar"
UMA vez: o servidor cria UM PEDIDO DE AJUSTE POR HORÁRIO MUDADO, com as mesmas validações e os
mesmos processos da janela de ajuste individual (9503:714), que NÃO é alterada.

O que vai na página:
  · uma região "Ajustar vários dias" (Static ID nc_lote), onde o Natcorp_Lote.js desenha a tela;
  · os 5 itens escondidos acima;
  · os processos Ajax Callback NC_LOTE_DIAS (lê) e NC_LOTE_CRIAR (cria), com o código dos arquivos
    NC_LOTE_DIAS.plsql.sql e NC_LOTE_CRIAR.plsql.sql;
  · JavaScript / CSS: #WORKSPACE_IMAGES#Natcorp_Lote.js e .css.
Os modelos (página, região) e o deslocamento de ids são os da exportação da 714 da MESMA base
(f9503_page_714.ORIGINAL.sql): importar na base de onde veio essa exportação. Rodar de novo gera o
mesmo arquivo.
"""
import os
import re
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.join(AQUI, 'f9503_page_714.ORIGINAL.sql')
SAIDA = os.path.join(AQUI, 'f9503_page_715.sql')
PAG = 715

ref = open(BASE, encoding='utf-8').read()
cab = ref[:ref.index('prompt --application/pages/delete_00714')]
if 'p_default_application_id=>9503' not in cab:
    sys.exit('a exportação de referência não é do app 9503')
cab = re.sub(r'--     PAGE: 714', '--     PAGE: 715', cab)
cab = re.sub(r'--   Exported By:.*', '--   Exported By:     gerar-pagina715.py (Natcorp)', cab)
UI = re.search(r",p_user_interface_id=>(wwv_flow_api\.id\(\d+\))", ref).group(1)
REGIAO = re.search(r"p_plug_name=>unistr\('Marca\\00E7\\00E3o'\)\n,p_region_name=>'MARC'\n.*?,p_plug_template=>(wwv_flow_api\.id\(\d+\))", ref, re.S).group(1)


def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def ident(k):
    return 'wwv_flow_api.id(%s)' % ('28299%04d%04d%07d' % (9503, PAG, k))


def junta(linhas):
    return 'wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in linhas) + '))'


COMENTARIO = [
    'Natcorp 08/10 - Ajustar varios dias de uma vez (aberta pelo botao da 203).',
    'A pessoa muda os horarios dos dias do periodo e toca em Salvar uma vez: NC_LOTE_CRIAR cria um',
    'pedido de ajuste por horario mudado, com as validacoes e os processos da janela 714 (nao alterada).',
    'Tela desenhada pelo Natcorp_Lote.js; sem ele aparece so o aviso da regiao. Guia: brand/apex/app/LOTE-MANUTENCAO.md.',
]
HTML = [
    '<div id="nc-lote" class="nc-lote" aria-live="polite">',
    '  <p class="nc-lote-espera">Carregando os dias do per&iacute;odo&hellip;</p>',
    '  <noscript>Esta tela precisa do arquivo Natcorp_Lote.js (JavaScript da p&aacute;gina).</noscript>',
    '</div>',
]

partes = [cab.rstrip('\n') + '\n']
partes.append('prompt --application/pages/delete_%05d\nbegin\nwwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>%d);\nend;\n/\n' % (PAG, PAG))
partes.append('prompt --application/pages/page_%05d\nbegin\n' % PAG)
partes.append('wwv_flow_api.create_page(\n'
              ' p_id=>%d\n' % PAG +
              ',p_user_interface_id=>' + UI + '\n'
              ',p_name=>' + uni('Ajustar vários dias') + '\n'
              ",p_page_mode=>'MODAL'\n"
              ',p_step_title=>' + uni('Ajustar vários dias') + '\n'
              ",p_reload_on_submit=>'A'\n"
              ",p_warn_on_unsaved_changes=>'N'\n"
              ",p_autocomplete_on_off=>'OFF'\n"
              ",p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Lote.js'\n"
              ",p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Lote.css'\n"
              ",p_page_template_options=>'#DEFAULT#'\n"
              ",p_dialog_height=>'640'\n"
              ",p_dialog_width=>'1100'\n"
              ",p_dialog_max_width=>'100%'\n"
              ",p_dialog_chained=>'N'\n"
              ",p_protection_level=>'C'\n"
              ',p_page_comment=>' + junta(COMENTARIO) + '\n'
              ",p_help_text=>'No help is available for this page.'\n"
              ",p_last_updated_by=>'NATCORP'\n"
              ",p_last_upd_yyyymmddhh24miss=>'20261008000000'\n"
              ');\n')
partes.append('wwv_flow_api.create_page_plug(\n'
              ' p_id=>' + ident(1) + '\n'
              ',p_plug_name=>' + uni('Ajustar vários dias') + '\n'
              ",p_region_name=>'nc_lote'\n"
              ",p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'\n"
              ',p_plug_template=>' + REGIAO + '\n'
              ',p_plug_display_sequence=>10\n'
              ",p_plug_display_point=>'BODY'\n"
              ',p_plug_source=>' + junta(HTML) + '\n'
              ",p_plug_query_options=>'DERIVED_REPORT_COLUMNS'\n"
              ",p_attribute_01=>'N'\n"
              ",p_attribute_02=>'HTML'\n"
              ');\n')
for k, nome in enumerate(['P715_EMP', 'P715_MAT', 'P715_DT_INI', 'P715_DT_FIM', 'P715_OPCAO'], start=11):
    partes.append('wwv_flow_api.create_page_item(\n'
                  ' p_id=>' + ident(k) + '\n'
                  ",p_name=>'" + nome + "'\n"
                  ',p_item_sequence=>' + str((k - 10) * 10) + '\n'
                  ',p_item_plug_id=>' + ident(1) + '\n'
                  ",p_display_as=>'NATIVE_HIDDEN'\n"
                  ",p_attribute_01=>'Y'\n"
                  ');\n')
partes.append('end;\n/\n')
for k, (nome, com) in enumerate([
        ('NC_LOTE_DIAS', 'Le os dias do periodo (posicoes da jornada, horario previsto, marcacao, abono, pedido aberto) e os motivos. So le.'),
        ('NC_LOTE_CRIAR', 'Cria um pedido de ajuste por horario mudado, com as validacoes e os processos da janela 714.')], start=21):
    pl = open(os.path.join(AQUI, nome + '.plsql.sql'), encoding='utf-8').read().rstrip('\n').split('\n')
    if any(ord(c) > 127 for l in pl for c in l):
        sys.exit(nome + '.plsql.sql tem acento: o banco guarda Latin-1, deixe o PL/SQL sem acento')
    partes.append('begin\nwwv_flow_api.create_page_process(\n'
                  ' p_id=>' + ident(k) + '\n'
                  ',p_process_sequence=>' + str((k - 20) * 10) + '\n'
                  ",p_process_point=>'ON_DEMAND'\n"
                  ",p_process_type=>'NATIVE_PLSQL'\n"
                  ",p_process_name=>'" + nome + "'\n"
                  ',p_process_sql_clob=>' + junta(pl) + '\n'
                  ",p_error_display_location=>'INLINE_IN_NOTIFICATION'\n"
                  ',p_process_comment=>' + uni(com) + '\n'
                  ');\nend;\n/\n')
partes.append(ref[ref.index('prompt --application/end_environment'):])

t = ''.join(partes)
if t.count('\nbegin\n') != t.count('\nend;\n/\n'):
    sys.exit('blocos begin/end desequilibrados')
open(SAIDA, 'w', encoding='utf-8').write(t)
print('ok →', os.path.basename(SAIDA), '·', len(t) // 1024, 'KB')
