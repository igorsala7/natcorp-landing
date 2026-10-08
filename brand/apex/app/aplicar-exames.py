"""Aplica o desenho da Requisição de Exames numa EXPORTAÇÃO da página do app 2937 (página 61 hoje — a
aberta pela aba "Requisição de Exames" do Painel do Operador, 200:774; a lista é a 2937:60).

    python3 aplicar-exames.py f2937_page_61.sql [saida.sql]

O script reconhece a página pelos ITENS (nunca pelos IDs): …_TIPO_PACIENTE, …_COD_TIPO_CONSULTA e
…_COD_PACIENTE. Se a página já tiver URLs de JavaScript, a nossa vai no FIM da lista; se já tiver
comentário, ele continua no alto, com o nosso embaixo."""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2937_page_61.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_Exames' in s     # já aplicado: só o comentário da página é atualizado

pag = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s)
pag = pag and pag.group(1)
if not pag or not all(("p_name=>'P%s_%s'" % (pag, n)) in s for n in ('TIPO_PACIENTE', 'COD_TIPO_CONSULTA', 'COD_PACIENTE')):
    sys.exit('este arquivo não é a página da Requisição de Exames (é a 61, não a lista 60 nem a agenda 75)')

JS = '#WORKSPACE_IMAGES#Natcorp_Exames.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Exames.css'


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
    'DESENHO DA TELA (Natcorp_Exames.css / Natcorp_Exames.js)',
    '',
    'A estrutura é toda do APEX; o .js só reorganiza a leitura (sem classe no APEX).',
    '  Pedido novo: passos 1 Quem vai fazer o exame? · 2 Que exame? · 3 Quando? · 4 Alguma observação?;',
    '  Candidato / Colaborador e os tipos de exame em cartões (setValue nos itens de verdade); o cartão',
    '  da consulta com "Escolher dia e horário" (clica o botão da agenda, que fica fora de vista); barra',
    '  no pé com o que falta e "Criar" = "Enviar pedido".',
    '  Pedido gravado: cabeçalho claro com código - descrição; o registro da agenda (dia, horário,',
    '  médico) é o único bloco em roxo; Situação, Salvar, Cancelar e Voltar numa linha de ações; a',
    '  aprovação logo abaixo, na largura toda.',
    '',
    'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
    'Guia: brand/apex/app/EXAMES-MANUTENCAO.md.',
]


def pagina(t):
    if re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_Exames)')
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
