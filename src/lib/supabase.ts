import { createClient, type SupabaseClient } from '@supabase/supabase-js'

/**
 * Cliente do Supabase para o cadastro dos portais (tabela portal_clients, balde portal-logos).
 * Sem as variáveis VITE_SUPABASE_URL e VITE_SUPABASE_PUBLISHABLE_KEY o site funciona em modo de reserva:
 * a página dos portais usa a lista embutida e a administração abre em prévia, sem salvar.
 */
const url = import.meta.env.VITE_SUPABASE_URL as string | undefined
const key = (import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY ?? import.meta.env.VITE_SUPABASE_ANON_KEY) as string | undefined

export const supabase: SupabaseClient | null =
  url && key ? createClient(url, key, { auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true } }) : null

export const supabaseConfigured = supabase !== null
