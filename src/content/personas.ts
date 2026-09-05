import type { LucideIcon } from 'lucide-react'
import { Briefcase, Calculator, ServerCog, Users } from 'lucide-react'
import { people, type Portrait } from './people'

export interface Persona {
  id: string
  role: string
  headline: string
  points: string[]
  icon: LucideIcon
  /** Retrato (foto provisória de banco, ver src/content/people.ts). */
  portrait: Portrait
}

export const personas: Persona[] = [
  {
    id: 'chro',
    role: 'CHRO e Diretoria de RH',
    headline: 'Um RH com lugar na mesa do negócio.',
    points: [
      'People Analytics e BI com dados de todos os módulos, prontos para a diretoria.',
      'Menos operação manual e mais tempo para estratégia, cultura e talentos.',
      'Carreira, sucessão, avaliações e metas na mesma base da folha.',
    ],
    icon: Users,
    portrait: people.chro,
  },
  {
    id: 'cfo',
    role: 'CEO e CFO',
    headline: 'Custo previsível, retorno mensurável.',
    points: [
      'Headcount e orçamento de pessoal previsto × realizado, em tempo real.',
      'Folha, benefícios e bônus com regras auditáveis e menos retrabalho.',
      'Jurídico trabalhista integrado para reduzir passivos e surpresas.',
    ],
    icon: Calculator,
    portrait: people.cfo,
  },
  {
    id: 'cto',
    role: 'CTO e Tecnologia',
    headline: 'Um sistema em vez de vários. Nuvem segura, com contingência.',
    points: [
      'Infraestrutura Oracle Cloud com produção, homologação e disaster recovery.',
      'Conexão com ERP e outros sistemas pelo módulo de importação e exportação.',
      'Um cadastro, uma base, um fornecedor. Menos integrações frágeis para manter.',
    ],
    icon: ServerCog,
    portrait: people.cto,
  },
  {
    id: 'rh',
    role: 'Gerência e Analistas de RH e DP',
    headline: 'O fim do retrabalho entre folha, ponto e eSocial.',
    points: [
      'Ponto apurado direto na folha e eSocial acompanhado dentro do sistema.',
      'Requisições aprovadas no workflow são efetivadas automaticamente.',
      'A NATI responde dúvidas de colaboradores e gestores antes de virarem chamado.',
    ],
    icon: Briefcase,
    portrait: people.rh,
  },
]
