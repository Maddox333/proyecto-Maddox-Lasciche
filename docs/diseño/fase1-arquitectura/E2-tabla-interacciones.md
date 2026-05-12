# E2 — Tabla de Interacciones

## Sistema Central: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

| # | Entidad Externa | Envía al Sistema | Recibe del Sistema |
|---|---|---|---|
| 1 | Estudiante | Credenciales de inicio de sesión · Solicitudes de consulta de horario · Solicitudes de navegación por el mapa · Preguntas al asistente virtual · Formularios de reporte de problemas técnicos | Confirmación de autenticación · Horario académico personalizado · Mapa interactivo con ubicación de torres y aulas · Respuestas del asistente virtual · Notificaciones académicas · Acuse de recibo del reporte enviado |
| 2 | Administrador del Sistema | Datos de horarios, docentes y aulas (altas, bajas y modificaciones) · Parámetros de configuración del sistema · Solicitudes de supervisión y monitoreo | Panel de administración con estado del sistema · Confirmaciones de cambios aplicados · Reportes de incidencias enviadas por estudiantes · Alertas de fallos o anomalías operativas |
| 3 | Navegador Web (Cliente) | Peticiones HTTP/S (GET, POST, etc.) con datos de formularios e interacciones de usuario · Tokens de sesión | Respuestas HTTP/S con HTML, CSS, JS y datos JSON · Recursos estáticos (mapas, íconos, estilos) · Mensajes de error o redirección |
| 4 | Base de Datos | Resultados de consultas SQL (registros de usuarios, horarios, aulas, docentes, reportes) | Sentencias de consulta, inserción, actualización y eliminación (CRUD) originadas por la lógica de negocio del servidor |
| 5 | Servicio de Notificaciones | Confirmación de entrega de notificaciones · Estado del envío (éxito / fallo) | Solicitudes de envío de notificaciones con destinatario, mensaje y tipo de alerta |
| 6 | Asistente Virtual (IA) | Respuestas generadas en lenguaje natural sobre horarios, aulas y orientación | Consultas textuales del estudiante junto con contexto de sesión (carrera, horario actual) |
| 7 | Infraestructura HTTPS / Red | Paquetes de datos cifrados transportados entre cliente y servidor | Datos en texto plano cifrados para su transmisión segura · Certificados TLS para validación |
| 8 | Universidad / Institución Académica | Lineamientos institucionales · Información académica oficial (programas, calendarios, estructura de campus) · Validación de identidad de usuarios | Sistema operativo que mejora la organización académica · Reportes de uso e incidencias · Canal digital de orientación estudiantil |
| 9 | Equipo de Desarrollo | Actualizaciones de código · Correcciones de bugs · Nuevas versiones del sistema · Scripts de migración de datos | Logs del sistema · Reportes de errores y fallos · Métricas de rendimiento · Tickets de problemas reportados por estudiantes |

## Flujos Críticos del Sistema

### Flujo de Mayor Frecuencia
**Estudiante → SIGAU → Base de Datos → SIGAU → Estudiante**  
Consulta de mapa y cálculo de ruta (CU-01)

### Flujo de Mayor Impacto
**Administrador → SIGAU → Base de Datos + Servicio de Notificaciones → Estudiante**  
Cambio de aula con notificación automática (CU-03)

### Flujo de Seguridad Transversal
**Todos los flujos → HTTPS → SIGAU**  
Cifrado TLS en cada comunicación cliente-servidor (RNF14)