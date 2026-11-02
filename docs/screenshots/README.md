# Screenshots to take / Capturas a tomar

Pending: take these with the demo instance running (see below) and save them in this folder with the exact
file names. Then uncomment the image links in `README.md` and `README.es.md`.

Pendiente: tomarlas con la instancia demo levantada (ver abajo) y guardarlas en esta carpeta con estos nombres.

| File | Screen | How to get there (demo data) |
|---|---|---|
| `01-login.png` | Login screen | `/login`, logged out |
| `02-board.png` | Ticket board (Tablero) | log in as `tecnico@example.com`, `/dashboard/tablero` |
| `03-ticket-detail.png` | Ticket detail with comments and history | `tecnico@example.com`, open ticket `TK-000001` (`/tickets/1`) or `TK-000005` |
| `04-new-ticket.png` | New ticket modal | any user, "+" / "Nuevo ticket" |
| `05-users-permissions.png` | User and permissions admin | `admin@example.com`, `/administrar/usuarios` |
| `06-mobile.png` | Mobile view (<= 768 px) | browser devtools, 390 px wide, e.g. ticket list as cards |

Optional extras: `07-statistics.png` (`/administrar/estadisticas`, admin), `08-backups.png` (`/administrar/backups`, admin).

## Starting the demo instance

1. `docker compose up -d` (or a local PostgreSQL, see the main README).
2. `cp backend/.env.example backend/.env`
3. `cd backend && npm install && npm run dev`
4. `cd frontend && npm install && npm run dev` and open http://localhost:5173
5. Demo accounts: `admin@example.com`, `tecnico@example.com`, `usuario@example.com`, password `Demo1234!`.

Tip: use a fresh browser profile so no saved personal data shows up, and review each image before committing
(no real names, mail addresses or notifications from other apps).
