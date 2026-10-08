"""Aplica o desenho da Requisição de Alteração Cadastral numa EXPORTAÇÃO da página 136 do app 200
(Painel do Operador) ou do app 300 (Portal do Colaborador — a mesma página, sem PIX/estrangeiro).

    python3 aplicar-cadastro-pagina136.py f200_page_136.sql [saida.sql]
    python3 aplicar-cadastro-pagina136.py f300_page_136.sql [saida.sql]

Acha tudo pelos NOMES (títulos das regiões), nunca pelos números: cada base e cada release
instalam o app com IDs internos próprios (as duas bases do app 200 diferem por um deslocamento
fixo), e uma exportação de página só entra no mesmo app de onde saiu. Exporte do ambiente onde
vai importar.

O que muda (tudo visível no Page Designer; nenhuma validação, processo, ação dinâmica, botão,
item ou lista de valores é tocado):
  · classes nc-cad-* nas regiões (o contrato com o Natcorp_Cadastro.css/.js);
  · as URLs dos arquivos e o comentário da página.
Nada é renomeado, reordenado ou escondido no APEX: os cartões, a lista de comprovantes e a barra
de baixo são desenho do JS sobre os mesmos elementos. O botão Criar continua se chamando Criar no
APEX (a tela mostra "Enviar pedido"). Roda de novo sobre um arquivo já alterado: não altera duas
vezes (para no primeiro sinal).
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f200_page_136.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if 'Natcorp_Cadastro' in s:
    sys.exit('este arquivo já tem o desenho aplicado (Natcorp_Cadastro já está na página)')
if not re.search(r'wwv_flow_api\.create_page\(\n p_id=>136\n', s) or not re.search(r'p_default_application_id=>(200|300)\n', s):
    sys.exit('este arquivo não é a página 136 do app 200 nem do 300')


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


classe_em('Colaborador', 'nc-cad-colaborador')            # empresa, matrícula, foto e dados de hoje
classe_em('&P136_TITULO.', 'nc-cad-solicitacao')        # nº, data e solicitante: vai para o alto
classe_em('Seletor', 'nc-cad-seletor')                  # as abas antigas: saem da tela (os cartões substituem)
classe_em('Documentos (Upload)', 'nc-cad-anexos')       # comprovantes: a lista do que anexar
classe_em('Botões', 'nc-cad-acoes')                     # Voltar / Criar / Salvar / Deletar: barra no rodapé

# cada bloco de dados com o seu assunto (o cartão "O que você quer atualizar?" que o abre)
TEMAS = {
    'endereco': ['Endereço'], 'contato': ['Contato'], 'banco': ['Dados Bancários'],
    'pessoais': ['Dados Pessoais'], 'familia': ['Dados da Mãe', 'Dados do Pai', 'Dados do Conjuge'],
    'estudo': ['Formação / Escolaridade'],
    'documentos': ['Identidade', 'CPF', 'Reservista', 'Título de Eleitor', 'Carteira Nacional de Habilitação',
                   'PIS / PASEP', 'Carteira Profissional', 'Habilitação Profissional'],
    'uniforme': ['Medidas'], 'deficiencia': ['Portador de Necessidades'],
}
for tema, nomes in TEMAS.items():
    for n in nomes:
        classe_em(n, 'nc-cad-tema-' + tema)


# ---------- arquivos e comentário da página ----------
def pagina(t):
    if re.search(r'^,p_javascript_file_urls=>', t, re.M) or re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem URLs de arquivo: junte à mão (acrescente as duas do Natcorp_Cadastro)')
    t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Cadastro.js'")
    t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Cadastro.css'")
    linhas = [
        'DESENHO DA TELA (Natcorp_Cadastro.css / Natcorp_Cadastro.js, em Arquivos desta página)',
        '',
        'A estrutura é toda do APEX. O CSS/JS só muda o DESENHO de quem tem uma destas classes:',
        '  nc-cad-colaborador  Colaborador: de quem são os dados.',
        '  nc-cad-solicitacao  &P136_TITULO.: nº, data e solicitante, no alto.',
        '  nc-cad-seletor      Seletor: sai da tela; os cartões "O que você quer atualizar?" abrem os blocos.',
        '  nc-cad-tema-XXX     cada bloco de dados, com o seu assunto (endereco, contato, banco, pessoais,',
        '                      familia, estudo, documentos, uniforme, deficiencia).',
        '  nc-cad-anexos       Documentos (Upload): a lista dos comprovantes pedidos pelo que mudou.',
        '  nc-cad-acoes        Botões: barra fixa no rodapé, com o que falta.',
        '',
        'Os campos são os do APEX, com as mesmas ações dinâmicas. Bloco sem nc-cad-tema-* continua',
        'onde estava. Bloco novo: dê a ele uma classe nc-cad-tema-XXX existente (ou peça um tema novo).',
        'Para desligar tudo: tire as duas URLs de arquivo. Guia: brand/apex/app/CADASTRO-MANUTENCAO.md.',
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
