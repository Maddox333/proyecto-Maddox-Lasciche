# M1 — Matriz de Trazabilidad: Entidades, Requisitos Funcionales, Casos de Uso y DCA

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona las entidades del sistema con los Requisitos
Funcionales (RF), los Casos de Uso (CU) y el Diagrama de Contexto
Arquitectural (DCA), permitiendo verificar que cada entidad está
correctamente cubierta por los artefactos de diseño.

---

## Matriz Principal

| Entidad | RF Relacionados | Casos de Uso | DCA (Actor/Sistema) |
|---|---|---|---|
| USUARIOS | RF-01, RF-02 | CU-01 Iniciar Sesión, CU-02 Cerrar Sesión | Actor: Estudiante, Docente, Administrador |
| ROL | RF-01, RF-02 | CU-01 Iniciar Sesión | Sistema: Control de Acceso |
| ESTUDIANTE | RF-03, RF-04, RF-05 | CU-03 Buscar Aula, CU-04 Ver Horario, CU-05 Ver Historial | Actor: Estudiante |
| DOCENTE | RF-06, RF-07 | CU-06 Ver Horario Docente, CU-07 Ver Mis Aulas | Actor: Docente |
| ADMINISTRADOR | RF-08, RF-09, RF-10 | CU-08 Gestionar Aulas, CU-09 Gestionar Usuarios, CU-10 Gestionar Reportes | Actor: Administrador |
| CARRERA | RF-03, RF-04 | CU-04 Ver Horario, CU-03 Buscar Aula | Sistema: Gestión Académica |
| MATERIA | RF-04, RF-06 | CU-04 Ver Horario, CU-06 Ver Horario Docente | Sistema: Gestión Académica |
| ASIGNACION | RF-04, RF-06, RF-10 | CU-04 Ver Horario, CU-06 Ver Horario Docente, CU-10 Gestionar Asignaciones | Sistema: Gestión Académica |
| TORRE | RF-08, RF-11 | CU-08 Gestionar Aulas, CU-11 Ver Mapa | Sistema: Gestión de Infraestructura |
| PISO | RF-08, RF-11 | CU-08 Gestionar Aulas, CU-11 Ver Mapa | Sistema: Gestión de Infraestructura |
| AULA | RF-03, RF-08, RF-11 | CU-03 Buscar Aula, CU-08 Gestionar Aulas, CU-11 Ver Mapa | Sistema: Gestión de Infraestructura |
| UBICACION | RF-11, RF-12 | CU-11 Ver Mapa, CU-12 Calcular Ruta | Sistema: Mapa Interactivo |
| CONSULTA | RF-05, RF-13 | CU-05 Ver Historial, CU-13 Registrar Consulta | Sistema: Historial |
| NOTIFICACION | RF-14 | CU-14 Enviar Notificación, CU-15 Ver Notificaciones | Sistema: Notificaciones |
| REPORTE_SOPORTE | RF-15, RF-16 | CU-16 Reportar Fallo, CU-17 Gestionar Reportes | Sistema: Soporte |
| HORARIO | RF-04, RF-06 | CU-04 Ver Horario, CU-06 Ver Horario Docente | Sistema: Gestión Académica |

---

## Requisitos Funcionales Referenciados

| Código | Descripción |
|---|---|
| RF-01 | El sistema debe permitir autenticación de usuarios por correo y contraseña |
| RF-02 | El sistema debe controlar el acceso según el rol del usuario |
| RF-03 | El sistema debe permitir buscar aulas por código o nombre |
| RF-04 | El sistema debe mostrar el horario personal del estudiante |
| RF-05 | El sistema debe registrar y mostrar el historial de consultas |
| RF-06 | El sistema debe mostrar el horario personal del docente |
| RF-07 | El sistema debe mostrar las aulas asignadas al docente |
| RF-08 | El sistema debe permitir al administrador gestionar aulas, pisos y torres |
| RF-09 | El sistema debe permitir al administrador gestionar usuarios |
| RF-10 | El sistema debe permitir al administrador gestionar asignaciones de horarios |
| RF-11 | El sistema debe mostrar un mapa interactivo del campus |
| RF-12 | El sistema debe calcular rutas entre dos aulas del campus |
| RF-13 | El sistema debe registrar cada consulta realizada por un estudiante |
| RF-14 | El sistema debe permitir enviar y recibir notificaciones |
| RF-15 | El sistema debe permitir reportar fallos en la información de aulas |
| RF-16 | El sistema debe permitir al administrador gestionar los reportes de soporte |

---

## Casos de Uso Referenciados

| Código | Caso de Uso | Actor Principal |
|---|---|---|
| CU-01 | Iniciar Sesión | Estudiante, Docente, Administrador |
| CU-02 | Cerrar Sesión | Estudiante, Docente, Administrador |
| CU-03 | Buscar Aula | Estudiante |
| CU-04 | Ver Horario Personal | Estudiante |
| CU-05 | Ver Historial de Consultas | Estudiante |
| CU-06 | Ver Horario Personal | Docente |
| CU-07 | Ver Mis Aulas | Docente |
| CU-08 | Gestionar Aulas | Administrador |
| CU-09 | Gestionar Usuarios | Administrador |
| CU-10 | Gestionar Asignaciones | Administrador |
| CU-11 | Ver Mapa Interactivo | Estudiante, Docente |
| CU-12 | Calcular Ruta | Estudiante |
| CU-13 | Registrar Consulta | Sistema |
| CU-14 | Enviar Notificación | Administrador |
| CU-15 | Ver Notificaciones | Estudiante |
| CU-16 | Reportar Fallo | Estudiante |
| CU-17 | Gestionar Reportes | Administrador |

---

## Cobertura de Entidades

| Entidad | Tiene RF | Tiene CU | Aparece en DCA | Cobertura |
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