// Crea la base indicada en DB_NAME (por defecto "kdesk") y le carga database/schema.sql.
// Si la base ya existe y tiene tablas, no la toca (usar --reset para recrearla desde cero).
//
//   npm run db:setup
//   npm run db:setup -- --reset
import dotenv from 'dotenv';
import fs from 'fs';
import path from 'path';
import pg from 'pg';
import { fileURLToPath } from 'url';

dotenv.config({ quiet: true });

const reset = process.argv.includes('--reset');
const nombre = process.env.DB_NAME;
if (!/^[a-zA-Z0-9_]+$/.test(nombre ?? '')) {
  console.error('DB_NAME inválido o vacío (revisá backend/.env)');
  process.exit(1);
}

const schema = fs.readFileSync(
  path.join(path.dirname(fileURLToPath(import.meta.url)), '../../database/schema.sql'),
  'utf8'
);

function cliente(database) {
  return new pg.Client({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
  });
}

const admin = cliente('postgres');
await admin.connect();
const existe = (await admin.query('SELECT 1 FROM pg_database WHERE datname = $1', [nombre])).rowCount > 0;
if (existe && reset) {
  await admin.query(`DROP DATABASE ${nombre} WITH (FORCE)`);
}
if (!existe || reset) {
  await admin.query(`CREATE DATABASE ${nombre}`);
}
await admin.end();

const db = cliente(nombre);
await db.connect();
const tablas = (await db.query("SELECT 1 FROM information_schema.tables WHERE table_name = 'usuarios'")).rowCount;
if (tablas > 0) {
  console.log(`La base '${nombre}' ya tiene el esquema cargado: no se hace nada (usá --reset para recrearla).`);
} else {
  await db.query(schema);
  console.log(`Base '${nombre}' creada con el esquema en ${process.env.DB_HOST}:${process.env.DB_PORT}.`);
}
await db.end();
