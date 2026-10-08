"""Aplica a ELEIÇÃO DA CIPA (Natcorp_Cipa.js/.css) numa EXPORTAÇÃO da página 34 (lista de
candidatos) ou 35 (Confirmar Votação) do app 2942 — o mesmo par de arquivos serve às duas.

    python3 aplicar-cipa-paginas.py f2942_page_34.sql [saida.sql]
    python3 aplicar-cipa-paginas.py f2942_page_35.sql [saida.sql]

Reconhece a página pelos itens (P34_CAND_MATRICULA / P35_TEXTO). O que muda (tudo visível no Page
Designer): só as duas URLs de arquivo e o comentário da página. Regiões, itens, botões, processos e
ações dinâmicas ficam como estão. Roda de novo sem alterar duas vezes.
Guia: CIPA-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2942_page_34.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_Cipa' in s

if "p_name=>'P34_CAND_MATRICULA'" in s:
    PAG = '34'
elif "p_name=>'P35_TEXTO'" in s and "p_name=>'P35_CAND_MATRICULA'" in s:
    PAG = '35'
else:
    sys.exit('este arquivo não é a página 34 nem a 35 da CIPA (itens P34_CAND_MATRICULA / P35_TEXTO)')

JS = '#WORKSPACE_IMAGES#Natcorp_Cipa.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Cipa.css'

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
    'DESENHO DA TELA (Natcorp_Cipa.css / Natcorp_Cipa.js) - o mesmo nas paginas 34 e 35',
    '',
    'Para o colaborador no celular: na 34, o que e a eleicao e como votar em 3 passos, o cartao "Quer ser candidato?"',
    'com o botao Inscrever-se original (so quando ele aparece), e cada candidato como um cartao grande (iniciais, nome,',
    'apelido, cargo, setor, unidade e "Votar"); o toque e o clique no link original. Na 35, o cartao de quem recebe o',
    'voto, a pergunta e os botoes originais; "Voto ja realizado" e o periodo de votacao viram telas proprias.',
    'Nada e gravado pelo desenho: link, botoes, processos, condicoes e acoes dinamicas continuam. Para desligar: tire as',
    'duas URLs de arquivo. Guia: brand/apex/app/CIPA-MANUTENCAO.md.',
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
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_Cipa)')
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
print('ok (página ' + PAG + ' do app 2942' + (', só o comentário' if JA else '') + ') →', SAIDA)
