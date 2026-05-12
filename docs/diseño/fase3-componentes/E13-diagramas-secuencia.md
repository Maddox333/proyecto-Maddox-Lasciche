# E13 — Diagrama de Secuencia

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Escenario 1: Consulta de Ubicación de Aula

**Actor:** Estudiante  
**Objetivo:** El estudiante busca la ubicación de un aula en el mapa interactivo

Estudiante UI (Frontend) Vista (Django) Modelo (BD)
| | | |
|-- buscar aula -->| | |
| |-- GET /buscar -->| |
| | |-- query AULA --->|
| | |<-- resultado ----|
| | |-- query UBICACION|
| | |<-- coordenadas --|
| |<-- JSON response-| |
|<-- mapa + aula --| | |
| | | |
| | |-- INSERT CONSULTA|
| | |-- INSERT HISTORIAL
| | |<-- confirmación -|
| | | |


---

## Escenario 2: Cálculo de Ruta entre Aulas

**Actor:** Estudiante  
**Objetivo:** El estudiante calcula la ruta más corta entre dos aulas

Estudiante UI (Frontend) Vista (Django) Modelo (BD)
| | | |
|-- origen/destino>| | |
| |-- POST /ruta --->| |
| | |-- query AULA x2->|
| | |<-- aulas --------|
| | |-- query UBICACION|
| | |<-- coordenadas --|
| | | |
| | |[calcular ruta] |
| | |-- INSERT RUTA -->|
| | |<-- id_ruta ------|
| |<-- ruta + tiempo-| |
|<-- mapa animado--| | |
| | | |


---

## Escenario 3: Inicio de Sesión

**Actor:** Estudiante / Administrador  
**Objetivo:** El usuario inicia sesión en el sistema

Usuario UI (Frontend) Vista (Django) Modelo (BD)
| | | |
|-- correo/pass -->| | |
| |-- POST /login -->| |
| | |-- query USUARIOS>|
| | |<-- usuario ------|
| | |[validar password]|
| | |[verificar activo]|
| | |-- query ROL ---->|
| | |<-- rol ----------|
| |<-- token/sesión -| |
|<-- dashboard -----| | |
| | | |
| [si falla] | | |
| |<-- error 401 ----| |
|<-- msg error -----| | |


---

## Escenario 4: Consulta de Horario del Estudiante

**Actor:** Estudiante  
**Objetivo:** El estudiante consulta sus materias y aulas asignadas

Estudiante UI (Frontend) Vista (Django) Modelo (BD)
| | | |
|-- ver horario -->| | |
| |-- GET /horario ->| |
| | |-- query ASIGNACION
| | | (id_estudiante)|
| | |<-- asignaciones -|
| | |-- query MATERIA->|
| | |<-- materias -----|
| | |-- query AULA --->|
| | |<-- aulas --------|
| | |-- query DOCENTE->|
| | |<-- docentes -----|
| |<-- JSON horario -| |
|<-- tabla horario-| | |
| | | |


---

## Escenario 5: Reporte de Fallo por Estudiante

**Actor:** Estudiante  
**Objetivo:** El estudiante reporta un problema o fallo en el sistema

Estudiante UI (Frontend) Vista (Django) Modelo (BD)
| | | |
|-- llenar form -->| | |
| |-- POST /reporte->| |
| | |[validar datos] |
| | |-- INSERT REPORTE>|
| | |<-- id_reporte ---|
| | |-- INSERT NOTIF ->|
| | |<-- confirmación -|
| |<-- 201 Created --| |
|<-- msg éxito -----| | |
| | | |


---

## Escenario 6: Gestión de Aulas por Administrador

**Actor:** Administrador  
**Objetivo:** El administrador registra o actualiza una aula en el sistema

Administrador UI (Frontend) Vista (Django) Modelo (BD)
| | | |
|-- form aula ---->| | |
| |-- POST /aula --->| |
| | |[validar permisos]|
| | |-- INSERT AULA -->|
| | |<-- id_aula ------|
| | |-- INSERT UBICACION
| | |<-- confirmación -|
| |<-- 201 Created --| |
|<-- aula creada --| | |
| | | |


---

## Resumen de Escenarios

| # | Escenario | Actor | Tablas involucradas |
|---|---|---|---|
| 1 | Consulta de ubicación de aula | Estudiante | AULA, UBICACION, CONSULTA, HISTORIAL |
| 2 | Cálculo de ruta entre aulas | Estudiante | AULA, UBICACION, RUTA |
| 3 | Inicio de sesión | Estudiante / Admin | USUARIOS, ROL |
| 4 | Consulta de horario | Estudiante | ASIGNACION, MATERIA, AULA, DOCENTE |
| 5 | Reporte de fallo | Estudiante | REPORTE_SOPORTE, NOTIFICACION |
| 6 | Gestión de aulas | Administrador | AULA, UBICACION |