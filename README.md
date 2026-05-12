# SIGAU — Sistema de Información y Gestión Académica Universitaria
## Módulo: Mapa de Aulas — Corporación Universitaria Remington

## ¿Qué módulo implementas?
Módulo de **Mapa Interactivo y Navegación de Aulas**: permite a los estudiantes
consultar su horario académico, localizar aulas en el campus y calcular rutas hacia ellas.

## ¿Qué tablas cubre tu módulo?
`ROL`, `USUARIOS`, `CARRERA`, `ESTUDIANTE`, `ADMINISTRADOR`, `DOCENTE`,
`MATERIA`, `TORRE`, `PISO`, `AULA`, `UBICACION`, `HORARIO`, `ASIGNACION`,
`RUTA`, `CONSULTA`, `HISTORIAL`, `NOTIFICACION`, `REPORTE_SOPORTE`

## ¿Qué framework elegiste y por qué?
**Stack:** React + Node.js (Express) + Sequelize + PostgreSQL 15
**Razón:** React expone la interfaz interactiva del mapa de aulas y consulta
de horarios definida en E15-E17. Node.js + Express ofrece un backend ligero
para servir el API REST de las 18 entidades del E9-E11, y Sequelize mapea
1:1 las tablas del modelo relacional contra PostgreSQL preservando todas
las FKs, CHECKs y UNIQUEs declarados en el DDL.

## Estructura del repositorio
```
proyecto-Maddox-Lasciche/
├── src/                          # Backend Node.js + Express + Sequelize
│   ├── config/database.js        # Conexión Sequelize → PostgreSQL
│   ├── models/                   # 18 modelos ORM con asociaciones
│   ├── routes/index.js           # CRUD REST de las 18 entidades
│   ├── middleware/errorHandler.js
│   ├── utils/crudFactory.js      # CRUD genérico reutilizable
│   └── server.js                 # Entry point del API
├── docs/
│   ├── analisis/                 # 01-07 (Planteamiento → Casos de uso)
│   ├── diseño/
│   │   ├── fase1-arquitectura/   # E1-E6
│   │   ├── fase2-datos/          # E7-E11 + script DDL .sql
│   │   ├── fase3-componentes/    # E12-E14
│   │   ├── fase4-interfaz/       # E15-E17
│   │   └── imagenes/             # Diagramas PNG
│   └── trazabilidad/             # 13 matrices (M1-M13)
├── package.json
├── .env.example
├── DECISIONES.md
├── BITACORA.md
└── README.md
```

## ¿Cómo ejecutar el proyecto?

Requisitos: Node.js ≥ 18 y PostgreSQL 15.

```bash
# 1. Clonar el repositorio
git clone https://github.com/Maddox333/proyecto-Maddox-Lasciche.git
cd proyecto-Maddox-Lasciche

# 2. Instalar dependencias
npm install

# 3. Configurar variables (copia .env.example → .env y ajusta credenciales)
cp .env.example .env

# 4. Crear la base de datos y aplicar el DDL
createdb sigau
psql -d sigau -f docs/diseño/fase2-datos/E11-script-DDL.sql

# 5. Levantar el servidor
npm run dev          # con nodemon
# ó
npm start
```

API disponible en `http://localhost:3000/api`. Health check: `GET /api/health`.

### Endpoints CRUD disponibles

| Recurso | Tipo | Ruta |
|---|---|---|
| Roles | maestra | `/api/roles` |
| Carreras | maestra | `/api/carreras` |
| Torres | maestra | `/api/torres` |
| Horarios | maestra | `/api/horarios` |
| Usuarios | transaccional | `/api/usuarios` |
| Estudiantes | transaccional | `/api/estudiantes` |
| Docentes | transaccional | `/api/docentes` |
| Administradores | transaccional | `/api/administradores` |
| Materias | transaccional | `/api/materias` |
| Pisos | transaccional | `/api/pisos` |
| Aulas | transaccional | `/api/aulas` |
| Ubicaciones | transaccional | `/api/ubicaciones` |
| Asignaciones | transaccional | `/api/asignaciones` |
| Rutas | transaccional | `/api/rutas` |
| Consultas | transaccional | `/api/consultas` |
| Historiales | transaccional | `/api/historiales` |
| Notificaciones | transaccional | `/api/notificaciones` |
| Reportes de soporte | transaccional | `/api/reportes-soporte` |

Cada recurso expone `GET /`, `GET /:id`, `POST /`, `PUT /:id`, `DELETE /:id`.
