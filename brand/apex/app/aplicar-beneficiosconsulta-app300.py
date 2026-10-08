"""Aplica o desenho do CONTRATO DE GESTÃO (Natcorp_BeneficiosConsulta.js/.css) DIRETO na exportação COMPLETA
do app 300 (f300.sql): página 89 (Cadastro de Benefícios, a consulta).

    python3 aplicar-beneficiosconsulta-app300.py f300.sql [saida.sql]

Para cada página: recorta o trecho dela ("prompt --application/pages/page_NNNNN" até o próximo
"prompt --application/"), põe as duas URLs de arquivo e o comentário na create_page, e devolve o
trecho no lugar. Nada fora dessas páginas é tocado; dentro delas, só a create_page. Página que já
tem o motor fica como está; página com OUTRA URL de arquivo para o script (juntar à mão).
No fim, confere: o arquivo fora das páginas da lista ficou igual byte a byte.
Guia: BENEFICIOSCONSULTA-MANUTENCAO.md. Molde: aplicar-consultas-app300.py.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f300.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA

PAGINAS = [89]
JS = '#WORKSPACE_IMAGES#Natcorp_BeneficiosConsulta.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_BeneficiosConsulta.css'
LINHAS = [
    'DESENHO DA TELA (Natcorp_BeneficiosConsulta.css / .js) - a consulta de beneficios, no jeito da janela Beneficios da Ficha',
    '',
    'Seus beneficios: um cartao por beneficio (as linhas do mesmo beneficio juntas), icone pelo tipo, valor grande,',
    'a conta quando ha mais de um lancamento, "Desde ..."; os que terminaram ficam recolhidos. Vale-transporte: um',
    'cartao por linha com a conta em palavras e o total do mes. Os dados sao lidos pelo titulo das colunas dos dois',
    'relatorios. Nada e gravado. Para desligar: tire as duas URLs de arquivo.',
    'Guia: brand/apex/app/BENEFICIOSCONSULTA-MANUTENCAO.md.',
]

s = open(ENTRADA, encoding='utf-8').read()
if 'p_default_application_id=>300\n' not in s or 'Export Type:     Application Export' not in s:
    sys.exit('este arquivo não é a exportação completa do app 300')


def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        return None
    return t[:m.end()] + linha + '\n' + t[m.end():]


def na_pagina(pg):
    if 'Natcorp_BeneficiosConsulta' in pg:
        return pg, 'já tinha'
    if re.search(r'^,p_(javascript|css)_file_urls=>', pg, re.M):
        sys.exit('a página já tem outra URL de arquivo: juntar à mão\n' + pg[:300])
    ancora = next(k for k in ('autocomplete_on_off', 'step_title', 'name') if re.search(r'^,?p_' + k + r'=>', pg, re.M))
    pg = poe(pg, ancora, ",p_javascript_file_urls=>'" + JS + "'")
    pg = poe(pg, 'javascript_file_urls', ",p_css_file_urls=>'" + CSS + "'")
    if not re.search(r'^,p_page_comment=>', pg, re.M):
        pg = poe(pg, 'css_file_urls', ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))')
    return pg, 'aplicado'


trechos = []
for n in PAGINAS:
    a = s.index('prompt --application/pages/page_%05d\n' % n)
    b = s.find('\nprompt --application/', a + 10)
    trechos.append((a, b, n))
saida, pos, relat = [], 0, []
for a, b, n in sorted(trechos):
    blk = s[a:b]
    m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', blk, re.S)
    novo, como = na_pagina(m.group(0))
    blk2 = blk[:m.start()] + novo + blk[m.end():]
    saida.append(s[pos:a]); saida.append(blk2); pos = b
    relat.append('%5d %s' % (n, como))
saida.append(s[pos:])
r = ''.join(saida)

# ---------- conferência: fora das páginas da lista, nada mudou ----------
def fora(t):
    partes, p0 = [], 0
    for n in sorted(PAGINAS, key=lambda n: t.index('prompt --application/pages/page_%05d\n' % n)):
        a = t.index('prompt --application/pages/page_%05d\n' % n); b = t.find('\nprompt --application/', a + 10)
        partes.append(t[p0:a]); p0 = b
    partes.append(t[p0:])
    return ''.join(partes)
if fora(r) != fora(s):
    sys.exit('ERRO: algo fora das páginas da lista mudou — nada foi gravado')
for m in re.finditer(r'wwv_flow_api\.(create_page)\(\n(.*?)\n\);', r, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido numa create_page')
open(SAIDA, 'w', encoding='utf-8').write(r)
print('\n'.join(relat))
print('ok → %s (%d páginas; fora delas, igual)' % (SAIDA, len(PAGINAS)))
