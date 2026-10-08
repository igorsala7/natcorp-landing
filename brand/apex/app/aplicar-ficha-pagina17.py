"""Aplica o desenho da ficha do colaborador (Dados Funcionais) numa EXPORTAÇÃO da página 17 do app 200.

    python3 aplicar-ficha-pagina17.py f200_page_17.sql [saida.sql]

Acha tudo pelos NOMES (títulos das regiões), nunca pelos números: cada base instala o app com IDs
internos próprios (as duas bases do app 200 diferem por um deslocamento fixo), e uma exportação de
página só entra no mesmo app de onde saiu. Exporte do ambiente onde vai importar.

O que muda (tudo visível no Page Designer; nenhuma validação, processo, ação dinâmica, botão,
item ou relatório é tocado):
  · classes nc-df-* em três regiões (o contrato com o Natcorp_Ficha.css/.js);
  · as URLs dos arquivos e o comentário da página.
O CSS em linha da página (#BTN_BENEFICIOS, #BTTPVINC, #BTDUPVINC) fica como está. As abas,
os relatórios e os itens continuam no APEX; o perfil, a navegação e os cartões são desenho do JS.
Roda de novo sobre um arquivo já alterado: não altera duas vezes.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f200_page_17.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if 'Natcorp_Ficha' in s:
    sys.exit('este arquivo já tem o desenho aplicado (Natcorp_Ficha já está na página)')
if not re.search(r'wwv_flow_api\.create_page\(\n p_id=>17\n', s) or 'p_default_application_id=>200' not in s:
    sys.exit('este arquivo não é a página 17 do app 200')


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
    # (04/10) a cópia da página em outro app pode não ter a região ou tê-la com outro nome:
    # NC_REGIOES_OPCIONAIS="A|B" (falta = segue) e NC_REGIOES_ALIAS="Nome=Outro nome|…" — só o
    # aplicar-redesenhos-app300.py liga; sem as variáveis, o script é o de sempre (exato)
    import os as _os
    alias = dict(x.split('=', 1) for x in _os.environ.get('NC_REGIOES_ALIAS', '').split('|') if '=' in x)
    alvo = alias.get(nome, nome) if isinstance(nome, str) else nome
    achadas = [m for m in todas() if (alvo.match(nome_de(m.group(0))) if hasattr(alvo, 'match') else nome_de(m.group(0)) == alvo)]
    if not achadas and isinstance(nome, str) and nome in _os.environ.get('NC_REGIOES_OPCIONAIS', '').split('|'):
        return
    if len(achadas) != 1:
        sys.exit('esperava uma região "%s", achei %d' % (getattr(nome, 'pattern', nome), len(achadas)))
    m = achadas[0]
    t = mais_classe(m.group(0), cls, ancora(m.group(0)))
    s = s[:m.start()] + t + s[m.end():]


classe_em('Colaborador', 'nc-df-colaborador')              # o alto: foto, nome, situação, fatos e as ações
classe_em('Informações', 'nc-df-info')                     # as abas: viram navegação lateral e seções por assunto
classe_em('Benefícios Relatório', 'nc-df-beneficios')      # na janela Benefícios: cartões por grupo, todas as linhas


# ---------- arquivos e comentário da página ----------
JS = '#WORKSPACE_IMAGES#Natcorp_Ficha.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Ficha.css'


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
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_Ficha)')
    t = mais_js(t)
    t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'" + CSS + "'")
    linhas = [
        'DESENHO DA TELA (Natcorp_Ficha.css / Natcorp_Ficha.js)',
        '',
        'A estrutura é toda do APEX. O CSS/JS só muda o DESENHO de quem tem uma destas classes:',
        '  nc-df-colaborador  Colaborador: o alto (faixa da marca, foto, nome, situação, 6 fatos e as',
        '                     ações da página, que continuam sendo os botões do APEX).',
        '  nc-df-info         Informações: as abas viram navegação lateral (com busca "/") e seções',
        '                     por assunto; Dependentes em cartões, Ocorrências em linha do tempo, com a',
        '                     tabela original a um clique.',
        '  nc-df-beneficios   Benefícios Relatório (janela Benefícios): cartões por grupo, com todas',
        '                     as linhas (o relatório vinha de 15 em 15).',
        '',
        'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
        'Guia: brand/apex/app/FICHA-MANUTENCAO.md.',
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
