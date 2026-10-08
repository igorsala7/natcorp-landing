"""Aplica o desenho da Marcação - Abono numa EXPORTAÇÃO da página 714 do app 9503
(FREQ_LANC_NATCORP — a janela que abre ao tocar num horário da Tratativa de Abono, 9503:203).

    python3 aplicar-abono-pagina714.py f9503_page_714.sql [saida.sql]

O script reconhece a página pelos ITENS (nunca pelos IDs): …_HORA_BATIDA_ABONO, …_POSICAO e
…_COD_JUSTIFICATIVA — os mesmos que o Natcorp_Abono.js procura. O que muda (tudo visível no Page
Designer; nenhuma validação, processo, ação dinâmica, botão, item, região ou relatório é tocado):
  · a URL do Natcorp_Abono.js no FIM da lista de JavaScript que a página já tem (ou uma lista nova);
  · a URL do Natcorp_Abono.css;
  · o comentário da página (o que o desenho faz e como desligar).
Roda de novo sobre um arquivo já alterado: não altera duas vezes (só atualiza o comentário).
Guia: ABONO-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f9503_page_714.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_Abono' in s     # já aplicado: só o comentário da página é atualizado

pag = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s)
pag = pag and pag.group(1)
if not pag or not all(("p_name=>'P%s_%s'" % (pag, n)) in s for n in ('HORA_BATIDA_ABONO', 'POSICAO', 'COD_JUSTIFICATIVA')):
    sys.exit('este arquivo não é a página da Marcação - Abono (itens HORA_BATIDA_ABONO, POSICAO e COD_JUSTIFICATIVA)')

JS = '#WORKSPACE_IMAGES#Natcorp_Abono.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Abono.css'


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
    'DESENHO DA TELA (Natcorp_Abono.css / Natcorp_Abono.js)',
    '',
    'A estrutura é toda do APEX; o .js só reorganiza a leitura (sem classe no APEX).',
    'Pedido novo, em perguntas: Qual batida? (as batidas do dia com o horário de cada uma, vindas',
    '  da Tratativa de Abono) · O que aconteceu? (horário errado / não devia existir / bateu no lugar',
    '  errado; sem batida = incluir) · Qual o horário? (relógio do aparelho) · Por quê? (os motivos',
    '  mais usados primeiro). Rodapé: a frase do pedido, o que falta e "Criar" = "Enviar pedido".',
    '  Quando o horário batido está 2 h ou mais longe do previsto, a tela sugere levá-lo para a',
    '  batida vazia do mesmo tipo (ex.: "Levar 18:01 para a 2ª saída").',
    'Celular: um passo por vez (4 passos), Voltar e Continuar presos embaixo. Computador: duas',
    '  colunas (A marcação | Por quê?). Com erro do APEX na tela, tudo aparece de uma vez.',
    'Pedido já feito: o resumo em frase no alto; os campos atrás de "Ver todos os campos".',
    '',
    'Nada é gravado pelo desenho: só apex.item().setValue, como a digitação (as ações dinâmicas',
    'continuam valendo). Para desligar tudo: tire as duas URLs de arquivo.',
    'Guia: brand/apex/app/ABONO-MANUTENCAO.md.',
]


def pagina(t):
    if re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_Abono)')
    t = mais_js(t)
    t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'" + CSS + "'")
    return comentario(t)


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

# ---------- conferência: nenhum atributo repetido em nenhum bloco ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok (página ' + pag + (', só o comentário' if JA else '') + ') →', SAIDA)
