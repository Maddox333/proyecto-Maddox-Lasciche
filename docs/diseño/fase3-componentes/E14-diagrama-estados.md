# E14 — Diagrama de Estados

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Diagrama 1: Estados de un Aula

**Descripción:** Ciclo de vida de un aula dentro del sistema

                [REGISTRO]
                    |
                    v
          +------------------+
          |   DISPONIBLE     |<---------+
          +------------------+          |
                    |                   |
          [asignar horario]    [liberar aula]
                    |                   |
                    v                   |
          +------------------+          |
          |    OCUPADA       |----------+
          +------------------+
                    |
          [reportar problema]
                    |
                    v
          +------------------+
          |  EN MANTENIMIENTO|
          +------------------+
                    |
          [resolver problema]
                    |
                    v
          +------------------+
          |   DISPONIBLE     |
          +------------------+
                    |
          [dar de baja]
                    |
                    v
          +------------------+
          |   INACTIVA       |
          +------------------+

| Estado | Descripción |
|---|---|
| DISPONIBLE | El aula está libre y puede ser asignada |
| OCUPADA | El aula tiene una asignación activa |
| EN MANTENIMIENTO | El aula está fuera de servicio temporalmente |
| INACTIVA | El aula fue dada de baja del sistema |

---

## Diagrama 2: Estados de una Consulta

**Descripción:** Ciclo de vida de una consulta de aula realizada por un estudiante

                [INICIO]
                    |
                    v
          +------------------+
          |    INICIADA      |
          +------------------+
                    |
          [buscar aula]
                    |
                    v
          +------------------+
          |   EN PROCESO     |
          +------------------+
               /        \
    [aula encontrada]  [aula no encontrada]
           /                  \
          v                    v
+------------------+ +------------------+
| EXITOSA | | FALLIDA |
+------------------+ +------------------+
\ /
\ /
v v
+------------------+
| REGISTRADA |
+------------------+
|
[guardar en historial]
|
v
[FIN]


| Estado | Descripción |
|---|---|
| INICIADA | El estudiante comenzó la búsqueda |
| EN PROCESO | El sistema está procesando la consulta |
| EXITOSA | Se encontró el aula solicitada |
| FALLIDA | No se encontró el aula solicitada |
| REGISTRADA | La consulta fue guardada en el historial |

---

## Diagrama 3: Estados de un Reporte de Soporte

**Descripción:** Ciclo de vida de un reporte de fallo enviado por un estudiante

                [CREACIÓN]
                    |
                    v
          +------------------+
          |     ABIERTO      |
          +------------------+
                    |
          [admin revisa]
                    |
                    v
          +------------------+
          |   EN REVISIÓN    |
          +------------------+
               /        \
    [se puede resolver] [no procede]
           /                  \
          v                    v
+------------------+ +------------------+
| EN PROCESO | | RECHAZADO |
+------------------+ +------------------+
|
[problema resuelto]
|
v
+------------------+
| CERRADO |
+------------------+


| Estado | Descripción |
|---|---|
| ABIERTO | El reporte fue creado y está pendiente de revisión |
| EN REVISIÓN | El administrador está analizando el reporte |
| EN PROCESO | Se está trabajando en la solución |
| RECHAZADO | El reporte no procede o es duplicado |
| CERRADO | El problema fue resuelto satisfactoriamente |

---

## Diagrama 4: Estados de una Notificación

**Descripción:** Ciclo de vida de una notificación enviada a un estudiante

                [GENERACIÓN]
                    |
                    v
          +------------------+
          |     ENVIADA      |
          +------------------+
                    |
          [estudiante accede]
                    |
                    v
          +------------------+
          |     RECIBIDA     |
          +------------------+
                    |
          [estudiante lee]
                    |
                    v
          +------------------+
          |      LEÍDA       |
          +------------------+
                    |
          [estudiante elimina]
                    |
                    v
          +------------------+
          |    ELIMINADA     |
          +------------------+

| Estado | Descripción |
|---|---|
| ENVIADA | La notificación fue generada y enviada |
| RECIBIDA | El estudiante accedió al sistema |
| LEÍDA | El estudiante leyó la notificación |
| ELIMINADA | El estudiante eliminó la notificación |

---

## Diagrama 5: Estados de un Usuario

**Descripción:** Ciclo de vida de un usuario en el sistema

                [REGISTRO]
                    |
                    v
          +------------------+
          |     ACTIVO       |<---------+
          +------------------+          |
                    |                   |
          [suspender cuenta]  [reactivar cuenta]
                    |                   |
                    v                   |
          +------------------+          |
          |    SUSPENDIDO    |----------+
          +------------------+
                    |
          [eliminar cuenta]
                    |
                    v
          +------------------+
          |    ELIMINADO     |
          +------------------+

| Estado | Descripción |
|---|---|
| ACTIVO | El usuario puede acceder al sistema normalmente |
| SUSPENDIDO | El acceso fue bloqueado temporalmente |
| ELIMINADO | La cuenta fue dada de baja definitivamente |

---

## Resumen de Diagramas de Estado

| # | Entidad | Estados | Transiciones |
|---|---|---|---|
| 1 | Aula | DISPONIBLE, OCUPADA, EN MANTENIMIENTO, INACTIVA | 5 |
| 2 | Consulta | INICIADA, EN PROCESO, EXITOSA, FALLIDA, REGISTRADA | 5 |
| 3 | Reporte de Soporte | ABIERTO, EN REVISIÓN, EN PROCESO, RECHAZADO, CERRADO | 5 |
| 4 | Notificación | ENVIADA, RECIBIDA, LEÍDA, ELIMINADA | 4 |
| 5 | Usuario | ACTIVO, SUSPENDIDO, ELIMINADO | 4 |
