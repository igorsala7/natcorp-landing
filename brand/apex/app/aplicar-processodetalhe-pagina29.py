"""Aplica o NOVO DETALHE DO PROCESSO SELETIVO (Natcorp_ProcessoDetalhe.js/.css) numa EXPORTAÇÃO da
página 29 do app 9113 (Recrutamento e Seleção — "Descrição da Vaga", aberta da lista de processos, p28).

    python3 aplicar-processodetalhe-pagina29.py f9113_page_29.sql [saida.sql]

Reconhece a página pelo CONTEÚDO: os itens P29_REQUISICAO e P29_SELECTED_N e o relatório de static id
partnersIRR. O que muda (tudo visível no Page Designer): as duas URLs de arquivo e o comentário da página
— o nosso bloco entra NO ALTO; o que o time já guardava ali (o CSS antigo comentado) fica embaixo, igual.
NENHUM item, região, botão, ação dinâmica, processo ou consulta é tocado. Roda de novo sem alterar duas
vezes. Guia: PROCESSODETALHE-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f9113_page_29.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_ProcessoDetalhe' in s

if "p_name=>'P29_REQUISICAO'" not in s or "p_name=>'P29_SELECTED_N'" not in s or "p_region_name=>'partnersIRR'" not in s:
    sys.exit('este arquivo não é o detalhe do processo seletivo (itens P29_REQUISICAO/P29_SELECTED_N e relatório partnersIRR)')

JS = '#WORKSPACE_IMAGES#Natcorp_ProcessoDetalhe.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_ProcessoDetalhe.css'

FIM = '---- (fim do bloco Natcorp; abaixo, o comentário que a página já tinha) ----'
LINHAS = [
    'DESENHO DA TELA (Natcorp_ProcessoDetalhe.css / Natcorp_ProcessoDetalhe.js)',
    '',
    'No alto, a FICHA DA VAGA (lida da região "Descrição da Vaga", que sai da coluna lateral): situação,',
    'empresa, filial, centro de custo, selecionador, prazo com a contagem e os botões de sempre (Detalhes',
    'da Vaga, Requisição, Anotações, Processo Seletivo, Finalizar Processo). Depois, CANDIDATOS: o funil das',
    'etapas (lido dos cartões "por etapa"; tocar filtra a lista), a busca do relatório e uma LINHA por',
    'candidato (nome, idade, local, sinais, etapa, nota e atalhos CV/e-mail/WhatsApp/LinkedIn). A caixa',
    'de seleção APERTA a original (.checkbox_item): a página grava a seleção e "Mudar fase" vai para a',
    'barra que aparece com os selecionados. Lista | Tabela devolve o relatório original.',
    'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/PROCESSODETALHE-MANUTENCAO.md.',
    FIM,
]


def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]


def comentario(t):
    """o nosso bloco no alto do comentário; o que vinha depois do FIM (ou o comentário inteiro, na 1ª vez) fica"""
    m = re.search(r"^,p_page_comment=>wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n(.*?)\)\)\n", t, re.M | re.S)
    nosso = ',\n'.join(uni(l) for l in LINHAS)
    if not m:
        return poe(t, 'page_template_options', ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + nosso + '))')
    corpo = m.group(1)
    i = corpo.find(uni(FIM))
    resto = corpo[i + len(uni(FIM)):].lstrip(',\n') if i >= 0 else corpo
    novo = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + nosso + (',\n' + resto if resto else '') + '))\n'
    return t[:m.start()] + novo + t[m.end():]


def pagina(t):
    if re.search(r'^,p_(javascript|css)_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_ProcessoDetalhe)')
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
print('ok (página 29 do app 9113' + (', só o comentário' if JA else '') + ') →', SAIDA)
