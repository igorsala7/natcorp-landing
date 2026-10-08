"""Aplica o desenho da Requisição de Pessoal (a "ficha da vaga") numa EXPORTAÇÃO da página 52
do app 2010.

    python3 aplicar-requisicao-pagina52.py f2010_page_52.sql [saida.sql]

Acha tudo pelos NOMES (títulos das regiões, nomes dos itens e botões), nunca pelos números —
cada release instala o app com IDs internos novos, e uma exportação de página só entra no
mesmo app de onde saiu (ORA-02291). Exporte do ambiente onde vai importar.

O que muda (tudo visível no Page Designer; nenhuma validação, processo, ação dinâmica ou
lista de valores é tocada):
  · classes nc-req-* nas etapas, seções, listas, aprovadores e ações (o contrato com o
    Natcorp_Requisicao.css/.js);
  · a etapa "Vaga e Local" deixa de existir: Empresa e Estrutura, Local de Trabalho e
    Publicação de Vaga passam para a Identificação; "Vaga e Local" fica em Condição › Nunca;
  · etapa nova "Candidatos" (só com a requisição gravada: P52_ROWID não nulo), com
    Colaboradores Inscritos e Candidatos Inscritos dentro (saem de Desempenho da Função);
  · etapa nova, a última, "Prévia do anúncio" (vazia: o JS desenha o anúncio);
  · "&P52_TITULO." → "Solicitação" (o resumo no alto já diz número, data e situação);
  · rótulos: "DDD" no primeiro Telefone da indicação; "Observações para o recrutamento";
  · as URLs dos arquivos e o comentário da página.
Roda de novo sobre um arquivo já alterado: não altera duas vezes (para no primeiro sinal).
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2010_page_52.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if "p_region_name=>'PREVIA_ETAPA'" in s:
    sys.exit('este arquivo já tem o desenho aplicado (PREVIA_ETAPA existe)')
if not re.search(r'wwv_flow_api\.create_page\(\n p_id=>52\n', s) or 'p_default_application_id=>2010' not in s:
    sys.exit('este arquivo não é a página 52 do app 2010')


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


# ---------- as etapas ----------
HOST = uma('Steppers')
editar(HOST['id'], classe('nc-req-etapas'))
IDENT = uma('Identificação', HOST['id'])
ETAPAS = [IDENT] + [uma(n, HOST['id']) for n in ('Cargo', 'Remuneração', 'Perfil', 'Detalhamento')]
for e in ETAPAS:
    editar(e['id'], classe('nc-req-etapa'))
TPL = re.search(r'p_plug_template=>(wwv_flow_api\.id\(\d+\))', bloco_de(IDENT['id'])).group(1)
# as etapas novas copiam as opções da Identificação; a região de dentro, as de uma seção dela
OPC_ETAPA = attr(bloco_de(IDENT['id']), 'region_template_options')
OPC_SECAO = attr(bloco_de(uma('Informações da Vaga', IDENT['id'])['id']), 'region_template_options')

# "Vaga e Local" some: as três regiões vão para a Identificação, depois das que já estão lá
VAGA = uma('Vaga e Local', HOST['id'])
filhas = sorted([r for r in regioes() if r['pai'] == VAGA['id']], key=lambda r: int(attr(bloco_de(r['id']), 'plug_display_sequence') or attr(bloco_de(r['id']), 'display_sequence')))
base = max(int(attr(bloco_de(r['id']), 'plug_display_sequence') or 0) for r in regioes() if r['pai'] == IDENT['id'])
for k, r in enumerate(filhas):
    editar(r['id'], pai_seq(IDENT['id'], base + 10 * (k + 1)))
editar(VAGA['id'], lambda t: por(t, 'plug_display_condition_type', "p_plug_display_condition_type=>'NEVER'") if re.search(r'^,p_plug_display_condition_type=>', t, re.M) else poe(t, 'plug_display_point', ",p_plug_display_condition_type=>'NEVER'"),
       lambda t: poe(t, 'plug_name', ",p_plug_comment=>" + uni('Desligada pelo desenho da ficha da vaga: as regiões de dentro foram para a Identificação. Uma ação dinâmica que mostre/esconda esta região (VAGA) não tem mais efeito sobre elas.')) if not re.search(r'^,p_plug_comment=>', t, re.M) else t)

# Identificação: Solicitação, Aprovadores, ações
editar(uma('&P52_TITULO.', IDENT['id'])['id'], renomear('Solicitação'), classe('nc-req-ficha nc-req-solicitacao'))
editar(uma('Aprovadores', IDENT['id'])['id'], classe('nc-req-aprovadores'))
editar(uma('Botões Requisição', IDENT['id'])['id'], classe('nc-req-acoes'))

# seções que se leem como ficha
for nome in ('Informações da Vaga', 'Empresa e Estrutura', 'Local de Trabalho', 'Publicação de Vaga'):
    editar(uma(nome, IDENT['id'])['id'], classe('nc-req-ficha'))
CARGO_E = ETAPAS[1]
for nome in ('Cargo', 'Horário Contratual', 'Controle de Frequência'):
    editar(uma(nome, CARGO_E['id'])['id'], classe('nc-req-ficha'))
REM = ETAPAS[2]
for nome in ('Remuneração', 'Insalubridade / Periculosidade', 'Projeto e Contrato'):
    editar(uma(nome, REM['id'])['id'], classe('nc-req-ficha'))
AVAL = uma('Indicação Para Avaliar Requisição', REM['id'])
editar(AVAL['id'], classe('nc-req-plano'))
for nome in ('Gestor', 'Avaliador'):
    editar(uma(nome, AVAL['id'])['id'], classe('nc-req-ficha'))
PERF = ETAPAS[3]
editar(uma('Características do Candidato', PERF['id'])['id'], classe('nc-req-ficha'))
editar(uma('Indicação de Candidato', PERF['id'])['id'], classe('nc-req-opcional'))
REQT = uma('Requisitos Técnicos', PERF['id'])
DESEMP = uma('Desempenho da Função', PERF['id'])
for g in (REQT, DESEMP):
    editar(g['id'], classe('nc-req-grupo'))
INSCRITOS = [uma(n, DESEMP['id']) for n in ('Colaboradores Inscritos', 'Candidatos Inscritos')]
for r in [r for r in regioes() if r['pai'] in (REQT['id'], DESEMP['id'])]:
    if r['id'] not in [x['id'] for x in INSCRITOS]:
        editar(r['id'], classe('nc-req-lista'))
DET = ETAPAS[4]
editar(uma('Detalhamento da Requisição', DET['id'])['id'], classe('nc-req-escrita'))
editar(uma('Perfil da Vaga', DET['id'])['id'], classe('nc-req-opcional nc-req-textos'))
editar(uma('Parecer', DET['id'])['id'], classe('nc-req-ficha nc-req-textos'))

# ---------- etapas novas ----------
NOVO = lambda n: 'wwv_flow_api.id(2829990520000000000%02d)' % n
ID_CAND, ID_PREV, ID_ANUN = NOVO(1), NOVO(2), NOVO(3)
seq_det = int(attr(bloco_de(DET['id']), 'plug_display_sequence'))


def regiao_nova(rid, nome, sid, pai, cls, seq, comentario, cond='', opc=None):
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
{cond},p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>{uni(comentario)}
);
"""


novas = regiao_nova(ID_CAND, 'Candidatos', 'CANDIDATOS', HOST['id'], 'nc-req-etapa nc-req-candidatos', seq_det + 10,
                    'Etapa dos inscritos (Colaboradores e Candidatos Inscritos). Só aparece com a requisição gravada.',
                    ",p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'\n,p_plug_display_when_condition=>'P52_ROWID'\n")
novas += regiao_nova(ID_PREV, 'Prévia do anúncio', 'PREVIA_ETAPA', HOST['id'], 'nc-req-etapa nc-req-etapa-previa', seq_det + 20,
                     'Última etapa: como a vaga aparece para o candidato. Vazia de propósito: o Natcorp_Requisicao.js desenha o anúncio e a conferência "Antes de publicar". Se o JS não carregar, o CSS a esconde.')
novas += regiao_nova(ID_ANUN, 'Como o candidato vai ver', 'PREVIA_ANUNCIO', ID_PREV, 'nc-req-previa', 10,
                     'O anúncio desenhado pelo Natcorp_Requisicao.js (cargo, empresa, descrição e requisitos).', opc=OPC_SECAO)
m = [m for m in todas() if id_de(m.group(0)) == HOST['id']][0]
s = s[:m.end()] + novas + s[m.end():]
for k, r in enumerate(INSCRITOS):
    editar(r['id'], pai_seq(ID_CAND, 10 * (k + 1)), classe('nc-req-pessoas'))


# ---------- itens ----------
def item(nome, fx):
    global s
    for m in blocos('create_page_item'):
        if re.search(r"^,p_name=>'" + nome + r"'\s*$", m.group(0), re.M):
            s = s[:m.start()] + fx(m.group(0)) + s[m.end():]
            return
    sys.exit('não achei o item ' + nome)


item('P52_DDD_INDICADO', lambda t: por(t, 'prompt', "p_prompt=>'DDD'"))
item('P52_OBSERVACAO', lambda t: por(t, 'prompt', 'p_prompt=>' + uni('Observações para o recrutamento')))


# ---------- arquivos e comentário da página ----------
def pagina(t):
    m = re.search(r"^,p_javascript_file_urls=>wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n(.*?)\)\)\s*$", t, re.M | re.S)
    if 'Natcorp_Requisicao.js' in t:
        pass   # já posta à mão no APEX (exportação nova depois de subir os arquivos)
    elif m:
        t = t[:m.end(1)] + ",\n'#WORKSPACE_IMAGES#Natcorp_Requisicao.js'" + t[m.end(1):]
    elif re.search(r"^,p_javascript_file_urls=>'([^']*)'\s*$", t, re.M):
        t = re.sub(r"^,p_javascript_file_urls=>'([^']*)'\s*$", lambda x: ",p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'" + x.group(1) + "',\n'#WORKSPACE_IMAGES#Natcorp_Requisicao.js'))", t, flags=re.M)
    else:
        t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Requisicao.js'")
    if 'Natcorp_Requisicao.css' in t:
        pass
    elif re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem outras URLs de CSS: junte à mão')
    else:
        t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Requisicao.css'")
    linhas = [
        'DESENHO DA TELA (Natcorp_Requisicao.css / Natcorp_Requisicao.js, em Arquivos desta página)',
        '',
        'A estrutura é toda do APEX. O CSS/JS só muda o DESENHO de quem tem uma destas classes:',
        '  nc-req-etapas       Steppers: o resumo da vaga no alto, a faixa da aprovação e o menu das etapas.',
        '  nc-req-etapa        cada etapa (Identificação, Cargo, Remuneração, Perfil, Detalhamento, Candidatos,',
        '                      Prévia do anúncio): uma por vez; o nome no menu é o título da região.',
        '  nc-req-ficha        seção que se lê como documento; "Editar" abre o formulário (que continua na página).',
        '  nc-req-solicitacao  Solicitação: número, situação, motivo, data e solicitante.',
        '  nc-req-aprovadores  Aprovadores: faixa horizontal abaixo do resumo; Aprovar/Reprovar vão para ela.',
        '  nc-req-acoes        Botões Requisição: no canto do resumo (computador) ou abaixo dele (celular).',
        '  nc-req-lista        listas de requisitos: as linhas viram etiquetas (Obrigatório / Desejável).',
        '  nc-req-grupo / nc-req-plano / nc-req-opcional / nc-req-textos   agrupamentos e seções de apoio.',
        '  nc-req-pessoas      inscritos como cartões de pessoa.',
        '  nc-req-escrita      a descrição; nc-req-previa: o anúncio (vazia no APEX; o JS desenha).',
        '',
        'Os botões e links são os do APEX (só mudam de lugar na tela). Data de Situação fica somente leitura',
        'na tela (readonly: o valor continua indo no envio). Para desligar tudo: tire as duas URLs de arquivo.',
        'Guia: brand/apex/app/REQUISICAO-MANUTENCAO.md.',
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
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
ids = re.findall(r'^ p_id=>(wwv_flow_api\.id\(\d+\))', s, re.M)
if len(ids) != len(set(ids)):
    sys.exit('id repetido')
fora = [l for l in s.split('\n') if re.match(r"^,?p_(plug_name|name|prompt|region_css_classes|plug_comment)=>'", l) and any(ord(c) > 127 for c in l)]
if fora:
    sys.exit('texto com acento sem unistr: ' + fora[0][:80])
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok →', SAIDA)
