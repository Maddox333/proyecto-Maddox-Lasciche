# E4 — Diagrama de Arquetipos

## Definición
Los arquetipos son los bloques de construcción conceptuales del sistema.
Representan las abstracciones fundamentales que dan forma a la arquitectura
antes de definir clases o componentes concretos.

---

## Arquetipos del SIGAU

### 🧑 ACTOR
Representa cualquier entidad humana que interactúa con el sistema.

| Arquetipo | Instancias concretas |
|---|---|
| Actor | Estudiante, Administrador, Equipo de Desarrollo |

**Responsabilidad:** Iniciar casos de uso, autenticarse y consumir servicios del sistema.

---

### 🔐 SESION
Representa el contexto de seguridad activo de un actor autenticado.

| Arquetipo | Instancias concretas |
|---|---|
| Sesión | SesionEstudiante, SesionAdministrador |

**Responsabilidad:** Mantener el estado de autenticación, rol y permisos durante
la interacción del usuario con el sistema.

---

### 📋 DESCRIPTOR
Representa entidades que describen o catalogan información del dominio académico.

| Arquetipo | Instancias concretas |
|---|---|
| Descriptor | Materia, Carrera, Docente, Rol |

**Responsabilidad:** Proveer información de referencia estable que otros arquetipos
consultan para operar correctamente.

---

### 📍 LUGAR
Representa entidades físicas del campus universitario.

| Arquetipo | Instancias concretas |
|---|---|
| Lugar | Torre, Piso, Aula, Ubicacion |

**Responsabilidad:** Modelar la estructura física del campus y permitir la
localización y navegación de espacios académicos.

---

### 📅 EVENTO
Representa ocurrencias temporales con impacto en el sistema.

| Arquetipo | Instancias concretas |
|---|---|
| Evento | Asignacion (horario), Notificacion, Consulta |

**Responsabilidad:** Registrar y gestionar hechos que ocurren en un momento
determinado y que generan reacciones en el sistema o en los actores.

---

### 📝 TRANSACCION
Representa operaciones que modifican el estado del sistema y deben quedar registradas.

| Arquetipo | Instancias concretas |
|---|---|
| Transacción | Historial, ReporteSoporte, Ruta |

**Responsabilidad:** Garantizar la trazabilidad de las acciones del usuario,
registrar el historial de consultas y gestionar el ciclo de vida de los reportes.

---

### ⚙️ SERVICIO
Representa capacidades del sistema que procesan lógica de negocio sin estado propio.

| Arquetipo | Instancias concretas |
|---|---|
| Servicio | ServicioMapa, ServicioRutas, ServicioNotificaciones, AsistenteVirtual |

**Responsabilidad:** Ejecutar operaciones complejas (cálculo de rutas, renderizado
de mapa, envío de notificaciones, procesamiento de lenguaje natural) de forma
desacoplada de la capa de presentación.

---

## Mapa de Arquetipos

ACTOR ──────────────► SESION
│ │
│ ▼
│ DESCRIPTOR ◄──── LUGAR
│ │ │
▼ ▼ ▼
SERVICIO ◄────────── EVENTO ────────► TRANSACCION


---

## Relación Arquetipos → Entidades del MER

| Arquetipo | Entidades del MER |
|---|---|
| ACTOR | USUARIOS, ESTUDIANTE, ADMINISTRADOR |
| SESION | ROL |
| DESCRIPTOR | MATERIA, CARRERA, DOCENTE |
| LUGAR | TORRE, PISO, AULA, UBICACION |
| EVENTO | ASIGNACION, NOTIFICACION, CONSULTA |
| TRANSACCION | HISTORIAL, REPORTE_SOPORTE, RUTA |
| SERVICIO | (Componentes de software — no entidades de datos) |

---

## Relación Arquetipos → Casos de Uso

| Arquetipo | Casos de Uso que lo activan |
|---|---|
| ACTOR | CU-01, CU-02, CU-03, CU-04, CU-05 |
| SESION | CU-01, CU-02, CU-03, CU-04, CU-05 |
| DESCRIPTOR | CU-02, CU-05 |
| LUGAR | CU-01, CU-05 |
| EVENTO | CU-02, CU-03 |
| TRANSACCION | CU-01, CU-04 |
| SERVICIO | CU-01, CU-03 |