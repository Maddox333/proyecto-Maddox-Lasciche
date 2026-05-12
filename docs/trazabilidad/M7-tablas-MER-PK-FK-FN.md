# M7 — Matriz de Trazabilidad: Tablas, MER, PK, FK y Formas Normales

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz documenta cada tabla de la base de datos relacionándola con
su entidad en el MER, sus claves primarias (PK), claves foráneas (FK)
y el cumplimiento de las formas normales (1FN, 2FN, 3FN).

---

## Matriz Principal

| # | Tabla | Entidad MER | PK | FK | 1FN | 2FN | 3FN |
|---|---|---|---|---|---|---|---|
| 1 | ROL | ROL | id_rol | — | ✅ | ✅ | ✅ |
| 2 | USUARIOS | USUARIOS | id_usuario | id_rol | ✅ | ✅ | ✅ |
| 3 | ESTUDIANTE | ESTUDIANTE | id_estudiante | id_usuario, id_carrera | ✅ | ✅ | ✅ |
| 4 | DOCENTE | DOCENTE | id_docente | id_usuario | ✅ | ✅ | ✅ |
| 5 | ADMINISTRADOR | ADMINISTRADOR | id_administrador | id_usuario | ✅ | ✅ | ✅ |
| 6 | CARRERA | CARRERA | id_carrera | — | ✅ | ✅ | ✅ |
| 7 | MATERIA | MATERIA | id_materia | id_carrera | ✅ | ✅ | ✅ |
| 8 | HORARIO | HORARIO | id_horario | — | ✅ | ✅ | ✅ |
| 9 | ASIGNACION | ASIGNACION | id_asignacion | id_docente, id_materia, id_aula, id_horario | ✅ | ✅ | ✅ |
| 10 | TORRE | TORRE | id_torre | — | ✅ | ✅ | ✅ |
| 11 | PISO | PISO | id_piso | id_torre | ✅ | ✅ | ✅ |
| 12 | AULA | AULA | id_aula | id_piso | ✅ | ✅ | ✅ |
| 13 | UBICACION | UBICACION | id_ubicacion | id_aula | ✅ | ✅ | ✅ |
| 14 | CONSULTA | CONSULTA | id_consulta | id_estudiante, id_aula | ✅ | ✅ | ✅ |
| 15 | NOTIFICACION | NOTIFICACION | id_notificacion | id_usuario | ✅ | ✅ | ✅ |
| 16 | REPORTE_SOPORTE | REPORTE_SOPORTE | id_reporte | id_estudiante, id_aula | ✅ | ✅ | ✅ |

---

## Detalle por Tabla

### ROL
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_rol | INT | ✅ | | NO | Identificador único del rol |
| nombre_rol | VARCHAR(50) | | | NO | Nombre del rol (Estudiante, Docente, Administrador) |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — No hay dependencias transitivas

---

### USUARIOS
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_usuario | INT | ✅ | | NO | Identificador único del usuario |
| correo | VARCHAR(100) | | | NO | Correo electrónico (único) |
| password | VARCHAR(255) | | | NO | Contraseña cifrada |
| id_rol | INT | | ✅ ROL | NO | Rol del usuario |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — `id_rol` es FK, no genera dependencia transitiva

---

### ESTUDIANTE
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_estudiante | INT | ✅ | | NO | Identificador único del estudiante |
| id_usuario | INT | | ✅ USUARIOS | NO | Usuario asociado (único) |
| id_carrera | INT | | ✅ CARRERA | NO | Carrera del estudiante |
| nombre | VARCHAR(100) | | | NO | Nombre completo |
| codigo_estudiantil | VARCHAR(20) | | | NO | Código único estudiantil |
| semestre | INT | | | NO | Semestre actual |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — Las FK no generan dependencias transitivas

---

### DOCENTE
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_docente | INT | ✅ | | NO | Identificador único del docente |
| id_usuario | INT | | ✅ USUARIOS | NO | Usuario asociado (único) |
| nombre | VARCHAR(100) | | | NO | Nombre completo |
| correo | VARCHAR(100) | | | NO | Correo institucional (único) |
| departamento | VARCHAR(100) | | SI | Departamento académico |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — Las FK no generan dependencias transitivas

---

### ADMINISTRADOR
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_administrador | INT | ✅ | | NO | Identificador único del administrador |
| id_usuario | INT | | ✅ USUARIOS | NO | Usuario asociado (único) |
| nombre | VARCHAR(100) | | | NO | Nombre completo |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — La FK no genera dependencia transitiva

---

### CARRERA
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_carrera | INT | ✅ | | NO | Identificador único de la carrera |
| nombre_carrera | VARCHAR(100) | | | NO | Nombre de la carrera |
| facultad | VARCHAR(100) | | | NO | Facultad a la que pertenece |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — No hay dependencias transitivas

---

### MATERIA
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_materia | INT | ✅ | | NO | Identificador único de la materia |
| id_carrera | INT | | ✅ CARRERA | NO | Carrera a la que pertenece |
| nombre_materia | VARCHAR(100) | | | NO | Nombre de la materia |
| creditos | INT | | | NO | Número de créditos |
| semestre | INT | | | NO | Semestre en que se dicta |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — La FK no genera dependencia transitiva

---

### HORARIO
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_horario | INT | ✅ | | NO | Identificador único del horario |
| dia_semana | VARCHAR(20) | | | NO | Día de la semana |
| hora_inicio | TIME | | | NO | Hora de inicio de la clase |
| hora_fin | TIME | | | NO | Hora de fin de la clase |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — No hay dependencias transitivas

---

### ASIGNACION
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_asignacion | INT | ✅ | | NO | Identificador único de la asignación |
| id_docente | INT | | ✅ DOCENTE | NO | Docente asignado |
| id_materia | INT | | ✅ MATERIA | NO | Materia asignada |
| id_aula | INT | | ✅ AULA | NO | Aula asignada |
| id_horario | INT | | ✅ HORARIO | NO | Horario asignado |
| periodo | VARCHAR(20) | | | NO | Período académico |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — Las FK no generan dependencias transitivas

---

### TORRE
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_torre | INT | ✅ | | NO | Identificador único de la torre |
| nombre_torre | VARCHAR(50) | | | NO | Nombre o código de la torre |
| descripcion | TEXT | | | SI | Descripción de la torre |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — No hay dependencias transitivas

---

### PISO
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_piso | INT | ✅ | | NO | Identificador único del piso |
| id_torre | INT | | ✅ TORRE | NO | Torre a la que pertenece |
| numero_piso | INT | | | NO | Número del piso |
| descripcion | TEXT | | | SI | Descripción del piso |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — La FK no genera dependencia transitiva

---

### AULA
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_aula | INT | ✅ | | NO | Identificador único del aula |
| id_piso | INT | | ✅ PISO | NO | Piso al que pertenece |
| codigo_aula | VARCHAR(20) | | | NO | Código único del aula |
| capacidad | INT | | | NO | Capacidad máxima de personas |
| tipo | VARCHAR(50) | | | NO | Tipo de aula (salón, laboratorio, etc.) |
| estado | VARCHAR(20) | | | NO | Estado actual del aula |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — La FK no genera dependencia transitiva

---

### UBICACION
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_ubicacion | INT | ✅ | | NO | Identificador único de la ubicación |
| id_aula | INT | | ✅ AULA | NO | Aula a la que corresponde (único) |
| latitud | DECIMAL(10,8) | | | NO | Coordenada latitud |
| longitud | DECIMAL(11,8) | | | NO | Coordenada longitud |
| referencia | TEXT | | | SI | Descripción textual de la ubicación |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — La FK no genera dependencia transitiva

---

### CONSULTA
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_consulta | INT | ✅ | | NO | Identificador único de la consulta |
| id_estudiante | INT | | ✅ ESTUDIANTE | NO | Estudiante que realizó la consulta |
| id_aula | INT | | ✅ AULA | NO | Aula consultada |
| fecha_consulta | DATETIME | | | NO | Fecha y hora de la consulta |
| resultado | VARCHAR(20) | | | NO | Resultado (EXITOSA/FALLIDA) |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — Las FK no generan dependencias transitivas

---

### NOTIFICACION
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_notificacion | INT | ✅ | | NO | Identificador único de la notificación |
| id_usuario | INT | | ✅ USUARIOS | NO | Usuario destinatario |
| titulo | VARCHAR(100) | | | NO | Título de la notificación |
| mensaje | TEXT | | | NO | Contenido de la notificación |
| fecha_envio | DATETIME | | | NO | Fecha y hora de envío |
| estado | VARCHAR(20) | | | NO | Estado (ENVIADA/LEÍDA/ELIMINADA) |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — La FK no genera dependencia transitiva

---

### REPORTE_SOPORTE
| Atributo | Tipo | PK | FK | Nulo | Descripción |
|---|---|---|---|---|---|
| id_reporte | INT | ✅ | | NO | Identificador único del reporte |
| id_estudiante | INT | | ✅ ESTUDIANTE | NO | Estudiante que reportó |
| id_aula | INT | | ✅ AULA | NO | Aula reportada |
| descripcion | TEXT | | | NO | Descripción del problema |
| fecha_reporte | DATETIME | | | NO | Fecha y hora del reporte |
| estado | VARCHAR(20) | | | NO | Estado del reporte |

**Formas Normales:**
- 1FN ✅ — Todos los atributos son atómicos
- 2FN ✅ — No hay dependencias parciales (PK simple)
- 3FN ✅ — Las FK no generan dependencias transitivas

---

## Resumen de Cobertura

| Tabla | Entidad MER | PK | FK | 1FN | 2FN | 3FN | Cobertura |
|---|---|---|---|---|---|---|---|
| ROL | ✅ | ✅ | — | ✅ | ✅ | ✅ | 100% |
| USUARIOS | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 100% |
| ESTUDIANTE | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 100% |
| DOCENTE | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 100% |
| ADMINISTRADOR | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 100% |
| CARRERA | ✅ | ✅ | — | ✅ | ✅ | ✅ | 100% |
| MATERIA | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 100% |
| HORARIO | ✅ | ✅ | — | ✅ | ✅ | ✅ | 100% |
| ASIGNACION | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 100% |
| TORRE | ✅ | ✅ | — | ✅ | ✅ | ✅ | 100% |
| PISO | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 100% |
| AULA | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 100% |
| UBICACION | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 100% |
| CONSULTA | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 100% |
| NOTIFICACION | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 100% |
| REPORTE_SOPORTE | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | 100% |

**Cobertura total: 16/16 tablas — 100% ✅**