import { Link } from 'react-router'
import { ArrowRight, MapPin, QrCode, ScanFace, WifiOff } from 'lucide-react'
import { Section, SectionHeader } from './Section'
import { Reveal, Stagger, StaggerItem } from '@/components/motion/Reveal'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import { NATPONTO_SIZE } from '@/components/mockups/natponto/NatPontoFrame'
import { NatPontoPhone, type NatPontoScreen } from '@/components/mockups/natponto/screens'
import { NatPontoIcon } from '@/components/brand/NatPontoIcon'

const screens: { id: NatPontoScreen; caption: string }[] = [
  { id: 'home', caption: 'Relógio, escala do dia e um toque para registrar' },
  { id: 'face', caption: 'Reconhecimento facial confirma quem está marcando' },
  { id: 'receipt', caption: 'Comprovante com QR, hash e local dentro do raio' },
]

const points = [
  { icon: ScanFace, title: 'Reconhecimento facial', text: 'O rosto confirma quem está marcando. Sem cartão emprestado, sem senha compartilhada.' },
  { icon: MapPin, title: 'Geolocalização com raio', text: 'A marcação registra onde foi feita e se está dentro do raio permitido da unidade.' },
  { icon: WifiOff, title: 'Funciona sem internet', text: 'Sem sinal, a marcação fica guardada no aparelho e sincroniza sozinha depois.' },
  { icon: QrCode, title: 'Comprovante verificável', text: 'Cada marcação gera comprovante com código QR, hash e registro de programa de computador no INPI.' },
]

/** Resumo do NatPonto na home: três telas do app reproduzidas em HTML/CSS. */
export function NatPontoSection() {
  return (
    <Section id="natponto" tone="white" className="overflow-hidden" aria-labelledby="natponto-title">
      <div className="container">
        <SectionHeader
          id="natponto-title"
          align="center"
          eyebrow="NatPonto · App de ponto"
          title="O ponto no celular, com [[rosto, local e hora]]."
          lead="O aplicativo de marcação da Natcorp, para iOS e Android. Reconhecimento facial, geolocalização com raio e comprovante de cada marcação. Funciona sem internet e chega em segundos ao Ponto Eletrônico."
        />

        <Stagger className="mt-14 grid gap-8 sm:grid-cols-3 lg:mt-20 lg:gap-10" stagger={0.12}>
          {screens.map((s) => (
            <StaggerItem key={s.id} className="min-w-0">
              <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height} className="mx-auto max-w-[300px]">
                <NatPontoPhone screen={s.id} />
              </ScaledFrame>
              <p className="mx-auto mt-4 max-w-[260px] text-center text-sm text-brand-graphite">{s.caption}</p>
            </StaggerItem>
          ))}
        </Stagger>

        <Stagger className="mt-14 grid gap-4 sm:grid-cols-2 lg:mt-20 lg:grid-cols-4" stagger={0.08}>
          {points.map(({ icon: Icon, title, text }) => (
            <StaggerItem key={title} className="rounded-2xl border border-brand-mist bg-white p-6 shadow-soft">
              <span className="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple">
                <Icon className="h-5 w-5" strokeWidth={1.6} />
              </span>
              <h3 className="mt-4 text-lg font-bold text-brand-ink">{title}</h3>
              <p className="mt-2 text-[15px] leading-relaxed text-brand-graphite">{text}</p>
            </StaggerItem>
          ))}
        </Stagger>

        <Reveal delay={0.2} className="mt-10 flex justify-center">
          <Link to="/modulos/natponto" className="group inline-flex items-center gap-3 rounded-full border border-brand-mist bg-white py-2 pl-2 pr-5 text-[15px] font-semibold text-brand-purple shadow-soft transition-colors hover:border-brand-purple/40">
            <NatPontoIcon className="h-8 w-8" />
            Conhecer o NatPonto em detalhes
            <ArrowRight className="h-4 w-4 transition-transform duration-300 group-hover:translate-x-0.5" aria-hidden />
          </Link>
        </Reveal>
      </div>
    </Section>
  )
}
