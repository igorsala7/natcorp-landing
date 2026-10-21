"""Monta o app 9503 INTEIRO (f9503.sql) com os desenhos entregues nas páginas dele.

    python3 montar-f9503.py              (lê f9503.ORIGINAL.sql, escreve f9503.sql)

Parte da exportação completa do app, intocada: f9503.ORIGINAL.sql (19/10 14:24, 42 páginas; a de
09/10 16:12 ficou em f9503.ORIGINAL-0910.sql). Cada exportação vem de uma base: os IDs mudam de
uma para outra por um deslocamento fixo (a de 19/10 = a de 09/10 + 3135841945794677638), mas os
scripts não dependem disso.
Cada página é recortada ("prompt --application/pages/page_NNNNN" até o próximo "prompt
--application/"), passa pelo script dela e volta ao lugar. Os scripts acham tudo pelos NOMES de
itens, botões e regiões, nunca pelos IDs: valem sobre a página como está no app — inclusive com as
mudanças da equipe feitas depois das exportações avulsas (179: lista de jornadas pelo
pkg_list_jornada; 181: condição do Criar pelo perfil de aprovação e a validação "Total de horas x
Banco Remaneceste"; 13/10, 179: ação "No pg sempre exceção igual a SIM", que põe P179_EXCECAO = S
no pedido novo pelo painel PG — o desenho acompanha, porque redesenha a cada change e ajax), que ficam.

  179  Requisição de Escala ........ aplicar-escala-pagina179.py   (Natcorp_Escala)
  181  Requisição de Apuração ...... aplicar-apuracao-pagina181.py (Natcorp_Apuracao)
  203  Tratativa de Abono .......... aplicar-ponto-pagina203.py    (Natcorp_Ponto + botão "Ajustar vários dias")
  714  Marcação - Abono ............ aplicar-abono-pagina714.py    (Natcorp_Abono)
  716  Requisição de Hora Extra .... aplicar-horaextra.py          (Natcorp_HoraExtra)
  204  Abono Individual (lista) .... aplicar-pontopainel-pagina204.py (painel Conferência do ponto:
                                  Natcorp_PontoPainel + NC_PONTO_INDICADORES, 19/10)
  715  Ajustar vários dias (NOVA) .. gerar-pagina715.py, com os modelos da 714 DESTE app

CUIDADO: importar o app inteiro substitui tudo. Só importar se ninguém mexeu no 9503 depois da
exportação (14:24 de 19/10); se passou tempo, pedir uma exportação nova e rodar de novo.
Os PL/SQL da 715 (NC_LOTE_DIAS, NC_LOTE_CRIAR) nunca rodaram num Oracle: testar um dia antes de lote.
"""
import os
import re
import subprocess
import sys
import tempfile

AQUI = os.path.dirname(os.path.abspath(__file__))
ENT = os.path.join(AQUI, 'f9503.ORIGINAL.sql')
SAI = os.path.join(AQUI, 'f9503.sql')
PAGINAS = [(179, 'aplicar-escala-pagina179.py', 'Natcorp_Escala'),
           (181, 'aplicar-apuracao-pagina181.py', 'Natcorp_Apuracao'),
           (203, 'aplicar-ponto-pagina203.py', 'Natcorp_Ponto'),
           (714, 'aplicar-abono-pagina714.py', 'Natcorp_Abono'),
           (716, 'aplicar-horaextra.py', 'Natcorp_HoraExtra'),
           (204, 'aplicar-pontopainel-pagina204.py', 'Natcorp_PontoPainel')]

app = open(ENT, encoding='utf-8').read()
if "prompt --application/pages/page_00715\n" in app:
    sys.exit('a exportação já tem a página 715: conferir à mão antes de montar')
cab_ref = open(os.path.join(AQUI, 'f9503_page_714.ORIGINAL.sql'), encoding='utf-8').read()
fim_ref = cab_ref[cab_ref.index('prompt --application/end_environment'):]
cab_ref = cab_ref[:cab_ref.index('prompt --application/pages/delete_00714')]


def limites(t, n):
    a = t.index('prompt --application/pages/page_%05d\n' % n)
    return a, t.index('prompt --application/', a + 10)


def rodar(args):
    r = subprocess.run([sys.executable] + args, cwd=AQUI, capture_output=True, text=True)
    if r.returncode:
        sys.exit('falhou: %s\n%s%s' % (' '.join(args), r.stdout, r.stderr))
    return r.stdout.strip()


conferir = []
with tempfile.TemporaryDirectory() as tmp:
    for n, script, marca in PAGINAS:
        a, b = limites(app, n)
        bloco = app[a:b]
        if marca in bloco:
            sys.exit('a página %d do app já tem %s: conferir à mão' % (n, marca))
        arq = os.path.join(tmp, 'p%d.sql' % n)
        open(arq, 'w', encoding='utf-8').write(bloco)
        rodar([script, arq, arq])
        novo = open(arq, encoding='utf-8').read()
        if marca not in novo or not novo.startswith('prompt --application/pages/page_%05d\n' % n):
            sys.exit('a página %d não saiu como esperado' % n)
        app = app[:a] + novo + app[b:]
        conferir.append((n, marca, len(novo) - len(bloco)))

    # a 715 (nova): gerada com a 714 do app como referência (modelos de página e região deste app)
    a, b = limites(app, 714)
    ref = os.path.join(tmp, 'ref714.sql')
    open(ref, 'w', encoding='utf-8').write(cab_ref + 'prompt --application/pages/delete_00714\n' + app[a:b] + fim_ref)
    p715 = os.path.join(tmp, 'p715.sql')
    rodar(['gerar-pagina715.py', ref, p715])
    t = open(p715, encoding='utf-8').read()
    i = t.index('prompt --application/pages/page_00715\n')
    j = t.index('prompt --application/end_environment', i)
    bloco715 = t[i:j]
    a, b = limites(app, 714)                       # entra logo depois da 714
    app = app[:b] + bloco715 + app[b:]
    conferir.append((715, 'Natcorp_Lote', len(bloco715)))

app = re.sub(r'(--     Pages:\s+)(\d+)', lambda m: m.group(1) + str(int(m.group(2)) + 1), app, count=1)
fora = sorted({c for c in app if ord(c) > 255})
if fora:
    sys.exit('caractere fora do Latin-1 na exportação (o banco não guarda): %r' % fora)
open(SAI, 'w', encoding='utf-8').write(app)
for n, marca, d in conferir:
    print('página %d: %s (%+d caracteres)' % (n, marca, d))
print('ok ->', SAI)
