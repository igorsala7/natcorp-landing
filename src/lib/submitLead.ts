import type { LeadFormData } from './leadSchema'

export interface SubmitResult {
  demo: boolean
}

/**
 * Envia o lead para o endpoint configurado (webhook de automação ou proxy próprio).
 *
 * Configuração via variáveis de ambiente (ver .env.example):
 * - VITE_LEAD_WEBHOOK_URL: URL que recebe o POST JSON do lead
 * - VITE_LEAD_WEBHOOK_TOKEN (opcional): enviado como Authorization: Bearer
 *
 * Sem VITE_LEAD_WEBHOOK_URL o formulário opera em modo demonstração:
 * o payload é registrado no console e nenhuma requisição é feita.
 */
export async function submitLead(data: LeadFormData): Promise<SubmitResult> {
  const url = import.meta.env.VITE_LEAD_WEBHOOK_URL as string | undefined
  const token = import.meta.env.VITE_LEAD_WEBHOOK_TOKEN as string | undefined

  const payload = {
    ...data,
    origem: 'landing-natcorp',
    pagina: typeof window !== 'undefined' ? window.location.href : undefined,
    timestamp: new Date().toISOString(),
  }

  if (!url) {
    console.info('[Natcorp] Modo demonstração — lead não enviado:', payload)
    await new Promise((resolve) => setTimeout(resolve, 700))
    return { demo: true }
  }

  const headers: Record<string, string> = { 'Content-Type': 'application/json' }
  if (token) headers.Authorization = `Bearer ${token}`

  const res = await fetch(url, { method: 'POST', headers, body: JSON.stringify(payload) })
  if (!res.ok) throw new Error(`Falha ao enviar lead: HTTP ${res.status}`)

  return { demo: false }
}
