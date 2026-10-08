"""Aplica o desenho da Alteração Funcional (movimentação, transferência, promoção) numa
EXPORTAÇÃO da página 116 do app 200.

    python3 aplicar-movimentacao-pagina116.py f200_page_116.sql [saida.sql]

Funciona com a exportação de QUALQUER ambiente: acha tudo pelos NOMES (ID estático das
regiões, nome das regiões, dos itens e dos botões), nunca pelos números — cada release
instala o app com IDs internos novos, e uma exportação de página só entra no mesmo app de
onde saiu (ORA-02291 WWV_FLOW_STEP_UI_FK). Exporte do ambiente onde vai importar.

O que muda (tudo visível no Page Designer):
  · "Opções" (as caixas P116_BLK_*) sai de dentro de "Colaborador Solicitado" e vira a região
    "O que você quer fazer?" logo abaixo dele: o desenho põe as intenções (Promoção,
    Transferência…) por cima das caixas, que continuam sendo a verdade;
  · cada bloco de "Alterações" (Empresa, Cargo, Salário…) ganha as classes do cartão
    "Hoje → Como fica" — qualquer filho de "Alterações" com um "…Atual" e um "…Proposta";
  · Benefícios: as classes do desenho da página 168 (Natcorp_Beneficios) e a região nova
    "Valor para benefícios" (SALDO_BENEFICIOS) com P116_TOTAL e P116_SALDO;
  · região nova "Resumo da movimentação" (RESUMO_MOVIMENTACAO), antes do Parecer;
  · região de botões no fim da página (sai da barra do topo); "Criar" → "Enviar movimentação";
  · "Valor do Benefício" → "Remuneração variável";
  · as URLs dos arquivos e o comentário da página.
Nada muda nas validações, processos, ações dinâmicas nem nas listas de valores.
Roda de novo sobre um arquivo já alterado: não altera duas vezes (para no primeiro sinal).
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f200_page_116.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
# já aplicado: só o arranjo dos benefícios (que veio depois) é conferido e posto
JA = "p_region_name=>'RESUMO_MOVIMENTACAO'" in s
if not re.search(r'wwv_flow_api\.create_page\(\n p_id=>116\n', s):
    sys.exit('este arquivo não é a página 116')


def uni(t):
    """texto → literal do APEX (unistr com \\00E1 para os acentos)"""
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def texto(lit):
    """literal do APEX → texto ('Empresa' ou unistr('Sal\\00E1rio'))"""
    lit = lit.strip()
    m = re.match(r"^unistr\('(.*)'\)$", lit) or re.match(r"^'(.*)'$", lit)
    if not m:
        return lit
    t = m.group(1).replace("''", "'")
    return re.sub(r'\\([0-9A-F]{4})', lambda x: chr(int(x.group(1), 16)), t) if lit.startswith('unistr') else t


def blocos(fn):
    return list(re.finditer(r'wwv_flow_api\.' + fn + r'\(\n.*?\n\);\n', s, re.S))


def attr(t, k):
    m = re.search(r'^,?p_' + k + r'=>(.*)$', t, re.M)
    return m.group(1) if m else ''


def id_de(t):
    return re.search(r'p_id=>(wwv_flow_api\.id\(\d+\))', t).group(1)


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
    return por(t, chave, linha) if re.search(r'^,?p_' + chave + r'=>', t, re.M) else poe(t, depois_de, ',' + linha)


def mais_classe(t, chave, cls, depois_de):
    m = re.search(r"^,p_" + chave + r"=>'([^']*)'\s*$", t, re.M)
    if m:
        atuais = m.group(1).split()
        return t if cls in atuais else por(t, chave, "p_" + chave + "=>'" + ' '.join(atuais + [cls]) + "'")
    return poe(t, depois_de, ",p_" + chave + "=>'" + cls + "'")


# ---------- itens e botões: como achar ----------
def item(nome, fx):
    global s
    for m in blocos('create_page_item'):
        if re.search(r"^,p_name=>'" + nome + r"'\s*$", m.group(0), re.M):
            s = s[:m.start()] + fx(m.group(0)) + s[m.end():]
            return
    sys.exit('não achei o item ' + nome)


def botao(nome, fx):
    global s
    for m in blocos('create_page_button'):
        if re.search(r"^,p_button_name=>'" + nome + r"'\s*$", m.group(0), re.M):
            s = s[:m.start()] + fx(m.group(0)) + s[m.end():]
            return
    sys.exit('não achei o botão ' + nome)



# ---------- "Adicionar um benefício": o arranjo da Requisição de Benefícios (200:168) ----------
# Na exportação, "Quanto neste benefício?" divide a linha com Quantidade e Total (4/4/4) e fica
# esmagado. Como na 168: o valor numa linha só dele, antes de mínimo/máximo; embaixo, numa linha
# de quatro campos pequenos, Valor mínimo, A empresa paga até, Quantidade e Total; "Escolha o
# benefício" numa linha própria; o botão "Adicionar ao pacote". Só ordem, colunas e rótulos.
def arranjo_beneficios():
    global s
    pronto = [False]
    def marca(t):
        if re.search(r'^,p_item_sequence=>2715\s*$', t, re.M):
            pronto[0] = True
        return t
    item('P116_VALOR', marca)
    if pronto[0]:
        return False
    item('P116_VALOR', lambda t: por(t, 'item_sequence', 'p_item_sequence=>2715'))
    item('P116_VALOR_MIN', lambda t: com(por(t, 'prompt', 'p_prompt=>' + uni('Valor mínimo')), 'colspan', 'p_colspan=>3', 'item_sequence'))
    item('P116_VALOR_MAX', lambda t: com(por(t, 'prompt', 'p_prompt=>' + uni('A empresa paga até')), 'colspan', 'p_colspan=>3', 'item_sequence'))
    item('P116_QUANTIDADE', lambda t: com(t, 'colspan', 'p_colspan=>3', 'item_sequence'))
    item('P116_TOT_MULTIPLO', lambda t: com(t, 'colspan', 'p_colspan=>3', 'item_sequence'))
    item('P116_TIPO_BENEFICIO', lambda t: tira(tira(t, 'begin_on_new_line'), 'begin_on_new_field'))
    botao('ADICIONAR', lambda t: por(t, 'button_image_alt', "p_button_image_alt=>'Adicionar ao pacote'"))
    return True


# o rótulo do % do salário ("% Aumento Rem." → "% Aumento Salário"), que veio depois
def rotulo_perc_salario():
    global s
    feito = [False]
    def fx(t):
        if re.search(r"^,p_prompt=>'% Aumento Rem\.'\s*$", t, re.M):
            feito[0] = True
            return por(t, 'prompt', 'p_prompt=>' + uni('% Aumento Salário'))
        return t
    item('P116_PERC_SALARIO', fx)
    return feito[0]


if JA:
    feitos = [nome for nome, fx in (('o arranjo dos benefícios', arranjo_beneficios), ('o rótulo "% Aumento Salário"', rotulo_perc_salario)) if fx()]
    if not feitos:
        sys.exit('este arquivo já tem o desenho aplicado (com tudo o que veio depois)')
    open(SAIDA, 'w', encoding='utf-8').write(s)
    print('ok → ' + SAIDA + ' · só ' + ' e '.join(feitos) + ' (o resto já estava aplicado)')
    sys.exit(0)


# ---------- as regiões: nome, pai, id ----------
TIPOS = ('create_page_plug', 'create_report_region')   # região comum e relatório clássico


def todas():
    return [m for fn in TIPOS for m in blocos(fn)]


def nome_de(t):
    return texto(attr(t, 'plug_name') or attr(t, 'name'))


def regioes():
    out = []
    for m in todas():
        t = m.group(0)
        pai = re.search(r'^,p_parent_plug_id=>(wwv_flow_api\.id\(\d+\))', t, re.M)
        out.append({'id': id_de(t), 'nome': nome_de(t), 'sid': texto(attr(t, 'region_name')), 'pai': pai.group(1) if pai else None})
    return out


def bloco_de(rid):
    return [m.group(0) for m in todas() if id_de(m.group(0)) == rid][0]


def seq_de(rid):
    t = bloco_de(rid)
    return int(attr(t, 'plug_display_sequence') or attr(t, 'display_sequence'))


def uma(nome, pai=None):
    achadas = [r for r in regioes() if r['nome'] == nome and (pai is None or r['pai'] == pai)]
    if len(achadas) != 1:
        sys.exit('esperava uma região "%s", achei %d' % (nome, len(achadas)))
    return achadas[0]


def editar_regiao(rid, fx):
    global s
    for m in todas():
        if id_de(m.group(0)) == rid:
            s = s[:m.start()] + fx(m.group(0)) + s[m.end():]
            return
    sys.exit('região sumiu: ' + rid)


def ancora(t):
    return 'plug_name' if re.search(r'^,p_plug_name=>', t, re.M) else 'name'


def classe(cls):
    return lambda t: mais_classe(t, 'region_css_classes', cls, ancora(t))


def estatico(sid):
    return lambda t: t if re.search(r'^,p_region_name=>', t, re.M) else poe(t, ancora(t), ",p_region_name=>'" + sid + "'")


def renomear(novo):
    return lambda t: por(t, ancora(t), 'p_' + ancora(t) + '=>' + uni(novo))


def junta(*fx):
    def f(t):
        for g in fx:
            t = g(t)
        return t
    return f


COLAB = uma('Colaborador Solicitado')
ALT = uma('Alterações')
BOT = uma('Botões')
BEN = uma('Benefícios', ALT['id'])
TPL = re.search(r'p_plug_template=>(wwv_flow_api\.id\(\d+\))', bloco_de(COLAB['id'])).group(1)
NOVO = lambda n: 'wwv_flow_api.id(2829991160000000000%02d)' % n
ID_SALDO, ID_RESUMO = NOVO(1), NOVO(2)

# colaborador: o cartão do desenho de benefícios (nome, matrícula, cargo, situação, tempo de casa)
editar_regiao(COLAB['id'], classe('nc-ben-perfil-regiao'))

# "Opções" sai de dentro do colaborador e vira "O que você quer fazer?"
OPC = uma('Opções', COLAB['id'])
editar_regiao(OPC['id'], junta(
    renomear('O que você quer fazer?'),
    estatico('INTENCOES'), classe('nc-mov-intencoes'),
    lambda t: tira(tira(tira(tira(tira(t, 'parent_plug_id'), 'plug_new_grid_row'), 'plug_new_grid_column'), 'plug_grid_column_span'), 'plug_display_column'),
    lambda t: por(t, 'plug_display_sequence', 'p_plug_display_sequence=>35')))

# "Alterações": sem as abas (o desenho esconde); cada bloco com Atual + Proposta vira cartão
editar_regiao(ALT['id'], classe('nc-mov-alteracoes'))
n_blocos = 0
for b in [r for r in regioes() if r['pai'] == ALT['id']]:
    filhos = [r for r in regioes() if r['pai'] == b['id']]
    hoje = [f for f in filhos if re.search(r'\bAtua(l|is)\b', f['nome'])]
    dep = [f for f in filhos if re.search(r'\bPropost[ao]s?\b', f['nome'])]
    if len(hoje) != 1 or len(dep) != 1:
        continue
    editar_regiao(b['id'], classe('nc-mov-bloco'))
    editar_regiao(hoje[0]['id'], classe('nc-mov-hoje'))
    editar_regiao(dep[0]['id'], classe('nc-mov-depois'))
    n_blocos += 1
if n_blocos < 10:
    sys.exit('achei só %d blocos Atual/Proposta em "Alterações"' % n_blocos)
editar_regiao(uma('Salário', ALT['id'])['id'], classe('nc-mov-salario'))

# (as sequências antes de renomear)
seq_atuais = seq_de(uma('Benefícios Atuais', BEN['id'])['id'])
seq_parecer = seq_de(uma('Parecer', ALT['id'])['id'])
# benefícios: o contrato do Natcorp_Beneficios (o mesmo da página 168)
for nome, cls, novo in (('Benefícios Atuais', 'nc-ben-hoje', 'O que ele tem hoje'),
                        ('Escolha os Benefícios', 'nc-ben-escolha', 'Adicionar um benefício'),
                        ('Benefícios Escolhidos', 'nc-ben-pacote', 'Novo pacote')):
    editar_regiao(uma(nome, BEN['id'])['id'], junta(classe(cls), renomear(novo)))

# botões: saem da barra do topo (REGION_POSITION_01) e vão para o fim do conteúdo
editar_regiao(BOT['id'], junta(classe('nc-mov-acoes'), estatico('BOTOES'),
    lambda t: por(por(t, 'plug_display_point', "p_plug_display_point=>'BODY'"), 'plug_display_sequence', 'p_plug_display_sequence=>990')))

# ---------- regiões novas ----------
def regiao_nova(rid, nome, sid, pai, cls, seq, opcoes, comentario):
    return f"""wwv_flow_api.create_page_plug(
 p_id=>{rid}
,p_plug_name=>{uni(nome)}
,p_region_name=>'{sid}'
,p_parent_plug_id=>{pai}
,p_region_css_classes=>'{cls}'
,p_region_template_options=>'{opcoes}'
,p_plug_template=>{TPL}
,p_plug_display_sequence=>{seq}
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>{uni(comentario)}
);
"""


novas = regiao_nova(ID_SALDO, 'Valor para benefícios', 'SALDO_BENEFICIOS', BEN['id'], 'nc-ben-medidor', seq_atuais - 5,
                    '#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove',
                    'Barra do valor para benefícios: o Natcorp_Beneficios.js desenha a partir de P116_TOTAL e P116_SALDO (os dois itens desta região ficam fora da vista, mas continuam sendo a fonte) e das linhas do "Novo pacote".')
novas += regiao_nova(ID_RESUMO, 'Resumo da movimentação', 'RESUMO_MOVIMENTACAO', ALT['id'], 'nc-mov-resumo', seq_parecer - 5,
                     '#DEFAULT#:t-Region--scrollBody',
                     'Vazia de propósito: o Natcorp_Movimentacao.js escreve aqui cada mudança dos blocos abertos (Hoje → Como fica) e o que falta preencher (datas e motivos). Se o JS não carregar, o CSS a esconde.')
m = [m for m in todas() if id_de(m.group(0)) == BOT['id']][0]
s = s[:m.start()] + novas + s[m.start():]

# ---------- itens ----------
item_classe = lambda cls: (lambda t: mais_classe(t, 'item_css_classes', cls, 'prompt' if re.search(r'^,p_prompt=>', t, re.M) else 'name'))
rotulo = lambda r: (lambda t: por(t, 'prompt', 'p_prompt=>' + uni(r)))
for nome in ('P116_SALARIO', 'P116_REMUNERACAO_VARIAVEL', 'P116_TOTAL_REMUNERACAO'):
    item(nome, item_classe('nc-mov-moeda'))
item('P116_REMUNERACAO_VARIAVEL', rotulo('Remuneração variável'))
item('P116_REMUNERACAO_VARIAVEL_PROP', rotulo('Remuneração variável'))
item('P116_PERC_REMUNERACAO_VAR_PROP', rotulo('% Aumento RV'))
item('P116_PERC_SALARIO', rotulo('% Aumento Salário'))
item('P116_TOTAL', lambda t: por(por(t, 'item_plug_id', 'p_item_plug_id=>' + ID_SALDO), 'item_sequence', 'p_item_sequence=>10'))
item('P116_SALDO', lambda t: por(por(t, 'item_plug_id', 'p_item_plug_id=>' + ID_SALDO), 'item_sequence', 'p_item_sequence=>20'))
item('P116_OPCAO', junta(item_classe('nc-ben-segmento'), rotulo('Que tipo de benefício?')))
item('P116_BENEFICIO', junta(item_classe('nc-ben-chips'), rotulo('Grupo')))
item('P116_TIPO_BENEFICIO', junta(item_classe('nc-ben-cartoes'), rotulo('Escolha o benefício')))
item('P116_VALOR', junta(item_classe('nc-ben-valor'), rotulo('Quanto neste benefício?')))
arranjo_beneficios()


# ---------- botões ----------
botao('CREATE', lambda t: por(t, 'button_image_alt', "p_button_image_alt=>" + uni('Enviar movimentação')))


# ---------- arquivos e comentário da página ----------
def pagina(t):
    js = "wwv_flow_string.join(wwv_flow_t_varchar2(\n'#WORKSPACE_IMAGES#Natcorp_Beneficios.js',\n'#WORKSPACE_IMAGES#Natcorp_Movimentacao.js'))"
    css = "wwv_flow_string.join(wwv_flow_t_varchar2(\n'#WORKSPACE_IMAGES#Natcorp_Beneficios.css',\n'#WORKSPACE_IMAGES#Natcorp_Movimentacao.css'))"
    if re.search(r'^,p_(javascript|css)_file_urls=>', t, re.M):
        sys.exit('a página já tem URLs de arquivo: junte à mão')
    t = poe(t, 'autocomplete_on_off', ',p_javascript_file_urls=>' + js)
    t = poe(t, 'autocomplete_on_off', ',p_css_file_urls=>' + css)
    linhas = [
        'DESENHO DA TELA (Natcorp_Movimentacao.css/.js e Natcorp_Beneficios.css/.js, em Arquivos desta página)',
        '',
        'A estrutura é toda do APEX: ordem, colunas, títulos, rótulos e botões estão aqui no Page Designer',
        'e aparecem na tela do mesmo jeito. O CSS/JS só muda o DESENHO de quem tem uma destas classes:',
        '',
        'Regiões (Aparência > Classes CSS):',
        '  nc-ben-perfil-regiao  Colaborador Solicitado: cartão com iniciais/foto, nome, cargo, situação, tempo de casa.',
        '  nc-mov-intencoes      O que você quer fazer?: cartões (Promoção, Transferência...) que MARCAM as caixas P116_BLK_*;',
        '                        as caixas continuam sendo a verdade e aparecem em "Outra alteração".',
        '  nc-mov-alteracoes     Alterações: só tira da vista as abas repetidas.',
        '  nc-mov-bloco          cada bloco (Empresa, Cargo, Salário...): cartão com o nome e a mudança.',
        '  nc-mov-hoje           a região "...Atual" do bloco: coluna "Hoje", só leitura.',
        '  nc-mov-depois         a região "...Proposta" do bloco: coluna "Como fica".',
        '  nc-mov-salario        Salário: os valores em reais e a diferença (%).',
        '  nc-mov-resumo         Resumo da movimentação (vazia no APEX; o JS escreve).',
        '  nc-mov-acoes          Botões: no fim da página, dizendo o que falta.',
        '  nc-ben-medidor / nc-ben-hoje / nc-ben-escolha / nc-ben-pacote   os benefícios, como na página 168.',
        '',
        'Itens (Avançado > Classes CSS; vai para o contêiner do item):',
        '  nc-mov-moeda   valor de leitura mostrado em reais (P116_SALARIO, P116_REMUNERACAO_VARIAVEL, P116_TOTAL_REMUNERACAO).',
        '  nc-ben-segmento / nc-ben-chips / nc-ben-cartoes / nc-ben-valor   P116_OPCAO, P116_BENEFICIO, P116_TIPO_BENEFICIO, P116_VALOR.',
        '',
        'Para mudar a tela: mude aqui. Para tirar o desenho: tire a classe. Para desligar tudo: tire as URLs de',
        'arquivo desta página. Um bloco novo em "Alterações" com um "...Atual" e um "...Proposta": ponha nele as',
        'classes nc-mov-bloco / nc-mov-hoje / nc-mov-depois. Fontes e guia: brand/apex/app/MOVIMENTACAO-MANUTENCAO.md.',
    ]
    bloco = 'p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in linhas) + '))'
    if re.search(r'^,p_page_comment=>', t, re.M):
        return t
    return poe(t, 'help_text', ',' + bloco)


m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + pagina(m.group(0)) + s[m.end():]

# ---------- conferência ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1))
ids = re.findall(r'^ p_id=>(wwv_flow_api\.id\(\d+\))', s, re.M)
if len(ids) != len(set(ids)):
    sys.exit('id repetido')
fora = [l for l in s.split('\n') if re.match(r"^,?p_[a-z0-9_]+=>'", l) and any(ord(c) > 127 for c in l)]
if fora:
    sys.exit('texto com acento sem unistr: ' + fora[0][:80])
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok →', SAIDA, '·', n_blocos, 'blocos')
