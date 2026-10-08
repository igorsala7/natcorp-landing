"""Aplica o desenho da Indicação de Curso numa EXPORTAÇÃO da página 126 do app 200.

A página 126 usa os MESMOS arquivos da 118 e da 120 (Natcorp_Treinamento.css/.js): o JS reconhece
a indicação pelos ITENS (Motivo da Indicação + Curso Existente?).

    python3 aplicar-treinamento-pagina126.py f200_page_126.sql [saida.sql]

Acha tudo pelos NOMES (títulos das regiões e dos itens), nunca pelos números: cada base e cada
release instalam o app com IDs internos próprios. Exporte do ambiente onde vai importar.

O que muda (tudo visível no Page Designer; nenhuma validação, processo, ação dinâmica, botão,
item ou lista de valores é tocado):
  · classes nc-tre-* em cinco regiões (o contrato com o Natcorp_Treinamento.css/.js);
  · as URLs dos arquivos e o comentário da página.
"Curso Existente?" continua a lista do APEX (a tela mostra dois cartões que a escolhem); "Criar"
continua CREATE (a tela mostra "Enviar indicação") — o foco nele segue disparando as ações da
página (nº da indicação, aprovadores). Roda de novo sobre um arquivo já alterado: não altera duas vezes.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f200_page_126.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if 'Natcorp_Treinamento' in s:
    sys.exit('este arquivo já tem o desenho aplicado (Natcorp_Treinamento já está na página)')
PAG = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s)
PAG = PAG and PAG.group(1)
if not PAG or ("p_name=>'P%s_MOTIVO_INDICACAO'" % PAG) not in s or ("p_name=>'P%s_CURSO_EXISTENTE'" % PAG) not in s:
    sys.exit('este arquivo não é a página da Indicação de Curso (itens MOTIVO_INDICACAO e CURSO_EXISTENTE)')


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


classe_em('&P%s_TITULO.' % PAG, 'nc-tre-solicitacao')  # nº, data, situação e solicitante: vai para o alto
classe_em('Aprovadores', 'nc-tre-aprovadores')          # a faixa da aprovação (Aprovar/Reprovar entram nela)
classe_em('Solicitado', 'nc-tre-colaborador')           # ① Quem você está indicando?
classe_em('Curso', 'nc-tre-curso')                      # ② Para qual curso? ③ Por quê? ④ Quem oferece
classe_em('Botões', 'nc-tre-acoes')                     # Voltar / Criar / Salvar: barra no rodapé


# ---------- arquivos e comentário da página ----------
JS = '#WORKSPACE_IMAGES#Natcorp_Treinamento.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Treinamento.css'


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
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_Treinamento)')
    t = mais_js(t)
    t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'" + CSS + "'")
    linhas = [
        'DESENHO DA TELA (Natcorp_Treinamento.css / Natcorp_Treinamento.js, os mesmos das páginas 118 e 120)',
        '',
        'A estrutura é toda do APEX. O CSS/JS só muda o DESENHO de quem tem uma destas classes:',
        '  nc-tre-solicitacao  &P%s_TITULO.: nº, data e quem indicou no alto; a Situação vai para o canto.' % PAG,
        '  nc-tre-aprovadores  Aprovadores: a faixa da aprovação, com Aprovar/Reprovar.',
        '  nc-tre-colaborador  Solicitado: "Quem você está indicando?".',
        '  nc-tre-curso        Curso: "Para qual curso?" (Curso existente? em dois cartões; a lista',
        '                      continua lá, fora da vista; o tipo em botões), "Por que você está',
        '                      indicando?" (Motivo) e "Quem oferece o curso" (curso novo).',
        '                      Indicação gravada (tudo travado): o cartão do curso.',
        '  nc-tre-acoes        Botões: barra fixa no rodapé, com o que falta preencher.',
        '',
        'Os itens são os do APEX, com as mesmas ações dinâmicas. Para desligar tudo: tire as duas URLs',
        'de arquivo. Guia: brand/apex/app/TREINAMENTO-MANUTENCAO.md.',
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
