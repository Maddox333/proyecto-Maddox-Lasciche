# M9 — Matriz de Trazabilidad: Clases, Métodos y Requisitos Funcionales

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona las clases del diagrama de clases con sus métodos
y los Requisitos Funcionales (RF) que cada método satisface, verificando
que toda la lógica de negocio está cubierta por la implementación.

---

## Clases del Sistema

| # | Clase | App Django | Responsabilidad |
|---|---|---|---|
| CL1 | UsuarioManager | autenticacion | Gestión de autenticación y sesiones |
| CL2 | RolManager | autenticacion | Control de acceso por rol |
| CL3 | EstudianteManager | usuarios | Gestión del perfil de estudiante |
| CL4 | DocenteManager | usuarios | Gestión del perfil de docente |
| CL5 | AdministradorManager | usuarios | Gestión del perfil de administrador |
| CL6 | AulaManager | infraestructura | Gestión de aulas |
| CL7 | MapaManager | mapa | Mapa interactivo y rutas |
| CL8 | ConsultaManager | consultas | Historial de consultas |
| CL9 | AsignacionManager | academico | Gestión de asignaciones |
| CL10 | NotificacionManager | notificaciones | Envío de notificaciones |
| CL11 | SoporteManager | soporte | Gestión de reportes |

---

## Matriz Principal

| Clase | Métodos | RF Cubiertos |
|---|---|---|
| CL1 — UsuarioManager | login(), logout(), cambiar_password() | RF-01 |
| CL2 — RolManager | verificar_rol(), asignar_rol(), obtener_permisos() | RF-02 |
| CL3 — EstudianteManager | registrar(), actualizar(), obtener_horario(), buscar_aula() | RF-03, RF-04, RF-05 |
| CL4 — DocenteManager | registrar(), actualizar(), obtener_horario(), obtener_aulas() | RF-06, RF-07 |
| CL5 — AdministradorManager | gestionar_usuarios(), gestionar_aulas(), gestionar_asignaciones() | RF-08, RF-09, RF-10 |
| CL6 — AulaManager | crear(), actualizar(), eliminar(), cambiar_estado(), buscar() | RF-08, RF-11 |
| CL7 — MapaManager | mostrar_mapa(), calcular_ruta(), obtener_ubicacion() | RF-11, RF-12 |
| CL8 — ConsultaManager | registrar_consulta(), obtener_historial(), filtrar() | RF-05, RF-13 |
| CL9 — AsignacionManager | crear(), actualizar(), eliminar(), validar_solapamiento() | RF-10 |
| CL10 — NotificacionManager | enviar(), marcar_leida(), eliminar(), listar() | RF-14 |
| CL11 — SoporteManager | reportar(), actualizar_estado(), listar_reportes() | RF-15, RF-16 |

---

## Detalle por Clase

### CL1 — UsuarioManager
| Método | Descripción | RF | RN |
|---|---|---|---|
| `login(correo, password)` | Autentica al usuario verificando credenciales | RF-01 | RN-15 |
| `logout(request)` | Cierra la sesión del usuario | RF-01 | — |
| `cambiar_password(usuario, nueva)` | Actualiza la contraseña cifrada | RF-01 | RN-15 |

**Implementación Django:**
```python
class UsuarioManager:
    def login(self, correo, password):
        usuario = authenticate(username=correo, password=password)
        if usuario:
            login(request, usuario)
            return True
        return False

    def logout(self, request):
        logout(request)

    def cambiar_password(self, usuario, nueva_password):
        usuario.set_password(nueva_password)
        usuario.save()


### CL2 — RolManager
| Método | Descripción | RF | RN |
|---|---|---|---|
| `verificar_rol(usuario, rol)` | Verifica si el usuario tiene el rol indicado | RF-02 | RN-01 |
| `asignar_rol(usuario, rol)` | Asigna un rol a un usuario | RF-02 | RN-01 |
| `obtener_permisos(rol)` | Retorna los permisos del rol | RF-02 | RN-01 |

**Implementación Django:**
```python
class RolManager:
    def verificar_rol(self, usuario, rol_nombre):
        return usuario.id_rol.nombre_rol == rol_nombre

    def asignar_rol(self, usuario, rol):
        usuario.id_rol = rol
        usuario.save()

    def obtener_permisos(self, rol):
        permisos = {
            'Estudiante': ['ver_mapa', 'buscar_aula', 'ver_horario'],
            'Docente': ['ver_horario', 'ver_aulas'],
            'Administrador': ['gestionar_todo']
        }
        return permisos.get(rol.nombre_rol, [])        

CL3 — EstudianteManager
Método	Descripción	RF	RN
registrar(datos)	Crea un nuevo perfil de estudiante	RF-09	RN-02
actualizar(estudiante, datos)	Actualiza datos del estudiante	RF-09	RN-02
obtener_horario(estudiante)	Retorna el horario del estudiante	RF-04	RN-02
buscar_aula(codigo)	Busca un aula por código	RF-03	RN-08
obtener_historial(estudiante)	Retorna el historial de consultas	RF-05	RN-09
Implementación Django:

python
Copy
class EstudianteManager:
    def obtener_horario(self, estudiante):
        return Asignacion.objects.filter(
            id_materia__id_carrera=estudiante.id_carrera
        ).select_related('id_materia', 'id_aula', 'id_horario')

    def buscar_aula(self, codigo):
        return Aula.objects.filter(
            codigo_aula=codigo,
            estado__in=['DISPONIBLE', 'OCUPADA']
        ).first()

    def obtener_historial(self, estudiante):
        return Consulta.objects.filter(
            id_estudiante=estudiante
        ).order_by('-fecha_consulta')
CL4 — DocenteManager
Método	Descripción	RF	RN
registrar(datos)	Crea un nuevo perfil de docente	RF-09	—
actualizar(docente, datos)	Actualiza datos del docente	RF-09	—
obtener_horario(docente)	Retorna el horario del docente	RF-06	RN-12
obtener_aulas(docente)	Retorna las aulas asignadas al docente	RF-07	RN-12
Implementación Django:

python
Copy
class DocenteManager:
    def obtener_horario(self, docente):
        return Asignacion.objects.filter(
            id_docente=docente
        ).select_related('id_materia', 'id_aula', 'id_horario')

    def obtener_aulas(self, docente):
        return Aula.objects.filter(
            asignacion__id_docente=docente
        ).distinct()
CL5 — AdministradorManager
Método	Descripción	RF	RN
gestionar_usuarios(accion, datos)	CRUD completo de usuarios	RF-09	RN-13
gestionar_aulas(accion, datos)	CRUD completo de aulas	RF-08	RN-13
gestionar_asignaciones(accion, datos)	CRUD completo de asignaciones	RF-10	RN-13
Implementación Django:

python
Copy
class AdministradorManager:
    def gestionar_usuarios(self, accion, datos):
        if accion == 'crear':
            return Usuarios.objects.create(**datos)
        elif accion == 'actualizar':
            return Usuarios.objects.filter(
                id_usuario=datos['id']
            ).update(**datos)
        elif accion == 'eliminar':
            return Usuarios.objects.filter(
                id_usuario=datos['id']
            ).delete()

    def gestionar_aulas(self, accion, datos):
        if accion == 'crear':
            return Aula.objects.create(**datos)
        elif accion == 'actualizar':
            return Aula.objects.filter(
                id_aula=datos['id']
            ).update(**datos)
        elif accion == 'eliminar':
            return Aula.objects.filter(
                id_aula=datos['id']
            ).delete()
CL6 — AulaManager
Método	Descripción	RF	RN
crear(datos)	Crea un nuevo aula	RF-08	RN-05
actualizar(aula, datos)	Actualiza datos del aula	RF-08	RN-05
eliminar(aula)	Elimina un aula	RF-08	—
cambiar_estado(aula, estado)	Cambia el estado del aula	RF-08	RN-07
buscar(filtros)	Busca aulas por filtros	RF-03	RN-08
Implementación Django:

python
Copy
class AulaManager:
    def buscar(self, filtros):
        qs = Aula.objects.all()
        if filtros.get('tipo'):
            qs = qs.filter(tipo=filtros['tipo'])
        if filtros.get('capacidad'):
            qs = qs.filter(capacidad__gte=filtros['capacidad'])
        if filtros.get('estado'):
            qs = qs.filter(estado=filtros['estado'])
        return qs

    def cambiar_estado(self, aula, nuevo_estado):
        aula.estado = nuevo_estado
        aula.save()
CL7 — MapaManager
Método	Descripción	RF	RN
mostrar_mapa()	Renderiza el mapa interactivo	RF-11	—
calcular_ruta(origen, destino)	Calcula la ruta entre dos puntos	RF-12	RN-14
obtener_ubicacion(aula)	Retorna las coordenadas del aula	RF-11	RN-14
Implementación Django:

python
Copy
class MapaManager:
    def obtener_ubicacion(self, aula):
        return Ubicacion.objects.filter(id_aula=aula).first()

    def calcular_ruta(self, origen_id, destino_id):
        origen = Ubicacion.objects.get(id_aula=origen_id)
        destino = Ubicacion.objects.get(id_aula=destino_id)
        return {
            'origen': {'lat': origen.latitud, 'lng': origen.longitud},
            'destino': {'lat': destino.latitud, 'lng': destino.longitud}
        }
CL8 — ConsultaManager
Método	Descripción	RF	RN
registrar_consulta(estudiante, aula)	Registra automáticamente una consulta	RF-13	RN-09
obtener_historial(estudiante)	Retorna el historial del estudiante	RF-05	RN-09
filtrar(estudiante, fecha)	Filtra el historial por fecha	RF-05	—
Implementación Django:

python
Copy
class ConsultaManager:
    def registrar_consulta(self, estudiante, aula, resultado='EXITOSA'):
        return Consulta.objects.create(
            id_estudiante=estudiante,
            id_aula=aula,
            resultado=resultado
        )

    def obtener_historial(self, estudiante):
        return Consulta.objects.filter(
            id_estudiante=estudiante
        ).order_by('-fecha_consulta')

    def filtrar(self, estudiante, fecha):
        return Consulta.objects.filter(
            id_estudiante=estudiante,
            fecha_consulta__date=fecha
        )
CL9 — AsignacionManager
Método	Descripción	RF	RN
crear(datos)	Crea una nueva asignación	RF-10	RN-06
actualizar(asignacion, datos)	Actualiza una asignación	RF-10	RN-06
eliminar(asignacion)	Elimina una asignación	RF-10	—
validar_solapamiento(aula, horario, periodo)	Verifica que no haya solapamiento	RF-10	RN-07
Implementación Django:

python
Copy
class AsignacionManager:
    def validar_solapamiento(self, aula, horario, periodo, excluir_id=None):
        qs = Asignacion.objects.filter(
            id_aula=aula,
            id_horario=horario,
            periodo=periodo
        )
        if excluir_id:
            qs = qs.exclude(id_asignacion=excluir_id)
        return qs.exists()

    def crear(self, datos):
        if self.validar_solapamiento(
            datos['id_aula'], datos['id_horario'], datos['periodo']
        ):
            raise ValueError("Solapamiento detectado en aula y horario.")
        return Asignacion.objects.create(**datos)
CL10 — NotificacionManager
Método	Descripción	RF	RN
enviar(usuario, titulo, mensaje)	Envía una notificación	RF-14	RN-10
marcar_leida(notificacion)	Marca la notificación como leída	RF-14	—
eliminar(notificacion)	Elimina una notificación	RF-14	—
listar(usuario)	Lista las notificaciones del usuario	RF-14	—
Implementación Django:

python
Copy
class NotificacionManager:
    def enviar(self, usuario, titulo, mensaje):
        return Notificacion.objects.create(
            id_usuario=usuario,
            titulo=titulo,
            mensaje=mensaje,
            estado='ENVIADA'
        )

    def marcar_leida(self, notificacion):
        notificacion.estado = 'LEIDA'
        notificacion.save()

    def listar(self, usuario):
        return Notificacion.objects.filter(
            id_usuario=usuario
        ).exclude(estado='ELIMINADA').order_by('-fecha_envio')
CL11 — SoporteManager
Método	Descripción	RF	RN
reportar(estudiante, aula, descripcion)	Crea un reporte de soporte	RF-15	RN-11
actualizar_estado(reporte, estado)	Actualiza el estado del reporte	RF-16	RN-11
listar_reportes(filtros)	Lista reportes con filtros	RF-16	RN-11
Implementación Django:

python
Copy
class SoporteManager:
    def reportar(self, estudiante, aula, descripcion):
        return ReporteSoporte.objects.create(
            id_estudiante=estudiante,
            id_aula=aula,
            descripcion=descripcion,
            estado='PENDIENTE'
        )

    def actualizar_estado(self, reporte, nuevo_estado):
        reporte.estado = nuevo_estado
        reporte.save()

    def listar_reportes(self, filtros=None):
        qs = ReporteSoporte.objects.all()
        if filtros and filtros.get('estado'):
            qs = qs.filter(estado=filtros['estado'])
        return qs.order_by('-fecha_reporte')