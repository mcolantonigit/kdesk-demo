# ROADMAP.md

# KDesk

Resumen de alcance por área. Este es el roadmap público de la versión de demostración: describe qué
está implementado y qué queda como ideas, sin detalles de ningún despliegue en particular.

## Implementado

- **Catálogos base**: roles, estados, prioridades, tipos de ticket, sucursales y sectores.
- **Autenticación**: registro con activación por correo, login con usuario y contraseña, recuperación de
  contraseña, y login opcional con Microsoft 365 (Entra ID) configurable por variables de entorno.
- **Perfil de usuario**: edición de datos propios y cambio de contraseña.
- **Tickets**: alta, edición, cambio de estado y prioridad, asignación, cierre, cancelación.
- **Comentarios, tareas técnicas (checklist) e historial de cambios** por ticket.
- **Paneles** por rol (usuario, técnico, administrador), lista y tablero de tickets, versión móvil.
- **Adjuntos** en tickets y comentarios.
- **Administración**: usuarios y permisos, catálogos, parámetros del sistema, auditoría con retención
  configurable.
- **Estadísticas** de tickets.
- **Backups** de la base desde la propia aplicación (manuales y programados).
- **Notificaciones y alertas** dentro de la aplicación (popups, sonido y lectura por voz del navegador).
- **Apariencia** personalizable (tema, preferencias por usuario).
- **Kadi** (asistente de IA que arma el ticket en una charla): incluida pero apagada por defecto.
- **Tests** automáticos de backend (contra una base de pruebas) y de frontend.

## Ideas a futuro (sin empezar)

- Integraciones con correo electrónico y WhatsApp (previstas en PROJECT.md, sin implementar).
- Integraciones con IA más allá de Kadi (previstas en PROJECT.md).
- Motor de IA intercambiable para Kadi: hoy usa Claude Code local (ver `backend/utils/claudeLocal.util.js`); se puede reemplazar por una API propia.
