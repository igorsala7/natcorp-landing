"""Aplica o HISTÓRICO DO COLABORADOR (Natcorp_HistoricoColaborador.js/.css) numa EXPORTAÇÃO da página 6
do app 2937 ("Cadastro de Dados de Funcionários").

    python3 aplicar-historicocolaborador-pagina6.py f2937_page_6.sql [saida.sql]

Reconhece a página pelo CONTEÚDO (nunca pelos IDs): os itens P6_NOME e P6_MATRICULA e as grades sobre
FUNC_DOENCA / ATESTADO_FUNCIONARIO / EXAME_FUNC. O que muda (tudo visível no Page Designer):
  • as duas URLs de arquivo e o comentário da página;
  • as grades de DOENÇAS e ATESTADOS deixam de ser "Somente leitura: Sempre" (Região › Read Only) —
    é o que deixa a gaveta do desenho lançar e corrigir por elas (a gravação é o processo "Save
    Interactive Grid Data" que já existe; os esquemas de autorização de incluir/alterar/excluir
    continuam valendo). A de EXAMES continua só leitura: não tem chave primária e a consulta junta
    três tabelas com colunas calculadas — destravar daria erro ao gravar.
Nenhum item, botão, ação dinâmica ou processo é tocado. Roda de novo sem alterar duas vezes.
Guia: HISTORICOCOLABORADOR-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2937_page_6.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_HistoricoColaborador' in s

if "p_name=>'P6_NOME'" not in s or "p_name=>'P6_MATRICULA'" not in s or 'from func_doenca' not in s or 'from atestado_funcionario' not in s:
    sys.exit('este arquivo não é a página de Dados de Funcionário (itens P6_NOME/P6_MATRICULA e grades de doenças e atestados)')

JS = '#WORKSPACE_IMAGES#Natcorp_HistoricoColaborador.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_HistoricoColaborador.css'

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
    'DESENHO DA TELA (Natcorp_HistoricoColaborador.css / Natcorp_HistoricoColaborador.js)',
    '',
    'As abas viram o HISTÓRICO do colaborador: quem é (fixo no alto); à esquerda o que pede atenção (restrições,',
    'doença sem término, atestado em vigor, exame vencido ou vencendo, vacina atrasada, acidente recente), o sangue',
    '(tipo e fator RH, editáveis) e o que a função faz; à direita a LINHA DO TEMPO com consultas, exames, atestados,',
    'doenças, vacinas, consulta ocupacional e acidentes juntos, por ano, com filtro por tipo e busca; tocar abre os',
    'detalhes, com "Ver consulta" e "Abrir análise". LANÇAR E CORRIGIR: "Novo atestado", "Nova doença" e "Editar"',
    'abrem uma gaveta com a ficha da própria grade (Single Row View) — Salvar é o salvar da grade, pelo processo',
    '"Save Interactive Grid Data". Por isso as regiões Doenças e Atestados NÃO são mais "Read Only: Always"',
    '(Exames continua: a grade não tem chave primária). "Tabelas" mostra as abas originais, só para consultar.',
    'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/HISTORICOCOLABORADOR-MANUTENCAO.md.',
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
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_HistoricoColaborador)')
    t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")
    t = poe(t, 'javascript_file_urls', ",p_css_file_urls=>'" + CSS + "'")
    return comentario(t)


def destravar(t):
    """tira o Read Only: Always das regiões de grade sobre FUNC_DOENCA e ATESTADO_FUNCIONARIO"""
    feitas = []
    for tabela in ('func_doenca', 'atestado_funcionario'):
        achou = False
        for m in re.finditer(r'wwv_flow_api\.create_page_plug\(\n.*?\n\);\n', t, re.S):
            b = m.group(0)
            if "p_plug_source_type=>'NATIVE_IG'" not in b or not re.search(r'\bfrom\s+' + tabela + r'\b', b, re.I):
                continue
            achou = True
            if "p_plug_read_only_when_type=>'ALWAYS'" in b:
                novo = re.sub(r"^,p_plug_read_only_when_type=>'ALWAYS'\n", '', b, flags=re.M)
                t = t[:m.start()] + novo + t[m.end():]
                feitas.append(tabela)
            break
        if not achou:
            sys.exit('não achei a grade sobre ' + tabela.upper())
    return t, feitas


s, DESTRAVADAS = destravar(s)
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
print('ok (página 6 do app 2937' + (', só o comentário' if JA else '') + (', destravadas: ' + ', '.join(DESTRAVADAS) if DESTRAVADAS else '') + ') →', SAIDA)
