# M3 — Matriz de Trazabilidad: Componentes, Arquetipos y Requisitos Funcionales

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona los componentes del sistema (módulos Django)
con los arquetipos arquitecturales y los Requisitos Funcionales (RF),
verificando que cada componente tiene una justificación arquitectural
y un requisito que lo respalda.

---

## Componentes del Sistema

| # | Componente | Tipo | Descripción |
|---|---|---|---|
| C1 | autenticacion | App Django | Gestión de login, logout y control de acceso por rol |
| C2 | usuarios | App Django | Gestión de usuarios, estudiantes, docentes y administradores |
| C3 | infraestructura | App Django | Gestión de torres, pisos y aulas |
| C4 | academico | App Django | Gestión de carreras, materias, horarios y asignaciones |
| C5 | mapa | App Django | Mapa interactivo, ubicaciones y cálculo de rutas |
| C6 | consultas | App Django | Registro y visualización del historial de consultas |
| C7 | notificaciones | App Django | Envío y recepción de notificaciones |
| C8 | soporte | App Django | Reporte y gestión de fallos |
| C9 | core | App Django | Configuración base, templates y utilidades compartidas |

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
| Archivos Django | `views.py`, `urls.py`, `forms.py`, `templates/login.html` |
| Casos de Uso | CU-01 Iniciar Sesión, CU-02 Cerrar Sesión |

### C2 — usuarios
| Elemento | Detalle |
|---|---|
| Arquetipos | A1 Actor, A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz |
| RF | RF-02 Control de acceso, RF-09 Gestionar usuarios |
| Archivos Django | `models.py`, `views.py`, `urls.py`, `admin.py`, `templates/usuarios/` |
| Casos de Uso | CU-09 Gestionar Usuarios |

### C3 — infraestructura
| Elemento | Detalle |
|---|---|
| Arquetipos | A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz |
| RF | RF-08 Gestionar aulas, RF-11 Mapa interactivo |
| Archivos Django | `models.py`, `views.py`, `urls.py`, `admin.py`, `templates/infraestructura/` |
| Casos de Uso | CU-08 Gestionar Aulas, CU-11 Ver Mapa |

### C4 — academico
| Elemento | Detalle |
|---|---|
| Arquetipos | A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz |
| RF | RF-04 Horario estudiante, RF-06 Horario docente, RF-07 Aulas docente, RF-10 Asignaciones |
| Archivos Django | `models.py`, `views.py`, `urls.py`, `admin.py`, `templates/academico/` |
| Casos de Uso | CU-04, CU-06, CU-07, CU-10 |

### C5 — mapa
| Elemento | Detalle |
|---|---|
| Arquetipos | A2 Servicio, A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz |
| RF | RF-03 Buscar aula, RF-11 Mapa interactivo, RF-12 Calcular ruta |
| Archivos Django | `models.py`, `views.py`, `urls.py`, `services.py`, `templates/mapa/` |
| Casos de Uso | CU-03, CU-11, CU-12 |

### C6 — consultas
| Elemento | Detalle |
|---|---|
| Arquetipos | A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz |
| RF | RF-05 Historial consultas, RF-13 Registrar consulta |
| Archivos Django | `models.py`, `views.py`, `urls.py`, `templates/consultas/` |
| Casos de Uso | CU-05, CU-13 |

### C7 — notificaciones
| Elemento | Detalle |
|---|---|
| Arquetipos | A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz, A7 Notificador |
| RF | RF-14 Notificaciones |
| Archivos Django | `models.py`, `views.py`, `urls.py`, `templates/notificaciones/` |
| Casos de Uso | CU-14, CU-15 |

### C8 — soporte
| Elemento | Detalle |
|---|---|
| Arquetipos | A3 Entidad, A4 Repositorio, A5 Controlador, A6 Interfaz, A8 Reportador |
| RF | RF-15 Reportar fallo, RF-16 Gestionar reportes |
| Archivos Django | `models.py`, `views.py`, `urls.py`, `templates/soporte/` |
| Casos de Uso | CU-16, CU-17 |

### C9 — core
| Elemento | Detalle |
|---|---|
| Arquetipos | A5 Controlador, A6 Interfaz |
| RF | RF-01, RF-02 |
| Archivos Django | `settings.py`, `urls.py`, `templates/base.html`, `static/` |
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