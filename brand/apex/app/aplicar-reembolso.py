"""Aplica o desenho dos Lançamentos Diversos em lote (Requisição de Reembolsos) numa EXPORTAÇÃO da
página do app 2060 (REQ_REEMBOLSO_NATCORP, página 7 hoje — a aberta pela aba "Requisição de
Reembolsos" do Painel do Operador, 200:798).

    python3 aplicar-reembolso.py f2060_page_7.sql [saida.sql]

O script reconhece a página pelos ITENS (nunca pelos IDs): …_COD_PROCESSO, …_EVENTOS e
…_COD_ELEGIBILIDADE. O que muda — tudo visível no Page Designer; nenhuma validação, processo, ação
dinâmica, botão, item, região ou relatório é tocado:
  · a URL do Natcorp_Reembolso.js no FIM da lista de JavaScript que a página já tem (ou uma lista nova);
  · a URL do Natcorp_Reembolso.css;
  · o comentário da página (o que o desenho faz e como desligar).
Roda de novo sobre um arquivo já alterado: não altera duas vezes.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2060_page_7.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_Reembolso' in s     # já aplicado: só o comentário da página é atualizado

pag = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s)
pag = pag and pag.group(1)
if not pag or not all(("p_name=>'P%s_%s'" % (pag, n)) in s for n in ('COD_PROCESSO', 'EVENTOS', 'COD_ELEGIBILIDADE')):
    sys.exit('este arquivo não é a página dos Lançamentos Diversos em lote')

JS = '#WORKSPACE_IMAGES#Natcorp_Reembolso.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Reembolso.css'


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
    'DESENHO DA TELA (Natcorp_Reembolso.css / Natcorp_Reembolso.js)',
    '',
    'A estrutura é toda do APEX; o .js só reorganiza a leitura (sem classe no APEX), em três passos:',
    '  1. Quem vai receber? Empresa e processo à vista; os outros filtros em "Filtrar mais"',
    '     ("N filtros em uso" quando escondidos). "Pesquisar" = "Buscar as pessoas". Depois da',
    '     busca, o passo vira um resumo ("2 pessoas encontradas") com "Mudar a busca".',
    '  2. O que você vai lançar? Tipo de lançamento (o evento) e motivo; Quanto (R$ ou horas/dias,',
    '     de cada pessoa); as datas decididas pelo sistema viram uma frase; Vale a partir de / até.',
    '  3. Confira quem vai receber: "N de N pessoas marcadas", Marcar/Desmarcar todas (as caixas f01',
    '     da página do relatório) e só as colunas com dado. A lista sai de dentro de Lançamentos.',
    '  Barra do pé: "Você vai lançar X de R$ Y para N pessoas (total)", o que falta e',
    '  "Criar Requisicao" = "Enviar lançamentos".',
    '  Pedido gravado: cabeçalho (nº, situação, efetivação), "Parâmetros" resumido, "N pessoas neste',
    '  pedido" e o caminho da aprovação (Aprovar/Reprovar dentro dele).',
    '',
    'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
    'Guia: brand/apex/app/REEMBOLSO-MANUTENCAO.md.',
]


def pagina(t):
    if re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_Reembolso)')
    t = mais_js(t)
    t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'" + CSS + "'")
    if re.search(r'^,p_page_comment=>', t, re.M):
        return t
    ancora = next((k for k in ('help_text', 'protection_level', 'autocomplete_on_off') if re.search(r'^,p_' + k + r'=>', t, re.M)), 'name')
    return poe(t, ancora, ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))')


def comentario(t):
    """troca o comentário da página pelo desta versão (ou põe, se não houver)"""
    novo = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))\n'
    m = re.search(r"^,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)|'(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))\n", t, re.M | re.S)
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
