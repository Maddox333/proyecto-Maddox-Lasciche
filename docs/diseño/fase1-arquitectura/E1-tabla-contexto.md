# E1 — Tabla de Contexto

## Sistema Central: SIGAU
**Sistema de Información y Gestión Académica Universitaria**  
Corporación Universitaria Remington

| # | Entidad Externa | Tipo | Descripción | Requisito que la justifica |
|---|---|---|---|---|
| 1 | Estudiante | Usuario (Actor Principal) | Usuario final del sistema. Accede desde computadores, smartphones o tablets mediante navegador web para consultar horarios, navegar el mapa, recibir notificaciones y reportar problemas. | RF1, RF9, RF11, RF13 |
| 2 | Administrador del Sistema | Usuario (Actor de Gestión) | Actor interno-operativo que gestiona la información académica (horarios, docentes, aulas) y supervisa el funcionamiento general de la aplicación. | RF admin CRUD |
| 3 | Navegador Web (Cliente) | Sistema Par (Intermediario Técnico) | Chrome, Edge o Firefox actúan como capa de presentación del sistema; renderizan la interfaz gráfica y transmiten peticiones HTTP/S hacia el servidor. | RNF18 |
| 4 | Base de Datos | Sistema Subordinado | Almacena y provee persistencia para usuarios, horarios, docentes y aulas. Responde a consultas originadas por la lógica del servidor. | RNF23 |
| 5 | Servicio de Notificaciones | Sistema Par (Servicio Externo) | Componente encargado de entregar alertas y avisos dentro de la aplicación a los estudiantes en tiempo real. | RF15, RF16, RF17 |
| 6 | Asistente Virtual (IA) | Sistema Subordinado / Par | Motor conversacional integrado en la interfaz que responde consultas del estudiante sobre horarios, aulas y orientación en el campus. | RF22 |
| 7 | Infraestructura HTTPS / Red | Sistema Par (Canal de Comunicación) | Protocolo y red que garantiza la transmisión cifrada y segura de todos los datos entre clientes y servidor. | RNF14, RNF15 |
| 8 | Universidad / Institución Académica | Sistema Superior (Propietario) | Entidad que define los requisitos institucionales, provee la información académica oficial y es beneficiaria directa del sistema. | RF4, RF5, RF6 |
| 9 | Equipo de Desarrollo | Actor de Soporte | Responsables del ciclo de vida del sistema: diseño, implementación y mantenimiento. | RNF21 |

## Síntesis
El SIGAU opera como hub central que orquesta la interacción entre:
- **2 usuarios humanos directos:** Estudiante y Administrador
- **1 actor de soporte técnico:** Equipo de Desarrollo
- **1 entidad rectora superior:** Universidad
- **2 sistemas subordinados:** Base de Datos y Asistente Virtual
- **1 servicio par de mensajería:** Notificaciones
- **2 componentes de infraestructura transversal:** Navegador Web e HTTPS

> Todos los flujos de datos están protegidos por HTTPS (RNF14).