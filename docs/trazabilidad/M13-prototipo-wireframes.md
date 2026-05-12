# M13 — Matriz de Trazabilidad: Navegación, Vistas y Roles

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz define el mapa de navegación completo del sistema,
especificando qué vistas puede acceder cada rol, las rutas de
navegación entre vistas y las restricciones de acceso.

---

## Roles del Sistema

| ID | Rol | Descripción | Acceso |
|---|---|---|---|
| R1 | Estudiante | Usuario que consulta aulas y horarios | Vistas de consulta y soporte |
| R2 | Docente | Usuario que consulta su horario y aulas | Vistas de consulta docente |
| R3 | Administrador | Gestor del sistema | Acceso total |
| R0 | Anónimo | Usuario no autenticado | Solo V01 (Login) |

---

## Matriz de Acceso por Rol

| Vista | URL | R0 Anónimo | R1 Estudiante | R2 Docente | R3 Admin |
|---|---|---|---|---|---|
| V01 Login | `/login/` | ✅ | ✅ | ✅ | ✅ |
| V02 Dashboard Estudiante | `/estudiante/dashboard/` | ❌ | ✅ | ❌ | ❌ |
| V03 Dashboard Docente | `/docente/dashboard/` | ❌ | ❌ | ✅ | ❌ |
| V04 Dashboard Admin | `/admin/dashboard/` | ❌ | ❌ | ❌ | ✅ |
| V05 Búsqueda de Aula | `/estudiante/buscar-aula/` | ❌ | ✅ | ❌ | ❌ |
| V06 Detalle de Aula | `/estudiante/aula/<id>/` | ❌ | ✅ | ❌ | ❌ |
| V07 Horario Estudiante | `/estudiante/horario/` | ❌ | ✅ | ❌ | ❌ |
| V08 Historial Consultas | `/estudiante/historial/` | ❌ | ✅ | ❌ | ❌ |
| V09 Horario Docente | `/docente/horario/` | ❌ | ❌ | ✅ | ❌ |
| V10 Aulas Docente | `/docente/aulas/` | ❌ | ❌ | ✅ | ❌ |
| V11 Gestión Aulas | `/admin/aulas/` | ❌ | ❌ | ❌ | ✅ |
| V12 Formulario Aula | `/admin/aulas/nueva/` | ❌ | ❌ | ❌ | ✅ |
| V13 Gestión Usuarios | `/admin/usuarios/` | ❌ | ❌ | ❌ | ✅ |
| V14 Formulario Usuario | `/admin/usuarios/nuevo/` | ❌ | ❌ | ❌ | ✅ |
| V15 Gestión Asignaciones | `/admin/asignaciones/` | ❌ | ❌ | ❌ | ✅ |
| V16 Formulario Asignación | `/admin/asignaciones/nueva/` | ❌ | ❌ | ❌ | ✅ |
| V17 Mapa Interactivo | `/mapa/` | ❌ | ✅ | ✅ | ❌ |
| V18 Ruta a Aula | `/mapa/ruta/<id>/` | ❌ | ✅ | ❌ | ❌ |
| V19 Notificaciones | `/notificaciones/` | ❌ | ✅ | ✅ | ✅ |
| V20 Reporte de Fallo | `/estudiante/reportar/` | ❌ | ✅ | ❌ | ❌ |
| V21 Gestión Reportes | `/admin/reportes/` | ❌ | ❌ | ❌ | ✅ |

---

## Flujos de Navegación por Rol

### R1 — Estudiante

[V01 Login]
└──► [V02 Dashboard Estudiante]
├──► [V05 Búsqueda de Aula]
│ └──► [V06 Detalle de Aula]
│ └──► [V18 Ruta a Aula]
├──► [V07 Horario Estudiante]
├──► [V08 Historial de Consultas]
├──► [V17 Mapa Interactivo]
│ └──► [V18 Ruta a Aula]
├──► [V19 Notificaciones]
└──► [V20 Reporte de Fallo]


### R2 — Docente

[V01 Login]
└──► [V03 Dashboard Docente]
├──► [V09 Horario Docente]
├──► [V10 Aulas Asignadas]
│ └──► [V17 Mapa Interactivo]
└──► [V19 Notificaciones]


### R3 — Administrador

[V01 Login]
└──► [V04 Dashboard Administrador]
├──► [V11 Gestión de Aulas]
│ └──► [V12 Formulario Aula (crear/editar)]
├──► [V13 Gestión de Usuarios]
│ └──► [V14 Formulario Usuario (crear/editar)]
├──► [V15 Gestión de Asignaciones]
│ └──► [V16 Formulario Asignación (crear/editar)]
├──► [V19 Notificaciones]
└──► [V21 Gestión de Reportes]


---

## Implementación de Control de Acceso en Django

### Decoradores por Vista

```python
# autenticacion/decorators.py

from functools import wraps
from django.shortcuts import redirect

def rol_requerido(*roles):
    def decorator(view_func):
        @wraps(view_func)
        def wrapper(request, *args, **kwargs):
            if not request.user.is_authenticated:
                return redirect('login')
            rol_usuario = request.user.usuarios.id_rol.nombre_rol
            if rol_usuario not in roles:
                return redirect('acceso_denegado')
            return view_func(request, *args, **kwargs)
        return wrapper
    return decorator


# Vistas de Estudiante
@rol_requerido('Estudiante')
def dashboard_estudiante(request): ...

@rol_requerido('Estudiante')
def buscar_aula(request): ...

@rol_requerido('Estudiante')
def detalle_aula(request, id): ...

@rol_requerido('Estudiante')
def horario_estudiante(request): ...

@rol_requerido('Estudiante')
def historial_consultas(request): ...

@rol_requerido('Estudiante')
def reportar_fallo(request): ...

# Vistas de Docente
@rol_requerido('Docente')
def dashboard_docente(request): ...

@rol_requerido('Docente')
def horario_docente(request): ...

@rol_requerido('Docente')
def aulas_docente(request): ...

# Vistas compartidas
@rol_requerido('Estudiante', 'Docente')
def mapa_interactivo(request): ...

@rol_requerido('Estudiante')
def ruta_aula(request, id): ...

@rol_requerido('Estudiante', 'Docente', 'Administrador')
def notificaciones(request): ...

# Vistas de Administrador
@rol_requerido('Administrador')
def dashboard_admin(request): ...

@rol_requerido('Administrador')
def gestion_aulas(request): ...

@rol_requerido('Administrador')
def formulario_aula(request): ...

@rol_requerido('Administrador')
def gestion_usuarios(request): ...

@rol_requerido('Administrador')
def formulario_usuario(request): ...

@rol_requerido('Administrador')
def gestion_asignaciones(request): ...

@rol_requerido('Administrador')
def formulario_asignacion(request): ...

@rol_requerido('Administrador')
def gestion_reportes(request): ...

# sigau/urls.py

from django.urls import path, include

urlpatterns = [
    # Autenticación
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),

    # Estudiante
    path('estudiante/', include([
        path('dashboard/', views.dashboard_estudiante, name='dashboard_estudiante'),
        path('buscar-aula/', views.buscar_aula, name='buscar_aula'),
        path('aula/<int:id>/', views.detalle_aula, name='detalle_aula'),
        path('horario/', views.horario_estudiante, name='horario_estudiante'),
        path('historial/', views.historial_consultas, name='historial_consultas'),
        path('reportar/', views.reportar_fallo, name='reportar_fallo'),
    ])),

    # Docente
    path('docente/', include([
        path('dashboard/', views.dashboard_docente, name='dashboard_docente'),
        path('horario/', views.horario_docente, name='horario_docente'),
        path('aulas/', views.aulas_docente, name='aulas_docente'),
    ])),

    # Mapa (compartido)
    path('mapa/', include([
        path('', views.mapa_interactivo, name='mapa'),
        path('ruta/<int:id>/', views.ruta_aula, name='ruta_aula'),
    ])),

    # Notificaciones (compartido)
    path('notificaciones/', views.notificaciones, name='notificaciones'),

    # Administrador
    path('admin/', include([
        path('dashboard/', views.dashboard_admin, name='dashboard_admin'),
        path('aulas/', views.gestion_aulas, name='gestion_aulas'),
        path('aulas/nueva/', views.formulario_aula, name='formulario_aula'),
        path('aulas/<int:id>/editar/', views.formulario_aula, name='editar_aula'),
        path('usuarios/', views.gestion_usuarios, name='gestion_usuarios'),
        path('usuarios/nuevo/', views.formulario_usuario, name='formulario_usuario'),
        path('usuarios/<int:id>/editar/', views.formulario_usuario, name='editar_usuario'),
        path('asignaciones/', views.gestion_asignaciones, name='gestion_asignaciones'),
        path('asignaciones/nueva/', views.formulario_asignacion, name='formulario_asignacion'),
        path('asignaciones/<int:id>/editar/', views.formulario_asignacion, name='editar_asignacion'),
        path('reportes/', views.gestion_reportes, name='gestion_reportes'),
    ])),
]