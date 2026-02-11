-- LoveNote AI Phase 2 schema (Supabase)

-- 1) Profiles (plan + role)
create table if not exists public.profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  email text unique,
  created_at timestamptz not null default now(),
  role text not null default 'user', -- 'user' | 'owner'
  plan text not null default 'free'  -- 'free' | 'bundle' | 'pro'
);

alter table public.profiles enable row level security;

create policy "profiles_select_own"
on public.profiles for select
to authenticated
using (auth.uid() = user_id);

create policy "profiles_update_own"
on public.profiles for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- Owner can read/update anyone (role=owner)
create policy "profiles_owner_all_select"
on public.profiles for select
to authenticated
using (exists (select 1 from public.profiles p where p.user_id = auth.uid() and p.role='owner'));

create policy "profiles_owner_all_update"
on public.profiles for update
to authenticated
using (exists (select 1 from public.profiles p where p.user_id = auth.uid() and p.role='owner'))
with check (true);

-- 2) Creations (saved outputs + optional base64 image)
create table if not exists public.creations (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now(),
  feature text not null,       -- message | meme | card | photo
  title text not null default '',
  content text not null default '',
  image_data text not null default '' -- data URL (base64) for Phase 2 simplicity
);

alter table public.creations enable row level security;

create policy "creations_select_own"
on public.creations for select
to authenticated
using (auth.uid() = user_id);

create policy "creations_insert_own"
on public.creations for insert
to authenticated
with check (auth.uid() = user_id);

create policy "creations_update_own"
on public.creations for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create policy "creations_delete_own"
on public.creations for delete
to authenticated
using (auth.uid() = user_id);

-- Owner can read all creations (analytics)
create policy "creations_owner_select_all"
on public.creations for select
to authenticated
using (exists (select 1 from public.profiles p where p.user_id = auth.uid() and p.role='owner'));

-- 3) Auto-create profile on signup
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (user_id, email)
  values (new.id, new.email)
  on conflict (user_id) do nothing;
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();
