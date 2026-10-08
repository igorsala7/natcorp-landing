"""Aplica o desenho da Requisição de Férias numa EXPORTAÇÃO da página 78 — do app 200 (o
colaborador) ou do app 300 (a mesma página, conferida em 02/10: mesmas regiões, itens e botões).

    python3 aplicar-ferias-pagina78.py f200_page_78.sql [saida.sql]
    python3 aplicar-ferias-pagina78.py f300_page_78.sql [saida.sql]

Funciona com a exportação de QUALQUER ambiente: acha tudo pelos NOMES (ID estático das
regiões, nome dos itens e dos botões), nunca pelos números — cada release instala o app com
IDs internos novos, e uma exportação de página só entra no mesmo app de onde saiu (ORA-02291
WWV_FLOW_STEP_UI_FK). Então: exporte a página do ambiente onde vai importar, rode este
script sobre ela, importe o resultado lá mesmo.

O que muda (tudo visível no Page Designer):
  · região nova "Confira suas férias" (LINHA_FERIAS), dentro de "Período", depois das
    parcelas: cada parte em frases (começa / volta), com os avisos;
  · "Período" → "Suas férias"; parcelas → "1ª parte", "2ª parte", "3ª parte" (as programadas
    também: o selo "Já programada" vem do desenho);
  · rótulos em linguagem simples (perguntas) e a ajuda de "Alguém vai cobrir sua posição…";
  · região de botões no fim da página (sai da barra do topo); "Criar" → "Enviar pedido de férias";
  · as classes nc-fer-… (o contrato com Natcorp_Ferias.css/.js), inclusive nc-fer-colaborador
    em "Colaborador Solicitado";
  · o comentário da página com o guia de manutenção.
Nada muda nas validações, processos, ações dinâmicas nem nas listas de valores.
Roda de novo sobre um arquivo já alterado: não altera duas vezes (para no primeiro sinal).
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f200_page_78.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if "p_region_name=>'LINHA_FERIAS'" in s:
    sys.exit('este arquivo já tem o desenho aplicado (LINHA_FERIAS existe)')
if not re.search(r'wwv_flow_api\.create_page\(\n p_id=>78\n', s):
    sys.exit('este arquivo não é a página 78')


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


def id_de(m):
    return re.search(r'p_id=>(wwv_flow_api\.id\(\d+\))', m.group(0)).group(1)


def editar(fn, chave, valor, fx):
    global s
    m = achar(fn, chave, valor)
    s = s[:m.start()] + fx(m.group(0)) + s[m.end():]


def por(t, chave, linha):
    m = re.search(r'^(,?)p_' + chave + r'=>.*$', t, re.M)
    if not m:
        sys.exit('falta p_' + chave)
    return t[:m.start()] + m.group(1) + linha + t[m.end():]


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]


def com(t, chave, linha, depois_de):
    """troca a linha se ela existe; senão acrescenta depois de outra"""
    return por(t, chave, linha) if re.search(r'^,?p_' + chave + r'=>', t, re.M) else poe(t, depois_de, ',' + linha)


def mais_classe(t, chave, cls, depois_de):
    """junta a classe às que o time já pôs (não apaga nenhuma)"""
    m = re.search(r"^,p_" + chave + r"=>'([^']*)'\s*$", t, re.M)
    if m:
        atuais = m.group(1).split()
        return t if cls in atuais else por(t, chave, "p_" + chave + "=>'" + ' '.join(atuais + [cls]) + "'")
    return poe(t, depois_de, ",p_" + chave + "=>'" + cls + "'")


# ---------- regiões: pelo ID estático ou, na exportação que ainda não tem, pelo nome ----------
REGIOES = {
    'PERIODO_FERIAS': 'Período de Férias',
    'BOTOES': 'Botões',
}
for sid, nome in REGIOES.items():
    if "p_region_name=>'%s'" % sid in s:
        continue
    alvo = [b for b in blocos('create_page_plug') if re.search(r'^,p_plug_name=>' + re.escape(uni(nome)) + r'\s*$', b.group(0), re.M)]
    if len(alvo) != 1:
        sys.exit('esperava uma região "%s", achei %d' % (nome, len(alvo)))
    t = alvo[0].group(0)
    t = por(t, 'region_name', "p_region_name=>'" + sid + "'") if re.search(r'^,p_region_name=>', t, re.M) else poe(t, 'plug_name', ",p_region_name=>'" + sid + "'")
    s = s[:alvo[0].start()] + t + s[alvo[0].end():]

regiao = lambda sid: achar('create_page_plug', 'region_name', "'" + sid + "'")
ID_PER = id_de(regiao('PER'))
TPL = re.search(r'p_plug_template=>(wwv_flow_api\.id\(\d+\))', regiao('PER').group(0)).group(1)
# id NOVO: alto, e DIFERENTE por aplicação (200, 300…) — o APEX soma o deslocamento do ambiente
# na importação. Um id só (o mesmo nas duas páginas 78) arriscava a constraint de chave única
# quando as duas páginas moram na mesma base.
APP = int(re.search(r'p_default_application_id=>(\d+)', s).group(1))
ID_LINHA = 'wwv_flow_api.id(%s)' % ('28299%04d0078%07d' % (APP, 1))
if re.search(r'\b' + re.escape(ID_LINHA) + r'\b', s):
    sys.exit('o id novo já existe neste arquivo: ' + ID_LINHA)


def regiao_classe(sid, cls, titulo=None, extra=None):
    def f(t):
        t = mais_classe(t, 'region_css_classes', cls, 'region_name')
        if titulo:
            t = por(t, 'plug_name', 'p_plug_name=>' + uni(titulo))
        return extra(t) if extra else t
    editar('create_page_plug', 'region_name', "'" + sid + "'", f)


regiao_classe('PER', 'nc-fer-direito', 'Suas férias')
regiao_classe('PERIODO_FERIAS', 'nc-fer-detalhes')
regiao_classe('DADOS', 'nc-fer-detalhes')
regiao_classe('COLABORADOR', 'nc-fer-colaborador')
for n in (1, 2, 3):
    regiao_classe('PARCELA%d' % n, 'nc-fer-parte', '%dª parte' % n)
    regiao_classe('2_PARCELA%d' % n, 'nc-fer-programada', '%dª parte' % n)
# botões: saem da barra do topo (REGION_POSITION_01) e vão para o fim do conteúdo
regiao_classe('BOTOES', 'nc-fer-acoes', extra=lambda t: por(por(t, 'plug_display_point', "p_plug_display_point=>'BODY'"), 'plug_display_sequence', 'p_plug_display_sequence=>990'))

# ---------- região nova: a linha do tempo, depois das parcelas (e da coletiva, que nunca aparece) ----------
seqs = [int(re.search(r'p_plug_display_sequence=>(\d+)', b.group(0)).group(1)) for b in blocos('create_page_plug') if 'p_parent_plug_id=>' + ID_PER in b.group(0)]
nova = f"""wwv_flow_api.create_page_plug(
 p_id=>{ID_LINHA}
,p_plug_name=>{uni('Confira suas férias')}
,p_region_name=>'LINHA_FERIAS'
,p_parent_plug_id=>{ID_PER}
,p_region_css_classes=>'nc-fer-linha'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>{TPL}
,p_plug_display_sequence=>{max(seqs) + 10}
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>{uni('Vazia de propósito: o Natcorp_Ferias.js escreve aqui, em frases, quando cada parte começa e quando a pessoa volta (datas e dias das regiões nc-fer-parte e nc-fer-programada), com o aviso quando passa de P78_DT_LIMITE_REQ ou cruza com outra parte. Se o JS não carregar, o CSS a esconde. Ao tirar o desenho da página, ponha esta região em Nunca.')}
);
"""
m = regiao('BOTOES')
s = s[:m.start()] + nova + s[m.start():]

# ---------- itens ----------
def item(nome, prompt=None, cls=None, extra=None):
    def f(t):
        if prompt:
            t = por(t, 'prompt', 'p_prompt=>' + uni(prompt))
        if cls:
            t = mais_classe(t, 'item_css_classes', cls, 'prompt')
        return extra(t) if extra else t
    editar('create_page_item', 'name', "'" + nome + "'", f)


PERGUNTA = 'Outra pessoa vai fazer o seu trabalho enquanto você estiver de férias?'
AJUDA = 'Responda Sim quando outra pessoa vai assumir o seu trabalho durante as férias (reposição). Com Sim, aparece o botão Requisição Pessoal para pedir essa pessoa.'
item('P78_OPCAO_FERIAS', 'Como você quer tirar suas férias?', 'nc-fer-opcao')
item('P78_OPCAO_FERIAS_A', 'Como você quer tirar suas férias?', 'nc-fer-opcao')
item('P78_HAVERA_REP', PERGUNTA, 'nc-fer-simnao',
     lambda t: t if re.search(r'^,p_help_text=>', t, re.M) else poe(t, 'item_template_options', ',p_help_text=>' + uni(AJUDA)))
for n in '124':  # a 3ª parcela usa os itens de número 4
    item('P78_DT_SAIDA_PARC' + n, 'Em que dia você começa as férias?')
    item('P78_NUM_DIAS_PARC%s_LST' % n, 'Quantos dias?', 'nc-fer-dias')
    item('P78_DIAS_ABONO_PEC%s_LST' % n, 'Dias vendidos (abono)', 'nc-fer-dias')
    item('P78_OPCAO_13SAL' + n, 'Quer receber metade do 13º salário junto com estas férias?', 'nc-fer-simnao')
    item('P78_DT_RETORNO_PARC' + n, 'Volta ao trabalho', 'nc-fer-retorno')

# ---------- botões ----------
editar('create_page_button', 'button_name', "'P78_CREATE'", lambda t: por(t, 'button_image_alt', 'p_button_image_alt=>' + uni('Enviar pedido de férias')))

# ---------- arquivos e comentário da página ----------
def pagina(t):
    t = com(t, 'javascript_file_urls', "p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Ferias.js'", 'autocomplete_on_off')
    t = com(t, 'css_file_urls', "p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Ferias.css'", 'javascript_file_urls')
    linhas = [
        'DESENHO DA TELA (Natcorp_Ferias.css / Natcorp_Ferias.js, em Arquivos desta página)',
        '',
        'A estrutura é toda do APEX: ordem, colunas, títulos, rótulos e botões estão aqui no Page Designer',
        'e aparecem na tela do mesmo jeito. O CSS/JS só muda o DESENHO de quem tem uma destas classes:',
        '',
        'Regiões (Aparência > Classes CSS):',
        '  nc-fer-direito     Suas férias: abre com "Você tem N dias de férias" e até quando começar (P78_SALDO_1, P78_DT_LIMITE_REQ).',
        '  nc-fer-detalhes    Período de Férias e Dados: recolhidos, atrás do botão "Ver os detalhes do período".',
        '  nc-fer-parte       1ª/2ª/3ª parte: o formulário de cada parte.',
        '  nc-fer-programada  As partes já programadas: o mesmo, com o selo "Já programada".',
        '  nc-fer-linha       Confira suas férias: cada parte em frases (vazia no APEX; o JS escreve).',
        '  nc-fer-acoes       Botões: presa ao pé da tela, dizendo o que falta escolher.',
        '  nc-fer-colaborador Colaborador Solicitado: o cartão com a foto, o nome, a filial e os anos de casa.',
        '  (sem classe)       a região com P78_COD_SOLICITACAO vira o cartão do pedido (nº, situação, quem pediu);',
        '                     o relatório com a coluna APROVADOR vira o caminho da aprovação, abaixo do pedido.',
        '',
        'Itens (Avançado > Classes CSS; vai para o contêiner do item) — a lista continua sendo o item de verdade:',
        '  nc-fer-opcao    P78_OPCAO_FERIAS(_A): primeiro "Você quer vender dias?", depois só as opções que servem (lê "N Parcela(s): X dias + Y abono").',
        '  nc-fer-simnao   P78_HAVERA_REP, P78_OPCAO_13SAL*: botões Não/Sim.',
        '  nc-fer-dias     P78_NUM_DIAS_PARC*_LST, P78_DIAS_ABONO_PEC*_LST: botões; com UMA opção, é escolhida sozinha e vira frase.',
        '  nc-fer-retorno  P78_DT_RETORNO_PARC*: a volta dita em frase ("Volta ao trabalho em quarta-feira, ...").',
        '',
        'Clicar num botão/cartão faz apex.item(...).setValue(...): as ações dinâmicas de sempre disparam, e as',
        'validações continuam no servidor. Para mudar a tela: mude aqui. Para tirar o desenho: tire a classe.',
        'Para desligar tudo: tire as duas URLs de arquivo desta página. Não renomeie os itens P78_* acima sem',
        'ajustar o Natcorp_Ferias.js. Fontes e guia: brand/apex/app/Natcorp_Ferias.src.js / .src.css e FERIAS-MANUTENCAO.md.',
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
ids = re.findall(r'^ p_id=>(wwv_flow_api\.id\(\d+\))', s, re.M)
if len(ids) != len(set(ids)):
    sys.exit('id repetido')
fora = [l for l in s.split('\n') if re.match(r"^,?p_[a-z0-9_]+=>'", l) and any(ord(c) > 127 for c in l)]
if fora:
    sys.exit('texto com acento sem unistr: ' + fora[0][:80])
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok →', SAIDA)
