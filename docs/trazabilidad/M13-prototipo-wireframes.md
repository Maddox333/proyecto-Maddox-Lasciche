# M13 — Matriz de Trazabilidad: Navegación, Vistas y Roles

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz define el mapa de navegación completo del sistema,
especificando qué vistas puede acceder cada rol, las rutas de
navegación entre vistas y las restricciones de acceso.

---

## Roles del Sistema

| ID | Rol | Descripción | Acceso |
|---|---|---|---|
| R1 | Estudiante | Usuario que consulta aulas y horarios | Vistas de consulta y soporte |
| R2 | Docente | Usuario que consulta su horario y aulas | Vistas de consulta docente |
| R3 | Administrador | Gestor del sistema | Acceso total |
| R0 | Anónimo | Usuario no autenticado | Solo V01 (Login) |

---

## Matriz de Acceso por Rol

| Vista | URL | R0 Anónimo | R1 Estudiante | R2 Docente | R3 Admin |
|---|---|---|---|---|---|
| V01 Login | `/login/` | ✅ | ✅ | ✅ | ✅ |
| V02 Dashboard Estudiante | `/estudiante/dashboard/` | ❌ | ✅ | ❌ | ❌ |
| V03 Dashboard Docente | `/docente/dashboard/` | ❌ | ❌ | ✅ | ❌ |
| V04 Dashboard Admin | `/admin/dashboard/` | ❌ | ❌ | ❌ | ✅ |
| V05 Búsqueda de Aula | `/estudiante/buscar-aula/` | ❌ | ✅ | ❌ | ❌ |
| V06 Detalle de Aula | `/estudiante/aula/<id>/` | ❌ | ✅ | ❌ | ❌ |
| V07 Horario Estudiante | `/estudiante/horario/` | ❌ | ✅ | ❌ | ❌ |
| V08 Historial Consultas | `/estudiante/historial/` | ❌ | ✅ | ❌ | ❌ |
| V09 Horario Docente | `/docente/horario/` | ❌ | ❌ | ✅ | ❌ |
| V10 Aulas Docente | `/docente/aulas/` | ❌ | ❌ | ✅ | ❌ |
| V11 Gestión Aulas | `/admin/aulas/` | ❌ | ❌ | ❌ | ✅ |
| V12 Formulario Aula | `/admin/aulas/nueva/` | ❌ | ❌ | ❌ | ✅ |
| V13 Gestión Usuarios | `/admin/usuarios/` | ❌ | ❌ | ❌ | ✅ |
| V14 Formulario Usuario | `/admin/usuarios/nuevo/` | ❌ | ❌ | ❌ | ✅ |
| V15 Gestión Asignaciones | `/admin/asignaciones/` | ❌ | ❌ | ❌ | ✅ |
| V16 Formulario Asignación | `/admin/asignaciones/nueva/` | ❌ | ❌ | ❌ | ✅ |
| V17 Mapa Interactivo | `/mapa/` | ❌ | ✅ | ✅ | ❌ |
| V18 Ruta a Aula | `/mapa/ruta/<id>/` | ❌ | ✅ | ❌ | ❌ |
| V19 Notificaciones | `/notificaciones/` | ❌ | ✅ | ✅ | ✅ |
| V20 Reporte de Fallo | `/estudiante/reportar/` | ❌ | ✅ | ❌ | ❌ |
| V21 Gestión Reportes | `/admin/reportes/` | ❌ | ❌ | ❌ | ✅ |

---

## Flujos de Navegación por Rol

### R1 — Estudiante

[V01 Login]
└──► [V02 Dashboard Estudiante]
├──► [V05 Búsqueda de Aula]
│ └──► [V06 Detalle de Aula]
│ └──► [V18 Ruta a Aula]
├──► [V07 Horario Estudiante]
├──► [V08 Historial de Consultas]
├──► [V17 Mapa Interactivo]
│ └──► [V18 Ruta a Aula]
├──► [V19 Notificaciones]
└──► [V20 Reporte de Fallo]


### R2 — Docente

[V01 Login]
└──► [V03 Dashboard Docente]
├──► [V09 Horario Docente]
├──► [V10 Aulas Asignadas]
│ └──► [V17 Mapa Interactivo]
└──► [V19 Notificaciones]


### R3 — Administrador

[V01 Login]
└──► [V04 Dashboard Administrador]
├──► [V11 Gestión de Aulas]
│ └──► [V12 Formulario Aula (crear/editar)]
├──► [V13 Gestión de Usuarios]
│ └──► [V14 Formulario Usuario (crear/editar)]
├──► [V15 Gestión de Asignaciones]
│ └──► [V16 Formulario Asignación (crear/editar)]
├──► [V19 Notificaciones]
└──► [V21 Gestión de Reportes]


---

## Implementación de Control de Acceso

El control de acceso tiene dos capas que se complementan:

1. **Backend (Express):** middleware que valida el JWT y exige roles en cada
   endpoint protegido (`/api/*`).
2. **Frontend (React Router):** componente `RequireRole` que envuelve cada
   ruta privada y redirige a `/login` (anónimo) o a `/acceso-denegado`
   (rol incorrecto).

### Backend — middleware Express

```js
// src/middleware/auth.js
const jwt = require('jsonwebtoken');
const { Usuario } = require('../models');

function requireAuth(req, res, next) {
  const token = req.headers.authorization?.replace('Bearer ', '');
  try {
    req.auth = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch {
    res.status(401).json({ error: 'No autenticado' });
  }
}

function requireRole(...rolesPermitidos) {
  return async (req, res, next) => {
    const usuario = await Usuario.findByPk(req.auth.id, { include: ['rol'] });
    if (!usuario || !rolesPermitidos.includes(usuario.rol.nombre_rol)) {
      return res.status(403).json({ error: 'Acceso denegado' });
    }
    req.usuario = usuario;
    next();
  };
}

module.exports = { requireAuth, requireRole };
```

```js
// src/routes/index.js (extracto)
const { requireAuth, requireRole } = require('../middleware/auth');

router.use('/usuarios',          requireAuth, requireRole('Administrador'), usuariosRouter);
router.use('/aulas',             requireAuth, requireRole('Administrador', 'Docente', 'Estudiante'), aulasRouter);
router.use('/asignaciones',      requireAuth, requireRole('Administrador'), asignacionesRouter);
router.use('/reportes-soporte',  requireAuth, reportesRouter); // mixto: ver requireRole interno
```

### Frontend — React Router

```jsx
// frontend/src/components/RequireRole.jsx
import { Navigate } from 'react-router-dom';
import { useAuth } from '../hooks/useAuth';

export default function RequireRole({ roles, children }) {
  const { user } = useAuth();
  if (!user) return <Navigate to="/login" replace />;
  if (!roles.includes(user.rol)) return <Navigate to="/acceso-denegado" replace />;
  return children;
}
```

```jsx
// frontend/src/App.jsx
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import RequireRole from './components/RequireRole';
// ... imports de páginas ...

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<Login />} />

        {/* Estudiante */}
        <Route path="/estudiante/dashboard"   element={<RequireRole roles={['Estudiante']}><DashboardEstudiante /></RequireRole>} />
        <Route path="/estudiante/buscar-aula" element={<RequireRole roles={['Estudiante']}><BuscarAula /></RequireRole>} />
        <Route path="/estudiante/aula/:id"    element={<RequireRole roles={['Estudiante']}><DetalleAula /></RequireRole>} />
        <Route path="/estudiante/horario"     element={<RequireRole roles={['Estudiante']}><HorarioEstudiante /></RequireRole>} />
        <Route path="/estudiante/historial"   element={<RequireRole roles={['Estudiante']}><Historial /></RequireRole>} />
        <Route path="/estudiante/reportar"    element={<RequireRole roles={['Estudiante']}><ReportarFallo /></RequireRole>} />

        {/* Docente */}
        <Route path="/docente/dashboard" element={<RequireRole roles={['Docente']}><DashboardDocente /></RequireRole>} />
        <Route path="/docente/horario"   element={<RequireRole roles={['Docente']}><HorarioDocente /></RequireRole>} />
        <Route path="/docente/aulas"     element={<RequireRole roles={['Docente']}><AulasDocente /></RequireRole>} />

        {/* Compartidos */}
        <Route path="/mapa"             element={<RequireRole roles={['Estudiante', 'Docente']}><Mapa /></RequireRole>} />
        <Route path="/mapa/ruta/:id"    element={<RequireRole roles={['Estudiante']}><Ruta /></RequireRole>} />
        <Route path="/notificaciones"   element={<RequireRole roles={['Estudiante', 'Docente', 'Administrador']}><Notificaciones /></RequireRole>} />

        {/* Administrador */}
        <Route path="/admin/dashboard"             element={<RequireRole roles={['Administrador']}><DashboardAdmin /></RequireRole>} />
        <Route path="/admin/aulas"                 element={<RequireRole roles={['Administrador']}><GestionAulas /></RequireRole>} />
        <Route path="/admin/aulas/nueva"           element={<RequireRole roles={['Administrador']}><FormAula /></RequireRole>} />
        <Route path="/admin/usuarios"              element={<RequireRole roles={['Administrador']}><GestionUsuarios /></RequireRole>} />
        <Route path="/admin/usuarios/nuevo"        element={<RequireRole roles={['Administrador']}><FormUsuario /></RequireRole>} />
        <Route path="/admin/asignaciones"          element={<RequireRole roles={['Administrador']}><GestionAsignaciones /></RequireRole>} />
        <Route path="/admin/asignaciones/nueva"    element={<RequireRole roles={['Administrador']}><FormAsignacion /></RequireRole>} />
        <Route path="/admin/reportes"              element={<RequireRole roles={['Administrador']}><GestionReportes /></RequireRole>} />
      </Routes>
    </BrowserRouter>
  );
}
```