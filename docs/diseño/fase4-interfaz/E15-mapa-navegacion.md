# E15 — Mapa de Navegación

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

El mapa de navegación define los flujos de pantallas del sistema,
mostrando cómo se conectan las vistas según el rol del usuario.

---

## Flujo General del Sistema

                +------------------+
                |   PANTALLA DE    |
                |   BIENVENIDA     |
                +------------------+
                         |
                [iniciar sesión]
                         |
                +------------------+
                |   LOGIN          |
                +------------------+
                /         |         \
      [rol: estudiante] [rol: docente] [rol: admin]
            /              |               \
           v               v                v
+------------------+ +------------------+ +------------------+
| DASHBOARD | | DASHBOARD | | DASHBOARD |
| ESTUDIANTE | | DOCENTE | | ADMINISTRADOR |
+------------------+ +------------------+ +------------------+


---

## Flujo: Estudiante

+------------------+
| DASHBOARD |
| ESTUDIANTE |
+------------------+
| | | |
| | | |
v | | v
+------+ | | +----------+
| MAPA | | | | HORARIO |
| AULAS| | | | |
+------+ | | +----------+
| | | |
[buscar] | | [ver aula]
| v | |
| +------+| v
| |RUTAS || +----------+
| | || | DETALLE |
| +------+| | AULA |
| | +----------+
v v
+----------+ +----------+
| DETALLE | | HISTORIAL|
| UBICACION| | CONSULTAS|
+----------+ +----------+
\ /
\ /
v v
+----------+
|NOTIFICA- |
|CIONES |
+----------+
|
[reportar fallo]
|
v
+----------+
| REPORTE |
| SOPORTE |
+----------+


---

## Flujo: Docente

+------------------+
| DASHBOARD |
| DOCENTE |
+------------------+
| |
v v
+----------+ +----------+
| HORARIO | | MIS |
| PERSONAL | | AULAS |
+----------+ +----------+
| |
[ver detalle] [ver ubicacion]
| |
v v
+----------+ +----------+
| DETALLE | | MAPA |
| MATERIA | | AULAS |
+----------+ +----------+


---

## Flujo: Administrador

+------------------+
| DASHBOARD |
| ADMINISTRADOR |
+------------------+
| | | |
v v v v
+----+ +----+ +------+ +------+
|AULAS| |PISOS| |TORRES| |USERS|
+----+ +----+ +------+ +------+
| | |
[CRUD] [CRUD] [CRUD]
|
v
+----------+
| ASIGNAR |
| HORARIOS |
+----------+
|
v
+----------+
| REPORTES |
| SOPORTE |
+----------+
|
[gestionar]
|
v
+----------+
| DETALLE |
| REPORTE |
+----------+


---

## Pantallas del Sistema

### Pantallas Públicas
| # | Pantalla | Ruta | Descripción |
|---|---|---|---|
| P1 | Bienvenida | `/` | Pantalla inicial del sistema |
| P2 | Login | `/login` | Formulario de inicio de sesión |

### Pantallas de Estudiante
| # | Pantalla | Ruta | Descripción |
|---|---|---|---|
| E1 | Dashboard Estudiante | `/estudiante/dashboard` | Vista principal del estudiante |
| E2 | Mapa de Aulas | `/estudiante/mapa` | Mapa interactivo del campus |
| E3 | Búsqueda de Aula | `/estudiante/buscar` | Buscador de aulas por código o nombre |
| E4 | Detalle de Aula | `/estudiante/aula/<id>` | Información detallada de un aula |
| E5 | Ubicación de Aula | `/estudiante/ubicacion/<id>` | Coordenadas y referencia del aula |
| E6 | Cálculo de Ruta | `/estudiante/ruta` | Ruta entre aula origen y destino |
| E7 | Horario Personal | `/estudiante/horario` | Materias y aulas asignadas |
| E8 | Historial de Consultas | `/estudiante/historial` | Consultas realizadas anteriormente |
| E9 | Notificaciones | `/estudiante/notificaciones` | Notificaciones recibidas |
| E10 | Reporte de Soporte | `/estudiante/reporte` | Formulario para reportar fallos |

### Pantallas de Docente
| # | Pantalla | Ruta | Descripción |
|---|---|---|---|
| D1 | Dashboard Docente | `/docente/dashboard` | Vista principal del docente |
| D2 | Horario Personal | `/docente/horario` | Materias y aulas asignadas al docente |
| D3 | Mis Aulas | `/docente/aulas` | Lista de aulas donde imparte clases |
| D4 | Detalle de Aula | `/docente/aula/<id>` | Información detallada de un aula |
| D5 | Ubicación de Aula | `/docente/ubicacion/<id>` | Coordenadas y referencia del aula |
| D6 | Mapa de Aulas | `/docente/mapa` | Mapa interactivo del campus |

### Pantallas de Administrador
| # | Pantalla | Ruta | Descripción |
|---|---|---|---|
| A1 | Dashboard Admin | `/admin/dashboard` | Vista principal del administrador |
| A2 | Gestión de Torres | `/admin/torres` | CRUD de torres del campus |
| A3 | Gestión de Pisos | `/admin/pisos` | CRUD de pisos por torre |
| A4 | Gestión de Aulas | `/admin/aulas` | CRUD de aulas por piso |
| A5 | Gestión de Ubicaciones | `/admin/ubicaciones` | Asignación de coordenadas a aulas |
| A6 | Gestión de Carreras | `/admin/carreras` | CRUD de carreras académicas |
| A7 | Gestión de Materias | `/admin/materias` | CRUD de materias por carrera |
| A8 | Gestión de Docentes | `/admin/docentes` | CRUD de docentes |
| A9 | Gestión de Estudiantes | `/admin/estudiantes` | CRUD de estudiantes |
| A10 | Gestión de Asignaciones | `/admin/asignaciones` | Asignación de horarios |
| A11 | Gestión de Reportes | `/admin/reportes` | Revisión y gestión de reportes |
| A12 | Gestión de Notificaciones | `/admin/notificaciones` | Envío de notificaciones |

---

## Resumen de Navegación

| Rol | Pantallas | Acceso |
|---|---|---|
| Público | P1, P2 | Sin autenticación |
| Estudiante | E1 — E10 | Autenticación requerida |
| Docente | D1 — D6 | Autenticación + rol docente |
| Administrador | A1 — A12 | Autenticación + rol admin |