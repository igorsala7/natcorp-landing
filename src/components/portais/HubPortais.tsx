import { useReducedMotion } from 'motion/react'

/**
 * A arte do hero dos portais: cinco linhas de fluxo que atravessam a tela,
 * o módulo da marca em camadas e um módulo de vidro pousado embaixo.
 *
 * Os traçados vieram do desenho original — não são aproximação. A animação,
 * que lá era feita por JS quadro a quadro, aqui é `stroke-dashoffset` em CSS:
 * mesma leitura, sem custo de JavaScript e sem repintar a cada quadro.
 */

/** As cinco curvas paralelas, deslocadas 44 unidades entre si. */
const LINHAS = [
  'M-128 945 C 412 905, 712 725, 992 645 S 1492 425, 2352 365',
  'M-128 989 C 412 949, 712 751, 992 671 S 1492 455, 2352 395',
  'M-128 1033 C 412 993, 712 777, 992 697 S 1492 485, 2352 425',
  'M-128 1077 C 412 1037, 712 803, 992 723 S 1492 515, 2352 455',
  'M-128 1121 C 412 1081, 712 829, 992 749 S 1492 545, 2352 485',
]

/** O contorno do módulo Natcorp, no sistema de coordenadas do desenho. */
const MODULO =
  'M1588 -114 L1889 226 C1986 336 1986 514 1889 624 L1588 964 C1491 1074 1333 1074 1236 964 L935 624 C838 514 838 336 935 226 L1236 -114 C1333 -224 1491 -224 1588 -114 Z'

export function HubPortais({ className }: { className?: string }) {
  const reduzido = useReducedMotion() ?? false
  /** Cada pacote entra num tempo diferente, senão os cinco andam em bloco. */
  const atraso = [0, -1.4, -2.8, -4.2, -5.6]

  return (
    <svg
      viewBox="-88 -375 2400 1600"
      preserveAspectRatio="xMidYMid meet"
      className={className}
      aria-hidden
      focusable="false"
    >
      <defs>
        <linearGradient id="hub-edge" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#F3C9DA" stopOpacity="0.95" />
          <stop offset="0.5" stopColor="#E4A9C4" stopOpacity="0.75" />
          <stop offset="1" stopColor="#C95788" stopOpacity="0.4" />
        </linearGradient>
        <linearGradient id="hub-edge2" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#E4A9C4" stopOpacity="0.9" />
          <stop offset="0.5" stopColor="#C95788" stopOpacity="0.75" />
          <stop offset="1" stopColor="#C95788" stopOpacity="0.45" />
        </linearGradient>
        <linearGradient id="hub-glass" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#F3C9DA" stopOpacity="0.3" />
          <stop offset="0.55" stopColor="#C95788" stopOpacity="0.16" />
          <stop offset="1" stopColor="#511C76" stopOpacity="0.1" />
        </linearGradient>
      </defs>

      {/* trilhos: as linhas paradas por onde os pacotes correm */}
      <g strokeLinecap="round" fill="none">
        {LINHAS.map((d) => (
          <path key={d} d={d} stroke="#F3C9DA" strokeWidth="1.6" strokeOpacity="0.3" />
        ))}
      </g>

      {/* módulo girado, atrás: dá profundidade sem competir com o da frente */}
      <g transform="translate(1300 500) rotate(12) scale(1.12) translate(-1412 -425)">
        <path d={MODULO} fill="none" stroke="#C95788" strokeWidth="8" strokeOpacity="0.16" />
        <path d={MODULO} fill="none" stroke="url(#hub-edge2)" strokeWidth="2.4" />
      </g>

      {/* o módulo da frente, em três espessuras: halo, meio-tom e fio */}
      <path d={MODULO} fill="none" stroke="#E4A9C4" strokeWidth="30" strokeOpacity="0.1" />
      <path d={MODULO} fill="none" stroke="#E4A9C4" strokeWidth="12" strokeOpacity="0.2" />
      <path d={MODULO} fill="none" stroke="url(#hub-edge)" strokeWidth="3.5" />

      {/* o que se move */}
      <g>
        <g strokeLinecap="round" fill="none">
          {LINHAS.map((d, i) => (
            <path
              key={d}
              d={d}
              pathLength={1}
              stroke="#FFFFFF"
              strokeWidth="2.2"
              strokeOpacity="0.9"
              strokeDasharray="0.08 1"
              className={reduzido ? undefined : 'animate-fluxo'}
              style={reduzido ? { strokeDashoffset: 0.4 } : { animationDelay: `${atraso[i]}s` }}
            />
          ))}
        </g>

        {/* dois pulsos percorrendo a borda do módulo, um largo e um fino */}
        <path
          d={MODULO}
          pathLength={1}
          fill="none"
          stroke="#F3C9DA"
          strokeWidth="14"
          strokeLinecap="round"
          strokeDasharray="0.07 1"
          opacity={0.45}
          className={reduzido ? undefined : 'animate-fluxo'}
          style={reduzido ? { strokeDashoffset: 0.3 } : { animationDuration: '11s' }}
        />
        <path
          d={MODULO}
          pathLength={1}
          fill="none"
          stroke="#FFFFFF"
          strokeWidth="5"
          strokeLinecap="round"
          strokeDasharray="0.055 1"
          className={reduzido ? undefined : 'animate-fluxo'}
          style={reduzido ? { strokeDashoffset: 0.3 } : { animationDuration: '11s' }}
        />

        {/* o módulo de vidro, pequeno, no canto inferior esquerdo do desenho */}
        <g className={reduzido ? undefined : 'animate-pulse-soft'} style={{ transformOrigin: '50% 50%', transformBox: 'view-box' }}>
          <g transform="translate(942 855) scale(0.26) translate(-1412 -425)">
            <path d={MODULO} fill="url(#hub-glass)" stroke="#F3C9DA" strokeWidth="5" strokeOpacity="0.8" />
            <path d={MODULO} fill="none" stroke="#FFFFFF" strokeWidth="2.5" strokeOpacity="0.5" transform="translate(-16 -16)" />
          </g>
        </g>
      </g>
    </svg>
  )
}
