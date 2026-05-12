# M10 — Matriz de Trazabilidad: Secuencias, Actores y Requisitos Funcionales

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona los diagramas de secuencia con los actores
involucrados y los Requisitos Funcionales que cada secuencia cubre,
verificando que todos los flujos del sistema están documentados.

---

## Actores del Sistema

| ID | Actor | Rol | Descripción |
|---|---|---|---|
| A1 | Estudiante | Usuario final | Consulta aulas, horarios y reporta fallos |
| A2 | Docente | Usuario final | Consulta su horario y aulas asignadas |
| A3 | Administrador | Gestor | Gestiona aulas, usuarios y asignaciones |
| A4 | Sistema SIGAU | Sistema | Procesa lógica de negocio y responde |
| A5 | Base de Datos | Componente | Persiste y retorna datos |

---

## Matriz Principal: Secuencias — Actores — RF

| # | Diagrama de Secuencia | Actores | RF Cubierto | Flujo Principal |
|---|---|---|---|---|
| DS-01 | Autenticación de usuario | A1/A2/A3, A4, A5 | RF-01 | Login → validar credenciales → sesión |
| DS-02 | Búsqueda de aula por código | A1, A4, A5 | RF-03 | Ingresar código → buscar → mostrar resultado |
| DS-03 | Consulta de horario (estudiante) | A1, A4, A5 | RF-04 | Solicitar horario → filtrar por carrera → mostrar |
| DS-04 | Historial de consultas | A1, A4, A5 | RF-05 | Solicitar historial → filtrar → mostrar lista |
| DS-05 | Consulta de horario (docente) | A2, A4, A5 | RF-06 | Solicitar horario → filtrar por docente → mostrar |
| DS-06 | Consulta de aulas asignadas | A2, A4, A5 | RF-07 | Solicitar aulas → filtrar por docente → mostrar |
| DS-07 | Gestión de aulas (CRUD) | A3, A4, A5 | RF-08 | Seleccionar acción → validar → persistir |
| DS-08 | Gestión de usuarios (CRUD) | A3, A4, A5 | RF-09 | Seleccionar acción → validar → persistir |
| DS-09 | Gestión de asignaciones | A3, A4, A5 | RF-10 | Crear asignación → validar solapamiento → guardar |
| DS-10 | Visualización del mapa | A1/A2, A4, A5 | RF-11 | Abrir mapa → cargar ubicaciones → renderizar |
| DS-11 | Cálculo de ruta | A1, A4, A5 | RF-12 | Seleccionar destino → calcular ruta → mostrar |
| DS-12 | Registro automático de consulta | A1, A4, A5 | RF-13 | Buscar aula → registrar consulta automáticamente |
| DS-13 | Envío de notificación | A3, A4, A5 | RF-14 | Crear notificación → enviar → marcar estado |
| DS-14 | Reporte de fallo de aula | A1, A4, A5 | RF-15 | Reportar fallo → guardar → notificar admin |
| DS-15 | Gestión de reportes de soporte | A3, A4, A5 | RF-16 | Listar reportes → actualizar estado → notificar |

---

## Detalle de Secuencias

### DS-01 — Autenticación de Usuario
**RF:** RF-01 | **Actores:** Estudiante/Docente/Administrador, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A1/A2/A3 | Ingresa correo y contraseña | — |
| 2 | A4 | Valida formato de credenciales | — |
| 3 | A4 | Consulta usuario en BD | — |
| 4 | A5 | Retorna datos del usuario | — |
| 5 | A4 | Verifica contraseña cifrada | — |
| 6 | A4 | Crea sesión y asigna rol | — |
| 7 | A4 | Redirige al dashboard según rol | Dashboard |

**Flujo alternativo:** Credenciales incorrectas → mensaje de error → reintentar (máx. 3 veces)

---

### DS-02 — Búsqueda de Aula por Código
**RF:** RF-03 | **Actores:** Estudiante, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A1 | Ingresa código de aula | — |
| 2 | A4 | Valida formato del código | — |
| 3 | A4 | Consulta aula en BD | — |
| 4 | A5 | Retorna datos del aula | — |
| 5 | A4 | Registra consulta automáticamente | — |
| 6 | A4 | Muestra información del aula | Ficha del aula |

**Flujo alternativo:** Aula no encontrada → mensaje "Aula no existe"

---

### DS-03 — Consulta de Horario (Estudiante)
**RF:** RF-04 | **Actores:** Estudiante, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A1 | Solicita ver su horario | — |
| 2 | A4 | Obtiene carrera del estudiante | — |
| 3 | A4 | Consulta asignaciones por carrera | — |
| 4 | A5 | Retorna lista de asignaciones | — |
| 5 | A4 | Organiza por día y hora | — |
| 6 | A4 | Muestra horario semanal | Tabla de horario |

---

### DS-04 — Historial de Consultas
**RF:** RF-05 | **Actores:** Estudiante, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A1 | Solicita ver historial | — |
| 2 | A4 | Consulta historial del estudiante | — |
| 3 | A5 | Retorna lista de consultas | — |
| 4 | A4 | Ordena por fecha descendente | — |
| 5 | A4 | Muestra historial paginado | Lista de consultas |

---

### DS-05 — Consulta de Horario (Docente)
**RF:** RF-06 | **Actores:** Docente, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A2 | Solicita ver su horario | — |
| 2 | A4 | Consulta asignaciones del docente | — |
| 3 | A5 | Retorna lista de asignaciones | — |
| 4 | A4 | Organiza por día y hora | — |
| 5 | A4 | Muestra horario con aulas | Tabla de horario |

---

### DS-06 — Consulta de Aulas Asignadas (Docente)
**RF:** RF-07 | **Actores:** Docente, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A2 | Solicita ver sus aulas | — |
| 2 | A4 | Consulta aulas por docente | — |
| 3 | A5 | Retorna lista de aulas | — |
| 4 | A4 | Muestra aulas con ubicación | Lista de aulas |

---

### DS-07 — Gestión de Aulas (CRUD)
**RF:** RF-08 | **Actores:** Administrador, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A3 | Selecciona acción (crear/editar/eliminar) | — |
| 2 | A3 | Completa formulario con datos | — |
| 3 | A4 | Valida datos ingresados | — |
| 4 | A4 | Ejecuta operación en BD | — |
| 5 | A5 | Confirma operación | — |
| 6 | A4 | Muestra confirmación | Mensaje de éxito |

**Flujo alternativo:** Datos inválidos → mensaje de error → corregir

---

### DS-08 — Gestión de Usuarios (CRUD)
**RF:** RF-09 | **Actores:** Administrador, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A3 | Selecciona tipo de usuario y acción | — |
| 2 | A3 | Completa formulario | — |
| 3 | A4 | Valida datos y unicidad de correo | — |
| 4 | A4 | Asigna rol correspondiente | — |
| 5 | A4 | Persiste en BD | — |
| 6 | A4 | Muestra confirmación | Mensaje de éxito |

---

### DS-09 — Gestión de Asignaciones
**RF:** RF-10 | **Actores:** Administrador, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A3 | Selecciona docente, materia, aula y horario | — |
| 2 | A4 | Valida solapamiento de aula y horario | — |
| 3 | A4 | Si no hay solapamiento → guarda asignación | — |
| 4 | A5 | Confirma inserción | — |
| 5 | A4 | Muestra confirmación | Asignación creada |

**Flujo alternativo:** Solapamiento detectado → error "Aula ocupada en ese horario"

---

### DS-10 — Visualización del Mapa
**RF:** RF-11 | **Actores:** Estudiante/Docente, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A1/A2 | Accede al módulo de mapa | — |
| 2 | A4 | Consulta todas las ubicaciones | — |
| 3 | A5 | Retorna coordenadas de aulas | — |
| 4 | A4 | Renderiza mapa con marcadores | — |
| 5 | A1/A2 | Interactúa con el mapa | Mapa interactivo |

---

### DS-11 — Cálculo de Ruta
**RF:** RF-12 | **Actores:** Estudiante, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A1 | Selecciona aula destino en el mapa | — |
| 2 | A4 | Obtiene ubicación del aula destino | — |
| 3 | A4 | Obtiene ubicación actual del usuario | — |
| 4 | A4 | Calcula ruta entre puntos | — |
| 5 | A4 | Muestra ruta en el mapa | Ruta trazada |

---

### DS-12 — Registro Automático de Consulta
**RF:** RF-13 | **Actores:** Estudiante, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A1 | Realiza búsqueda de aula | — |
| 2 | A4 | Procesa búsqueda | — |
| 3 | A4 | Registra consulta automáticamente | — |
| 4 | A5 | Confirma registro | — |
| 5 | A4 | Retorna resultado al estudiante | Resultado de búsqueda |

---

### DS-13 — Envío de Notificación
**RF:** RF-14 | **Actores:** Administrador, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A3 | Redacta notificación y selecciona destinatario | — |
| 2 | A4 | Valida datos de la notificación | — |
| 3 | A4 | Crea registro en BD con estado ENVIADA | — |
| 4 | A5 | Confirma inserción | — |
| 5 | A4 | Notificación disponible para el usuario | Notificación enviada |

---

### DS-14 — Reporte de Fallo de Aula
**RF:** RF-15 | **Actores:** Estudiante, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A1 | Selecciona aula y describe el fallo | — |
| 2 | A4 | Valida datos del reporte | — |
| 3 | A4 | Crea reporte con estado PENDIENTE | — |
| 4 | A5 | Confirma inserción | — |
| 5 | A4 | Notifica al administrador | Reporte enviado |

---

### DS-15 — Gestión de Reportes de Soporte
**RF:** RF-16 | **Actores:** Administrador, Sistema, BD

| Paso | Actor | Acción | Respuesta |
|---|---|---|---|
| 1 | A3 | Accede a lista de reportes | — |
| 2 | A4 | Consulta reportes en BD | — |
| 3 | A5 | Retorna lista de reportes | — |
| 4 | A3 | Selecciona reporte y actualiza estado | — |
| 5 | A4 | Persiste nuevo estado | — |
| 6 | A4 | Notifica al estudiante | Estado actualizado |

---

## Cobertura de RF por Secuencia

| RF | DS cubridor | Actor principal | Estado |
|---|---|---|---|
| RF-01 Autenticación | DS-01 | A1/A2/A3 | ✅ |
| RF-02 Control acceso | DS-01 (implícito en rol) | A4 | ✅ |
| RF-03 Buscar aula | DS-02 | A1 | ✅ |
| RF-04 Horario estudiante | DS-03 | A1 | ✅ |
| RF-05 Historial | DS-04 | A1 | ✅ |
| RF-06 Horario docente | DS-05 | A2 | ✅ |
| RF-07 Aulas docente | DS-06 | A2 | ✅ |
| RF-08 Gestionar aulas | DS-07 | A3 | ✅ |
| RF-09 Gestionar usuarios | DS-08 | A3 | ✅ |
| RF-10 Asignaciones | DS-09 | A3 | ✅ |
| RF-11 Mapa interactivo | DS-10 | A1/A2 | ✅ |
| RF-12 Calcular ruta | DS-11 | A1 | ✅ |
| RF-13 Registrar consulta | DS-12 | A1 | ✅ |
| RF-14 Notificaciones | DS-13 | A3 | ✅ |
| RF-15 Reportar fallo | DS-14 | A1 | ✅ |
| RF-16 Gestionar reportes | DS-15 | A3 | ✅ |

**Cobertura total: 16/16 RF cubiertos — 100% ✅**

---

## Resumen

| Criterio | Resultado |
|---|---|
| Total diagramas de secuencia | 15 |
| Total actores involucrados | 5 |
| RF cubiertos | 16/16 |
| Flujos alternativos documentados | 4 |
| Cobertura total | 100% ✅ |