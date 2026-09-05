import { z } from 'zod'

export const leadSchema = z.object({
  nome: z.string().min(2, 'Informe seu nome completo'),
  email: z
    .string()
    .email('Informe um e-mail válido')
    .refine(
      (v) => !/@(gmail|hotmail|outlook|yahoo|icloud|live|bol|uol)\./i.test(v),
      'Use o e-mail corporativo da sua empresa',
    ),
  telefone: z.string().refine((v) => {
    const digits = v.replace(/\D/g, '')
    return digits.length >= 10 && digits.length <= 13
  }, 'Informe um telefone válido com DDD'),
  empresa: z.string().min(2, 'Informe o nome da empresa'),
  cargo: z.string().min(1, 'Selecione seu cargo'),
  colaboradores: z.string().min(1, 'Selecione o número de colaboradores'),
  empresas: z.string().min(1, 'Selecione quantas empresas ou CNPJs'),
  unidades: z.string().min(1, 'Selecione quantas unidades'),
  organizacao: z.string().optional(),
  mensagem: z.string().max(1000, 'Máximo de 1000 caracteres').optional(),
  novidades: z.boolean().optional(),
})

export type LeadFormData = z.infer<typeof leadSchema>

export const cargoOptions = [
  'CEO / Presidência',
  'CFO / Diretoria Financeira',
  'CTO / Diretoria de Tecnologia',
  'CHRO / Diretoria de RH',
  'Gerência de RH',
  'Gerência de Departamento Pessoal',
  'Analista de RH',
  'Analista de Departamento Pessoal',
  'Outro',
]

/** Faixas de porte do formulário do site anterior, sem sobreposição, com o topo dividido para grupos grandes. */
export const colaboradoresOptions = [
  '1 a 100',
  '101 a 200',
  '201 a 300',
  '301 a 500',
  '501 a 700',
  '701 a 1.000',
  '1.001 a 2.000',
  '2.001 a 3.000',
  '3.001 a 4.000',
  '4.001 a 5.000',
  '5.001 a 8.000',
  '8.001 a 10.000',
  '10.001 a 20.000',
  'Acima de 20.000',
]

/** Estrutura do grupo: quantas empresas ou CNPJs entram na mesma base. */
export const empresasOptions = ['1 empresa (1 CNPJ)', '2 a 3 empresas', '4 a 7 empresas', '8 a 15 empresas', 'Mais de 15 empresas']

/** Unidades, filiais ou lojas. */
export const unidadesOptions = ['1 unidade', '2 a 5 unidades', '6 a 10 unidades', '11 a 25 unidades', 'Mais de 25 unidades']

/** Como o RH está organizado hoje. */
export const organizacaoOptions = ['RH centralizado na matriz', 'RH em cada unidade ou filial', 'Misto: matriz e unidades', 'Ainda estamos definindo']
