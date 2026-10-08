"""Aplica o desenho da Requisição de Desligamento numa EXPORTAÇÃO da página 59 do app 200.

    python3 aplicar-desligamento-pagina59.py f200_page_59.sql [saida.sql]

Acha tudo pelos NOMES (títulos das regiões), nunca pelos números: cada base e cada release
instalam o app com IDs internos próprios (as duas bases do app 200 diferem por um deslocamento
fixo), e uma exportação de página só entra no mesmo app de onde saiu. Exporte do ambiente onde
vai importar.

O que muda (tudo visível no Page Designer; nenhuma validação, processo, ação dinâmica, botão,
item ou lista de valores é tocado):
  · classes nc-desl-* em cinco regiões (o contrato com o Natcorp_Desligamento.css/.js);
  · as URLs dos arquivos e o comentário da página.
Nada é renomeado, reordenado ou escondido no APEX: as mudanças de lugar são só na tela, feitas
pelo JS, com os mesmos elementos. Roda de novo sobre um arquivo já alterado: não altera duas
vezes (para no primeiro sinal).
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f200_page_59.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
# (01/10) já não para quando acha o Natcorp_Desligamento: completa o que faltar — URLs, as
# cinco classes, o comentário — e não repete o que já está. Rodar de novo não muda nada.
ORIGINAL = s
if not re.search(r'wwv_flow_api\.create_page\(\n p_id=>59\n', s) or 'p_default_application_id=>200' not in s:
    sys.exit('este arquivo não é a página 59 do app 200')


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
    fora das janelas (Relatórios, Carta de Demissão)"""
    global s
    achadas = [m for m in todas() if (nome.match(nome_de(m.group(0))) if hasattr(nome, 'match') else nome_de(m.group(0)) == nome)]
    if len(achadas) != 1:
        sys.exit('esperava uma região "%s", achei %d' % (getattr(nome, 'pattern', nome), len(achadas)))
    m = achadas[0]
    t = mais_classe(m.group(0), cls, ancora(m.group(0)))
    s = s[:m.start()] + t + s[m.end():]


classe_em('&P59_TITULO.', 'nc-desl-solicitacao')     # número, situação, abertura e solicitante
classe_em('Colaborador Solicitado', 'nc-desl-perfil')
classe_em('Aprovadores', 'nc-desl-aprovadores')
classe_em('Informações para Desligamento', 'nc-desl-form')
classe_em('Botões', 'nc-desl-acoes')                  # Voltar / Criar / Salvar


# ---------- arquivos e comentário da página ----------
def url_em(t, campo, url):
    """a URL no campo de arquivos da página: acrescenta às que já houver, sem repetir"""
    if url in t:
        return t
    m = re.search(r"^,p_" + campo + r"=>(?:'([^']*)'|wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n(.*?)\)\))$", t, re.M | re.S)
    if not m:
        return poe(t, 'autocomplete_on_off', ",p_" + campo + "=>'" + url + "'")
    atuais = [m.group(1)] if m.group(1) is not None else re.findall(r"'([^']*)'", m.group(2))
    lista = atuais + [url]
    novo = ",p_" + campo + "=>wwv_flow_string.join(wwv_flow_t_varchar2(\n" + ',\n'.join("'" + u + "'" for u in lista) + "))"
    return t[:m.start()] + novo + t[m.end():]


def pagina(t):
    t = url_em(t, 'javascript_file_urls', '#WORKSPACE_IMAGES#Natcorp_Desligamento.js')
    t = url_em(t, 'css_file_urls', '#WORKSPACE_IMAGES#Natcorp_Desligamento.css')
    linhas = [
        'DESENHO DA TELA (Natcorp_Desligamento.css / Natcorp_Desligamento.js, em Arquivos desta página)',
        '',
        'A estrutura é toda do APEX. O CSS/JS só muda o DESENHO de quem tem uma destas classes:',
        '  nc-desl-solicitacao  &P59_TITULO.: vira a ficha da requisição (nº, abertura, situação, quem pediu).',
        '  nc-desl-perfil       Colaborador Solicitado: foto, nome, tempo de casa e os fatos do contrato.',
        '  nc-desl-aprovadores  Aprovadores: faixa horizontal do caminho da aprovação.',
        '  nc-desl-form         Informações para Desligamento: os campos em seções, NA ORDEM DO APEX',
        '                       (cada seção começa num campo-marco: Situação, Data de Comunicação,',
        '                       Haverá Reposição, Justificativa) e o bloco da carta.',
        '  nc-desl-acoes        Botões: barra fixa no rodapé, com o que falta preencher.',
        '',
        'Botões e campos são os do APEX: só mudam de lugar na tela e continuam com as mesmas ações',
        'dinâmicas. O desenho não esconde nem trava nada que a página mostre, e o que a página esconde',
        'continua escondido. Para desligar tudo: tire as duas URLs de arquivo.',
        'Guia: brand/apex/app/DESLIGAMENTO-MANUTENCAO.md.',
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
if s == ORIGINAL:
    print('nada a mudar: o desenho já está todo aplicado em', ENTRADA)
else:
    open(SAIDA, 'w', encoding='utf-8').write(s)
    print('ok →', SAIDA)
