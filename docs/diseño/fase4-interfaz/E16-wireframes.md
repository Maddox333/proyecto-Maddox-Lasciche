# E16 — Wireframes

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Los wireframes representan el esquema visual de las pantallas principales
del sistema, mostrando la disposición de los elementos de interfaz sin
estilos visuales definitivos.

---

## WF-P1: Pantalla de Bienvenida

+--------------------------------------------------+
| SIGAU |
| Sistema de Gestión Académica |
+--------------------------------------------------+
| |
| |
| [LOGO UNIVERSIDAD] |
| |
| Bienvenido al Sistema SIGAU |
| Gestión y navegación de aulas universitarias |
| |
| [ INICIAR SESIÓN ] |
| |
| |
+--------------------------------------------------+
| © 2025 SIGAU — Universidad |
+--------------------------------------------------+


---

## WF-P2: Login

+--------------------------------------------------+
| SIGAU |
+--------------------------------------------------+
| |
| Iniciar Sesión |
| |
| Correo electrónico: |
| +------------------------------------------+ |
| | | |
| +------------------------------------------+ |
| |
| Contraseña: |
| +------------------------------------------+ |
| | | |
| +------------------------------------------+ |
| |
| [ INGRESAR ] |
| |
| ¿Olvidaste tu contraseña? |
| |
+--------------------------------------------------+


---

## WF-E1: Dashboard Estudiante

+--------------------------------------------------+
| SIGAU | Dashboard [🔔 Notif] [👤 Nombre] |
+--------------------------------------------------+
| [🗺 Mapa] [📅 Horario] [📋 Historial] [⚙ Config]|
+--------------------------------------------------+
| |
| Bienvenido, [Nombre Estudiante] |
| Carrera: [Nombre Carrera] | Semestre: [N] |
| |
| +------------------+ +------------------+ |
| | 🗺 Buscar Aula | | 📅 Mi Horario | |
| | Encuentra tu | | Ver materias y | |
| | aula en el mapa | | aulas asignadas | |
| | [ IR AL MAPA ] | | [ VER HORARIO ] | |
| +------------------+ +------------------+ |
| |
| +------------------+ +------------------+ |
| | 🔀 Calcular Ruta | | 📋 Historial | |
| | Ruta entre dos | | Consultas | |
| | aulas del campus | | anteriores | |
| | [ CALCULAR ] | | [ VER HISTORIAL]| |
| +------------------+ +------------------+ |
| |
| Últimas notificaciones: |
| • [Notificación 1] [Ver →] |
| • [Notificación 2] [Ver →] |
| |
+--------------------------------------------------+


---

## WF-E2: Mapa de Aulas

+--------------------------------------------------+
| SIGAU | Mapa de Aulas [👤 Nombre] |
+--------------------------------------------------+
| [← Volver] |
+--------------------------------------------------+
| Buscar aula: |
| +--------------------------------------+ [🔍] |
| | Código o nombre del aula... | |
| +--------------------------------------+ |
| |
| +--------------------------------------------+ |
| | | |
| | | |
| | MAPA INTERACTIVO | |
| | DEL CAMPUS | |
| | | |
| | [Torre A] [Torre B] | |
| | • • | |
| | [Torre C] [Torre D] | |
| | • • | |
| | | |
| +--------------------------------------------+ |
| |
| Filtrar por: [Torre ▼] [Piso ▼] [Tipo ▼] |
| |
+--------------------------------------------------+


---

## WF-E3: Detalle de Aula

+--------------------------------------------------+
| SIGAU | Detalle de Aula [👤 Nombre] |
+--------------------------------------------------+
| [← Volver al mapa] |
+--------------------------------------------------+
| |
| Aula: [CODIGO_AULA] |
| +--------------------------+ |
| | Torre: [Nombre] | |
| | Piso: [N] | |
| | Capacidad: [N] personas | |
| | Tipo: [Tipo aula] | |
| | Estado: ✅ Disponible| |
| +--------------------------+ |
| |
| Ubicación en el mapa: |
| +--------------------------------------------+ |
| | | |
| | [Mini mapa con pin 📍] | |
| | | |
| +--------------------------------------------+ |
| |
| [ 🔀 CALCULAR RUTA HASTA AQUÍ ] |
| |
+--------------------------------------------------+


---

## WF-E4: Cálculo de Ruta

+--------------------------------------------------+
| SIGAU | Calcular Ruta [👤 Nombre] |
+--------------------------------------------------+
| [← Volver] |
+--------------------------------------------------+
| |
| Aula de origen: |
| +------------------------------------------+ |
| | Seleccionar aula... ▼ | |
| +------------------------------------------+ |
| |
| Aula de destino: |
| +------------------------------------------+ |
| | Seleccionar aula... ▼ | |
| +------------------------------------------+ |
| |
| [ CALCULAR RUTA ] |
| |
| Resultado: |
| +--------------------------------------------+ |
| | 📍 Origen: [Aula A] | |
| | 📍 Destino: [Aula B] | |
| | 📏 Distancia: [X] metros | |
| | ⏱ Tiempo estimado: [X] minutos | |
| | | |
| | [Mapa con ruta animada] | |
| | | |
| +--------------------------------------------+ |
| |
+--------------------------------------------------+


---

## WF-E5: Horario Personal (Estudiante)

+--------------------------------------------------+
| SIGAU | Mi Horario [👤 Nombre] |
+--------------------------------------------------+
| [← Volver] |
+--------------------------------------------------+
| |
| Semestre actual: [N] | Carrera: [Nombre] |
| |
| +--------+----------+----------+----------+ |
| | Hora | Lunes | Martes | Miércoles| |
| +--------+----------+----------+----------+ |
| | 07:00 | [Materia]| | [Materia]| |
| | | [Aula] | | [Aula] | |
| +--------+----------+----------+----------+ |
| | 09:00 | | [Materia]| | |
| | | | [Aula] | | |
| +--------+----------+----------+----------+ |
| | 11:00 | [Materia]| | | |
| | | [Aula] | | | |
| +--------+----------+----------+----------+ |
| |
| [Ver Jueves] [Ver Viernes] |
| |
| [ 🗺 VER AULA EN EL MAPA ] |
| |
+--------------------------------------------------+


---

## WF-D1: Dashboard Docente

+--------------------------------------------------+
| SIGAU | Dashboard Docente [👤 Nombre] |
+--------------------------------------------------+
| [📅 Horario] [🏫 Mis Aulas] [🗺 Mapa] [⚙ Config]|
+--------------------------------------------------+
| |
| Bienvenido, Prof. [Nombre Docente] |
| Departamento: [Nombre Departamento] |
| |
| +------------------+ +------------------+ |
| | 📅 Mi Horario | | 🏫 Mis Aulas | |
| | Ver materias y | | Aulas donde | |
| | aulas asignadas | | imparto clases | |
| | [ VER HORARIO ] | | [ VER AULAS ] | |
| +------------------+ +------------------+ |
| |
| +------------------+ |
| | 🗺 Mapa Campus | |
| | Navegar el mapa | |
| | interactivo | |
| | [ VER MAPA ] | |
| +------------------+ |
| |
| Próxima clase: |
| • [Materia] — [Aula] — [Hora] [Ver →] |
| |
+--------------------------------------------------+


---

## WF-D2: Horario Personal (Docente)

+--------------------------------------------------+
| SIGAU | Mi Horario [👤 Nombre] |
+--------------------------------------------------+
| [← Volver] |
+--------------------------------------------------+
| |
| Docente: [Nombre] | Departamento: [Nombre] |
| |
| +--------+----------+----------+----------+ |
| | Hora | Lunes | Martes | Miércoles| |
| +--------+----------+----------+----------+ |
| | 07:00 | [Materia]| | [Materia]| |
| | | [Aula] | | [Aula] | |
| +--------+----------+----------+----------+ |
| | 09:00 | | [Materia]| | |
| | | | [Aula] | | |
| +--------+----------+----------+----------+ |
| | 11:00 | [Materia]| | | |
| | | [Aula] | | | |
| +--------+----------+----------+----------+ |
| |
| [Ver Jueves] [Ver Viernes] |
| |
| [ 🗺 VER AULA EN EL MAPA ] |
| |
+--------------------------------------------------+


---

## WF-A1: Dashboard Administrador

+--------------------------------------------------+
| SIGAU | Panel Admin [👤 Admin] |
+--------------------------------------------------+
| [🏫 Aulas] [👥 Usuarios] [📋 Reportes] [⚙ Config]|
+--------------------------------------------------+
| |
| Panel de Administración |
| |
| +----------+ +----------+ +----------+ |
| | 🏫 Aulas | | 👥 Users | | 📋 Rep. | |
| | Total: | | Total: | | Abiertos:| |
| | [N] | | [N] | | [N] | |
| +----------+ +----------+ +----------+ |
| |
| Gestión rápida: |
| [ + Nueva Aula ] [ + Nueva Asignación ] |
| [ + Nuevo Usuario ] [ + Notificación ] |
| |
| Reportes pendientes: |
| • [Reporte 1] — [Estado] [Ver →] |
| • [Reporte 2] — [Estado] [Ver →] |
| • [Reporte 3] — [Estado] [Ver →] |
| |
+--------------------------------------------------+


---

## Resumen de Wireframes

| Código | Pantalla | Rol |
|---|---|---|
| WF-P1 | Bienvenida | Público |
| WF-P2 | Login | Público |
| WF-E1 | Dashboard Estudiante | Estudiante |
| WF-E2 | Mapa de Aulas | Estudiante |
| WF-E3 | Detalle de Aula | Estudiante |
| WF-E4 | Cálculo de Ruta | Estudiante |
| WF-E5 | Horario Personal | Estudiante |
| WF-D1 | Dashboard Docente | Docente |
| WF-D2 | Horario Personal | Docente |
| WF-A1 | Dashboard Administrador | Administrador |