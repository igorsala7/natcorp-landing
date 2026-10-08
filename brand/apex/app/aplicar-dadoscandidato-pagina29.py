"""Aplica a FICHA DO CANDIDATO (Natcorp_DadosCandidato.js/.css) numa EXPORTAÇÃO da página 29 do app 2937
("Dados Candidatos Reduzido", a janela "Dados do candidato" da Agenda).

    python3 aplicar-dadoscandidato-pagina29.py f2937_page_29.sql [saida.sql]

Reconhece a página pelo CONTEÚDO: os itens P29_COD_CANDIDATO e P29_NOME e o processo CARREGA_DADOS
sobre INF_PESSOAIS_CANDIDATO. O que muda (tudo visível no Page Designer): as duas URLs de arquivo,
o comentário, o título da janela ("Dados Candidatos Reduzido" → "Dados do candidato") e a CORREÇÃO do
processo CARREGA_DADOS (junção externa, uma linha por busca, "nenhum dado" sem erro — ver o bloco abaixo).
Nenhum item, região, botão ou ação dinâmica é tocado — o desenho só LÊ os itens. Roda de novo sem
alterar duas vezes. Guia: DADOS-CANDIDATO-MANUTENCAO.md.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f2937_page_29.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
s = open(ENTRADA, encoding='utf-8').read()
JA = 'Natcorp_DadosCandidato' in s

if "p_name=>'P29_COD_CANDIDATO'" not in s or "p_name=>'P29_NOME'" not in s or 'INF_PESSOAIS_CANDIDATO' not in s:
    sys.exit('este arquivo não é a janela "Dados Candidatos Reduzido" (itens P29_COD_CANDIDATO/P29_NOME e processo sobre INF_PESSOAIS_CANDIDATO)')

JS = '#WORKSPACE_IMAGES#Natcorp_DadosCandidato.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_DadosCandidato.css'

LINHAS_29 = [
    'DESENHO DA TELA (Natcorp_DadosCandidato.css / Natcorp_DadosCandidato.js)',
    '',
    'A FICHA do candidato para o médico: código - nome, idade, sexo, situação e o cargo pretendido no alto;',
    'o que pede atenção (PCD, restrição para admissão) ou a confirmação de que não há; e as seções Vaga',
    'pretendida, Contato (telefones que ligam no celular), Identificação, Documentos (CPF, PIS, CTPS',
    'formatados), Indicação e vínculos e Uniforme. Só aparece o que está preenchido ("Sem informação: ...").',
    'Só LÊ os itens que o CARREGA_DADOS preenche; o formulário original fica na página, fora da vista.',
    'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/DADOS-CANDIDATO-MANUTENCAO.md.',
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



LINHAS = LINHAS_29


def comentario(t):
    novo = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))\n'
    m = re.search(r"^,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)|'(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))\n", t, re.M | re.S)
    if m:
        return t[:m.start()] + novo + t[m.end():]
    ancora = next((k for k in ('help_text', 'protection_level', 'autocomplete_on_off') if re.search(r'^,p_' + k + r'=>', t, re.M)), 'name')
    return poe(t, ancora, novo.rstrip('\n'))


def pagina(t):
    if re.search(r'^,p_(javascript|css)_file_urls=>', t, re.M):
        sys.exit('a página já tem URL de arquivo: junte à mão (acrescente as do Natcorp_DadosCandidato)')
    t = poe(t, 'autocomplete_on_off', ",p_javascript_file_urls=>'" + JS + "'")
    t = poe(t, 'javascript_file_urls', ",p_css_file_urls=>'" + CSS + "'")
    return comentario(t)



m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
pg = comentario(m.group(0)) if JA else pagina(m.group(0))
pg = pg.replace(",p_step_title=>'Dados Candidatos Reduzido'", ",p_step_title=>'Dados do candidato'")
s = s[:m.start()] + pg + s[m.end():]


# ---------- o CARREGA_DADOS deixa de quebrar com dados reais ----------
# Antes: (1) junção INTERNA com INF_FUNC_CANDIDATO — candidato sem essa linha dava "nenhum dado
# encontrado"; (2) as buscas por código (função do cargo, local, filial, referências) devolviam mais de
# uma linha quando havia mais de uma (ex.: cargo com várias funções) — "mais de uma linha" — e a
# janela abria VAZIA com "Ocorreu um erro ao tentar processar as informações". Agora: junção externa,
# cada busca pega uma linha (rownum = 1) e "nenhum dado" deixa a ficha vazia (o desenho avisa).
TROCAS = [
    ("'					   and F.COD_FILIAL = IPC.COD_FILIAL',", "'					   and F.COD_FILIAL = IPC.COD_FILIAL and rownum = 1',"),
    ("'				 Where cod = IFC.cargo_pretendido',", "'				 Where cod = IFC.cargo_pretendido and rownum = 1',"),
    ("'					where loc.cod_Local_Trab = IFC.cargo_pretendido',", "'					where loc.cod_Local_Trab = IFC.cargo_pretendido and rownum = 1',"),
    ("'				 WHERE f.cod_cargo = IFC.cargo_pretendido',", "'				 WHERE f.cod_cargo = IFC.cargo_pretendido and rownum = 1',"),
    ("'							 and b.cod_empresa = IFC.referencia_emp',", "'							 and b.cod_empresa = IFC.referencia_emp and rownum = 1',"),
    ("'							 and b.cod_empresa = IFC.parente_emp',", "'							 and b.cod_empresa = IFC.parente_emp and rownum = 1',"),
    ("'				 and b.cod_empresa = IFC.ex_func_emp',", "'				 and b.cod_empresa = IFC.ex_func_emp and rownum = 1',"),
    ("'	   and IFC.COD_EMPRESA = IPC.EMPRESA',", "'	   and IFC.COD_EMPRESA (+) = IPC.EMPRESA',"),
    ("'     and IFC.COD_CANDIDATO = IPC.COD_CANDIDATO;',", "'     and IFC.COD_CANDIDATO (+) = IPC.COD_CANDIDATO;',"),
    ("'exception ',\n'   when others then',", "'exception ',\n'   when no_data_found then null;  -- candidato sem cadastro: a ficha avisa (Natcorp_DadosCandidato.js)',\n'   when others then',"),
]
for velho, novo in TROCAS:
    if novo in s:
        continue
    if s.count(velho) != 1:
        sys.exit('o processo CARREGA_DADOS mudou (não achei: ' + velho.strip()[:60] + '): junte a correção à mão')
    s = s.replace(velho, novo)

# ---------- conferência: nenhum atributo repetido em nenhum bloco ----------
for m in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
    ks = re.findall(r'^,?p_([a-z0-9_]+)=>', m.group(2), re.M)
    if len(ks) != len(set(ks)):
        sys.exit('atributo repetido em ' + m.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
fora = [l for l in s.split('\n') if re.match(r"^,?p_[a-z0-9_]+=>'", l) and any(ord(c) > 127 for c in l)]
if fora:
    sys.exit('texto com acento sem unistr: ' + fora[0][:80])
open(SAIDA, 'w', encoding='utf-8').write(s)
print('ok (página 29 do app 2937' + (', só o comentário' if JA else '') + ') →', SAIDA)
