// Carga los datos de demostración (database/seed-demo.sql) en la base de DB_NAME.
// Es idempotente solo para los usuarios: si ya hay tickets, no vuelve a cargarlos.
//
//   npm run seed:demo
import dotenv from 'dotenv';
import fs from 'fs';
import path from 'path';
import pg from 'pg';
import { fileURLToPath } from 'url';

dotenv.config({ quiet: true });

const sql = fs.readFileSync(
  path.join(path.dirname(fileURLToPath(import.meta.url)), '../../database/seed-demo.sql'),
  'utf8'
);

const db = new pg.Client({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

try {
  await db.connect();
  const { rows } = await db.query('SELECT count(*)::int AS n FROM tickets');
  if (rows[0].n > 0) {
    console.log(`La base '${process.env.DB_NAME}' ya tiene ${rows[0].n} tickets: no se carga nada.`);
  } else {
    await db.query(sql);
    console.log("Datos de demostración cargados. Usuarios: admin@example.com, tecnico@example.com, usuario@example.com (contraseña: Demo1234!)");
  }
} catch (e) {
  console.error(`Error: ${e.message}`);
  process.exitCode = 1;
} finally {
  await db.end();
}
