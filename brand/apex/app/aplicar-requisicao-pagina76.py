"""Aplica o desenho da Requisição de Posição (a mesma "ficha da vaga" da Requisição de Pessoal)
numa EXPORTAÇÃO da página 76 do app 200.

    python3 aplicar-requisicao-pagina76.py f200_page_76.sql [saida.sql]

Acha tudo pelos NOMES (títulos das regiões, nomes dos itens), nunca pelos números: cada base e
cada release instalam o app com IDs internos próprios. Exporte do ambiente onde vai importar.

A página 76 tem as seções soltas dentro de "Informações de Vaga". O script as agrupa em etapas,
como na Requisição de Pessoal (app 2010, p. 52), e o Natcorp_Requisicao.css/.js (o mesmo das
duas páginas) desenha:
  · "Informações de Vaga" (INF_VAGA) vira o hospedeiro das etapas (nc-req-etapas);
  · cinco regiões novas, filhas dela, na ordem da página: Identificação, Cargo, Remuneração,
    Perfil e Detalhamento — as seções passam para dentro delas, na mesma ordem de antes;
  · "&P76_TITULO." passa para a Identificação, com o título "Solicitação";
  · a etapa nova "Prévia do anúncio", a última (vazia: o JS desenha o anúncio);
  · classes nc-req-* nas seções e nos Aprovadores; as URLs dos arquivos e o comentário da página.
Nenhuma validação, processo, ação dinâmica, botão, item ou lista de valores é tocado. Roda de
novo sobre um arquivo já alterado: não altera duas vezes (para no primeiro sinal).
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f200_page_76.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if "p_region_name=>'PREVIA_ETAPA'" in s:
    sys.exit('este arquivo já tem o desenho aplicado (PREVIA_ETAPA existe)')
if not re.search(r'wwv_flow_api\.create_page\(\n p_id=>76\n', s) or 'p_default_application_id=>200' not in s:
    sys.exit('este arquivo não é a página 76 do app 200')

def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def texto(lit):
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


def mais_classe(t, chave, cls, depois_de):
    m = re.search(r"^,p_" + chave + r"=>'([^']*)'\s*$", t, re.M)
    if m:
        atuais = m.group(1).split()
        novas = [c for c in cls.split() if c not in atuais]
        return t if not novas else por(t, chave, "p_" + chave + "=>'" + ' '.join(atuais + novas) + "'")
    return poe(t, depois_de, ",p_" + chave + "=>'" + cls + "'")




# ---------- regiões: comum e relatório; o título sem o subtítulo em HTML ----------
TIPOS = ('create_page_plug', 'create_report_region')


def todas():
    return [m for fn in TIPOS for m in blocos(fn)]


def ancora(t):
    return 'plug_name' if re.search(r'^,p_plug_name=>', t, re.M) else 'name'


def nome_de(t):
    n = texto(attr(t, 'plug_name') or attr(t, 'name'))
    return re.sub(r'<span[^>]*>.*?</span>', '', n).strip()


def regioes():
    out = []
    for m in todas():
        t = m.group(0)
        pai = re.search(r'^,p_parent_plug_id=>(wwv_flow_api\.id\(\d+\))', t, re.M)
        out.append({'id': id_de(t), 'nome': nome_de(t), 'pai': pai.group(1) if pai else None})
    return out


def varias(nome, pai=None):
    return [r for r in regioes() if r['nome'] == nome and (pai is None or r['pai'] == pai)]


def uma(nome, pai=None):
    a = varias(nome, pai)
    if len(a) != 1:
        sys.exit('esperava uma região "%s", achei %d' % (nome, len(a)))
    return a[0]


def bloco_de(rid):
    return [m.group(0) for m in todas() if id_de(m.group(0)) == rid][0]


def editar(rid, *fx):
    global s
    for m in todas():
        if id_de(m.group(0)) == rid:
            t = m.group(0)
            for f in fx:
                t = f(t)
            s = s[:m.start()] + t + s[m.end():]
            return
    sys.exit('região sumiu: ' + rid)


def classe(cls):
    return lambda t: mais_classe(t, 'region_css_classes', cls, ancora(t))


def renomear(novo):
    return lambda t: por(t, ancora(t), 'p_' + ancora(t) + '=>' + uni(novo))


def pai_seq(pai, seq):
    def f(t):
        seqk = 'plug_display_sequence' if re.search(r'^,p_plug_display_sequence=>', t, re.M) else 'display_sequence'
        t = por(t, 'parent_plug_id', 'p_parent_plug_id=>' + pai) if re.search(r'^,p_parent_plug_id=>', t, re.M) else poe(t, ancora(t), ',p_parent_plug_id=>' + pai)
        t = por(t, seqk, 'p_' + seqk + '=>%d' % seq)
        for k in ('plug_new_grid_row', 'plug_new_grid_column', 'plug_grid_column_span', 'plug_display_column', 'new_grid_row', 'new_grid_column', 'grid_column_span'):
            t = tira(t, k)
        return t
    return f


# ---------- o hospedeiro e as etapas ----------
HOST = uma('Informações de Vaga')
editar(HOST['id'], classe('nc-req-etapas'))
TPL = re.search(r'p_plug_template=>(wwv_flow_api\.id\(\d+\))', bloco_de(HOST['id'])).group(1)
OPC_ETAPA = "'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'"
OPC_SECAO = attr(bloco_de(uma('Cargo', HOST['id'])['id']), 'region_template_options')

NOVO = lambda n: 'wwv_flow_api.id(2829990760000000000%02d)' % n
ETAPAS = [
    (NOVO(1), 'Identificação', 'IDENTIFICACAO', ['Informações da Vaga']),
    (NOVO(2), 'Cargo', 'CARGO_ETAPA', ['Cargo', 'Frequência']),
    (NOVO(3), 'Remuneração', 'REMUNERACAO_ETAPA', ['Remuneração', 'Insalubridade / Periculosidade', 'Projeto', 'Contrato', 'Vaga Faturável']),
    (NOVO(4), 'Perfil', 'PERFIL_ETAPA', ['PCD', 'Ferramentas de Apoio / Equipamentos']),
    (NOVO(5), 'Detalhamento', 'DETALHAMENTO_ETAPA', ['Descrição de Atividades', 'Observações / Políticas / Detalhes da Vaga']),
]
ID_PREV, ID_ANUN = NOVO(6), NOVO(7)
existe = set(re.findall(r'wwv_flow_api\.id\((\d+)\)', s))
for rid in [e[0] for e in ETAPAS] + [ID_PREV, ID_ANUN]:
    if re.search(r'\d+', rid).group(0) in existe:
        sys.exit('id novo já existe na página: ' + rid)
SECOES = {}
for e in ETAPAS:
    for t in e[3]:
        SECOES[t] = uma(t, HOST['id'])


def regiao_nova(rid, nome, sid, pai, cls, seq, comentario, opc=None):
    return f"""wwv_flow_api.create_page_plug(
 p_id=>{rid}
,p_plug_name=>{uni(nome)}
,p_region_name=>'{sid}'
,p_parent_plug_id=>{pai}
,p_region_css_classes=>'{cls}'
,p_region_template_options=>{opc or OPC_ETAPA}
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


novas = ''
for k, e in enumerate(ETAPAS):
    novas += regiao_nova(e[0], e[1], e[2], HOST['id'], 'nc-req-etapa', 10 * (k + 1),
                         'Etapa do desenho da ficha da vaga (Natcorp_Requisicao.js): mostra ' + ', '.join(e[3]) + '. O nome no menu das etapas é o título desta região.')
novas += regiao_nova(ID_PREV, 'Prévia do anúncio', 'PREVIA_ETAPA', HOST['id'], 'nc-req-etapa nc-req-etapa-previa', 10 * (len(ETAPAS) + 1),
                     'Última etapa: como a vaga aparece para o candidato. Vazia de propósito: o Natcorp_Requisicao.js desenha o anúncio e a conferência "Antes de publicar". Se o JS não carregar, o CSS a esconde.')
novas += regiao_nova(ID_ANUN, 'Como o candidato vai ver', 'PREVIA_ANUNCIO', ID_PREV, 'nc-req-previa', 10,
                     'O anúncio desenhado pelo Natcorp_Requisicao.js (cargo, empresa, descrição e requisitos).', opc=OPC_SECAO)
m = [m for m in todas() if id_de(m.group(0)) == HOST['id']][0]
s = s[:m.end()] + novas + s[m.end():]

# as seções entram nas etapas, na ordem de antes
for e in ETAPAS:
    for k, t in enumerate(e[3]):
        editar(SECOES[t]['id'], pai_seq(e[0], 10 * (k + 2)))

# "&P76_TITULO." (número, situação, data e solicitante) vira a Solicitação, no alto da Identificação
SOL = uma('&P76_TITULO.')
editar(SOL['id'], pai_seq(ETAPAS[0][0], 10), renomear('Solicitação'), classe('nc-req-ficha nc-req-solicitacao'))

# classes das seções
for t in ('Informações da Vaga', 'Cargo', 'Frequência', 'Remuneração', 'Insalubridade / Periculosidade', 'Projeto', 'Contrato', 'Vaga Faturável', 'PCD'):
    editar(SECOES[t]['id'], classe('nc-req-ficha'))
editar(SECOES['Ferramentas de Apoio / Equipamentos']['id'], classe('nc-req-lista'))
editar(SECOES['Descrição de Atividades']['id'], classe('nc-req-escrita'))
editar(SECOES['Observações / Políticas / Detalhes da Vaga']['id'], classe('nc-req-textos'))
editar(uma('Aprovadores')['id'], classe('nc-req-aprovadores'))


# ---------- arquivos e comentário da página ----------
def pagina(t):
    if 'Natcorp_Requisicao.js' not in t:
        if re.search(r'^,p_javascript_file_urls=>', t, re.M):
            sys.exit('a página já tem outras URLs de JavaScript: junte à mão')
        t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Requisicao.js'")
    if 'Natcorp_Requisicao.css' not in t:
        if re.search(r'^,p_css_file_urls=>', t, re.M):
            sys.exit('a página já tem outras URLs de CSS: junte à mão')
        t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Requisicao.css'")
    linhas = [
        'DESENHO DA TELA (Natcorp_Requisicao.css / Natcorp_Requisicao.js, os mesmos da Requisição de Pessoal)',
        '',
        'A estrutura é toda do APEX. O CSS/JS só muda o DESENHO de quem tem uma destas classes:',
        '  nc-req-etapas       Informações de Vaga: o resumo da vaga no alto, a faixa da aprovação e o menu das etapas.',
        '  nc-req-etapa        cada etapa (Identificação, Cargo, Remuneração, Perfil, Detalhamento, Prévia do anúncio):',
        '                      uma por vez; o nome no menu é o título da região. Seção nova: ponha dentro de uma etapa.',
        '  nc-req-ficha        seção que se lê como documento; "Editar" abre o formulário (que continua na página).',
        '  nc-req-solicitacao  Solicitação (&P76_TITULO.): número, situação, data e solicitante.',
        '  nc-req-aprovadores  Aprovadores: faixa horizontal abaixo do resumo; Aprovar/Reprovar vão para ela.',
        '  nc-req-lista        Ferramentas de Apoio / Equipamentos: as linhas viram etiquetas.',
        '  nc-req-escrita / nc-req-textos   a descrição (com contador) e as observações.',
        '  nc-req-previa       o anúncio (vazia no APEX; o JS desenha).',
        '',
        'Os botões e links são os do APEX (só mudam de lugar na tela). Para desligar tudo: tire as duas',
        'URLs de arquivo. Guia: brand/apex/app/REQUISICAO-MANUTENCAO.md (seção Requisição de Posição).',
    ]
    if re.search(r'^,p_page_comment=>', t, re.M):
        return t
    return poe(t, 'help_text', ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in linhas) + '))')


m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + pagina(m.group(0)) + s[m.end():]

# ---------- conferência ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
ids = re.findall(r'^ p_id=>(wwv_flow_api\.id\(\d+\))', s, re.M)
if len(ids) != len(set(ids)):
    sys.exit('id repetido')
fora = [l for l in s.split('\n') if re.match(r"^,?p_(plug_name|name|prompt|region_css_classes|plug_comment)=>'", l) and any(ord(c) > 127 for c in l)]
if fora:
    sys.exit('texto com acento sem unistr: ' + fora[0][:80])
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok →', SAIDA)
