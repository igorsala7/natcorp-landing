import { useEffect, useState, type ReactNode } from 'react'
import { m } from 'motion/react'
import {
  ArrowRight,
  Award,
  BadgeCheck,
  Bell,
  BookOpen,
  Building2,
  CalendarCheck,
  Check,
  Clock,
  Download,
  FileSignature,
  FileText,
  GraduationCap,
  HardHat,
  Heart,
  IdCard,
  Leaf,
  Mail,
  MapPin,
  MessageSquare,
  PlayCircle,
  ShieldCheck,
  Smile,
  Stethoscope,
  Timer,
  TrendingUp,
  User,
  Utensils,
  Wallet,
} from 'lucide-react'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'
import { NatiAvatar } from '@/components/brand/NatiAvatar'
import { EmployeeAvatar } from '@/components/brand/EmployeeAvatar'
import { ScaledFrame } from '@/components/motion/ScaledFrame'
import { NATPONTO_SIZE } from '@/components/mockups/natponto/NatPontoFrame'
import { NatPontoPhone } from '@/components/mockups/natponto/screens'
import { Conversation, NatiBubble, NatiChatWindow, UserBubble } from '@/components/mockups/nati/NatiChatWindow'
import type { VisualKey } from '@/content/hiringJourney'

/* ---------- primitivos ---------- */

const item = {
  hidden: { opacity: 0, y: 8 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.5, ease: EASE } },
}

type Tone = 'ok' | 'wait' | 'info' | 'muted'

const toneClass: Record<Tone, string> = {
  ok: 'bg-emerald-50 text-emerald-700',
  wait: 'bg-amber-50 text-[#8F4600]',
  info: 'bg-brand-purple/10 text-brand-purple',
  muted: 'bg-brand-off-white text-brand-graphite',
}

function Pill({ tone = 'info', children, className }: { tone?: Tone; children: ReactNode; className?: string }) {
  return <span className={cn('inline-flex shrink-0 items-center rounded-full px-2.5 py-1 text-[11px] font-semibold', toneClass[tone], className)}>{children}</span>
}

interface CardProps {
  eyebrow: string
  title: string
  status?: ReactNode
  label: string
  children: ReactNode
  className?: string
}

/** Cartão base dos mini mockups: cabeçalho, status e conteúdo com entrada escalonada. */
function Card({ eyebrow, title, status, label, children, className }: CardProps) {
  return (
    <m.div
      role="img"
      aria-label={label}
      className={cn('rounded-2xl border border-brand-mist bg-white p-5 shadow-lift', className)}
      initial="hidden"
      whileInView="visible"
      viewport={viewportOnce}
      variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.1, delayChildren: 0.15 } } }}
    >
      <m.div variants={item} className="flex items-start justify-between gap-3">
        <div className="min-w-0">
          <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">{eyebrow}</p>
          <p className="mt-0.5 text-[15px] font-bold leading-snug text-brand-ink">{title}</p>
        </div>
        {status}
      </m.div>
      {children}
    </m.div>
  )
}

function Row({
  icon: Icon,
  state = 'done',
  children,
  meta,
}: {
  icon?: typeof Check
  state?: 'done' | 'active' | 'next' | 'plain'
  children: ReactNode
  meta?: ReactNode
}) {
  return (
    <m.li variants={item} className="flex items-start gap-3">
      <span
        className={cn(
          'mt-0.5 flex h-6 w-6 shrink-0 items-center justify-center rounded-full',
          state === 'done' && 'bg-brand-purple text-white',
          state === 'active' && 'border-2 border-brand-pink bg-white text-brand-pink',
          state === 'next' && 'border border-brand-mist bg-white text-brand-graphite',
          state === 'plain' && 'bg-brand-off-white text-brand-purple',
        )}
      >
        {Icon ? <Icon className="h-3.5 w-3.5" strokeWidth={2.4} /> : state === 'done' ? <Check className="h-3.5 w-3.5" strokeWidth={3} /> : <span className="h-1.5 w-1.5 rounded-full bg-current" />}
      </span>
      <div className="min-w-0 flex-1">
        <div className="flex items-baseline justify-between gap-3 text-[13.5px] font-semibold text-brand-ink">
          <span className="min-w-0">{children}</span>
          {meta && <span className="shrink-0 text-[11px] font-medium tabular text-brand-graphite">{meta}</span>}
        </div>
      </div>
    </m.li>
  )
}

function Trail({ items }: { items: { label: string; who: string; when: string; auto?: boolean }[] }) {
  return (
    <ol className="mt-5 space-y-0">
      {items.map((t, i) => (
        <m.li key={t.label} variants={item} className="relative flex gap-3 pb-4 last:pb-0">
          {i < items.length - 1 && <span aria-hidden className="absolute left-[11px] top-6 w-px bg-brand-purple/25" style={{ height: 'calc(100% - 0.6rem)' }} />}
          <span className={cn('relative z-10 mt-0.5 flex h-6 w-6 shrink-0 items-center justify-center rounded-full text-white', t.auto ? 'bg-brand-pink' : 'bg-brand-purple')}>
            {t.auto ? <ArrowRight className="h-3.5 w-3.5" strokeWidth={2.5} /> : <Check className="h-3.5 w-3.5" strokeWidth={2.5} />}
          </span>
          <div className="min-w-0 flex-1">
            <div className="flex items-baseline justify-between gap-3">
              <p className="text-[13.5px] font-semibold text-brand-ink">{t.label}</p>
              <p className="shrink-0 text-[11px] tabular text-brand-graphite">{t.when}</p>
            </div>
            <p className="text-[12px] text-brand-graphite">{t.who}</p>
          </div>
        </m.li>
      ))}
    </ol>
  )
}

function Bar({ value, max, className, duration = 0.9 }: { value: number; max: number; className?: string; duration?: number }) {
  const pct = Math.round((value / max) * 100)
  return (
    <div className={cn('h-2 w-full overflow-hidden rounded-full bg-brand-off-white', className)} aria-hidden>
      <m.div
        className="h-full rounded-full bg-[linear-gradient(90deg,#9A408A,#511C76)]"
        initial={{ width: 0 }}
        whileInView={{ width: `${pct}%` }}
        viewport={viewportOnce}
        transition={{ duration, ease: EASE, delay: 0.3 }}
      />
    </div>
  )
}

function Note({ children }: { children: ReactNode }) {
  return (
    <m.p variants={item} className="mt-4 border-t border-brand-mist pt-3 text-[12px] leading-snug text-brand-graphite">
      {children}
    </m.p>
  )
}

function Chip({ children }: { children: ReactNode }) {
  return <span className="rounded-lg border border-brand-mist bg-brand-off-white px-2.5 py-1 text-[12px] font-semibold text-brand-ink">{children}</span>
}

/** Par rótulo e valor, como um campo preenchido de tela. */
function Field({ label, value, className }: { label: string; value: string; className?: string }) {
  return (
    <div className={cn('rounded-xl bg-brand-off-white px-3 py-2', className)}>
      <p className="text-[10px] font-bold uppercase tracking-wide text-brand-graphite">{label}</p>
      <p className="font-semibold text-brand-ink">{value}</p>
    </div>
  )
}

/* ---------- visuais por etapa ---------- */

function ApprovalVisual() {
  return (
    <Card
      eyebrow="Requisição de Vaga · #51.208"
      title="Aumento de quadro · Supervisor(a) de Produção"
      status={<Pill tone="ok">Aprovada</Pill>}
      label="Requisição de Vaga aprovada: aumento de quadro para Supervisor(a) de Produção, centro de custo Produção em Sorocaba e faixa salarial dentro da grade; solicitação do gestor pelo Portal do Gestor, alçada financeira da Controladoria, aprovação final da Diretoria de Operações pelo celular e vaga criada no headcount automaticamente"
    >
      <m.div variants={item} className="mt-4 grid grid-cols-2 gap-2 text-[12px]">
        <Field label="Centro de custo" value="Produção · Sorocaba" />
        <div className="rounded-xl bg-brand-off-white px-3 py-2">
          <p className="text-[10px] font-bold uppercase tracking-wide text-brand-graphite">Faixa salarial do cargo</p>
          <p className="font-semibold text-emerald-700">Dentro da grade</p>
        </div>
      </m.div>
      <Trail
        items={[
          { label: 'Solicitação', who: 'Marcos Tavares · Portal do Gestor', when: 'Seg 07/09 08:52' },
          { label: 'Alçada financeira', who: 'Cláudia Nunes · Controladoria', when: 'Ter 08/09 10:15' },
          { label: 'Aprovação final', who: 'Diretoria de Operações · pelo celular', when: 'Ter 08/09 11:30' },
          { label: 'Vaga criada no headcount', who: 'Efetivado automaticamente', when: 'Ter 08/09 11:31', auto: true },
        ]}
      />
    </Card>
  )
}

function ProcessVisual() {
  return (
    <Card
      eyebrow="Processo seletivo · criado automaticamente"
      title="Supervisor(a) de Produção · Sorocaba"
      status={<Pill tone="info">Prazo: 20 dias</Pill>}
      label="Processo seletivo criado automaticamente a partir da Requisição de Pessoal aprovada, com recrutadora responsável, prazo de 20 dias e quatro fases: triagem, questionário técnico, entrevista com o RH e entrevista com o gestor"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={User} state="plain" meta="responsável">
          Juliana Prado, recrutadora
        </Row>
        <Row icon={FileText} state="plain" meta="#51.209">
          Origem: Requisição de Pessoal
        </Row>
        <Row icon={Timer} state="plain" meta="até 28/09">
          Prazo da vaga: 20 dias
        </Row>
      </ul>
      <m.div variants={item} className="mt-5">
        <p className="text-[10px] font-bold uppercase tracking-wide text-brand-graphite">Fases</p>
        <div className="mt-2 flex flex-wrap items-center gap-1.5">
          {['Triagem', 'Questionário técnico', 'Entrevista com o RH', 'Entrevista com o gestor'].map((e, i, arr) => (
            <span key={e} className="flex items-center gap-1.5">
              <Chip>{e}</Chip>
              {i < arr.length - 1 && <ArrowRight className="h-3 w-3 text-brand-graphite" aria-hidden />}
            </span>
          ))}
        </div>
      </m.div>
    </Card>
  )
}

function JobBoardVisual() {
  return (
    <m.div
      role="img"
      aria-label="Quadro de vagas da empresa fictícia Vale Verde Alimentos, com a marca dela, mostrando a vaga de Supervisor(a) de Produção em Sorocaba, o botão Candidatar-se e a indicação de que a vaga também foi publicada no LinkedIn"
      className="overflow-hidden rounded-2xl border border-brand-mist bg-white shadow-lift"
      initial="hidden"
      whileInView="visible"
      viewport={viewportOnce}
      variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.12, delayChildren: 0.15 } } }}
    >
      <div className="flex items-center justify-between bg-[#1F6B45] px-5 py-3 text-white">
        <span className="flex items-center gap-2 text-[14px] font-bold">
          <span className="flex h-7 w-7 items-center justify-center rounded-lg bg-white/15">
            <Leaf className="h-4 w-4" strokeWidth={2.2} aria-hidden />
          </span>
          Vale Verde Alimentos
        </span>
        <span className="text-[11px] font-semibold uppercase tracking-[0.14em] text-white/80">Carreiras</span>
      </div>
      <div className="p-5">
        <m.p variants={item} className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">
          Vagas abertas · 1 nova
        </m.p>
        <m.div variants={item} className="mt-3 rounded-xl border border-brand-mist p-4">
          <p className="text-[15px] font-bold text-brand-ink">Supervisor(a) de Produção</p>
          <p className="mt-1 flex flex-wrap gap-x-3 gap-y-1 text-[12px] text-brand-graphite">
            <span className="inline-flex items-center gap-1">
              <MapPin className="h-3.5 w-3.5" aria-hidden />
              Sorocaba/SP
            </span>
            <span className="inline-flex items-center gap-1">
              <Building2 className="h-3.5 w-3.5" aria-hidden />
              Produção
            </span>
            <span>Efetivo</span>
          </p>
          <div className="mt-3 flex items-center justify-between">
            <span className="text-[11px] text-brand-graphite">Publicada há 2 horas</span>
            <span className="rounded-lg bg-[#1F6B45] px-3 py-1.5 text-[12px] font-bold text-white">Candidatar-se</span>
          </div>
        </m.div>
        <m.div variants={item} className="mt-3 flex flex-wrap items-center gap-2">
          <Pill tone="muted">Também publicada no LinkedIn</Pill>
          <span className="text-[11px] text-brand-graphite">e nas outras plataformas conectadas</span>
        </m.div>
      </div>
    </m.div>
  )
}

function CandidateVisual() {
  return (
    <Card
      eyebrow="Portal do Candidato · celular"
      title="Ana Ribeiro · Inscrição no processo"
      status={<Pill tone="ok">Inscrita</Pill>}
      label="Portal do Candidato: dados pessoais e formação, cursos, soft skills e histórico preenchidos, termos de tratamento de dados aceitos e inscrição enviada, aguardando triagem"
    >
      <m.div variants={item} className="mt-4">
        <Bar value={3} max={4} />
      </m.div>
      <ul className="mt-4 space-y-3">
        <Row meta="21:18">Dados pessoais e formação</Row>
        <Row meta="21:24">Cursos, soft skills e histórico</Row>
        <Row meta="21:27">Termos de tratamento de dados aceitos</Row>
        <Row state="active" meta="aguardando">
          Inscrição enviada · aguardando triagem
        </Row>
      </ul>
      <Note>Vaga vista no LinkedIn. Cadastro criado pelo celular em doze minutos.</Note>
    </Card>
  )
}

function TalentVisual() {
  const people = [
    { name: 'Ana Ribeiro', score: 94, tags: 'Curso técnico em alimentos · 4 anos em produção · nota 8,7' },
    { name: 'Carlos Menezes', score: 88, tags: 'Líder de turno · 6 anos em alimentos' },
    { name: 'Patrícia Souza', score: 81, tags: 'Técnica em alimentos · 2 anos em produção' },
  ]
  return (
    <m.div
      role="img"
      aria-label="Fase de questionário técnico: Ana Ribeiro com nota 8,7, corte 7,0, aprovada automaticamente para a próxima fase; abaixo, a NATI indica seis talentos aderentes à vaga a partir do banco de talentos, com Ana em primeiro"
      className="rounded-2xl border border-brand-mist bg-white p-5 shadow-lift"
      initial="hidden"
      whileInView="visible"
      viewport={viewportOnce}
      variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.12, delayChildren: 0.15 } } }}
    >
      <m.div variants={item} className="flex items-center gap-2 rounded-xl bg-emerald-50 px-3 py-2 text-[12px] font-semibold text-emerald-700">
        <Check className="h-3.5 w-3.5 shrink-0" strokeWidth={3} aria-hidden />
        <span>Questionário técnico · nota 8,7 · corte 7,0 · aprovada para a próxima fase</span>
      </m.div>
      <m.div variants={item} className="mt-4 flex items-center gap-3">
        <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-brand-off-white">
          <NatiAvatar ring className="h-9 w-9" />
        </span>
        <div className="min-w-0 flex-1">
          <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">NATI · banco de talentos</p>
          <p className="text-[15px] font-bold text-brand-ink">6 talentos aderentes ao cargo</p>
        </div>
      </m.div>
      <ul className="mt-4 space-y-3">
        {people.map((p) => (
          <m.li key={p.name} variants={item} className="rounded-xl border border-brand-mist p-3">
            <div className="flex items-center justify-between gap-3">
              <p className="text-[13.5px] font-bold text-brand-ink">{p.name}</p>
              <span className="text-[13px] font-extrabold tabular text-brand-purple">{p.score}%</span>
            </div>
            <Bar value={p.score} max={100} className="mt-2 h-1.5" />
            <p className="mt-2 text-[11.5px] text-brand-graphite">{p.tags}</p>
          </m.li>
        ))}
      </ul>
      <Note>+3 candidatos com aderência acima de 70%. A decisão de convocar continua com a recrutadora.</Note>
    </m.div>
  )
}

function SlaVisual() {
  return (
    <Card
      eyebrow="Painel de recrutamento"
      title="Vaga fechada em 8 dias"
      status={<Pill tone="ok">Dentro do prazo</Pill>}
      label="Painel de recrutamento: vaga fechada em 8 dias de um prazo de 20, com 23 candidaturas, 6 indicados pela NATI, 4 entrevistas e 1 aprovada"
    >
      <m.div variants={item} className="mt-4">
        <div className="flex items-baseline justify-between text-[12px] text-brand-graphite">
          <span className="font-semibold text-brand-ink">8 dias</span>
          <span>prazo: 20 dias</span>
        </div>
        <Bar value={8} max={20} className="mt-1.5" />
      </m.div>
      <m.div variants={item} className="mt-5 grid grid-cols-2 gap-2">
        {[
          ['23', 'candidaturas'],
          ['6', 'indicados pela NATI'],
          ['4', 'entrevistas'],
          ['1', 'aprovada'],
        ].map(([v, l]) => (
          <div key={l} className="rounded-xl bg-brand-off-white px-3 py-2.5">
            <p className="text-xl font-extrabold tabular text-brand-purple">{v}</p>
            <p className="text-[11px] text-brand-graphite">{l}</p>
          </div>
        ))}
      </m.div>
      <Note>Proposta conferida contra teto salarial, formação e experiência do cargo: dentro da política.</Note>
    </Card>
  )
}

function AdmissionVisual() {
  return (
    <Card
      eyebrow="Admissão Digital"
      title="Ana Ribeiro · Supervisor(a) de Produção"
      status={<Pill tone="wait">Aguardando a candidata</Pill>}
      label="Admissão Digital aberta automaticamente para Ana Ribeiro dois minutos após a aprovação, com as etapas de dados, documentos e dependentes, benefícios, exame admissional e assinatura ainda pendentes"
    >
      <ul className="mt-5 space-y-3">
        <Row state="active">Dados pessoais e bancários</Row>
        <Row state="next">Documentos e dependentes</Row>
        <Row state="next">Escolha de benefícios</Row>
        <Row state="next">Exame admissional</Row>
        <Row state="next">Assinatura do contrato</Row>
      </ul>
      <Note>Convite enviado em 16/09 às 10:02, dois minutos após a aprovação. Acompanhada por Beatriz Lima, Analista de Admissão.</Note>
    </Card>
  )
}

function DataFormVisual() {
  return (
    <Card
      eyebrow="Portal do Candidato · celular"
      title="Dados da admissão"
      status={<Pill tone="ok">Concluído 20:34</Pill>}
      label="Dados da admissão preenchidos pela candidata no celular: dados pessoais, endereço, dados bancários, um dependente e seis documentos fotografados: RG, CPF, carteira de trabalho digital, comprovante de endereço, certidão de casamento e a certidão de nascimento do dependente"
    >
      <ul className="mt-5 space-y-3">
        <Row meta="20:14">Dados pessoais e escolaridade</Row>
        <Row meta="20:17">Endereço</Row>
        <Row meta="20:21">Dados bancários e PIS</Row>
        <Row meta="20:25">Dependente · filho, 6 anos</Row>
        <Row meta="20:34">Documentos fotografados · 6 de 6</Row>
      </ul>
      <m.div variants={item} className="mt-4 flex flex-wrap gap-1.5">
        {['RG', 'CPF', 'Carteira de trabalho digital', 'Comprovante de endereço', 'Certidão de casamento', 'Dependente: certidão de nascimento'].map((d) => (
          <Chip key={d}>{d}</Chip>
        ))}
      </m.div>
      <Note>A validação apontou um dígito errado na agência antes do envio. Corrigido na hora. Tudo já no GED.</Note>
    </Card>
  )
}

function BenefitsVisual() {
  return (
    <Card
      eyebrow="Escolha de benefícios"
      title="Elegível: Supervisor(a) de Produção · Sorocaba"
      status={<Pill tone="ok">4 de 5</Pill>}
      label="Escolha de benefícios conforme a elegibilidade do cargo: vale-transporte e refeição obrigatórios já marcados, plano de saúde com o filho como dependente e odontológico escolhidos; previdência privada deixada para depois"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={MapPin} meta="trajeto informado">
          Vale-transporte
        </Row>
        <Row icon={Utensils} meta="obrigatório">
          Refeição no refeitório
        </Row>
        <Row icon={Heart} meta="titular + filho">
          Plano de saúde
        </Row>
        <Row icon={Smile} meta="complementar">
          Odontológico
        </Row>
        <Row state="next" meta="deixou para depois">
          Previdência privada
        </Row>
      </ul>
      <Note>As escolhas viram rubricas na folha e pedidos às operadoras, sem planilha.</Note>
    </Card>
  )
}

function GedVisual() {
  return (
    <Card
      eyebrow="GED · documentos de Ana Ribeiro"
      title="Conferência pelo Departamento Pessoal"
      status={<Pill tone="ok">6 de 6 válidos</Pill>}
      label="Documentos no GED conferidos pelo Departamento Pessoal: RG, CPF, carteira de trabalho digital, certidão de casamento e certidão de nascimento do dependente válidos; comprovante de endereço devolvido por estar ilegível e reenviado seis minutos depois"
    >
      <ul className="mt-5 space-y-3">
        <Row>RG</Row>
        <Row>CPF</Row>
        <Row>Carteira de trabalho digital</Row>
        <Row>Certidão de casamento</Row>
        <Row>Certidão de nascimento · dependente</Row>
        <Row meta="reenviado 09:26">Comprovante de endereço</Row>
      </ul>
      <m.div variants={item} className="mt-4 rounded-xl border border-amber-200 bg-amber-50 px-3 py-2 text-[12px] text-[#8F4600]">
        09:20 · Beatriz Lima devolveu: “Imagem ilegível, pode fotografar de novo?” · 09:26 · Ana Ribeiro substituiu o arquivo.
      </m.div>
    </Card>
  )
}

function AsoVisual() {
  return (
    <Card
      eyebrow="SESMT · exame admissional"
      title="ASO · Ana Ribeiro"
      status={<Pill tone="ok">Apta</Pill>}
      label="ASO admissional: agendado na agenda do Dr. Henrique Sales para segunda 21/09 às 08:30, função Supervisor(a) de Produção, grupo de exposição de produção com ruído e umidade, exames clínico e audiometria, assinatura digital do médico do trabalho, evento S-2220 validado, e a lista de EPIs exigidos para o cargo"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={CalendarCheck} state="plain" meta="Seg 21/09 08:30">
          Agendado na agenda do Dr. Henrique Sales
        </Row>
        <Row icon={Building2} state="plain">
          GHE: Produção · ruído e umidade
        </Row>
        <Row icon={Stethoscope} state="plain">
          Exames do PCMSO: clínico e audiometria
        </Row>
        <Row icon={FileSignature} state="plain" meta="08:52">
          Dr. Henrique Sales · assinatura digital
        </Row>
        <Row icon={BadgeCheck} state="plain">
          eSocial S-2220 validado
        </Row>
      </ul>
      <m.div variants={item} className="mt-4 border-t border-brand-mist pt-3">
        <p className="text-[10px] font-bold uppercase tracking-wide text-brand-graphite">EPIs exigidos para o cargo</p>
        <div className="mt-2 flex flex-wrap gap-1.5">
          {['Protetor auricular', 'Óculos de proteção', 'Botina antiderrapante', 'Touca'].map((e) => (
            <Chip key={e}>{e}</Chip>
          ))}
        </div>
      </m.div>
    </Card>
  )
}

function ContractVisual() {
  return (
    <Card
      eyebrow="NatDocs · Assinatura Eletrônica"
      title="Contrato de trabalho · experiência 45 + 45 dias"
      status={<Pill tone="ok">Concluído</Pill>}
      label="Contrato de trabalho assinado eletronicamente pela colaboradora, pelo celular, e pela empresa, com validade jurídica; termo de uso dos sistemas e políticas internas assinados; download disponível na plataforma e originais e assinados enviados por e-mail"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={FileSignature} meta="12:40">
          Ana Ribeiro assinou pelo celular
        </Row>
        <Row icon={FileSignature} meta="12:41">
          Vale Verde Alimentos assinou
        </Row>
        <Row icon={ShieldCheck}>Padrão ICP-Brasil · validade jurídica</Row>
        <Row icon={Download} state="plain">
          Download disponível na plataforma
        </Row>
        <Row icon={Mail} state="plain" meta="12:42">
          Originais e assinados enviados por e-mail
        </Row>
      </ul>
      <m.div variants={item} className="mt-4 flex flex-wrap gap-1.5">
        <Chip>Termo de uso dos sistemas ✓</Chip>
        <Chip>Políticas internas ✓</Chip>
      </m.div>
      <Note>Nada para imprimir, nada para levar no primeiro dia. O GED guarda os originais e as versões assinadas.</Note>
    </Card>
  )
}

function ConfirmVisual() {
  const [inView, setInView] = useState(false)
  const [confirmed, setConfirmed] = useState(false)

  useEffect(() => {
    if (!inView) return
    const timer = window.setTimeout(() => setConfirmed(true), 1200)
    return () => window.clearTimeout(timer)
  }, [inView])

  return (
    <Card
      eyebrow="Admissão · programa no sistema Natcorp"
      title="Confirmar admissão"
      status={<Pill tone={confirmed ? 'ok' : 'wait'}>{confirmed ? 'Confirmada' : 'Pronta para confirmar'}</Pill>}
      label="Programa de admissão no sistema Natcorp: código da candidata C-48.213, Ana Ribeiro, data de admissão 28/09, cargo Supervisor(a) de Produção em Sorocaba; o botão Confirmar admissão vira Admissão confirmada às 09:40, e uma confirmação atualiza folha, ponto, benefícios, eSocial, headcount e portais"
    >
      <m.div variants={item} className="mt-4 grid grid-cols-2 gap-2 text-[12px]">
        <Field label="Código da candidata" value="C-48.213 · Ana Ribeiro" />
        <Field label="Data de admissão" value="28/09" />
        <Field label="Cargo" value="Supervisor(a) de Produção · Sorocaba" className="col-span-2" />
      </m.div>
      <m.div variants={item} onViewportEnter={() => setInView(true)} viewport={viewportOnce} className="mt-4">
        <m.div
          className={cn(
            'flex h-11 items-center justify-center gap-2 rounded-xl text-[13.5px] font-bold text-white transition-colors duration-500 ease-brand',
            confirmed ? 'bg-emerald-700' : 'bg-brand-purple',
          )}
          animate={confirmed ? { scale: [1, 0.97, 1] } : { scale: 1 }}
          transition={{ duration: 0.4, ease: EASE }}
        >
          {confirmed ? (
            <>
              <Check className="h-4 w-4" strokeWidth={3} aria-hidden />
              Admissão confirmada · 09:40
            </>
          ) : (
            'Confirmar admissão'
          )}
        </m.div>
      </m.div>
      <Note>Uma confirmação atualiza folha, ponto, benefícios, eSocial, headcount e portais.</Note>
    </Card>
  )
}

function PortalVisual() {
  return (
    <Card
      eyebrow="Portal do Colaborador · celular"
      title="Bom dia, Ana"
      status={
        <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-brand-off-white">
          <EmployeeAvatar ring className="h-8 w-8" />
        </span>
      }
      label="Portal do Colaborador no primeiro dia: escala da semana das 06:30 às 15:48, documentos assinados, holerite, espelho de ponto e informe de rendimentos a partir de 06/11, requisições que efetivam sozinhas, e a NATI se apresentando no canto da tela"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={Clock} state="plain" meta="06:30 às 15:48">
          Escala da semana
        </Row>
        <Row icon={FileText} state="plain" meta="3 no GED">
          Documentos assinados
        </Row>
        <Row icon={Wallet} state="plain" meta="a partir de 06/11">
          Holerite, espelho de ponto e informe
        </Row>
        <Row icon={IdCard} state="plain" meta="aprovada, efetiva">
          Requisições: férias, dados, dependentes, ponto
        </Row>
      </ul>
      <m.div variants={item} className="mt-4 flex items-start gap-2.5 rounded-xl border border-brand-mist bg-[#F7F5FA] p-3">
        <NatiAvatar ring className="mt-0.5 h-7 w-7 shrink-0" />
        <p className="text-[12.5px] leading-snug text-brand-ink">
          Oi, Ana. Sou a <b>NATI</b>, sua assistente de RH. Posso ajudar com o portal, o ponto ou os seus benefícios?
        </p>
      </m.div>
    </Card>
  )
}

function OnboardingVisual() {
  return (
    <Card
      eyebrow="Onboarding · Supervisor(a) de Produção"
      title="Bem-vinda à Vale Verde, Ana"
      status={<Pill tone="info">2 de 6</Pill>}
      label="Onboarding no portal: vídeo de boas-vindas assistido, código de conduta lido, mapa da unidade, termo de EPI, trilha de entrada e arquivos da primeira semana pendentes; comunicado de boas-vindas e vídeo institucional no Blog Corporativo"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={PlayCircle} meta="3 min">
          Vídeo de boas-vindas do diretor industrial
        </Row>
        <Row icon={BookOpen}>Código de conduta</Row>
        <Row state="next">Mapa da unidade: refeitório e vestiário</Row>
        <Row state="next" meta="hoje 07:30">
          Termo de EPI
        </Row>
        <Row state="next" meta="hoje 09:00">
          Trilha de entrada
        </Row>
        <Row state="next" meta="até sexta">
          Arquivos da primeira semana
        </Row>
      </ul>
      <m.div variants={item} className="mt-4 flex items-start gap-2 rounded-xl bg-brand-off-white p-3 text-[12px] text-brand-graphite">
        <Bell className="mt-0.5 h-3.5 w-3.5 shrink-0 text-brand-purple" aria-hidden />
        <span>
          <b className="text-brand-ink">Blog Corporativo:</b> “Boas-vindas aos admitidos de setembro” e o vídeo institucional da Vale Verde, no ar desde as 06:00.
        </span>
      </m.div>
    </Card>
  )
}

function EpiVisual() {
  return (
    <Card
      eyebrow="Ficha de EPI · Segurança do Trabalho"
      title="Supervisor(a) de Produção · Produção · Sorocaba"
      status={<Pill tone="ok">Assinada 07:34</Pill>}
      label="Ficha de EPI do cargo e do local de trabalho, prevista pela vaga com estoque reservado antes da admissão: protetor auricular, óculos de proteção, botina antiderrapante e touca, cada um com certificado de aprovação validado, entregues por Rafael Duarte e assinada eletronicamente na tela"
    >
      <m.p variants={item} className="mt-3 inline-flex items-center gap-1.5 text-[12px] font-semibold text-emerald-700">
        <ShieldCheck className="h-3.5 w-3.5 shrink-0" aria-hidden />
        Previsto pela vaga · estoque reservado antes da admissão
      </m.p>
      <ul className="mt-4 space-y-3">
        <Row icon={HardHat} meta="CA validado">
          Protetor auricular tipo concha
        </Row>
        <Row icon={HardHat} meta="CA validado">
          Óculos de proteção
        </Row>
        <Row icon={HardHat} meta="CA validado">
          Botina antiderrapante
        </Row>
        <Row icon={HardHat} meta="CA validado">
          Touca descartável
        </Row>
      </ul>
      <Note>Entregue por Rafael Duarte, técnico de segurança. Assinatura eletrônica na tela do tablet. Item com CA vencido não é liberado para entrega.</Note>
    </Card>
  )
}

function TrainingVisual() {
  return (
    <Card
      eyebrow="Trilha de entrada · Supervisor(a) de Produção"
      title="Matrícula automática na admissão"
      status={<Pill tone="info">1 de 4 hoje</Pill>}
      label="Trilha de entrada do cargo com matrícula automática na confirmação da admissão: integração de segurança em andamento, uso e conservação de EPIs, boas práticas de fabricação e liderança de primeiro nível nas próximas semanas"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={GraduationCap} state="active" meta="hoje 09:00 · 2h">
          Integração de segurança
        </Row>
        <Row state="next" meta="hoje 14:00">
          Uso e conservação de EPIs (NR-06)
        </Row>
        <Row state="next" meta="qua 30/09 · 4h">
          Boas práticas de fabricação
        </Row>
        <Row state="next" meta="online · 30 dias">
          Liderança de primeiro nível
        </Row>
      </ul>
      <Note>Presença e certificado registrados no perfil. A validade dos treinamentos obrigatórios é acompanhada pelo SESMT.</Note>
    </Card>
  )
}

function NatPontoVisual() {
  return (
    <div className="grid grid-cols-2 gap-3">
      <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height}>
        <NatPontoPhone screen="face" />
      </ScaledFrame>
      <ScaledFrame width={NATPONTO_SIZE.width} height={NATPONTO_SIZE.height}>
        <NatPontoPhone screen="receipt" />
      </ScaledFrame>
    </div>
  )
}

function EvaluationVisual() {
  return (
    <Card
      eyebrow="Avaliações e Feedbacks · Portal do Gestor"
      title="Ana Ribeiro · Supervisor(a) de Produção"
      status={<Pill tone="ok">Experiência 2 de 2</Pill>}
      label="Avaliações do período de experiência aos 45 e aos 90 dias, feitas pelo gestor, com feedback registrado e efetivação automática do contrato por prazo indeterminado; ao longo do ano, autoavaliação, ciclo 180º com o gestor e 360º com a equipe, pelo celular"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={Award} meta="12/11 · Marcos Tavares">
          Período 1 · 45 dias · Atende
        </Row>
        <Row icon={Award} meta="27/12 · Marcos Tavares">
          Período 2 · 90 dias · Supera
        </Row>
        <Row icon={MessageSquare} state="plain">
          Feedback: organização do turno e comunicação com a equipe
        </Row>
        <Row state="next" meta="ciclo anual">
          Autoavaliação
        </Row>
        <Row state="next" meta="pelo celular">
          180º com o gestor · 360º com a equipe
        </Row>
      </ul>
      <m.div variants={item} className="mt-4 rounded-xl bg-emerald-50 px-3 py-2 text-[12px] font-semibold text-emerald-700">
        Contrato por prazo indeterminado efetivado automaticamente em 28/12, conforme os períodos cadastrados no cargo.
      </m.div>
    </Card>
  )
}

function RequestVisual() {
  const requests = [
    { what: 'Ajuste de marcação', result: 'aprovada', when: '10/02' },
    { what: 'Alteração de endereço', result: 'efetivada', when: '16/03' },
    { what: 'Horas extras', result: 'autorizadas', when: '22/04' },
    { what: 'Atestado 2 dias', result: 'afastamento lançado', when: '18/05' },
    { what: 'Férias', result: 'agendadas', when: '05/07' },
    { what: 'Voto CIPA', result: 'registrado', when: '12/08' },
  ]
  return (
    <Card
      eyebrow="Portal do Colaborador · Minhas requisições"
      title="Ana Ribeiro · 2027"
      status={<Pill tone="ok">6 efetivadas</Pill>}
      label="Requisições da colaboradora ao longo dos meses, todas pelo portal e efetivadas sem o RH digitar: ajuste de marcação aprovada em fevereiro, alteração de endereço efetivada em março, horas extras autorizadas em abril, atestado de dois dias com afastamento lançado em maio, férias agendadas em julho e voto na CIPA registrado em agosto"
    >
      <ul className="mt-5 space-y-3">
        {requests.map((r) => (
          <Row key={r.what} meta={r.when}>
            {r.what} <span className="font-medium text-brand-graphite">· {r.result}</span>
          </Row>
        ))}
      </ul>
      <Note>Aprovada, a requisição efetiva o dado na hora. Nada disso passou pelo RH digitar.</Note>
    </Card>
  )
}

function MovementVisual() {
  return (
    <Card
      eyebrow="Portal do Gestor · Requisição de Movimentação"
      title="Ana Ribeiro · Mudança de horário contratual"
      status={<Pill tone="ok">Aprovada</Pill>}
      label="Requisição de Movimentação pelo Portal do Gestor: horário contratual de Ana Ribeiro muda de 06:30 às 15:48, turno 1, para 14:00 às 22:20, turno 2; solicitação de Marcos Tavares, alçada do RH com Beatriz Lima, horário atualizado no Ponto Eletrônico e alteração contratual enviada ao eSocial automaticamente"
    >
      <m.div variants={item} className="mt-4 flex items-center gap-2 text-[12px]">
        <div className="min-w-0 flex-1 rounded-xl bg-brand-off-white px-3 py-2">
          <p className="text-[10px] font-bold uppercase tracking-wide text-brand-graphite">De</p>
          <p className="font-semibold text-brand-ink">06:30 às 15:48</p>
          <p className="text-brand-graphite">Turno 1</p>
        </div>
        <ArrowRight className="h-4 w-4 shrink-0 text-brand-purple" aria-hidden />
        <div className="min-w-0 flex-1 rounded-xl border border-brand-purple/20 bg-brand-purple/5 px-3 py-2">
          <p className="text-[10px] font-bold uppercase tracking-wide text-brand-purple">Para</p>
          <p className="font-semibold text-brand-ink">14:00 às 22:20</p>
          <p className="text-brand-graphite">Turno 2</p>
        </div>
      </m.div>
      <Trail
        items={[
          { label: 'Solicitação', who: 'Marcos Tavares · Portal do Gestor', when: 'Seg 05/04 16:10' },
          { label: 'Alçada RH', who: 'Beatriz Lima · Departamento Pessoal', when: 'Ter 06/04 09:02' },
          { label: 'Horário atualizado no Ponto Eletrônico', who: 'Efetivado automaticamente', when: 'Ter 06/04 09:02', auto: true },
          { label: 'Alteração contratual enviada ao eSocial', who: 'Efetivado automaticamente', when: 'Ter 06/04 09:03', auto: true },
        ]}
      />
      <Note>Cargo, salário, posição e departamento seguem o mesmo fluxo. Fora da faixa de Cargos e Salários, o pedido não segue.</Note>
    </Card>
  )
}

function NatiVisual() {
  return (
    <NatiChatWindow bare bodyClassName="p-4">
      <Conversation stagger={0.5}>
        <UserBubble time="18:22">Apareceu um desconto no meu holerite de junho que eu não reconheço. O que é isso?</UserBubble>
        <NatiBubble>
          Ana, é a <b>coparticipação do plano de saúde</b> do seu filho, referente a uma consulta em <b>maio</b>. A operadora envia o valor e ele entra na folha do mês seguinte.
          <span className="mt-2 block">Quer que eu abra um Chamado Interno para o RH te enviar o extrato da operadora?</span>
        </NatiBubble>
        <UserBubble time="18:23">Sim, por favor.</UserBubble>
        <NatiBubble>
          Pronto. <b>Chamado #7.311</b> aberto com o RH, prazo de 8 horas. Você acompanha pelo Portal do Colaborador e eu te aviso quando responderem.
        </NatiBubble>
        <m.div variants={item} className="flex justify-center pt-1">
          <Pill tone="ok">Chamado #7.311 aberto · prazo 8h · respondido em 2h</Pill>
        </m.div>
      </Conversation>
    </NatiChatWindow>
  )
}

function PayrollVisual() {
  return (
    <Card
      eyebrow="Folha · Fechamento de outubro"
      title="10.000 colaboradores · 6 unidades"
      status={<Pill tone="ok">Calculada em 4 min 02 s</Pill>}
      label="Fechamento da folha de outubro: 10.000 colaboradores em 6 unidades calculados em 4 minutos e 2 segundos, a 2.500 folhas por minuto; ponto fechado nas 6 unidades, eSocial com 12 eventos S-1200 aceitos, benefícios conferidos; a NATI encontrou 2 inconsistências em 10.000 folhas antes do pagamento"
    >
      <m.div variants={item} className="mt-4">
        <div className="flex items-baseline justify-between text-[12px] text-brand-graphite">
          <span className="font-semibold text-brand-ink">Cálculo da folha</span>
          <span className="tabular">2.500 folhas por minuto</span>
        </div>
        <Bar value={100} max={100} className="mt-1.5" duration={1.6} />
      </m.div>
      <m.div variants={item} className="mt-4 grid grid-cols-3 gap-2">
        {[
          ['Ponto fechado', '6/6 unidades'],
          ['eSocial', 'S-1200 · 12/12 aceitos'],
          ['Benefícios', 'Conferidos'],
        ].map(([l, v]) => (
          <div key={l} className="rounded-xl bg-brand-off-white px-3 py-2.5">
            <p className="text-[10px] font-bold uppercase tracking-wide text-brand-graphite">{l}</p>
            <p className="mt-0.5 text-[12px] font-semibold leading-snug text-brand-ink">{v}</p>
          </div>
        ))}
      </m.div>
      <m.div variants={item} className="mt-4 flex items-start gap-2.5 rounded-xl border border-brand-mist bg-[#F7F5FA] p-3">
        <NatiAvatar ring className="mt-0.5 h-7 w-7 shrink-0" />
        <p className="text-[12.5px] leading-snug text-brand-ink">
          A NATI encontrou <b>2 inconsistências</b> em 10.000 folhas antes do pagamento.
        </p>
      </m.div>
      <Note>BI, People Analytics e Jurídico Trabalhista leem a mesma base. Nenhuma planilha exportada.</Note>
    </Card>
  )
}

function SuccessionVisual() {
  return (
    <Card
      eyebrow="Carreira e Sucessão · Coordenação de Produção"
      title="Mapa de sucessores"
      status={<Pill tone="info">Set/2027</Pill>}
      label="Mapa de sucessão para a Coordenação de Produção: Ana Ribeiro pronta em até um ano, com risco de perda baixo; Requisição de Promoção dentro da faixa do cargo e efetivada na folha e no organograma. O outro caminho: Offboarding, com solicitação, aprovação, documentos assinados e rescisão"
    >
      <ul className="mt-5 space-y-4">
        {[
          { name: 'Ana Ribeiro', ready: 'Pronta em até 1 ano', risk: 'risco de perda baixo', score: 90 },
          { name: 'Pedro Almeida', ready: 'Pronto em 1 a 2 anos', risk: 'risco de perda médio', score: 62 },
        ].map((p) => (
          <m.li key={p.name} variants={item}>
            <div className="flex items-center justify-between gap-3 text-[13.5px]">
              <span className="font-bold text-brand-ink">{p.name}</span>
              <span className="text-[11.5px] text-brand-graphite">{p.risk}</span>
            </div>
            <Bar value={p.score} max={100} className="mt-1.5 h-1.5" />
            <p className="mt-1 text-[11.5px] text-brand-graphite">{p.ready}</p>
          </m.li>
        ))}
      </ul>
      <m.div variants={item} className="mt-4 flex items-start gap-2 rounded-xl bg-brand-off-white p-3 text-[12px] text-brand-graphite">
        <TrendingUp className="mt-0.5 h-3.5 w-3.5 shrink-0 text-brand-purple" aria-hidden />
        <span>
          <b className="text-brand-ink">Requisição de Promoção:</b> Coordenação de Produção, dentro da faixa do cargo e da política de mérito. Efetivada na folha e no organograma.
        </span>
      </m.div>
      <Note>Ou: Offboarding · solicitação, aprovação, documentos assinados, rescisão. A posição volta ao headcount.</Note>
    </Card>
  )
}

const visuals: Record<VisualKey, () => ReactNode> = {
  approval: ApprovalVisual,
  process: ProcessVisual,
  jobboard: JobBoardVisual,
  candidate: CandidateVisual,
  talent: TalentVisual,
  sla: SlaVisual,
  admission: AdmissionVisual,
  dataform: DataFormVisual,
  benefits: BenefitsVisual,
  ged: GedVisual,
  aso: AsoVisual,
  contract: ContractVisual,
  confirm: ConfirmVisual,
  portal: PortalVisual,
  onboarding: OnboardingVisual,
  natponto: NatPontoVisual,
  epi: EpiVisual,
  training: TrainingVisual,
  evaluation: EvaluationVisual,
  request: RequestVisual,
  movement: MovementVisual,
  nati: NatiVisual,
  payroll: PayrollVisual,
  succession: SuccessionVisual,
}

/** Mini mockup de cada etapa da história. */
export function StepVisual({ visual }: { visual: VisualKey }) {
  const V = visuals[visual]
  return <V />
}
