"""Aplica o novo desenho à EXPORTAÇÃO da página 5 do app 9132 ("Lançamentos" de ocorrências).

    python3 aplicar-lancocorr-pagina5.py f9132_page_5.ORIGINAL.sql f9132_page_5.sql

O que muda (ações dinâmicas, validações, processos, listas em cascata e os relatórios ficam como vieram):
  1. a página ganha os File URLs: #WORKSPACE_IMAGES#Natcorp_LancOcorr.js e os CSS
     Natcorp_HistFiltros.css (os grupos de filtros, os mesmos da 200:21) + Natcorp_LancOcorr.css
  2. a região "Parâmetros de Pesquisa" (PSQ1) vira "Filtros" com a moldura PADRÃO (a mesma da região
     BLOCO desta página — o id existe no app 9132) no lugar da recolhível: ela agora mora na coluna
     da esquerda e não se recolhe mais depois do Pesquisar (a ação "Expand Collapse Parametros"
     continua na página; sem região recolhível, ela não tem o que recolher)
  3. os rótulos saem da CAIXA ALTA ("CENTROS DE CUSTO" → "Centros de custo")
  4. a ORDEM dos campos (sequência) passa a ser a dos grupos do JS. CUIDADO: o APEX confere, no envio, a
     ordem dos itens contra a ordem em que a página foi desenhada — o JS move os campos para os grupos;
     sem esta troca o Pesquisar dá "Violação de proteção da página" (visto em 09/10)
Guia: LANCOCORR-MANUTENCAO.md.
"""
import os
import sys

JS = "#WORKSPACE_IMAGES#Natcorp_LancOcorr.js"
CSS = ["#WORKSPACE_IMAGES#Natcorp_HistFiltros.css", "#WORKSPACE_IMAGES#Natcorp_LancOcorr.css"]
REG_PSQ1 = '58549278215787579232'
REG_FILTROS = '12734199073572558757'
# a ordem em que o Natcorp_LancOcorr.js põe os campos (GRUPOS): mudou lá? mude aqui
ORDEM = ['P5_EMPRESAS', 'P5_DATAREF',
         'P5_FILIAIS', 'P5_CCUSTOS', 'P5_CARGOS', 'P5_MATRICULAS', 'P5_SITUACOES', 'P5_DATASIT', 'P5_MESANOSIT',
         'P5_VINCULOS', 'P5_SINDICATOS', 'P5_TIPOSAL', 'P5_TIPOPAG', 'P5_DTADMINI', 'P5_DTADMFIM',
         'P5_TIPOEVENT', 'P5_OCORRPAGTO', 'P5_DTVALINI', 'P5_DTVALFIM',
         'P5_USUARIO', 'P5_DTATLZ',
         'P5_CODAUX']                    # o escondido fica no fim: o JS deixa a região "Filtros" (vazia) depois dos grupos
MOLDURA_PADRAO = '34586999916296988390'     # a da região BLOCO (Standard) nesta app

ROTULOS = {
    "'DT. VALIDADE INICIAL'": "'Validade inicial'",
    "'DT. VALIDADE FINAL'": "'Validade final'",
    "'EMPRESAS'": "'Empresas'",
    "'CENTROS DE CUSTO'": "'Centros de custo'",
    "unistr('MATR\\00CDCULAS')": "unistr('Matr\\00EDculas')",
    "'FILIAIS'": "'Filiais'",
    "'CARGOS'": "'Cargos'",
    "unistr('DT. ADMISS\\00C3O INICIAL')": "unistr('Admiss\\00E3o inicial')",
    "unistr('DT. ADMISS\\00C3O FINAL')": "unistr('Admiss\\00E3o final')",
    "unistr('SITUA\\00C7\\00D5ES')": "unistr('Situa\\00E7\\00F5es')",
    "unistr('V\\00CDNCULOS')": "unistr('V\\00EDnculos')",
    "'SINDICATOS'": "'Sindicatos'",
    "unistr('TIPOS DE SAL\\00C1RIO')": "unistr('Tipos de sal\\00E1rio')",
    "'TIPOS DE PAGAMENTO'": "'Tipos de pagamento'",
    "unistr('PER\\00CDODOS')": "unistr('Per\\00EDodos')",
    "'TIPOS DE EVENTO'": "'Tipos de evento'",
    "unistr('OCORR\\00CANCIAS')": "unistr('Ocorr\\00EAncias')",
    "'PROCESSO'": "'Processo'",
    "unistr('DATA SITUA\\00C7\\00C3O DEMITIDO')": "unistr('Data da demiss\\00E3o')",
    "unistr('M\\00CAS/ANO SITUA\\00C7\\00C3O DEMITIDO')": "unistr('M\\00EAs/ano da demiss\\00E3o')",
    "unistr('USU\\00C1RIOS')": "unistr('Usu\\00E1rios')",
    "unistr('DT. ATUALIZA\\00C7\\00C3O')": "unistr('Data de atualiza\\00E7\\00E3o')",
}

if len(sys.argv) != 3:
    raise SystemExit(__doc__)
ent, sai = sys.argv[1], sys.argv[2]
s = open(ent, encoding='utf-8').read()

def troca(a, b):
    global s
    if s.count(a) != 1:
        raise SystemExit('esperava 1 ocorrência de: ' + a[:90] + ' (achei %d)' % s.count(a))
    s = s.replace(a, b)

if 'Natcorp_LancOcorr' in s:
    raise SystemExit('esta exportação já tem o desenho: rode sobre o .ORIGINAL.sql')
if 'p_javascript_file_urls' in s or 'p_css_file_urls' in s:
    raise SystemExit('a página já tem File URLs: juntar à mão (este script supõe que não há)')

# 1. os arquivos
troca(",p_autocomplete_on_off=>'OFF'\n,p_page_template_options=>",
      ",p_autocomplete_on_off=>'OFF'\n,p_javascript_file_urls=>'%s'\n,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(\n'%s',\n'%s'))\n,p_page_template_options=>"
      % (JS, CSS[0], CSS[1]))

# 2. a região dos filtros: moldura padrão, sem recolher
a = s.index('wwv_flow_api.create_page_plug(\n p_id=>wwv_flow_api.id(%s)' % REG_PSQ1); b = s.index('\n);', a)
reg = s[a:b]
novo = reg.replace(",p_plug_name=>unistr('Par\\00E2metros de Pesquisa')", ",p_plug_name=>'Filtros'") \
          .replace(",p_region_template_options=>'#DEFAULT#:t-Region--noPadding:is-collapsed:t-Region--noBorder:t-Region--hiddenOverflow:t-Form--noPadding:t-Form--stretchInputs:margin-top-none'",
                   ",p_region_template_options=>'#DEFAULT#:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove:margin-top-none'") \
          .replace(",p_plug_template=>wwv_flow_api.id(34586996203006988385)", ",p_plug_template=>wwv_flow_api.id(%s)" % MOLDURA_PADRAO)
if novo.count("'Filtros'") != 1 or MOLDURA_PADRAO not in novo or 'is-collapsed' in novo:
    raise SystemExit('a região PSQ1 não veio como esperado')
s = s[:a] + novo + s[b:]

# 3. os rótulos
for velho, n in ROTULOS.items():
    troca("\n,p_prompt=>" + velho + "\n", "\n,p_prompt=>" + n + "\n")

# 4. a ordem dos campos da região Filtros
import re
for n, nome in enumerate(ORDEM):
    i = s.find(",p_name=>'%s'\n" % nome)
    if i < 0:
        raise SystemExit('campo não encontrado: ' + nome)
    a = s.rfind('wwv_flow_api.create_page_item(', 0, i); b = s.index('\n);', i)
    it = s[a:b]
    if "p_item_plug_id=>wwv_flow_api.id(%s)" % REG_FILTROS not in it:
        raise SystemExit('campo fora da região Filtros: ' + nome)
    novo_it, k = re.subn(r"\n,p_item_sequence=>\d+", "\n,p_item_sequence=>%d" % ((n + 1) * 10), it)
    if k != 1:
        raise SystemExit('sequência não encontrada: ' + nome)
    s = s[:a] + novo_it + s[b:]
# todos os campos da região Filtros estão na ORDEM? (um campo novo na página quebraria o envio)
import collections
nos_filtros = re.findall(r"p_name=>'(P5_\w+)'\n,p_item_sequence=>\d+\n,p_item_plug_id=>wwv_flow_api\.id\(%s\)" % REG_FILTROS, s)
fora = sorted(set(nos_filtros) - set(ORDEM))
if fora:
    raise SystemExit('campos da região Filtros fora da ORDEM (ponha no JS e aqui): ' + ', '.join(fora))

ruim = sorted({c for c in s if ord(c) > 255})
if ruim:
    raise SystemExit('caracteres fora do Latin-1: ' + ' '.join(ruim))
open(sai, 'w', encoding='utf-8').write(s)
print(os.path.basename(sai), len(s.encode()) // 1024, 'KB · File URLs, Filtros (moldura padrão), %d rótulos' % len(ROTULOS))
