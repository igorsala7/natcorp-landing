"""Aplica a AGENDA DO DIA (Natcorp_AgendaMedica.js/.css) numa EXPORTAÇÃO da página 10 do app 2937
("Controle de Agendas Médicas").

    python3 aplicar-agendamedica-pagina10.py f2937_page_10.sql [saida.sql]

Reconhece a página pelo CONTEÚDO (nunca pelos IDs): o Interactive Grid "horarios" sobre a
AGENDAS_MEDICOS_HORARIOS. O que muda (tudo visível no Page Designer): só as duas URLs de arquivo e
o comentário da página. NENHUMA região, item, botão, ação dinâmica ou processo é tocado — o grid
continua sendo o motor (dados, salvar, regras), a agenda do dia é desenhada por cima dele.
Roda de novo sobre um arquivo já alterado: não altera duas vezes (só atualiza o comentário).
Guia: AGENDAMEDICA-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2937_page_10.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_AgendaMedica' in s

if "p_plug_source_type=>'NATIVE_IG'" not in s or 'AGENDAS_MEDICOS_HORARIOS' not in s or "p_region_name=>'horarios'" not in s:
    sys.exit('este arquivo não é a página da Agenda Médica (Interactive Grid "horarios" sobre a AGENDAS_MEDICOS_HORARIOS)')

JS = '#WORKSPACE_IMAGES#Natcorp_AgendaMedica.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_AgendaMedica.css'

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
    'DESENHO DA TELA (Natcorp_AgendaMedica.css / Natcorp_AgendaMedica.js)',
    '',
    'Por cima do grid "Horários", uma AGENDA DO DIA para o médico: o dia por extenso com anterior /',
    'hoje / próximo, o profissional, a sala e a empresa (Alterar abre os filtros), o resumo do dia',
    '(agendados, na clínica, atendidos, livres), um horário por linha com o paciente, o tipo de consulta',
    'e o próximo passo (Agendar, Marcar chegada, Concluir), e o painel do horário com só as ações que',
    'valem (as mesmas regras da função regra_negocio). Agendar/Editar usa a vista de um registro do grid.',
    'O grid continua sendo o motor: os dados, o salvar (com o processo "Bloqueia outras empresas") e as',
    'regras são os de sempre; os botões originais são apertados pelo desenho. Atualiza sozinho a cada minuto.',
    'Para desligar tudo: tire as duas URLs de arquivo. Guia: brand/apex/app/AGENDAMEDICA-MANUTENCAO.md.',
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
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_LinhaTempo)')
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
print('ok (página 10 do app 2937' + (', só o comentário' if JA else '') + ') →', SAIDA)
