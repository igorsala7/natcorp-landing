"""Aplica o desenho da Comunicação de Acidente numa EXPORTAÇÃO das páginas do app 2943
(SEG_CTRL_NATCORP): 91 (Comunicação de Acidente/Incidente — quem comunica), 31 (Comunicação de
Acidente de Trabalho — a análise do Médico do Trabalho / Técnico de Segurança) ou 92 (a janela
Parte do Corpo Atingida).

    python3 aplicar-acidente.py f2943_page_91.sql [saida.sql]
    python3 aplicar-acidente.py f2943_page_31.sql [saida.sql]
    python3 aplicar-acidente.py f2943_page_92.sql [saida.sql]

O script reconhece a página pelos ITENS (nunca pelos IDs). O que muda — tudo visível no Page
Designer; nenhuma validação, processo, ação dinâmica, botão, item ou relatório é tocado:
  · a URL do Natcorp_Acidente.js no FIM da lista de JavaScript que a página já tem;
  · a URL do Natcorp_Acidente.css;
  · o comentário da página (o que o desenho faz e como desligar).
Os mesmos dois arquivos servem às três páginas: o .js reconhece qual é pelos itens. Roda de
novo sobre um arquivo já alterado: não altera duas vezes.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2943_page_91.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
if 'Natcorp_Acidente' in s:
    sys.exit('este arquivo já tem o desenho aplicado (Natcorp_Acidente já está na página)')

pag = re.search(r'wwv_flow_api\.create_page\(\n p_id=>(\d+)\n', s)
pag = pag and pag.group(1)
# a 91 é cópia da 31 e ainda carrega o Diagnóstico (numa região "NEVER"): o que só a 31 tem é o
# "Médico que atendeu" (COD_MED_EMIT_CAT_1)
if pag and ("p_name=>'P%s_COD_MED_EMIT_CAT_1'" % pag) in s and ("p_name=>'P%s_ESPEC_LOCAL_ACIDENTE'" % pag) in s:
    QUAL = 'analise'
elif pag and ("p_name=>'P%s_ESPEC_LOCAL_ACIDENTE'" % pag) in s and ("p_name=>'P%s_DESCRICAO_TEXTO'" % pag) in s:
    QUAL = 'comunicacao'
elif pag and ("p_name=>'P%s_COD_PARTE_LESADA'" % pag) in s and ("p_name=>'P%s_LATERALIDADE'" % pag) in s:
    QUAL = 'parte'
else:
    sys.exit('este arquivo não é a página de comunicação (91), de análise (31) nem da parte do corpo (92)')

JS = '#WORKSPACE_IMAGES#Natcorp_Acidente.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Acidente.css'


def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]


def mais_js(t):
    """acrescenta o nosso JS no FIM da lista que a página já tem (ou cria a lista)"""
    m = re.search(r"^,p_javascript_file_urls=>wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n(.*?)\)\)\n", t, re.M | re.S)
    if m:
        return t[:m.end(1)] + ",\n'" + JS + "'" + t[m.end(1):]
    m = re.search(r"^,p_javascript_file_urls=>'([^']*)'\n", t, re.M)
    if m:
        return t[:m.start()] + ",p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'" + m.group(1) + "',\n'" + JS + "'))\n" + t[m.end():]
    return poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")


LINHAS = {
    'comunicacao': [
        'DESENHO DA TELA (Natcorp_Acidente.css / Natcorp_Acidente.js — os mesmos das páginas 31 e 92)',
        '',
        'A estrutura é toda do APEX; o .js só reorganiza a leitura (sem classe no APEX):',
        '  Pedido novo: 6 passos (quem, quando, onde, parte do corpo, o que aconteceu, atendimento',
        '  e registros), atalhos de data, "Me ajude a contar", o rodapé com o que falta e, no fim,',
        '  "Confira antes de enviar" (a ficha como quem analisa vai ver). "Criar" = "Enviar comunicação".',
        '  Comunicação gravada: cabeçalho (nº, situação) com o Caracterização CAT, a ficha do acidente',
        '  (figura do corpo, relato, sinais), todos os dados em leitura e a aprovação.',
        'O Adicionar da parte do corpo espera o colaborador e a data (a página só monta o endereço da',
        'janela no change da data); se o colaborador mudar depois, o .js redispara o change da data.',
        '',
        'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
        'Guia: brand/apex/app/ACIDENTE-MANUTENCAO.md.',
    ],
    'analise': [
        'DESENHO DA TELA (Natcorp_Acidente.css / Natcorp_Acidente.js — os mesmos das páginas 91 e 92)',
        '',
        'A estrutura é toda do APEX; o .js só reorganiza a leitura (sem classe no APEX):',
        '  o caso fixo à esquerda (pessoa, quando, onde, parte do corpo, relato, sinais) e quatro',
        '  frentes no lugar das abas: Atendimento médico, Classificação da CAT, Acidente e local,',
        '  Investigação (com índice das seções). Só entra numa frente a aba que o perfil deixou à',
        '  vista. Listas curtas viram botões; as grades (IG) ficam com "Adicionar …" e "Salvar lista";',
        '  a barra do pé mostra os obrigatórios que faltam e o Salvar (também Ctrl+S).',
        '  Acidente NOVO (aberto pelo Criar): "Acidente e local" vem primeiro, o caso ao lado vira guia',
        '  (o que falta, e cada linha leva ao campo), sem situação nem PDFs; "Criar comunicação" na barra.',
        '',
        'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
        'Guia: brand/apex/app/ACIDENTE-MANUTENCAO.md.',
    ],
    'parte': [
        'DESENHO DA TELA (Natcorp_Acidente.css / Natcorp_Acidente.js — os mesmos das páginas 91 e 31)',
        '',
        'O lado vira quatro botões (a lista Lateralidade continua, escondida, e é a enviada) e a',
        'figura do corpo marca a parte enquanto se escolhe. "Criar" aparece como "Adicionar parte".',
        '',
        'Nada é gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.',
        'Guia: brand/apex/app/ACIDENTE-MANUTENCAO.md.',
    ],
}


def pagina(t):
    if re.search(r'^,p_css_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de CSS: junte à mão (acrescente a do Natcorp_Acidente)')
    t = mais_js(t)
    t = poe(t, 'autocomplete_on_off', ",p_css_file_urls=>'" + CSS + "'")
    if re.search(r'^,p_page_comment=>', t, re.M):
        return t
    ancora = 'help_text' if re.search(r'^,p_help_text=>', t, re.M) else 'protection_level'
    return poe(t, ancora, ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS[QUAL]) + '))')


m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
s = s[:m.start()] + pagina(m.group(0)) + s[m.end():]

# ---------- conferência ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok (' + QUAL + ', página ' + pag + ') →', SAIDA)
