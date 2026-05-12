# M3 — Matriz de Trazabilidad: Componentes, Arquetipos y Requisitos Funcionales

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona los componentes del sistema (módulos del backend
Node.js/Express y de la SPA React) con los arquetipos arquitecturales y
los Requisitos Funcionales (RF),
verificando que cada componente tiene una justificación arquitectural
y un requisito que lo respalda.

---

## Componentes del Sistema

| # | Componente | Tipo | Descripción |
|---|---|---|---|
| C1 | autenticacion | Módulo backend + React | Login, logout y control de acceso por rol (JWT + middleware Express + rutas protegidas en React Router) |
| C2 | usuarios | Módulo backend + React | Gestión de usuarios, estudiantes, docentes y administradores |
| C3 | infraestructura | Módulo backend + React | Gestión de torres, pisos y aulas |
| C4 | academico | Módulo backend + React | Gestión de carreras, materias, horarios y asignaciones |
| C5 | mapa | Módulo backend + React | Mapa interactivo (react-leaflet), ubicaciones y cálculo de rutas |
| C6 | consultas | Módulo backend + React | Registro y visualización del historial de consultas |
| C7 | notificaciones | Módulo backend + React | Envío y recepción de notificaciones |
| C8 | soporte | Módulo backend + React | Reporte y gestión de fallos |
| C9 | core | Módulo backend + React | Configuración base (Express app, layout React, utilidades compartidas) |

---

## Matriz Principal

| Componente | Arquetipos | Requisitos Funcionales |
|---|---|---|
| C1 — autenticacion | A1, A2, A5, A6 | RF-01, RF-02 |
| C2 — usuarios | A1, A3, A4, A5, A6 | RF-02, RF-09 |
| C3 — infraestructura | A3, A4, A5, A6 | RF-08, RF-11 |
| C4 — academico | A3, A4, A5, A6 | RF-04, RF-06, RF-07, RF-10 |
| C5 — mapa | A2, A3, A4, A5, A6 | RF-03, RF-11, RF-12 |
| C6 — consultas | A3, A4, A5, A6 | RF-05, RF-13 |
| C7 — notificaciones | A3, A4, A5, A6, A7 | RF-14 |
| C8 — soporte | A3, A4, A5, A6, A8 | RF-15, RF-16 |
| C9 — core | A5, A6 | RF-01, RF-02 |

---

## Detalle por Componente

### C1 — autenticacion
| Elemento | Detalle |
|---|---|
| Arquetipos | A1 Actor, A2 Servicio, A5 Controlador, A6 Interfaz |
| RF | RF-01 Autenticación, RF-02 Control de acceso |
| Archivos | Backend: `src/routes/auth.js`, middleware JWT en `src/middleware/auth.js`. Frontend React: `frontend/src/pages/Login.jsx`, `frontend/src/hooks/useAuth.js` |
| Casos de Uso | CU-01 Iniciar Sesión, CU-02 Cerrar Sesión |

### C2 — usuarios
| Elemento | Detalle |
|---|---|
| Arquetipos | A1 Actor, A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz |
| RF | RF-02 Control de acceso, RF-09 Gestionar usuarios |
| Archivos | Backend: `src/models/{Usuario,Estudiante,Docente,Administrador,Rol}.js`, `src/routes/index.js`. Frontend React: `frontend/src/pages/Usuarios.jsx`, `frontend/src/components/UsuarioForm.jsx` |
| Casos de Uso | CU-09 Gestionar Usuarios |

### C3 — infraestructura
| Elemento | Detalle |
|---|---|
| Arquetipos | A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz |
| RF | RF-08 Gestionar aulas, RF-11 Mapa interactivo |
| Archivos | Backend: `src/models/{Torre,Piso,Aula,Ubicacion}.js`, endpoints `/api/{torres,pisos,aulas,ubicaciones}`. Frontend React: `frontend/src/pages/GestionAulas.jsx` |
| Casos de Uso | CU-08 Gestionar Aulas, CU-11 Ver Mapa |

### C4 — academico
| Elemento | Detalle |
|---|---|
| Arquetipos | A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz |
| RF | RF-04 Horario estudiante, RF-06 Horario docente, RF-07 Aulas docente, RF-10 Asignaciones |
| Archivos | Backend: `src/models/{Carrera,Materia,Horario,Asignacion}.js`. Frontend React: `frontend/src/pages/Horario.jsx`, `frontend/src/pages/Asignaciones.jsx` |
| Casos de Uso | CU-04, CU-06, CU-07, CU-10 |

### C5 — mapa
| Elemento | Detalle |
|---|---|
| Arquetipos | A2 Servicio, A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz |
| RF | RF-03 Buscar aula, RF-11 Mapa interactivo, RF-12 Calcular ruta |
| Archivos | Backend: `src/models/Ruta.js`, `src/services/rutaService.js`. Frontend React: `frontend/src/pages/Mapa.jsx`, `frontend/src/components/MapaCampus.jsx` (react-leaflet) |
| Casos de Uso | CU-03, CU-11, CU-12 |

### C6 — consultas
| Elemento | Detalle |
|---|---|
| Arquetipos | A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz |
| RF | RF-05 Historial consultas, RF-13 Registrar consulta |
| Archivos | Backend: `src/models/{Consulta,Historial}.js`, endpoints `/api/{consultas,historiales}`. Frontend React: `frontend/src/pages/Historial.jsx` |
| Casos de Uso | CU-05, CU-13 |

### C7 — notificaciones
| Elemento | Detalle |
|---|---|
| Arquetipos | A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz, A7 Notificador |
| RF | RF-14 Notificaciones |
| Archivos | Backend: `src/models/Notificacion.js`, endpoint `/api/notificaciones`. Frontend React: `frontend/src/components/NotificationCenter.jsx` |
| Casos de Uso | CU-14, CU-15 |

### C8 — soporte
| Elemento | Detalle |
|---|---|
| Arquetipos | A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz, A8 Reportador |
| RF | RF-15 Reportar fallo, RF-16 Gestionar reportes |
| Archivos | Backend: `src/models/ReporteSoporte.js`, endpoint `/api/reportes-soporte`. Frontend React: `frontend/src/pages/Reportes.jsx` |
| Casos de Uso | CU-16, CU-17 |

### C9 — core
| Elemento | Detalle |
|---|---|
| Arquetipos | A5 Controlador, A6 Interfaz |
| RF | RF-01, RF-02 |
| Archivos | Backend: `src/server.js`, `src/config/database.js`, `src/middleware/errorHandler.js`, `src/utils/crudFactory.js`. Frontend React: `frontend/src/App.jsx`, `frontend/src/main.jsx`, `frontend/src/components/Layout.jsx` |
| Casos de Uso | Todos (base compartida) |

---

## Cobertura de Componentes

| Componente | Tiene Arquetipos | Tiene RF | Implementación definida | Cobertura |
|---|---|---|---|---|
| C1 — autenticacion | ✅ | ✅ | ✅ | 100% |
| C2 — usuarios | ✅ | ✅ | ✅ | 100% |
| C3 — infraestructura | ✅ | ✅ | ✅ | 100% |
| C4 — academico | ✅ | ✅ | ✅ | 100% |
| C5 — mapa | ✅ | ✅ | ✅ | 100% |
| C6 — consultas | ✅ | ✅ | ✅ | 100% |
| C7 — notificaciones | ✅ | ✅ | ✅ | 100% |
| C8 — soporte | ✅ | ✅ | ✅ | 100% |
| C9 — core | ✅ | ✅ | ✅ | 100% |

**Cobertura total: 9/9 componentes — 100% ✅**