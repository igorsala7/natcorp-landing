"""Aplica o desenho da Requisição de PPP / Laudo numa EXPORTAÇÃO da página do app 2943 (página 61
hoje — a janela aberta pela aba "Requisição de PPP" do Painel do Operador, 200:775 → página 60).

    python3 aplicar-ppp.py f2943_page_61.sql [saida.sql]

O script reconhece a página pelos ITENS (nunca pelos IDs): …_TIPO_SOLICITACAO e
…_MATRICULA_SOLICITADO. O que muda — tudo visível no Page Designer; nenhuma validação, processo, ação
dinâmica, botão, item, região ou relatório é tocado:
  · a URL do Natcorp_PPP.js no FIM da lista de JavaScript que a página já tem (ou uma lista nova);
  · a URL do Natcorp_PPP.css;
  · o comentário da página (o que o desenho faz e como desligar).
Roda de novo sobre um arquivo já alterado: não altera duas vezes.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2943_page_61.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_PPP' in s     # já aplicado: só o comentário da página é atualizado

pag = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s)
pag = pag and pag.group(1)
if not pag or not all(("p_name=>'P%s_%s'" % (pag, n)) in s for n in ('TIPO_SOLICITACAO', 'MATRICULA_SOLICITADO')):
    sys.exit('este arquivo não é a página da Requisição de PPP / Laudo')

JS = '#WORKSPACE_IMAGES#Natcorp_PPP.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_PPP.css'


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
    'DESENHO DA TELA (Natcorp_PPP.css / Natcorp_PPP.js)',
    '',
    'A estrutura é toda do APEX; o .js só reorganiza a leitura (sem classe no APEX).',
    'Pedido novo: abertura com o caminho do pedido (você pede, o Médico e o Técnico de Segurança',
    '  analisam, o documento fica pronto aqui) e três passos:',
    '  1. Para quem é? Empresa e Colaborador.',
    '  2. O que você precisa? "Objeto da Solicitação" vira cartões (PPP, LTCAT, LI, Perícia) com o',
    '     nome por extenso e para que serve; o toque faz setValue na lista de verdade.',
    '  3. Conte mais e anexe (opcional).',
    '  Acima dos botões, o que falta; "Criar" = "Enviar pedido". Desdobramentos só depois de criado.',
    'Pedido gravado: cabeçalho (nº, situação, documento, para quem, quem pediu e quando) no lugar dos',
    '  campos do alto; as abas viram uma página só: o que foi pedido, o caminho da aprovação',
    '  (Aprovar/Reprovar dentro dele) e o Acompanhamento (os desdobramentos, com as iniciais no',
    '  lugar do ícone). Em leitura somem as caixas vazias e a área de arrastar arquivo.',
    '',
    'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
    'Guia: brand/apex/app/PPP-MANUTENCAO.md.',
]


def pagina(t):
    if re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_PPP)')
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
