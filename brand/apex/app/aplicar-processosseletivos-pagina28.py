"""Aplica a LISTA NOVA DE PROCESSOS SELETIVOS (Natcorp_ProcessosSeletivos.js/.css) numa EXPORTAÇÃO da
página 28 do app 9113 (Recrutamento e Seleção — "Relação de Vagas" / Processos Seletivos).

    python3 aplicar-processosseletivos-pagina28.py f9113_page_28.sql [saida.sql]

Reconhece a página pelo CONTEÚDO: os itens P28_ENVOLVIDO e P28_RELATORIO e a consulta sobre
PS_PROCESSO_SELETIVO. O que muda (tudo visível no Page Designer): as duas URLs de arquivo, o comentário
e as linhas por página do "Relatório de Vagas 1" (25 → 50: as linhas agora são compactas). NENHUM item,
região, botão, ação dinâmica, processo ou consulta é tocado. Roda de novo sem alterar duas vezes.
Guia: PROCESSOSSELETIVOS-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f9113_page_28.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_ProcessosSeletivos' in s

if "p_name=>'P28_ENVOLVIDO'" not in s or "p_name=>'P28_RELATORIO'" not in s or 'PS_PROCESSO_SELETIVO' not in s:
    sys.exit('este arquivo não é a página de Processos Seletivos (itens P28_ENVOLVIDO/P28_RELATORIO e consulta sobre PS_PROCESSO_SELETIVO)')

JS = '#WORKSPACE_IMAGES#Natcorp_ProcessosSeletivos.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_ProcessosSeletivos.css'

LINHAS_28 = [
    'DESENHO DA TELA (Natcorp_ProcessosSeletivos.css / Natcorp_ProcessosSeletivos.js)',
    '',
    'Uma LINHA por processo, em colunas: Vaga (cargo, número, empresa · filial · centro de custo) · Fase ·',
    'Candidatos · Selecionador · Prazo de contratação (com a contagem: vencido há N dias / faltam N dias) ·',
    'Situação; tocar abre o processo (página 29). No alto: o total, Minhas vagas | Todas as vagas e a Situação',
    'em botões de um toque, a busca (Enter) e Lista | Tabela. Filtros com título, Limpar e Pesquisar fixo.',
    'Só LÊ o relatório e escreve nos itens P28_* de sempre (o Pesquisar original). 50 linhas por página.',
    'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/PROCESSOSSELETIVOS-MANUTENCAO.md.',
]

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



LINHAS = LINHAS_28


def comentario(t):
    novo = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))\n'
    m = re.search(r"^,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)|'(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))\n", t, re.M | re.S)
    if m:
        return t[:m.start()] + novo + t[m.end():]
    ancora = next((k for k in ('help_text', 'protection_level', 'autocomplete_on_off') if re.search(r'^,p_' + k + r'=>', t, re.M)), 'name')
    return poe(t, ancora, novo.rstrip('\n'))


def pagina(t):
    if re.search(r'^,p_(javascript|css)_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_ProcessosSeletivos)')
    t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")
    t = poe(t, 'javascript_file_urls', ",p_css_file_urls=>'" + CSS + "'")
    return comentario(t)



m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + (comentario(m.group(0)) if JA else pagina(m.group(0))) + s[m.end():]

# ---------- 50 linhas por página no "Relatório de Vagas 1" (a lista) ----------
bl = re.search(r"wwv_flow_api\.create_report_region\(\n(?:(?!\n\);).)*?p_name=>unistr\('Relat\\00F3rio de Vagas 1'\).*?\n\);", s, re.S)
if not bl:
    sys.exit('não achei a região "Relatório de Vagas 1"')
if ',p_query_num_rows=>25\n' in bl.group(0):
    s = s[:bl.start()] + bl.group(0).replace(',p_query_num_rows=>25\n', ',p_query_num_rows=>50\n') + s[bl.end():]

# ---------- conferência: nenhum atributo repetido em nenhum bloco ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
fora = [l for l in s.split('\n') if re.match(r"^,?p_[a-z0-9_]+=>'", l) and any(ord(c) > 127 for c in l)]
if fora:
    sys.exit('texto com acento sem unistr: ' + fora[0][:80])
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok (página 28 do app 9113' + (', só o comentário' if JA else '') + ') →', SAIDA)
