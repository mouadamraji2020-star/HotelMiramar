-- Hôtel Miramar Tanger: admin settings + visit statistics
-- HOW TO USE: Supabase dashboard > SQL Editor > New query > paste ALL of this > Run.
-- BEFORE RUNNING: change the e-mail address on the line marked  <<< CHANGE THIS >>>
-- It must be the same e-mail as the admin user you create in Authentication > Users.

create or replace function public.is_admin() returns boolean
language sql stable as $$
  select (auth.jwt() ->> 'email') = 'PUT_YOUR_ADMIN_EMAIL_HERE'   -- <<< CHANGE THIS >>>
$$;

-- 1) Settings: what is switched on or off on the website
create table if not exists public.site_settings (
  key        text primary key,
  value      jsonb not null,
  updated_at timestamptz not null default now()
);

-- 2) Statistics: anonymous events (no names, e-mails or phone numbers are ever stored)
create table if not exists public.events (
  id         bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  event      text not null check (event in ('visit','section_view','book_click','request_sent')),
  session    text check (char_length(session) <= 40),
  lang       text check (char_length(lang) <= 5),
  device     text check (char_length(device) <= 10),
  ref        text check (char_length(ref) <= 100),
  room       text check (char_length(room) <= 10),
  section    text check (char_length(section) <= 20),
  nights     int  check (nights between 0 and 365),
  guests     int  check (guests between 0 and 20)
);
create index if not exists events_created_at_idx on public.events (created_at);

alter table public.site_settings enable row level security;
alter table public.events        enable row level security;

-- Everybody can READ the settings (the website needs them); only the admin can change them.
drop policy if exists "settings read"  on public.site_settings;
drop policy if exists "settings admin" on public.site_settings;
create policy "settings read"  on public.site_settings for select to anon, authenticated using (true);
create policy "settings admin" on public.site_settings for all    to authenticated using (public.is_admin()) with check (public.is_admin());

-- Everybody can ADD an event (that is how visits are counted); only the admin can read or delete them.
drop policy if exists "events insert"       on public.events;
drop policy if exists "events admin read"   on public.events;
drop policy if exists "events admin delete" on public.events;
create policy "events insert"       on public.events for insert to anon, authenticated with check (true);
create policy "events admin read"   on public.events for select to authenticated using (public.is_admin());
create policy "events admin delete" on public.events for delete to authenticated using (public.is_admin());

grant usage on schema public to anon, authenticated;
grant select on public.site_settings to anon;
grant select, insert, update, delete on public.site_settings to authenticated;
grant insert on public.events to anon;
grant select, insert, delete on public.events to authenticated;
grant usage, select on all sequences in schema public to anon, authenticated;
