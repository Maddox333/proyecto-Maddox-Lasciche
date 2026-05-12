# E7 — Diccionario de Datos

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Tabla: USUARIOS

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_usuario | INT | — | NO | ✅ | — | Identificador único del usuario |
| correo | VARCHAR | 100 | NO | — | — | Correo institucional (único) |
| contrasena | VARCHAR | 255 | NO | — | — | Contraseña cifrada (hash bcrypt) |
| id_rol | INT | — | NO | — | ✅ ROL | Rol asignado al usuario |
| fecha_registro | DATE | — | NO | — | — | Fecha de creación del usuario |
| activo | BOOLEAN | — | NO | — | — | Estado del usuario (activo/inactivo) |

---

## Tabla: ROL

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_rol | INT | — | NO | ✅ | — | Identificador único del rol |
| nombre_rol | VARCHAR | 50 | NO | — | — | Nombre del rol (Estudiante, Administrador) |
| descripcion | VARCHAR | 200 | SÍ | — | — | Descripción de los permisos del rol |

---

## Tabla: ESTUDIANTE

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_estudiante | INT | — | NO | ✅ | — | Identificador único del estudiante |
| id_usuario | INT | — | NO | — | ✅ USUARIOS | Referencia al usuario del sistema |
| id_carrera | INT | — | NO | — | ✅ CARRERA | Carrera académica del estudiante |
| nombre | VARCHAR | 100 | NO | — | — | Nombre completo del estudiante |
| codigo_estudiantil | VARCHAR | 20 | NO | — | — | Código único estudiantil |
| semestre | INT | — | NO | — | — | Semestre actual del estudiante |

---

## Tabla: ADMINISTRADOR

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_admin | INT | — | NO | ✅ | — | Identificador único del administrador |
| id_usuario | INT | — | NO | — | ✅ USUARIOS | Referencia al usuario del sistema |
| nombre | VARCHAR | 100 | NO | — | — | Nombre completo del administrador |
| cargo | VARCHAR | 100 | SÍ | — | — | Cargo institucional del administrador |

---

## Tabla: CARRERA

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_carrera | INT | — | NO | ✅ | — | Identificador único de la carrera |
| nombre_carrera | VARCHAR | 150 | NO | — | — | Nombre oficial de la carrera |
| facultad | VARCHAR | 150 | NO | — | — | Facultad a la que pertenece |
| duracion_semestres | INT | — | NO | — | — | Duración total en semestres |

---

## Tabla: DOCENTE

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_docente | INT | — | NO | ✅ | — | Identificador único del docente |
| nombre | VARCHAR | 100 | NO | — | — | Nombre completo del docente |
| correo | VARCHAR | 100 | NO | — | — | Correo institucional del docente |
| departamento | VARCHAR | 100 | SÍ | — | — | Departamento académico al que pertenece |

---

## Tabla: MATERIA

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_materia | INT | — | NO | ✅ | — | Identificador único de la materia |
| nombre_materia | VARCHAR | 150 | NO | — | — | Nombre oficial de la materia |
| codigo_materia | VARCHAR | 20 | NO | — | — | Código único de la materia |
| creditos | INT | — | NO | — | — | Número de créditos académicos |
| id_carrera | INT | — | NO | — | ✅ CARRERA | Carrera a la que pertenece la materia |

---

## Tabla: ASIGNACION

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_asignacion | INT | — | NO | ✅ | — | Identificador único de la asignación |
| id_materia | INT | — | NO | — | ✅ MATERIA | Materia asignada |
| id_docente | INT | — | NO | — | ✅ DOCENTE | Docente que dicta la materia |
| id_aula | INT | — | NO | — | ✅ AULA | Aula donde se dicta la clase |
| id_estudiante | INT | — | NO | — | ✅ ESTUDIANTE | Estudiante inscrito |
| dia_semana | VARCHAR | 20 | NO | — | — | Día de la semana de la clase |
| hora_inicio | TIME | — | NO | — | — | Hora de inicio de la clase |
| hora_fin | TIME | — | NO | — | — | Hora de finalización de la clase |

---

## Tabla: TORRE

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_torre | INT | — | NO | ✅ | — | Identificador único de la torre |
| nombre_torre | VARCHAR | 100 | NO | — | — | Nombre o código de la torre |
| descripcion | VARCHAR | 200 | SÍ | — | — | Descripción general de la torre |

---

## Tabla: PISO

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_piso | INT | — | NO | ✅ | — | Identificador único del piso |
| id_torre | INT | — | NO | — | ✅ TORRE | Torre a la que pertenece el piso |
| numero_piso | INT | — | NO | — | — | Número del piso |
| descripcion | VARCHAR | 200 | SÍ | — | — | Descripción del piso |

---

## Tabla: AULA

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_aula | INT | — | NO | ✅ | — | Identificador único del aula |
| id_piso | INT | — | NO | — | ✅ PISO | Piso donde se encuentra el aula |
| codigo_aula | VARCHAR | 20 | NO | — | — | Código único del aula |
| capacidad | INT | — | NO | — | — | Capacidad máxima de estudiantes |
| tipo_aula | VARCHAR | 50 | SÍ | — | — | Tipo de aula (salón, laboratorio, etc.) |
| disponible | BOOLEAN | — | NO | — | — | Estado de disponibilidad del aula |

---

## Tabla: UBICACION

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_ubicacion | INT | — | NO | ✅ | — | Identificador único de la ubicación |
| id_aula | INT | — | NO | — | ✅ AULA | Aula a la que corresponde la ubicación |
| coordenada_x | DECIMAL | 10,6 | NO | — | — | Coordenada X en el mapa del campus |
| coordenada_y | DECIMAL | 10,6 | NO | — | — | Coordenada Y en el mapa del campus |
| referencia | VARCHAR | 200 | SÍ | — | — | Referencia visual (ej: "frente a la cafetería") |

---

## Tabla: RUTA

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_ruta | INT | — | NO | ✅ | — | Identificador único de la ruta |
| id_estudiante | INT | — | NO | — | ✅ ESTUDIANTE | Estudiante que solicitó la ruta |
| id_aula_origen | INT | — | NO | — | ✅ AULA | Aula o punto de origen |
| id_aula_destino | INT | — | NO | — | ✅ AULA | Aula destino de la ruta |
| distancia_metros | DECIMAL | 8,2 | SÍ | — | — | Distancia estimada en metros |
| tiempo_minutos | INT | — | SÍ | — | — | Tiempo estimado en minutos |
| fecha_consulta | TIMESTAMP | — | NO | — | — | Fecha y hora de la consulta |

---

## Tabla: CONSULTA

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_consulta | INT | — | NO | ✅ | — | Identificador único de la consulta |
| id_estudiante | INT | — | NO | — | ✅ ESTUDIANTE | Estudiante que realizó la consulta |
| id_aula | INT | — | NO | — | ✅ AULA | Aula consultada |
| fecha_consulta | TIMESTAMP | — | NO | — | — | Fecha y hora de la consulta |
| tipo_consulta | VARCHAR | 50 | NO | — | — | Tipo (búsqueda, mapa, ruta, asistente) |

---

## Tabla: HISTORIAL

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_historial | INT | — | NO | ✅ | — | Identificador único del historial |
| id_estudiante | INT | — | NO | — | ✅ ESTUDIANTE | Estudiante dueño del historial |
| id_consulta | INT | — | NO | — | ✅ CONSULTA | Consulta registrada |
| fecha_registro | TIMESTAMP | — | NO | — | — | Fecha de registro en el historial |

---

## Tabla: NOTIFICACION

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_notificacion | INT | — | NO | ✅ | — | Identificador único de la notificación |
| id_estudiante | INT | — | NO | — | ✅ ESTUDIANTE | Estudiante destinatario |
| titulo | VARCHAR | 150 | NO | — | — | Título de la notificación |
| mensaje | TEXT | — | NO | — | — | Contenido de la notificación |
| tipo | VARCHAR | 50 | NO | — | — | Tipo (cambio de aula, recordatorio, etc.) |
| leida | BOOLEAN | — | NO | — | — | Estado de lectura |
| fecha_envio | TIMESTAMP | — | NO | — | — | Fecha y hora de envío |

---

## Tabla: REPORTE_SOPORTE

| Campo | Tipo | Longitud | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|---|
| id_reporte | INT | — | NO | ✅ | — | Identificador único del reporte |
| id_estudiante | INT | — | NO | — | ✅ ESTUDIANTE | Estudiante que generó el reporte |
| tipo_fallo | VARCHAR | 100 | NO | — | — | Categoría del fallo reportado |
| descripcion | TEXT | — | NO | — | — | Descripción detallada del problema |
| estado | VARCHAR | 50 | NO | — | — | Estado (Abierto, En revisión, Resuelto) |
| fecha_reporte | TIMESTAMP | — | NO | — | — | Fecha y hora del reporte |
| fecha_resolucion | TIMESTAMP | — | SÍ | — | — | Fecha de resolución (si aplica) |