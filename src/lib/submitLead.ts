import type { LeadFormData } from './leadSchema'

/**
 * Endpoint do CRM Natcorp.
 *
 * É PÚBLICO DE PROPÓSITO: não enviar `anon key`, `service_role`, token nem header
 * `Authorization`. Nenhum é necessário, e uma credencial embutida no bundle do
 * site (toda variável VITE_* é embutida) abriria superfície de ataque sem ganho.
 *
 * Fica como padrão no código, e não só em variável de ambiente, porque a versão
 * anterior caía em "modo demonstração" quando a variável faltava: o lead era
 * descartado no console e o visitante via tela de sucesso. Um deploy sem a
 * variável perdia todos os contatos sem nenhum sinal.
 */
const ENDPOINT_CRM = 'https://pwvybfbfoikaahqplned.supabase.co/functions/v1/leads'

/** Único motivo que a pessoa consegue corrigir; o resto o CRM não detalha de propósito. */
export type MotivoRecusa = 'email_invalido' | 'tente_mais_tarde'

export type SubmitResult = { ok: true } | { ok: false; motivo: MotivoRecusa }

/**
 * O site qualifica em três perguntas que o contrato do CRM não tem campo para
 * receber (`empresas`, `unidades`, `organizacao`). Inventar campo novo não
 * adianta — o endpoint ignora o que não conhece e a resposta seria perdida em
 * silêncio. Então elas entram na mensagem, rotuladas, para o time comercial ler
 * junto com o resto.
 */
function comporMensagem(data: LeadFormData): string {
  const qualificacao = [
    ['Empresas ou CNPJs no grupo', data.empresas],
    ['Unidades ou filiais', data.unidades],
    ['RH organizado hoje', data.organizacao],
  ]
    .filter(([, valor]) => valor)
    .map(([rotulo, valor]) => `${rotulo}: ${valor}`)

  const escrito = (data.mensagem ?? '').trim()
  if (!qualificacao.length) return escrito

  return [escrito, escrito ? '—' : null, ...qualificacao].filter(Boolean).join('\n')
}

/** Campanha de origem, quando a pessoa chegou por link marcado. */
function detectarOrigem(): string {
  if (typeof window === 'undefined') return 'landing-natcorp'
  const params = new URLSearchParams(window.location.search)
  return params.get('utm_campaign') || params.get('utm_source') || 'landing-natcorp'
}

/**
 * Envia o lead ao CRM.
 *
 * O endpoint responde SEMPRE HTTP 200 — o que importa está no corpo. Checar só
 * `res.ok` faria uma recusa (`{"ok":false}`) passar por sucesso e o lead sumiria
 * com o visitante vendo "recebemos seu contato".
 *
 * Recusa de negócio volta como `{ ok: false, motivo }`. Falha de rede lança, para
 * o formulário distinguir "tente mais tarde" de "verifique sua conexão".
 */
export async function submitLead(data: LeadFormData): Promise<SubmitResult> {
  const url = (import.meta.env.VITE_LEAD_WEBHOOK_URL as string | undefined)?.trim() || ENDPOINT_CRM

  const corpo = {
    nome: data.nome.trim(),
    email: data.email.trim(),
    empresa: data.empresa.trim(),
    cargo: data.cargo,
    // O site pergunta "Telefone / WhatsApp" num campo só. Vai como `telefone`:
    // repetir o mesmo número em `whatsapp` daria ao comercial a impressão de
    // dois canais confirmados quando há um.
    telefone: data.telefone.trim(),
    colaboradores: data.colaboradores,
    mensagem: comporMensagem(data),
    novidades: data.novidades === true,
    website: data.website ?? '', // honeypot: vai como veio, o servidor decide
    pagina: typeof window === 'undefined' ? '' : window.location.href,
    origem: detectarOrigem(),
    // `data_cadastro` NÃO vai: quem grava a data é o servidor.
  }

  const res = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(corpo),
  })

  const resposta = (await res.json().catch(() => null)) as
    | { ok?: boolean; motivo?: string }
    | null

  if (resposta?.ok) return { ok: true }

  return {
    ok: false,
    motivo: resposta?.motivo === 'email_invalido' ? 'email_invalido' : 'tente_mais_tarde',
  }
}
