# E17 — Prototipo Interactivo

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

El prototipo interactivo describe el comportamiento esperado de la interfaz
de usuario, definiendo las interacciones, transiciones y respuestas del
sistema ante las acciones del usuario. Sirve como guía para la
implementación del frontend en Django.

---

## Herramienta de Prototipado

| Herramienta | Uso |
|---|---|
| Figma | Diseño visual y prototipado interactivo |
| Django Templates | Implementación final del frontend |
| Bootstrap 5 | Framework CSS para estilos y componentes |
| Leaflet.js | Librería para el mapa interactivo del campus |

---

## Interacciones por Pantalla

### PI-P2: Login
| Acción | Respuesta del sistema |
|---|---|
| Usuario ingresa correo y contraseña correctos | Redirige al dashboard según el rol |
| Usuario ingresa credenciales incorrectas | Muestra mensaje de error en rojo |
| Usuario deja campos vacíos | Muestra validación en cada campo |
| Usuario hace clic en "¿Olvidaste tu contraseña?" | Muestra formulario de recuperación |

---

### PI-E1: Dashboard Estudiante
| Acción | Respuesta del sistema |
|---|---|
| Clic en "Ir al Mapa" | Navega a WF-E2 Mapa de Aulas |
| Clic en "Ver Horario" | Navega a WF-E5 Horario Personal |
| Clic en "Calcular Ruta" | Navega a WF-E4 Cálculo de Ruta |
| Clic en "Ver Historial" | Navega a historial de consultas |
| Clic en notificación | Abre detalle de la notificación |
| Clic en ícono 🔔 | Despliega panel de notificaciones |

---

### PI-E2: Mapa de Aulas
| Acción | Respuesta del sistema |
|---|---|
| Usuario escribe en buscador | Filtra aulas en tiempo real |
| Usuario selecciona filtro Torre | Resalta aulas de esa torre en el mapa |
| Usuario selecciona filtro Piso | Filtra aulas por piso |
| Usuario selecciona filtro Tipo | Filtra por tipo de aula |
| Usuario hace clic en pin del mapa | Muestra popup con info básica del aula |
| Usuario hace clic en "Ver detalle" del popup | Navega a WF-E3 Detalle de Aula |
| Usuario hace zoom en el mapa | El mapa hace zoom con animación suave |

---

### PI-E3: Detalle de Aula
| Acción | Respuesta del sistema |
|---|---|
| Clic en "← Volver al mapa" | Regresa a WF-E2 con el mapa en la misma posición |
| Clic en "Calcular Ruta hasta aquí" | Navega a WF-E4 con el aula preseleccionada como destino |
| Clic en mini mapa | Expande el mapa a pantalla completa |
| Sistema detecta aula ocupada | Muestra badge rojo "Ocupada" en lugar de "Disponible" |

---

### PI-E4: Cálculo de Ruta
| Acción | Respuesta del sistema |
|---|---|
| Usuario selecciona aula origen | Actualiza el selector con el aula elegida |
| Usuario selecciona aula destino | Actualiza el selector con el aula elegida |
| Clic en "Calcular Ruta" | Muestra animación de carga y dibuja la ruta en el mapa |
| Ruta calculada exitosamente | Muestra distancia, tiempo estimado y ruta animada |
| Origen igual a destino | Muestra mensaje de error "Selecciona aulas diferentes" |
| Clic en "← Volver" | Regresa al dashboard |

---

### PI-E5: Horario Personal (Estudiante)
| Acción | Respuesta del sistema |
|---|---|
| Clic en celda del horario | Muestra detalle de la materia y aula |
| Clic en "Ver Aula en el Mapa" | Navega a WF-E2 con el aula resaltada |
| Clic en "Ver Jueves" / "Ver Viernes" | Cambia la vista de días con transición suave |
| Hover sobre celda | Muestra tooltip con nombre del docente |

---

### PI-D1: Dashboard Docente
| Acción | Respuesta del sistema |
|---|---|
| Clic en "Ver Horario" | Navega a WF-D2 Horario Personal Docente |
| Clic en "Ver Aulas" | Navega a lista de aulas del docente |
| Clic en "Ver Mapa" | Navega a mapa interactivo |
| Clic en próxima clase | Navega al detalle del aula correspondiente |

---

### PI-D2: Horario Personal (Docente)
| Acción | Respuesta del sistema |
|---|---|
| Clic en celda del horario | Muestra detalle de la materia y grupo |
| Clic en "Ver Aula en el Mapa" | Navega al mapa con el aula resaltada |
| Clic en "Ver Jueves" / "Ver Viernes" | Cambia la vista de días con transición suave |
| Hover sobre celda | Muestra tooltip con nombre de la carrera |

---

### PI-A1: Dashboard Administrador
| Acción | Respuesta del sistema |
|---|---|
| Clic en "Nueva Aula" | Abre modal con formulario de creación |
| Clic en "Nueva Asignación" | Navega a formulario de asignación de horario |
| Clic en "Nuevo Usuario" | Abre modal con formulario de registro |
| Clic en "Notificación" | Abre modal para redactar y enviar notificación |
| Clic en reporte pendiente | Navega al detalle del reporte |
| Clic en contador de aulas | Navega a gestión de aulas |
| Clic en contador de usuarios | Navega a gestión de usuarios |

---

## Componentes Reutilizables

| Componente | Descripción | Usado en |
|---|---|---|
| Navbar | Barra de navegación superior con rol y notificaciones | Todas las pantallas autenticadas |
| Sidebar | Menú lateral con accesos rápidos | Dashboard de cada rol |
| Mapa Leaflet | Mapa interactivo del campus con pins y rutas | E2, E3, E4, D2, A5 |
| Tabla Horario | Grilla semanal de materias y aulas | E5, D2 |
| Card Resumen | Tarjeta con ícono, título y botón de acción | E1, D1, A1 |
| Modal Formulario | Ventana emergente para crear/editar registros | A1 (CRUD) |
| Badge Estado | Indicador visual de estado (disponible/ocupada) | E3, A4 |
| Toast Notificación | Mensaje emergente temporal de confirmación | Todas las pantallas |

---

## Transiciones y Animaciones

| Transición | Descripción |
|---|---|
| Cambio de pantalla | Fade in/out suave (0.3s) |
| Carga de mapa | Spinner mientras carga Leaflet.js |
| Cálculo de ruta | Animación de línea dibujándose en el mapa |
| Apertura de modal | Slide down desde arriba (0.2s) |
| Notificación toast | Aparece desde la esquina inferior derecha |
| Hover en cards | Sombra elevada con transición suave |

---

## Paleta de Colores del Prototipo

| Elemento | Color | Código HEX |
|---|---|---|
| Color primario | Azul universitario | `#1A3C6E` |
| Color secundario | Gris claro | `#F5F5F5` |
| Acento | Amarillo dorado | `#F0A500` |
| Éxito | Verde | `#28A745` |
| Error | Rojo | `#DC3545` |
| Advertencia | Naranja | `#FD7E14` |
| Texto principal | Gris oscuro | `#333333` |

---

## Resumen del Prototipo

| Rol | Pantallas prototipadas | Interacciones definidas |
|---|---|---|
| Público | 2 | 4 |
| Estudiante | 5 | 22 |
| Docente | 2 | 8 |
| Administrador | 1 | 7 |
| **Total** | **10** | **41** |