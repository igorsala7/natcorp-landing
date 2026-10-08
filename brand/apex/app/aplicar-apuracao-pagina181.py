"""Ajusta a EXPORTAÇÃO da página 181 do app 9503 ("Requisição de Apuração") para o desenho
Natcorp_Apuracao.

    python3 aplicar-apuracao-pagina181.py f9503_page_181.sql [saida.sql]

Acha tudo pelos NOMES (botões, itens, títulos das regiões), nunca pelos IDs. Rodar de novo sobre um
arquivo já ajustado não muda nada. Nada muda nas validações, processos, ações dinâmicas nem nas
listas de valores; a máscara de horas da própria página (JavaScript da página) fica como está.

O que muda (tudo visível no Page Designer):
  · as URLs #WORKSPACE_IMAGES#Natcorp_Apuracao.js / .css (se ainda não estiverem);
  · botões: "Criar Requisição" (NOVO_CRIAR, CREATE) → "Enviar pedido"; "Apuração Justificativa"
    (JUSTIFICAR) → "Só justificar, sem trocar";
  · regiões: "Evento Atual" → "O evento deste dia"; "Evento Novo" do pedido novo (P181_COD_REQ
    vazio) → "Trocar por"; o do pedido existente → "O pedido"; "Observações" → "Observação";
  · rótulos: "Qtde. Horas" (P181_QTD_HORAS_NOVO) → "Horas"; "Saldo Remanescente" → "Saldo que
    sobrou"; "Observação do Aprovador" → "Comentário de quem aprova (se quiser)";
  · o comentário da página.
"""
import re
import sys

ENTRADA = sys.argv[1] if len(sys.argv) > 1 else 'f9503_page_181.sql'
SAIDA = sys.argv[2] if len(sys.argv) > 2 else ENTRADA
JS = '#WORKSPACE_IMAGES#Natcorp_Apuracao.js'
CSS = '#WORKSPACE_IMAGES#Natcorp_Apuracao.css'

t = open(ENTRADA, encoding='utf-8').read()
feito = []


def uni(s):
    """texto → literal do export: com acento vira unistr('…\\00E7…'), sem acento fica '…'"""
    s = s.replace("'", "''")
    if all(ord(c) < 128 for c in s):
        return "'" + s + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in s) + "')"


def blocos(tipo):
    return list(re.finditer(r"wwv_flow_api\.create_page_" + tipo + r"\(\n(.*?)\n\);", t, re.S))


def troca_no_bloco(m, campo, novo):
    """troca ,p_<campo>=>… dentro do bloco m (uma linha) pelo valor novo"""
    global t
    b = m.group(1)
    # o texto novo vai como função: com string, o re.sub leria o "\\00E7" do unistr como grupo
    nb = re.sub(r"^,p_" + campo + r"=>.*$", lambda x: ",p_" + campo + "=>" + novo, b, count=1, flags=re.M)
    if nb != b:
        t = t[:m.start(1)] + nb + t[m.end(1):]
        return True
    return False


def bloco_com(tipo, re_chave):
    for m in blocos(tipo):
        if re.search(re_chave, m.group(1), re.M):
            yield m


# 1. as URLs dos arquivos
if JS not in t:
    t = re.sub(r"^,p_autocomplete_on_off=>'[^']*'$", lambda x: x.group(0) + "\n,p_javascript_file_urls=>'" + JS + "'", t, count=1, flags=re.M)
    feito.append('URL do .js')
if CSS not in t:
    t = re.sub(r"^,p_page_template_options=>", lambda x: ",p_css_file_urls=>'" + CSS + "'\n,p_page_template_options=>", t, count=1, flags=re.M)
    feito.append('URL do .css')

# 2. botões (pelo nome do botão)
for nome, rot in [('NOVO_CRIAR', 'Enviar pedido'), ('CREATE', 'Enviar pedido'), ('JUSTIFICAR', 'Só justificar, sem trocar')]:
    for m in list(bloco_com('button', r"^,p_button_name=>'" + nome + "'$")):
        if troca_no_bloco(m, 'button_image_alt', uni(rot)):
            feito.append('botão ' + nome)
        break

# 3. regiões (pelo título e, nos dois "Evento Novo", pela condição em P181_COD_REQ)
def regiao(re_nome, novo, re_extra=None):
    for m in list(bloco_com('plug', r"^,p_plug_name=>" + re_nome + r"$")):
        if re_extra and not re.search(re_extra, m.group(1), re.S):
            continue
        if troca_no_bloco(m, 'plug_name', uni(novo)):
            feito.append('região ' + novo)
        return

regiao(r"'Evento Atual'", 'O evento deste dia')
regiao(r"'Evento Novo'", 'Trocar por', r"p_plug_display_condition_type=>'ITEM_IS_NULL'")
regiao(r"'Evento Novo'", 'O pedido', r"p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'")
regiao(r"unistr\('Observa\\00E7\\00F5es'\)", 'Observação', r"p_plug_display_sequence")

# 4. rótulos (pelo nome do item)
for item, rot in [('P181_QTD_HORAS_NOVO', 'Horas'), ('P181_SALDO_REMAN', 'Saldo que sobrou'), ('P181_OBS_APROVADOR', 'Comentário de quem aprova (se quiser)')]:
    for m in list(bloco_com('item', r"^,p_name=>'" + item + "'$")):
        if troca_no_bloco(m, 'prompt', uni(rot)):
            feito.append('rótulo ' + item)
        break

# 5. o comentário da página
LINHAS = [
    'Desenho Natcorp_Apuracao (01/10/2026): uma coluna, uma conversa.',
    'Pedido novo: o evento deste dia num cartão; Vai para onde? (Banco de horas / Ponto); De onde vêm',
    'as horas? (Deste dia / Do saldo que sobrou); Qual evento? (botões com busca; "(não utilizar)" e',
    'testes atrás de "Mais eventos"); Quantas horas? (Todas / Metade); a frase do pedido no pé.',
    'Pedido existente (aprovação): a frase do pedido e a situação no alto; os campos atrás de',
    '"Ver todos os campos". O desenho só usa apex.item().setValue: as listas e campos substituídos',
    'continuam na página, escondidos. Guia: brand/apex/app/APURACAO-MANUTENCAO.md.',
]
novo_com = ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join(uni(l) for l in LINHAS) + '))'
if 'Natcorp_Apuracao (01/10' not in t:
    m = re.search(r"^,p_page_comment=>(?:wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n.*?\)\)|'(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))$", t, re.M | re.S)
    if m:
        t = t[:m.start()] + novo_com + t[m.end():]
    else:
        t = re.sub(r"^,p_help_text=>", lambda x: novo_com + "\n,p_help_text=>", t, count=1, flags=re.M)
    feito.append('comentário da página')

open(SAIDA, 'w', encoding='utf-8').write(t)
print('ok →', SAIDA, '·', ', '.join(feito) if feito else 'nada a mudar (já ajustado)')
