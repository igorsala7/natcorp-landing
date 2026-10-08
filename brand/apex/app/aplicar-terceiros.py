"""Aplica o desenho da Requisição de Serviço de Terceiros numa EXPORTAÇÃO da página do app 2290
(página 186 hoje — a aberta pela aba "Requisição de Serviços de Terceiros" do Painel do Operador,
200:804).

    python3 aplicar-terceiros.py f2290_page_186.sql [saida.sql]

O script reconhece a página pelos ITENS (nunca pelos IDs): …_IND_VINCULO_EMPREG e …_COD_TERCEIRO.
A URL de JavaScript que a página já tem (jquery.mask) continua, com a nossa no FIM da lista; o
comentário que a página já tem continua no alto, com o nosso embaixo. O que muda — tudo visível no Page Designer; nenhuma validação, processo, ação
dinâmica, botão, item, região ou relatório é tocado:
  · a URL do Natcorp_Terceiros.js no FIM da lista de JavaScript que a página já tem (ou uma lista nova);
  · a URL do Natcorp_Terceiros.css;
  · o comentário da página (o que o desenho faz e como desligar).
Roda de novo sobre um arquivo já alterado: não altera duas vezes.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2290_page_186.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_Terceiros' in s     # já aplicado: só o comentário da página é atualizado

pag = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s)
pag = pag and pag.group(1)
if not pag or not all(("p_name=>'P%s_%s'" % (pag, n)) in s for n in ('IND_VINCULO_EMPREG', 'COD_TERCEIRO')):
    sys.exit('este arquivo não é a página da Requisição de Serviço de Terceiros (é a 186, não a lista 185)')

JS = '#WORKSPACE_IMAGES#Natcorp_Terceiros.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Terceiros.css'


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
    'DESENHO DA TELA (Natcorp_Terceiros.css / Natcorp_Terceiros.js)',
    '',
    'A estrutura é toda do APEX; o .js só reorganiza a leitura (sem classe no APEX). O stepper',
    '"Página única / Etapas" é do time (Natcorp_Allow_Unload_Iframes.js, classe nc-stepper-host) e',
    'não é tocado.',
    '  Abertura com a lista de documentos para pedir à empresa contratada (Copiar / WhatsApp).',
    '  Perguntas de segurança: a pergunta em outras palavras por cima do texto oficial, siglas',
    '  explicadas, "Veio marcado / Conferido" e o placar de cada bloco; produto químico = Não recolhe',
    '  a FISPQ. Anexos com o nome simples e "Falta anexar / Anexado".',
    '  Dicas entre o nome do campo e a caixa; nomes e caixas alinhados por linha; o Prestador em',
    '  "A empresa contratada" e "O contrato" (os campos só mudam de lugar dentro da região).',
    '  Barra no pé com o que falta e "Criar" = "Enviar pedido".',
    '',
    'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
    'Guia: brand/apex/app/TERCEIROS-MANUTENCAO.md.',
]


def pagina(t):
    if re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_Terceiros)')
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
