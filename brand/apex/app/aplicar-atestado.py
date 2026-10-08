"""Aplica o desenho da Requisição de Atestados e Afastamentos numa EXPORTAÇÃO da página que abre
em janela pela lista de atestados (app 2937 "Medicina Ocupacional - Atendimento", página 91 hoje).
NÃO é o abono de marcações do ponto: aqui é o atestado e o período em que a pessoa ficou fora.

    python3 aplicar-atestado.py f2937_page_91.sql [saida.sql]

O script reconhece a página pelos ITENS (nunca pelos IDs): …_COD_ATESTADO_MEDICO,
…_DT_INICIO_AFASTAMENTO e …_QTDE_DIAS_AFASTAMENTO. O que muda — tudo visível no Page Designer;
nenhuma validação, processo, ação dinâmica, botão, item ou relatório é tocado:
  · a URL do Natcorp_Atestado.js no FIM da lista de JavaScript que a página já tem;
  · a URL do Natcorp_Atestado.css;
  · o comentário da página (o que o desenho faz e como desligar).
Sobre um arquivo que já tem o desenho (ex.: uma exportação nova da página já aplicada), não põe
as URLs de novo: só troca o comentário da página pelo desta versão.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2937_page_91.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_Atestado' in s      # já aplicado: só o comentário da página é atualizado

pag = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s)
pag = pag and pag.group(1)
if not pag or not all(("p_name=>'P%s_%s'" % (pag, n)) in s for n in ('COD_ATESTADO_MEDICO', 'DT_INICIO_AFASTAMENTO', 'QTDE_DIAS_AFASTAMENTO')):
    sys.exit('este arquivo não é a página da Requisição de Atestados e Afastamentos')

JS = '#WORKSPACE_IMAGES#Natcorp_Atestado.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Atestado.css'


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
    'DESENHO DA TELA (Natcorp_Atestado.css / Natcorp_Atestado.js)',
    '',
    'A estrutura é toda do APEX; o .js só reorganiza a leitura (sem classe no APEX):',
    '  Pedido novo: a região Dados do Atestado em partes (Quem · Que afastamento é · Quando ·',
    '  Quem atendeu · O atestado · INSS e acidente, esta recolhida), atalhos Hoje/Ontem,',
    '  "Quantos dias" em botões, "Mesmo dia", a frase que confere o período, a foto do atestado',
    '  com prévia e aviso de 10 MB, e o rodapé com o que falta. "Criar" = "Enviar pedido".',
    '  Pedido gravado: cabeçalho (nº, situação, período, quem pediu) no lugar das regiões',
    '  Requisição e Log (escondidas, continuam na página); campos vazios saem da leitura;',
    '  "Cancelar" = "Cancelar este pedido".',
    '  Aprovação: o mesmo "caminho da aprovação" das páginas de requisição, logo abaixo do',
    '  cabeçalho (resumo "1 de 2 · aguardando Fulano", aprovadores em linha, justificativas);',
    '  para quem aprova, os botões Aprovar/Reprovar do APEX vão para dentro dela ("é a sua vez").',
    '  A timeline e a sub-região Justificativa continuam na página, escondidas.',
    'Os atalhos usam apex.item().setValue com o change: as ações da página (último dia a partir',
    'de quantos dias, dias a partir do último dia, dias/horas do tipo) rodam como se digitado.',
    '',
    'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
    'Guia: brand/apex/app/ATESTADO-MANUTENCAO.md.',
]


def pagina(t):
    if re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_Atestado)')
    t = mais_js(t)
    t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'" + CSS + "'")
    if re.search(r'^,p_page_comment=>', t, re.M):
        return t
    ancora = 'help_text' if re.search(r'^,p_help_text=>', t, re.M) else 'protection_level'
    return poe(t, ancora, ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))')


def comentario(t):
    """troca o comentário da página pelo desta versão (ou põe, se não houver)"""
    novo = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))\n'
    m = re.search(r"^,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)|'(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))\n", t, re.M | re.S)
    if m:
        return t[:m.start()] + novo + t[m.end():]
    ancora = 'help_text' if re.search(r'^,p_help_text=>', t, re.M) else 'protection_level'
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
