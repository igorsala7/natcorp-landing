import type { ReactNode } from 'react'
import { m } from 'motion/react'
import {
  ArrowRight,
  Award,
  BadgeCheck,
  Bell,
  BookOpen,
  Building2,
  Check,
  Clock,
  Download,
  FileSignature,
  FileText,
  Gift,
  GraduationCap,
  HardHat,
  Heart,
  IdCard,
  Leaf,
  MapPin,
  MessageSquare,
  PlayCircle,
  ShieldCheck,
  Stethoscope,
  Timer,
  TrendingUp,
  User,
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

function Bar({ value, max, className }: { value: number; max: number; className?: string }) {
  const pct = Math.round((value / max) * 100)
  return (
    <div className={cn('h-2 w-full overflow-hidden rounded-full bg-brand-off-white', className)} aria-hidden>
      <m.div
        className="h-full rounded-full bg-[linear-gradient(90deg,#9A408A,#511C76)]"
        initial={{ width: 0 }}
        whileInView={{ width: `${pct}%` }}
        viewport={viewportOnce}
        transition={{ duration: 0.9, ease: EASE, delay: 0.3 }}
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

/* ---------- visuais por etapa ---------- */

function ApprovalVisual() {
  return (
    <Card
      eyebrow="Requisição de Pessoal · #51.208"
      title="Reposição · Supervisor(a) de Setor"
      status={<Pill tone="ok">Aprovada</Pill>}
      label="Requisição de pessoal aprovada: solicitação do gestor, validação da alçada financeira, aprovação final da diretoria e posição colocada em recrutamento automaticamente"
    >
      <m.div variants={item} className="mt-4 grid grid-cols-2 gap-2 text-[12px]">
        <div className="rounded-xl bg-brand-off-white px-3 py-2">
          <p className="text-[10px] font-bold uppercase tracking-wide text-brand-graphite">Centro de custo</p>
          <p className="font-semibold text-brand-ink">Produção · Sorocaba</p>
        </div>
        <div className="rounded-xl bg-brand-off-white px-3 py-2">
          <p className="text-[10px] font-bold uppercase tracking-wide text-brand-graphite">Custo da posição</p>
          <p className="font-semibold text-emerald-700">Dentro do orçado</p>
        </div>
      </m.div>
      <Trail
        items={[
          { label: 'Solicitação', who: 'Marcos Tavares · Portal do Gestor', when: 'Seg 07/09 08:52' },
          { label: 'Alçada financeira', who: 'Cláudia Nunes · Controladoria', when: 'Ter 08/09 10:15' },
          { label: 'Aprovação final', who: 'Diretoria de Operações · pelo celular', when: 'Ter 08/09 11:30' },
          { label: 'Posição em recrutamento', who: 'Efetivado automaticamente', when: 'Ter 08/09 11:31', auto: true },
        ]}
      />
    </Card>
  )
}

function ProcessVisual() {
  return (
    <Card
      eyebrow="Processo seletivo · criado automaticamente"
      title="Supervisor(a) de Setor · Produção"
      status={<Pill tone="info">Prazo: 20 dias</Pill>}
      label="Processo seletivo criado automaticamente a partir da requisição aprovada, com recrutadora responsável, etapas e prazo de 20 dias"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={User} state="plain" meta="responsável">
          Juliana Prado, recrutadora
        </Row>
        <Row icon={FileText} state="plain" meta="#51.208">
          Origem: Requisição de Pessoal
        </Row>
        <Row icon={Timer} state="plain" meta="até 28/09">
          Prazo da vaga: 20 dias
        </Row>
      </ul>
      <m.div variants={item} className="mt-5">
        <p className="text-[10px] font-bold uppercase tracking-wide text-brand-graphite">Etapas</p>
        <div className="mt-2 flex flex-wrap items-center gap-1.5">
          {['Triagem', 'Questionário', 'Entrevista com o gestor', 'Aprovação'].map((e, i, arr) => (
            <span key={e} className="flex items-center gap-1.5">
              <Chip>{e}</Chip>
              {i < arr.length - 1 && <ArrowRight className="h-3 w-3 text-brand-gray" aria-hidden />}
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
      aria-label="Quadro de vagas da empresa fictícia Vale Verde Alimentos, com a marca dela, mostrando a vaga de Supervisor(a) de Setor em Sorocaba e o botão Candidatar-se"
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
          <p className="text-[15px] font-bold text-brand-ink">Supervisor(a) de Setor</p>
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
      </div>
    </m.div>
  )
}

function CandidateVisual() {
  return (
    <Card
      eyebrow="Portal do Candidato · celular"
      title="Ana Ribeiro · Progresso da inscrição"
      status={<Pill tone="info">75%</Pill>}
      label="Portal do Candidato: currículo atualizado, questionário respondido e termos aceitos; entrevista aguardando convocação"
    >
      <m.div variants={item} className="mt-4">
        <Bar value={3} max={4} />
      </m.div>
      <ul className="mt-4 space-y-3">
        <Row meta="21:18">Currículo atualizado</Row>
        <Row meta="21:24">Questionário da área de produção</Row>
        <Row meta="21:27">Termos de tratamento de dados aceitos</Row>
        <Row state="next" meta="aguardando">
          Entrevista com o gestor
        </Row>
      </ul>
      <Note>Cadastrada no banco de talentos desde maio. O sistema avisou sobre a nova vaga pelo celular.</Note>
    </Card>
  )
}

function TalentVisual() {
  const people = [
    { name: 'Ana Ribeiro', score: 94, tags: 'Curso técnico · 4 anos em produção · questionário completo' },
    { name: 'Carlos Menezes', score: 88, tags: 'Líder de turno · 6 anos em alimentos' },
    { name: 'Patrícia Souza', score: 81, tags: 'Técnica em alimentos · 2 anos em produção' },
  ]
  return (
    <m.div
      role="img"
      aria-label="A NATI indica seis talentos aderentes à vaga a partir do banco de talentos; Ana Ribeiro aparece em primeiro"
      className="rounded-2xl border border-brand-mist bg-white p-5 shadow-lift"
      initial="hidden"
      whileInView="visible"
      viewport={viewportOnce}
      variants={{ hidden: {}, visible: { transition: { staggerChildren: 0.12, delayChildren: 0.15 } } }}
    >
      <m.div variants={item} className="flex items-center gap-3">
        <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-brand-off-white">
          <NatiAvatar ring className="h-9 w-9" />
        </span>
        <div className="min-w-0 flex-1">
          <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-brand-graphite">NATI · banco de talentos</p>
          <p className="text-[15px] font-bold text-brand-ink">6 talentos aderentes à vaga</p>
        </div>
      </m.div>
      <ul className="mt-5 space-y-3">
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
      title="Ana Ribeiro · Supervisor(a) de Setor"
      status={<Pill tone="wait">Aguardando a candidata</Pill>}
      label="Admissão Digital aberta automaticamente para Ana Ribeiro, com as etapas de dados, documentos, benefícios e assinatura ainda pendentes"
    >
      <ul className="mt-5 space-y-3">
        <Row state="active">Dados pessoais e bancários</Row>
        <Row state="next">Documentos</Row>
        <Row state="next">Escolha de benefícios</Row>
        <Row state="next">Assinatura do contrato</Row>
      </ul>
      <Note>Convite enviado em 16/09 às 10:02. Acompanhada por Beatriz Lima, Departamento Pessoal.</Note>
    </Card>
  )
}

function DataFormVisual() {
  return (
    <Card
      eyebrow="Portal do Candidato · celular"
      title="Dados da admissão"
      status={<Pill tone="ok">Concluído 20:34</Pill>}
      label="Dados da admissão preenchidos pela candidata no celular: dados pessoais, endereço, dados bancários, um dependente e cinco documentos fotografados"
    >
      <ul className="mt-5 space-y-3">
        <Row meta="20:14">Dados pessoais</Row>
        <Row meta="20:17">Endereço</Row>
        <Row meta="20:21">Dados bancários</Row>
        <Row meta="20:25">Dependentes (1)</Row>
        <Row meta="20:34">Documentos · 5 de 5</Row>
      </ul>
      <Note>A validação apontou um dígito errado na agência antes do envio. Corrigido na hora.</Note>
    </Card>
  )
}

function BenefitsVisual() {
  return (
    <Card
      eyebrow="Escolha de benefícios"
      title="Elegível: Supervisor(a) de Setor · Sorocaba"
      status={<Pill tone="ok">3 escolhidos</Pill>}
      label="Escolha de benefícios conforme a elegibilidade do cargo: plano de saúde com um dependente, vale-transporte e vale-alimentação; previdência privada não aderida"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={Heart} meta="titular + 1">
          Plano de saúde
        </Row>
        <Row icon={MapPin} meta="trajeto informado">
          Vale-transporte
        </Row>
        <Row icon={Gift}>Vale-alimentação</Row>
        <Row state="next" meta="não aderiu">
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
      title="Validação pelo Departamento Pessoal"
      status={<Pill tone="ok">5 de 5 válidos</Pill>}
      label="Documentos no GED validados pelo DP: RG, CPF, CNH e certidão do dependente válidos; comprovante de endereço devolvido por estar ilegível e reenviado seis minutos depois"
    >
      <ul className="mt-5 space-y-3">
        <Row>RG</Row>
        <Row>CPF</Row>
        <Row>CNH</Row>
        <Row>Certidão de nascimento · dependente</Row>
        <Row meta="reenviado 09:26">Comprovante de endereço</Row>
      </ul>
      <m.div variants={item} className="mt-4 rounded-xl border border-amber-200 bg-amber-50 px-3 py-2 text-[12px] text-[#8F4600]">
        09:20 · Beatriz Lima devolveu: “Imagem ilegível, pode fotografar de novo?” · 09:26 · Ana Ribeiro substituiu o arquivo.
      </m.div>
    </Card>
  )
}

function ContractVisual() {
  return (
    <Card
      eyebrow="NatDocs · Assinatura Eletrônica"
      title="Contrato de experiência · 45 + 45 dias"
      status={<Pill tone="ok">Concluído</Pill>}
      label="Contrato de experiência assinado eletronicamente pela colaboradora e pela empresa, no padrão ICP-Brasil, com o original disponível para download"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={FileSignature} meta="12:40">
          Ana Ribeiro assinou pelo celular
        </Row>
        <Row icon={FileSignature} meta="12:41">
          Vale Verde Alimentos assinou
        </Row>
        <Row icon={ShieldCheck}>Padrão ICP-Brasil · validade jurídica</Row>
      </ul>
      <m.div variants={item} className="mt-4 flex flex-wrap gap-1.5">
        <Chip>Termo de uso dos sistemas ✓</Chip>
        <Chip>Políticas internas ✓</Chip>
      </m.div>
      <m.p variants={item} className="mt-4 inline-flex items-center gap-1.5 text-[12.5px] font-semibold text-brand-purple">
        <Download className="h-3.5 w-3.5" aria-hidden />
        Baixar o original para verificação
      </m.p>
    </Card>
  )
}

function AsoVisual() {
  return (
    <Card
      eyebrow="SESMT · exame admissional"
      title="ASO · Ana Ribeiro"
      status={<Pill tone="ok">Apta</Pill>}
      label="ASO admissional: função Supervisor(a) de Setor, grupo de exposição de produção com ruído e umidade, exames clínico e audiometria, médico do trabalho com assinatura digital, evento S-2220 validado, e a lista de EPIs exigidos para o cargo"
    >
      <ul className="mt-5 space-y-3">
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
      label="Portal do Colaborador no primeiro dia: escala da semana, holerite a partir de 06/11, espelho de ponto, atualizar dados, e um chamado interno aberto para o crachá de acesso"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={Clock} state="plain" meta="06:30 às 18:00">
          Escala da semana
        </Row>
        <Row icon={Wallet} state="plain" meta="a partir de 06/11">
          Holerite
        </Row>
        <Row icon={IdCard} state="plain">
          Meus dados e benefícios ativos
        </Row>
      </ul>
      <m.div variants={item} className="mt-4 rounded-xl border border-brand-mist p-3">
        <div className="flex items-center justify-between gap-3">
          <p className="text-[12px] font-bold text-brand-ink">Chamado #7.812 · Crachá de acesso ao setor de qualidade</p>
          <Pill tone="wait">Em atendimento</Pill>
        </div>
        <p className="mt-1 text-[11.5px] text-brand-graphite">Aberto às 06:11 · previsão de resposta hoje</p>
      </m.div>
    </Card>
  )
}

function OnboardingVisual() {
  return (
    <Card
      eyebrow="Onboarding · primeira semana"
      title="Bem-vinda à Vale Verde, Ana"
      status={<Pill tone="info">2 de 6</Pill>}
      label="Onboarding no portal: vídeo de boas-vindas assistido, código de conduta lido, mapa da unidade, termo de EPI, trilha de entrada e encontro com o time pendentes; comunicado de boas-vindas no blog corporativo"
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
        <Row state="next" meta="quarta">
          Conheça o time
        </Row>
      </ul>
      <m.div variants={item} className="mt-4 flex items-start gap-2 rounded-xl bg-brand-off-white p-3 text-[12px] text-brand-graphite">
        <Bell className="mt-0.5 h-3.5 w-3.5 shrink-0 text-brand-purple" aria-hidden />
        <span>
          <b className="text-brand-ink">Blog corporativo:</b> “Boas-vindas aos admitidos de setembro” publicado hoje às 06:00.
        </span>
      </m.div>
    </Card>
  )
}

function EpiVisual() {
  return (
    <Card
      eyebrow="Ficha de EPI · Segurança do Trabalho"
      title="Supervisor(a) de Setor · Produção · Sorocaba"
      status={<Pill tone="ok">Assinada 07:34</Pill>}
      label="Ficha de EPI do cargo e do local de trabalho: protetor auricular, óculos de proteção, botina antiderrapante e touca, cada um com certificado de aprovação validado, entregues por Rafael Duarte e assinada eletronicamente na tela"
    >
      <ul className="mt-5 space-y-3">
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
      eyebrow="Trilha de entrada · Supervisor(a) de Setor"
      title="Matrícula automática na admissão"
      status={<Pill tone="info">1 de 5 hoje</Pill>}
      label="Trilha de entrada do cargo com matrícula automática: integração de segurança em andamento, uso e conservação de EPIs, segurança em máquinas, boas práticas de fabricação e liderança de primeiro nível"
    >
      <ul className="mt-5 space-y-3">
        <Row icon={GraduationCap} state="active" meta="hoje 09:00 · 2h">
          Integração de segurança
        </Row>
        <Row state="next" meta="hoje 14:00">
          Uso e conservação de EPIs (NR-06)
        </Row>
        <Row state="next" meta="qua 30/09 · 8h">
          Segurança em máquinas (NR-12)
        </Row>
        <Row state="next" meta="sex 02/10">
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
      eyebrow="Avaliação de experiência · Portal do Gestor"
      title="Ana Ribeiro · Supervisor(a) de Setor"
      status={<Pill tone="ok">Período 2 de 2</Pill>}
      label="Avaliações do período de experiência aos 45 e aos 90 dias, feitas pelo gestor, com feedback registrado e efetivação automática do contrato por prazo indeterminado"
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
      </ul>
      <m.div variants={item} className="mt-4 rounded-xl bg-emerald-50 px-3 py-2 text-[12px] font-semibold text-emerald-700">
        Contrato por prazo indeterminado efetivado automaticamente em 28/12, conforme os períodos cadastrados no cargo.
      </m.div>
    </Card>
  )
}

function NatiVisual() {
  return (
    <NatiChatWindow bare bodyClassName="p-4">
      <Conversation stagger={0.5}>
        <UserBubble time="22:05">Quando cai o meu primeiro pagamento completo?</UserBubble>
        <NatiBubble>
          Ana, seu primeiro pagamento completo é o da <b>folha de outubro</b>, no 5º dia útil: <b>06/11</b>. Os dias de 28 a 30/09 já entraram nele.
          <span className="mt-2 block">
            O adiantamento de <b>R$ 400,00</b> que você pediu pelo NatPay em 20/10 aparece como desconto no holerite.
          </span>
        </NatiBubble>
        <UserBubble time="22:06">Posso ver o holerite?</UserBubble>
        <NatiBubble>
          Claro. Ele fica disponível em 06/11 no Portal do Colaborador. Se preferir, eu te envio em PDF por aqui no mesmo dia.
        </NatiBubble>
      </Conversation>
    </NatiChatWindow>
  )
}

function RequestVisual() {
  return (
    <Card
      eyebrow="Requisição de Abono · #63.410"
      title="Marcação sem registro · 10/02 · 13:31"
      status={<Pill tone="ok">Efetivada</Pill>}
      label="Requisição de abono de marcação aberta pela colaboradora no app, aprovada pelo gestor no celular e regularizada automaticamente no ponto; um atestado de um dia enviado pelo portal em março"
    >
      <Trail
        items={[
          { label: 'Solicitação com justificativa', who: 'Ana Ribeiro · pelo app', when: '10/02 13:40' },
          { label: 'Aprovação do gestor', who: 'Marcos Tavares · Portal do Gestor', when: '10/02 18:05' },
          { label: 'Regularizada no ponto', who: 'Efetivado automaticamente antes da apuração', when: '10/02 18:05', auto: true },
        ]}
      />
      <Note>12/03 · Atestado de 1 dia enviado pelo portal: prontuário atualizado e falta justificada na folha.</Note>
    </Card>
  )
}

function SuccessionVisual() {
  return (
    <Card
      eyebrow="Carreira e Sucessão · Coordenação de Produção"
      title="Mapa de sucessores"
      status={<Pill tone="info">Set/2027</Pill>}
      label="Mapa de sucessão para a Coordenação de Produção: Ana Ribeiro pronta em até um ano, com risco de perda baixo; requisição de promoção dentro da faixa do cargo e efetivada na folha"
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
          <b className="text-brand-ink">Requisição de Promoção:</b> dentro da faixa do cargo e da política de mérito. Efetivada na folha e no organograma.
        </span>
      </m.div>
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
  contract: ContractVisual,
  aso: AsoVisual,
  portal: PortalVisual,
  onboarding: OnboardingVisual,
  epi: EpiVisual,
  training: TrainingVisual,
  natponto: NatPontoVisual,
  evaluation: EvaluationVisual,
  nati: NatiVisual,
  request: RequestVisual,
  succession: SuccessionVisual,
}

/** Mini mockup de cada etapa da história. */
export function StepVisual({ visual }: { visual: VisualKey }) {
  const V = visuals[visual]
  return <V />
}
