#!/usr/bin/env python3
"""Recorta o fundo branco das figuras 3D dos portais e exporta em WebP com alfa.

POR QUE ISTO EXISTE

O modelo de imagem não entrega alfa de verdade. Se o prompt pedir "fundo
transparente", ele DESENHA o xadrez cinza — que vira parte da figura. Então se
pede fundo branco liso e recorta aqui.

POR QUE FLOOD FILL, E NÃO "APAGUE O QUE FOR BRANCO"

Limiar simples come o que é branco DENTRO da silhueta: tênis brancos, a camisa
sob o blazer, a folha de papel na mão, o reflexo no tablet. O fundo é o branco
LIGADO À BORDA da imagem — essa é a definição que vale. O preenchimento parte
das quatro bordas e só remove o que alcança a partir dali; branco cercado por
figura fica.

O preenchimento é por faixas (scanline), não pixel a pixel: numa imagem 2K o
segundo demora minutos em Python e este termina em menos de um segundo.

USO
    python3 scripts/recorta.py entrada.png saida.webp [--largura 360]
"""
import argparse
import sys
from pathlib import Path

import numpy as np
from PIL import Image, ImageFilter

# Branco do fundo: claro o bastante E sem cor. Os dois critérios juntos, porque
# o degradê suave do render encosta em 240 numa camisa clara — o que salva é
# ela ter matiz, e o fundo não.
CLARO = 236
SEM_COR = 16


def mascara_de_fundo(rgb: np.ndarray) -> np.ndarray:
    """True onde o pixel é branco liso E alcançável a partir da borda."""
    alto = rgb.max(axis=2).astype(np.int16)
    baixo = rgb.min(axis=2).astype(np.int16)
    branco = (baixo >= CLARO) & ((alto - baixo) <= SEM_COR)

    h, w = branco.shape
    fundo = np.zeros((h, w), dtype=bool)

    # Sementes: todo pixel branco encostado numa das quatro bordas.
    pilha = []
    for x in np.flatnonzero(branco[0]):
        pilha.append((int(x), 0))
    for x in np.flatnonzero(branco[h - 1]):
        pilha.append((int(x), h - 1))
    for y in np.flatnonzero(branco[:, 0]):
        pilha.append((0, int(y)))
    for y in np.flatnonzero(branco[:, w - 1]):
        pilha.append((w - 1, int(y)))

    while pilha:
        x, y = pilha.pop()
        if fundo[y, x] or not branco[y, x]:
            continue
        # Abre a faixa contígua de branco nesta linha, para os dois lados.
        esq = x
        while esq > 0 and branco[y, esq - 1] and not fundo[y, esq - 1]:
            esq -= 1
        dir_ = x
        while dir_ < w - 1 and branco[y, dir_ + 1] and not fundo[y, dir_ + 1]:
            dir_ += 1
        fundo[y, esq : dir_ + 1] = True
        # Semeia as linhas vizinhas: uma semente por sub-faixa branca ainda aberta.
        for vy in (y - 1, y + 1):
            if vy < 0 or vy >= h:
                continue
            livre = branco[vy, esq : dir_ + 1] & ~fundo[vy, esq : dir_ + 1]
            if not livre.any():
                continue
            # Início de cada sub-faixa: onde livre passa de False para True.
            bordas = np.flatnonzero(livre & ~np.concatenate(([False], livre[:-1])))
            for b in bordas:
                pilha.append((esq + int(b), vy))

    return fundo


def recorta(entrada: Path, saida: Path, largura: int) -> None:
    im = Image.open(entrada).convert("RGB")
    rgb = np.asarray(im)
    fundo = mascara_de_fundo(rgb)

    if not (~fundo).any():
        sys.exit(f"recorta: {entrada.name} ficou vazia — o fundo não era branco liso?")

    alfa = np.where(fundo, 0, 255).astype(np.uint8)
    out = Image.fromarray(np.dstack([rgb, alfa]), "RGBA")

    # Corta na silhueta antes de redimensionar: a margem branca do render varia
    # de imagem para imagem, e é ela que faria duas figuras saírem em escalas
    # diferentes com a mesma largura em CSS.
    caixa = out.getchannel("A").getbbox()
    out = out.crop(caixa)

    alt = round(out.height * largura / out.width)
    out = out.resize((largura, alt), Image.LANCZOS)

    # Um toque de desfoque SÓ no alfa tira a escadinha da borda que o corte
    # binário deixa. No RGB estragaria o desenho.
    a = out.getchannel("A").filter(ImageFilter.GaussianBlur(0.6))
    out.putalpha(a)

    saida.parent.mkdir(parents=True, exist_ok=True)
    out.save(saida, "WEBP", quality=88, method=6)
    kb = saida.stat().st_size / 1024
    print(f"recorta: {saida.name}  {largura}x{alt}  {kb:.0f} KB")


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("entrada", type=Path)
    ap.add_argument("saida", type=Path)
    ap.add_argument("--largura", type=int, default=360, help="largura final (padrão 360, como as figuras antigas)")
    a = ap.parse_args()
    recorta(a.entrada, a.saida, a.largura)
