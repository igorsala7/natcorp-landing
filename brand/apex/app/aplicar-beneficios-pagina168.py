"""Aplica o desenho da Requisição de Benefícios numa EXPORTAÇÃO da página 168 do app 200.

    python3 aplicar-beneficios-pagina168.py f200_page_168.sql [saida.sql]

Funciona com a exportação de QUALQUER ambiente: acha tudo pelos NOMES (ID estático das
regiões, nome dos itens e dos botões, nome da ação dinâmica), nunca pelos números — cada
release instala o app com IDs internos novos, e uma exportação de página só entra no mesmo
app de onde saiu (ORA-02291 WWV_FLOW_STEP_UI_FK). Então: exporte a página do ambiente onde
vai importar, rode este script sobre ela, importe o resultado lá mesmo.

O que muda (tudo visível no Page Designer):
  · regiões novas "Seu valor para benefícios" (SALDO_BENEFICIOS, com P168_TOTAL/P168_SALDO)
    e "Pacote" (PACOTE_BENEFICIOS, sem moldura, com Escolhidos, Requisitados e Atuais dentro);
  · "Adicionar um benefício" em 5 colunas; títulos e rótulos em linguagem simples;
  · região de botões no fim da página; "Criar" → "Enviar pedido", "Adicionar" → "Adicionar ao pacote";
  · as classes nc-ben-… (o contrato com Natcorp_Beneficios.css/.js);
  · a ação "Show Region" (quando P168_MATRICULA muda) também mostra/esconde as regiões novas
    e a de botões;
  · o comentário da página com o guia de manutenção.
Roda de novo sobre um arquivo já alterado: não altera duas vezes (para no primeiro sinal).
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f200_page_168.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if "p_region_name=>'SALDO_BENEFICIOS'" in s:
    sys.exit('este arquivo já tem o desenho aplicado (SALDO_BENEFICIOS existe)')


def uni(t):
    """texto → literal do APEX (unistr com \\00E1 para os acentos)"""
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def blocos(fn):
    return list(re.finditer(r'wwv_flow_api\.' + fn + r'\(\n.*?\n\);\n', s, re.S))


def achar(fn, chave, valor):
    for m in blocos(fn):
        if re.search(r'^,?p_' + chave + r'=>' + re.escape(valor) + r'\s*$', m.group(0), re.M):
            return m
    sys.exit('não achei ' + fn + ' com p_' + chave + '=>' + valor)


# regiões: pelo ID estático ou, na exportação que ainda não tem, pelo nome — e ganha o ID
REGIOES = {
    'ESCOLHA_BENEFICIOS': ('create_page_plug', 'plug_name', 'Escolha os Benefícios'),
    'BENEFICIOS_ESCOLHIDOS': ('create_report_region', 'name', 'Benefícios Escolhidos'),
    'BENEFICIOS_REQUISITADOS': ('create_report_region', 'name', 'Benefícios Requisitados'),
    'BENEFICIOS_ATUAIS': ('create_report_region', 'name', 'Benefícios Atuais'),
    'BOTOES': ('create_page_plug', 'plug_name', 'Botões'),
    'COLABORADOR': ('create_page_plug', 'plug_name', 'Colaborador Solicitado'),
}


def dar_ids_estaticos():
    global s
    for sid, (fn, campo, nome) in REGIOES.items():
        if "p_region_name=>'%s'" % sid in s:
            continue
        m = None
        for b in blocos(fn):
            if re.search(r'^,?p_' + campo + r'=>' + re.escape(uni(nome)) + r'\s*$', b.group(0), re.M):
                m = b
        if not m:
            sys.exit('não achei a região "' + nome + '"')
        t = m.group(0)
        t = por(t, 'region_name', "p_region_name=>'" + sid + "'") if re.search(r'^,p_region_name=>', t, re.M) else poe(t, campo, ",p_region_name=>'" + sid + "'")
        s = s[:m.start()] + t + s[m.end():]


def id_de(m):
    return re.search(r'p_id=>(wwv_flow_api\.id\(\d+\))', m.group(0)).group(1)


def editar(fn, chave, valor, fx):
    global s
    m = achar(fn, chave, valor)
    novo = fx(m.group(0))
    s = s[:m.start()] + novo + s[m.end():]


def por(t, chave, linha):
    m = re.search(r'^(,?)p_' + chave + r'=>.*$', t, re.M)
    if not m:
        sys.exit('falta p_' + chave)
    return t[:m.start()] + m.group(1) + linha + t[m.end():]


def tira(t, chave):
    m = re.search(r'^,p_' + chave + r'=>.*\n', t, re.M)
    return t[:m.start()] + t[m.end():] if m else t


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]


def com(t, chave, linha, depois_de):
    """troca a linha se ela existe; senão acrescenta depois de outra"""
    return por(t, chave, linha) if re.search(r'^,?p_' + chave + r'=>', t, re.M) else poe(t, depois_de, ',' + linha)


# ---------- ids que variam por ambiente: pelos nomes ----------
dar_ids_estaticos()
ID_ESCOLHA = id_de(achar('create_page_plug', 'region_name', "'ESCOLHA_BENEFICIOS'"))
ID_BOTOES = id_de(achar('create_page_plug', 'region_name', "'BOTOES'"))
TPL = re.search(r'p_plug_template=>(wwv_flow_api\.id\(\d+\))', achar('create_page_plug', 'region_name', "'ESCOLHA_BENEFICIOS'").group(0)).group(1)
ev = None
for m in blocos('create_page_da_event'):
    if "p_name=>'Show Region'" in m.group(0) and "p_triggering_element=>'P168_MATRICULA'" in m.group(0):
        ev = m
if not ev:
    sys.exit('não achei a ação dinâmica "Show Region" de P168_MATRICULA')
ID_EV = id_de(ev)
# ids NOVOS: altos e fixos — o APEX soma o deslocamento do ambiente na importação
NOVO = lambda n: 'wwv_flow_api.id(2829991680000000000%02d)' % n
ID_SALDO, ID_PACOTE = NOVO(1), NOVO(2)

# ---------- regiões novas, antes da Escolha (o pai antes dos filhos) ----------
novas = f"""wwv_flow_api.create_page_plug(
 p_id=>{ID_SALDO}
,p_plug_name=>{uni('Seu valor para benefícios')}
,p_region_name=>'SALDO_BENEFICIOS'
,p_region_css_classes=>'nc-ben-medidor'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>{TPL}
,p_plug_display_sequence=>55
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NULL'
,p_plug_display_when_condition=>'P168_ROWID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>{uni('Medidor do saldo. O Natcorp_Beneficios.js desenha a barra a partir de P168_TOTAL e P168_SALDO (os dois itens desta região ficam fora da vista, mas continuam sendo a fonte) e das linhas de "Seu novo pacote". Mostrada/escondida pela ação "Show Region", com as outras.')}
);
wwv_flow_api.create_page_plug(
 p_id=>{ID_PACOTE}
,p_plug_name=>'Pacote'
,p_region_name=>'PACOTE_BENEFICIOS'
,p_region_css_classes=>'nc-ben-coluna-pacote'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>{TPL}
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>{uni('Coluna da direita, sem moldura: agrupa "Seu novo pacote", "Benefícios Requisitados" e "O que você tem hoje", um embaixo do outro, ao lado de "Adicionar um benefício" (5 colunas). Sem coluna fixa: quando "Adicionar um benefício" não aparece (requisição já criada), ela ocupa a linha toda.')}
);
"""
m = achar('create_page_plug', 'region_name', "'ESCOLHA_BENEFICIOS'")
s = s[:m.start()] + novas + s[m.start():]

# ---------- regiões existentes ----------
def f(t):
    t = por(t, 'plug_name', 'p_plug_name=>' + uni('Adicionar um benefício'))
    t = com(t, 'region_css_classes', "p_region_css_classes=>'nc-ben-escolha'", 'region_name')
    t = por(t, 'plug_display_sequence', 'p_plug_display_sequence=>60')
    t = tira(t, 'plug_new_grid_row')
    t = com(t, 'plug_grid_column_span', 'p_plug_grid_column_span=>5', 'plug_display_sequence')
    return t
editar('create_page_plug', 'region_name', "'ESCOLHA_BENEFICIOS'", f)

def filho(nome, cls, seq, titulo=None):
    def f(t):
        if titulo:
            t = por(t, 'name', 'p_name=>' + uni(titulo))
        if cls:
            t = com(t, 'region_css_classes', "p_region_css_classes=>'" + cls + "'", 'region_name')
        t = com(t, 'parent_plug_id', 'p_parent_plug_id=>' + ID_PACOTE, 'region_name')
        t = por(t, 'display_sequence', 'p_display_sequence=>%d' % seq)
        t = tira(tira(tira(t, 'new_grid_row'), 'new_grid_column'), 'grid_column_span')
        return t
    editar('create_report_region', 'region_name', "'" + nome + "'", f)
filho('BENEFICIOS_ESCOLHIDOS', 'nc-ben-pacote', 10, 'Seu novo pacote')
filho('BENEFICIOS_REQUISITADOS', None, 20)
filho('BENEFICIOS_ATUAIS', 'nc-ben-hoje', 30, 'O que você tem hoje')

editar('create_page_plug', 'region_name', "'BOTOES'", lambda t: por(com(t, 'region_css_classes', "p_region_css_classes=>'nc-ben-acoes'", 'region_name'), 'plug_display_sequence', 'p_plug_display_sequence=>990'))
editar('create_page_plug', 'region_name', "'COLABORADOR'", lambda t: com(t, 'region_css_classes', "p_region_css_classes=>'nc-ben-perfil-regiao'", 'region_name'))

# ---------- itens ----------
def item(nome, fx):
    editar('create_page_item', 'name', "'" + nome + "'", fx)
classe = lambda c: (lambda t: com(t, 'item_css_classes', "p_item_css_classes=>'" + c + "'", 'prompt'))
item('P168_TOTAL', lambda t: por(por(t, 'item_plug_id', 'p_item_plug_id=>' + ID_SALDO), 'item_sequence', 'p_item_sequence=>10'))
item('P168_SALDO', lambda t: por(por(t, 'item_plug_id', 'p_item_plug_id=>' + ID_SALDO), 'item_sequence', 'p_item_sequence=>20'))
item('P168_OPCAO', lambda t: classe('nc-ben-segmento')(por(t, 'prompt', 'p_prompt=>' + uni('Que tipo de benefício?'))))
item('P168_BENEFICIO', lambda t: classe('nc-ben-chips')(por(t, 'prompt', "p_prompt=>'Grupo'")))
item('P168_TIPO_BENEFICIO', lambda t: classe('nc-ben-cartoes')(tira(tira(por(t, 'prompt', 'p_prompt=>' + uni('Escolha o benefício')), 'begin_on_new_line'), 'begin_on_new_field')))
item('P168_VALOR', lambda t: classe('nc-ben-valor')(por(por(t, 'prompt', 'p_prompt=>' + uni('Quanto você quer neste benefício?')), 'item_sequence', 'p_item_sequence=>85')))
item('P168_VALOR_MIN', lambda t: com(por(t, 'prompt', 'p_prompt=>' + uni('Valor mínimo')), 'colspan', 'p_colspan=>3', 'item_sequence'))
item('P168_VALOR_MAX', lambda t: com(por(t, 'prompt', 'p_prompt=>' + uni('A empresa paga até')), 'colspan', 'p_colspan=>3', 'item_sequence'))
item('P168_QUANTIDADE', lambda t: com(t, 'colspan', 'p_colspan=>3', 'item_sequence'))
item('P168_TOT_MULTIPLO', lambda t: com(t, 'colspan', 'p_colspan=>3', 'item_sequence'))

# ---------- botões ----------
editar('create_page_button', 'button_name', "'CREATE'", lambda t: por(t, 'button_image_alt', "p_button_image_alt=>'Enviar pedido'"))
editar('create_page_button', 'button_name', "'ADICIONAR'", lambda t: por(t, 'button_image_alt', "p_button_image_alt=>'Adicionar ao pacote'"))

# ---------- "Show Region": as regiões novas e a de botões junto com as outras ----------
acoes = [m for m in blocos('create_page_da_action') if 'p_event_id=>' + ID_EV in m.group(0)]
if not acoes:
    sys.exit('a ação "Show Region" não tem ações')
seq0 = max(int(re.search(r'p_action_sequence=>(\d+)', m.group(0)).group(1)) for m in acoes) + 10
novas, n = '', 11
# 04/10 (cliente: "Benefícios precisa ter o botão Voltar"): a região Botões NÃO entra mais aqui — na
# página original ela nunca some, e escondê-la sem colaborador levava o Voltar junto.
for k, rid in enumerate([ID_SALDO, ID_PACOTE]):
    for resultado, acao, seq in (('FALSE', 'NATIVE_HIDE', seq0 + k * 10), ('TRUE', 'NATIVE_SHOW', seq0 + 30 + k * 10)):
        novas += f"""wwv_flow_api.create_page_da_action(
 p_id=>{NOVO(n)}
,p_event_id=>{ID_EV}
,p_event_result=>'{resultado}'
,p_action_sequence=>{seq}
,p_execute_on_page_init=>'Y'
,p_action=>'{acao}'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>{rid}
,p_attribute_01=>'N'
);
"""
        n += 1
ultima = acoes[-1]
s = s[:ultima.end()] + novas + s[ultima.end():]

# ---------- arquivos e comentário da página ----------
def pagina(t):
    t = com(t, 'javascript_file_urls', "p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Beneficios.js'", 'autocomplete_on_off')
    t = com(t, 'css_file_urls', "p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Beneficios.css'", 'javascript_file_urls')
    linhas = [
        'DESENHO DA TELA (Natcorp_Beneficios.css / Natcorp_Beneficios.js, em Arquivos desta página)',
        '',
        'A estrutura é toda do APEX: ordem, colunas, títulos, rótulos e botões estão aqui no Page Designer',
        'e aparecem na tela do mesmo jeito. O CSS/JS só muda o DESENHO de quem tem uma destas classes:',
        '',
        'Regiões (Aparência > Classes CSS):',
        '  nc-ben-perfil-regiao  Colaborador Solicitado: cartão com iniciais/foto, nome e datas (lê Colab Info).',
        '  nc-ben-medidor        Seu valor para benefícios: a barra do saldo (lê P168_TOTAL, P168_SALDO e o pacote).',
        '  nc-ben-escolha        Adicionar um benefício.',
        '  nc-ben-pacote         Seu novo pacote: cada linha vira um cartão. Colunas BENEFICIO, TIPO_BENEFICIO, VALOR_TOTAL, REMOVER.',
        '  nc-ben-hoje           O que você tem hoje: o mesmo cartão, mais discreto.',
        '  nc-ben-acoes          Botões: presa ao pé da tela, com o resumo do pacote.',
        '',
        'Itens (Avançado > Classes CSS; vai para o contêiner do item) - a lista continua sendo o item de verdade:',
        '  nc-ben-segmento   P168_OPCAO: dois botões.',
        '  nc-ben-chips      P168_BENEFICIO: botões pequenos; com UMA opção, ela é escolhida sozinha.',
        '  nc-ben-cartoes    P168_TIPO_BENEFICIO: cartões ilustrados.',
        '  nc-ben-valor      P168_VALOR: campo grande com - / + e régua; avisa quando o mínimo passa do saldo.',
        '',
        'A ação "Show Region" (P168_MATRICULA) mostra/esconde também "Seu valor para benefícios" e "Pacote" (os Botões, com o Voltar, ficam sempre).',
        'Para mudar a tela: mude aqui. Para tirar o desenho: tire a classe. Para desligar tudo: tire as duas URLs de',
        'arquivo desta página. Não renomeie os itens P168_* nem as colunas acima sem ajustar o Natcorp_Beneficios.js.',
        'Fontes e guia: brand/apex/app/Natcorp_Beneficios.src.js / .src.css e BENEFICIOS-MANUTENCAO.md.',
    ]
    bloco = 'p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in linhas) + '))'
    if re.search(r'^,p_page_comment=>', t, re.M):
        return t  # já tem comentário: não sobrescreve o do time
    return poe(t, 'help_text', ',' + bloco)
m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + pagina(m.group(0)) + s[m.end():]

# ---------- conferência ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1))
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok →', SAIDA)
