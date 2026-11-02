// Nombre de la organización que usa esta instalación, para los mensajes de
// login ("Solo se puede entrar con una cuenta de ..."). Se define con ORG_NAME.
export function nombreOrganizacion() {
  return (process.env.ORG_NAME || 'la organización').trim();
}
