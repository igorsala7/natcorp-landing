"""Aplica o desenho novo nas páginas do PROCESSO SELETIVO do app 9113 que não têm script próprio:
32 (ficha do candidato — Natcorp_CandidatoProcesso) e 38, 10, 13, 3, 35 (janelas — Natcorp_ProcessoJanelas).
A página 29 tem o dela: aplicar-processodetalhe-pagina29.py.

    python3 aplicar-recrutamento-paginas.py f9113_page_32.sql f9113_page_38.sql …   (um ou vários)

Reconhece cada página pelo CONTEÚDO (itens dela). O que muda (tudo visível no Page Designer): as duas
URLs de arquivo e o comentário da página. Na página 3, um conserto: o processo "Atualiza Data" punha
SEMPRE hoje + 7 dias na data de contratação, por cima da data gravada; agora só quando está vazia
(NVL). NENHUM outro item, região, botão, ação dinâmica, processo ou consulta é tocado. Roda de novo
sem alterar duas vezes. Guias: CANDIDATOPROCESSO-MANUTENCAO.md e PROCESSOJANELAS-MANUTENCAO.md.
"""
import re
import sys

JANELAS = ('Natcorp_ProcessoJanelas', 'PROCESSOJANELAS-MANUTENCAO.md')
PAGINAS = {
    32: (["p_name=>'P32_COD_CANDIDATO'", "p_region_name=>'AVALIACOES'"], ('Natcorp_CandidatoProcesso', 'CANDIDATOPROCESSO-MANUTENCAO.md'), [
        'Ficha do candidato no processo: CARTÃO no alto (nome, idade, cidade, etapa, nota, e-mail e celular',
        'com copiar e WhatsApp, Aprovar candidato / Avaliar fase / Ver currículo); ABAS por assunto (Resumo,',
        'Fases e avaliações, Questionário, Anotações, Documentos, Linha do tempo, Outros processos) — as abas',
        '"Dados pessoais" e "Fases" saem porque o conteúdo delas entrou em Resumo e em Fases e avaliações;',
        'fases em linha do tempo; questionário por fase; "Ver tabela" devolve cada relatório original.']),
    38: (["p_name=>'P38_URL'"], JANELAS, [
        'Janela Detalhes da vaga: link para candidatos com Copiar link e Abrir; o anúncio ("Como o candidato',
        'vê"); a descrição em texto legível.']),
    10: (["p_name=>'P10_PROCESSO'"], JANELAS, [
        'Janela Anotações das fases: "+" vira "Adicionar anotação"; lista vazia explicada.']),
    13: (["p_name=>'P13_COD_PROCESSO'"], JANELAS, [
        'Janela Processo seletivo: ficha do processo no alto (status, cargo, empresa, filial, CC, vaga,',
        'requisição); "Classificação e responsável"; seções abertas; campo só de leitura como texto; vazio sai.']),
    3: (["p_name=>'P3_DT_CONTRATACAO'"], JANELAS, [
        'Janela Aprovar candidato: quem está sendo aprovado; data de contratação em destaque; "Confirmar',
        'aprovação"; aviso se abrir sem o candidato. Processo "Atualiza Data" com NVL (não apaga a data gravada).']),
    35: (["p_name=>'P35_TEMPLATE_EMAIL'"], JANELAS, [
        'Janela Enviar e-mail como "nova mensagem" do Mail: barra no alto (assunto, Fechar, Enviar — os botões',
        'originais, movidos), linhas Para / Modelo / Assunto sem caixa, e o corpo ocupando o resto da janela.',
        'O editor (CKEditor) ganha o desenho GERAL do Natcorp_Editor (Style_Min + peça do Temas).']),
}


def uni(t):
    if all(ord(c) < 128 for c in t):
        return "'" + t.replace("'", "''") + "'"
    return "unistr('" + ''.join(c if ord(c) < 128 else '\\%04X' % ord(c) for c in t.replace('\\', '\\005C').replace("'", "''")) + "')"


def poe(t, depois_de, linha):
    m = re.search(r'^,?p_' + depois_de + r'=>.*\n', t, re.M)
    if not m:
        sys.exit('falta p_' + depois_de)
    return t[:m.end()] + linha + '\n' + t[m.end():]


FIM = '---- (fim do bloco Natcorp; abaixo, o comentário que a página já tinha) ----'


def comentario(t, linhas):
    nosso = ',\n'.join(uni(l) for l in linhas + [FIM])
    m = re.search(r"^,p_page_comment=>wwv_flow_string\.join\(wwv_flow_t_varchar2\(\n(.*?)\)\)\n", t, re.M | re.S)
    if not m:
        m1 = re.search(r"^,p_page_comment=>('(?:[^']|'')*'|unistr\('(?:[^']|'')*'\))\n", t, re.M)
        # comentário de uma linha só: fica depois do FIM
        if m1:
            return t[:m1.start()] + ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + nosso + ',\n' + m1.group(1) + '))\n' + t[m1.end():]
        return poe(t, 'page_template_options', ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + nosso + '))')
    corpo = m.group(1)
    i = corpo.find(uni(FIM))
    resto = corpo[i + len(uni(FIM)):].lstrip(',\n') if i >= 0 else corpo
    return t[:m.start()] + ',p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(\n' + nosso + (',\n' + resto if resto else '') + '))\n' + t[m.end():]


def aplicar(caminho):
    s = open(caminho, encoding='utf-8').read()
    pg = next((n for n, (marcas, _, _) in PAGINAS.items() if all(x in s for x in marcas)), None)
    if pg is None:
        sys.exit(caminho + ': não reconheci a página (32, 38, 10, 13, 3 ou 35 do app 9113)')
    marcas, (arq, guia), texto = PAGINAS[pg]
    linhas = ['DESENHO DA TELA (' + arq + '.css / ' + arq + '.js)', ''] + texto + [
        'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/' + guia + '.']
    m = re.search(r'wwv_flow_api\.create_page\(\n.*?\n\);\n', s, re.S)
    pagina = m.group(0)
    ja = arq in pagina
    if not ja:
        if re.search(r'^,p_(javascript|css)_file_urls=>', pagina, re.M):
            sys.exit(caminho + ': a página já tem URL de arquivo; junte à mão (acrescente as do ' + arq + ')')
        pagina = poe(pagina, 'autocomplete_on_off', ",p_javascript_file_urls=>'#WORKSPACE_IMAGES#" + arq + ".js'")
        pagina = poe(pagina, 'javascript_file_urls', ",p_css_file_urls=>'#WORKSPACE_IMAGES#" + arq + ".css'")
    pagina = comentario(pagina, linhas)
    s = s[:m.start()] + pagina + s[m.end():]
    if pg == 3:
        s = s.replace(",p_process_sql_clob=>':P3_DT_CONTRATACAO := to_date(sysdate)+7;'",
                      ",p_process_sql_clob=>':P3_DT_CONTRATACAO := NVL(:P3_DT_CONTRATACAO, to_date(sysdate)+7);'")
    # conferência: nenhum atributo repetido; acento só em unistr
    for b in re.finditer(r'wwv_flow_api\.(create_[a-z_]+)\(\n(.*?)\n\);', s, re.S):
        ks = re.findall(r'^,?p_([a-z0-9_]+)=>', b.group(2), re.M)
        if len(ks) != len(set(ks)):
            sys.exit(caminho + ': atributo repetido em ' + b.group(1) + ': ' + str([k for k in ks if ks.count(k) > 1]))
    fora = [l for l in s.split('\n') if re.match(r"^,?p_[a-z0-9_]+=>'", l) and any(ord(c) > 127 for c in l)]
    if fora:
        sys.exit(caminho + ': texto com acento sem unistr: ' + fora[0][:80])
    open(caminho, 'w', encoding='utf-8').write(s)
    print('ok (página', pg, 'do app 9113' + (', só o comentário' if ja else '') + ') →', caminho)


if len(sys.argv) < 2:
    sys.exit(__doc__)
for c in sys.argv[1:]:
    aplicar(c)
