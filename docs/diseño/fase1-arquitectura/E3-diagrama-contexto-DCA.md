# E3 — Diagrama de Contexto Arquitectónico (DCA)

## Sistema Central: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

## Descripción Textual del DCA

### Flujos desde y hacia usuarios humanos

**Estudiante:**  
Representa el flujo de mayor frecuencia e importancia. Desde su dispositivo
(PC, smartphone o tablet), envía credenciales al SIGAU para autenticarse;
el sistema responde con una sesión activa y le entrega su horario académico
personalizado. Posteriormente, el estudiante puede solicitar la visualización
del mapa interactivo de torres y aulas, interactuar con el asistente virtual
mediante consultas en lenguaje natural, y enviar formularios de reporte de
problemas. En sentido inverso, el SIGAU le devuelve respuestas del asistente,
notificaciones académicas y confirmaciones de sus acciones.

**Administrador del Sistema:**  
Establece un flujo de gestión bidireccional: envía al SIGAU los datos maestros
de horarios, docentes y aulas (operaciones CRUD), y el sistema le retorna paneles
de supervisión, confirmaciones de cambios aplicados y reportes de incidencias
generadas por los estudiantes.

**Equipo de Desarrollo:**  
Interactúa con el SIGAU en el plano operativo-técnico: despliega actualizaciones,
aplica correcciones y ejecuta migraciones; el sistema expone logs, métricas de
rendimiento y tickets de error que alimentan el ciclo de mantenimiento continuo.

---

### Flujos hacia sistemas técnicos intermedios

**Navegador Web:**  
Actúa como intermediario entre el usuario y el SIGAU: transporta peticiones HTTP/S
con los datos de interacción del usuario y recibe del sistema respuestas con la
interfaz renderizada (HTML/CSS/JS) y datos estructurados en JSON.

**Infraestructura HTTPS / Red:**  
Envuelve todos los flujos anteriores: el SIGAU delega en este canal el cifrado TLS
de cada paquete transmitido, garantizando confidencialidad e integridad en cada
comunicación cliente-servidor.

---

### Flujos hacia sistemas subordinados

**Base de Datos:**  
Recibe del SIGAU todas las operaciones de persistencia (consultas, inserciones,
actualizaciones y eliminaciones sobre usuarios, horarios, aulas, docentes y reportes)
y devuelve los conjuntos de datos resultantes que la lógica de negocio necesita
para construir las respuestas.

**Asistente Virtual:**  
Recibe del SIGAU las consultas textuales del estudiante acompañadas de contexto
de sesión (carrera, horario vigente, ubicación en el mapa) y retorna respuestas
generadas en lenguaje natural que el sistema presenta al usuario.

**Servicio de Notificaciones:**  
Recibe del SIGAU las solicitudes de envío de alertas (con destinatario, contenido
y tipo de notificación) y confirma al sistema el estado de entrega.

---

### Flujo desde el sistema superior

**Universidad / Institución Académica:**  
Ocupa el rol de sistema superior en la jerarquía: provee al SIGAU los lineamientos
institucionales, la información académica oficial (estructura de campus, programas,
calendarios) y la base de identidad de usuarios válidos.

---

## Diagrama DCA (PlantUML)

```plantuml
@startuml
!define RECTANGLE class

actor Estudiante
actor Administrador
actor "Equipo de Desarrollo" as Dev

rectangle "SIGAU" as Sistema {
}

database "Base de Datos" as DB
rectangle "Asistente Virtual" as AV
rectangle "Servicio de\nNotificaciones" as Notif
rectangle "Navegador Web" as Browser
rectangle "HTTPS / Red" as HTTPS
rectangle "Universidad" as Uni

Estudiante --> Browser : credenciales, consultas
Browser --> HTTPS : HTTP/S
HTTPS --> Sistema : peticiones cifradas

Administrador --> Sistema : CRUD horarios/aulas/docentes
Dev --> Sistema : actualizaciones, migraciones

Sistema --> DB : CRUD SQL
DB --> Sistema : datos

Sistema --> AV : consulta + contexto
AV --> Sistema : respuesta lenguaje natural

Sistema --> Notif : solicitud de alerta
Notif --> Sistema : confirmación entrega

Uni --> Sistema : info académica oficial
Sistema --> Uni : reportes de uso

Sistema --> Browser : HTML/CSS/JS/JSON
Browser --> Estudiante : interfaz renderizada
@enduml