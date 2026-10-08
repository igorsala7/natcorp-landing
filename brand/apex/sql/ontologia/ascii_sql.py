"""Deixa os .sql desta pasta só com ASCII, para rodarem iguais em qualquer cliente (SQL*Plus, SQLcl,
SQL Developer, APEX SQL Workshop), qualquer que seja o NLS_LANG.

    python3 ascii_sql.py            converte 00..05 (os outros já saem em ASCII dos geradores)

  • texto entre aspas com acento  →  to_char(unistr('...\\00E7...'))   (VARCHAR2, o caractere certo)
  • comentário e linha "prompt"   →  sem acento ("Ç" vira "C"; molduras viram = - |)
Rodar de novo não muda nada (o que já é ASCII fica como está).
"""
import os
import sys
import unicodedata

AQUI = os.path.dirname(os.path.abspath(__file__))
TROCAS = {'═': '=', '─': '-', '║': '|', '╔': '+', '╗': '+', '╚': '+', '╝': '+', '→': '->', '←': '<-',
          '—': '-', '…': '...', '≈': '~', '×': 'x', '÷': '/', '≥': '>=', '≤': '<=', '⇄': '<->', '•': '*',
          '┌': '+', '┐': '+', '└': '+', '┘': '+', '├': '+', '┤': '+', '┬': '+', '┴': '+', '┼': '+', '│': '|', 'Σ': 'soma', '·': '-', '✓': 'v', '✗': 'x'}


def sem_acento(t):
    t = ''.join(TROCAS.get(c, c) for c in t)
    t = ''.join(c for c in unicodedata.normalize('NFD', t) if unicodedata.category(c) != 'Mn')
    return t


def literal(conteudo):
    """conteúdo SEM as aspas externas (com '' internos) → literal SQL"""
    if all(ord(c) < 128 for c in conteudo):
        return "'" + conteudo + "'"
    # to_char: unistr devolve NVARCHAR2, e misturar com VARCHAR2 num CASE/UNION dá ORA-12704
    return "to_char(unistr('" + ''.join(
        '\\005C' if c == '\\' else (c if ord(c) < 128 else '\\%04X' % ord(c)) for c in conteudo) + "'))"


def converter(sql):
    out, i, n = [], 0, len(sql)
    inicio_linha = True
    while i < n:
        c = sql[i]
        if inicio_linha:
            fim = sql.find('\n', i)
            fim = n if fim < 0 else fim
            linha = sql[i:fim]
            if linha.lstrip().lower().startswith(('prompt', 'rem ')):
                out.append(sem_acento(linha)); i = fim; inicio_linha = False
                continue
        inicio_linha = False
        if c == '-' and sql.startswith('--', i):
            fim = sql.find('\n', i); fim = n if fim < 0 else fim
            out.append(sem_acento(sql[i:fim])); i = fim
        elif c == '/' and sql.startswith('/*', i):
            fim = sql.find('*/', i + 2); fim = n if fim < 0 else fim + 2
            out.append(sem_acento(sql[i:fim])); i = fim
        elif c == "'":
            j = i + 1
            while j < n:
                if sql[j] == "'" and j + 1 < n and sql[j + 1] == "'":
                    j += 2
                elif sql[j] == "'":
                    break
                else:
                    j += 1
            out.append(literal(sql[i + 1:j])); i = j + 1
        else:
            if c == '\n':
                inicio_linha = True
            out.append(c if ord(c) < 128 else sem_acento(c)); i += 1
    r = ''.join(out)
    sobra = sorted({ch for ch in r if ord(ch) > 127})
    if sobra:
        raise SystemExit('sobrou caractere não ASCII: %r' % sobra)
    return r


if __name__ == '__main__':
    arquivos = sys.argv[1:] or ['00_conferir.sql', '01_tabelas.sql', '02_ont_texto.sql', '03_visoes.sql',
                                '04_ont_ontologia.sql', '05_ont_aderencia.sql', '06_municipios.sql', '08_rotina.sql', '99_remover.sql']
    for a in arquivos:
        p = os.path.join(AQUI, a)
        antes = open(p, encoding='utf-8').read()
        depois = converter(antes)
        if depois != antes:
            open(p, 'w', encoding='ascii').write(depois)
            print('convertido:', a)
        else:
            print('já ASCII:  ', a)
