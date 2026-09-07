-- Cadastro dos portais dos clientes (página /portais/<cliente>) e quem pode editá-lo (/admin/portais).
--
-- portal_clients : um cliente por linha; o slug é a chave (o trecho da URL). As URLs de cada portal ficam
--                  em urls_prod e urls_dev (JSON por aplicativo: colaborador, gestor, operador, candidato,
--                  natdocs, chamado). Um aplicativo sem URL usa o padrão do APEX no site.
-- portal_admins  : e-mails autorizados a alterar o cadastro. Só esses e-mails conseguem criar usuário.
-- portal-logos   : balde público com os logotipos.

create extension if not exists pgcrypto;

create table if not exists public.portal_clients (
  slug        text primary key check (slug ~ '^[a-z0-9][a-z0-9-]{0,39}$'),
  name        text not null check (length(trim(name)) between 1 and 80),
  code        text not null check (code ~ '^[A-Z0-9_]{1,40}$'),
  apex        text not null default 'rh' check (apex ~ '^[a-z0-9_-]{1,30}$'),
  logo_url    text,
  urls_prod   jsonb not null default '{}'::jsonb,
  urls_dev    jsonb not null default '{}'::jsonb,
  active      boolean not null default true,
  sort        integer not null default 0,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

create table if not exists public.portal_admins (
  email       text primary key check (email = lower(email)),
  created_at  timestamptz not null default now()
);

-- Quem está logado é administrador?
create or replace function public.is_portal_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.portal_admins a
    where a.email = lower(coalesce(auth.jwt() ->> 'email', ''))
  );
$$;

revoke all on function public.is_portal_admin() from public;
grant execute on function public.is_portal_admin() to anon, authenticated;

-- updated_at automático
create or replace function public.portal_clients_touch()
returns trigger
language plpgsql
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists portal_clients_touch on public.portal_clients;
create trigger portal_clients_touch
  before update on public.portal_clients
  for each row execute function public.portal_clients_touch();

-- Só e-mails da lista de administradores conseguem criar usuário (a página de administração é a única
-- que usa a autenticação deste projeto).
create or replace function public.portal_admins_only()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if not exists (select 1 from public.portal_admins a where a.email = lower(coalesce(new.email, ''))) then
    raise exception 'Cadastro restrito aos administradores.' using errcode = 'P0001';
  end if;
  return new;
end;
$$;

drop trigger if exists portal_admins_only on auth.users;
create trigger portal_admins_only
  before insert on auth.users
  for each row execute function public.portal_admins_only();

-- Segurança por linha
alter table public.portal_clients enable row level security;
alter table public.portal_admins enable row level security;

drop policy if exists "portal_clients: leitura pública" on public.portal_clients;
create policy "portal_clients: leitura pública"
  on public.portal_clients for select
  using (true);

drop policy if exists "portal_clients: administradores escrevem" on public.portal_clients;
create policy "portal_clients: administradores escrevem"
  on public.portal_clients for all
  to authenticated
  using (public.is_portal_admin())
  with check (public.is_portal_admin());

drop policy if exists "portal_admins: cada um vê o próprio e-mail" on public.portal_admins;
create policy "portal_admins: cada um vê o próprio e-mail"
  on public.portal_admins for select
  to authenticated
  using (email = lower(coalesce(auth.jwt() ->> 'email', '')));

-- Logotipos: balde público para leitura; só administradores gravam.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('portal-logos', 'portal-logos', true, 2097152, array['image/svg+xml', 'image/png', 'image/webp', 'image/jpeg'])
on conflict (id) do update set public = excluded.public, file_size_limit = excluded.file_size_limit, allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "portal-logos: leitura pública" on storage.objects;
create policy "portal-logos: leitura pública"
  on storage.objects for select
  using (bucket_id = 'portal-logos');

drop policy if exists "portal-logos: administradores enviam" on storage.objects;
create policy "portal-logos: administradores enviam"
  on storage.objects for insert
  to authenticated
  with check (bucket_id = 'portal-logos' and public.is_portal_admin());

drop policy if exists "portal-logos: administradores atualizam" on storage.objects;
create policy "portal-logos: administradores atualizam"
  on storage.objects for update
  to authenticated
  using (bucket_id = 'portal-logos' and public.is_portal_admin())
  with check (bucket_id = 'portal-logos' and public.is_portal_admin());

drop policy if exists "portal-logos: administradores apagam" on storage.objects;
create policy "portal-logos: administradores apagam"
  on storage.objects for delete
  to authenticated
  using (bucket_id = 'portal-logos' and public.is_portal_admin());

-- Os clientes de hoje, com os endereços atuais dos portais.
insert into public.portal_clients (slug, name, code, apex, urls_prod, urls_dev, sort) values
  ('natcorp',   'Natcorp',   'NATCORP',   'rh',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/rh/f?p=PC_NATCORP","gestor":"https://www.natcorpbr.com.br/apex/rh/f?p=PG_NATCORP","operador":"https://www.natcorpbr.com.br/apex/rh/f?p=PO_NATCORP","candidato":"https://www.natcorpbr.com.br/apex/rh/f?p=CV_NATCORP","natdocs":"https://www.natcorpbr.com.br/apex/rh/f?p=NATDOCS_NATCORP","chamado":"https://www.natcorpbr.com.br/apex/rh/f?p=CHAMADO_NATCORP"}',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/dev/f?p=PC_NATCORP","gestor":"https://www.natcorpbr.com.br/apex/dev/f?p=PG_NATCORP","operador":"https://www.natcorpbr.com.br/apex/dev/f?p=PO_NATCORP","candidato":"https://www.natcorpbr.com.br/apex/dev/f?p=CV_NATCORP","natdocs":"https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_NATCORP","chamado":"https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_NATCORP"}', 1),
  ('incor',     'Incor',     'INCOR',     'rh',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/rh/f?p=PC_INCOR","gestor":"https://www.natcorpbr.com.br/apex/rh/f?p=PG_INCOR","operador":"https://www.natcorpbr.com.br/apex/rh/f?p=PO_INCOR","candidato":"https://www.natcorpbr.com.br/apex/rh/f?p=CV_INCOR","natdocs":"https://www.natcorpbr.com.br/apex/rh/f?p=NATDOCS_INCOR","chamado":"https://www.natcorpbr.com.br/apex/rh/f?p=CHAMADO_INCOR"}',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/dev/f?p=PC_INCOR","gestor":"https://www.natcorpbr.com.br/apex/dev/f?p=PG_INCOR","operador":"https://www.natcorpbr.com.br/apex/dev/f?p=PO_INCOR","candidato":"https://www.natcorpbr.com.br/apex/dev/f?p=CV_INCOR","natdocs":"https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_INCOR","chamado":"https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_INCOR"}', 2),
  ('redeflex',  'Redeflex',  'REDEFLEX',  'rh',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/rh/f?p=PC_REDEFLEX","gestor":"https://www.natcorpbr.com.br/apex/rh/f?p=PG_REDEFLEX","operador":"https://www.natcorpbr.com.br/apex/rh/f?p=PO_REDEFLEX","candidato":"https://www.natcorpbr.com.br/apex/rh/f?p=CV_REDEFLEX","natdocs":"https://www.natcorpbr.com.br/apex/rh/f?p=NATDOCS_REDEFLEX","chamado":"https://www.natcorpbr.com.br/apex/rh/f?p=CHAMADO_REDEFLEX"}',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/dev/f?p=PC_REDEFLEX","gestor":"https://www.natcorpbr.com.br/apex/dev/f?p=PG_REDEFLEX","operador":"https://www.natcorpbr.com.br/apex/dev/f?p=PO_REDEFLEX","candidato":"https://www.natcorpbr.com.br/apex/dev/f?p=CV_REDEFLEX","natdocs":"https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_REDEFLEX","chamado":"https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_REDEFLEX"}', 3),
  ('leadec',    'Leadec',    'LEADEC',    'natrh',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/natrh/f?p=PC_LEADEC","gestor":"https://www.natcorpbr.com.br/apex/natrh/f?p=PG_LEADEC","operador":"https://www.natcorpbr.com.br/apex/natrh/f?p=PO_LEADEC","candidato":"https://www.natcorpbr.com.br/apex/natrh/f?p=CV_LEADEC","natdocs":"https://www.natcorpbr.com.br/apex/natrh/f?p=NATDOCS_LEADEC","chamado":"https://www.natcorpbr.com.br/apex/natrh/f?p=CHAMADO_LEADEC"}',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/dev/f?p=PC_LEADEC","gestor":"https://www.natcorpbr.com.br/apex/dev/f?p=PG_LEADEC","operador":"https://www.natcorpbr.com.br/apex/dev/f?p=PO_LEADEC","candidato":"https://www.natcorpbr.com.br/apex/dev/f?p=CV_LEADEC","natdocs":"https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_LEADEC","chamado":"https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_LEADEC"}', 4),
  ('saude',     'Saúde',     'SAUDE',     'hc',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/hc/f?p=PC_SAUDE","gestor":"https://www.natcorpbr.com.br/apex/hc/f?p=PG_SAUDE","operador":"https://www.natcorpbr.com.br/apex/hc/f?p=PO_SAUDE","candidato":"https://www.natcorpbr.com.br/apex/hc/f?p=CV_SAUDE","natdocs":"https://www.natcorpbr.com.br/apex/hc/f?p=NATDOCS_SAUDE","chamado":"https://www.natcorpbr.com.br/apex/hc/f?p=CHAMADO_SAUDE"}',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/dev/f?p=PC_SAUDE","gestor":"https://www.natcorpbr.com.br/apex/dev/f?p=PG_SAUDE","operador":"https://www.natcorpbr.com.br/apex/dev/f?p=PO_SAUDE","candidato":"https://www.natcorpbr.com.br/apex/dev/f?p=CV_SAUDE","natdocs":"https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_SAUDE","chamado":"https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_SAUDE"}', 5),
  ('stefanini', 'Stefanini', 'STEFANINI', 'hcm',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/hcm/f?p=PC_STEFANINI","gestor":"https://www.natcorpbr.com.br/apex/hcm/f?p=PG_STEFANINI","operador":"https://www.natcorpbr.com.br/apex/hcm/f?p=PO_STEFANINI","candidato":"https://www.natcorpbr.com.br/apex/hcm/f?p=CV_STEFANINI","natdocs":"https://www.natcorpbr.com.br/apex/hcm/f?p=NATDOCS_STEFANINI","chamado":"https://www.natcorpbr.com.br/apex/hcm/f?p=CHAMADO_STEFANINI"}',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/dev/f?p=PC_STEFANINI","gestor":"https://www.natcorpbr.com.br/apex/dev/f?p=PG_STEFANINI","operador":"https://www.natcorpbr.com.br/apex/dev/f?p=PO_STEFANINI","candidato":"https://www.natcorpbr.com.br/apex/dev/f?p=CV_STEFANINI","natdocs":"https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_STEFANINI","chamado":"https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_STEFANINI"}', 6),
  ('realfood',  'RealFood',  'REALFOOD',  'cloud',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/cloud/f?p=PC_REALFOOD","gestor":"https://www.natcorpbr.com.br/apex/cloud/f?p=PG_REALFOOD","operador":"https://www.natcorpbr.com.br/apex/cloud/f?p=PO_REALFOOD","candidato":"https://www.natcorpbr.com.br/apex/cloud/f?p=CV_REALFOOD","natdocs":"https://www.natcorpbr.com.br/apex/cloud/f?p=NATDOCS_REALFOOD","chamado":"https://www.natcorpbr.com.br/apex/cloud/f?p=CHAMADO_REALFOOD"}',
    '{"colaborador":"https://www.natcorpbr.com.br/apex/dev/f?p=PC_REALFOOD","gestor":"https://www.natcorpbr.com.br/apex/dev/f?p=PG_REALFOOD","operador":"https://www.natcorpbr.com.br/apex/dev/f?p=PO_REALFOOD","candidato":"https://www.natcorpbr.com.br/apex/dev/f?p=CV_REALFOOD","natdocs":"https://www.natcorpbr.com.br/apex/dev/f?p=NATDOCS_REALFOOD","chamado":"https://www.natcorpbr.com.br/apex/dev/f?p=CHAMADO_REALFOOD"}', 7)
on conflict (slug) do nothing;

-- O administrador (troque ou acrescente e-mails aqui ou direto na tabela).
insert into public.portal_admins (email) values ('ai@natcorp.com.br')
on conflict (email) do nothing;
