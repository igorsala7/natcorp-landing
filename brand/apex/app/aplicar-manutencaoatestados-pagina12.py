"""Aplica a MANUTENÇÃO DE ATESTADOS (Natcorp_ManutencaoAtestados.js/.css) numa EXPORTAÇÃO da página 12
do app 2937 (Manutenção de Atestados Médicos — onde o profissional de saúde lança os atestados).

    python3 aplicar-manutencaoatestados-pagina12.py f2937_page_12.sql [saida.sql]

Reconhece a página pelos itens P12_MATRICULA e P12_MENSAGEM e pela grade sobre ATESTADO_FUNCIONARIO.
O que muda (tudo visível no Page Designer): só as duas URLs de arquivo e o comentário da página. A
grade já é editável: regiões, colunas, itens, processos, validações e ações dinâmicas ficam como estão.
Roda de novo sem alterar duas vezes. Guia: MANUTENCAOATESTADOS-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2937_page_12.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_ManutencaoAtestados' in s

if "p_name=>'P12_MATRICULA'" not in s or "p_name=>'P12_MENSAGEM'" not in s or 'from atestado_funcionario' not in s:
    sys.exit('este arquivo não é a Manutenção de Atestados Médicos (itens P12_MATRICULA/P12_MENSAGEM e grade de atestados)')

JS = '#WORKSPACE_IMAGES#Natcorp_ManutencaoAtestados.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_ManutencaoAtestados.css'

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
    'DESENHO DA TELA (Natcorp_ManutencaoAtestados.css / Natcorp_ManutencaoAtestados.js)',
    '',
    'Para quem lança atestados: no alto a busca de sempre (Empresa, Matricula) e o cartao do colaborador (situacao,',
    'Desligado em vermelho, cargo, setor, local, sangue); um resumo (afastado hoje? dias afastado em 60 dias e 12 meses);',
    'os atestados em CARTOES por ano (tipo, periodo com dias, motivo, CID, medico, clinica, "Em vigor", "Sem termino").',
    '"Lancar atestado" e tocar num cartao abrem uma GAVETA com a ficha da propria grade (Single Row View), por assunto e',
    'com dicas: as listas, as contas dias/termino, a conferencia de ferias, as validacoes e o salvar sao os da pagina.',
    '"Tabela" mostra a grade original so para consultar. Para desligar: tire as duas URLs de arquivo.',
    'Guia: brand/apex/app/MANUTENCAOATESTADOS-MANUTENCAO.md.',
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
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_ManutencaoAtestados)')
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
print('ok (página 12 do app 2937' + (', só o comentário' if JA else '') + ') →', SAIDA)
