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

/** Faixas de porte usadas no formulário do site anterior, sem sobreposição. */
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
  'Acima de 10.000',
]
