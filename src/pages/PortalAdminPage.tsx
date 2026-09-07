import { useEffect, useMemo, useRef, useState, type FormEvent } from 'react'
import { Link } from 'react-router'
import type { Session } from '@supabase/supabase-js'
import { toast } from 'sonner'
import { ArrowUpRight, Check, ExternalLink, FlaskConical, ImagePlus, KeyRound, Loader2, LogOut, Plus, Search, ShieldAlert, Trash2, Wand2, X } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { PageTransition } from '@/components/motion/PageTransition'
import { Logo } from '@/components/brand/Logo'
import { useSeo } from '@/hooks/useSeo'
import { supabase, supabaseConfigured } from '@/lib/supabase'
import { deletePortalClient, fallbackClients, fetchPortalClients, friendlyError, savePortalClient, uploadLogo } from '@/lib/portalClients'
import {
  apexServers,
  defaultPortalUrl,
  defaultPortalUrls,
  hubPath,
  normalizeSlug,
  portalApps,
  type PortalClient,
  type PortalEnv,
  type PortalUrls,
} from '@/content/portals'
import { paths, siteConfig } from '@/content/site'
import { cn } from '@/lib/utils'

/**
 * Administração do cadastro dos portais (/admin/portais): só para o administrador.
 * Aqui entram o nome, o slug (/portais/<slug>), o código base do APEX (f?p=PO_<CÓDIGO>), o logotipo e os
 * endereços de cada portal em produção e em homologação. A página pública lê o que está aqui.
 * Sem o banco configurado, abre em prévia: dá para ver e mexer, mas nada é salvo.
 */
export default function PortalAdminPage() {
  useSeo({ title: 'Administração dos portais | Natcorp', description: 'Cadastro dos clientes e dos endereços dos portais.', path: paths.portalAdmin, noindex: true })
  const [session, setSession] = useState<Session | null>(null)
  const [authReady, setAuthReady] = useState(!supabaseConfigured)
  const [recovery, setRecovery] = useState(false)
  const [isAdmin, setIsAdmin] = useState<boolean | null>(supabaseConfigured ? null : true)

  useEffect(() => {
    if (!supabase) return
    supabase.auth.getSession().then(({ data }) => {
      setSession(data.session)
      setAuthReady(true)
    })
    const { data: sub } = supabase.auth.onAuthStateChange((event, s) => {
      setSession(s)
      if (event === 'PASSWORD_RECOVERY') setRecovery(true)
      if (event === 'SIGNED_OUT') setIsAdmin(null)
    })
    return () => sub.subscription.unsubscribe()
  }, [])

  const email = session?.user.email ?? null
  useEffect(() => {
    if (!supabase || !email) return
    let alive = true
    supabase
      .from('portal_admins')
      .select('email')
      .limit(1)
      .then(({ data, error }) => {
        if (!alive) return
        setIsAdmin(!error && (data?.length ?? 0) > 0)
      })
    return () => {
      alive = false
    }
  }, [email])

  const logout = async () => {
    await supabase?.auth.signOut()
    setRecovery(false)
  }

  let body: React.ReactNode
  if (!authReady) body = <Centered>{null}</Centered>
  else if (supabaseConfigured && !session) body = <Login />
  else if (supabaseConfigured && recovery) body = <NewPassword onDone={() => setRecovery(false)} />
  else if (supabaseConfigured && isAdmin === null) body = <Centered>{null}</Centered>
  else if (supabaseConfigured && isAdmin === false) body = <NoAccess email={email ?? ''} onLogout={logout} />
  else body = <Workspace preview={!supabaseConfigured} />

  return (
    <PageTransition>
      <div className="flex min-h-screen flex-col bg-brand-off-white text-brand-ink">
        <header className="on-dark sticky top-0 z-40 border-b border-white/10 bg-brand-blue text-white">
          <div className="container flex h-16 items-center gap-4">
            <Link to={paths.home} className="shrink-0" aria-label="Natcorp, ir para o site">
              <Logo variant="horizontal" tone="white" decorative className="h-7 w-auto sm:h-8" />
            </Link>
            <span className="h-6 w-px bg-white/25" aria-hidden />
            <span className="text-[14px] font-bold tracking-tight">Portais · Administração</span>
            <div className="ml-auto flex items-center gap-2 text-[13px]">
              {!supabaseConfigured && (
                <span className="hidden items-center gap-1.5 rounded-full bg-[#F2B84B] px-2.5 py-1 text-[11px] font-extrabold uppercase tracking-[0.12em] text-brand-ink sm:inline-flex">
                  <FlaskConical className="h-3 w-3" strokeWidth={2.4} /> Prévia
                </span>
              )}
              {email && <span className="hidden text-white/70 sm:inline">{email}</span>}
              {session && (
                <button
                  type="button"
                  onClick={logout}
                  className="inline-flex items-center gap-1.5 rounded-full border border-white/25 px-3 py-1.5 font-semibold text-white/90 hover:bg-white/10"
                >
                  <LogOut className="h-3.5 w-3.5" /> Sair
                </button>
              )}
            </div>
          </div>
        </header>
        {!supabaseConfigured && (
          <div className="border-b border-[#F2B84B]/50 bg-[#FFF4DB] text-[13px] text-[#6B4A00]">
            <div className="container flex flex-wrap items-center gap-x-3 gap-y-1 py-2">
              <span className="font-bold">Prévia sem banco.</span>
              <span>As alterações ficam só nesta tela. Para salvar de verdade, configure VITE_SUPABASE_URL e VITE_SUPABASE_PUBLISHABLE_KEY.</span>
            </div>
          </div>
        )}
        <main className="flex-1">{body}</main>
        <footer className="border-t border-brand-mist py-5 text-[12px] text-brand-gray">
          <div className="container flex flex-wrap justify-between gap-2">
            <span>
              © {new Date().getFullYear()} {siteConfig.name}. Uso interno.
            </span>
            <span>A página pública lê este cadastro na hora: o que você salva aqui já vale em natcorp.com.br/portais.</span>
          </div>
        </footer>
      </div>
    </PageTransition>
  )
}

function Centered({ children }: { children: React.ReactNode }) {
  return <div className="container flex min-h-[60vh] items-center justify-center py-16">{children}</div>
}

/* ---------------- entrada ---------------- */

type LoginMode = 'login' | 'signup' | 'reset'

function Login() {
  const [mode, setMode] = useState<LoginMode>('login')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [busy, setBusy] = useState(false)
  const [note, setNote] = useState<string | null>(null)
  const adminUrl = typeof window !== 'undefined' ? `${window.location.origin}${paths.portalAdmin}` : paths.portalAdmin

  const submit = async (e: FormEvent) => {
    e.preventDefault()
    if (!supabase) return
    setBusy(true)
    setNote(null)
    try {
      const mail = email.trim().toLowerCase()
      if (mode === 'login') {
        const { error } = await supabase.auth.signInWithPassword({ email: mail, password })
        if (error) throw error
      } else if (mode === 'signup') {
        const { data, error } = await supabase.auth.signUp({ email: mail, password, options: { emailRedirectTo: adminUrl } })
        if (error) throw error
        if (data.session) return
        setNote('Enviamos um e-mail de confirmação. Abra o link e depois entre com a senha que você acabou de criar.')
        setMode('login')
      } else {
        const { error } = await supabase.auth.resetPasswordForEmail(mail, { redirectTo: adminUrl })
        if (error) throw error
        setNote('Se este e-mail for de um administrador, você recebe um link para criar uma senha nova.')
        setMode('login')
      }
    } catch (err) {
      toast.error(friendlyError(err))
    } finally {
      setBusy(false)
    }
  }

  const titles: Record<LoginMode, { title: string; lead: string; cta: string }> = {
    login: { title: 'Entrar', lead: 'Só administradores da Natcorp alteram o cadastro dos portais.', cta: 'Entrar' },
    signup: { title: 'Primeiro acesso', lead: 'Crie a senha do seu e-mail de administrador. Só e-mails autorizados conseguem concluir.', cta: 'Criar senha' },
    reset: { title: 'Esqueci a senha', lead: 'Você recebe um link por e-mail para criar uma senha nova.', cta: 'Enviar o link' },
  }
  const t = titles[mode]

  return (
    <Centered>
      <form onSubmit={submit} className="w-full max-w-md rounded-[28px] border border-brand-mist bg-white p-8 shadow-soft sm:p-10">
        <span className="grid h-12 w-12 place-items-center rounded-2xl bg-brand-gradient text-white">
          <KeyRound className="h-5 w-5" strokeWidth={2} />
        </span>
        <h1 className="mt-6 text-[26px] font-extrabold leading-tight">{t.title}</h1>
        <p className="mt-2 text-[14.5px] leading-relaxed text-brand-graphite">{t.lead}</p>
        {note && <p className="mt-4 rounded-xl border border-brand-mist bg-brand-off-white px-4 py-3 text-[13.5px] leading-relaxed text-brand-ink">{note}</p>}
        <div className="mt-6 space-y-4">
          <Field label="E-mail" htmlFor="adm-email">
            <Input
              id="adm-email"
              type="email"
              autoComplete="username"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="voce@natcorp.com.br"
            />
          </Field>
          {mode !== 'reset' && (
            <Field label={mode === 'signup' ? 'Senha nova (8 caracteres ou mais)' : 'Senha'} htmlFor="adm-pass">
              <Input
                id="adm-pass"
                type="password"
                autoComplete={mode === 'signup' ? 'new-password' : 'current-password'}
                required
                minLength={8}
                value={password}
                onChange={(e) => setPassword(e.target.value)}
              />
            </Field>
          )}
        </div>
        <Button type="submit" size="lg" className="mt-6 w-full" disabled={busy}>
          {busy ? <Loader2 className="animate-spin" /> : null}
          {t.cta}
        </Button>
        <div className="mt-5 flex flex-wrap justify-between gap-x-4 gap-y-2 text-[13px] font-semibold text-brand-purple">
          {mode !== 'login' ? (
            <button type="button" className="hover:underline" onClick={() => setMode('login')}>
              Já tenho senha
            </button>
          ) : (
            <button type="button" className="hover:underline" onClick={() => setMode('signup')}>
              Primeiro acesso
            </button>
          )}
          {mode !== 'reset' && (
            <button type="button" className="hover:underline" onClick={() => setMode('reset')}>
              Esqueci a senha
            </button>
          )}
        </div>
      </form>
    </Centered>
  )
}

function NewPassword({ onDone }: { onDone: () => void }) {
  const [password, setPassword] = useState('')
  const [busy, setBusy] = useState(false)
  const submit = async (e: FormEvent) => {
    e.preventDefault()
    if (!supabase) return
    setBusy(true)
    try {
      const { error } = await supabase.auth.updateUser({ password })
      if (error) throw error
      toast.success('Senha alterada.')
      onDone()
    } catch (err) {
      toast.error(friendlyError(err))
    } finally {
      setBusy(false)
    }
  }
  return (
    <Centered>
      <form onSubmit={submit} className="w-full max-w-md rounded-[28px] border border-brand-mist bg-white p-8 shadow-soft sm:p-10">
        <h1 className="text-[26px] font-extrabold leading-tight">Senha nova</h1>
        <p className="mt-2 text-[14.5px] text-brand-graphite">Escolha a senha do seu acesso de administrador.</p>
        <Field label="Senha nova (8 caracteres ou mais)" htmlFor="adm-new" className="mt-6">
          <Input id="adm-new" type="password" autoComplete="new-password" required minLength={8} value={password} onChange={(e) => setPassword(e.target.value)} />
        </Field>
        <Button type="submit" size="lg" className="mt-6 w-full" disabled={busy}>
          {busy ? <Loader2 className="animate-spin" /> : null}
          Salvar a senha
        </Button>
      </form>
    </Centered>
  )
}

function NoAccess({ email, onLogout }: { email: string; onLogout: () => void }) {
  return (
    <Centered>
      <div className="w-full max-w-md rounded-[28px] border border-brand-mist bg-white p-8 text-center shadow-soft sm:p-10">
        <span className="mx-auto grid h-12 w-12 place-items-center rounded-2xl bg-brand-off-white text-brand-purple">
          <ShieldAlert className="h-6 w-6" strokeWidth={2} />
        </span>
        <h1 className="mt-6 text-[24px] font-extrabold">Sem permissão</h1>
        <p className="mt-2 text-[14.5px] leading-relaxed text-brand-graphite">
          O e-mail <b className="text-brand-ink">{email}</b> não está na lista de administradores dos portais.
        </p>
        <Button variant="secondary" className="mt-6" onClick={onLogout}>
          <LogOut /> Sair
        </Button>
      </div>
    </Centered>
  )
}

/* ---------------- área de trabalho ---------------- */

const blank = (): PortalClient => ({ slug: '', name: '', code: '', apex: 'rh', active: true, urls: { prod: {}, dev: {} } })

function Workspace({ preview }: { preview: boolean }) {
  const [clients, setClients] = useState<PortalClient[]>(() => (preview ? fallbackClients() : []))
  const [loading, setLoading] = useState(!preview)
  const [selected, setSelected] = useState<string | null>(null)
  const [creating, setCreating] = useState(false)
  const [query, setQuery] = useState('')

  useEffect(() => {
    if (preview) return
    let alive = true
    fetchPortalClients()
      .then((rows) => {
        if (!alive) return
        if (rows) setClients(rows)
        setLoading(false)
      })
      .catch((err) => {
        if (!alive) return
        toast.error(friendlyError(err))
        setLoading(false)
      })
    return () => {
      alive = false
    }
  }, [preview])

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase()
    return q ? clients.filter((c) => `${c.name} ${c.slug} ${c.code}`.toLowerCase().includes(q)) : clients
  }, [clients, query])

  const current = creating ? null : (clients.find((c) => c.slug === selected) ?? null)

  const afterSave = (saved: PortalClient, previousSlug?: string) => {
    setClients((list) => {
      const without = list.filter((c) => c.slug !== previousSlug && c.slug !== saved.slug)
      return [...without, saved].sort((a, b) => a.name.localeCompare(b.name, 'pt-BR'))
    })
    setCreating(false)
    setSelected(saved.slug)
  }
  const afterDelete = (slug: string) => {
    setClients((list) => list.filter((c) => c.slug !== slug))
    setSelected(null)
  }

  return (
    <div className="container grid gap-6 py-8 lg:grid-cols-[300px_minmax(0,1fr)] lg:gap-8 lg:py-10">
      <aside className="lg:sticky lg:top-24 lg:self-start">
        <div className="flex items-center justify-between gap-3">
          <h1 className="text-[20px] font-extrabold leading-tight">Clientes</h1>
          <Button
            size="sm"
            onClick={() => {
              setCreating(true)
              setSelected(null)
            }}
          >
            <Plus /> Novo cliente
          </Button>
        </div>
        <div className="relative mt-4">
          <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-brand-gray" />
          <Input
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Buscar por nome, slug ou código"
            className="bg-white pl-9"
            aria-label="Buscar cliente"
          />
        </div>
        <ul className="mt-4 space-y-1.5" aria-label="Lista de clientes">
          {loading && <li className="rounded-xl border border-brand-mist bg-white px-4 py-3 text-[13px] text-brand-gray">Carregando…</li>}
          {!loading && filtered.length === 0 && (
            <li className="rounded-xl border border-dashed border-brand-mist px-4 py-3 text-[13px] text-brand-gray">Nenhum cliente encontrado.</li>
          )}
          {filtered.map((c) => {
            const active = !creating && c.slug === selected
            return (
              <li key={c.slug}>
                <button
                  type="button"
                  onClick={() => {
                    setCreating(false)
                    setSelected(c.slug)
                  }}
                  className={cn(
                    'flex w-full items-center gap-3 rounded-xl border px-3.5 py-2.5 text-left transition-colors',
                    active ? 'border-brand-purple bg-brand-purple text-white' : 'border-brand-mist bg-white hover:border-brand-purple/40',
                  )}
                >
                  <span
                    className={cn('h-2 w-2 shrink-0 rotate-45 rounded-[1px]', active ? 'bg-white' : c.active === false ? 'bg-brand-gray' : 'bg-brand-gradient')}
                    aria-hidden
                  />
                  <span className="min-w-0 flex-1">
                    <span className="block truncate text-[14px] font-bold">{c.name}</span>
                    <span className={cn('block truncate text-[12px]', active ? 'text-white/75' : 'text-brand-gray')}>
                      /portais/{c.slug} · {c.code}
                    </span>
                  </span>
                  {c.active === false && (
                    <span
                      className={cn(
                        'rounded-full px-2 py-0.5 text-[10px] font-bold uppercase tracking-[0.1em]',
                        active ? 'bg-white/20' : 'bg-brand-off-white text-brand-gray',
                      )}
                    >
                      Inativo
                    </span>
                  )}
                </button>
              </li>
            )
          })}
        </ul>
      </aside>

      <section aria-live="polite">
        {creating || current ? (
          <ClientForm
            key={creating ? '__new__' : current!.slug}
            initial={current ?? blank()}
            isNew={creating}
            preview={preview}
            onSaved={afterSave}
            onDeleted={afterDelete}
            onCancel={() => setCreating(false)}
          />
        ) : (
          <div className="flex min-h-[420px] flex-col items-center justify-center rounded-[28px] border border-dashed border-brand-mist bg-white/60 p-10 text-center">
            <span className="grid h-14 w-14 place-items-center rounded-2xl bg-brand-gradient text-white">
              <Wand2 className="h-6 w-6" strokeWidth={2} />
            </span>
            <h2 className="mt-5 text-[20px] font-extrabold">Escolha um cliente ao lado</h2>
            <p className="mt-2 max-w-md text-[14.5px] leading-relaxed text-brand-graphite">
              Cada cliente tem nome, slug, código base, logotipo e os endereços dos seis portais em produção e em homologação. A página pública mostra exatamente o que
              está salvo aqui.
            </p>
          </div>
        )}
      </section>
    </div>
  )
}

/* ---------------- formulário ---------------- */

interface ClientFormProps {
  initial: PortalClient
  isNew: boolean
  preview: boolean
  onSaved: (saved: PortalClient, previousSlug?: string) => void
  onDeleted: (slug: string) => void
  onCancel: () => void
}

const slugify = (s: string) =>
  s
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .slice(0, 40)

function ClientForm({ initial, isNew, preview, onSaved, onDeleted, onCancel }: ClientFormProps) {
  const [draft, setDraft] = useState<PortalClient>(initial)
  const [touched, setTouched] = useState({ slug: !isNew, code: !isNew })
  const [saving, setSaving] = useState(false)
  const [uploading, setUploading] = useState(false)
  const fileRef = useRef<HTMLInputElement>(null)
  const dirty = JSON.stringify(draft) !== JSON.stringify(initial)

  const set = <K extends keyof PortalClient>(key: K, value: PortalClient[K]) => setDraft((d) => ({ ...d, [key]: value }))
  const setUrl = (env: PortalEnv, key: keyof PortalUrls, value: string) =>
    setDraft((d) => ({ ...d, urls: { ...d.urls, [env]: { ...(d.urls?.[env] ?? {}), [key]: value } } }))
  const fill = (env: PortalEnv) => setDraft((d) => ({ ...d, urls: { ...d.urls, [env]: defaultPortalUrls(d, env) } }))

  const onName = (name: string) => {
    setDraft((d) => ({
      ...d,
      name,
      slug: touched.slug ? d.slug : slugify(name),
      code: touched.code ? d.code : slugify(name).replace(/-/g, '').toUpperCase(),
    }))
  }

  const errors = validate(draft)

  const save = async (e: FormEvent) => {
    e.preventDefault()
    if (errors.length) {
      toast.error(errors[0])
      return
    }
    const clean: PortalClient = { ...draft, slug: normalizeSlug(draft.slug), code: draft.code.trim().toUpperCase(), name: draft.name.trim() }
    if (preview) {
      onSaved(clean, isNew ? undefined : initial.slug)
      toast.info('Prévia: nada foi salvo no banco.')
      return
    }
    setSaving(true)
    try {
      const saved = await savePortalClient(clean, isNew ? undefined : initial.slug)
      onSaved(saved, isNew ? undefined : initial.slug)
      toast.success(`${saved.name} salvo.`)
    } catch (err) {
      toast.error(friendlyError(err))
    } finally {
      setSaving(false)
    }
  }

  const remove = async () => {
    if (!window.confirm(`Excluir ${initial.name}? A página /portais/${initial.slug} deixa de existir.`)) return
    if (preview) {
      onDeleted(initial.slug)
      toast.info('Prévia: nada foi apagado no banco.')
      return
    }
    setSaving(true)
    try {
      await deletePortalClient(initial.slug)
      onDeleted(initial.slug)
      toast.success(`${initial.name} excluído.`)
    } catch (err) {
      toast.error(friendlyError(err))
    } finally {
      setSaving(false)
    }
  }

  const pickLogo = async (file: File | undefined) => {
    if (!file) return
    if (file.size > 2 * 1024 * 1024) {
      toast.error('O logotipo precisa ter até 2 MB.')
      return
    }
    if (preview) {
      set('logoUrl', URL.createObjectURL(file))
      toast.info('Prévia: o logotipo não foi enviado.')
      return
    }
    const slug = normalizeSlug(draft.slug)
    if (!slug) {
      toast.error('Preencha o slug antes de enviar o logotipo.')
      return
    }
    setUploading(true)
    try {
      const url = await uploadLogo(slug, file)
      set('logoUrl', url)
      toast.success('Logotipo enviado. Salve o cliente para publicar.')
    } catch (err) {
      toast.error(friendlyError(err))
    } finally {
      setUploading(false)
      if (fileRef.current) fileRef.current.value = ''
    }
  }

  const code = draft.code.trim().toUpperCase() || 'CODIGO'
  const slug = normalizeSlug(draft.slug) || 'slug'

  return (
    <form onSubmit={save} className="space-y-6">
      {/* identidade */}
      <Card title={isNew ? 'Novo cliente' : draft.name || 'Cliente'} lead="Nome, endereço da página e código base no APEX.">
        <div className="grid gap-5 md:grid-cols-2">
          <Field label="Nome do cliente" htmlFor="c-name" hint="Como aparece na página e no cabeçalho.">
            <Input id="c-name" value={draft.name} onChange={(e) => onName(e.target.value)} placeholder="Stefanini" required maxLength={80} className="bg-white" />
          </Field>
          <Field label="Ativo" htmlFor="c-active" hint="Inativo: a página some, o cadastro fica.">
            <label htmlFor="c-active" className="flex h-10 cursor-pointer items-center gap-3 rounded-md border border-input bg-white px-3 text-[14px]">
              <input
                id="c-active"
                type="checkbox"
                checked={draft.active !== false}
                onChange={(e) => set('active', e.target.checked)}
                className="h-4 w-4 accent-[#511C76]"
              />
              {draft.active !== false ? 'Página no ar' : 'Página fora do ar'}
            </label>
          </Field>
          <Field label="Slug (endereço da página)" htmlFor="c-slug" hint={`natcorp.com.br/portais/${slug} e /portais/dev/${slug}`}>
            <div className="flex items-center rounded-md border border-input bg-white focus-within:ring-2 focus-within:ring-ring focus-within:ring-offset-2">
              <span className="pl-3 text-[13px] text-brand-gray">/portais/</span>
              <input
                id="c-slug"
                value={draft.slug}
                onChange={(e) => {
                  setTouched((t) => ({ ...t, slug: true }))
                  set('slug', e.target.value.toLowerCase())
                }}
                placeholder="stefanini"
                required
                pattern="[a-z0-9][a-z0-9\-]{0,39}"
                title="Letras minúsculas, números e hífen"
                className="h-10 w-full bg-transparent px-1.5 text-[14px] outline-none"
              />
            </div>
          </Field>
          <Field label="Código base no APEX" htmlFor="c-code" hint={`f?p=PO_${code}, PC_${code}, PG_${code}…`}>
            <Input
              id="c-code"
              value={draft.code}
              onChange={(e) => {
                setTouched((t) => ({ ...t, code: true }))
                set('code', e.target.value.toUpperCase())
              }}
              placeholder="STEFANINI"
              required
              pattern="[A-Z0-9_]{1,40}"
              title="Letras maiúsculas, números e sublinhado"
              className="bg-white font-mono"
            />
          </Field>
        </div>

        <div className="mt-6 grid gap-5 md:grid-cols-[minmax(0,1fr)_auto] md:items-start">
          <Field label="Logotipo" hint="SVG, PNG, WebP ou JPG, até 2 MB. Aparece no cabeçalho e no cartão da abertura, sobre fundo branco.">
            <div className="flex flex-wrap items-center gap-3">
              <div className="flex h-[88px] w-[240px] items-center justify-center overflow-hidden rounded-xl border border-brand-mist bg-white px-4">
                {draft.logoUrl ? (
                  <img src={draft.logoUrl} alt={draft.name || 'Logotipo'} className="max-h-14 max-w-full object-contain" />
                ) : (
                  <span className="text-[13px] text-brand-gray">{draft.name ? draft.name : 'Sem logotipo'}</span>
                )}
              </div>
              <div className="flex flex-wrap gap-2">
                <input
                  ref={fileRef}
                  type="file"
                  accept="image/svg+xml,image/png,image/webp,image/jpeg"
                  className="sr-only"
                  id="c-logo"
                  onChange={(e) => pickLogo(e.target.files?.[0])}
                />
                <Button type="button" variant="secondary" size="sm" disabled={uploading} onClick={() => fileRef.current?.click()}>
                  {uploading ? <Loader2 className="animate-spin" /> : <ImagePlus />}
                  {draft.logoUrl ? 'Trocar' : 'Enviar logotipo'}
                </Button>
                {draft.logoUrl && (
                  <Button type="button" variant="ghost" size="sm" onClick={() => set('logoUrl', undefined)}>
                    <X /> Remover
                  </Button>
                )}
              </div>
            </div>
          </Field>
        </div>
      </Card>

      <UrlsCard env="prod" draft={draft} onUrl={setUrl} onFill={() => fill('prod')} onApex={(v) => set('apex', v)} />
      <UrlsCard env="dev" draft={draft} onUrl={setUrl} onFill={() => fill('dev')} />

      {/* ações */}
      <div className="sticky bottom-0 z-10 -mx-5 border-t border-brand-mist bg-brand-off-white/95 px-5 py-4 backdrop-blur sm:-mx-6 sm:px-6 lg:mx-0 lg:rounded-2xl lg:border lg:px-5">
        <div className="flex flex-wrap items-center gap-3">
          {!isNew && (
            <>
              <a
                href={hubPath(initial.slug, 'prod')}
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-1.5 text-[13px] font-bold text-brand-purple hover:underline"
              >
                Ver a página <ExternalLink className="h-3.5 w-3.5" />
              </a>
              <a
                href={hubPath(initial.slug, 'dev')}
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-1.5 text-[13px] font-bold text-[#B8791F] hover:underline"
              >
                Ver a homologação <ExternalLink className="h-3.5 w-3.5" />
              </a>
            </>
          )}
          <div className="ml-auto flex flex-wrap items-center gap-2">
            {!isNew && (
              <Button type="button" variant="ghost" size="sm" className="text-destructive hover:bg-red-50" disabled={saving} onClick={remove}>
                <Trash2 /> Excluir
              </Button>
            )}
            {isNew && (
              <Button type="button" variant="ghost" size="sm" onClick={onCancel}>
                Cancelar
              </Button>
            )}
            <Button type="submit" size="lg" disabled={saving || (!dirty && !isNew)}>
              {saving ? <Loader2 className="animate-spin" /> : <Check />}
              {isNew ? 'Cadastrar cliente' : 'Salvar alterações'}
            </Button>
          </div>
        </div>
        {errors.length > 0 && dirty && <p className="mt-2 text-[12.5px] text-destructive">{errors[0]}</p>}
      </div>
    </form>
  )
}

function validate(c: PortalClient): string[] {
  const out: string[] = []
  if (!c.name.trim()) out.push('Informe o nome do cliente.')
  if (!/^[a-z0-9][a-z0-9-]{0,39}$/.test(normalizeSlug(c.slug))) out.push('O slug aceita letras minúsculas, números e hífen (ex.: stefanini).')
  if (!/^[A-Z0-9_]{1,40}$/.test(c.code.trim().toUpperCase())) out.push('O código base aceita letras maiúsculas, números e sublinhado (ex.: STEFANINI).')
  for (const env of ['prod', 'dev'] as const) {
    for (const app of portalApps) {
      const v = c.urls?.[env]?.[app.key]?.trim()
      if (v && !/^https?:\/\/\S+$/i.test(v)) out.push(`O endereço do ${app.name} (${env === 'dev' ? 'homologação' : 'produção'}) precisa começar com https://.`)
    }
  }
  return out
}

interface UrlsCardProps {
  env: PortalEnv
  draft: PortalClient
  onUrl: (env: PortalEnv, key: keyof PortalUrls, value: string) => void
  onFill: () => void
  onApex?: (v: string) => void
}

/** Os seis endereços de um ambiente, com o preenchimento pelo padrão do APEX e o padrão como dica. */
function UrlsCard({ env, draft, onUrl, onFill, onApex }: UrlsCardProps) {
  const dev = env === 'dev'
  const urls = draft.urls?.[env] ?? {}
  const missing = portalApps.filter((a) => !urls[a.key]?.trim()).length
  return (
    <Card
      title={dev ? 'Endereços de homologação' : 'Endereços de produção'}
      lead={
        dev
          ? 'Os portais da base de testes (/portais/dev/<slug>). Um campo vazio usa o padrão em /apex/dev/.'
          : 'Os portais que os clientes usam no dia a dia. Um campo vazio usa o padrão do servidor escolhido.'
      }
      accent={dev ? 'amber' : 'purple'}
      aside={
        <div className="flex flex-wrap items-center gap-2">
          {!dev && onApex && (
            <label className="flex items-center gap-2 text-[12.5px] font-semibold text-brand-graphite">
              Servidor
              <select
                value={apexServers.includes(draft.apex as (typeof apexServers)[number]) ? draft.apex : '__other'}
                onChange={(e) => e.target.value !== '__other' && onApex(e.target.value)}
                className="h-9 rounded-md border border-input bg-white px-2 text-[13px] font-mono"
              >
                {apexServers.map((s) => (
                  <option key={s} value={s}>
                    /apex/{s}/
                  </option>
                ))}
                <option value="__other">outro…</option>
              </select>
              {!apexServers.includes(draft.apex as (typeof apexServers)[number]) && (
                <input
                  value={draft.apex}
                  onChange={(e) => onApex(e.target.value.toLowerCase())}
                  className="h-9 w-24 rounded-md border border-input bg-white px-2 font-mono text-[13px]"
                  aria-label="Servidor do APEX"
                />
              )}
            </label>
          )}
          <Button type="button" variant="secondary" size="sm" onClick={onFill}>
            <Wand2 /> Preencher pelo padrão
          </Button>
        </div>
      }
    >
      <div className="grid gap-4 md:grid-cols-2">
        {portalApps.map((app) => {
          const id = `u-${env}-${app.key}`
          const value = urls[app.key] ?? ''
          const fallback = defaultPortalUrl(app, draft, env)
          return (
            <Field key={app.key} label={app.name} htmlFor={id} hint={value.trim() ? undefined : `Padrão: ${fallback}`}>
              <div className="flex items-center gap-2">
                <Input
                  id={id}
                  type="url"
                  value={value}
                  onChange={(e) => onUrl(env, app.key, e.target.value)}
                  placeholder={fallback}
                  className="bg-white font-mono text-[12.5px]"
                />
                <a
                  href={value.trim() || fallback}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="grid h-10 w-10 shrink-0 place-items-center rounded-md border border-brand-mist bg-white text-brand-purple hover:border-brand-purple/40"
                  aria-label={`Abrir ${app.name}`}
                  title="Abrir em outra aba"
                >
                  <ArrowUpRight className="h-4 w-4" />
                </a>
              </div>
            </Field>
          )
        })}
      </div>
      {missing > 0 && (
        <p className="mt-4 text-[12.5px] text-brand-gray">
          {missing === 6
            ? 'Nenhum endereço informado: a página usa o padrão em todos.'
            : `${missing} ${missing === 1 ? 'endereço vazio usa' : 'endereços vazios usam'} o padrão.`}
        </p>
      )}
    </Card>
  )
}

/* ---------------- peças ---------------- */

function Card({
  title,
  lead,
  accent = 'purple',
  aside,
  children,
}: {
  title: string
  lead?: string
  accent?: 'purple' | 'amber'
  aside?: React.ReactNode
  children: React.ReactNode
}) {
  return (
    <section className="rounded-[28px] border border-brand-mist bg-white p-6 shadow-soft sm:p-8">
      <div className="flex flex-col gap-4 md:flex-row md:items-start md:justify-between">
        <div>
          <h2 className="flex items-center gap-2.5 text-[18px] font-extrabold leading-tight">
            <span className={cn('h-2.5 w-2.5 rotate-45 rounded-[1px]', accent === 'amber' ? 'bg-[#F2B84B]' : 'bg-brand-gradient')} aria-hidden />
            {title}
            {accent === 'amber' && (
              <span className="inline-flex items-center gap-1 rounded-full bg-[#F2B84B] px-2 py-0.5 text-[10px] font-extrabold uppercase tracking-[0.12em] text-brand-ink">
                <FlaskConical className="h-3 w-3" strokeWidth={2.4} /> Homologação
              </span>
            )}
          </h2>
          {lead && <p className="mt-1.5 max-w-2xl text-[13.5px] leading-relaxed text-brand-graphite">{lead}</p>}
        </div>
        {aside}
      </div>
      <div className="mt-6">{children}</div>
    </section>
  )
}

function Field({ label, htmlFor, hint, className, children }: { label: string; htmlFor?: string; hint?: string; className?: string; children: React.ReactNode }) {
  return (
    <div className={cn('min-w-0', className)}>
      <Label htmlFor={htmlFor} className="text-[12.5px] font-bold text-brand-ink">
        {label}
      </Label>
      <div className="mt-1.5">{children}</div>
      {hint && <p className="mt-1.5 truncate text-[12px] text-brand-gray">{hint}</p>}
    </div>
  )
}
