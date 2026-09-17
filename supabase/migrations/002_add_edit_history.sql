-- Agrega el historial de versiones a los shots ya guardados.
-- Pegar y correr en: Supabase Dashboard > SQL Editor > New query > Run.

alter table shots
  add column if not exists edit_history jsonb not null default '[]'::jsonb;
