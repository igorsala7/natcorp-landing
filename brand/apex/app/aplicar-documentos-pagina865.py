"""Aplica o desenho da Consulta de Documentos numa EXPORTAÇÃO da página 865 do app 2210 (CONS_GED).

    python3 aplicar-documentos-pagina865.py f2210_page_865.sql [saida.sql]

Acha tudo pelos NOMES (títulos das regiões), nunca pelos números: cada base instala o app com IDs
internos próprios, e uma exportação de página só entra no mesmo app de onde saiu. Exporte do
ambiente onde vai importar.

O que muda (tudo visível no Page Designer; nenhuma validação, processo, ação dinâmica, botão,
item ou relatório é tocado):
  · a classe nc-ged-docs nas quatro regiões de documentos (Colaborador, Candidato, Terceiro,
    Outros — o APEX mostra só a do P865_TIPO);
  · as URLs dos arquivos e o comentário da página.
O CSS em linha da página (#PARAMETROS) fica como está. O botão Adicionar continua o mesmo (o JS só
o traz para o alto, dentro da mesma região: as ações "… Dialog Closed" continuam valendo).
Roda de novo sobre um arquivo já alterado: não altera duas vezes.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2210_page_865.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if 'Natcorp_Documentos' in s:
    sys.exit('este arquivo já tem o desenho aplicado (Natcorp_Documentos já está na página)')
if not re.search(r'wwv_flow_api\.create_page\(\n p_id=>865\n', s) or "p_name=>'P865_TIPO'" not in s:
    sys.exit('este arquivo não é a página 865 do app de documentos (CONS_GED)')


def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def texto(lit):
    lit = lit.strip()
    m = re.match(r"^unistr\('(.*)'\)$", lit) or re.match(r"^'(.*)'$", lit)
    if not m:
        return lit
    t = m.group(1).replace("''", "'")
    return re.sub(r'\\([0-9A-F]{4})', lambda x: chr(int(x.group(1), 16)), t) if lit.startswith('unistr') else t


def blocos(fn):
    return list(re.finditer(r'wwv_flow_api\.' + fn + r'\(\n.*?\n\);\n', s, re.S))


def attr(t, k):
    m = re.search(r'^,?p_' + k + r'=>(.*)$', t, re.M)
    return m.group(1) if m else ''


def id_de(t):
    return re.search(r'p_id=>(wwv_flow_api\.id\(\d+\))', t).group(1)


def por(t, chave, linha):
    m = re.search(r'^(,?)p_' + chave + r'=>.*$', t, re.M)
    return t[:m.start()] + m.group(1) + linha + t[m.end():]


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]


def mais_classe(t, cls, depois_de):
    m = re.search(r"^,p_region_css_classes=>'([^']*)'\s*$", t, re.M)
    if m:
        atuais = m.group(1).split()
        novas = [c for c in cls.split() if c not in atuais]
        return t if not novas else por(t, 'region_css_classes', "p_region_css_classes=>'" + ' '.join(atuais + novas) + "'")
    return poe(t, depois_de, ",p_region_css_classes=>'" + cls + "'")


# ---------- regiões: comum e relatório ----------
TIPOS = ('create_page_plug', 'create_report_region')


def todas():
    return [m for fn in TIPOS for m in blocos(fn)]


def ancora(t):
    return 'plug_name' if re.search(r'^,p_plug_name=>', t, re.M) else 'name'


def nome_de(t):
    return re.sub(r'<span[^>]*>.*?</span>', '', texto(attr(t, 'plug_name') or attr(t, 'name'))).strip()


def classe_em(nome, cls):
    """a região de título `nome` (texto exato ou expressão regular) — tem de existir uma só,
    no nome exato"""
    global s
    achadas = [m for m in todas() if (nome.match(nome_de(m.group(0))) if hasattr(nome, 'match') else nome_de(m.group(0)) == nome)]
    if len(achadas) != 1:
        sys.exit('esperava uma região "%s", achei %d' % (getattr(nome, 'pattern', nome), len(achadas)))
    m = achadas[0]
    t = mais_classe(m.group(0), cls, ancora(m.group(0)))
    s = s[:m.start()] + t + s[m.end():]


# regiões que podem faltar numa cópia da página (ex.: a 863 do app 300 não tem Terceiro/Outros):
# NC_REGIOES_OPCIONAIS="A|B", posto pelo aplicar-redesenhos-app300.py
import os
OPCIONAIS = set(filter(None, os.environ.get('NC_REGIOES_OPCIONAIS', '').split('|')))
for regiao in ('Documentos Colaborador', 'Documentos Candidato', 'Documentos Terceiro', 'Documentos Outros'):
    if regiao in OPCIONAIS and not any(nome_de(m.group(0)) == regiao for m in todas()):
        continue
    classe_em(regiao, 'nc-ged-docs')                      # a pasta: abas por assunto, cartões, versões


# ---------- arquivos e comentário da página ----------
JS = '#WORKSPACE_IMAGES#Natcorp_Documentos.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Documentos.css'


def mais_js(t):
    """acrescenta o nosso JS no FIM da lista que a página já tem (ou cria a lista)"""
    m = re.search(r"^,p_javascript_file_urls=>wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n(.*?)\)\)\n", t, re.M | re.S)
    if m:
        return t[:m.end(1)] + ",\n'" + JS + "'" + t[m.end(1):]
    m = re.search(r"^,p_javascript_file_urls=>'([^']*)'\n", t, re.M)
    if m:
        return t[:m.start()] + ",p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'" + m.group(1) + "',\n'" + JS + "'))\n" + t[m.end():]
    return poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")


def pagina(t):
    if re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_Documentos)')
    t = mais_js(t)
    t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'" + CSS + "'")
    linhas = [
        'DESENHO DA TELA (Natcorp_Documentos.css / Natcorp_Documentos.js)',
        '',
        'A estrutura é toda do APEX. O CSS/JS só muda o DESENHO das regiões com a classe',
        '  nc-ged-docs  Documentos Colaborador / Candidato / Terceiro / Outros: a PASTA da pessoa —',
        '               abas por assunto (tirado do nome do documento e do tipo de sub-item), um',
        '               cartão por documento com as versões (Sequência) dentro, dependentes por',
        '               pessoa, "Mais recentes" por mês e a tabela original a um clique.',
        '"Ver" e "Editar" clicam nos links originais da linha; "Adicionar" é o botão do APEX.',
        '',
        'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
        'Guia: brand/apex/app/DOCUMENTOS-MANUTENCAO.md.',
    ]
    return poe(t, 'help_text', ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in linhas) + '))') \
        if not re.search(r'^,p_page_comment=>', t, re.M) else t


m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + pagina(m.group(0)) + s[m.end():]

# ---------- conferência ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
fora = [l for l in s.split('\n') if re.match(r"^,?p_(plug_name|name|region_css_classes|page_comment)=>'", l) and any(ord(c) > 127 for c in l)]
if fora:
    sys.exit('texto com acento sem unistr: ' + fora[0][:80])
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok →', SAIDA)
