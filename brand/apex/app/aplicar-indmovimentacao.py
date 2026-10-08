"""Aplica o desenho da Requisição de Indicação de Movimentação numa EXPORTAÇÃO da página do app 2280
(página 184 hoje — a aberta pela aba "Requisição de Indicação de Movimentação" do Painel do Operador,
200:803; a lista é a 2280:183).

    python3 aplicar-indmovimentacao.py f2280_page_184.sql [saida.sql]

O script reconhece a página pelos ITENS (nunca pelos IDs): …_COD_FILIAL_PROP, …_COD_CARGO_PROP e
…_COD_FILIAL_ATUAL. Se a página já tiver URLs de JavaScript, a nossa vai no FIM da lista; se já tiver
comentário, ele continua no alto, com o nosso embaixo."""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2280_page_184.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_IndMovimentacao' in s     # já aplicado: só o comentário da página é atualizado

pag = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s)
pag = pag and pag.group(1)
if not pag or not all(("p_name=>'P%s_%s'" % (pag, n)) in s for n in ('COD_FILIAL_PROP', 'COD_CARGO_PROP', 'COD_FILIAL_ATUAL')):
    sys.exit('este arquivo não é a página da Indicação de Movimentação (é a 184, não a lista 183)')

JS = '#WORKSPACE_IMAGES#Natcorp_IndMovimentacao.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_IndMovimentacao.css'


def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]


def mais_js(t):
    """acrescenta o nosso JS no FIM da lista que a página já tem (ou cria a lista)"""
    m = re.search(r"^,p_javascript_file_urls=>wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n(.*?)\)\)\n", t, re.M | re.S)
    if m:
        return t[:m.end(1)] + ",\n'" + JS + "'" + t[m.end(1):]
    m = re.search(r"^,p_javascript_file_urls=>'([^']*)'\n", t, re.M)
    if m:
        return t[:m.start()] + ",p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'" + m.group(1) + "',\n'" + JS + "'))\n" + t[m.end():]
    return poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")


LINHAS = [
    'DESENHO DA TELA (Natcorp_IndMovimentacao.css / Natcorp_IndMovimentacao.js)',
    '',
    'A estrutura é toda do APEX; o .js só reorganiza a leitura (sem classe no APEX). O stepper',
    '"Página única / Etapas" é do time (Natcorp_Allow_Unload_Iframes.js, classe nc-stepper-host) e',
    'não é tocado.',
    '  Pedido novo: passos 1 Quem vai mudar? · 2 O que muda? · 3 Por que mudar?; o quadro',
    '  "Hoje → Vai para" (Filial, Cargo, Função, Local de trabalho) com o selo Muda / Continua igual /',
    '  Falta escolher; "Continua igual" copia o código de hoje (itens P184_COD_*_ATUAL) respeitando',
    '  as listas em cascata (Cargo antes da Função, Filial antes do Local); barra no pé com o que falta',
    '  e "Criar" = "Enviar pedido".',
    '  Pedido gravado: cabeçalho com código - descrição de cada mudança (de → para), empresa, motivo',
    '  e quem pediu; a região Aprovadores vem logo abaixo, na largura toda, como o caminho das outras',
    '  requisições.',
    '',
    'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
    'Guia: brand/apex/app/INDMOVIMENTACAO-MANUTENCAO.md.',
]


def pagina(t):
    if re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_IndMovimentacao)')
    t = mais_js(t)
    t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'" + CSS + "'")
    if re.search(r'^,p_page_comment=>', t, re.M):
        return comentario(t)
    ancora = next((k for k in ('help_text', 'protection_level', 'autocomplete_on_off') if re.search(r'^,p_' + k + r'=>', t, re.M)), 'name')
    return poe(t, ancora, ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))')


def comentario(t):
    """troca o comentário da página pelo desta versão (ou põe, se não houver)"""
    m = re.search(r"^,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)|'(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))\n", t, re.M | re.S)
    antes = []
    if m:
        # o que a página já tinha no comentário (fora o nosso bloco) continua no alto
        velho = m.group(0)
        partes = re.findall(r"^(?:,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\()?)?((?:unistr\()?'(?:[^']|'')*'\)?)", velho, re.M)
        for q in partes:
            if 'DESENHO DA TELA' in q:
                break
            antes.append(q)
        while antes and antes[-1] in ("''",):
            antes.pop()
    corpo = antes + (["''"] if antes else []) + [uni(l) for l in LINHAS]
    novo = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(corpo) + '))\n'
    if m:
        return t[:m.start()] + novo + t[m.end():]
    ancora = next((k for k in ('help_text', 'protection_level', 'autocomplete_on_off') if re.search(r'^,p_' + k + r'=>', t, re.M)), 'name')
    return poe(t, ancora, novo.rstrip('\n'))


m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + (comentario(m.group(0)) if JA else pagina(m.group(0))) + s[m.end():]

# ---------- conferência ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok (página ' + pag + (', só o comentário' if JA else '') + ') →', SAIDA)
