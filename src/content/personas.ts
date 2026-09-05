import type { LucideIcon } from 'lucide-react'
import { Briefcase, Building2, Calculator, FileSpreadsheet, ServerCog, Users } from 'lucide-react'
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
  {
    id: 'rh-filial',
    role: 'RH da unidade ou filial',
    headline: 'A sua unidade inteira, e só ela, em uma tela.',
    points: [
      'Vê e opera só a sua unidade: admissões, ponto, movimentações e benefícios dentro do seu perfil.',
      'Alçadas locais para aprovar o que é da filial, seguindo as políticas da matriz.',
      'Pendências da unidade resolvidas antes do corte, sem planilha para a matriz.',
    ],
    icon: Building2,
    portrait: people.rhFilial,
  },
  {
    id: 'financeiro',
    role: 'Contabilidade e Financeiro',
    headline: 'Folha contabilizada por empresa e CNPJ, pronta para o ERP.',
    points: [
      'Contabilização da folha por empresa, CNPJ e centro de custo.',
      'Provisões de férias, 13º e encargos calculadas no mesmo fechamento.',
      'Integração com o ERP pelo módulo de conexão, sem redigitar lançamentos.',
    ],
    icon: FileSpreadsheet,
    portrait: people.financeiro,
  },
]
