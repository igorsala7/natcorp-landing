import { z } from 'zod'

/**
 * Faixas de porte — DEFINIDAS PELO CRM, não pelo site.
 *
 * O `value` vai para o CRM e precisa bater caractere a caractere: o separador é
 * TRAVESSÃO (en dash, U+2013 "–"), não hífen, e os milhares levam ponto. Se um
 * hífen comum entrar aqui, o lead é gravado mas a classificação de porte falha
 * EM SILÊNCIO — chega sem prioridade e ninguém percebe. O `label` é livre, é só
 * o que a pessoa lê.
 *
 * Os cortes em 150 e 300 são os limiares que o CRM usa para decidir se a empresa
 * tem porte para o produto. Por isso as faixas anteriores do site (1 a 100,
 * 101 a 200, …) não podiam ser mapeadas: elas ATRAVESSAVAM esses limiares, e
 * nenhuma conversão daria um resultado correto. Não juntar, não dividir, não
 * inventar faixa nova sem alinhar com o CRM antes.
 */
export const colaboradoresOptions = [
  { value: 'até 50', label: 'Até 50' },
  { value: '51–150', label: '51 a 150' },
  { value: '151–300', label: '151 a 300' },
  { value: '301–500', label: '301 a 500' },
  { value: '501–1.000', label: '501 a 1.000' },
  { value: '1.001–3.000', label: '1.001 a 3.000' },
  { value: '3.001–10.000', label: '3.001 a 10.000' },
  { value: 'mais de 10.000', label: 'Mais de 10.000' },
] as const

export const colaboradoresValores = colaboradoresOptions.map((o) => o.value) as readonly string[]

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
  colaboradores: z
    .string()
    .min(1, 'Selecione o número de colaboradores')
    // Rede de segurança contra o erro mais caro desta integração: se alguém
    // reescrever a lista com hífen no lugar do travessão, o build continua
    // passando e o defeito só apareceria semanas depois, no funil comercial.
    .refine((v) => colaboradoresValores.includes(v), 'Faixa inválida'),
  empresas: z.string().min(1, 'Selecione quantas empresas ou CNPJs'),
  unidades: z.string().min(1, 'Selecione quantas unidades'),
  organizacao: z.string().optional(),
  mensagem: z.string().max(1000, 'Máximo de 1000 caracteres').optional(),
  novidades: z.boolean().optional(),
  /** Honeypot. Fica vazio para gente; robô que preenche tudo cai aqui. Ver LeadForm. */
  website: z.string().optional(),
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

/** Estrutura do grupo: quantas empresas ou CNPJs entram na mesma base. */
export const empresasOptions = ['1 empresa (1 CNPJ)', '2 a 3 empresas', '4 a 7 empresas', '8 a 15 empresas', 'Mais de 15 empresas']

/** Unidades, filiais ou lojas. */
export const unidadesOptions = ['1 unidade', '2 a 5 unidades', '6 a 10 unidades', '11 a 25 unidades', 'Mais de 25 unidades']

/** Como o RH está organizado hoje. */
export const organizacaoOptions = ['RH centralizado na matriz', 'RH em cada unidade ou filial', 'Misto: matriz e unidades', 'Ainda estamos definindo']
