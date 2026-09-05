import { useEffect, useState } from 'react'
import type { ReactNode } from 'react'
import { m } from 'motion/react'
import {
  ArrowDown,
  ArrowLeft,
  Building2,
  CalendarDays,
  Check,
  ChevronRight,
  CloudCheck,
  Fingerprint,
  Info,
  MapPin,
  RefreshCw,
  ScanFace,
} from 'lucide-react'
import { Logo } from '@/components/brand/Logo'
import { EmployeeAvatar } from '@/components/brand/EmployeeAvatar'
import { NatPontoIcon } from '@/components/brand/NatPontoIcon'
import { NatPontoFrame } from './NatPontoFrame'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

const WEEK = ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado']

function useNow() {
  const [now, setNow] = useState(() => new Date())
  useEffect(() => {
    const t = window.setInterval(() => setNow(new Date()), 1000)
    return () => window.clearInterval(t)
  }, [])
  return now
}

function LiveClock({ now }: { now: Date }) {
  const h = now.getHours()
  const greeting = h >= 5 && h < 12 ? 'Bom dia' : h >= 12 && h < 18 ? 'Boa tarde' : 'Boa noite'
  return (
    <>
      <p className="mt-2.5 text-[44px] font-extrabold leading-none tracking-tight tabular text-brand-blue">{now.toLocaleTimeString('pt-BR', { hour12: false })}</p>
      <p className="mt-1.5 text-[13px] text-brand-graphite">
        {now.toLocaleDateString('pt-BR')} – {WEEK[now.getDay()]}
      </p>
      <p className="mt-1 text-[16px] font-bold text-brand-graphite">{greeting}, ANA</p>
    </>
  )
}

/** Tela inicial do NatPonto: relógio, colaboradora, escala e botão de registrar. */
export function NatPontoHome() {
  const now = useNow()
  const hhmm = now.toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit', hour12: false })
  return (
    <NatPontoFrame clock={hhmm} label="App NatPonto: tela inicial com relógio, dados da colaboradora, escala do dia e botão Registrar Ponto">
      <div className="h-full overflow-hidden px-4 pt-3">
        <div className="rounded-3xl bg-[radial-gradient(70%_60%_at_20%_20%,rgba(228,169,196,0.55),transparent_70%),radial-gradient(60%_50%_at_90%_80%,rgba(201,87,136,0.28),transparent_70%),linear-gradient(180deg,#EFE9F5,#F7F2F8)] px-4 py-4 text-center">
          <span className="inline-flex items-center gap-1.5 rounded-full border border-brand-pink/40 bg-brand-pink/10 px-3 py-1 text-[10px] font-bold uppercase tracking-wide text-brand-purple">
            <RefreshCw className="h-3 w-3 text-brand-pink" strokeWidth={2.5} />
            <ArrowDown className="h-3 w-3 text-brand-pink" strokeWidth={2.5} />
            Arraste para atualizar
          </span>
          <LiveClock now={now} />
        </div>

        <div className="mt-2.5 rounded-2xl bg-white p-3.5 shadow-soft">
          <div className="flex items-center gap-3">
            <EmployeeAvatar ring className="h-12 w-12 shrink-0" />
            <div className="min-w-0 flex-1">
              <p className="truncate text-[15px] font-extrabold uppercase text-brand-ink">Ana Ribeiro</p>
              <p className="mt-0.5 flex items-center gap-1 text-[11px] uppercase text-brand-graphite">
                <Building2 className="h-3 w-3" strokeWidth={2} />
                Natcorp do Brasil
              </p>
            </div>
            <span className="inline-flex items-center gap-1 rounded-full border border-emerald-600/40 bg-emerald-50 px-2 py-0.5 text-[10px] font-bold text-emerald-700">
              <Check className="h-3 w-3" strokeWidth={3} />
              ATIVO
            </span>
          </div>
          <div className="mt-2.5 grid grid-cols-2 gap-1.5">
            {[
              ['Cargo', 'Supervisora de Setor'],
              ['Matrícula', '205818'],
              ['CPF', '345.•••.•••-87'],
            ].map(([k, v]) => (
              <div key={k} className="rounded-xl bg-[#F4F2F7] px-3 py-1.5">
                <p className="text-[9px] font-bold uppercase tracking-wide text-brand-graphite">{k}</p>
                <p className="truncate text-[12px] font-extrabold uppercase text-brand-ink">{v}</p>
              </div>
            ))}
          </div>
        </div>

        <p className="mt-3 text-[13px] font-extrabold uppercase text-brand-blue">Minha escala</p>
        <div className="mt-1.5 rounded-2xl bg-white p-3.5 shadow-soft">
          <p className="flex items-center gap-2 text-[13px] font-bold text-brand-blue">
            <CalendarDays className="h-4 w-4" strokeWidth={2} />
            Horários e local
          </p>
          <div className="mt-2 grid grid-cols-4 gap-1.5">
            {['06:30', '12:30', '13:30', '18:00'].map((t) => (
              <span key={t} className="rounded-xl border border-brand-mist bg-[#F4F2F7] py-1 text-center text-[12px] font-bold tabular text-brand-blue">
                {t}
              </span>
            ))}
          </div>
          <div className="mt-2 flex items-center justify-between rounded-xl border border-brand-mist px-3 py-2 text-[12px] font-bold uppercase text-brand-blue">
            <span className="flex items-center gap-1.5">
              <MapPin className="h-3.5 w-3.5 text-brand-pink" strokeWidth={2.2} />
              Gerência de RH
            </span>
            <ChevronRight className="h-4 w-4 text-brand-pink" strokeWidth={2.2} />
          </div>
        </div>
      </div>

      <div className="absolute inset-x-0 bottom-0 bg-[linear-gradient(180deg,rgba(244,242,247,0),#F4F2F7_45%)] px-4 pb-4 pt-6">
        <span className="flex items-center justify-center gap-3 rounded-2xl bg-[linear-gradient(90deg,#B24A7E,#C95788)] py-3.5 text-[15px] font-bold uppercase tracking-[0.18em] text-white shadow-lift">
          <Fingerprint className="h-5 w-5" strokeWidth={2} />
          Registrar ponto
        </span>
      </div>
    </NatPontoFrame>
  )
}

/** Tela de abertura: ícone do app e marca. */
export function NatPontoSplash() {
  return (
    <NatPontoFrame topBar="none" clock="18:33" label="App NatPonto: tela de abertura com o ícone do app">
      <div className="flex h-full flex-col items-center justify-center bg-[radial-gradient(60%_45%_at_50%_42%,#4A2277,#2A1550_70%)]">
        <m.div animate={{ scale: [1, 1.05, 1] }} transition={{ duration: 3, repeat: Infinity, ease: 'easeInOut' }} className="drop-shadow-[0_18px_30px_rgba(201,87,136,0.45)]">
          <NatPontoIcon className="h-28 w-28" />
        </m.div>
        <Logo tone="white" className="mt-12 h-7 w-auto" decorative />
        <p className="mt-1 text-[8px] uppercase tracking-[0.3em] text-white/60">Ponto eletrônico</p>
      </div>
    </NatPontoFrame>
  )
}

/** Tela de reconhecimento facial, com sobreposição opcional (ex.: confirmação). */
export function NatPontoFace({ overlay, clock = '18:36' }: { overlay?: ReactNode; clock?: string }) {
  return (
    <NatPontoFrame
      clock={clock}
      label={overlay ? 'App NatPonto: marcação registrada, será sincronizada posteriormente' : 'App NatPonto: reconhecimento facial com o rosto no centro da moldura e contagem regressiva'}
    >
      <div className="flex h-full flex-col">
        <div className="px-4 pb-3 pt-4">
          <div className="flex items-center justify-center gap-1.5" aria-hidden>
            <span className="h-2 w-2 rounded-full bg-emerald-500" />
            <span className="h-2 w-8 rounded-full bg-brand-blue" />
            <span className="h-2 w-2 rounded-full bg-brand-mist" />
          </div>
          <div className="mt-3 flex items-center gap-3">
            <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-[linear-gradient(135deg,#6A2E8E,#B4568F)] text-white">
              <ScanFace className="h-6 w-6" strokeWidth={1.8} />
            </span>
            <div>
              <p className="text-[15px] font-bold text-[#A8386B]">Reconhecimento Facial</p>
              <p className="text-[11px] text-brand-graphite">Posicione seu rosto no centro e aguarde</p>
            </div>
          </div>
        </div>

        <div className="relative flex-1 overflow-hidden bg-[radial-gradient(50%_40%_at_30%_20%,#EEE2D2,transparent_70%),radial-gradient(45%_45%_at_80%_35%,#C9AE93,transparent_70%),linear-gradient(180deg,#D9C7B3_0%,#8D7561_60%,#2A2230_100%)]">
          <p className="absolute inset-x-0 top-5 text-center text-[24px] font-extrabold text-[#E07AA9] drop-shadow-[0_2px_6px_rgba(0,0,0,0.35)]">Não se mexa</p>
          <span className="absolute right-3 top-4 rounded-full bg-brand-ink/80 px-2.5 py-1 text-[11px] font-bold tabular text-white">58s</span>

          <div className="absolute left-1/2 top-[54%] h-[62%] w-[70%] -translate-x-1/2 -translate-y-1/2">
            <m.div
              className="absolute inset-0 overflow-hidden rounded-[50%] border-[3px] border-[#D6679A] bg-[#E9DDD0]/60"
              animate={{ boxShadow: ['0 0 0 0 rgba(214,103,154,0.0)', '0 0 0 8px rgba(214,103,154,0.18)', '0 0 0 0 rgba(214,103,154,0.0)'] }}
              transition={{ duration: 2.2, repeat: Infinity, ease: 'easeInOut' }}
            >
              <EmployeeAvatar className="absolute left-1/2 top-[6%] w-[150%] -translate-x-1/2" />
            </m.div>
            {[
              'left-[-14px] top-[6%] border-l-[3px] border-t-[3px] rounded-tl-md',
              'right-[-14px] top-[6%] border-r-[3px] border-t-[3px] rounded-tr-md',
              'left-[-14px] bottom-[6%] border-l-[3px] border-b-[3px] rounded-bl-md',
              'right-[-14px] bottom-[6%] border-r-[3px] border-b-[3px] rounded-br-md',
            ].map((c) => (
              <span key={c} className={cn('absolute h-7 w-7 border-[#D6679A]', c)} aria-hidden />
            ))}
          </div>

          <m.span
            className="absolute bottom-5 left-1/2 flex h-14 w-14 -translate-x-1/2 items-center justify-center rounded-full bg-[linear-gradient(180deg,#6A2E8E,#B4568F)] text-[26px] font-bold text-white shadow-lift"
            animate={{ scale: [1, 1.08, 1] }}
            transition={{ duration: 1, repeat: Infinity, ease: 'easeInOut' }}
          >
            1
          </m.span>

          {overlay}
        </div>

        <div className="px-4 pb-4 pt-3">
          <p className="flex items-start gap-1.5 text-[11px] leading-snug text-brand-graphite">
            <Info className="mt-0.5 h-3 w-3 shrink-0" strokeWidth={2} />
            Evite máscara, boné e óculos escuros. Use boa iluminação.
          </p>
          <span className="mt-3 flex items-center justify-center gap-2 rounded-2xl border-2 border-brand-blue py-3 text-[14px] font-bold uppercase tracking-[0.18em] text-brand-blue">
            <ArrowLeft className="h-4 w-4" strokeWidth={2.5} />
            Voltar
          </span>
        </div>
      </div>
    </NatPontoFrame>
  )
}

/** Confirmação "Marcação registrada" sobre a tela de reconhecimento. */
export function NatPontoSuccess() {
  return (
    <NatPontoFace
      overlay={
        <div className="absolute inset-0 flex items-center justify-center bg-brand-ink/45 p-4">
          <m.div
            className="w-full rounded-3xl bg-[linear-gradient(180deg,#1E63C9,#3B9BF0)] px-4 py-6 text-center text-white shadow-lift"
            initial={{ opacity: 0, scale: 0.9 }}
            whileInView={{ opacity: 1, scale: 1 }}
            viewport={viewportOnce}
            transition={{ duration: 0.6, ease: EASE, delay: 0.4 }}
          >
            <span className="mx-auto flex h-16 w-16 items-center justify-center rounded-full bg-white/15">
              <CloudCheck className="h-8 w-8" strokeWidth={1.8} />
            </span>
            <p className="mt-4 text-[20px] font-bold">Marcação registrada</p>
            <p className="mt-1 text-[14px] font-bold uppercase">Ana Ribeiro</p>
            <p className="text-[12px] tabular text-white/85">03/09/2026 18:36</p>
            <p className="mt-3 text-[12px] font-bold">Será sincronizada posteriormente</p>
            <p className="mt-2 text-[9.5px] font-bold uppercase tracking-wide text-white/85">Toque na tela para continuar</p>
          </m.div>
        </div>
      }
    />
  )
}

/* QR falso, determinístico, com os três padrões de localização. */
const QR_N = 21
function qrModules() {
  let seed = 7
  const rnd = () => {
    seed = (seed * 1103515245 + 12345) & 0x7fffffff
    return seed / 0x7fffffff
  }
  const m: boolean[][] = Array.from({ length: QR_N }, () => Array.from({ length: QR_N }, () => rnd() > 0.55))
  const finder = (ox: number, oy: number) => {
    for (let y = 0; y < 7; y++)
      for (let x = 0; x < 7; x++) {
        const edge = x === 0 || y === 0 || x === 6 || y === 6
        const core = x >= 2 && x <= 4 && y >= 2 && y <= 4
        m[oy + y][ox + x] = edge || core
      }
    for (let i = -1; i <= 7; i++) {
      if (oy + i >= 0 && oy + i < QR_N && ox - 1 >= 0) m[oy + i][ox - 1] = false
      if (oy + i >= 0 && oy + i < QR_N && ox + 7 < QR_N) m[oy + i][ox + 7] = false
      if (ox + i >= 0 && ox + i < QR_N && oy - 1 >= 0) m[oy - 1][ox + i] = false
      if (ox + i >= 0 && ox + i < QR_N && oy + 7 < QR_N) m[oy + 7][ox + i] = false
    }
  }
  finder(0, 0)
  finder(QR_N - 7, 0)
  finder(0, QR_N - 7)
  for (let i = 8; i < QR_N - 8; i++) {
    m[6][i] = i % 2 === 0
    m[i][6] = i % 2 === 0
  }
  return m
}
const QR = qrModules()

function FakeQr({ className }: { className?: string }) {
  return (
    <svg viewBox={`0 0 ${QR_N} ${QR_N}`} className={cn('block', className)} shapeRendering="crispEdges" aria-hidden>
      <rect width={QR_N} height={QR_N} fill="#fff" />
      {QR.flatMap((row, y) => row.map((on, x) => (on ? <rect key={`${x}-${y}`} x={x} y={y} width="1" height="1" fill="#1B1238" /> : null)))}
    </svg>
  )
}

/** Mapa estilizado (sem tiles externos) com o raio permitido e a marcação. */
function MapMock() {
  return (
    <svg viewBox="0 0 300 240" className="block h-auto w-full" aria-hidden>
      <rect width="300" height="240" fill="#F2EFE9" />
      {[
        [10, 20, 60, 40],
        [80, 10, 70, 50],
        [160, 14, 50, 34],
        [225, 22, 60, 40],
        [12, 80, 50, 30],
        [70, 76, 46, 36],
        [230, 84, 60, 30],
        [20, 170, 70, 40],
        [110, 180, 60, 34],
        [200, 176, 80, 36],
      ].map(([x, y, w, h], i) => (
        <rect key={i} x={x} y={y} width={w} height={h} fill="#E2DCD2" stroke="#D3CBBF" strokeWidth="1" />
      ))}
      <rect x="150" y="60" width="70" height="52" fill="#F5D9DC" stroke="#E9C2C7" />
      <text x="185" y="82" textAnchor="middle" fontSize="8" fontWeight="700" fill="#C43A3A">
        Shopping Tamboré
      </text>
      <polygon points="0,200 60,190 90,240 0,240" fill="#CDEBB0" />
      <path d="M0 222 C60 214 120 230 200 222 S280 214 300 226" stroke="#AAD3DF" strokeWidth="12" fill="none" />
      <path d="M0 150 L300 118" stroke="#E892A2" strokeWidth="18" strokeLinecap="round" />
      <path d="M0 150 L300 118" stroke="#F6C3CC" strokeWidth="2" strokeDasharray="8 8" fill="none" />
      <path d="M212 0 L206 240" stroke="#F3E39A" strokeWidth="9" />
      <path d="M0 62 L300 50" stroke="#F3E39A" strokeWidth="7" />
      <text x="150" y="141" textAnchor="middle" fontSize="7.5" fill="#6B2A33" transform="rotate(-6 150 141)">
        Rodovia Presidente Castelo Branco
      </text>
      <text x="90" y="232" fontSize="7.5" fill="#4A4460">
        Avenida Piracuru
      </text>
      <text x="238" y="120" fontSize="7" fill="#4A4460" transform="rotate(-84 238 120)">
        Avenida Piracema
      </text>
      <circle cx="150" cy="120" r="40" fill="rgba(201,87,136,0.14)" stroke="#C95788" strokeWidth="1.5" strokeDasharray="4 3" />
      <circle cx="146" cy="112" r="11" fill="rgba(42,129,203,0.25)" />
      <circle cx="146" cy="112" r="6" fill="#2A81CB" stroke="#fff" strokeWidth="2" />
      <path d="M152 142 C144 130 141 126 141 120 A11 11 0 0 1 163 120 C163 126 160 130 152 142 Z" fill="#511C76" stroke="#fff" strokeWidth="1.5" />
      <circle cx="152" cy="120" r="4" fill="#fff" />
      <g>
        <rect x="10" y="10" width="22" height="22" rx="3" fill="#fff" stroke="#D3CBBF" />
        <rect x="10" y="32" width="22" height="22" rx="3" fill="#fff" stroke="#D3CBBF" />
        <path d="M16 21 H26 M21 16 V26" stroke="#1B1238" strokeWidth="2" />
        <path d="M16 43 H26" stroke="#1B1238" strokeWidth="2" />
      </g>
    </svg>
  )
}

/** Comprovante da marcação: QR, registro no INPI, hash e geolocalização. */
export function NatPontoReceipt() {
  return (
    <NatPontoFrame topBar="modal" title="Comprovante" clock="18:37" label="App NatPonto: comprovante da marcação com código de verificação, registro no INPI, hash SHA-256 e geolocalização dentro do raio">
      <div className="h-full overflow-hidden px-3 pt-3">
        <div className="rounded-2xl bg-white shadow-soft">
          <div className="flex items-start justify-between px-4 pt-4">
            <p className="mt-6 flex items-center gap-2 text-[14px] font-bold text-brand-blue">
              <span className="h-3 w-3 rounded-full bg-emerald-600" />
              Registrado
            </p>
            <div className="text-center">
              <span className="inline-block rounded-xl border-2 border-[#F0C5D6] p-1.5">
                <FakeQr className="h-[72px] w-[72px]" />
              </span>
              <p className="mt-1 text-[8.5px] font-bold uppercase tracking-wide text-brand-graphite">Código de verificação</p>
            </div>
          </div>
          <div className="mt-3 border-t border-brand-mist bg-[#F8F6FA] px-4 py-2.5">
            <p className="text-[9px] font-bold uppercase tracking-wide text-brand-graphite">Registro no INPI</p>
            <p className="font-mono text-[12px] font-semibold tracking-wider text-brand-ink">BR 51 2024 001255 9</p>
          </div>
          <div className="border-t border-brand-mist px-4 py-2.5">
            <p className="text-[9px] font-bold uppercase tracking-wide text-brand-graphite">Hash SHA-256 da marcação</p>
            <p className="break-all font-mono text-[9.5px] font-semibold leading-snug text-brand-purple">21045f61be0e80b32f28ff71d56c85cb62f4ecb6ccbe50499d77ac65cb59f053</p>
          </div>
        </div>

        <div className="mt-3 rounded-2xl bg-white p-4 shadow-soft">
          <p className="flex items-center gap-1.5 text-[13px] font-extrabold uppercase text-brand-blue">
            <MapPin className="h-4 w-4 text-brand-pink" strokeWidth={2.2} />
            Geolocalização
          </p>
          <p className="mt-2 flex items-center gap-2 rounded-xl border border-[#F5C79A] bg-[#FFF4E8] px-3 py-2 text-[12px] font-bold uppercase text-[#8F4600]">
            <MapPin className="h-4 w-4 fill-current" strokeWidth={2} />
            Dentro do raio (A)
          </p>
          <div className="mt-2 overflow-hidden rounded-xl border border-brand-mist">
            <MapMock />
          </div>
        </div>
      </div>
      <div className="absolute inset-x-0 bottom-0 bg-[linear-gradient(180deg,rgba(244,242,247,0),#F4F2F7_40%)] px-4 pb-4 pt-6">
        <span className="flex items-center justify-center gap-2 rounded-2xl border-2 border-brand-blue bg-white py-3 text-[14px] font-bold uppercase tracking-[0.18em] text-brand-blue">
          <ArrowLeft className="h-4 w-4" strokeWidth={2.5} />
          Voltar
        </span>
      </div>
    </NatPontoFrame>
  )
}

export type NatPontoScreen = 'home' | 'splash' | 'face' | 'success' | 'receipt'

export function NatPontoPhone({ screen }: { screen: NatPontoScreen }) {
  switch (screen) {
    case 'splash':
      return <NatPontoSplash />
    case 'face':
      return <NatPontoFace />
    case 'success':
      return <NatPontoSuccess />
    case 'receipt':
      return <NatPontoReceipt />
    default:
      return <NatPontoHome />
  }
}
