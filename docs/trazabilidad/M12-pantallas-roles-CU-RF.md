# M12 — Matriz de Trazabilidad: Vistas, Actores y Requisitos Funcionales

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona las vistas (pantallas/interfaces) del sistema
con los actores que las utilizan y los Requisitos Funcionales que
cada vista satisface, verificando cobertura completa de la UI.

---

## Actores del Sistema

| ID | Actor | Acceso |
|---|---|---|
| A1 | Estudiante | Vistas de consulta, mapa, historial y soporte |
| A2 | Docente | Vistas de horario y aulas asignadas |
| A3 | Administrador | Vistas de gestión completa |

---

## Matriz Principal: Vistas — Actores — RF

| # | Vista | Ruta URL | Actor | RF Cubierto |
|---|---|---|---|---|
| V01 | Login | `/login/` | A1, A2, A3 | RF-01 |
| V02 | Dashboard Estudiante | `/estudiante/dashboard/` | A1 | RF-02, RF-03 |
| V03 | Dashboard Docente | `/docente/dashboard/` | A2 | RF-02, RF-06 |
| V04 | Dashboard Administrador | `/admin/dashboard/` | A3 | RF-02, RF-08 |
| V05 | Búsqueda de Aula | `/estudiante/buscar-aula/` | A1 | RF-03 |
| V06 | Detalle de Aula | `/estudiante/aula/<id>/` | A1 | RF-03, RF-11 |
| V07 | Horario Estudiante | `/estudiante/horario/` | A1 | RF-04 |
| V08 | Historial de Consultas | `/estudiante/historial/` | A1 | RF-05 |
| V09 | Horario Docente | `/docente/horario/` | A2 | RF-06 |
| V10 | Aulas Asignadas Docente | `/docente/aulas/` | A2 | RF-07 |
| V11 | Gestión de Aulas | `/admin/aulas/` | A3 | RF-08 |
| V12 | Formulario Aula | `/admin/aulas/nueva/` | A3 | RF-08 |
| V13 | Gestión de Usuarios | `/admin/usuarios/` | A3 | RF-09 |
| V14 | Formulario Usuario | `/admin/usuarios/nuevo/` | A3 | RF-09 |
| V15 | Gestión de Asignaciones | `/admin/asignaciones/` | A3 | RF-10 |
| V16 | Formulario Asignación | `/admin/asignaciones/nueva/` | A3 | RF-10 |
| V17 | Mapa Interactivo | `/mapa/` | A1, A2 | RF-11 |
| V18 | Ruta a Aula | `/mapa/ruta/<id>/` | A1 | RF-12 |
| V19 | Notificaciones | `/notificaciones/` | A1, A2, A3 | RF-14 |
| V20 | Reporte de Fallo | `/estudiante/reportar/` | A1 | RF-15 |
| V21 | Gestión de Reportes | `/admin/reportes/` | A3 | RF-16 |

---

## Detalle por Vista

### V01 — Login
**URL:** `/login/` | **Actor:** A1, A2, A3 | **RF:** RF-01

| Componente | Descripción |
|---|---|
| Formulario | Campos: correo, contraseña |
| Botón | "Iniciar sesión" |
| Enlace | "¿Olvidaste tu contraseña?" |
| Validación | Credenciales incorrectas → mensaje de error |
| Redirección | Según rol → dashboard correspondiente |

**Template Django:** `autenticacion/login.html`
```python
# views.py
def login_view(request):
    if request.method == 'POST':
        correo = request.POST['correo']
        password = request.POST['password']
        usuario = authenticate(request, username=correo, password=password)
        if usuario:
            login(request, usuario)
            return redirect_by_rol(usuario)
        return render(request, 'login.html', {'error': 'Credenciales incorrectas'})
    return render(request, 'autenticacion/login.html')
V02 — Dashboard Estudiante
URL: /estudiante/dashboard/ | Actor: A1 | RF: RF-02, RF-03

Componente	Descripción
Barra de navegación	Links a: Buscar Aula, Horario, Historial, Mapa, Reportar
Buscador rápido	Campo de búsqueda de aula por código
Tarjetas resumen	Próxima clase, última consulta, notificaciones
Acceso rápido	Botones a las funciones principales
Template Django: estudiante/dashboard.html

V03 — Dashboard Docente
URL: /docente/dashboard/ | Actor: A2 | RF: RF-02, RF-06

Componente	Descripción
Barra de navegación	Links a: Horario, Mis Aulas, Mapa, Notificaciones
Tarjeta horario hoy	Clases del día actual
Tarjeta aulas	Aulas asignadas al docente
Notificaciones	Últimas notificaciones recibidas
Template Django: docente/dashboard.html

V04 — Dashboard Administrador
URL: /admin/dashboard/ | Actor: A3 | RF: RF-02, RF-08

Componente	Descripción
Barra de navegación	Links a: Aulas, Usuarios, Asignaciones, Reportes
Métricas	Total aulas, usuarios, asignaciones activas, reportes pendientes
Accesos rápidos	Botones a gestión de cada entidad
Alertas	Reportes pendientes de revisión
Template Django: administrador/dashboard.html

V05 — Búsqueda de Aula
URL: /estudiante/buscar-aula/ | Actor: A1 | RF: RF-03

Componente	Descripción
Campo de búsqueda	Código de aula o nombre
Filtros	Tipo de aula, capacidad, estado
Resultados	Lista de aulas con código, tipo, estado y ubicación
Botón detalle	Redirige a V06
Template Django: estudiante/buscar_aula.html

python

# views.py
@login_required
def buscar_aula(request):
    query = request.GET.get('q', '')
    aulas = Aula.objects.filter(
        codigo_aula__icontains=query
    ).select_related('id_piso__id_torre')
    ConsultaManager().registrar_consulta(
        request.user.estudiante,
        aulas.first() if aulas.exists() else None,
        resultado='EXITOSA' if aulas.exists() else 'FALLIDA'
    )
    return render(request, 'estudiante/buscar_aula.html', {'aulas': aulas})
V06 — Detalle de Aula
URL: /estudiante/aula/<id>/ | Actor: A1 | RF: RF-03, RF-11

Componente	Descripción
Ficha del aula	Código, tipo, capacidad, estado, piso, torre
Mapa mini	Ubicación del aula en el mapa
Botón ruta	"Cómo llegar" → redirige a V18
Horario del aula	Asignaciones actuales del aula
Template Django: estudiante/detalle_aula.html

V07 — Horario Estudiante
URL: /estudiante/horario/ | Actor: A1 | RF: RF-04

Componente	Descripción
Tabla semanal	Lunes a Sábado con franjas horarias
Celdas	Materia, aula, docente por franja
Filtro	Por semana o periodo
Exportar	Botón para descargar horario en PDF
Template Django: estudiante/horario.html

V08 — Historial de Consultas
URL: /estudiante/historial/ | Actor: A1 | RF: RF-05

Componente	Descripción
Tabla de historial	Fecha, aula consultada, resultado
Filtro por fecha	Selector de rango de fechas
Paginación	10 registros por página
Indicador	Ícono de resultado (✅ EXITOSA / ❌ FALLIDA)
Template Django: estudiante/historial.html

V09 — Horario Docente
URL: /docente/horario/ | Actor: A2 | RF: RF-06

Componente	Descripción
Tabla semanal	Lunes a Sábado con franjas horarias
Celdas	Materia, aula, carrera por franja
Filtro	Por periodo académico
Vista compacta	Resumen del día actual
Template Django: docente/horario.html

V10 — Aulas Asignadas Docente
URL: /docente/aulas/ | Actor: A2 | RF: RF-07

Componente	Descripción
Lista de aulas	Código, piso, torre, capacidad, estado
Mapa mini	Ubicación de cada aula
Filtro	Por día de la semana
Botón detalle	Ver información completa del aula
Template Django: docente/aulas.html

V11 — Gestión de Aulas
URL: /admin/aulas/ | Actor: A3 | RF: RF-08

Componente	Descripción
Tabla de aulas	Código, tipo, capacidad, estado, piso, torre
Botón crear	Redirige a V12
Botón editar	Formulario inline de edición
Botón eliminar	Confirmación antes de eliminar
Filtros	Por estado, tipo, torre
Cambio de estado	Dropdown para cambiar estado del aula
Template Django: administrador/gestion_aulas.html

V12 — Formulario Aula
URL: /admin/aulas/nueva/ | Actor: A3 | RF: RF-08

Componente	Descripción
Campo código	Código único del aula
Select piso	Selector de piso (carga torres y pisos)
Campo capacidad	Número entero
Select tipo	Salón, Laboratorio, Auditorio, etc.
Select estado	DISPONIBLE, OCUPADA, MANTENIMIENTO
Coordenadas	Latitud y longitud para ubicación
Botón guardar	Valida y persiste
Template Django: administrador/formulario_aula.html

V13 — Gestión de Usuarios
URL: /admin/usuarios/ | Actor: A3 | RF: RF-09

Componente	Descripción
Tabla de usuarios	Correo, rol, nombre, estado
Filtro por rol	Estudiante, Docente, Administrador
Botón crear	Redirige a V14
Botón editar	Formulario de edición
Botón bloquear/desbloquear	Cambia estado del usuario
Template Django: administrador/gestion_usuarios.html

V14 — Formulario Usuario
URL: /admin/usuarios/nuevo/ | Actor: A3 | RF: RF-09

Componente	Descripción
Campo correo	Email único
Campo contraseña	Con confirmación
Select rol	Estudiante, Docente, Administrador
Campos adicionales	Según rol seleccionado (nombre, código, carrera, etc.)
Botón guardar	Valida y persiste
Template Django: administrador/formulario_usuario.html

V15 — Gestión de Asignaciones
URL: /admin/asignaciones/ | Actor: A3 | RF: RF-10

Componente	Descripción
Tabla de asignaciones	Docente, materia, aula, horario, periodo
Filtros	Por periodo, docente, aula
Botón crear	Redirige a V16
Botón editar	Formulario de edición
Botón cancelar	Cambia estado a CANCELADA
Template Django: administrador/gestion_asignaciones.html

V16 — Formulario Asignación
URL: /admin/asignaciones/nueva/ | Actor: A3 | RF: RF-10

Componente	Descripción
Select docente	Lista de docentes activos
Select materia	Lista de materias
Select aula	Lista de aulas disponibles
Select horario	Día y franja horaria
Campo periodo	Ej: 2025-1
Validación	Alerta si hay solapamiento de aula/horario
Botón guardar	Valida y persiste
Template Django: administrador/formulario_asignacion.html

V17 — Mapa Interactivo
URL: /mapa/ | Actor: A1, A2 | RF: RF-11

Componente	Descripción
Mapa Leaflet.js	Mapa del campus con marcadores de aulas
Marcadores	Un marcador por aula con popup informativo
Popup	Código, tipo, estado, piso, torre
Buscador	Campo para buscar aula en el mapa
Botón ruta	"Cómo llegar" desde el popup
Template Django: mapa/mapa.html

python

# views.py
@login_required
def mapa_view(request):
    ubicaciones = Ubicacion.objects.select_related(
        'id_aula__id_piso__id_torre'
    ).all()
    return render(request, 'mapa/mapa.html', {'ubicaciones': ubicaciones})
V18 — Ruta a Aula
URL: /mapa/ruta/<id>/ | Actor: A1 | RF: RF-12

Componente	Descripción
Mapa Leaflet.js	Mapa con ruta trazada
Punto origen	Ubicación actual del usuario
Punto destino	Aula seleccionada
Línea de ruta	Ruta calculada entre origen y destino
Información	Distancia estimada y tiempo a pie
Template Django: mapa/ruta.html

V19 — Notificaciones
URL: /notificaciones/ | Actor: A1, A2, A3 | RF: RF-14

Componente	Descripción
Lista de notificaciones	Título, mensaje, fecha, estado
Indicador	Badge con cantidad de no leídas
Botón leer	Marca como LEIDA
Botón eliminar	Marca como ELIMINADA
Filtro	Por estado (ENVIADA, LEIDA)
Template Django: notificaciones/lista.html

V20 — Reporte de Fallo
URL: /estudiante/reportar/ | Actor: A1 | RF: RF-15

Componente	Descripción
Select aula	Lista de aulas del campus
Campo descripción	Textarea para describir el fallo
Botón enviar	Crea reporte con estado PENDIENTE
Confirmación	Mensaje de éxito tras enviar
Template Django: estudiante/reportar_fallo.html

V21 — Gestión de Reportes
URL: /admin/reportes/ | Actor: A3 | RF: RF-16

Componente	Descripción
Tabla de reportes	Estudiante, aula, descripción, fecha, estado
Filtro por estado	PENDIENTE, EN_REVISION, RESUELTO
Botón revisar	Cambia estado a EN_REVISION
Botón resolver	Cambia estado a RESUELTO
Notificación automática	Notifica al estudiante al resolver
Template Django: administrador/gestion_reportes.html

Cobertura de RF por Vista
RF	Vistas que lo cubren	Actores	Estado
RF-01 Autenticación	V01	A1, A2, A3	✅
RF-02 Control acceso	V02, V03, V04	A1, A2, A3	✅
RF-03 Buscar aula	V05, V06	A1	✅
RF-04 Horario estudiante	V07	A1	✅
RF-05 Historial	V08	A1	✅
RF-06 Horario docente	V03, V09	A2	✅
RF-07 Aulas docente	V10	A2	✅
RF-08 Gestionar aulas	V11, V12	A3	✅
RF-09 Gestionar usuarios	V13, V14	A3	✅
RF-10 Asignaciones	V15, V16	A3	✅
RF-11 Mapa interactivo	V06, V17	A1, A2	✅
RF-12 Calcular ruta	V18	A1	✅
RF-13 Registrar consulta	V05 (automático)	A1	✅
RF-14 Notificaciones	V19	A1, A2, A3	✅
RF-15 Reportar fallo	V20	A1	✅
RF-16 Gestionar reportes	V21	A3	✅
Cobertura total: 16/16 RF cubiertos — 100% ✅