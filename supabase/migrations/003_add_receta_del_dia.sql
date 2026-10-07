-- Marca qué shot se eligió como receta del día (para el servicio). Independiente de favorito.
-- Pegar y correr en: Supabase Dashboard > SQL Editor > New query > Run.

alter table shots
  add column if not exists receta_del_dia boolean not null default false;
