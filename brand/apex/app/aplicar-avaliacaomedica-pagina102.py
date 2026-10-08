"""Aplica a JANELA NOVA (Natcorp_AvaliacaoMedica.js/.css) numa EXPORTAÇÃO da página 102 do app 2937
("Avaliação Medica - Respostas", a janela de uma pergunta).

    python3 aplicar-avaliacaomedica-pagina102.py f2937_page_102.sql [saida.sql]

Reconhece a página pelo CONTEÚDO: os itens P102_TXT_QUESTAO e P102_RESP_ALTERNATIVA. Muda as duas
URLs de arquivo, o comentário e a condição do P102_RESP_DISSERTATIVA (passa a existir também quando a
pergunta tem a alternativa "Descreva") — as ações que gravam ("SALVAR ALTERNATIVA", "Salvar Dissertativa") e a
navegação (Anterior/Próximo/Finalizar) são as de sempre. Guia: AVALIACAOMEDICA-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2937_page_102.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_AvaliacaoMedica' in s

if "p_name=>'P102_TXT_QUESTAO'" not in s or "p_name=>'P102_RESP_ALTERNATIVA'" not in s:
    sys.exit('este arquivo não é a janela de respostas da Avaliação Médica (itens P102_TXT_QUESTAO e P102_RESP_ALTERNATIVA)')

JS = '#WORKSPACE_IMAGES#Natcorp_AvaliacaoMedica.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_AvaliacaoMedica.css'

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
    'DESENHO DA TELA (Natcorp_AvaliacaoMedica.css / Natcorp_AvaliacaoMedica.js)',
    '',
    'A pergunta grande e as alternativas em botões (escrevem na lista original: a ação "SALVAR ALTERNATIVA"',
    'grava) e, gravado, vai sozinho para a próxima. Anterior / Próximo / Finalizar no rodapé (teclas <- ->,',
    '1 a 9); antes de mudar de pergunta, espera a gravação (o texto grava ao sair do campo).',
    'A caixa de texto também existe nas perguntas com a alternativa "Descreva" (aparece ao escolhê-la).',
    'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/AVALIACAOMEDICA-MANUTENCAO.md.',
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
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_AvaliacaoMedica)')
    t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")
    t = poe(t, 'javascript_file_urls', ",p_css_file_urls=>'" + CSS + "'")
    return comentario(t)


# ---------- a caixa de texto também nas perguntas com a alternativa "Descreva" ----------
# Antes ela só existia nas perguntas Dissertativas: numa de múltipla escolha com "Descreva" (ex.: "Qual
# atividade física pratica…?") o médico marcava "Descreva" e não tinha onde escrever. As duas ações que
# gravam já levam P102_RESP_ALTERNATIVA E P102_RESP_DISSERTATIVA juntas — basta o item existir na página.
# O desenho só mostra a caixa quando a alternativa escolhida é a "Descreva" (mesma regra: DESCREV/ESPECIFI).
VELHA = "'              AND NVL(perg.ind_livre,''N'') = ''S'';'))"
NOVA = "\n".join([
    "'              AND (NVL(perg.ind_livre,''N'') = ''S''',",
    "'                   OR EXISTS (SELECT 1 FROM resposta_1 resp, questionario_questoes_1 qure',",
    "'                               WHERE resp.cod_resposta = qure.cod_resposta',",
    "'                                 AND resp.cod_formacao = qure.cod_formacao',",
    "'                                 AND qure.cod_questionario = qupe.cod_questionario',",
    "'                                 AND qure.cod_questao = qupe.cod_questao',",
    "'                                 AND qure.cod_formacao = qupe.cod_formacao',",
    "'                                 AND (UPPER(resp.nome_resposta) LIKE ''%DESCREV%'' OR UPPER(resp.nome_resposta) LIKE ''%ESPECIFI%'')));'))",
])
bl = re.search(r"wwv_flow_api\.create_page_item\(\n(?:(?!\n\);).)*?p_name=>'P102_RESP_DISSERTATIVA'.*?\n\);", s, re.S)
if not bl:
    sys.exit('não achei o item P102_RESP_DISSERTATIVA')
if 'DESCREV' not in bl.group(0):
    if bl.group(0).count(VELHA) != 1:
        sys.exit('a condição do P102_RESP_DISSERTATIVA mudou: junte à mão (ver o comentário acima)')
    s = s[:bl.start()] + bl.group(0).replace(VELHA, NOVA) + s[bl.end():]


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
print('ok (página 102 do app 2937' + (', só o comentário' if JA else '') + ') →', SAIDA)
