# E5 — Diagrama de Componentes UML

## Descripción
El diagrama de componentes representa la estructura interna del SIGAU,
mostrando los módulos de software, sus responsabilidades y las dependencias
entre ellos.

---

## Componentes del Sistema

### 🖥️ Capa de Presentación (Frontend)
Responsable de renderizar la interfaz de usuario en el navegador web.

| Componente | Responsabilidad |
|---|---|
| `UI.Login` | Formulario de autenticación con correo institucional y contraseña |
| `UI.Dashboard` | Vista principal del estudiante con próxima clase y accesos rápidos |
| `UI.Mapa` | Renderizado del mapa interactivo de torres, pisos y aulas |
| `UI.Horario` | Visualización del horario académico personalizado del estudiante |
| `UI.Notificaciones` | Centro de notificaciones y alertas académicas |
| `UI.Asistente` | Interfaz conversacional del asistente virtual |
| `UI.Soporte` | Formulario de reporte de fallos y consulta de estado |
| `UI.AdminPanel` | Panel de administración para gestión CRUD de datos maestros |

---

### ⚙️ Capa de Lógica de Negocio (Backend)
Procesa las reglas del dominio y orquesta los servicios del sistema.

| Componente | Responsabilidad |
|---|---|
| `Auth.Controller` | Valida credenciales, genera tokens de sesión y gestiona roles |
| `Mapa.Controller` | Procesa solicitudes de visualización del mapa y búsqueda de aulas |
| `Ruta.Controller` | Calcula la ruta óptima entre origen y aula destino |
| `Horario.Controller` | Consulta y entrega el horario académico del estudiante |
| `Notif.Controller` | Gestiona la creación y envío de notificaciones |
| `Asistente.Controller` | Procesa consultas en lenguaje natural y genera respuestas |
| `Soporte.Controller` | Registra reportes de fallos y actualiza su estado |
| `Admin.Controller` | Gestiona operaciones CRUD sobre datos maestros del sistema |

---

### 🗄️ Capa de Acceso a Datos (DAL)
Abstrae las operaciones de persistencia sobre la base de datos.

| Componente | Responsabilidad |
|---|---|
| `Usuario.Repository` | CRUD sobre USUARIOS, ESTUDIANTE, ADMINISTRADOR, ROL |
| `Academico.Repository` | CRUD sobre MATERIA, CARRERA, DOCENTE, ASIGNACION |
| `Campus.Repository` | CRUD sobre TORRE, PISO, AULA, UBICACION, RUTA |
| `Historial.Repository` | Registro y consulta de HISTORIAL y CONSULTA |
| `Notif.Repository` | Persistencia de NOTIFICACION |
| `Soporte.Repository` | Persistencia de REPORTE_SOPORTE |

---

### 🔌 Servicios Externos
Componentes externos integrados al sistema.

| Componente | Responsabilidad |
|---|---|
| `Servicio.Notificaciones` | Entrega de alertas en tiempo real al estudiante |
| `Servicio.IA` | Motor de procesamiento de lenguaje natural del asistente virtual |
| `Servicio.HTTPS` | Canal cifrado TLS para todas las comunicaciones |

---

## Diagrama de Componentes (PlantUML)

```plantuml
@startuml
package "Capa de Presentación" {
  [UI.Login]
  [UI.Dashboard]
  [UI.Mapa]
  [UI.Horario]
  [UI.Notificaciones]
  [UI.Asistente]
  [UI.Soporte]
  [UI.AdminPanel]
}

package "Capa de Lógica de Negocio" {
  [Auth.Controller]
  [Mapa.Controller]
  [Ruta.Controller]
  [Horario.Controller]
  [Notif.Controller]
  [Asistente.Controller]
  [Soporte.Controller]
  [Admin.Controller]
}

package "Capa de Acceso a Datos" {
  [Usuario.Repository]
  [Academico.Repository]
  [Campus.Repository]
  [Historial.Repository]
  [Notif.Repository]
  [Soporte.Repository]
}

database "Base de Datos" as DB

[UI.Login] --> [Auth.Controller]
[UI.Dashboard] --> [Horario.Controller]
[UI.Mapa] --> [Mapa.Controller]
[UI.Mapa] --> [Ruta.Controller]
[UI.Horario] --> [Horario.Controller]
[UI.Notificaciones] --> [Notif.Controller]
[UI.Asistente] --> [Asistente.Controller]
[UI.Soporte] --> [Soporte.Controller]
[UI.AdminPanel] --> [Admin.Controller]

[Auth.Controller] --> [Usuario.Repository]
[Mapa.Controller] --> [Campus.Repository]
[Ruta.Controller] --> [Campus.Repository]
[Horario.Controller] --> [Academico.Repository]
[Notif.Controller] --> [Notif.Repository]
[Asistente.Controller] --> [Academico.Repository]
[Soporte.Controller] --> [Soporte.Repository]
[Admin.Controller] --> [Usuario.Repository]
[Admin.Controller] --> [Academico.Repository]
[Admin.Controller] --> [Campus.Repository]

[Usuario.Repository] --> DB
[Academico.Repository] --> DB
[Campus.Repository] --> DB
[Historial.Repository] --> DB
[Notif.Repository] --> DB
[Soporte.Repository] --> DB

[Notif.Controller] --> [Servicio.Notificaciones]
[Asistente.Controller] --> [Servicio.IA]
@enduml