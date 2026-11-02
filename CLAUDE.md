# CLAUDE.md

Instrucciones operativas para trabajar en este repo (KDesk).

Antes de empezar, leer `docs/CODING_RULES.md`, `docs/STACK.md` y `docs/ARCHITECTURE.md`.

## Procesos de desarrollo

No matar procesos de desarrollo que ya estén corriendo (backend en el puerto 4000, Vite).
Para probar algo end-to-end, usar esos servidores; si hace falta levantar una instancia
adicional, no tocar los existentes al terminar.

Los tests del backend corren contra la base `kdesk_test` (ver README). Nunca apuntarlos
a otra base.
