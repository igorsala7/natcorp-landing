#!/usr/bin/env python3
"""Calcula `larg` e `esq` das figuras dos cartões de portal.

POR QUE ISTO EXISTE

As duas pessoas de um cartão precisam sair na MESMA escala e lado a lado. Cada
arquivo vem do gerador com um enquadramento diferente, então largura igual em
CSS não significa tamanho igual na tela — é o que deixa uma cabeça maior que a
outra. A conta está descrita em src/assets/portals/LEIA-ME-figuras.md; aqui ela
vira código, para não ser refeita a olho a cada figura nova.

A ESCALA iguala a ALTURA EXIBIDA das duas figuras. O LEIA-ME sugere a mediana de
três invariantes (cabeça, ombro, corpo), mas os três pares que já estão no ar não
seguem isso — eles batem a altura exibida ao pixel (507/508, 457/457, 504/504), e
é essa a regra. A mediana, medida aqui, REPROVA: a `colaborador-dupla` é a moça de
cabelo comprido e mede "cabeça" 56px contra 214px da parceira, porque sem pescoço
estreito visível o mínimo cai no lugar errado. Isso contamina a mediana e dá 185
onde o código usa 135.

A POSIÇÃO sai dos extremos opacos dentro da faixa que o cartão mostra, lembrando
que espelhar TROCA as bordas de lado.

USO
    python3 scripts/medir-figuras.py figure-chamado.webp figure-chamado-dupla.webp
"""
import argparse
from pathlib import Path

import numpy as np
from PIL import Image

RAIZ = Path(__file__).resolve().parent.parent / "src/assets/portals"

# Altura exibida que as figuras devem ter, em px. Dois dos três pares no ar usam
# ~505 (o terceiro, o do Gestor, ficou em 457); 505 é a família maior e é o que
# deixa a figura preencher o palco de 200px sem o rosto sumir.
ALTURA_ALVO = 505
# O palco do cartão tem 220px de altura e a figura começa em `topo`.
TOPO = 20
FAIXA = 220 - TOPO
# Folga entre as duas pessoas.
FOLGA = 16
# Largura do palco na grade de 3 colunas, medida no navegador (não os 372 que o
# LEIA-ME estimava).
PALCO = 395
# Quanto do palco a dupla pode ocupar. Os três pares que já estão no ar ficam em
# 78%, 86% e 90% — a folga nas laterais é parte da composição. Encher os 100%
# foi o que deixou os cartões novos com as figuras coladas na borda.
OCUPACAO = 0.86
LARGURA_MAX = PALCO * OCUPACAO


def silhueta(nome: str) -> np.ndarray:
    im = Image.open(RAIZ / nome).convert("RGBA")
    return np.asarray(im.getchannel("A")) > 40


def altura_silhueta(a: np.ndarray) -> tuple[int, int, int]:
    """(topo, base, altura) da silhueta, em px do arquivo."""
    linhas = a.any(axis=1)
    topo = int(np.argmax(linhas))
    base = len(linhas) - int(np.argmax(linhas[::-1]))
    return topo, base, base - topo


def escala(nome: str, alvo: float = ALTURA_ALVO) -> tuple[int, int]:
    """Largura em CSS que faz a figura ser exibida com `alvo` px de altura."""
    a = silhueta(nome)
    _, _, corpo = altura_silhueta(a)
    return round(a.shape[1] * alvo / corpo), corpo


def extremos_na_faixa(nome: str, larg: int, espelhado: bool) -> tuple[float, float]:
    """Bordas opacas (esquerda, direita) em px de tela, dentro da faixa visível."""
    a = silhueta(nome)
    esc = larg / a.shape[1]
    linhas_visiveis = int(round(FAIXA / esc))
    visivel = a[:linhas_visiveis]
    colunas = visivel.any(axis=0)
    if not colunas.any():
        return 0.0, float(larg)
    e = int(np.argmax(colunas))
    d = len(colunas) - int(np.argmax(colunas[::-1]))
    if espelhado:  # espelhar troca as bordas de lado
        e, d = a.shape[1] - d, a.shape[1] - e
    return e * esc, d * esc


def calcula(principal: str, dupla: str | None, altura: float) -> None:
    lp, _ = escala(principal, altura)
    if not dupla:
        pe, pd = extremos_na_faixa(principal, lp, False)
        print(f"  altura exibida: {altura:.0f}px")
        print(f"\n  principal: {{ larg: {lp}, esq: {round(-(pd - pe) / 2 - pe)}, topo: {TOPO} }},")
        return

    ld, _ = escala(dupla, altura)

    # A dupla é espelhada, para as duas não olharem para o mesmo lado.
    pe, pd = extremos_na_faixa(principal, lp, False)
    de, dd = extremos_na_faixa(dupla, ld, True)
    larg_p, larg_d = pd - pe, dd - de
    total = larg_p + FOLGA + larg_d

    # Se a dupla não couber no cartão mais estreito, encolhe as DUAS juntas —
    # encolher uma só quebraria a igualdade de altura, que é o ponto do cálculo.
    if total > LARGURA_MAX:
        menor = altura * LARGURA_MAX / total
        print(f"  passou da folga em {altura:.0f}px de altura ({total:.0f} > {LARGURA_MAX:.0f}) — refazendo as duas com {menor:.0f}px")
        return calcula(principal, dupla, menor)

    x_d = -total / 2
    x_p = x_d + larg_d + FOLGA
    print(f"  silhuetas: dupla {larg_d:.0f} + folga {FOLGA} + principal {larg_p:.0f} = {total:.0f}px ({total/PALCO*100:.0f}% do palco) ✓")
    print(f"  altura exibida: {altura:.0f}px nas duas")
    print(f"\n  principal: {{ larg: {lp}, esq: {round(x_p - pe)}, topo: {TOPO} }},")
    print(f"  dupla:     {{ larg: {ld}, esq: {round(x_d - de)}, topo: {TOPO}, espelhado: true }},")


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("principal")
    ap.add_argument("dupla", nargs="?")
    ap.add_argument("--altura", type=float, default=ALTURA_ALVO)
    a = ap.parse_args()
    calcula(a.principal, a.dupla, a.altura)


if __name__ == "__main__":
    main()
