"""Transplanta a EXPORTAÇÃO DE UMA PÁGINA do APEX para outra aplicação, outro workspace ou outra
base — sem instalar o app inteiro por cima.

    python3 transplantar-pagina.py PAGINA.sql --destino DESTINO.sql [--origem ORIGEM.sql] [-o SAIDA.sql]

  PAGINA.sql   a página exportada (Export de página/componente) do app de origem
  --destino    a exportação COMPLETA do app de destino (ou, no modo "mesma linhagem", qualquer
               exportação de página do destino, se não houver a completa)
  --origem     a exportação completa do app de origem — só é preciso quando os dois apps NÃO são
               cópias um do outro (modo "por nome")
  -o           o arquivo gerado (padrão: <pagina>.para-<app destino>.sql)

POR QUE O APEX RECUSA E O QUE ESTE SCRIPT FAZ
  O cabeçalho (wwv_flow_api.import_begin) diz o workspace, o app, o deslocamento e o dono de
  origem, e a página aponta para os componentes compartilhados (modelos, lista de valores,
  autorização, interface, breadcrumb, grupo de páginas…) PELO ID. Numa outra cópia do app os
  mesmos componentes têm outros IDs. O script:
    1. troca o cabeçalho pelo do destino (workspace, app, deslocamento, dono);
    2. traduz os IDs:
       · modo "mesma linhagem" (cópias do mesmo app: 200, 202, 207…): todo ID difere por uma
         constante. Ela é MEDIDA contra o destino (primeiro pela diferença dos deslocamentos do
         cabeçalho, depois pela interface de usuário) e só é aceita se TODAS as referências
         externas da página existirem no destino;
       · modo "por nome" (apps diferentes): cada referência externa vira o componente do destino
         com o mesmo tipo e nome (e o mesmo "pai", quando há); os componentes da própria página
         ganham IDs novos, conferidos contra os do destino;
    3. confere e relata: o que foi traduzido, o que não tem correspondente, colisão de IDs,
       links com o número do app de origem escrito à mão, versão do APEX.
  Nada é importado: o resultado é um .sql para importar pelo App Builder do destino, como se a
  página tivesse sido exportada lá.

LIMITES (o script para e explica, em vez de gerar arquivo que quebra na instalação)
  · versão: destino mais ANTIGO que a origem ainda não é tratado (parâmetros do create_* mudam
    entre 5.0, 5.1, 18.2 e 19.2);
  · componente compartilhado que não existe no destino (modelo renomeado, lista de valores só de
    um lado): listado, e nada é gerado;
  · tabelas, pacotes e funções usados no SQL/PL/SQL da página precisam existir no esquema de
    destino — isso o script não tem como conferir.
  A página de destino é SUBSTITUÍDA inteira (o arquivo começa com remove_page): exporte a de lá
  antes, como cópia de segurança.
"""
import argparse
import os
import re
import sys

RE_ID = re.compile(r'wwv_flow_api\.id\((\d+)\)')
RE_BLOCO = re.compile(r'wwv_flow_api\.(create_[a-z_0-9]+)\(\n p_id=>wwv_flow_api\.id\((\d+)\)(.*?)\n\);', re.S)
RE_CAB = re.compile(r'wwv_flow_api\.import_begin \(\n.*?\n\);', re.S)
# o "pai" que distingue componentes de mesmo nome (opção de um modelo, item de uma lista…)
PAIS = ('p_row_template_id', 'p_list_id', 'p_menu_id', 'p_plugin_id', 'p_plug_template_id', 'p_template_id',
        'p_page_template_id', 'p_lov_id', 'p_group_id', 'p_theme_style_id', 'p_ui_id', 'p_user_interface_id')


def ler(f):
    return open(f, encoding='utf-8', errors='replace').read()


def cabecalho(s):
    m = RE_CAB.search(s)
    if not m:
        sys.exit('não achei o import_begin em um dos arquivos: é mesmo uma exportação do APEX?')
    c = m.group(0)
    def v(k):
        x = re.search(r'p_' + k + r"=>'?([^'\n]*)'?", c)
        return x.group(1) if x else ''
    return {'texto': c, 'release': v('release'), 'workspace': v('default_workspace_id'), 'app': v('default_application_id'),
            'offset': int(v('default_id_offset') or 0), 'owner': v('default_owner')}


def versao(r):
    return tuple(int(x) for x in re.findall(r'\d+', r)[:3])


def catalogo(s):
    """id → (tipo, nome, bloco) de tudo que o arquivo define"""
    cat = {}
    for m in RE_BLOCO.finditer(s):
        t = m.group(3)
        nm = re.search(r"^,p_[a-z_]*name=>(.*)$", t, re.M)
        # o mesmo id pode ser definido duas vezes (create_row_template e o create_row_template_patch
        # que o estende): vale o primeiro, que é o componente com nome
        cat.setdefault(int(m.group(2)), (m.group(1), nm.group(1).strip() if nm else '', t))
    return cat


def chave(cat, i, pilha=()):
    """tipo + nome + tema + pais, para achar o mesmo componente no outro app"""
    if i not in cat or i in pilha:
        return None
    tipo, nome, t = cat[i]
    tema = re.search(r'^,p_theme_id=>(\d+)', t, re.M)
    pais = []
    for p in PAIS:
        m = re.search(r'^,' + p + r'=>wwv_flow_api\.id\((\d+)\)', t, re.M)
        if m:
            pais.append((p, chave(cat, int(m.group(1)), pilha + (i,))))
    return (tipo, nome, tema.group(1) if tema else '', tuple(pais))


def main():
    ap = argparse.ArgumentParser(description='Transplanta uma página exportada do APEX para outro app/workspace/base.')
    ap.add_argument('pagina')
    ap.add_argument('--destino', required=True)
    ap.add_argument('--origem')
    ap.add_argument('-o', '--saida')
    ap.add_argument('--por-nome', action='store_true', help='não tenta a constante: traduz tudo por nome (precisa de --origem)')
    a = ap.parse_args()

    pg = ler(a.pagina)
    dst = ler(a.destino)
    cp, cd = cabecalho(pg), cabecalho(dst)
    if 'Export Type:     Page Export' not in pg and 'Export Type:     Component Export' not in pg:
        sys.exit(a.pagina + ' não é exportação de página/componente')
    if versao(cd['release']) < versao(cp['release']):
        sys.exit('o destino (%s) é mais antigo que a origem (%s): descida de versão ainda não é tratada' % (cd['release'], cp['release']))

    pagina_n = re.search(r'remove_page \(p_flow_id=>wwv_flow\.g_flow_id, p_page_id=>(\d+)\)', pg)
    pagina_n = pagina_n.group(1) if pagina_n else '?'
    cat_pg = catalogo(pg)
    internos = set(cat_pg)
    refs = [int(x) for x in RE_ID.findall(pg)]
    externos = sorted(set(r for r in refs if r not in internos))
    cat_d = catalogo(dst)
    ids_d = set(cat_d)
    destino_completo = 'Export Type:     Application Export' in dst
    if not destino_completo:
        # só uma página do destino: os componentes compartilhados não estão definidos nela, mas os
        # que ela USA aparecem como referência — são os únicos que dá para conferir
        ids_d |= set(int(x) for x in RE_ID.findall(dst))
    # os ids da MESMA página no destino podem ser reaproveitados (ela é substituída)
    pag_d = set()
    m = re.search(r'prompt --application/pages/page_%05d\n(.*?)(?=prompt --application/pages/page_\d{5}\n|prompt --application/(deployment|end_environment))' % int(pagina_n) if pagina_n != '?' else r'$^', dst, re.S)
    if m:
        pag_d = set(int(x) for x in re.findall(r'\n p_id=>wwv_flow_api\.id\((\d+)\)', m.group(1)))

    rel = []
    mapa = None
    modo = ''

    # ---- modo "mesma linhagem": uma constante vale para tudo ----
    candidatos = [('diferença dos deslocamentos do cabeçalho', cd['offset'] - cp['offset'])]
    ui = re.search(r'p_user_interface_id=>wwv_flow_api\.id\((\d+)\)', pg)
    if ui:
        for i, (tipo, nome, _) in cat_d.items():
            if tipo == 'create_user_interface':
                candidatos.append(('interface de usuário %s do destino' % nome, i - int(ui.group(1))))
        ui_d = re.search(r'p_user_interface_id=>wwv_flow_api\.id\((\d+)\)', dst)
        if not destino_completo and ui_d:
            candidatos.append(('interface de usuário da página do destino', int(ui_d.group(1)) - int(ui.group(1))))
    for motivo, d in ([] if a.por_nome else candidatos):
        faltam = [e for e in externos if e + d not in ids_d]
        if not faltam:
            mapa = lambda x, d=d: x + d
            modo = 'mesma linhagem (constante %d, pela %s)' % (d, motivo)
            break
        if not destino_completo and motivo.startswith('interface') and len(faltam) < len(externos):
            # com só uma página de referência, o que ela não usa não tem como ser conferido
            mapa = lambda x, d=d: x + d
            modo = 'mesma linhagem (constante %d, pela %s)' % (d, motivo)
            rel.append('NÃO CONFERIDO: %d de %d referências externas não aparecem na página de referência do destino '
                       '(ela não usa esses componentes). Com a exportação COMPLETA do destino dá para conferir todas.'
                       % (len(faltam), len(externos)))
            break

    # ---- modo "por nome": precisa do catálogo da origem ----
    if mapa is None:
        if not a.origem:
            sys.exit('os apps não parecem cópias um do outro (nenhuma constante cobre as %d referências externas).\n'
                     'Passe também --origem com a exportação COMPLETA do app de origem para traduzir por nome.' % len(externos))
        cat_o = catalogo(ler(a.origem))
        por_chave = {}
        for i in cat_d:
            por_chave.setdefault(chave(cat_d, i), []).append(i)
        trad, sem, dup = {}, [], []
        for e in externos:
            k = chave(cat_o, e)
            alvo = por_chave.get(k, []) if k else []
            if len(alvo) == 1:
                trad[e] = alvo[0]
            elif not alvo:
                sem.append((e, cat_o.get(e, ('?', '?', ''))[:2]))
            else:
                dup.append((e, cat_o[e][:2], len(alvo)))
        if sem or dup:
            for e, (t, n) in sem:
                rel.append('SEM CORRESPONDENTE no destino: %s %s (id %d na origem)' % (t, n, e))
            for e, (t, n), q in dup:
                rel.append('AMBÍGUO no destino (%d iguais): %s %s' % (q, t, n))
            print('\n'.join(rel))
            sys.exit('nada foi gerado: resolva as referências acima (crie/renomeie no destino) e rode de novo')
        d_int = cd['offset'] - cp['offset']
        colide = [i for i in internos if i + d_int in ids_d and i + d_int not in pag_d]
        if colide:
            sys.exit('%d ids da página colidiriam com componentes do destino; nada foi gerado' % len(colide))
        mapa = lambda x: trad[x] if x in trad else x + d_int
        modo = 'por nome (%d referências traduzidas; ids da página deslocados em %d)' % (len(trad), d_int)

    # ---- conferências ----
    novos_int = set(mapa(i) for i in internos)
    colide = sorted(i for i in novos_int if i in ids_d and i not in pag_d)
    if colide:
        sys.exit('%d ids da página cairiam em componentes de OUTRA parte do destino (ex.: %d); nada foi gerado' % (len(colide), colide[0]))

    # ---- o novo arquivo ----
    novo = RE_ID.sub(lambda m: 'wwv_flow_api.id(%d)' % mapa(int(m.group(1))), pg)
    novo = novo.replace(RE_CAB.search(novo).group(0), cd['texto'], 1)
    novo = re.sub(r'^prompt APPLICATION \d+ - ', 'prompt APPLICATION %s - ' % cd['app'], novo, count=1, flags=re.M)
    novo = re.sub(r'^(--   Application:\s+)\d+', lambda m: m.group(1) + cd['app'], novo, count=1, flags=re.M)
    # links com o número do app de ORIGEM escrito à mão (o &APP_ID. já se ajusta sozinho)
    for mm in sorted(set(re.findall(r"f\?p=%s:[^'\"\s]{0,40}" % re.escape(cp['app']), pg))):
        rel.append('ATENÇÃO link fixo para o app de origem (%s): %s' % (cp['app'], mm))
    if cp['owner'] and cp['owner'] != cd['owner'] and re.search(r'\b%s\.' % re.escape(cp['owner']), pg, re.I):
        rel.append('ATENÇÃO o código cita o esquema de origem (%s.) explicitamente' % cp['owner'])

    saida = a.saida or re.sub(r'\.sql$', '', a.pagina) + '.para-%s.sql' % cd['app']
    open(saida, 'w', encoding='utf-8').write(novo)
    print('página %s: app %s (%s, %s) → app %s (%s, %s)' % (pagina_n, cp['app'], cp['owner'], cp['release'], cd['app'], cd['owner'], cd['release']))
    print('modo:', modo)
    print('componentes da página: %d · referências externas: %d' % (len(internos), len(externos)))
    if pag_d:
        print('a página %s do destino será SUBSTITUÍDA (%d componentes lá hoje) — exporte-a antes, como cópia' % (pagina_n, len(pag_d)))
    for r in rel:
        print(r)
    print('gerado:', saida)


if __name__ == '__main__':
    main()
