# M2 — Matriz de Trazabilidad: Arquetipos, Casos de Uso y Requisitos Funcionales

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona los arquetipos del sistema (patrones de diseño
arquitectural) con los Casos de Uso (CU) y los Requisitos Funcionales (RF),
verificando que cada arquetipo está respaldado por casos de uso y requisitos
concretos.

---

## Arquetipos del Sistema

| # | Arquetipo | Descripción |
|---|---|---|
| A1 | Actor | Representa a los usuarios del sistema (Estudiante, Docente, Administrador) |
| A2 | Servicio | Lógica de negocio encapsulada (autenticación, búsqueda, cálculo de rutas) |
| A3 | Entidad | Objetos del dominio persistidos en la base de datos |
| A4 | Repositorio | Acceso y gestión de datos en la base de datos |
| A5 | Controlador | Manejo de peticiones HTTP y respuestas (vistas Django) |
| A6 | Interfaz | Pantallas y componentes de la interfaz de usuario |
| A7 | Notificador | Gestión y envío de notificaciones a usuarios |
| A8 | Reportador | Gestión de reportes de soporte y fallos |

---

## Matriz Principal

| Arquetipo | Casos de Uso | Requisitos Funcionales |
|---|---|---|
| A1 — Actor | CU-01, CU-02, CU-03, CU-04, CU-05, CU-06, CU-07, CU-11, CU-12, CU-15, CU-16 | RF-01, RF-02, RF-03, RF-04, RF-05, RF-06, RF-07 |
| A2 — Servicio | CU-01, CU-03, CU-12, CU-13 | RF-01, RF-02, RF-03, RF-12, RF-13 |
| A3 — Entidad | CU-03, CU-04, CU-05, CU-06, CU-07, CU-08, CU-09, CU-10, CU-11 | RF-03, RF-04, RF-05, RF-06, RF-07, RF-08, RF-09, RF-10, RF-11 |
| A4 — Repositorio | CU-03, CU-04, CU-05, CU-06, CU-07, CU-08, CU-09, CU-10 | RF-03, RF-04, RF-05, RF-06, RF-07, RF-08, RF-09, RF-10 |
| A5 — Controlador | CU-01, CU-02, CU-03, CU-04, CU-05, CU-06, CU-07, CU-08, CU-09, CU-10, CU-11, CU-12 | RF-01, RF-02, RF-03, RF-04, RF-05, RF-06, RF-07, RF-08, RF-09, RF-10, RF-11, RF-12 |
| A6 — Interfaz | CU-01, CU-03, CU-04, CU-05, CU-06, CU-07, CU-11, CU-12, CU-15, CU-16 | RF-01, RF-03, RF-04, RF-05, RF-06, RF-07, RF-11, RF-12, RF-14, RF-15 |
| A7 — Notificador | CU-14, CU-15 | RF-14 |
| A8 — Reportador | CU-16, CU-17 | RF-15, RF-16 |

---

## Detalle por Arquetipo

### A1 — Actor
| Elemento | Detalle |
|---|---|
| Clases asociadas | Usuarios, Estudiante, Docente, Administrador |
| CU principales | CU-01 Iniciar Sesión, CU-02 Cerrar Sesión |
| RF principales | RF-01 Autenticación, RF-02 Control de acceso por rol |
| Implementación Django | `AbstractUser` o modelo `Usuarios` con FK a `ROL` |

### A2 — Servicio
| Elemento | Detalle |
|---|---|
| Clases asociadas | AuthService, BusquedaService, RutaService |
| CU principales | CU-01 Iniciar Sesión, CU-03 Buscar Aula, CU-12 Calcular Ruta |
| RF principales | RF-01, RF-03, RF-12 |
| Implementación Django | Módulos en `services.py` por aplicación |

### A3 — Entidad
| Elemento | Detalle |
|---|---|
| Clases asociadas | Todas las entidades del MER (16 tablas) |
| CU principales | CU-03, CU-04, CU-05, CU-06, CU-07, CU-08 |
| RF principales | RF-03 al RF-11 |
| Implementación Django | Modelos en `models.py` por aplicación |

### A4 — Repositorio
| Elemento | Detalle |
|---|---|
| Clases asociadas | Django ORM (QuerySets) |
| CU principales | CU-03, CU-04, CU-05, CU-08, CU-09, CU-10 |
| RF principales | RF-03 al RF-10 |
| Implementación Django | Managers y QuerySets en `models.py` |

### A5 — Controlador
| Elemento | Detalle |
|---|---|
| Clases asociadas | Vistas Django (Class-Based Views) |
| CU principales | Todos los CU |
| RF principales | Todos los RF |
| Implementación Django | `views.py` con `ListView`, `DetailView`, `CreateView`, etc. |

### A6 — Interfaz
| Elemento | Detalle |
|---|---|
| Clases asociadas | Templates HTML + Bootstrap 5 |
| CU principales | CU-01, CU-03, CU-04, CU-05, CU-11, CU-12 |
| RF principales | RF-01, RF-03, RF-04, RF-11, RF-12 |
| Implementación Django | Templates en `templates/` con herencia de `base.html` |

### A7 — Notificador
| Elemento | Detalle |
|---|---|
| Clases asociadas | Notificacion |
| CU principales | CU-14 Enviar Notificación, CU-15 Ver Notificaciones |
| RF principales | RF-14 |
| Implementación Django | App `notificaciones` con modelo y vistas propias |

### A8 — Reportador
| Elemento | Detalle |
|---|---|
| Clases asociadas | ReporteSoporte |
| CU principales | CU-16 Reportar Fallo, CU-17 Gestionar Reportes |
| RF principales | RF-15, RF-16 |
| Implementación Django | App `soporte` con modelo y vistas propias |

---

## Cobertura de Arquetipos

| Arquetipo | Tiene CU | Tiene RF | Implementación definida | Cobertura |
|---|---|---|---|---|
| A1 — Actor | ✅ | ✅ | ✅ | 100% |
| A2 — Servicio | ✅ | ✅ | ✅ | 100% |
| A3 — Entidad | ✅ | ✅ | ✅ | 100% |
| A4 — Repositorio | ✅ | ✅ | ✅ | 100% |
| A5 — Controlador | ✅ | ✅ | ✅ | 100% |
| A6 — Interfaz | ✅ | ✅ | ✅ | 100% |
| A7 — Notificador | ✅ | ✅ | ✅ | 100% |
| A8 — Reportador | ✅ | ✅ | ✅ | 100% |

**Cobertura total: 8/8 arquetipos — 100% ✅**