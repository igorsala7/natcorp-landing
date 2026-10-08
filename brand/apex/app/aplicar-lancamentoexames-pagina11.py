"""Aplica o LANÇAMENTO DE EXAMES (Natcorp_LancamentoExames.js/.css) numa EXPORTAÇÃO da página 11 do
app 2937 ("Manutenção de Exames Médicos", aberta pelo botão Exames do 2937:19).

    python3 aplicar-lancamentoexames-pagina11.py f2937_page_11.sql [saida.sql]

Reconhece a página pelo CONTEÚDO (nunca pelos IDs): o Interactive Grid sobre a EXAME_FUNC e o item
P11_MATRICULA. O que muda (tudo visível no Page Designer): só as duas URLs de arquivo e o comentário
da página. NENHUMA região, coluna, item, botão, ação dinâmica, validação ou processo é tocado — o
grid continua sendo o motor (dados, listas, salvar), o histórico e a ficha são desenhados por cima.
Roda de novo sobre um arquivo já alterado: não altera duas vezes (só atualiza o comentário).
Guia: LANCAMENTOEXAMES-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2937_page_11.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_LancamentoExames' in s

if "p_plug_source_type=>'NATIVE_IG'" not in s or 'from exame_func' not in s or "p_name=>'P11_MATRICULA'" not in s:
    sys.exit('este arquivo não é a página da Manutenção de Exames Médicos (Interactive Grid sobre a EXAME_FUNC e o item P11_MATRICULA)')

JS = '#WORKSPACE_IMAGES#Natcorp_LancamentoExames.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_LancamentoExames.css'

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
    'DESENHO DA TELA (Natcorp_LancamentoExames.css / Natcorp_LancamentoExames.js)',
    '',
    'Por cima do grid "Exames": o paciente fixo no alto (código - nome, idade, cargo, setor, local, sangue),',
    '"Trocar paciente" (empresa e matrícula) e os cadastros de médico e entidade; a SITUAÇÃO de cada exame',
    '(o último, com o próximo: vencido, vence em breve, em dia) com "Lançar de novo"; o HISTÓRICO do mais',
    'novo ao mais antigo (data, exame, tipo, resultado com cor, próximo, médico, procedimento), com busca e',
    'filtro por exame. Tocar num exame abre o resumo (só leitura); Editar, Lançar exame e Lançar de novo',
    'abrem a vista de um registro do próprio grid numa gaveta, em quatro partes, com atalhos para o próximo',
    'exame (+6 meses, +1 ano, +2 anos). Salvar grava só o exame da ficha, pelo salvar do grid (processos e',
    'validações de sempre). Para desligar: tire as duas URLs de arquivo. Guia: LANCAMENTOEXAMES-MANUTENCAO.md.',
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
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_LancamentoExames)')
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
print('ok (página 11 do app 2937' + (', só o comentário' if JA else '') + ') →', SAIDA)
