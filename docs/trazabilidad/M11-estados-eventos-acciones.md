# M11 — Matriz de Trazabilidad: Estados, Entidades y Reglas de Negocio

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona los diagramas de estado con las entidades del
sistema y las Reglas de Negocio (RN) que gobiernan las transiciones
de estado, verificando que toda la lógica de estados está cubierta.

---

## Entidades con Estado

| # | Entidad | Estados posibles | RN asociadas |
|---|---|---|---|
| E1 | AULA | DISPONIBLE, OCUPADA, MANTENIMIENTO | RN-05, RN-07 |
| E2 | ASIGNACION | ACTIVA, INACTIVA, CANCELADA | RN-06, RN-07 |
| E3 | CONSULTA | EXITOSA, FALLIDA | RN-09 |
| E4 | NOTIFICACION | ENVIADA, LEIDA, ELIMINADA | RN-10 |
| E5 | REPORTE_SOPORTE | PENDIENTE, EN_REVISION, RESUELTO | RN-11 |
| E6 | USUARIO (sesión) | ACTIVO, INACTIVO, BLOQUEADO | RN-15 |

---

## Matriz Principal: Estados — Entidades — RN

| Entidad | Estado Inicial | Transiciones | Estado Final | RN |
|---|---|---|---|---|
| AULA | DISPONIBLE | DISPONIBLE → OCUPADA (asignación activa) | OCUPADA | RN-07 |
| AULA | OCUPADA | OCUPADA → DISPONIBLE (asignación termina) | DISPONIBLE | RN-07 |
| AULA | DISPONIBLE | DISPONIBLE → MANTENIMIENTO (admin) | MANTENIMIENTO | RN-05 |
| AULA | MANTENIMIENTO | MANTENIMIENTO → DISPONIBLE (admin) | DISPONIBLE | RN-05 |
| ASIGNACION | ACTIVA | ACTIVA → INACTIVA (periodo termina) | INACTIVA | RN-06 |
| ASIGNACION | ACTIVA | ACTIVA → CANCELADA (admin cancela) | CANCELADA | RN-06 |
| CONSULTA | — | Búsqueda exitosa → EXITOSA | EXITOSA | RN-09 |
| CONSULTA | — | Búsqueda fallida → FALLIDA | FALLIDA | RN-09 |
| NOTIFICACION | ENVIADA | ENVIADA → LEIDA (usuario abre) | LEIDA | RN-10 |
| NOTIFICACION | LEIDA | LEIDA → ELIMINADA (usuario elimina) | ELIMINADA | RN-10 |
| NOTIFICACION | ENVIADA | ENVIADA → ELIMINADA (usuario elimina) | ELIMINADA | RN-10 |
| REPORTE_SOPORTE | PENDIENTE | PENDIENTE → EN_REVISION (admin revisa) | EN_REVISION | RN-11 |
| REPORTE_SOPORTE | EN_REVISION | EN_REVISION → RESUELTO (admin resuelve) | RESUELTO | RN-11 |
| USUARIO (sesión) | INACTIVO | INACTIVO → ACTIVO (login exitoso) | ACTIVO | RN-15 |
| USUARIO (sesión) | ACTIVO | ACTIVO → INACTIVO (logout) | INACTIVO | RN-15 |
| USUARIO (sesión) | ACTIVO | ACTIVO → BLOQUEADO (3 intentos fallidos) | BLOQUEADO | RN-15 |

---

## Detalle por Entidad

### E1 — AULA

**Estados:**
- `DISPONIBLE` — El aula está libre y puede ser asignada
- `OCUPADA` — El aula tiene una asignación activa en el horario actual
- `MANTENIMIENTO` — El aula no está disponible por mantenimiento

**Diagrama de transiciones:**
[DISPONIBLE] ──asignación activa──► [OCUPADA]
[OCUPADA] ──asignación termina──► [DISPONIBLE]
[DISPONIBLE] ──admin pone en mantenimiento──► [MANTENIMIENTO]
[MANTENIMIENTO] ──admin habilita──► [DISPONIBLE]


**Reglas de Negocio:**
| RN | Descripción | Transición afectada |
|---|---|---|
| RN-05 | Solo el administrador puede cambiar el estado a MANTENIMIENTO | DISPONIBLE → MANTENIMIENTO |
| RN-07 | Un aula OCUPADA no puede ser asignada en el mismo horario | DISPONIBLE → OCUPADA |

**Implementación Django:**
```python
class Aula(models.Model):
    ESTADOS = [
        ('DISPONIBLE', 'Disponible'),
        ('OCUPADA', 'Ocupada'),
        ('MANTENIMIENTO', 'Mantenimiento'),
    ]
    estado = models.CharField(
        max_length=20,
        choices=ESTADOS,
        default='DISPONIBLE'
    )

    def poner_en_mantenimiento(self, usuario):
        if usuario.id_rol.nombre_rol != 'Administrador':
            raise PermissionError("Solo el administrador puede hacer esto.")
        self.estado = 'MANTENIMIENTO'
        self.save()

    def habilitar(self):
        self.estado = 'DISPONIBLE'
        self.save()
E2 — ASIGNACION
Estados:

ACTIVA — La asignación está vigente en el periodo actual
INACTIVA — El periodo de la asignación ha terminado
CANCELADA — El administrador canceló la asignación
Diagrama de transiciones:

[ACTIVA] ──periodo termina──► [INACTIVA]
[ACTIVA] ──admin cancela──► [CANCELADA]
Reglas de Negocio:

RN	Descripción	Transición afectada
RN-06	No puede haber dos asignaciones activas para la misma aula en el mismo horario y periodo	Creación → ACTIVA
RN-07	Al cancelar una asignación, el aula vuelve a DISPONIBLE	ACTIVA → CANCELADA
Implementación Django:

python

class Asignacion(models.Model):
    ESTADOS = [
        ('ACTIVA', 'Activa'),
        ('INACTIVA', 'Inactiva'),
        ('CANCELADA', 'Cancelada'),
    ]
    estado = models.CharField(
        max_length=20,
        choices=ESTADOS,
        default='ACTIVA'
    )

    def cancelar(self):
        self.estado = 'CANCELADA'
        self.id_aula.estado = 'DISPONIBLE'
        self.id_aula.save()
        self.save()
E3 — CONSULTA
Estados:

EXITOSA — La búsqueda encontró el aula solicitada
FALLIDA — La búsqueda no encontró resultados
Diagrama de transiciones:

[búsqueda realizada] ──aula encontrada──► [EXITOSA]
[búsqueda realizada] ──aula no encontrada──► [FALLIDA]
Reglas de Negocio:

RN	Descripción	Transición afectada
RN-09	Toda búsqueda de aula debe registrarse automáticamente con su resultado	Búsqueda → EXITOSA/FALLIDA
Implementación Django:

python

class Consulta(models.Model):
    RESULTADOS = [
        ('EXITOSA', 'Exitosa'),
        ('FALLIDA', 'Fallida'),
    ]
    resultado = models.CharField(
        max_length=20,
        choices=RESULTADOS,
        default='EXITOSA'
    )
E4 — NOTIFICACION
Estados:

ENVIADA — La notificación fue creada y está pendiente de lectura
LEIDA — El usuario abrió la notificación
ELIMINADA — El usuario eliminó la notificación
Diagrama de transiciones:

[ENVIADA] ──usuario abre──► [LEIDA]
[LEIDA] ──usuario elimina──► [ELIMINADA]
[ENVIADA] ──usuario elimina──► [ELIMINADA]
Reglas de Negocio:

RN	Descripción	Transición afectada
RN-10	Una notificación ELIMINADA no puede volver a ENVIADA ni LEIDA	ELIMINADA (estado final)
Implementación Django:

python

class Notificacion(models.Model):
    ESTADOS = [
        ('ENVIADA', 'Enviada'),
        ('LEIDA', 'Leída'),
        ('ELIMINADA', 'Eliminada'),
    ]
    estado = models.CharField(
        max_length=20,
        choices=ESTADOS,
        default='ENVIADA'
    )

    def marcar_leida(self):
        if self.estado == 'ENVIADA':
            self.estado = 'LEIDA'
            self.save()

    def eliminar_notificacion(self):
        if self.estado != 'ELIMINADA':
            self.estado = 'ELIMINADA'
            self.save()
E5 — REPORTE_SOPORTE
Estados:

PENDIENTE — El reporte fue enviado y espera revisión
EN_REVISION — El administrador está revisando el reporte
RESUELTO — El problema fue solucionado
Diagrama de transiciones:

[PENDIENTE] ──admin revisa──► [EN_REVISION]
[EN_REVISION] ──admin resuelve──► [RESUELTO]
Reglas de Negocio:

RN	Descripción	Transición afectada
RN-11	Solo el administrador puede cambiar el estado del reporte	Todas las transiciones
RN-11	Un reporte RESUELTO no puede volver a PENDIENTE	RESUELTO (estado final)
Implementación Django:

python

class ReporteSoporte(models.Model):
    ESTADOS = [
        ('PENDIENTE', 'Pendiente'),
        ('EN_REVISION', 'En revisión'),
        ('RESUELTO', 'Resuelto'),
    ]
    estado = models.CharField(
        max_length=20,
        choices=ESTADOS,
        default='PENDIENTE'
    )

    def iniciar_revision(self, usuario):
        if usuario.id_rol.nombre_rol != 'Administrador':
            raise PermissionError("Solo el administrador puede revisar reportes.")
        if self.estado == 'PENDIENTE':
            self.estado = 'EN_REVISION'
            self.save()

    def resolver(self, usuario):
        if usuario.id_rol.nombre_rol != 'Administrador':
            raise PermissionError("Solo el administrador puede resolver reportes.")
        if self.estado == 'EN_REVISION':
            self.estado = 'RESUELTO'
            self.save()
E6 — USUARIO (Sesión)
Estados:

INACTIVO — El usuario no ha iniciado sesión
ACTIVO — El usuario tiene sesión activa
BLOQUEADO — El usuario fue bloqueado por intentos fallidos
Diagrama de transiciones:

[INACTIVO] ──login exitoso──► [ACTIVO]
[ACTIVO] ──logout──► [INACTIVO]
[ACTIVO] ──3 intentos fallidos──► [BLOQUEADO]
[BLOQUEADO] ──admin desbloquea──► [INACTIVO]
Reglas de Negocio:

RN	Descripción	Transición afectada
RN-15	Después de 3 intentos fallidos, la cuenta queda BLOQUEADA	ACTIVO → BLOQUEADO
RN-15	Solo el administrador puede desbloquear una cuenta	BLOQUEADO → INACTIVO
Implementación Django:

python

class Usuarios(models.Model):
    intentos_fallidos = models.IntegerField(default=0)
    bloqueado = models.BooleanField(default=False)

    def registrar_intento_fallido(self):
        self.intentos_fallidos += 1
        if self.intentos_fallidos >= 3:
            self.bloqueado = True
        self.save()

    def desbloquear(self, admin):
        if admin.id_rol.nombre_rol == 'Administrador':
            self.bloqueado = False
            self.intentos_fallidos = 0
            self.save()
Cobertura de RN por Estado
RN	Entidad	Transición cubierta	Estado
RN-05	AULA	DISPONIBLE ↔ MANTENIMIENTO	✅
RN-06	ASIGNACION	Validación al crear → ACTIVA	✅
RN-07	AULA / ASIGNACION	DISPONIBLE → OCUPADA / CANCELADA → DISPONIBLE	✅
RN-09	CONSULTA	Búsqueda → EXITOSA / FALLIDA	✅
RN-10	NOTIFICACION	ENVIADA → LEIDA → ELIMINADA	✅
RN-11	REPORTE_SOPORTE	PENDIENTE → EN_REVISION → RESUELTO	✅
RN-15	USUARIO	ACTIVO → BLOQUEADO / BLOQUEADO → INACTIVO	✅
Cobertura total: 7/7 RN con estados — 100% ✅