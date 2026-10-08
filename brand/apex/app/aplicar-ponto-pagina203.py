"""Ajusta a EXPORTAÇÃO da página 203 do app 9503 ("Abono - Colaborador", a Tratativa de Abono) para
o desenho Natcorp_Ponto.

    python3 aplicar-ponto-pagina203.py f9503_page_203.sql [saida.sql]

  · as URLs de arquivo da página passam a ser #WORKSPACE_IMAGES#Natcorp_Ponto.js / .css. Se houver
    outro arquivo Natcorp_ de janela (Natcorp_Abono, Natcorp_Apuracao — são das páginas 714 e
    181), ele sai: em 01/10 a 203 chegou com os do Abono no lugar dos dela. URLs que não são
    nossas ficam;
  · o comentário da página;
  · 08/10: o botão "Ajustar vários dias" (P203_BTN_AJUSTE_LOTE) na região Marcações (Static ID
    marcacao), ao lado de "Req. HE": abre a página 715 (janela) com o colaborador e o período da
    203 (e a visão de Marcações, P203_OPCAO: P/Q = plantão, como o link da grade manda à 714).
    Ao fechar a janela, a ação que a região já tem ("IR - Dialog Closed Refresh Region_1")
    refaz a grade e atualiza as regiões — nenhuma ação nova. Aparece para quem pode criar
    ajuste (o mesmo teste do botão "Criar" da 714: perfil sem pe_perfil_abono_geral.bloqueia).
Fora isso, nada muda em regiões, itens, botões, ações dinâmicas, validações nem processos.
Rodar de novo não muda nada.
"""
import os
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f9503_page_203.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
NOSSO = {'js': '#WORKSPACE_IMAGES#Natcorp_Ponto.js', 'css': '#WORKSPACE_IMAGES#Natcorp_Ponto.css'}
DE_JANELA = re.compile(r'#WORKSPACE_IMAGES#Natcorp_(Abono|Apuracao)\.(js|css)$')

t = open(ENTRADA, encoding='utf-8').read()
feito = []


def uni(s):
    s = s.replace("'", "''")
    if all(ord(c) < 128 for c in s):
        return "'" + s + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in s) + "')"


ini = t.index('wwv_flow_api.create_page(\n')
fim = t.index('\n);', ini)
pg = t[ini:fim]


def lista(campo):
    """as URLs de um campo (uma só '…' ou wwv_flow_string.join(…)) e o trecho exato"""
    m = re.search(r"^,p_" + campo + r"=>(?:'([^']*)'|wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n(.*?)\)\))$", pg, re.M | re.S)
    if not m:
        return None, []
    if m.group(1) is not None:
        return m, [m.group(1)]
    return m, re.findall(r"'([^']*)'", m.group(2))


def escreve(campo, urls):
    v = "'" + urls[0] + "'" if len(urls) == 1 else 'wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join("'" + u + "'" for u in urls) + '))'
    return ',p_' + campo + '=>' + v


for campo, tipo, ancora in [('javascript_file_urls', 'js', 'autocomplete_on_off'), ('css_file_urls', 'css', 'page_template_options')]:
    m, urls = lista(campo)
    novas = [u for u in urls if not DE_JANELA.search(u)]
    tiradas = [u for u in urls if DE_JANELA.search(u)]
    if NOSSO[tipo] not in novas:
        novas.append(NOSSO[tipo])
    if novas == urls:
        continue
    linha = escreve(campo, novas)
    if m:
        pg = pg[:m.start()] + linha + pg[m.end():]
    elif campo == 'javascript_file_urls':
        pg = re.sub(r"^(,p_autocomplete_on_off=>'[^']*')$", lambda x: x.group(1) + '\n' + linha, pg, count=1, flags=re.M)
    else:
        pg = re.sub(r"^,p_page_template_options=>", lambda x: linha + '\n,p_page_template_options=>', pg, count=1, flags=re.M)
    feito.append(tipo + ': ' + (', '.join(u.split('#')[-1] for u in tiradas) + ' → ' if tiradas else '+ ') + NOSSO[tipo].split('#')[-1])

LINHAS = [
    'Desenho Natcorp_Ponto (Tratativa de Abono): faixa do colaborador e do período, "Fechar o mês" em 4',
    'passos, um dia por linha com semanas e filtros, menus Lançar / Mais opções, Horas do dia com',
    '"O que o dia gerou" (Pedir ajuste = janela 181, Justificar = janela 10) e pedidos em cartões.',
    'Os botões e listas da página continuam aqui, escondidos e usados por procuração.',
    'Guia: brand/apex/app/PONTO-MANUTENCAO.md.',
]
if 'Desenho Natcorp_Ponto' not in pg:
    novo = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))'
    m = re.search(r"^,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)|'(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))$", pg, re.M | re.S)
    if m:
        pg = pg[:m.start()] + novo + pg[m.end():]
    else:
        pg = re.sub(r"^,p_help_text=>", lambda x: novo + '\n,p_help_text=>', pg, count=1, flags=re.M)
    feito.append('comentário da página')

t = t[:ini] + pg + t[fim:]

# ---------- 08/10: o botão "Ajustar vários dias" (abre a página 715) ----------
if "p_button_name=>'P203_BTN_AJUSTE_LOTE'" not in t:
    m = re.search(r"wwv_flow_api\.create_page_plug\(\n p_id=>(wwv_flow_api\.id\(\d+\))\n(?:(?!\n\);).)*?\n,p_region_name=>'marcacao'\n", t, re.S)
    he = re.search(r"wwv_flow_api\.create_page_button\(\n(?:(?!\n\);).)*?\n,p_button_name=>'BTN_REQ_HE_1'\n.*?\n\);\n", t, re.S)
    if not m or not he or m.group(1) not in he.group(0):
        sys.exit('não achei a região marcacao com o botão BTN_REQ_HE_1: conferir a exportação')
    modelo = re.search(r"^,p_button_template_id=>(wwv_flow_api\.id\(\d+\))$", he.group(0), re.M).group(1)
    ident = 'wwv_flow_api.id(%s)' % ('28299%04d%04d%07d' % (9503, 203, 11))
    if ident in t:
        sys.exit('o id novo já existe neste arquivo: ' + ident)
    botao = ('wwv_flow_api.create_page_button(\n'
             ' p_id=>' + ident + '\n'
             ',p_button_sequence=>45\n'
             ',p_button_plug_id=>' + m.group(1) + '\n'
             ",p_button_name=>'P203_BTN_AJUSTE_LOTE'\n"
             ",p_button_action=>'REDIRECT_PAGE'\n"
             ",p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--iconRight'\n"
             ',p_button_template_id=>' + modelo + '\n'
             ",p_button_is_hot=>'Y'\n"
             ',p_button_image_alt=>' + uni('Ajustar vários dias') + '\n'
             ",p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'\n"
             ",p_button_redirect_url=>'f?p=&APP_ID.:715:&SESSION.::&DEBUG.:RP,715:P715_EMP,P715_MAT,P715_DT_INI,P715_DT_FIM,P715_OPCAO:&P203_EMP.,&P203_MAT.,&P203_DT_INI.,&P203_DT_FIM.,&P203_OPCAO.'\n"
             ',p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'
             "'select 1',\n"
             "'  from usuario_oracle uo',\n"
             "' where uo.nm_usuario_oracle = :P_USUARIO',\n"
             "'   and not exists (select 1',\n"
             "'                     from pe_perfil_abono_geral pe',\n"
             "'                    where uo.cd_perfil  = pe.cd_perfil',\n"
             "'                      and uo.cd_empresa = pe.cod_empresa',\n"
             "'                      and pe.bloqueia   = ''S'')'))\n"
             ",p_button_condition_type=>'EXISTS'\n"
             ",p_icon_css_classes=>'fa-calendar-check-o'\n"
             ",p_button_comment=>'Natcorp 08/10: abre a 715 (ajustar varios dias de uma vez). Ao fechar, a acao IR - Dialog Closed Refresh Region_1 da regiao atualiza a tela.'\n"
             ');\n')
    t = t[:he.end()] + botao + t[he.end():]
    feito.append('botão Ajustar vários dias')

fora = [l for l in t.split('\n') if re.match(r"^'.*'(,|\)\))$", l) and any(ord(c) > 127 for c in l)]
if fora:
    sys.exit('texto com acento sem unistr: ' + fora[0][:80])
open(SAIDA, 'w', encoding='utf-8').write(t)
print('ok →', SAIDA, '·', '; '.join(feito) if feito else 'nada a mudar (já ajustado)')
