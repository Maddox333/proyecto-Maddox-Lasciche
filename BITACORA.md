# Bitácora de Desarrollo — SIGAU

## Entrada #01 — 11 de Mayo 2026

**¿Qué hice?**
Creé el repositorio en GitHub con la estructura completa de carpetas y archivos
según los lineamientos del proyecto. Organicé los artefactos de diseño previos
en sus carpetas correspondientes (análisis, diseño por fases, trazabilidad).

**¿Qué problema encontré?**
El comando `code .` no funcionaba desde la terminal porque VS Code no estaba
configurado en el PATH del sistema.

**¿Cómo lo resolví?**
Instalé el comando desde VS Code con: Cmd+Shift+P → "Shell Command: Install 'code' in PATH".

**¿Usé IA?** Sí — Usé IA para guiar la creación de la estructura del repositorio
y la generación de los contenidos base. Revisé y ajusté cada archivo para que
coincidiera con mi diseño específico del sistema SIGAU.

---

## Entrada #02 — 2026-05-12

### Actividades realizadas
- Completada la carpeta `docs/analisis/` (archivos 01 al 07)
- Completada la carpeta `docs/fase1-arquitectura/` (E1 al E6)
- Completada la carpeta `docs/fase2-datos/` (E7 al E11)
- Completada la carpeta `docs/fase3-componentes/` (E12 al E14)
- Completada la carpeta `docs/fase4-interfaz/` (E15 al E17)
- Completadas todas las matrices de trazabilidad `docs/trazabilidad/` (M1 al M13)
- Realizados commits incrementales por carpeta para mantener historial limpio

### Decisiones tomadas
- Se siguió un orden secuencial de carpetas para mayor coherencia del repositorio
- Se usó IA (Claude) como apoyo para generar el contenido de cada artefacto
- Todo el contenido fue basado en el documento `Parcial 1 Ing software 2.docx` y el MER corregido `Mer.png`

### Problemas encontrados
- Ninguno en esta sesión

### Estado actual
- Documentación completa al 100%
- Repositorio listo para iniciar la Fase de implementación

### Próximos pasos
- Iniciar implementación del backend con el framework elegido
- Actualizar `DECISIONES.md` con nuevas decisiones técnicas de implementación

---

## Entrada #03 — 2026-05-12

### Actividades realizadas
- **Migración de stack:** se reemplazó el scaffold inicial de NestJS por el
  stack final **React + Node.js (Express) + Sequelize + PostgreSQL 15**.
- Se eliminó la carpeta `src/sigau-backend/` y se levantó la nueva estructura
  `src/{config,models,routes,middleware,utils,server.js}` en la raíz del repo.
- Se generaron los **18 modelos Sequelize** correspondientes a las tablas del
  E11 (ROL, USUARIOS, CARRERA, ESTUDIANTE, ADMINISTRADOR, DOCENTE, MATERIA,
  TORRE, PISO, AULA, UBICACION, HORARIO, ASIGNACION, RUTA, CONSULTA, HISTORIAL,
  NOTIFICACION, REPORTE_SOPORTE) con asociaciones (`hasMany`, `belongsTo`,
  `hasOne`) y alias para las dos FK de `RUTA` hacia `AULA` (`aula_origen`,
  `aula_destino`).
- Se reescribió `E11-script-DDL.sql` de **MySQL 8 → PostgreSQL 15** (SERIAL,
  CHECK constraints, ON DELETE CASCADE, seeds de `ROL`).
- Se implementó el **CRUD genérico** `buildCrudRouter` en `src/utils/crudFactory.js`
  y se registraron los 18 endpoints REST en `src/routes/index.js`.
- Se agregó hashing **bcryptjs** en hooks `beforeCreate`/`beforeUpdate` del
  modelo `USUARIOS` y se ocultó `contrasena` del JSON serializado.
- Se actualizaron `README.md` y `DECISIONES.md` (Decisiones #04 a #08).

### Decisiones tomadas
- **D-04:** Migrar el motor de BD de MySQL a PostgreSQL 15.
- **D-05:** Migrar el framework de NestJS a React + Node (Express) + Sequelize.
- **D-06:** El esquema se crea desde el DDL, no con `sequelize.sync()`.
- **D-07:** Hashear contraseñas con bcryptjs en hooks del modelo `USUARIOS`.
- **D-08:** Implementar el CRUD vía factory genérico en lugar de 18 controladores.

### Problemas encontrados
- El README listaba 17 entidades pero el DDL del E11 contiene **18**
  (incluye `HORARIO`, `RUTA` e `HISTORIAL` que faltaban en la matriz M8).
  Se tomó el DDL como fuente de verdad y se actualizó la lista del README.

### Estado actual
- Backend Express + Sequelize corriendo contra PostgreSQL.
- 18 endpoints CRUD activos en `/api/...`.
- Health check funcional en `GET /api/health`.

### Próximos pasos
- Inicializar el proyecto React (Vite) en `frontend/` para consumir el API.
- Implementar autenticación JWT y middleware de autorización por rol.
- Reemplazar el CRUD genérico de `RUTA` por un controlador que calcule
  `distancia_metros` y `tiempo_minutos` a partir de las coordenadas de
  `UBICACION`.
