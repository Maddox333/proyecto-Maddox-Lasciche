# M11 — Matriz de Trazabilidad: Estados, Entidades y Reglas de Negocio

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona los diagramas de estado con las entidades del
sistema y las Reglas de Negocio (RN) que gobiernan las transiciones
de estado, verificando que toda la lógica de estados está cubierta.

Los ejemplos de implementación usan **Sequelize 6** (modelos en
`src/models/*.js`) sobre Node.js + Express, con la base de datos
**PostgreSQL 15**.

---

## Entidades con Estado

| # | Entidad | Estados posibles | RN asociadas |
|---|---|---|---|
| E1 | AULA | DISPONIBLE, OCUPADA, MANTENIMIENTO | RN-05, RN-07 |
| E2 | ASIGNACION | ACTIVA, INACTIVA, CANCELADA | RN-06, RN-07 |
| E3 | CONSULTA | EXITOSA, FALLIDA | RN-09 |
| E4 | NOTIFICACION | ENVIADA, LEIDA, ELIMINADA | RN-10 |
| E5 | REPORTE_SOPORTE | Abierto, EN_REVISION, Resuelto | RN-11 |
| E6 | USUARIO (sesión) | ACTIVO, INACTIVO, BLOQUEADO | RN-15 |

---

## Matriz Principal: Estados — Entidades — RN

| Entidad | Estado Inicial | Transiciones | Estado Final | RN |
|---|---|---|---|---|
| AULA | DISPONIBLE | DISPONIBLE → OCUPADA (asignación activa) | OCUPADA | RN-07 |
| AULA | OCUPADA | OCUPADA → DISPONIBLE (asignación termina) | DISPONIBLE | RN-07 |
| AULA | DISPONIBLE | DISPONIBLE → MANTENIMIENTO (admin) | MANTENIMIENTO | RN-05 |
| AULA | MANTENIMIENTO | MANTENIMIENTO → DISPONIBLE (admin) | DISPONIBLE | RN-05 |
| ASIGNACION | ACTIVA | ACTIVA → INACTIVA (periodo termina) | INACTIVA | RN-06 |
| ASIGNACION | ACTIVA | ACTIVA → CANCELADA (admin cancela) | CANCELADA | RN-06 |
| CONSULTA | — | Búsqueda exitosa → EXITOSA | EXITOSA | RN-09 |
| CONSULTA | — | Búsqueda fallida → FALLIDA | FALLIDA | RN-09 |
| NOTIFICACION | ENVIADA | ENVIADA → LEIDA (usuario abre) | LEIDA | RN-10 |
| NOTIFICACION | LEIDA | LEIDA → ELIMINADA (usuario elimina) | ELIMINADA | RN-10 |
| NOTIFICACION | ENVIADA | ENVIADA → ELIMINADA (usuario elimina) | ELIMINADA | RN-10 |
| REPORTE_SOPORTE | Abierto | Abierto → EN_REVISION (admin revisa) | EN_REVISION | RN-11 |
| REPORTE_SOPORTE | EN_REVISION | EN_REVISION → Resuelto (admin resuelve) | Resuelto | RN-11 |
| USUARIO (sesión) | INACTIVO | INACTIVO → ACTIVO (login exitoso) | ACTIVO | RN-15 |
| USUARIO (sesión) | ACTIVO | ACTIVO → INACTIVO (logout) | INACTIVO | RN-15 |
| USUARIO (sesión) | ACTIVO | ACTIVO → BLOQUEADO (3 intentos fallidos) | BLOQUEADO | RN-15 |

---

## Detalle por Entidad

### E1 — AULA

**Estados:**
- `DISPONIBLE` — El aula está libre y puede ser asignada
- `OCUPADA` — El aula tiene una asignación activa en el horario actual
- `MANTENIMIENTO` — El aula no está disponible por mantenimiento

**Diagrama de transiciones:**
```
[DISPONIBLE]   ──asignación activa──►       [OCUPADA]
[OCUPADA]      ──asignación termina──►      [DISPONIBLE]
[DISPONIBLE]   ──admin pone en mantenim──►  [MANTENIMIENTO]
[MANTENIMIENTO]──admin habilita──►          [DISPONIBLE]
```

**Reglas de Negocio:**
| RN | Descripción | Transición afectada |
|---|---|---|
| RN-05 | Solo el administrador puede cambiar el estado a MANTENIMIENTO | DISPONIBLE → MANTENIMIENTO |
| RN-07 | Un aula OCUPADA no puede ser asignada en el mismo horario | DISPONIBLE → OCUPADA |

**Implementación (Sequelize):**
El modelo `Aula` (`src/models/Aula.js`) restringe los valores con
`validate: { isIn: [['DISPONIBLE', 'OCUPADA', 'MANTENIMIENTO']] }`; las
transiciones se ejecutan desde el servicio `AulaService` (ver M9).

```js
const { Aula } = require('../models');

async function ponerEnMantenimiento(idAula, usuarioActor) {
  const rol = await usuarioActor.getRol();
  if (rol.nombre_rol !== 'Administrador') {
    throw new Error('Solo el administrador puede hacer esto.');
  }
  const aula = await Aula.findByPk(idAula);
  aula.estado = 'MANTENIMIENTO';
  await aula.save();
  return aula;
}

async function habilitar(idAula) {
  const aula = await Aula.findByPk(idAula);
  aula.estado = 'DISPONIBLE';
  await aula.save();
  return aula;
}
```

---

### E2 — ASIGNACION

**Estados:**
- `ACTIVA` — La asignación está vigente en el periodo actual
- `INACTIVA` — El periodo de la asignación ha terminado
- `CANCELADA` — El administrador canceló la asignación

**Diagrama de transiciones:**
```
[ACTIVA] ──periodo termina──► [INACTIVA]
[ACTIVA] ──admin cancela──►   [CANCELADA]
```

**Reglas de Negocio:**
| RN | Descripción | Transición afectada |
|---|---|---|
| RN-06 | No puede haber dos asignaciones activas para la misma aula en el mismo horario y periodo | Creación → ACTIVA |
| RN-07 | Al cancelar una asignación, el aula vuelve a DISPONIBLE | ACTIVA → CANCELADA |

**Implementación (Sequelize):**
```js
const { Asignacion, Aula } = require('../models');

async function cancelar(idAsignacion) {
  const asignacion = await Asignacion.findByPk(idAsignacion);
  asignacion.estado = 'CANCELADA';
  await asignacion.save();
  const aula = await Aula.findByPk(asignacion.id_aula);
  aula.estado = 'DISPONIBLE';
  await aula.save();
}
```

---

### E3 — CONSULTA

**Estados:**
- `EXITOSA` — La búsqueda encontró el aula solicitada
- `FALLIDA` — La búsqueda no encontró resultados

**Diagrama de transiciones:**
```
[búsqueda realizada] ──aula encontrada──►    [EXITOSA]
[búsqueda realizada] ──aula no encontrada──► [FALLIDA]
```

**Reglas de Negocio:**
| RN | Descripción | Transición afectada |
|---|---|---|
| RN-09 | Toda búsqueda de aula debe registrarse automáticamente con su resultado | Búsqueda → EXITOSA/FALLIDA |

**Implementación (Sequelize):**
La entidad `CONSULTA` del DDL no tiene una columna explícita de "resultado";
se modela como un evento (`tipo_consulta`) cuya semántica de éxito/falla
queda en el log y, de ser necesario, se persiste el resultado en
`tipo_consulta` (`BUSQUEDA_EXITOSA` / `BUSQUEDA_FALLIDA`).

```js
const { Consulta, Historial } = require('../models');

async function registrarBusqueda(idEstudiante, idAula, encontrada) {
  const tipo = encontrada ? 'BUSQUEDA_EXITOSA' : 'BUSQUEDA_FALLIDA';
  const consulta = await Consulta.create({
    id_estudiante: idEstudiante, id_aula: idAula, tipo_consulta: tipo,
  });
  await Historial.create({ id_estudiante: idEstudiante, id_consulta: consulta.id_consulta });
  return consulta;
}
```

---

### E4 — NOTIFICACION

**Estados:**
- `ENVIADA` — La notificación fue creada y está pendiente de lectura
- `LEIDA` — El usuario abrió la notificación
- `ELIMINADA` — El usuario eliminó la notificación

**Diagrama de transiciones:**
```
[ENVIADA] ──usuario abre──►    [LEIDA]
[LEIDA]   ──usuario elimina──► [ELIMINADA]
[ENVIADA] ──usuario elimina──► [ELIMINADA]
```

**Reglas de Negocio:**
| RN | Descripción | Transición afectada |
|---|---|---|
| RN-10 | Una notificación ELIMINADA no puede volver a ENVIADA ni LEIDA | ELIMINADA (estado final) |

**Implementación (Sequelize):**
```js
const { Notificacion } = require('../models');

async function marcarLeida(idNotif) {
  const n = await Notificacion.findByPk(idNotif);
  if (n.estado === 'ENVIADA') {
    n.estado = 'LEIDA';
    await n.save();
  }
  return n;
}

async function eliminar(idNotif) {
  const n = await Notificacion.findByPk(idNotif);
  if (n.estado !== 'ELIMINADA') {
    n.estado = 'ELIMINADA';
    await n.save();
  }
  return n;
}
```

---

### E5 — REPORTE_SOPORTE

**Estados:**
- `Abierto` — El reporte fue enviado y espera revisión
- `EN_REVISION` — El administrador está revisando el reporte
- `Resuelto` — El problema fue solucionado (se registra `fecha_resolucion`)

**Diagrama de transiciones:**
```
[Abierto]     ──admin revisa──►   [EN_REVISION]
[EN_REVISION] ──admin resuelve──► [Resuelto]
```

**Reglas de Negocio:**
| RN | Descripción | Transición afectada |
|---|---|---|
| RN-11 | Solo el administrador puede cambiar el estado del reporte | Todas las transiciones |
| RN-11 | Un reporte Resuelto no puede volver a Abierto | Resuelto (estado final) |

**Implementación (Sequelize):**
```js
const { ReporteSoporte } = require('../models');

async function iniciarRevision(idReporte, usuarioActor) {
  const rol = await usuarioActor.getRol();
  if (rol.nombre_rol !== 'Administrador') {
    throw new Error('Solo el administrador puede revisar reportes.');
  }
  const r = await ReporteSoporte.findByPk(idReporte);
  if (r.estado === 'Abierto') {
    r.estado = 'EN_REVISION';
    await r.save();
  }
  return r;
}

async function resolver(idReporte, usuarioActor) {
  const rol = await usuarioActor.getRol();
  if (rol.nombre_rol !== 'Administrador') {
    throw new Error('Solo el administrador puede resolver reportes.');
  }
  const r = await ReporteSoporte.findByPk(idReporte);
  if (r.estado === 'EN_REVISION') {
    r.estado = 'Resuelto';
    r.fecha_resolucion = new Date();
    await r.save();
  }
  return r;
}
```

---

### E6 — USUARIO (Sesión)

**Estados:**
- `INACTIVO` — El usuario no ha iniciado sesión
- `ACTIVO` — El usuario tiene sesión activa (JWT vigente)
- `BLOQUEADO` — El usuario fue bloqueado por intentos fallidos

**Diagrama de transiciones:**
```
[INACTIVO]  ──login exitoso──►        [ACTIVO]
[ACTIVO]    ──logout──►               [INACTIVO]
[ACTIVO]    ──3 intentos fallidos──►  [BLOQUEADO]
[BLOQUEADO] ──admin desbloquea──►     [INACTIVO]
```

**Reglas de Negocio:**
| RN | Descripción | Transición afectada |
|---|---|---|
| RN-15 | Después de 3 intentos fallidos, la cuenta queda BLOQUEADA | ACTIVO → BLOQUEADO |
| RN-15 | Solo el administrador puede desbloquear una cuenta | BLOQUEADO → INACTIVO |

**Implementación (Sequelize):**
El estado de sesión se gestiona con JWT y un contador `intentos_fallidos`
en memoria (o tabla auxiliar) controlado por `UsuarioService` / middleware
de autenticación.

```js
const intentosPorUsuario = new Map();

async function registrarIntentoFallido(idUsuario) {
  const n = (intentosPorUsuario.get(idUsuario) ?? 0) + 1;
  intentosPorUsuario.set(idUsuario, n);
  if (n >= 3) {
    const { Usuario } = require('../models');
    await Usuario.update({ activo: false }, { where: { id_usuario: idUsuario } });
  }
}

async function desbloquear(idUsuario, usuarioActor) {
  const rol = await usuarioActor.getRol();
  if (rol.nombre_rol !== 'Administrador') {
    throw new Error('Solo el administrador puede desbloquear cuentas.');
  }
  intentosPorUsuario.delete(idUsuario);
  const { Usuario } = require('../models');
  await Usuario.update({ activo: true }, { where: { id_usuario: idUsuario } });
}
```

---

## Cobertura de RN por Estado

| RN | Entidad | Transición cubierta | Estado |
|----|---------|---------------------|--------|
| RN-05 | AULA | DISPONIBLE ↔ MANTENIMIENTO | ✅ |
| RN-06 | ASIGNACION | Validación al crear → ACTIVA | ✅ |
| RN-07 | AULA / ASIGNACION | DISPONIBLE → OCUPADA / CANCELADA → DISPONIBLE | ✅ |
| RN-09 | CONSULTA | Búsqueda → EXITOSA / FALLIDA | ✅ |
| RN-10 | NOTIFICACION | ENVIADA → LEIDA → ELIMINADA | ✅ |
| RN-11 | REPORTE_SOPORTE | Abierto → EN_REVISION → Resuelto | ✅ |
| RN-15 | USUARIO | ACTIVO → BLOQUEADO / BLOQUEADO → INACTIVO | ✅ |

**Cobertura total: 7/7 RN con estados — 100% ✅**
