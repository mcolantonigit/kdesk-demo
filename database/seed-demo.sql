-- =====================================================================
-- KDesk - Datos de demostración (100% ficticios)
-- Ejecutar DESPUÉS de schema.sql:   npm run seed:demo   (desde backend/)
-- Todas las cuentas usan la contraseña:  Demo1234!
--   admin@example.com     (administrador)
--   tecnico@example.com   (técnico)
--   tecnico2@example.com  (técnico)
--   usuario@example.com   (usuario común)
--   usuario2@example.com  (usuario común)
-- =====================================================================

BEGIN;

INSERT INTO sucursales (nombre) VALUES ('Sucursal Norte') ON CONFLICT (nombre) DO NOTHING;

INSERT INTO usuarios (nombre, apellido, correo, password_hash, id_rol, id_sucursal, id_sector, email_verificado, kadi_habilitada)
SELECT u.nombre, u.apellido, u.correo,
       '$2b$10$IIVqN6Hffr5KQM2r9w1xNe7U.5QuTkpzwyCgN.MPpiTupxd.IFcDO',
       (SELECT id FROM roles WHERE nombre = u.rol),
       (SELECT id FROM sucursales WHERE nombre = u.sucursal),
       (SELECT id FROM sectores WHERE nombre = u.sector),
       TRUE, FALSE
FROM (VALUES
    ('Laura',   'Gómez',     'admin@example.com',    'administrador', 'Casa Central',   'Sistemas'),
    ('Diego',   'Fernández', 'tecnico@example.com',  'tecnico',       'Casa Central',   'Sistemas'),
    ('Valeria', 'Ortiz',     'tecnico2@example.com', 'tecnico',       'Sucursal Norte', 'Sistemas'),
    ('Carla',   'Ruiz',      'usuario@example.com',  'usuario',       'Casa Central',   'Ventas'),
    ('Martín',  'Sosa',      'usuario2@example.com', 'usuario',       'Sucursal Norte', 'Administracion')
) AS u(nombre, apellido, correo, rol, sucursal, sector)
ON CONFLICT (correo) DO NOTHING;

-- Tickets de ejemplo ---------------------------------------------------
CREATE TEMP TABLE demo_tickets (
    ord int, titulo text, descripcion text, tipo text, prio_sug text, prio text,
    estado text, creador text, tecnico text, dias int, comentario_tec text, comentario_user text
) ON COMMIT DROP;

INSERT INTO demo_tickets VALUES
 (1,'Impresora de ventas no imprime','La impresora del sector Ventas muestra "fuera de línea" desde la mañana. Se probó apagar y prender.','Incidente','Alta','Alta','En proceso','usuario@example.com','tecnico@example.com',2,'Estoy revisando el spooler y el cable de red.','Sigue igual, hay una cola de documentos trabada.'),
 (2,'VPN no conecta desde casa','Al intentar conectar por VPN aparece error de autenticación. Ayer funcionaba.','Incidente','Alta','Alta','Asignado','usuario2@example.com','tecnico2@example.com',1,'Voy a verificar si venció tu certificado.',NULL),
 (3,'Acceso a carpeta compartida','Necesito permisos de escritura en la carpeta "Presupuestos" del servidor de archivos.','Solicitud de Servicio','Media','Media','Resuelto','usuario@example.com','tecnico@example.com',6,'Listo, ya tenés permisos de escritura. Probá y confirmame.','Funciona, gracias.'),
 (4,'Correo no sincroniza en celular','El correo corporativo dejó de llegar al celular desde el lunes.','Incidente','Media','Media','En espera del usuario','usuario2@example.com','tecnico2@example.com',4,'Necesito que me digas el modelo del celular y si cambiaste la contraseña recientemente.',NULL),
 (5,'PC muy lenta al iniciar','La computadora tarda más de diez minutos en iniciar y se traba al abrir Excel.','Incidente','Media','Media','En proceso','usuario@example.com','tecnico@example.com',3,'Revisé el disco: está casi lleno y con errores. Vamos a cambiarlo por un SSD.','Ok, avisame cuándo puedo dejarte la PC.'),
 (6,'Instalar Visual Studio Code','Pido instalación de Visual Studio Code para armar scripts de reportes.','Instalacion de Software','Baja','Baja','Cerrado','usuario2@example.com','tecnico2@example.com',12,'Instalado en tu equipo.','Perfecto, gracias.'),
 (7,'Alta de usuario para pasante','Ingresa un pasante el lunes al sector Compras: necesita usuario, correo y acceso al ERP.','Alta de Usuario','Media','Media','Pendiente','usuario@example.com',NULL,0,NULL,NULL),
 (8,'Olvidé mi contraseña de Windows','No puedo entrar a mi sesión de Windows después de las vacaciones.','Cambio de Contrasena','Alta','Alta','Cerrado','usuario2@example.com','tecnico@example.com',9,'Contraseña restablecida. Vas a tener que cambiarla al primer inicio.','Pude entrar, gracias.'),
 (9,'Monitor adicional para escritorio','Solicito un segundo monitor para el puesto de Administración.','Solicitud de Hardware','Baja','Baja','Pendiente','usuario2@example.com',NULL,1,NULL,NULL),
 (10,'Wifi de sala de reuniones caído','La sala de reuniones no tiene wifi desde hoy; hay una reunión con clientes mañana.','Incidente','Critica','Critica','En proceso','usuario@example.com','tecnico2@example.com',0,'El access point no responde. Voy a llevarlo a la sala para reemplazarlo.',NULL),
 (11,'Teclado con teclas trabadas','Varias teclas del teclado no responden.','Solicitud de Hardware','Baja','Baja','Cerrado','usuario@example.com','tecnico@example.com',15,'Reemplazado por uno nuevo.','Gracias.'),
 (12,'Excel se cierra solo','Al abrir un archivo grande de ventas Excel se cierra sin avisar.','Incidente','Media','Media','Asignado','usuario@example.com','tecnico@example.com',2,'Voy a reparar la instalación de Office y revisar complementos.',NULL),
 (13,'Pedido de licencia de PDF','Necesito poder editar PDFs para contratos.','Instalacion de Software','Baja','Baja','Cancelado','usuario2@example.com',NULL,8,NULL,'Cancelo, ya lo resolví con otra herramienta.'),
 (14,'Pantalla azul al conectar USB','La PC muestra pantalla azul cada vez que conecto el pendrive.','Incidente','Alta','Alta','Resuelto','usuario2@example.com','tecnico2@example.com',5,'Era un driver de USB desactualizado, ya está actualizado.','Ya no pasa más.'),
 (15,'Alta de casilla compartida','Pedimos una casilla compartida "ventas" para el equipo comercial.','Solicitud de Servicio','Media','Media','Cerrado','usuario@example.com','tecnico@example.com',20,'Casilla creada y miembros agregados.','Recibido.'),
 (16,'Scanner no envía a carpeta','El scanner multifunción ya no deja los escaneos en la carpeta de red.','Incidente','Media','Media','En proceso','usuario@example.com','tecnico2@example.com',3,'La contraseña de la cuenta de escaneo había vencido, la estoy actualizando.',NULL),
 (17,'Reunión virtual sin audio','En las videollamadas los demás no me escuchan.','Incidente','Media','Media','Resuelto','usuario2@example.com','tecnico@example.com',7,'El micrófono estaba deshabilitado en la configuración de privacidad.','Listo, ahora se escucha.'),
 (18,'Cambio de contraseña del ERP','Debo cambiar la contraseña del ERP por política de seguridad.','Cambio de Contrasena','Baja','Baja','Cerrado','usuario@example.com','tecnico2@example.com',11,'Cambio realizado.','Gracias.'),
 (19,'Notebook nueva para visitas','Pido una notebook para uso de visitas en la sala de reuniones.','Solicitud de Hardware','Baja','Baja','Pendiente','usuario@example.com',NULL,2,NULL,NULL),
 (20,'Antivirus bloquea sistema interno','El antivirus bloquea el acceso al sistema de gestión interno.','Incidente','Alta','Alta','Asignado','usuario2@example.com','tecnico@example.com',1,'Voy a agregar una excepción para la aplicación.',NULL),
 (21,'Instalar Adobe Reader','Necesito Adobe Reader en la PC nueva.','Instalacion de Software','Baja','Baja','Cerrado','usuario2@example.com','tecnico2@example.com',14,'Instalado.','OK.'),
 (22,'Disco de red sin espacio','El disco compartido de Ventas está casi lleno y no deja guardar archivos.','Incidente','Alta','Alta','En proceso','usuario@example.com','tecnico@example.com',2,'Estoy liberando archivos viejos y evaluando ampliar el espacio.','Mientras tanto no podemos guardar los reportes mensuales.'),
 (23,'Mouse inalámbrico sin respuesta','El mouse dejó de funcionar, ya cambié las pilas.','Solicitud de Hardware','Baja','Baja','Cerrado','usuario@example.com','tecnico2@example.com',13,'Receptor reemplazado.','Gracias.'),
 (24,'Pedido de acceso a Teams','Necesito ser agregado al canal de Compras en Teams.','Solicitud de Servicio','Baja','Baja','Resuelto','usuario2@example.com','tecnico@example.com',4,'Agregado al canal.','Ya lo veo.'),
 (25,'Phishing recibido por correo','Recibí un correo sospechoso pidiendo mis credenciales. No hice clic.','Otro','Alta','Alta','Cerrado','usuario@example.com','tecnico2@example.com',10,'Bloqueamos el remitente y avisamos al resto. Buena decisión no abrirlo.','Gracias por el aviso.'),
 (26,'Teléfono IP sin tono','El teléfono IP del escritorio no tiene tono de línea.','Incidente','Media','Media','En espera del usuario','usuario2@example.com','tecnico@example.com',5,'¿Podés confirmarme el número de interno que tenés asignado?',NULL),
 (27,'Backup de mi PC antes de cambio','Voy a cambiar de equipo y quiero resguardar mis documentos.','Solicitud de Servicio','Media','Media','Asignado','usuario@example.com','tecnico2@example.com',1,'Coordinemos un horario para copiar tus archivos.',NULL),
 (28,'Duda sobre firma del correo','¿Cómo configuro la firma institucional en Outlook?','Otro','Baja','Baja','Cerrado','usuario2@example.com','tecnico@example.com',16,'Te pasé el paso a paso por correo.','Perfecto.'),
 (29,'Proyector de sala no enciende','El proyector de la sala de capacitación no prende.','Incidente','Media','Media','Pendiente','usuario@example.com',NULL,0,NULL,NULL),
 (30,'Instalar impresora en notebook','Necesito agregar la impresora de planta baja a mi notebook.','Instalacion de Software','Baja','Baja','Cerrado','usuario2@example.com','tecnico@example.com',18,'Impresora agregada y probada.','Anda perfecto.');

DO $$
DECLARE
    d record;
    v_ticket int; v_id_creador int; v_id_tec int; v_ts timestamp;
    v_suc int; v_sec int; v_nombre_sec text; v_nombre_user text;
BEGIN
    FOR d IN SELECT * FROM demo_tickets ORDER BY ord LOOP
        SELECT id, id_sucursal, id_sector, nombre || ' ' || apellido
          INTO v_id_creador, v_suc, v_sec, v_nombre_user
          FROM usuarios WHERE correo = d.creador;
        SELECT nombre INTO v_nombre_sec FROM sectores WHERE id = v_sec;
        v_id_tec := (SELECT id FROM usuarios WHERE correo = d.tecnico);
        v_ts := NOW() - make_interval(days => d.dias) - interval '6 hours';

        INSERT INTO tickets (titulo, descripcion, nombre_descriptivo, id_tipo, id_prioridad_sugerida, id_prioridad,
                             id_estado, id_usuario_creador, id_tecnico_responsable, id_sucursal, id_sector,
                             fecha_creacion, fecha_actualizacion)
        VALUES (d.titulo, d.descripcion, v_nombre_sec || ' - ' || v_nombre_user || ' - ' || d.titulo,
                (SELECT id FROM tipos_ticket WHERE nombre = d.tipo),
                (SELECT id FROM prioridades WHERE nombre = d.prio_sug),
                CASE WHEN v_id_tec IS NULL THEN NULL ELSE (SELECT id FROM prioridades WHERE nombre = d.prio) END,
                (SELECT id FROM estados WHERE nombre = d.estado),
                v_id_creador, v_id_tec, v_suc, v_sec, v_ts, v_ts)
        RETURNING id INTO v_ticket;

        INSERT INTO historial_ticket (id_ticket, id_usuario, evento, detalle, fecha)
        VALUES (v_ticket, v_id_creador, 'CREACION', 'Ticket creado', v_ts);

        IF v_id_tec IS NOT NULL THEN
            INSERT INTO historial_ticket (id_ticket, id_usuario, evento, detalle, fecha)
            VALUES (v_ticket, v_id_tec, 'CAMBIO_RESPONSABLE',
                    'Responsable asignado: ' || (SELECT nombre || ' ' || apellido FROM usuarios WHERE id = v_id_tec),
                    v_ts + interval '30 minutes');
        END IF;
        IF d.estado NOT IN ('Pendiente', 'Asignado', 'Cancelado') THEN
            INSERT INTO historial_ticket (id_ticket, id_usuario, evento, detalle, fecha)
            VALUES (v_ticket, v_id_tec, 'CAMBIO_ESTADO', 'Estado -> En proceso', v_ts + interval '1 hour');
        END IF;
        IF d.comentario_tec IS NOT NULL THEN
            INSERT INTO comentarios (id_ticket, id_autor, contenido, fecha_creacion)
            VALUES (v_ticket, v_id_tec, d.comentario_tec, v_ts + interval '2 hours');
            INSERT INTO historial_ticket (id_ticket, id_usuario, evento, detalle, fecha)
            VALUES (v_ticket, v_id_tec, 'COMENTARIO', 'Comentario agregado', v_ts + interval '2 hours');
        END IF;
        IF d.comentario_user IS NOT NULL THEN
            INSERT INTO comentarios (id_ticket, id_autor, contenido, fecha_creacion)
            VALUES (v_ticket, v_id_creador, d.comentario_user, v_ts + interval '3 hours');
            INSERT INTO historial_ticket (id_ticket, id_usuario, evento, detalle, fecha)
            VALUES (v_ticket, v_id_creador, 'COMENTARIO', 'Comentario agregado', v_ts + interval '3 hours');
        END IF;
        IF d.estado IN ('Resuelto', 'Cerrado') THEN
            INSERT INTO historial_ticket (id_ticket, id_usuario, evento, detalle, fecha)
            VALUES (v_ticket, v_id_tec, 'CAMBIO_ESTADO', 'Estado -> ' || d.estado, v_ts + interval '4 hours');
        END IF;
        IF d.estado = 'Cerrado' THEN
            UPDATE tickets SET fecha_cierre = v_ts + interval '5 hours' WHERE id = v_ticket;
            INSERT INTO historial_ticket (id_ticket, id_usuario, evento, detalle, fecha)
            VALUES (v_ticket, v_id_tec, 'CIERRE', 'Ticket cerrado', v_ts + interval '5 hours');
        END IF;
        IF d.estado = 'Cancelado' THEN
            INSERT INTO historial_ticket (id_ticket, id_usuario, evento, detalle, fecha)
            VALUES (v_ticket, v_id_creador, 'CAMBIO_ESTADO', 'Estado -> Cancelado', v_ts + interval '1 hour');
        END IF;

        -- Tareas técnicas en los tickets en curso
        IF d.estado = 'En proceso' THEN
            INSERT INTO tareas_tecnicas (id_ticket, descripcion, completada, fecha_completada)
            VALUES (v_ticket, 'Diagnóstico inicial', TRUE, v_ts + interval '90 minutes'),
                   (v_ticket, 'Aplicar solución y probar', FALSE, NULL);
        END IF;
    END LOOP;
END $$;

INSERT INTO auditoria (id_usuario, accion, detalle)
SELECT id, 'REGISTRO', 'Alta de usuario de demostración (' || correo || ')'
FROM usuarios WHERE correo LIKE '%@example.com';

COMMIT;
