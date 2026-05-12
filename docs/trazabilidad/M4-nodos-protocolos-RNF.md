# M4 — Matriz de Trazabilidad: Nodos, Protocolos y Requisitos No Funcionales

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona los nodos del diagrama de despliegue con los
protocolos de comunicación y los Requisitos No Funcionales (RNF),
verificando que la infraestructura técnica satisface los atributos
de calidad del sistema.

---

## Nodos del Sistema

| # | Nodo | Tipo | Descripción |
|---|---|---|---|
| N1 | Navegador Web | Cliente | Browser del usuario (Chrome, Firefox, Safari) |
| N2 | Servidor Web | Servidor | Node.js 18 LTS + Express 4 + Sequelize 6 (proceso gestionado con PM2) |
| N3 | Servidor de Base de Datos | Servidor | PostgreSQL 15 |
| N4 | Servidor de Archivos Estáticos | Servidor | Nginx para CSS, JS, imágenes |
| N5 | Servidor de Mapas | Servicio externo | OpenStreetMap / Leaflet.js tiles |
| N6 | Dispositivo Móvil | Cliente | Smartphone con navegador móvil |

---

## Protocolos de Comunicación

| # | Protocolo | Descripción | Entre nodos |
|---|---|---|---|
| P1 | HTTPS | Comunicación segura cliente-servidor | N1/N6 ↔ N2 |
| P2 | HTTP | Comunicación interna entre servicios | N2 ↔ N4 |
| P3 | TCP/IP | Comunicación base de datos | N2 ↔ N3 |
| P4 | REST/JSON | API para datos del mapa | N2 ↔ N5 |
| P5 | WebSocket | Notificaciones en tiempo real | N1/N6 ↔ N2 |
| P6 | SQL | Consultas a la base de datos | N2 ↔ N3 |

---

## Requisitos No Funcionales

| Código | Categoría | Descripción |
|---|---|---|
| RNF-01 | Seguridad | El sistema debe autenticar usuarios con contraseñas cifradas (bcrypt) |
| RNF-02 | Seguridad | El sistema debe usar HTTPS en todas las comunicaciones |
| RNF-03 | Rendimiento | El sistema debe responder en menos de 3 segundos ante cualquier consulta |
| RNF-04 | Rendimiento | El mapa interactivo debe cargar en menos de 5 segundos |
| RNF-05 | Disponibilidad | El sistema debe estar disponible el 99% del tiempo |
| RNF-06 | Escalabilidad | El sistema debe soportar al menos 500 usuarios concurrentes |
| RNF-07 | Usabilidad | La interfaz debe ser responsive y funcionar en dispositivos móviles |
| RNF-08 | Mantenibilidad | El código debe seguir una arquitectura por capas (modelos Sequelize / routers Express / componentes React) con separación clara de responsabilidades |
| RNF-09 | Portabilidad | El sistema debe funcionar en Chrome, Firefox y Safari |
| RNF-10 | Integridad | La base de datos debe mantener integridad referencial con FK |

---

## Matriz Principal

| Nodo | Protocolos | RNF Relacionados |
|---|---|---|
| N1 — Navegador Web | P1 HTTPS, P5 WebSocket | RNF-02, RNF-03, RNF-07, RNF-09 |
| N2 — Servidor Web | P1 HTTPS, P2 HTTP, P3 TCP/IP, P4 REST, P5 WebSocket | RNF-01, RNF-02, RNF-03, RNF-05, RNF-06, RNF-08 |
| N3 — Servidor BD | P3 TCP/IP, P6 SQL | RNF-03, RNF-05, RNF-06, RNF-10 |
| N4 — Servidor Estáticos | P2 HTTP | RNF-03, RNF-04, RNF-07 |
| N5 — Servidor Mapas | P4 REST/JSON | RNF-04 |
| N6 — Dispositivo Móvil | P1 HTTPS, P5 WebSocket | RNF-02, RNF-07, RNF-09 |

---

## Detalle por Nodo

### N1 — Navegador Web
| Elemento | Detalle |
|---|---|
| Tecnología | Chrome, Firefox, Safari |
| Protocolos | HTTPS, WebSocket |
| RNF | RNF-02 Seguridad, RNF-03 Rendimiento, RNF-07 Responsive, RNF-09 Portabilidad |
| Componentes servidos | SPA React (Vite build), TailwindCSS/Bootstrap 5, react-leaflet |

### N2 — Servidor Web
| Elemento | Detalle |
|---|---|
| Tecnología | Node.js 18 LTS + Express 4 + Sequelize 6 (gestor de procesos: PM2 / systemd) |
| Protocolos | HTTPS, HTTP, TCP/IP, REST, WebSocket |
| RNF | RNF-01, RNF-02, RNF-03, RNF-05, RNF-06, RNF-08 |
| Responsabilidad | Lógica de negocio, routers REST, autenticación JWT, APIs |

### N3 — Servidor de Base de Datos
| Elemento | Detalle |
|---|---|
| Tecnología | PostgreSQL 15 |
| Protocolos | TCP/IP, SQL |
| RNF | RNF-03 Rendimiento, RNF-05 Disponibilidad, RNF-06 Escalabilidad, RNF-10 Integridad |
| Responsabilidad | Persistencia de datos, integridad referencial |

### N4 — Servidor de Archivos Estáticos
| Elemento | Detalle |
|---|---|
| Tecnología | Nginx |
| Protocolos | HTTP |
| RNF | RNF-03 Rendimiento, RNF-04 Carga del mapa, RNF-07 Responsive |
| Responsabilidad | Servir CSS, JS, imágenes y tiles del mapa |

### N5 — Servidor de Mapas
| Elemento | Detalle |
|---|---|
| Tecnología | OpenStreetMap + Leaflet.js |
| Protocolos | REST/JSON |
| RNF | RNF-04 Carga del mapa |
| Responsabilidad | Proveer tiles del mapa interactivo |

### N6 — Dispositivo Móvil
| Elemento | Detalle |
|---|---|
| Tecnología | Smartphone con navegador móvil |
| Protocolos | HTTPS, WebSocket |
| RNF | RNF-02 Seguridad, RNF-07 Responsive, RNF-09 Portabilidad |
| Responsabilidad | Acceso móvil al sistema |

---

## Cobertura de RNF por Nodo

| RNF | N1 | N2 | N3 | N4 | N5 | N6 |
|---|---|---|---|---|---|---|
| RNF-01 Seguridad auth | | ✅ | | | | |
| RNF-02 HTTPS | ✅ | ✅ | | | | ✅ |
| RNF-03 Rendimiento | ✅ | ✅ | ✅ | ✅ | | |
| RNF-04 Carga mapa | | | | ✅ | ✅ | |
| RNF-05 Disponibilidad | | ✅ | ✅ | | | |
| RNF-06 Escalabilidad | | ✅ | ✅ | | | |
| RNF-07 Responsive | ✅ | | | ✅ | | ✅ |
| RNF-08 Mantenibilidad | | ✅ | | | | |
| RNF-09 Portabilidad | ✅ | | | | | ✅ |
| RNF-10 Integridad BD | | | ✅ | | | |

**Cobertura total: 10/10 RNF cubiertos — 100% ✅**