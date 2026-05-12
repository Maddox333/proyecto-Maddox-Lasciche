# E8 — Modelo Entidad Relación (MER)

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

> ⚠️ **Nota importante:** El MER de referencia es el contenido en el archivo
> `Mer.png` adjunto al repositorio, el cual constituye la versión corregida
> y definitiva del modelo. La descripción textual a continuación es fiel
> a dicho modelo.

---

## Entidades y Atributos

### USUARIOS
- **id_usuario** (PK)
- correo
- contrasena
- fecha_registro
- activo
- id_rol (FK → ROL)

### ROL
- **id_rol** (PK)
- nombre_rol
- descripcion

### ESTUDIANTE
- **id_estudiante** (PK)
- id_usuario (FK → USUARIOS)
- id_carrera (FK → CARRERA)
- nombre
- codigo_estudiantil
- semestre

### ADMINISTRADOR
- **id_admin** (PK)
- id_usuario (FK → USUARIOS)
- nombre
- cargo

### CARRERA
- **id_carrera** (PK)
- nombre_carrera
- facultad
- duracion_semestres

### DOCENTE
- **id_docente** (PK)
- id_usuario (FK → USUARIOS)
- nombre
- correo
- departamento

### MATERIA
- **id_materia** (PK)
- id_carrera (FK → CARRERA)
- nombre_materia
- codigo_materia
- creditos

### ASIGNACION
- **id_asignacion** (PK)
- id_materia (FK → MATERIA)
- id_docente (FK → DOCENTE)
- id_aula (FK → AULA)
- id_estudiante (FK → ESTUDIANTE)
- dia_semana
- hora_inicio
- hora_fin

### TORRE
- **id_torre** (PK)
- nombre_torre
- descripcion

### PISO
- **id_piso** (PK)
- id_torre (FK → TORRE)
- numero_piso
- descripcion

### AULA
- **id_aula** (PK)
- id_piso (FK → PISO)
- codigo_aula
- capacidad
- tipo_aula
- disponible

### UBICACION
- **id_ubicacion** (PK)
- id_aula (FK → AULA)
- coordenada_x
- coordenada_y
- referencia

### RUTA
- **id_ruta** (PK)
- id_estudiante (FK → ESTUDIANTE)
- id_aula_origen (FK → AULA)
- id_aula_destino (FK → AULA)
- distancia_metros
- tiempo_minutos
- fecha_consulta

### CONSULTA
- **id_consulta** (PK)
- id_estudiante (FK → ESTUDIANTE)
- id_aula (FK → AULA)
- fecha_consulta
- tipo_consulta

### HISTORIAL
- **id_historial** (PK)
- id_estudiante (FK → ESTUDIANTE)
- id_consulta (FK → CONSULTA)
- fecha_registro

### NOTIFICACION
- **id_notificacion** (PK)
- id_estudiante (FK → ESTUDIANTE)
- titulo
- mensaje
- tipo
- leida
- fecha_envio

### REPORTE_SOPORTE
- **id_reporte** (PK)
- id_estudiante (FK → ESTUDIANTE)
- tipo_fallo
- descripcion
- estado
- fecha_reporte
- fecha_resolucion

---

## Relaciones y Cardinalidades

| Entidad A | Cardinalidad | Entidad B | Descripción |
|---|---|---|---|
| ROL | 1 | N — USUARIOS | Un rol puede tener muchos usuarios |
| USUARIOS | 1 | 1 — ESTUDIANTE | Un usuario puede ser un estudiante |
| USUARIOS | 1 | 1 — ADMINISTRADOR | Un usuario puede ser un administrador |
| USUARIOS | 1 | 1 — DOCENTE | Un usuario puede ser un docente |
| CARRERA | 1 | N — ESTUDIANTE | Una carrera tiene muchos estudiantes |
| CARRERA | 1 | N — MATERIA | Una carrera tiene muchas materias |
| DOCENTE | 1 | N — ASIGNACION | Un docente tiene muchas asignaciones |
| MATERIA | 1 | N — ASIGNACION | Una materia tiene muchas asignaciones |
| AULA | 1 | N — ASIGNACION | Un aula tiene muchas asignaciones |
| ESTUDIANTE | 1 | N — ASIGNACION | Un estudiante tiene muchas asignaciones |
| TORRE | 1 | N — PISO | Una torre tiene muchos pisos |
| PISO | 1 | N — AULA | Un piso tiene muchas aulas |
| AULA | 1 | 1 — UBICACION | Un aula tiene una ubicación en el mapa |
| ESTUDIANTE | 1 | N — RUTA | Un estudiante puede calcular muchas rutas |
| AULA | 1 | N — RUTA | Un aula puede ser origen o destino de rutas |
| ESTUDIANTE | 1 | N — CONSULTA | Un estudiante puede realizar muchas consultas |
| AULA | 1 | N — CONSULTA | Un aula puede ser consultada muchas veces |
| ESTUDIANTE | 1 | N — HISTORIAL | Un estudiante tiene un historial de consultas |
| CONSULTA | 1 | N — HISTORIAL | Una consulta puede aparecer en el historial |
| ESTUDIANTE | 1 | N — NOTIFICACION | Un estudiante puede recibir muchas notificaciones |
| ESTUDIANTE | 1 | N — REPORTE_SOPORTE | Un estudiante puede generar muchos reportes |

---

## Diagrama MER (Notación Chen — Textual)