# Decisiones Técnicas — SIGAU

Bitácora de decisiones de arquitectura e implementación tomadas durante la
programación con framework. Cada entrada deja registrado el contexto,
la decisión y la consecuencia.

---

## Decisión #01
**¿Qué decidí?**
~~Usar Django (Python) como framework de desarrollo backend.~~ *(Decisión revertida — ver Decisión #03)*

**¿Por qué?**
Django ofrecía un ORM que mapeaba directamente las entidades del modelo relacional,
un sistema de autenticación integrado compatible con los roles definidos en el MER
(Estudiante, Administrador), y una arquitectura MTV que se alineaba con los componentes
definidos en el E5.

**¿Qué artefacto de diseño respalda esta decisión?**
E5 — Diagrama de Componentes UML / E6 — Diagrama de Despliegue UML / E9 — Modelo Relacional

---

## Decisión #02
**¿Qué decidí?**
~~Usar MySQL 8.0 como motor de base de datos en lugar de PostgreSQL.~~ *(Decisión revertida — ver Decisión #04)*

**¿Por qué?**
MySQL era ampliamente usado en entornos académicos, tenía buena integración con
el entorno de desarrollo inicial del equipo, y el motor InnoDB garantizaba
integridad referencial y transacciones ACID.

**¿Qué artefacto de diseño respalda esta decisión?**
E11 — Script DDL / E9 — Modelo Relacional / E10 — Normalización 3FN

---

## Decisión #03
**¿Qué decidí?**
~~Migrar el framework backend de Django (Python) a NestJS (Node.js + TypeScript).~~ *(Decisión revertida — ver Decisión #05)*

**¿Por qué?**
El criterio académico indicó que Django facilitaba demasiado el desarrollo,
por lo que se optó por NestJS como framework que exige mayor comprensión
de la arquitectura. NestJS ofrecía una estructura modular explícita, uso de
decoradores TypeScript, integración con TypeORM para el modelo relacional,
y autenticación JWT manual, lo que representaba un mayor reto técnico.

**¿Qué artefacto de diseño respalda esta decisión?**
E5 — Diagrama de Componentes UML / E6 — Diagrama de Despliegue UML / E9 — Modelo Relacional

---

## Decisión #04 · Migrar el motor de base de datos de MySQL a PostgreSQL 15

**Fecha:** 2026-05-12
**Estado:** Aceptada

**Contexto.** El stack final del proyecto declara PostgreSQL 15 como base de datos.
PostgreSQL ofrece soporte nativo de `CHECK` constraints multi-valor (sin necesidad
de `ENUM` propietarios), tipos `TIMESTAMP` con manejo consistente de zona horaria,
y secuencias `SERIAL`/`IDENTITY` independientes del dialecto. Además, Sequelize
expone PostgreSQL como un dialecto de primera clase con menos discrepancias en
los tipos `DECIMAL` y `BOOLEAN` frente a MySQL.

**Decisión.** Reescribir `E11-script-DDL.sql` para PostgreSQL: `AUTO_INCREMENT` → `SERIAL`,
`ENUM(...)` inline → `VARCHAR(n) CHECK (... IN (...))`, eliminación de
`ENGINE=InnoDB`, eliminación de `SET FOREIGN_KEY_CHECKS` (reemplazado por `CASCADE`
en los `DROP TABLE`). Se agregaron `ON DELETE CASCADE` en las FKs de las relaciones
fuertes (Estudiante→Usuario, Piso→Torre, Aula→Piso, Ubicación→Aula, Historial→Consulta)
y un `CHECK (id_aula_origen <> id_aula_destino)` en `RUTA`.

**¿Qué artefacto de diseño respalda esta decisión?**
E11 — Script DDL / E10 — Normalización 3FN / E9 — Modelo Relacional

**Consecuencias.**
- ✅ Una sola fuente de verdad del esquema: el archivo `.sql` versionado en `docs/`.
- ✅ Las restricciones `CHECK` se preservan declarativamente en lugar de delegarse
  al ORM o a triggers.
- ✅ `SERIAL` permite que Sequelize y el DDL coincidan sin configuración adicional.
- ⚠️ Cualquier instalación previa contra MySQL debe migrarse manualmente
  (export + transformación + import).

---

## Decisión #05 · Migrar el framework de NestJS a React + Node.js (Express) + Sequelize

**Fecha:** 2026-05-12
**Estado:** Aceptada

**Contexto.** El módulo entrega valor principalmente desde la interfaz: el
estudiante consulta su horario, localiza aulas en un mapa interactivo y calcula
rutas. Los wireframes del E16 y el prototipo del E17 definen una SPA con
componentes reactivos (mapa, panel de horario, modal de ruta). NestJS resolvía
únicamente el backend y obligaba a un proyecto separado para el frontend.
Adicionalmente, mantener TypeORM con decoradores duplicaba la fuente de verdad
del esquema (modelo TS + DDL .sql).

**Decisión.** Adoptar el stack **React + Node.js 18 + Express 4 + Sequelize 6 +
PostgreSQL 15**:

- **React** (Vite) cubre las pantallas SCR-01 a SCR-XX del E16/E17.
- **Express 4** expone un API REST mínimo (`src/server.js`).
- **Sequelize 6** mapea las 18 entidades del E9 contra PostgreSQL con
  `freezeTableName: true` y sin `sync()` (ver Decisión #06).
- **bcryptjs** se aplica en hooks `beforeCreate`/`beforeUpdate` del modelo
  `USUARIOS` para cumplir el RNF de no almacenar contraseñas en texto plano.

Se descartó Prisma (curva de aprendizaje y migraciones autogeneradas que no
respetaban los alias de FK del MER) y TypeORM (duplicación entre decoradores
y DDL).

**¿Qué artefacto de diseño respalda esta decisión?**
E5 — Diagrama de Componentes UML / E6 — Diagrama de Despliegue UML /
E15 — Mapa de Navegación / E16 — Wireframes / E17 — Prototipo

**Consecuencias.**
- ✅ Frontend y backend comparten lenguaje (JavaScript), reduciendo el costo
  de contexto entre capas.
- ✅ Sequelize permite declarar asociaciones con alias (`as: 'aula_origen'`,
  `as: 'aula_destino'`) que reflejan las dos FKs de `RUTA` hacia `AULA`.
- ⚠️ Sequelize no genera migraciones automáticas: el esquema sigue creándose
  con `E11-script-DDL.sql` y los modelos se mapean a tablas existentes.

---

## Decisión #06 · El esquema lo crea el DDL, no `sequelize.sync()`

**Fecha:** 2026-05-12
**Estado:** Aceptada

**Contexto.** Sequelize permite generar las tablas automáticamente con `sync()`.
Sin embargo el proyecto ya cuenta con un DDL formal
(`docs/diseño/fase2-datos/E11-script-DDL.sql`) que incluye `CHECK` constraints,
índices de optimización, seeds de la tabla `ROL` y comentarios sobre
normalización 3FN que `sync()` no reproduce.

**Decisión.** El esquema se crea **siempre** ejecutando el DDL
(`npm run db:migrate`). Los modelos Sequelize **no** llaman `sync()` en ningún
arranque. Si un modelo difiere del DDL, se considera bug del modelo, no del DDL.

**¿Qué artefacto de diseño respalda esta decisión?**
E11 — Script DDL / E9 — Modelo Relacional / E10 — Normalización 3FN

**Consecuencias.**
- ✅ Una sola fuente de verdad del esquema: el archivo `.sql` versionado en `docs/`.
- ✅ Las restricciones avanzadas (CHECKs de `estado`, UNIQUE compuesto de
  `ASIGNACION`, índices) se preservan.
- ⚠️ Cualquier cambio de esquema obliga a tocar **dos** archivos: el DDL y el
  modelo Sequelize. Se acepta el costo a cambio de no perder integridad
  declarativa.

---

## Decisión #07 · Hash de contraseñas con bcrypt en hooks del modelo USUARIOS

**Fecha:** 2026-05-12
**Estado:** Aceptada

**Contexto.** El RNF de seguridad exige que las contraseñas nunca se almacenen
en texto plano. Los hooks de Sequelize permiten interceptar
`beforeCreate`/`beforeUpdate` y aplicar la transformación en un único lugar.

**Decisión.** Se usa **bcryptjs** con factor de costo configurable por
`BCRYPT_SALT_ROUNDS` (default 12). El hash se aplica únicamente cuando el campo
`contrasena` cambió (`user.changed('contrasena')`), evitando re-hashes en
updates parciales. Adicionalmente, el método `toJSON()` del modelo elimina
`contrasena` de cualquier respuesta serializada.

**¿Qué artefacto de diseño respalda esta decisión?**
E5 — Diagrama de Componentes UML / E9 — Modelo Relacional

**Consecuencias.**
- ✅ Imposible crear o actualizar un usuario sin que la contraseña se hashee.
- ✅ Las respuestas HTTP nunca devuelven el hash al cliente.
- ⚠️ Para verificar contraseña hay que llamar `usuario.verificarContrasena(plain)`
  — no comparar campos directamente.

---

## Decisión #08 · CRUD genérico vía factory en lugar de un controlador por entidad

**Fecha:** 2026-05-12
**Estado:** Aceptada

**Contexto.** Las 18 entidades del esquema requieren las mismas 5 operaciones
REST (list, get, create, update, delete). Crear 18 controladores casi idénticos
genera ~900 líneas redundantes y dificulta cambios transversales (paginación,
validación, logging).

**Decisión.** Se implementa un **factory** `buildCrudRouter(Model, { include })`
en `src/utils/crudFactory.js` que devuelve un `Router` Express completo.
Las rutas en `src/routes/index.js` consumen el factory y declaran qué
relaciones se incluyen (`include`) por entidad. Cuando una entidad necesite
reglas específicas (autenticación, autorización por rol, validación de campos),
se reemplaza la línea `router.use('/foo', buildCrudRouter(Foo))` por un router
dedicado sin tocar el resto.

**¿Qué artefacto de diseño respalda esta decisión?**
E5 — Diagrama de Componentes UML / E12 — Diagrama de Clases

**Consecuencias.**
- ✅ Toda la capa CRUD cabe en un archivo de ~50 líneas en lugar de 18 archivos.
- ✅ Mejorar el manejo de errores o validación se hace en un solo lugar.
- ⚠️ La lógica especializada (cálculo de `RUTA`, autenticación del estudiante en
  `CONSULTA`/`HISTORIAL`) tendrá que reemplazar el router genérico cuando llegue
  su semana.
