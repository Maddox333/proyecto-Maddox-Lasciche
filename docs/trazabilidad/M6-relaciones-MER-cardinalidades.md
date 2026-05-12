# M6 — Matriz de Trazabilidad: Relaciones del MER y Cardinalidades

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz documenta todas las relaciones del Modelo Entidad-Relación (MER),
especificando la cardinalidad, la FK correspondiente y la regla de negocio
que justifica cada relación.

---

## Relaciones del MER

| # | Entidad A | Cardinalidad | Entidad B | FK | Regla de Negocio |
|---|---|---|---|---|---|
| R01 | USUARIOS | 1 — 1 | ESTUDIANTE | ESTUDIANTE.id_usuario | RN-01: Un usuario tiene un solo perfil |
| R02 | USUARIOS | 1 — 1 | DOCENTE | DOCENTE.id_usuario | RN-01: Un usuario tiene un solo perfil |
| R03 | USUARIOS | 1 — 1 | ADMINISTRADOR | ADMINISTRADOR.id_usuario | RN-01: Un usuario tiene un solo perfil |
| R04 | ROL | 1 — N | USUARIOS | USUARIOS.id_rol | RN-01: Un rol puede tener múltiples usuarios |
| R05 | CARRERA | 1 — N | ESTUDIANTE | ESTUDIANTE.id_carrera | RN-02: Un estudiante pertenece a una carrera |
| R06 | CARRERA | 1 — N | MATERIA | MATERIA.id_carrera | Una carrera tiene múltiples materias |
| R07 | TORRE | 1 — N | PISO | PISO.id_torre | RN-05: Una torre tiene múltiples pisos |
| R08 | PISO | 1 — N | AULA | AULA.id_piso | RN-05: Un piso tiene múltiples aulas |
| R09 | AULA | 1 — 1 | UBICACION | UBICACION.id_aula | RN-14: Una ubicación por aula |
| R10 | AULA | 1 — N | ASIGNACION | ASIGNACION.id_aula | RN-07: Un aula tiene múltiples asignaciones |
| R11 | DOCENTE | 1 — N | ASIGNACION | ASIGNACION.id_docente | RN-03: Un docente tiene múltiples asignaciones |
| R12 | MATERIA | 1 — N | ASIGNACION | ASIGNACION.id_materia | RN-04: Una materia tiene múltiples asignaciones |
| R13 | HORARIO | 1 — N | ASIGNACION | ASIGNACION.id_horario | Un horario puede tener múltiples asignaciones |
| R14 | ESTUDIANTE | 1 — N | CONSULTA | CONSULTA.id_estudiante | RN-09: Un estudiante tiene múltiples consultas |
| R15 | AULA | 1 — N | CONSULTA | CONSULTA.id_aula | Una aula puede ser consultada múltiples veces |
| R16 | USUARIOS | 1 — N | NOTIFICACION | NOTIFICACION.id_usuario | Un usuario recibe múltiples notificaciones |
| R17 | ESTUDIANTE | 1 — N | REPORTE_SOPORTE | REPORTE_SOPORTE.id_estudiante | Un estudiante puede enviar múltiples reportes |
| R18 | AULA | 1 — N | REPORTE_SOPORTE | REPORTE_SOPORTE.id_aula | Un aula puede tener múltiples reportes |

---

## Detalle de Cardinalidades

### Relaciones Uno a Uno (1 — 1)
| Relación | Justificación |
|---|---|
| USUARIOS — ESTUDIANTE | Cada usuario estudiante tiene exactamente un perfil de estudiante |
| USUARIOS — DOCENTE | Cada usuario docente tiene exactamente un perfil de docente |
| USUARIOS — ADMINISTRADOR | Cada usuario admin tiene exactamente un perfil de administrador |
| AULA — UBICACION | Cada aula tiene exactamente una ubicación geográfica en el campus |

### Relaciones Uno a Muchos (1 — N)
| Relación | Justificación |
|---|---|
| ROL → USUARIOS | Un rol (Estudiante/Docente/Admin) puede asignarse a múltiples usuarios |
| CARRERA → ESTUDIANTE | Una carrera tiene múltiples estudiantes matriculados |
| CARRERA → MATERIA | Una carrera tiene múltiples materias en su plan de estudios |
| TORRE → PISO | Una torre tiene múltiples pisos |
| PISO → AULA | Un piso tiene múltiples aulas |
| AULA → ASIGNACION | Un aula puede tener múltiples asignaciones en diferentes horarios |
| DOCENTE → ASIGNACION | Un docente puede tener múltiples asignaciones de materias |
| MATERIA → ASIGNACION | Una materia puede asignarse en múltiples horarios y aulas |
| HORARIO → ASIGNACION | Un horario puede tener múltiples asignaciones |
| ESTUDIANTE → CONSULTA | Un estudiante puede realizar múltiples consultas de aulas |
| AULA → CONSULTA | Un aula puede ser consultada múltiples veces |
| USUARIOS → NOTIFICACION | Un usuario puede recibir múltiples notificaciones |
| ESTUDIANTE → REPORTE_SOPORTE | Un estudiante puede enviar múltiples reportes |
| AULA → REPORTE_SOPORTE | Un aula puede tener múltiples reportes de soporte |

---

## Matriz de Adyacencia de Entidades

| | USR | ROL | EST | DOC | ADM | CAR | MAT | ASI | TOR | PIS | AUL | UBI | CON | NOT | REP | HOR |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **USR** | — | FK | 1:1 | 1:1 | 1:1 | | | | | | | | | 1:N | | |
| **ROL** | 1:N | — | | | | | | | | | | | | | | |
| **EST** | FK | | — | | | FK | | | | | | | 1:N | | 1:N | |
| **DOC** | FK | | | — | | | | 1:N | | | | | | | | |
| **ADM** | FK | | | | — | | | | | | | | | | | |
| **CAR** | | | 1:N | | | — | 1:N | | | | | | | | | |
| **MAT** | | | | | | FK | — | 1:N | | | | | | | | |
| **ASI** | | | | FK | | | FK | — | | | FK | | | | | FK |
| **TOR** | | | | | | | | | — | 1:N | | | | | | |
| **PIS** | | | | | | | | | FK | — | 1:N | | | | | |
| **AUL** | | | | | | | | FK | | FK | — | 1:1 | 1:N | | 1:N | |
| **UBI** | | | | | | | | | | | FK | — | | | | |
| **CON** | | | FK | | | | | | | | FK | | — | | | |
| **NOT** | FK | | | | | | | | | | | | | — | | |
| **REP** | | | FK | | | | | | | | FK | | | | — | |
| **HOR** | | | | | | | | 1:N | | | | | | | | — |

---

## Resumen de Relaciones

| Tipo | Cantidad | Porcentaje |
|---|---|---|
| Uno a Uno (1 — 1) | 4 | 22% |
| Uno a Muchos (1 — N) | 14 | 78% |
| Muchos a Muchos (N — M) | 0 | 0% |
| **Total** | **18** | **100%** |

> ℹ️ No existen relaciones N:M directas porque todas fueron
> resueltas mediante entidades intermedias (ASIGNACION, CONSULTA).

---

## Cobertura de Relaciones

| Relación | Tiene FK | Tiene Cardinalidad | Tiene RN | Cobertura |
|---|---|---|---|---|
| R01 USUARIOS — ESTUDIANTE | ✅ | ✅ | ✅ | 100% |
| R02 USUARIOS — DOCENTE | ✅ | ✅ | ✅ | 100% |
| R03 USUARIOS — ADMINISTRADOR | ✅ | ✅ | ✅ | 100% |
| R04 ROL — USUARIOS | ✅ | ✅ | ✅ | 100% |
| R05 CARRERA — ESTUDIANTE | ✅ | ✅ | ✅ | 100% |
| R06 CARRERA — MATERIA | ✅ | ✅ | ✅ | 100% |
| R07 TORRE — PISO | ✅ | ✅ | ✅ | 100% |
| R08 PISO — AULA | ✅ | ✅ | ✅ | 100% |
| R09 AULA — UBICACION | ✅ | ✅ | ✅ | 100% |
| R10 AULA — ASIGNACION | ✅ | ✅ | ✅ | 100% |
| R11 DOCENTE — ASIGNACION | ✅ | ✅ | ✅ | 100% |
| R12 MATERIA — ASIGNACION | ✅ | ✅ | ✅ | 100% |
| R13 HORARIO — ASIGNACION | ✅ | ✅ | ✅ | 100% |
| R14 ESTUDIANTE — CONSULTA | ✅ | ✅ | ✅ | 100% |
| R15 AULA — CONSULTA | ✅ | ✅ | ✅ | 100% |
| R16 USUARIOS — NOTIFICACION | ✅ | ✅ | ✅ | 100% |
| R17 ESTUDIANTE — REPORTE_SOPORTE | ✅ | ✅ | ✅ | 100% |
| R18 AULA — REPORTE_SOPORTE | ✅ | ✅ | ✅ | 100% |

**Cobertura total: 18/18 relaciones — 100% ✅**