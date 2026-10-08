"""Aplica o desenho dos LANÇAMENTOS DIVERSOS (reembolsos) do app 2060 (REQ_REEMBOLSO_NATCORP) numa
EXPORTAÇÃO de página:
  · página 2  (a lista, Requisição de Lançamentos Diversos) → motor Natcorp_Consulta (receita A2060_P2_);
  · página 11 (o pedido, Criar/Editar: Lançamentos Diversos) → Natcorp_Lancamento.

    python3 aplicar-lancamentos-2060.py f2060_page_2.sql [saida.sql]
    python3 aplicar-lancamentos-2060.py f2060_page_11.sql [saida.sql]

Reconhece a página pelos itens (P2_PERIODO + P2_SIT_REQ; P11_COD_PROCESSO + P11_MOTIVO). O que muda (tudo visível no Page
Designer): só as duas URLs de arquivo e o comentário da página. Regiões, relatório, itens, botões,
ações dinâmicas e o processo ficam como estão. Roda de novo sem alterar duas vezes.
Guia: LANCAMENTO-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2060_page_11.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if "p_default_application_id=>2060" not in s:
    sys.exit('este arquivo não é do app 2060')
if "p_name=>'P2_PERIODO'" in s and "p_name=>'P2_SIT_REQ'" in s:
    NOME, PAGINA = 'Natcorp_Consulta', 2
elif "p_name=>'P11_COD_PROCESSO'" in s and "p_name=>'P11_MOTIVO'" in s:
    NOME, PAGINA = 'Natcorp_Lancamento', 11
else:
    sys.exit('este arquivo não é a página 2 nem a 11 dos Lançamentos Diversos')
JA = NOME in s
JS = '#WORKSPACE_IMAGES#' + NOME + '.js'
CSS = '#WORKSPACE_IMAGES#' + NOME + '.css'

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



LINHAS_2 = [
    'DESENHO DA TELA (Natcorp_Consulta.css / Natcorp_Consulta.js, receita A2060_P2_) - a lista dos pedidos',
    '',
    'Os pedidos em cartoes para o colaborador no celular: "Seus pedidos de reembolso", "Fazer um pedido" (o botao Criar',
    'Requisicao original), a situacao com as cores do sistema e "Ver pedido" (o link da linha). "Ver como tabela" mostra o',
    'relatorio original. Os dados sao lidos pelo titulo das colunas. Para desligar: tire as duas URLs de arquivo.',
    'Guia: brand/apex/app/LANCAMENTO-MANUTENCAO.md.',
]
LINHAS_11 = [
    'DESENHO DA TELA (Natcorp_Lancamento.css / Natcorp_Lancamento.js) - o pedido de reembolso / lancamento',
    '',
    'Em 3 partes para o colaborador no celular: 1 o que esta pedindo (processo, lancamento, tipo, motivo); 2 a nota e o',
    'valor (data, quantidades, valor da nota com R$, "Valor que sera lancado" em destaque); 3 a foto da nota. "Enviar',
    'pedido" e o botao Criar. As abas Mostrar Tudo/Lancamentos/Anexos saem (tudo numa tela). Os campos, botoes e acoes',
    'dinamicas sao os originais: so mudam de lugar (ordem visual), de rotulo e de roupa. Para desligar: tire as URLs.',
    'Guia: brand/apex/app/LANCAMENTO-MANUTENCAO.md.',
]
LINHAS = LINHAS_2 if PAGINA == 2 else LINHAS_11


def comentario(t):
    novo = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))\n'
    m = re.search(r"^,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)|'(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))\n", t, re.M | re.S)
    if m:
        return t[:m.start()] + novo + t[m.end():]
    ancora = next((k for k in ('help_text', 'protection_level', 'autocomplete_on_off') if re.search(r'^,p_' + k + r'=>', t, re.M)), 'name')
    return poe(t, ancora, novo.rstrip('\n'))


def pagina(t):
    if re.search(r'^,p_(javascript|css)_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do ' + NOME + ')')
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
print('ok (página %d do app 2060' % PAGINA + (', só o comentário' if JA else '') + ') →', SAIDA)
