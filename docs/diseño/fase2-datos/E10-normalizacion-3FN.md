# E10 — Normalización en Tercera Forma Normal (3FN)

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Definiciones

| Forma Normal | Condición |
|---|---|
| **1FN** | Todos los atributos son atómicos, no hay grupos repetitivos ni atributos multivaluados |
| **2FN** | Cumple 1FN + todos los atributos no clave dependen completamente de la PK (sin dependencias parciales) |
| **3FN** | Cumple 2FN + no existen dependencias transitivas (atributo no clave que depende de otro atributo no clave) |

---

## Análisis por Tabla

### ROL
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| nombre_rol | id_rol | Completa ✅ |
| descripcion | id_rol | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**  
No hay dependencias parciales ni transitivas.

---

### USUARIOS
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| correo | id_usuario | Completa ✅ |
| contrasena | id_usuario | Completa ✅ |
| fecha_registro | id_usuario | Completa ✅ |
| activo | id_usuario | Completa ✅ |
| id_rol | id_usuario | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**  
`id_rol` es FK, no genera dependencia transitiva porque no determina otros atributos de la tabla.

---

### ESTUDIANTE
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| nombre | id_estudiante | Completa ✅ |
| codigo_estudiantil | id_estudiante | Completa ✅ |
| semestre | id_estudiante | Completa ✅ |
| id_usuario | id_estudiante | Completa ✅ |
| id_carrera | id_estudiante | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**  
Las FKs no generan dependencias transitivas.

---

### ADMINISTRADOR
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| nombre | id_admin | Completa ✅ |
| cargo | id_admin | Completa ✅ |
| id_usuario | id_admin | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

### CARRERA
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| nombre_carrera | id_carrera | Completa ✅ |
| facultad | id_carrera | Completa ✅ |
| duracion_semestres | id_carrera | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

### DOCENTE
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| nombre | id_docente | Completa ✅ |
| correo | id_docente | Completa ✅ |
| departamento | id_docente | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

### MATERIA
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| nombre_materia | id_materia | Completa ✅ |
| codigo_materia | id_materia | Completa ✅ |
| creditos | id_materia | Completa ✅ |
| id_carrera | id_materia | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

### ASIGNACION
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| dia_semana | id_asignacion | Completa ✅ |
| hora_inicio | id_asignacion | Completa ✅ |
| hora_fin | id_asignacion | Completa ✅ |
| id_materia | id_asignacion | Completa ✅ |
| id_docente | id_asignacion | Completa ✅ |
| id_aula | id_asignacion | Completa ✅ |
| id_estudiante | id_asignacion | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**  
La PK es simple (id_asignacion), por lo tanto no puede haber dependencias parciales.
Todas las FKs dependen directamente de la PK.

---

### TORRE
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| nombre_torre | id_torre | Completa ✅ |
| descripcion | id_torre | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

### PISO
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| numero_piso | id_piso | Completa ✅ |
| descripcion | id_piso | Completa ✅ |
| id_torre | id_piso | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

### AULA
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| codigo_aula | id_aula | Completa ✅ |
| capacidad | id_aula | Completa ✅ |
| tipo_aula | id_aula | Completa ✅ |
| disponible | id_aula | Completa ✅ |
| id_piso | id_aula | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

### UBICACION
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| coordenada_x | id_ubicacion | Completa ✅ |
| coordenada_y | id_ubicacion | Completa ✅ |
| referencia | id_ubicacion | Completa ✅ |
| id_aula | id_ubicacion | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

### RUTA
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| distancia_metros | id_ruta | Completa ✅ |
| tiempo_minutos | id_ruta | Completa ✅ |
| fecha_consulta | id_ruta | Completa ✅ |
| id_estudiante | id_ruta | Completa ✅ |
| id_aula_origen | id_ruta | Completa ✅ |
| id_aula_destino | id_ruta | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

### CONSULTA
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| fecha_consulta | id_consulta | Completa ✅ |
| tipo_consulta | id_consulta | Completa ✅ |
| id_estudiante | id_consulta | Completa ✅ |
| id_aula | id_consulta | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

### HISTORIAL
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| fecha_registro | id_historial | Completa ✅ |
| id_estudiante | id_historial | Completa ✅ |
| id_consulta | id_historial | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

### NOTIFICACION
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| titulo | id_notificacion | Completa ✅ |
| mensaje | id_notificacion | Completa ✅ |
| tipo | id_notificacion | Completa ✅ |
| leida | id_notificacion | Completa ✅ |
| fecha_envio | id_notificacion | Completa ✅ |
| id_estudiante | id_notificacion | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

### REPORTE_SOPORTE
| Atributo | Depende de | Tipo de dependencia |
|---|---|---|
| tipo_fallo | id_reporte | Completa ✅ |
| descripcion | id_reporte | Completa ✅ |
| estado | id_reporte | Completa ✅ |
| fecha_reporte | id_reporte | Completa ✅ |
| fecha_resolucion | id_reporte | Completa ✅ |
| id_estudiante | id_reporte | Completa ✅ |

**✅ Cumple 1FN, 2FN y 3FN**

---

## Resumen de Normalización

| Tabla | 1FN | 2FN | 3FN |
|---|---|---|---|
| ROL | ✅ | ✅ | ✅ |
| USUARIOS | ✅ | ✅ | ✅ |
| ESTUDIANTE | ✅ | ✅ | ✅ |
| ADMINISTRADOR | ✅ | ✅ | ✅ |
| CARRERA | ✅ | ✅ | ✅ |
| DOCENTE | ✅ | ✅ | ✅ |
| MATERIA | ✅ | ✅ | ✅ |
| ASIGNACION | ✅ | ✅ | ✅ |
| TORRE | ✅ | ✅ | ✅ |
| PISO | ✅ | ✅ | ✅ |
| AULA | ✅ | ✅ | ✅ |
| UBICACION | ✅ | ✅ | ✅ |
| RUTA | ✅ | ✅ | ✅ |
| CONSULTA | ✅ | ✅ | ✅ |
| HISTORIAL | ✅ | ✅ | ✅ |
| NOTIFICACION | ✅ | ✅ | ✅ |
| REPORTE_SOPORTE | ✅ | ✅ | ✅ |

> **Conclusión:** Las 17 tablas del modelo relacional del SIGAU cumplen
> con la Tercera Forma Normal (3FN), garantizando eliminación de
> redundancias, integridad referencial y consistencia de datos.