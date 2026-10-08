"""Aplica o desenho da Requisição de Escala numa EXPORTAÇÃO da página 179 do app 9503
(FREQ_LANC_NATCORP — a janela "Criar/Editar: Requisição Escala para Colaborador").

    python3 aplicar-escala-pagina179.py f9503_page_179.sql [saida.sql]

O script reconhece a página pelos ITENS (nunca pelos IDs). O que muda — tudo visível no Page
Designer; nenhuma validação, processo, ação dinâmica, botão, item ou relatório é tocado:
  · a URL do Natcorp_Escala.js (no fim da lista de JavaScript, se a página tiver uma);
  · a URL do Natcorp_Escala.css;
  · o comentário da página (o que o desenho faz e como desligar).
Roda de novo sobre um arquivo já alterado: não altera duas vezes.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f9503_page_179.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if 'Natcorp_Escala' in s:
    sys.exit('este arquivo já tem o desenho aplicado (Natcorp_Escala já está na página)')

pag = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s)
pag = pag and pag.group(1)
if not (pag and ("p_name=>'P%s_COD_ESCALA'" % pag) in s and ("p_name=>'P%s_EXCECAO'" % pag) in s):
    sys.exit('este arquivo não é a página da Requisição de Escala (itens COD_ESCALA e EXCECAO)')
QUAL = 'escala'

JS = '#WORKSPACE_IMAGES#Natcorp_Escala.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Escala.css'


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


LINHAS = {
    'escala': [
        'DESENHO DA TELA (Natcorp_Escala.css / Natcorp_Escala.js)',
        '',
        'A estrutura é toda do APEX; o .js só reorganiza a leitura (sem classe no APEX):',
        '  pedido novo em 5 passos (quem, o que precisa, a nova escala, por quanto tempo, por quê);',
        '  Plantão e Exceção viram escolhas grandes ("Mudar a escala / Fazer plantão", "Definitiva /',
        '  Só por um tempo"); o rodapé diz o que falta e "Criar" aparece como "Enviar pedido".',
        '  Pedido gravado: cabeçalho com nº, data e situação, e a aprovação em linha do tempo.',
        'Se a empresa só aceita exceção (a página força Exceção = Sim), a tela explica.',
        '',
        'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
        'Guia: brand/apex/app/ESCALA-MANUTENCAO.md.',
    ],
}


def pagina(t):
    if re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_Escala)')
    t = mais_js(t)
    t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'" + CSS + "'")
    if re.search(r'^,p_page_comment=>', t, re.M):
        return t
    ancora = 'help_text' if re.search(r'^,p_help_text=>', t, re.M) else 'protection_level'
    return poe(t, ancora, ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS[QUAL]) + '))')


m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + pagina(m.group(0)) + s[m.end():]

# ---------- conferência ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok (escala, página ' + pag + ') →', SAIDA)
