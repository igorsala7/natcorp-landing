"""Aplica a CONSULTA DE FÉRIAS (Natcorp_FeriasConsulta.js/.css) numa EXPORTAÇÃO da página 77 do app 300
(Portal do Colaborador — Requisição de Férias, a lista dos pedidos).

    python3 aplicar-feriasconsulta-pagina77.py f300_page_77.sql [saida.sql]

Reconhece a página pelos itens P77_OK e P77_ALERT_ACAO_JURIDICO. O que muda (tudo visível no Page
Designer): só as duas URLs de arquivo e o comentário da página. Regiões, relatório, itens, botões,
ações dinâmicas e o processo ficam como estão. Roda de novo sem alterar duas vezes.
Guia: FERIASCONSULTA-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f300_page_77.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_FeriasConsulta' in s

if "p_name=>'P77_OK'" not in s or "p_name=>'P77_ALERT_ACAO_JURIDICO'" not in s:
    sys.exit('este arquivo não é a consulta de Requisição de Férias (itens P77_OK e P77_ALERT_ACAO_JURIDICO)')

JS = '#WORKSPACE_IMAGES#Natcorp_FeriasConsulta.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_FeriasConsulta.css'

def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def des_uni(lit):
    """uma linha do wwv_flow_t_varchar2 ('...' ou unistr('...')) de volta para texto"""
    m = re.match(r"^(unistr\()?'(.*)'\)?$", lit.strip())
    t = m.group(2).replace("''", "'")
    if m.group(1):
        t = re.sub(r'\\([0-9A-Fa-f]{4})', lambda x: chr(int(x.group(1), 16)), t)
    return t


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]



LINHAS = [
    'DESENHO DA TELA (Natcorp_FeriasConsulta.css / Natcorp_FeriasConsulta.js)',
    '',
    'Os pedidos de ferias em cartoes, para o colaborador no celular: cartao curto do colaborador, "Pedir ferias" (o',
    'botao Criar Requisicao original, com as acoes dele), "Suas proximas ferias", a situacao em botoes com a contagem,',
    'e cada pedido com as partes (sai, volta, dias, dias vendidos, 13o), o periodo aquisitivo e o saldo, "Ver pedido" e',
    '"Pedir de novo" (os links originais). Cancelados e reprovados ficam guardados num botao. "Ver como tabela" mostra o',
    'relatorio original com as ferramentas. Os dados sao lidos do relatorio pelo titulo das colunas: renomear coluna = conferir.',
    'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/FERIASCONSULTA-MANUTENCAO.md.',
]


def comentario(t):
    novo = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))\n'
    m = re.search(r"^,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)|'(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))\n", t, re.M | re.S)
    if m:
        return t[:m.start()] + novo + t[m.end():]
    ancora = next((k for k in ('help_text', 'protection_level', 'autocomplete_on_off') if re.search(r'^,p_' + k + r'=>', t, re.M)), 'name')
    return poe(t, ancora, novo.rstrip('\n'))


def pagina(t):
    if re.search(r'^,p_(javascript|css)_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_FeriasConsulta)')
    t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")
    t = poe(t, 'javascript_file_urls', ",p_css_file_urls=>'" + CSS + "'")
    return comentario(t)


m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + (comentario(m.group(0)) if JA else pagina(m.group(0))) + s[m.end():]



# ---------- conferência: nenhum atributo repetido em nenhum bloco ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
fora = [l for l in s.split('\n') if re.match(r"^,?p_[a-z0-9_]+=>'", l) and any(ord(c) > 127 for c in l)]
if fora:
    sys.exit('texto com acento sem unistr: ' + fora[0][:80])
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok (página 77 do app 300' + (', só o comentário' if JA else '') + ') →', SAIDA)
