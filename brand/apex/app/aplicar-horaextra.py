"""Aplica o desenho da Requisição de Hora Extra numa EXPORTAÇÃO da página do app 9503 (página 716
hoje — a janela aberta pela lista 9503:138, que a aba "Requisição de Hora Extra" do Painel do
Operador embute em 200:795).

    python3 aplicar-horaextra.py f9503_page_716.sql [saida.sql]

O script reconhece a página pelos ITENS (nunca pelos IDs): …_HORA_INICIAL, …_HORA_FINAL e
…_DATA_PONTO. O que muda — tudo visível no Page Designer; nenhuma validação, processo, ação
dinâmica, botão, item, região ou relatório é tocado:
  · a URL do Natcorp_HoraExtra.js no FIM da lista de JavaScript que a página já tem (ou uma lista nova);
  · a URL do Natcorp_HoraExtra.css;
  · o comentário da página (o que o desenho faz e como desligar).
Roda de novo sobre um arquivo já alterado: não altera duas vezes.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f9503_page_716.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_HoraExtra' in s     # já aplicado: só o comentário da página é atualizado

pag = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s)
pag = pag and pag.group(1)
if not pag or not all(("p_name=>'P%s_%s'" % (pag, n)) in s for n in ('HORA_INICIAL', 'HORA_FINAL', 'DATA_PONTO')):
    sys.exit('este arquivo não é a página da Requisição de Hora Extra (é a 716, não a lista 138)')

JS = '#WORKSPACE_IMAGES#Natcorp_HoraExtra.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_HoraExtra.css'


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
    'DESENHO DA TELA (Natcorp_HoraExtra.css / Natcorp_HoraExtra.js)',
    '',
    'A estrutura é toda do APEX; o .js só reorganiza a leitura (sem classe no APEX).',
    'Pedido novo: abertura com o caminho do pedido (você pede, quem aprova autoriza, você faz as',
    '  horas) e quatro passos: 1. Quem vai fazer (a caixa abre a lista); 2. Em que dia (Hoje, Amanhã,',
    '  Sábado e o dia por extenso); 3. Em que horário: o relógio de ponteiros (clockpicker) dá lugar',
    '  ao seletor de hora do aparelho (input type=time, valor HH:MM), atalhos de 1 a 4 horas e a',
    '  régua do dia com a duração; 4. Por que precisa (começos de motivo que escrevem na caixa).',
    '  Rodapé: a frase do pedido, o que falta e "Criar" = "Enviar pedido".',
    'Pedido gravado: cabeçalho (nº, situação, de quem, dia, horário na régua, motivo, quem pediu);',
    '  as abas viram uma página só e a aprovação é o caminho das outras requisições. Aprovar e',
    '  Reprovar entram no caminho só com uma etapa pendente.',
    '',
    'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
    'Guia: brand/apex/app/HORAEXTRA-MANUTENCAO.md.',
]


def pagina(t):
    if re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_HoraExtra)')
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
