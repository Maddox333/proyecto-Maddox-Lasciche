# E9 — Modelo Relacional

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

> El modelo relacional se deriva directamente del MER corregido (Mer.png)
> aplicando las reglas de transformación estándar de entidades, atributos
> y relaciones.

---

## Reglas de Transformación Aplicadas

| Regla | Descripción |
|---|---|
| R1 | Cada entidad se convierte en una tabla |
| R2 | Cada atributo simple se convierte en una columna |
| R3 | La PK de cada entidad se convierte en la PK de la tabla |
| R4 | Las relaciones 1:N se resuelven agregando la PK del lado "1" como FK en el lado "N" |
| R5 | Las relaciones 1:1 se resuelven agregando la FK en la tabla de menor jerarquía |
| R6 | Las relaciones N:M se resuelven creando una tabla intermedia con las PK de ambas entidades |

---

## Modelo Relacional

### Tablas de Seguridad y Usuarios

**ROL** (<u>id_rol</u>, nombre_rol, descripcion)

**USUARIOS** (<u>id_usuario</u>, correo, contrasena, fecha_registro, activo, *id_rol*)  
→ *id_rol* FK → ROL(id_rol)

**ESTUDIANTE** (<u>id_estudiante</u>, nombre, codigo_estudiantil, semestre, *id_usuario*, *id_carrera*)  
→ *id_usuario* FK → USUARIOS(id_usuario)  
→ *id_carrera* FK → CARRERA(id_carrera)

**ADMINISTRADOR** (<u>id_admin</u>, nombre, cargo, *id_usuario*)  
→ *id_usuario* FK → USUARIOS(id_usuario)

---

### Tablas Académicas

**CARRERA** (<u>id_carrera</u>, nombre_carrera, facultad, duracion_semestres)

**DOCENTE** (<u>id_docente</u>, nombre, correo, departamento, *id_usuario*)  
→ *id_usuario* FK → USUARIOS(id_usuario)

**MATERIA** (<u>id_materia</u>, nombre_materia, codigo_materia, creditos, *id_carrera*)  
→ *id_carrera* FK → CARRERA(id_carrera)

**ASIGNACION** (<u>id_asignacion</u>, dia_semana, hora_inicio, hora_fin, *id_materia*, *id_docente*, *id_aula*, *id_estudiante*)  
→ *id_materia* FK → MATERIA(id_materia)  
→ *id_docente* FK → DOCENTE(id_docente)  
→ *id_aula* FK → AULA(id_aula)  
→ *id_estudiante* FK → ESTUDIANTE(id_estudiante)

---

### Tablas de Campus

**TORRE** (<u>id_torre</u>, nombre_torre, descripcion)

**PISO** (<u>id_piso</u>, numero_piso, descripcion, *id_torre*)  
→ *id_torre* FK → TORRE(id_torre)

**AULA** (<u>id_aula</u>, codigo_aula, capacidad, tipo_aula, disponible, *id_piso*)  
→ *id_piso* FK → PISO(id_piso)

**UBICACION** (<u>id_ubicacion</u>, coordenada_x, coordenada_y, referencia, *id_aula*)  
→ *id_aula* FK → AULA(id_aula)

---

### Tablas de Navegación

**RUTA** (<u>id_ruta</u>, distancia_metros, tiempo_minutos, fecha_consulta, *id_estudiante*, *id_aula_origen*, *id_aula_destino*)  
→ *id_estudiante* FK → ESTUDIANTE(id_estudiante)  
→ *id_aula_origen* FK → AULA(id_aula)  
→ *id_aula_destino* FK → AULA(id_aula)

---

### Tablas de Interacción y Trazabilidad

**CONSULTA** (<u>id_consulta</u>, fecha_consulta, tipo_consulta, *id_estudiante*, *id_aula*)  
→ *id_estudiante* FK → ESTUDIANTE(id_estudiante)  
→ *id_aula* FK → AULA(id_aula)

**HISTORIAL** (<u>id_historial</u>, fecha_registro, *id_estudiante*, *id_consulta*)  
→ *id_estudiante* FK → ESTUDIANTE(id_estudiante)  
→ *id_consulta* FK → CONSULTA(id_consulta)

**NOTIFICACION** (<u>id_notificacion</u>, titulo, mensaje, tipo, leida, fecha_envio, *id_estudiante*)  
→ *id_estudiante* FK → ESTUDIANTE(id_estudiante)

**REPORTE_SOPORTE** (<u>id_reporte</u>, tipo_fallo, descripcion, estado, fecha_reporte, fecha_resolucion, *id_estudiante*)  
→ *id_estudiante* FK → ESTUDIANTE(id_estudiante)

---

## Resumen del Modelo Relacional

| # | Tabla | PK | FKs | Tipo |
|---|---|---|---|---|
| 1 | ROL | id_rol | — | Catálogo |
| 2 | USUARIOS | id_usuario | id_rol | Seguridad |
| 3 | ESTUDIANTE | id_estudiante | id_usuario, id_carrera | Usuario |
| 4 | ADMINISTRADOR | id_admin | id_usuario | Usuario |
| 5 | CARRERA | id_carrera | — | Catálogo |
| 6 | DOCENTE | id_docente | id_usuario | Catálogo |
| 7 | MATERIA | id_materia | id_carrera | Académica |
| 8 | ASIGNACION | id_asignacion | id_materia, id_docente, id_aula, id_estudiante | Relación |
| 9 | TORRE | id_torre | — | Campus |
| 10 | PISO | id_piso | id_torre | Campus |
| 11 | AULA | id_aula | id_piso | Campus |
| 12 | UBICACION | id_ubicacion | id_aula | Campus |
| 13 | RUTA | id_ruta | id_estudiante, id_aula_origen, id_aula_destino | Navegación |
| 14 | CONSULTA | id_consulta | id_estudiante, id_aula | Trazabilidad |
| 15 | HISTORIAL | id_historial | id_estudiante, id_consulta | Trazabilidad |
| 16 | NOTIFICACION | id_notificacion | id_estudiante | Interacción |
| 17 | REPORTE_SOPORTE | id_reporte | id_estudiante | Soporte |

> **Total: 17 tablas** — todas derivadas del MER corregido (Mer.png)