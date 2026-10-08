"""Aplica a FICHA DA CONSULTA (Natcorp_ConsultaMedica.js/.css) numa EXPORTAÇÃO da página 40 do app 2937
("Consulta Médica", aberta pela Agenda Médica).

    python3 aplicar-consultamedica-pagina40.py f2937_page_40.sql [saida.sql]

Reconhece a página pelo CONTEÚDO (nunca pelos IDs): o formulário da CONSULTA_MEDICA e as regiões TAB1 e
TAB10. O que muda (tudo visível no Page Designer): só as duas URLs de arquivo e o comentário da página.
NENHUMA região, item, botão, ação dinâmica, validação ou processo é tocado — as regiões só mudam de
lugar na tela (das abas para a ficha). Roda de novo sobre um arquivo já alterado: não altera duas vezes.
Guia: CONSULTAMEDICA-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2937_page_40.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_ConsultaMedica' in s

if "'CONSULTA_MEDICA'" not in s or "p_region_name=>'TAB1'" not in s or "p_region_name=>'TAB10'" not in s:
    sys.exit('este arquivo não é a página da Consulta Médica (formulário da CONSULTA_MEDICA com as regiões TAB1…TAB10)')

JS = '#WORKSPACE_IMAGES#Natcorp_ConsultaMedica.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_ConsultaMedica.css'

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
    'DESENHO DA TELA (Natcorp_ConsultaMedica.css / Natcorp_ConsultaMedica.js)',
    '',
    'As 12 abas viram UMA ficha na ordem do atendimento, com um trilho à esquerda (Dados da consulta; Ouvir:',
    'relato, anamnese, antecedentes, gestação; Examinar; Concluir: diagnóstico, conduta; Prescrever e orientar:',
    'receituário, posologia, encaminhamento; Trabalho: atividades, recomendação) que marca o que já tem registro.',
    'Paciente fixo no alto; antecedentes em botões de marcar; textos que crescem com limite; entrada/saída em',
    'hh:mm com "Agora"; rodapé com Voltar e Finalizar (sem a saída, ela vira a hora de agora). Sair sem finalizar',
    'com algo escrito pede confirmação. No pré-atendimento, aviso com o botão Iniciar Atendimento.',
    'As regiões do APEX só mudam de lugar: Finalizar, validações, processos, ações dinâmicas e a trava são os',
    'de sempre. Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/CONSULTAMEDICA-MANUTENCAO.md.',
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
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_ConsultaMedica)')
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
print('ok (página 40 do app 2937' + (', só o comentário' if JA else '') + ') →', SAIDA)
