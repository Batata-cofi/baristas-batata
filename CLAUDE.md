# Calibración de café — baristas de Batata Cofi

Herramienta interna para los baristas de Batata Cofi (calibración de shots, recetas del día, escala de texturas). HTML/JS en un solo `index.html`, sin build.
- Publicación: Vercel, se redeploya solo con cada push a `main`.
- Base: Supabase propio (`gpbzpflnteytslymtqan`), separado a propósito del tablero y de Batateros (cada app de Batata tiene su proyecto). Esquema en `supabase/schema.sql` y `supabase/migrations/`.
- Lo usan empleados: cambios claros, sin romper el flujo de carga en el local.

## Reglas generales
- Textos y explicaciones en español rioplatense. Lautaro prefiere lo simple y visual (colores, semáforos, frases cortas) antes que muros de texto.
- Puede haber otras sesiones de Claude trabajando en el mismo repo: `git pull` antes de empezar, cambios chicos, no pisar ni revertir trabajo ajeno.
- Nunca escribir claves privadas, tokens ni contraseñas en el código ni en el repo. Las claves "publicables"/anon de Supabase pueden ir en el front solo si la tabla está protegida con RLS.
- Antes de cambios que escriben en una base de datos o publican algo hacia afuera (mails, mensajes), confirmar con Lautaro.
- Después de publicar, verificar en la URL real que el cambio esté (no dar por hecho el deploy).
