"""Aplica o novo desenho à EXPORTAÇÃO da página 21 ("Histórico Financeiro") dos apps 200 e 9181.

    python3 aplicar-histfin-pagina21.py f200_page_21.ORIGINAL.sql f200_page_21.sql
    python3 aplicar-histfin-pagina21.py f9181_page_21.ORIGINAL.sql f9181_page_21.sql

O app vem da própria exportação (p_default_application_id); os ids de cada app estão em PERFIS. A 9181
é a mesma página com o botão IA a mais e SEM a junção com distribuicao_custo e as 4 colunas contábeis
(os passos que mexem nelas são pulados ali).

O que muda (ações dinâmicas, processos, listas em cascata e o relatório ficam como vieram):
  1. a página usa o modelo com a coluna de filtros à esquerda (o MESMO das consultas 16, 25, 26
     e 164) e ganha os File URLs #WORKSPACE_IMAGES#Natcorp_HistFin.js / .css
  2. a região "Parâmetros" vira "Filtros" (Static ID PARAMETROS) na coluna da esquerda, com a
     moldura da 164; o Pesquisar fica no lugar do da 164 (o JS o leva para o pé da coluna)
  3. os campos dos filtros ficam um embaixo do outro, na ordem dos assuntos (Quando · O que somar ·
     De quem · Quais verbas · Mais opções) — o JS os reúne em grupos; "Período" passa a "Meses"
  4. a região "Totais" ganha o Static ID TOTAIS (o resumo a esconde quando já mostra os totais)
  5. DESEMPENHO do relatório e do Totais (passo 6 abaixo): funções por linha com cache, distribuicao_custo
     sem junção (não repete linhas), e sem Pesquisar nada roda
  6. entra o processo Ajax Callback NC_HISTFIN_INDICADORES (os números do resumo), com o PL/SQL de
     NC_HISTFIN_INDICADORES.plsql.sql (ficha curta; símbolos fora do Latin-1 viram texto simples)
Guia: HISTFIN-MANUTENCAO.md.
"""
import os
import re
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
FONTE = os.path.join(AQUI, 'NC_HISTFIN_INDICADORES.plsql.sql')
JS = "#WORKSPACE_IMAGES#Natcorp_HistFin.js"
CSS = "#WORKSPACE_IMAGES#Natcorp_HistFin.css"
PERFIS = {
    # app 200: modelo e moldura das consultas 16/25/26/164
    '200':  dict(ID_PROCESSO='990021000000000002', MODELO_COLUNA='283867002111251591073', MOLDURA_FILTROS='283867018226281591150',
                 REG_PARAMETROS='283825994804965841560', REG_TOTAIS='283826003613083841566', BOTAO_PESQUISAR='283825995202589841560',
                 CONTABIL=True),
    # app 9181: modelo e moldura das páginas 50/55/58 (as consultas com a coluna de filtros desse app)
    '9181': dict(ID_PROCESSO='990921000000000002', MODELO_COLUNA='57484998059769710817', MOLDURA_FILTROS='57485014174799710894',
                 REG_PARAMETROS='251571967256954943765', REG_TOTAIS='251571976065072943771', BOTAO_PESQUISAR='28441828271585142453',
                 CONTABIL=False),
}

# a ordem dos campos na coluna (o JS agrupa; sem o JS, a ordem já ajuda)
ORDEM = ['P21_EMPRESA', 'P21_DATA_REF',
         'P21_H_FINAN', 'P21_H_FINAN_ACM', 'P21_H_FERIAS', 'P21_H_13', 'P21_H_RESC', 'P21_H_RECALC',
         'P21_H_ADIANT', 'P21_H_PART', 'P21_H_DIVERSOS', 'P21_H_DIVERSOS_ACM',
         'P21_FILIAL_INI', 'P21_FILIAL_FIM', 'P21_CCUSTO_INI', 'P21_CCUSTO_FIM', 'P21_MATRICULA_INI', 'P21_MATRICULA_FIM',
         'P21_SITUACOES', 'P21_VINCULOS', 'P21_SINDICATO', 'P21_DT_ADM_INI', 'P21_DT_ADM_FIM',
         'P21_TIPO_RUBRICA', 'P21_COD_OCORR',
         'P21_CCUSTO_CONT_INI', 'P21_CCUSTO_CONT_FIM', 'P21_DT_RETENCAO_INI', 'P21_DT_RETENCAO_FIM', 'P21_OCULTAR',
         'P21_DATA_REF_INI', 'P21_DATA_REF_FIM']

if len(sys.argv) != 3:
    raise SystemExit(__doc__)
ent, sai = sys.argv[1], sys.argv[2]
s = open(ent, encoding='utf-8').read()
APP = re.search(r",p_default_application_id=>(\d+)", s).group(1)
if APP not in PERFIS:
    raise SystemExit('app %s sem perfil em PERFIS' % APP)
globals().update(PERFIS[APP])

def troca(a, b, onde=None):
    global s
    if s.count(a) != 1:
        raise SystemExit('esperava 1 ocorrência de: ' + a[:90] + ' (achei %d)' % s.count(a))
    s = s.replace(a, b)

def bloco(inicio_id, tipo):
    """o texto 'wwv_flow_api.<tipo>(\n p_id=>wwv_flow_api.id(<id>)' … '\n);'"""
    a = s.index('wwv_flow_api.%s(\n p_id=>wwv_flow_api.id(%s)' % (tipo, inicio_id))
    b = s.index('\n);', a) + 3
    return a, b

TROCA = {'─': '-', '═': '=', '…': '...', '→': '->', '≠': '<>', '≥': '>=', '≤': '<=', '—': '-', '–': '-',
         '“': '"', '”': '"', '‘': "'", '’': "'", '•': '-', '×': 'x', '−': '-'}
def latin1(t):
    for k, v in TROCA.items():
        t = t.replace(k, v)
    ruim = sorted({c for c in t if ord(c) > 255})
    if ruim:
        raise SystemExit('caracteres fora do Latin-1 no PL/SQL: ' + ' '.join(ruim))
    return t

def junta(texto):
    linhas = texto.rstrip('\n').split('\n')
    return 'wwv_flow_string.join(wwv_flow_t_varchar2(\n' + ',\n'.join("'" + l.replace("'", "''") + "'" for l in linhas) + '))'

if 'NC_HISTFIN_INDICADORES' in s or 'Natcorp_HistFin' in s:
    raise SystemExit('esta exportação já tem o desenho: rode sobre o .ORIGINAL.sql')
if 'p_javascript_file_urls' in s or 'p_css_file_urls' in s or 'p_step_template' in s[:s.index('create_page_plug')]:
    raise SystemExit('a página já tem File URLs ou modelo próprio: juntar à mão (este script supõe que não há)')

# 1. o modelo da página e os arquivos
troca(",p_autocomplete_on_off=>'ON'\n", ",p_autocomplete_on_off=>'ON'\n,p_javascript_file_urls=>'%s'\n,p_css_file_urls=>'%s'\n" % (JS, CSS))
troca(",p_page_template_options=>'#DEFAULT#'\n,p_protection_level=>'C'",
      ",p_step_template=>wwv_flow_api.id(%s)\n,p_page_template_options=>'#DEFAULT#'\n,p_protection_level=>'C'" % MODELO_COLUNA)

# 2. a região dos filtros: coluna da esquerda, moldura da 164
a, b = bloco(REG_PARAMETROS, 'create_page_plug')
reg = s[a:b]
reg = reg.replace(",p_plug_name=>unistr('Par\\00E2metros')", ",p_plug_name=>'Filtros'\n,p_region_name=>'PARAMETROS'")
reg = reg.replace(",p_region_template_options=>'#DEFAULT#:is-expanded:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'",
                  ",p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'")
reg = re.sub(r",p_plug_template=>wwv_flow_api\.id\(\d+\)", ",p_plug_template=>wwv_flow_api.id(%s)" % MOLDURA_FILTROS, reg)
reg = reg.replace(",p_plug_display_sequence=>20", ",p_plug_display_sequence=>5")
reg = reg.replace(",p_plug_display_point=>'BODY'", ",p_plug_display_point=>'REGION_POSITION_02'")
if "REGION_POSITION_02" not in reg or "'PARAMETROS'" not in reg or MOLDURA_FILTROS not in reg:
    raise SystemExit('a região Parâmetros não veio como esperado')
s = s[:a] + reg + s[b:]

# 3. o Pesquisar no lugar do da 164
a, b = bloco(BOTAO_PESQUISAR, 'create_page_button')
bt = s[a:b].replace(",p_button_position=>'REGION_TEMPLATE_NEXT'", ",p_button_position=>'REGION_TEMPLATE_CREATE'") \
           .replace(",p_button_template_options=>'#DEFAULT#:t-Button--iconRight'", ",p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'")
if 'REGION_TEMPLATE_CREATE' not in bt:
    raise SystemExit('o botão Pesquisar não veio como esperado')
s = s[:a] + bt + s[b:]

# 4. os campos: um embaixo do outro, na ordem dos assuntos
for n, nome in enumerate(ORDEM):
    i = s.find(",p_name=>'%s'\n" % nome)
    if i < 0:
        raise SystemExit('campo não encontrado: ' + nome)
    a = s.rfind('wwv_flow_api.create_page_item(', 0, i)
    b = s.index('\n);', i) + 3
    it = s[a:b]
    if "p_item_plug_id=>wwv_flow_api.id(%s)" % REG_PARAMETROS not in it:
        raise SystemExit('campo fora da região dos filtros: ' + nome)
    it = re.sub(r"\n,p_item_sequence=>\d+", "\n,p_item_sequence=>%d" % ((n + 1) * 10), it)
    it = re.sub(r"\n,p_colspan=>\d+", "", it)
    it = re.sub(r"\n,p_grid_label_column_span=>\d+", "", it)
    it = re.sub(r"\n,p_grid_column=>\d+", "", it)
    it = it.replace("\n,p_begin_on_new_line=>'N'", "")
    if nome == 'P21_DATA_REF':
        it = it.replace(",p_prompt=>unistr('Per\\00EDodo')", ",p_prompt=>'Meses'")
    s = s[:a] + it + s[b:]

# 5. a região Totais ganha o Static ID
a, b = bloco(REG_TOTAIS, 'create_page_plug')
tot = s[a:b].replace(",p_plug_name=>'Totais'", ",p_plug_name=>'Totais'\n,p_region_name=>'TOTAIS'")
s = s[:a] + tot + s[b:]

# 6. DESEMPENHO do relatório (09/10) — só mexe DENTRO do bloco do relatório HST e do processo Totais.
#    Cada troca é de uma LINHA exata da exportação (aspas dobradas duas vezes: a do SQL dinâmico e a
#    da exportação). Não muda colunas, posições, nem o ORDER BY 1,10,19.
#    a) as funções por linha viram "(select f(...) from dual)": o Oracle guarda o resultado das entradas
#       repetidas (scalar subquery caching) — o mesmo valor, muito menos chamadas;
#    b) distribuicao_custo deixa de ser JUNÇÃO (repetia as linhas de quem tem 2+ centros e somava o
#       valor em dobro): "exists" mantém as MESMAS pessoas; a coluna vem de uma subconsulta (o menor);
#    c) sem Pesquisar, o relatório e o Totais não rodam (abrir a página não paga a consulta inteira);
#       aberto pela ficha do colaborador (P21_MAT), rodam como antes.
def lin(t):
    """uma linha do código PL/SQL como ela fica na exportação: entre aspas, aspas internas dobradas"""
    return "'" + t.replace("'", "''") + "',"
def ir(velho, novo):
    """troca UMA linha exata dentro da fonte do relatório HST (velho/novo no texto do PL/SQL)"""
    global s
    a = s.index('p_plug_source=>', s.index("p_region_name=>'HST'")); b = s.index('\n,p_', a)
    trecho = s[a:b]
    v = '\n'.join(lin(x) for x in velho.split('\n')); n = '\n'.join(lin(x) for x in novo.split('\n'))
    if trecho.count(v) != 1:
        raise SystemExit('desempenho: esperava 1 ocorrência no relatório de: ' + v[:90] + ' (achei %d)' % trecho.count(v))
    s = s[:a] + trecho.replace(v, n) + s[b:]
def cache(linha, chamada):
    if chamada not in linha:
        raise SystemExit('desempenho: chamada fora da linha: ' + chamada)
    ir(linha, linha.replace(chamada, '(select ' + chamada + ' from dual)'))
Q = "''"   # a aspa DENTRO do SQL dinâmico (v_sql := '...'), como está no código da página
cache("       initcap(fnct_nome_empresa(v.cod_empresa, " + Q + "S" + Q + ")) Empresa,", "initcap(fnct_nome_empresa(v.cod_empresa, " + Q + "S" + Q + "))")
cache("       initcap(fnct_nome_filial(v.cod_empresa, v.FILIAL)) Filial,", "initcap(fnct_nome_filial(v.cod_empresa, v.FILIAL))")
cache("       initcap(fnct_nome_ccusto(v.cod_empresa, v.cod_ccusto)) CCusto,", "initcap(fnct_nome_ccusto(v.cod_empresa, v.cod_ccusto))")
cache("       initcap(fnct_nome_unidade_adm(v.cod_empresa, null, v.unidade_adm)) unidade_adm,", "initcap(fnct_nome_unidade_adm(v.cod_empresa, null, v.unidade_adm))")
cache("       initcap(fnct_nome_atividade(v.cod_atividade)) atividade,", "initcap(fnct_nome_atividade(v.cod_atividade))")
cache("       initcap(fnct_nome_local_trab(v.local_trab)) local_trab,", "initcap(fnct_nome_local_trab(v.local_trab))")
cache("       v.cod_ccusto_cont || " + Q + " - " + Q + " ||initcap(fnct_nome_ccusto_contab(v.cod_empresa, v.cod_ccusto_cont)) CCusto_Contab,", "initcap(fnct_nome_ccusto_contab(v.cod_empresa, v.cod_ccusto_cont))")
cache("       Initcap(fnct_nome_func(v.cod_empresa, v.matricula)) nome,", "Initcap(fnct_nome_func(v.cod_empresa, v.matricula))")
cache("       initcap(fnct_nome_sindicato(v.cod_empresa, v.NUM_SIND_DISS, " + Q + "S" + Q + ")) sindicato,", "initcap(fnct_nome_sindicato(v.cod_empresa, v.NUM_SIND_DISS, " + Q + "S" + Q + "))")
cache("       DECODE(F_Acesso_Salario_Apex(V.COD_EMPRESA, V.MATRICULA, V.FILIAL, :P_USUARIO)," + Q + "S" + Q + ",V.VALOR, NULL) VALOR,", "F_Acesso_Salario_Apex(V.COD_EMPRESA, V.MATRICULA, V.FILIAL, :P_USUARIO)")
cache("       Fnct_Nome_Cod_Gerencial(v.COD_GERENCIAL) cod_gerencial,", "Fnct_Nome_Cod_Gerencial(v.COD_GERENCIAL)")
if CONTABIL:   # só o app 200 tem as colunas contábeis e a junção com distribuicao_custo
    for n, nome in ((1, 'ContaContab'), (2, 'ContaDebito'), (3, 'ContaCredito '), (4, 'CategoriaContab')):
        chamada = "INITCAP(fnc_BuscaDadosEstrutContabil(v.cod_empresa, v.cod_ccusto_cont, v.cod_ocorr, %d))" % n
        cache("      ," + chamada + " " + nome, chamada)
    ir("       d.cod_ccusto_contab dist_c_custo_contabil,",
       "       (select min(d.cod_ccusto_contab) from distribuicao_custo d where d.cod_empresa = v.cod_empresa and d.matricula = v.matricula) dist_c_custo_contabil,")
    ir("  from hist v, inf i, distribuicao_custo d", "  from hist v, inf i")
    ir("   and v.cod_empresa = d.cod_empresa\n   and v.matricula  = d.matricula",
       "   and exists (select 1 from distribuicao_custo d where d.cod_empresa = v.cod_empresa and d.matricula = v.matricula)")
elif 'distribuicao_custo' in s[s.index("p_region_name=>'HST'"):s.index("p_region_name=>'HST'") + 40000]:
    raise SystemExit('este app (%s) tem distribuicao_custo no relatório: marcar CONTABIL=True no perfil' % APP)
ir("              where i.COD_EMPRESA = nvl(:p21_emp, nvl(:p21_empresa, i.cod_empresa))';",
   "              where i.COD_EMPRESA = nvl(:p21_emp, nvl(:p21_empresa, i.cod_empresa))';\n"
   "\n"
   "-- NATCORP 09/10: sem Pesquisar o relatorio nao roda (abrir a pagina nao paga a consulta inteira).\n"
   "-- Aberto pela ficha do colaborador (P21_MAT), roda como antes.\n"
   "if :P21_MAT is null and nvl(:P21_PESQUISA, 'N') <> 'S' then\n"
   "  v_sql := v_sql||' and 1 = 0';\n"
   "end if;")
# o Totais: a mesma regra (sem Pesquisar, não calcula)
a = s.index("p_process_name=>'Totais'"); b = s.index('\n,p_error_display_location', a)
tr = s[a:b]
if tr.count(lin('BEGIN')) != 1:
    raise SystemExit('desempenho: o processo Totais não veio como esperado')
s = s[:a] + tr.replace(lin('BEGIN'), lin('BEGIN') + '\n' + lin('-- NATCORP 09/10: sem Pesquisar nao calcula (a mesma regra do relatorio).') + '\n'
                       + lin("IF :P21_MAT IS NULL AND NVL(:P21_PESQUISA, 'N') <> 'S' THEN RETURN; END IF;")) + s[b:]

# 7. o processo dos números, no fim do último bloco (antes do end_environment)
fonte = open(FONTE, encoding='utf-8').read()
corpo = latin1('/* NATCORP - resumo da folha (Natcorp_HistFin.js). FONTE: brand/apex/app/NC_HISTFIN_INDICADORES.plsql.sql\n'
               '   (guia HISTFIN-MANUTENCAO.md). Mude la e aplique de novo com aplicar-histfin-pagina21.py. */\n'
               + fonte[fonte.index('\ndeclare\n') + 1:])
processo = """wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(%s)
,p_process_sequence=>60
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_HISTFIN_INDICADORES'
,p_process_sql_clob=>%s
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
""" % (ID_PROCESSO, junta(corpo))
fim = "end;\n/\nprompt --application/end_environment\n"
troca(fim, processo + fim)

ruim = sorted({c for c in s if ord(c) > 255})
if ruim:
    raise SystemExit('caracteres fora do Latin-1 na exportação: ' + ' '.join(ruim))
open(sai, 'w', encoding='utf-8').write(s)
print(os.path.basename(sai), len(s.encode()) // 1024, 'KB · modelo com coluna, Filtros à esquerda, %d campos em ordem, NC_HISTFIN_INDICADORES' % len(ORDEM))
