"""Aplica o desenho da Avaliação de desempenho numa EXPORTAÇÃO da página 140 ou 144 do app 9118.

    python3 aplicar-avaliacao.py f9118_page_140.sql [saida.sql]
    python3 aplicar-avaliacao.py f9118_page_144.sql [saida.sql]

O script reconhece qual das duas páginas é. Acha tudo pelos NOMES (títulos das regiões), nunca
pelos números: cada base instala o app com IDs internos próprios, e uma exportação de página só
entra no mesmo app de onde saiu. Exporte do ambiente onde vai importar.

O que muda (tudo visível no Page Designer; nenhuma validação, processo, ação dinâmica, botão,
item ou relatório é tocado):
  · classes nc-av-* nas regiões (o contrato com o Natcorp_Avaliacao.css/.js — os MESMOS arquivos
    nas duas páginas);
  · as URLs dos dois arquivos e o comentário da página.
O CSS/JS em linha que as páginas já têm fica como está. Roda de novo sobre um arquivo já
alterado: não altera duas vezes.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f9118_page_140.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if 'Natcorp_Avaliacao' in s:
    sys.exit('este arquivo já tem o desenho aplicado (Natcorp_Avaliacao já está na página)')
if re.search(r'wwv_flow_api\.create_page\(\n p_id=>140\n', s) and "p_name=>'P140_COD_AVALIACAO'" in s:
    PAG = 140
elif re.search(r'wwv_flow_api\.create_page\(\n p_id=>144\n', s) and "p_name=>'P144_ORDEM_COUNT'" in s:
    PAG = 144
else:
    sys.exit('este arquivo não é a página 140 nem a 144 da avaliação (app 9118)')


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


if PAG == 140:
    classe_em('Botões', 'nc-av-acoes')                      # Salvar vai para a barra de baixo, Deletar para o fim
    classe_em('Avaliação', 'nc-av-dados')                   # na criação é o passo 1; travado, vira fatos no alto
    classe_em('Relatórios', 'nc-av-relatorios')             # Ficha de Registro, Comitê, Avaliação: "Imprimir" no alto
    classe_em('Resultado', 'nc-av-resultado')               # os três números lado a lado
    classe_em('Questões', 'nc-av-questoes')                 # resumo por competência + perguntas em cartões/linhas
    classe_em('Plano de Desenvolvimento', 'nc-av-plano')    # o PDI em três blocos
    classe_em('Feedback', 'nc-av-feedback')                 # etapa no alto
    classe_em('Comentário', 'nc-av-comentario')             # a conversa avaliador / avaliado / examinador
    classe_em('Conclusão', 'nc-av-conclusao')               # o fecho
else:
    classe_em('&P144_TITULO.', 'nc-av-pergunta')             # progresso, competência, a pergunta em letra grande
    classe_em('Respostas', 'nc-av-respostas')               # as opções em cartões de toque / a resposta escrita


# ---------- arquivos e comentário da página ----------
JS = '#WORKSPACE_IMAGES#Natcorp_Avaliacao.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Avaliacao.css'


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
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_Avaliacao)')
    t = mais_js(t)
    t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'" + CSS + "'")
    if PAG == 140:
        linhas = [
            'DESENHO DA TELA (Natcorp_Avaliacao.css / Natcorp_Avaliacao.js, os mesmos da página 144)',
            '',
            'A estrutura é toda do APEX. O CSS/JS só muda o DESENHO de quem tem uma destas classes:',
            '  nc-av-acoes        Botões: Salvar numa barra fixa embaixo; Deletar no fim da página.',
            '  nc-av-dados        Avaliação: passo 1 na criação; travado, vira fatos no alto.',
            '  nc-av-relatorios   Relatórios: os botões de impressão vão para o alto.',
            '  nc-av-resultado    Resultado: os três números lado a lado.',
            '  nc-av-questoes     Questões: média por competência, distribuição das respostas e as',
            '                     perguntas em cartões (celular) ou linhas (computador).',
            '  nc-av-plano        Plano de Desenvolvimento: PDI em três blocos.',
            '  nc-av-feedback     Feedback: etapa no alto.',
            '  nc-av-comentario   Comentário: conversa entre avaliador, avaliado e examinador.',
            '  nc-av-conclusao    Conclusão.',
            'A região Avaliado (COLABORADOR) vira o perfil da pessoa pelo próprio JS. Empresa e',
            'Matrícula do avaliado continuam com as ações dinâmicas da página.',
            '',
            'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
            'Guia: brand/apex/app/AVALIACAO-MANUTENCAO.md.',
        ]
    else:
        linhas = [
            'DESENHO DA TELA (Natcorp_Avaliacao.css / Natcorp_Avaliacao.js, os mesmos da página 140)',
            '',
            'A estrutura é toda do APEX. O CSS/JS só muda o DESENHO de quem tem uma destas classes:',
            '  nc-av-pergunta     &P144_TITULO.: progresso, competência e a pergunta em letra grande.',
            '  nc-av-respostas    Respostas: as opções em cartões de toque; a resposta escrita.',
            'Os botões do rodapé ganham rótulo (Anterior, Próxima, Voltar à lista / Concluir); as',
            'ações dinâmicas (gravar ao escolher, VALIDAR_FECHAMENTO, "Indique uma ação") são as mesmas.',
            '',
            'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
            'Guia: brand/apex/app/AVALIACAO-MANUTENCAO.md.',
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
