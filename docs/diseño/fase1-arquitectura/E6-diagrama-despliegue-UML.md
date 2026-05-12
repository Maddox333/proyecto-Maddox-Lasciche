# E6 — Diagrama de Despliegue UML

## Descripción
El diagrama de despliegue representa la infraestructura física y lógica
sobre la que se ejecuta el SIGAU, mostrando los nodos de hardware/software,
los artefactos desplegados en cada nodo y los protocolos de comunicación
entre ellos.

---

## Nodos del Sistema

### 📱 Nodo 1 — Dispositivo del Usuario (Cliente)
**Tipo:** Nodo físico (PC, smartphone, tablet)  
**Sistema Operativo:** Windows / macOS / iOS / Android  
**Runtime:** Navegador moderno + SPA React (Vite build estático)  
**Artefactos desplegados:**
- Navegador Web (Chrome, Firefox, Edge, Safari)
- Bundle React de SIGAU (HTML5 + CSS3 + JS ES2022, servido como estáticos)
- Token JWT de sesión almacenado en localStorage/sessionStorage

**Protocolos de salida:** HTTPS (TLS 1.3) → API REST del backend

---

### 🌐 Nodo 2 — Servidor Web / Aplicación (Backend)
**Tipo:** Nodo lógico (servidor en la nube o on-premise)  
**Sistema Operativo:** Ubuntu Server 22.04 LTS  
**Runtime:** Node.js 18 LTS + Express 4 + Sequelize 6  
**Artefactos desplegados:**
- `Auth.Controller` — Módulo de autenticación y gestión de sesiones
- `Mapa.Controller` — Módulo de mapa interactivo
- `Ruta.Controller` — Módulo de cálculo de rutas
- `Horario.Controller` — Módulo de horario académico
- `Notif.Controller` — Módulo de notificaciones
- `Asistente.Controller` — Módulo del asistente virtual
- `Soporte.Controller` — Módulo de soporte técnico
- `Admin.Controller` — Panel de administración
- `*.Repository` — Capa de acceso a datos (modelos Sequelize)

**Protocolos de entrada:** HTTPS (TLS 1.3)  
**Protocolos de salida:** TCP/IP → Base de Datos

---

### 🗄️ Nodo 3 — Servidor de Base de Datos
**Tipo:** Nodo lógico (servidor dedicado o servicio gestionado)  
**Sistema Operativo:** Ubuntu Server 22.04 LTS  
**Motor:** PostgreSQL 15  
**Artefactos desplegados:**
- Esquema relacional SIGAU (18 tablas normalizadas en 3FN)
- Scripts DDL de creación y migración (`E11-script-DDL.sql`)
- Índices de optimización sobre PK y FK

**Protocolos de entrada:** TCP/IP (puerto 5432) desde Servidor Web  
**Acceso:** Solo desde red interna (sin exposición pública)

---

### 🤖 Nodo 4 — Servicio de IA (Asistente Virtual)
**Tipo:** Nodo externo (API de terceros o microservicio propio)  
**Artefactos desplegados:**
- Motor de procesamiento de lenguaje natural
- API REST de consulta/respuesta

**Protocolos:** HTTPS → Servidor Web

---

### 🔔 Nodo 5 — Servicio de Notificaciones
**Tipo:** Nodo externo (servicio gestionado)  
**Artefactos desplegados:**
- Motor de entrega de notificaciones en tiempo real
- API REST de envío de alertas

**Protocolos:** HTTPS → Servidor Web

---

## Diagrama de Despliegue (PlantUML)

```plantuml
@startuml
node "Dispositivo del Usuario" as Cliente {
  component "Navegador Web" as Browser
  component "SPA React\n(Vite build)" as UI
  Browser --> UI
}

node "Servidor Web / Aplicación\n(Node.js + Express + Sequelize)" as Servidor {
  component "Auth.Controller" as Auth
  component "Mapa.Controller" as Mapa
  component "Ruta.Controller" as Ruta
  component "Horario.Controller" as Horario
  component "Notif.Controller" as Notif
  component "Asistente.Controller" as Asistente
  component "Soporte.Controller" as Soporte
  component "Admin.Controller" as Admin
  component "*.Repository (ORM)" as ORM
}

node "Servidor de Base de Datos\n(PostgreSQL 15)" as BaseDatos {
  database "SIGAU DB\n(18 tablas - 3FN)" as DB
}

node "Servicio de IA\n(API Externa)" as IA {
  component "Motor NLP" as NLP
}

node "Servicio de Notificaciones\n(API Externa)" as ServNotif {
  component "Motor de Alertas" as Alertas
}

Cliente --> Servidor : HTTPS (TLS 1.3)
Servidor --> BaseDatos : TCP/IP :5432
Servidor --> IA : HTTPS
Servidor --> ServNotif : HTTPS

Auth --> ORM
Mapa --> ORM
Ruta --> ORM
Horario --> ORM
Notif --> ORM
Soporte --> ORM
Admin --> ORM
ORM --> DB
@enduml