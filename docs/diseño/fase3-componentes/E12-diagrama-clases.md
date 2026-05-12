# E12 — Diagrama de Clases

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

El diagrama de clases representa la estructura estática del sistema,
mostrando las clases, sus atributos, métodos y las relaciones entre ellas.
Está orientado a la implementación en Django (modelos).

---

## Clases del Sistema

### Clase: Rol
+---------------------------+
| Rol |
+---------------------------+
| - id_rol: int |
| - nombre_rol: str |
| - descripcion: str |
+---------------------------+
| + str(): str |
+---------------------------+


### Clase: Usuarios
+---------------------------+
| Usuarios |
+---------------------------+
| - id_usuario: int |
| - correo: str |
| - contrasena: str |
| - fecha_registro: date |
| - activo: bool |
| - rol: Rol |
+---------------------------+
| + str(): str |
| + is_active(): bool |
+---------------------------+


### Clase: Estudiante
+-------------------------------+
| Estudiante |
+-------------------------------+
| - id_estudiante: int |
| - nombre: str |
| - codigo_estudiantil: str |
| - semestre: int |
| - usuario: Usuarios |
| - carrera: Carrera |
+-------------------------------+
| + str(): str |
| + get_horario(): list |
| + get_historial(): list |
+-------------------------------+


### Clase: Administrador
+---------------------------+
| Administrador |
+---------------------------+
| - id_admin: int |
| - nombre: str |
| - cargo: str |
| - usuario: Usuarios |
+---------------------------+
| + str(): str |
+---------------------------+


### Clase: Carrera
+-------------------------------+
| Carrera |
+-------------------------------+
| - id_carrera: int |
| - nombre_carrera: str |
| - facultad: str |
| - duracion_semestres: int |
+-------------------------------+
| + str(): str |
| + get_materias(): list |
+-------------------------------+


### Clase: Docente
+---------------------------+
| Docente |
+---------------------------+
| - id_docente: int |
| - nombre: str |
| - correo: str |
| - departamento: str |
| - usuario: Usuarios |
+---------------------------+
| + str(): str |
| + get_asignaciones(): list|
| + get_horario(): list |
+---------------------------+


### Clase: Materia
+---------------------------+
| Materia |
+---------------------------+
| - id_materia: int |
| - nombre_materia: str |
| - codigo_materia: str |
| - creditos: int |
| - carrera: Carrera |
+---------------------------+
| + str(): str |
+---------------------------+


### Clase: Asignacion
+-------------------------------+
| Asignacion |
+-------------------------------+
| - id_asignacion: int |
| - dia_semana: str |
| - hora_inicio: time |
| - hora_fin: time |
| - materia: Materia |
| - docente: Docente |
| - aula: Aula |
| - estudiante: Estudiante |
+-------------------------------+
| + str(): str |
| + get_duracion(): int |
+-------------------------------+


### Clase: Torre
+---------------------------+
| Torre |
+---------------------------+
| - id_torre: int |
| - nombre_torre: str |
| - descripcion: str |
+---------------------------+
| + str(): str |
| + get_pisos(): list |
+---------------------------+


### Clase: Piso
+---------------------------+
| Piso |
+---------------------------+
| - id_piso: int |
| - numero_piso: int |
| - descripcion: str |
| - torre: Torre |
+---------------------------+
| + str(): str |
| + get_aulas(): list |
+---------------------------+


### Clase: Aula
+---------------------------+
| Aula |
+---------------------------+
| - id_aula: int |
| - codigo_aula: str |
| - capacidad: int |
| - tipo_aula: str |
| - disponible: bool |
| - piso: Piso |
+---------------------------+
| + str(): str |
| + get_ubicacion(): obj |
| + is_disponible(): bool |
+---------------------------+


### Clase: Ubicacion
+---------------------------+
| Ubicacion |
+---------------------------+
| - id_ubicacion: int |
| - coordenada_x: decimal |
| - coordenada_y: decimal |
| - referencia: str |
| - aula: Aula |
+---------------------------+
| + str(): str |
| + get_coordenadas(): tuple|
+---------------------------+


### Clase: Ruta
+-------------------------------+
| Ruta |
+-------------------------------+
| - id_ruta: int |
| - distancia_metros: decimal |
| - tiempo_minutos: int |
| - fecha_consulta: datetime |
| - estudiante: Estudiante |
| - aula_origen: Aula |
| - aula_destino: Aula |
+-------------------------------+
| + str(): str |
| + calcular_ruta(): dict |
+-------------------------------+


### Clase: Consulta
+---------------------------+
| Consulta |
+---------------------------+
| - id_consulta: int |
| - fecha_consulta: datetime|
| - tipo_consulta: str |
| - estudiante: Estudiante |
| - aula: Aula |
+---------------------------+
| + str(): str |
| + registrar(): bool |
+---------------------------+


### Clase: Historial
+---------------------------+
| Historial |
+---------------------------+
| - id_historial: int |
| - fecha_registro: datetime|
| - estudiante: Estudiante |
| - consulta: Consulta |
+---------------------------+
| + str(): str |
| + get_entradas(): list |
+---------------------------+


### Clase: Notificacion
+-------------------------------+
| Notificacion |
+-------------------------------+
| - id_notificacion: int |
| - titulo: str |
| - mensaje: str |
| - tipo: str |
| - leida: bool |
| - fecha_envio: datetime |
| - estudiante: Estudiante |
+-------------------------------+
| + str(): str |
| + marcar_leida(): bool |
+-------------------------------+


### Clase: ReporteSoporte
+-------------------------------+
| ReporteSoporte |
+-------------------------------+
| - id_reporte: int |
| - tipo_fallo: str |
| - descripcion: str |
| - estado: str |
| - fecha_reporte: datetime |
| - fecha_resolucion: datetime |
| - estudiante: Estudiante |
+-------------------------------+
| + str(): str |
| + cerrar_reporte(): bool |
+-------------------------------+


---

## Relaciones entre Clases

| Clase A | Relación | Clase B | Tipo |
|---|---|---|---|
| Rol | 1 — N | Usuarios | Asociación |
| Usuarios | 1 — 1 | Estudiante | Composición |
| Usuarios | 1 — 1 | Administrador | Composición |
| Usuarios | 1 — 1 | Docente | Composición |
| Carrera | 1 — N | Estudiante | Asociación |
| Carrera | 1 — N | Materia | Asociación |
| Docente | 1 — N | Asignacion | Asociación |
| Materia | 1 — N | Asignacion | Asociación |
| Aula | 1 — N | Asignacion | Asociación |
| Estudiante | 1 — N | Asignacion | Asociación |
| Torre | 1 — N | Piso | Composición |
| Piso | 1 — N | Aula | Composición |
| Aula | 1 — 1 | Ubicacion | Composición |
| Estudiante | 1 — N | Ruta | Asociación |
| Aula | 1 — N | Ruta | Asociación |
| Estudiante | 1 — N | Consulta | Asociación |
| Aula | 1 — N | Consulta | Asociación |
| Estudiante | 1 — N | Historial | Asociación |
| Consulta | 1 — N | Historial | Asociación |
| Estudiante | 1 — N | Notificacion | Asociación |
| Estudiante | 1 — N | ReporteSoporte | Asociación |

---

## Nota de Implementación en Django

> En Django, cada clase corresponde a un **Model** en `models.py`.
> Las relaciones se implementan con:
> - `ForeignKey` para relaciones 1:N
> - `OneToOneField` para relaciones 1:1
> - `ManyToManyField` para relaciones N:M