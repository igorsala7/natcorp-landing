"""Aplica os desenhos do portal "Conhecendo Você" numa EXPORTAÇÃO DA APLICAÇÃO 600 inteira
(Cadastro de Currículo - Natcorp): as páginas que já têm desenho recebem as URLs do .js/.css
delas e um comentário de página.

    python3 aplicar-app600.py f600.sql [saida.sql]

  página  arquivo                 reconhecida por (os mesmos itens que o .js procura)
  1       Natcorp_DadosPessoais   _NOME_MAE, _NUM_CPF_DISPLAY, _TIPO_MIDIA
  5       Natcorp_Formacao        _FORMACAO_ESCOLAR_OBS, _CURSO_OBS, _IDIOMA_OBS
  14      Natcorp_Carta           _DESC_QUALIFIC_FUNC
  17      Natcorp_Empregos        região com id estático EMPREGOS_ANTERIORES
  35      Natcorp_Funcional       _SITUACAO_DSP, _SALARIO_DSP, _JORNADA_DSP
  131     Natcorp_Dependentes     lista com links …_NUM_DEPEND e sem _EXCLUIR_DEPENDENTE
  133     Natcorp_Dependentes     _NUM_DEPEND e _EXCLUIR_DEPENDENTE
  168     Natcorp_Beneficios      _COD_CANDIDATO, _TIPO_BENEFICIO, _SALDO (a escolha de benefícios do
                                  candidato — a mesma tela da Requisição de Benefícios do app 200)

O número da página serve só para ACHAR o bloco no arquivo; quem confirma que é a página certa
são os itens (se não baterem, o script para sem gravar nada). Por página muda — tudo visível no
Page Designer; nenhuma validação, processo, ação dinâmica, botão, item ou relatório é tocado:
  · a URL do Natcorp_X.js no FIM da lista de JavaScript que a página já tem (ou uma lista nova);
  · a URL do Natcorp_X.css (junto das que a página já tiver);
  · o comentário da página (o que o desenho faz e como desligar), se ela ainda não tiver um.
Página que já carrega o Natcorp_X fica como está: rodar de novo não altera duas vezes.
A p132 do app 600 (dependentes do CANDIDATO, sem _EXCLUIR_DEPENDENTE) não tem desenho e não entra.

A 168 recebe também o CONTRATO do desenho da Requisição de Benefícios (o mesmo que o
aplicar-beneficios-pagina168.py põe no app 200), por nomes, nunca por IDs:
  · região nova "Seu valor para benefícios" (SALDO_BENEFICIOS, nc-ben-medidor) com P168_TOTAL e
    P168_SALDO; "Escolha os Benefícios" → "Adicionar um benefício" (nc-ben-escolha);
    "Benefícios Escolhidos" → "Seu pacote" (nc-ben-pacote); os requisitados → nc-ben-requisitados;
    "Botões 2" (Confirmar Solicitação) → nc-ben-acoes;
  · P168_OPCAO / P168_BENEFICIO / P168_TIPO_BENEFICIO de Popup LOV para LISTA DE SELEÇÃO (o mesmo
    SQL e a mesma cascata; é como elas já são no app 200 — sem as opções na página não há como
    desenhar botões e cartões) e com o modelo "Optional - Above" (o rótulo flutuante ficava por cima
    do desenho); as classes nc-ben-segmento / nc-ben-chips / nc-ben-cartoes / nc-ben-valor;
  · rótulos em linguagem simples; "Confirmar Solicitação" → "Enviar pedido", "Adicionar" →
    "Adicionar ao pacote".
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f600.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if not re.search(r"p_default_application_id=>600\b", s):
    sys.exit('este arquivo não é a exportação da aplicação 600')


def itens(*nomes):
    return lambda n, b: all(re.search(r"p_name=>'P%d%s'" % (n, x), b) for x in nomes)


PAGINAS = [
    (1, 'Natcorp_DadosPessoais', itens('_NOME_MAE', '_NUM_CPF_DISPLAY', '_TIPO_MIDIA'), 'DADOSPESSOAIS', [
        'Dados Pessoais do candidato/colaborador: 7 capítulos no lugar dos 17 blocos, o resumo do',
        'cadastro (P0_PERCENTUAL), "Continuar", selo por documento, "Enviar foto" e "Salvando…/Salvo".',
        'Os capítulos são montados NO LUGAR (classes e cabeçalhos): nada sai das regiões que o',
        '"Libera Campos" libera. Aberta pelo RH (embutida), vira "Cadastro de Fulano".']),
    (5, 'Natcorp_Formacao', itens('_FORMACAO_ESCOLAR_OBS', '_CURSO_OBS', '_IDIOMA_OBS'), 'FORMACAO', [
        'Cursos e Formações: as quatro listas (Instrução, Cursos, Idiomas, Habilidades) em cartões,',
        '"Adicionar" no fim de cada lista e "Mais informações" recolhido.']),
    (14, 'Natcorp_Carta', itens('_DESC_QUALIFIC_FUNC'), 'CARTA', [
        'Carta de Apresentação: começos de frase que escrevem na caixa, um exemplo recolhido, a dica',
        'do microfone do teclado e o contador. "Prosseguir" aparece como "Continuar".']),
    (17, 'Natcorp_Empregos', lambda n, b: "p_region_name=>'EMPREGOS_ANTERIORES'" in b, 'EMPREGOS', [
        'Empregos Anteriores: linha do tempo (mais recente em cima), com a duração de cada emprego,',
        '"Emprego atual" e o total no alto. Reconhecida pela região EMPREGOS_ANTERIORES.']),
    (35, 'Natcorp_Funcional', itens('_SITUACAO_DSP', '_SALARIO_DSP', '_JORNADA_DSP'), 'FUNCIONAL', [
        'Informações Funcionais (RH): a ficha no alto, as 9 abas legíveis, consulta × edição',
        '(o que só se lê fica sem borda) e as consultas de cada aba junto dela.']),
    (131, 'Natcorp_Dependentes', lambda n, b: '_NUM_DEPEND' in b and not re.search(r"p_name=>'P%d_EXCLUIR_DEPENDENTE'" % n, b), 'DEPENDENTES', [
        'Lista de Dependentes: dois grupos (Esperando o RH / Já cadastrados), idade calculada da',
        'data de nascimento e "Incluir dependente" em cima.']),
    (133, 'Natcorp_Dependentes', itens('_NUM_DEPEND', '_EXCLUIR_DEPENDENTE'), 'DEPENDENTES', [
        'Requisição de Dependentes do colaborador: o formulário por assunto e, para quem aprova,',
        '"N campos alterados", "Ver só o que mudou" e a barra da decisão.']),
    (168, 'Natcorp_Beneficios', itens('_COD_CANDIDATO', '_TIPO_BENEFICIO', '_SALDO'), 'BENEFICIOS', [
        'Escolha de benefícios do candidato: o MESMO desenho da Requisição de Benefícios do app 200.',
        'Regiões com classe: nc-ben-medidor (Seu valor para benefícios, com P168_TOTAL/P168_SALDO),',
        'nc-ben-escolha (Adicionar um benefício), nc-ben-pacote (Seu pacote), nc-ben-requisitados',
        '(o pedido gravado) e nc-ben-acoes (Botões 2). Itens: nc-ben-segmento (P168_OPCAO),',
        'nc-ben-chips (P168_BENEFICIO), nc-ben-cartoes (P168_TIPO_BENEFICIO), nc-ben-valor (P168_VALOR).',
        'As três listas são LISTA DE SELEÇÃO (eram Popup LOV) com o rótulo em cima: o desenho usa as',
        'opções da lista. Pedido gravado: faixa do pedido e o caminho da aprovação (Aprovar/Reprovar',
        'vão para dentro dele).']),
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


def mais_url(t, attr, url):
    """acrescenta a URL no FIM da lista que a página já tem (ou cria a lista)"""
    m = re.search(r"^,p_" + attr + r"=>wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n(.*?)\)\)\n", t, re.M | re.S)
    if m:
        return t[:m.end(1)] + ",\n'" + url + "'" + t[m.end(1):]
    m = re.search(r"^,p_" + attr + r"=>'([^']*)'\n", t, re.M)
    if m:
        return t[:m.start()] + ",p_" + attr + "=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'" + m.group(1) + "',\n'" + url + "'))\n" + t[m.end():]
    return poe(t, 'autocomplete_on_off', ",p_" + attr + "=>'" + url + "'")


def pagina(t, arq, guia, linhas):
    t = mais_url(t, 'javascript_file_urls', '#WORKSPACE_IMAGES#' + arq + '.js')
    t = mais_url(t, 'css_file_urls', '#WORKSPACE_IMAGES#' + arq + '.css')
    if re.search(r'^,p_page_comment=>', t, re.M):
        return t
    txt = ['DESENHO DA TELA (' + arq + '.css / ' + arq + '.js)', ''] + linhas + [
        '', 'A estrutura é toda do APEX; nada é gravado pelo desenho.',
        'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/' + guia + '-MANUTENCAO.md.']
    return poe(t, 'autocomplete_on_off', ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in txt) + '))')



# ---------- 168: o contrato do desenho da Requisição de Benefícios ----------
def blocos(b, fn):
    return list(re.finditer(r'wwv_flow_api\.' + fn + r'\(\n.*?\n\);\n', b, re.S))


def trocar(b, fn, chave, valor, fx):
    for m in blocos(b, fn):
        if re.search(r'^,?p_' + chave + r'=>' + re.escape(valor) + r'\s*$', m.group(0), re.M):
            return b[:m.start()] + fx(m.group(0)) + b[m.end():]
    sys.exit('168: não achei ' + fn + ' com p_' + chave + '=>' + valor)


def por(t, chave, linha):
    m = re.search(r'^(,?)p_' + chave + r'=>.*$', t, re.M)
    if not m:
        sys.exit('168: falta p_' + chave)
    return t[:m.start()] + m.group(1) + linha + t[m.end():]


def tira(t, chave):
    m = re.search(r'^,p_' + chave + r'=>.*\n', t, re.M)
    return t[:m.start()] + t[m.end():] if m else t


def com(t, chave, linha, depois_de):
    return por(t, chave, linha) if re.search(r'^,?p_' + chave + r'=>', t, re.M) else poe(t, depois_de, ',' + linha)


ACIMA = None   # o modelo de campo "Optional - Above" deste app (pelo nome)
mm = re.search(r"wwv_flow_api\.create_field_template\(\n p_id=>(wwv_flow_api\.id\(\d+\))\n,p_template_name=>'Optional - Above'", s)
if mm:
    ACIMA = mm.group(1)


def para_lista(t):
    """Popup LOV → lista de seleção: o mesmo SQL, o mesmo "exibir nulo" e a mesma cascata"""
    if "p_display_as=>'NATIVE_SELECT_LIST'" in t:
        return t
    t = por(t, 'display_as', "p_display_as=>'NATIVE_SELECT_LIST'")
    t = tira(t, 'cSize')
    for k in ('attribute_03', 'attribute_04', 'attribute_05'):
        t = tira(t, k)
    t = por(t, 'attribute_01', "p_attribute_01=>'NONE'")
    t = por(t, 'attribute_02', "p_attribute_02=>'N'")
    t = com(t, 'cHeight', 'p_cHeight=>1', 'ajax_optimize_refresh' if re.search(r'^,p_ajax_optimize_refresh=>', t, re.M) else 'lov_display_null')
    return t


def rotulo_em_cima(t):
    return por(t, 'field_template', 'p_field_template=>' + ACIMA) if ACIMA else t


def estrutura_168(b):
    if "p_region_name=>'SALDO_BENEFICIOS'" in b:
        return b
    esc = [m for m in blocos(b, 'create_page_plug') if re.search(r"^,p_plug_name=>unistr\('Escolha os Benef\\00EDcios'\)\s*$", m.group(0), re.M)]
    if not esc:
        sys.exit('168: não achei a região "Escolha os Benefícios"')
    TPL = re.search(r'p_plug_template=>(wwv_flow_api\.id\(\d+\))', esc[0].group(0)).group(1)
    ID_SALDO = 'wwv_flow_api.id(282999169000000000001)'
    nova = """wwv_flow_api.create_page_plug(
 p_id=>%s
,p_plug_name=>%s
,p_region_name=>'SALDO_BENEFICIOS'
,p_region_css_classes=>'nc-ben-medidor'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>%s
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NULL'
,p_plug_display_when_condition=>'P168_ROWID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>%s
);
""" % (ID_SALDO, uni('Seu valor para benefícios'), TPL,
       uni('Medidor do saldo. O Natcorp_Beneficios.js desenha a barra a partir de P168_TOTAL e P168_SALDO (os dois itens desta região ficam fora da vista, mas continuam sendo a fonte) e das linhas de "Seu pacote". Sem candidato, a barra não aparece.'))
    b = b[:esc[0].start()] + nova + b[esc[0].start():]

    def regiao(nome, fn, campo, cls, titulo=None):
        def f(t):
            if titulo:
                t = por(t, campo, 'p_' + campo + '=>' + uni(titulo))
            return com(t, 'region_css_classes', "p_region_css_classes=>'" + cls + "'", campo)
        return trocar(b, fn, campo, nome, f)
    b = regiao(uni('Escolha os Benefícios'), 'create_page_plug', 'plug_name', 'nc-ben-escolha', 'Adicionar um benefício')
    b = regiao(uni('Benefícios Escolhidos'), 'create_report_region', 'name', 'nc-ben-pacote', 'Seu pacote')
    b = regiao(uni('Benefícios Requisitados - &P168_DT_REQ.'), 'create_report_region', 'name', 'nc-ben-requisitados')
    b = regiao(uni('Botões 2'), 'create_page_plug', 'plug_name', 'nc-ben-acoes')

    classe = lambda c: (lambda t: com(t, 'item_css_classes', "p_item_css_classes=>'" + c + "'", 'prompt'))
    def item(nome, fx):
        return trocar(b, 'create_page_item', 'name', "'" + nome + "'", fx)
    b = item('P168_TOTAL', lambda t: por(por(t, 'item_plug_id', 'p_item_plug_id=>' + ID_SALDO), 'item_sequence', 'p_item_sequence=>10'))
    b = item('P168_SALDO', lambda t: por(por(t, 'item_plug_id', 'p_item_plug_id=>' + ID_SALDO), 'item_sequence', 'p_item_sequence=>20'))
    b = item('P168_OPCAO', lambda t: classe('nc-ben-segmento')(rotulo_em_cima(para_lista(por(t, 'prompt', 'p_prompt=>' + uni('Que tipo de benefício?'))))))
    b = item('P168_BENEFICIO', lambda t: classe('nc-ben-chips')(rotulo_em_cima(para_lista(por(t, 'prompt', "p_prompt=>'Grupo'")))))
    b = item('P168_TIPO_BENEFICIO', lambda t: classe('nc-ben-cartoes')(rotulo_em_cima(para_lista(tira(tira(por(t, 'prompt', 'p_prompt=>' + uni('Escolha o benefício')), 'begin_on_new_line'), 'begin_on_new_field')))))
    b = item('P168_VALOR', lambda t: classe('nc-ben-valor')(rotulo_em_cima(por(t, 'prompt', 'p_prompt=>' + uni('Quanto você quer neste benefício?')))))
    b = item('P168_VALOR_MIN', lambda t: por(t, 'prompt', 'p_prompt=>' + uni('Valor mínimo')))
    b = item('P168_VALOR_MAX', lambda t: por(t, 'prompt', 'p_prompt=>' + uni('A empresa paga até')))

    b = trocar(b, 'create_page_button', 'button_name', "'CREATE'", lambda t: por(t, 'button_image_alt', "p_button_image_alt=>'Enviar pedido'"))
    b = trocar(b, 'create_page_button', 'button_name', "'ADICIONAR'", lambda t: por(t, 'button_image_alt', "p_button_image_alt=>'Adicionar ao pacote'"))
    return b

ESTRUTURA = {168: estrutura_168}
feitas, ja = [], []
for n, arq, confere, guia, linhas in PAGINAS:
    a = s.find('prompt --application/pages/page_%05d\n' % n)
    if a < 0:
        sys.exit('a página %d não está no arquivo' % n)
    b = s.find('prompt --application/pages/page_', a + 10)
    b = len(s) if b < 0 else b
    bloco = s[a:b]
    if not confere(n, bloco):
        sys.exit('a página %d não tem os itens esperados para o %s: nada foi gravado' % (n, arq))
    m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', bloco, re.S)
    if not m:
        sys.exit('não achei o create_page da página %d' % n)
    if arq in m.group(0):
        ja.append(n)
        continue
    bloco = bloco[:m.start()] + pagina(m.group(0), arq, guia, linhas) + bloco[m.end():]
    if n in ESTRUTURA:
        bloco = ESTRUTURA[n](bloco)
    s = s[:a] + bloco + s[b:]
    feitas.append(n)

# ---------- conferência ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
open(SAIDA, 'w', encoding='utf-8').write(s)
print('aplicadas:', feitas or '-', '| já tinham:', ja or '-', '→', SAIDA)
