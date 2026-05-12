# M5 — Matriz de Trazabilidad: Entidades, Arquetipos, Requisitos Funcionales y Reglas de Negocio

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona las entidades del modelo de datos con los arquetipos
arquitecturales, los Requisitos Funcionales (RF) y las Reglas de Negocio (RN),
verificando que cada entidad tiene una justificación funcional y de negocio.

---

## Reglas de Negocio del Sistema

| Código | Regla de Negocio |
|---|---|
| RN-01 | Un usuario solo puede tener un rol activo a la vez |
| RN-02 | Un estudiante pertenece a una sola carrera |
| RN-03 | Un docente puede impartir múltiples materias |
| RN-04 | Una materia puede ser impartida por múltiples docentes en diferentes horarios |
| RN-05 | Un aula pertenece a un solo piso y un piso pertenece a una sola torre |
| RN-06 | Una asignación vincula un docente, una materia, un aula y un horario |
| RN-07 | Un aula solo puede tener una asignación activa por franja horaria |
| RN-08 | Un estudiante solo puede consultar aulas que estén en estado DISPONIBLE u OCUPADA |
| RN-09 | El historial de consultas se registra automáticamente al buscar un aula |
| RN-10 | Las notificaciones son enviadas por el administrador a estudiantes |
| RN-11 | Un reporte de soporte debe ser revisado por un administrador |
| RN-12 | Un docente solo puede ver sus propias asignaciones y aulas |
| RN-13 | El administrador puede gestionar todos los recursos del sistema |
| RN-14 | Una ubicación corresponde a exactamente un aula |
| RN-15 | La contraseña de un usuario debe estar cifrada en la base de datos |

---

## Matriz Principal

| Entidad | Arquetipo | RF Relacionados | Reglas de Negocio |
|---|---|---|---|
| USUARIOS | A1 Actor, A3 Entidad | RF-01, RF-02 | RN-01, RN-15 |
| ROL | A3 Entidad | RF-02 | RN-01 |
| ESTUDIANTE | A1 Actor, A3 Entidad | RF-03, RF-04, RF-05 | RN-02, RN-08, RN-09 |
| DOCENTE | A1 Actor, A3 Entidad | RF-06, RF-07 | RN-03, RN-12 |
| ADMINISTRADOR | A1 Actor, A3 Entidad | RF-08, RF-09, RF-10 | RN-13 |
| CARRERA | A3 Entidad | RF-04 | RN-02 |
| MATERIA | A3 Entidad | RF-04, RF-06 | RN-03, RN-04 |
| ASIGNACION | A3 Entidad | RF-04, RF-06, RF-10 | RN-06, RN-07 |
| TORRE | A3 Entidad | RF-08, RF-11 | RN-05 |
| PISO | A3 Entidad | RF-08, RF-11 | RN-05 |
| AULA | A3 Entidad | RF-03, RF-08, RF-11 | RN-05, RN-07, RN-08 |
| UBICACION | A3 Entidad | RF-11, RF-12 | RN-14 |
| CONSULTA | A3 Entidad | RF-05, RF-13 | RN-09 |
| NOTIFICACION | A3 Entidad, A7 Notificador | RF-14 | RN-10 |
| REPORTE_SOPORTE | A3 Entidad, A8 Reportador | RF-15, RF-16 | RN-11 |
| HORARIO | A3 Entidad | RF-04, RF-06 | RN-06, RN-07 |

---

## Detalle por Entidad

### USUARIOS
| Elemento | Detalle |
|---|---|
| Arquetipo | A1 Actor, A3 Entidad |
| RF | RF-01 Autenticación, RF-02 Control de acceso |
| RN | RN-01 Un rol activo, RN-15 Contraseña cifrada |
| Atributos clave | id_usuario, correo, password, id_rol |
| Implementación | Modelo `Usuarios` con FK a `ROL` |

### ROL
| Elemento | Detalle |
|---|---|
| Arquetipo | A3 Entidad |
| RF | RF-02 Control de acceso |
| RN | RN-01 Un usuario, un rol activo |
| Atributos clave | id_rol, nombre_rol |
| Implementación | Modelo `Rol` con valores: Estudiante, Docente, Administrador |

### ESTUDIANTE
| Elemento | Detalle |
|---|---|
| Arquetipo | A1 Actor, A3 Entidad |
| RF | RF-03 Buscar aula, RF-04 Ver horario, RF-05 Historial |
| RN | RN-02 Una carrera, RN-08 Ver aulas disponibles, RN-09 Registro automático |
| Atributos clave | id_estudiante, id_usuario, id_carrera |
| Implementación | Modelo `Estudiante` con FK a `Usuarios` y `Carrera` |

### DOCENTE
| Elemento | Detalle |
|---|---|
| Arquetipo | A1 Actor, A3 Entidad |
| RF | RF-06 Ver horario docente, RF-07 Ver mis aulas |
| RN | RN-03 Múltiples materias, RN-12 Solo sus asignaciones |
| Atributos clave | id_docente, id_usuario, nombre, departamento |
| Implementación | Modelo `Docente` con FK a `Usuarios` |

### ADMINISTRADOR
| Elemento | Detalle |
|---|---|
| Arquetipo | A1 Actor, A3 Entidad |
| RF | RF-08, RF-09, RF-10 Gestión completa |
| RN | RN-13 Acceso total al sistema |
| Atributos clave | id_administrador, id_usuario |
| Implementación | Modelo `Administrador` con FK a `Usuarios` |

### AULA
| Elemento | Detalle |
|---|---|
| Arquetipo | A3 Entidad |
| RF | RF-03 Buscar aula, RF-08 Gestionar aulas, RF-11 Mapa |
| RN | RN-05 Pertenece a un piso, RN-07 Una asignación por franja, RN-08 Estado visible |
| Atributos clave | id_aula, codigo_aula, capacidad, tipo, estado, id_piso |
| Implementación | Modelo `Aula` con FK a `Piso` |

### ASIGNACION
| Elemento | Detalle |
|---|---|
| Arquetipo | A3 Entidad |
| RF | RF-04, RF-06, RF-10 Horarios y asignaciones |
| RN | RN-06 Vincula docente-materia-aula-horario, RN-07 Sin solapamiento |
| Atributos clave | id_asignacion, id_docente, id_materia, id_aula, id_horario |
| Implementación | Modelo `Asignacion` con FK a `Docente`, `Materia`, `Aula`, `Horario` |

### UBICACION
| Elemento | Detalle |
|---|---|
| Arquetipo | A3 Entidad |
| RF | RF-11 Mapa interactivo, RF-12 Calcular ruta |
| RN | RN-14 Una ubicación por aula |
| Atributos clave | id_ubicacion, id_aula, latitud, longitud, referencia |
| Implementación | Modelo `Ubicacion` con FK a `Aula` |

---

## Cobertura de Entidades

| Entidad | Tiene Arquetipo | Tiene RF | Tiene RN | Cobertura |
|---|---|---|---|---|
| USUARIOS | ✅ | ✅ | ✅ | 100% |
| ROL | ✅ | ✅ | ✅ | 100% |
| ESTUDIANTE | ✅ | ✅ | ✅ | 100% |
| DOCENTE | ✅ | ✅ | ✅ | 100% |
| ADMINISTRADOR | ✅ | ✅ | ✅ | 100% |
| CARRERA | ✅ | ✅ | ✅ | 100% |
| MATERIA | ✅ | ✅ | ✅ | 100% |
| ASIGNACION | ✅ | ✅ | ✅ | 100% |
| TORRE | ✅ | ✅ | ✅ | 100% |
| PISO | ✅ | ✅ | ✅ | 100% |
| AULA | ✅ | ✅ | ✅ | 100% |
| UBICACION | ✅ | ✅ | ✅ | 100% |
| CONSULTA | ✅ | ✅ | ✅ | 100% |
| NOTIFICACION | ✅ | ✅ | ✅ | 100% |
| REPORTE_SOPORTE | ✅ | ✅ | ✅ | 100% |
| HORARIO | ✅ | ✅ | ✅ | 100% |

**Cobertura total: 16/16 entidades — 100% ✅**