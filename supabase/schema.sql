-- Batata Cofi — esquema compartido para reemplazar localStorage por Supabase.
-- Pegar y correr entero en: Supabase Dashboard > SQL Editor > New query > Run.

create table if not exists cafes (
  id text primary key,
  nombre text not null,
  proceso text,
  tueste text,
  created_at timestamptz not null default now()
);

create table if not exists shots (
  id text primary key,
  barista text,
  barista_key text,
  cafe_id text references cafes(id) on delete set null,
  fecha text,
  hora text,
  sensorial jsonb,
  receta jsonb,
  decision text,
  comentario text,
  diagnostico jsonb,
  cafe jsonb,
  favorito boolean not null default false,
  clima jsonb,
  created_at timestamptz not null default now()
);

create table if not exists catas (
  key text primary key,
  cafe_id text references cafes(id) on delete set null,
  semana text,
  fecha text,
  barista text,
  acidez int,
  dulzor int,
  posgusto int,
  cuerpo int,
  textura text,
  notas text,
  created_at timestamptz not null default now()
);

-- Fila única que guarda cuál es el café activo compartido por todo el equipo.
create table if not exists app_state (
  id int primary key default 1,
  cafe_activo text references cafes(id) on delete set null,
  updated_at timestamptz not null default now(),
  constraint app_state_singleton check (id = 1)
);

-- Datos iniciales (el café que hoy viene hardcodeado en el HTML).
insert into cafes (id, nombre, proceso, tueste)
values ('c1', 'Colombia Lavado · Caturra/Castillo', 'Lavado', '30/04/2026')
on conflict (id) do nothing;

insert into app_state (id, cafe_activo)
values (1, 'c1')
on conflict (id) do nothing;

-- RLS: la app no tiene login, así que se habilita acceso completo para la
-- clave pública (anon). Cualquiera con la anon key (visible en el HTML del
-- repo público) puede leer y escribir estos datos — aceptable para una
-- herramienta interna, pero es bueno tenerlo presente.
alter table cafes enable row level security;
alter table shots enable row level security;
alter table catas enable row level security;
alter table app_state enable row level security;

drop policy if exists "anon full access" on cafes;
create policy "anon full access" on cafes for all to anon using (true) with check (true);

drop policy if exists "anon full access" on shots;
create policy "anon full access" on shots for all to anon using (true) with check (true);

drop policy if exists "anon full access" on catas;
create policy "anon full access" on catas for all to anon using (true) with check (true);

drop policy if exists "anon full access" on app_state;
create policy "anon full access" on app_state for all to anon using (true) with check (true);

-- Realtime: para que a los otros baristas les aparezcan los shots/catas
-- nuevos sin tener que recargar la página.
alter publication supabase_realtime add table cafes, shots, catas, app_state;
