# M12 — Matriz de Trazabilidad: Vistas, Actores y Requisitos Funcionales

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona las vistas (pantallas/interfaces) del sistema
con los actores que las utilizan y los Requisitos Funcionales que
cada vista satisface, verificando cobertura completa de la UI.

Las vistas se implementan como **componentes React** (Vite) en
`frontend/src/pages/` y consumen el API REST del backend Express en
`/api/*` vía Axios.

---

## Actores del Sistema

| ID | Actor | Acceso |
|----|-------|--------|
| A1 | Estudiante | Vistas de consulta, mapa, historial y soporte |
| A2 | Docente | Vistas de horario y aulas asignadas |
| A3 | Administrador | Vistas de gestión completa |

---

## Matriz Principal: Vistas — Actores — RF

| # | Vista | Ruta React Router | Actor | RF Cubierto |
|---|-------|-------------------|-------|-------------|
| V01 | Login | `/login` | A1, A2, A3 | RF-01 |
| V02 | Dashboard Estudiante | `/estudiante/dashboard` | A1 | RF-02, RF-03 |
| V03 | Dashboard Docente | `/docente/dashboard` | A2 | RF-02, RF-06 |
| V04 | Dashboard Administrador | `/admin/dashboard` | A3 | RF-02, RF-08 |
| V05 | Búsqueda de Aula | `/estudiante/buscar-aula` | A1 | RF-03 |
| V06 | Detalle de Aula | `/estudiante/aula/:id` | A1 | RF-03, RF-11 |
| V07 | Horario Estudiante | `/estudiante/horario` | A1 | RF-04 |
| V08 | Historial de Consultas | `/estudiante/historial` | A1 | RF-05 |
| V09 | Horario Docente | `/docente/horario` | A2 | RF-06 |
| V10 | Aulas Asignadas Docente | `/docente/aulas` | A2 | RF-07 |
| V11 | Gestión de Aulas | `/admin/aulas` | A3 | RF-08 |
| V12 | Formulario Aula | `/admin/aulas/nueva` | A3 | RF-08 |
| V13 | Gestión de Usuarios | `/admin/usuarios` | A3 | RF-09 |
| V14 | Formulario Usuario | `/admin/usuarios/nuevo` | A3 | RF-09 |
| V15 | Gestión de Asignaciones | `/admin/asignaciones` | A3 | RF-10 |
| V16 | Formulario Asignación | `/admin/asignaciones/nueva` | A3 | RF-10 |
| V17 | Mapa Interactivo | `/mapa` | A1, A2 | RF-11 |
| V18 | Ruta a Aula | `/mapa/ruta/:id` | A1 | RF-12 |
| V19 | Notificaciones | `/notificaciones` | A1, A2, A3 | RF-14 |
| V20 | Reporte de Fallo | `/estudiante/reportar` | A1 | RF-15 |
| V21 | Gestión de Reportes | `/admin/reportes` | A3 | RF-16 |

---

## Detalle por Vista

### V01 — Login
**Ruta:** `/login` · **Actor:** A1, A2, A3 · **RF:** RF-01

| Componente | Descripción |
|---|---|
| Formulario | Campos: correo, contraseña |
| Botón | "Iniciar sesión" |
| Enlace | "¿Olvidaste tu contraseña?" |
| Validación | Credenciales incorrectas → mensaje de error |
| Redirección | Según rol → dashboard correspondiente |

**Componente React:** `frontend/src/pages/Login.jsx`
**Endpoint:** `POST /api/auth/login` → `{ token, rol }`

```jsx
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

export default function Login() {
  const [form, setForm] = useState({ correo: '', contrasena: '' });
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  async function handleSubmit(e) {
    e.preventDefault();
    try {
      const { data } = await axios.post('/api/auth/login', form);
      localStorage.setItem('token', data.token);
      navigate(`/${data.rol.toLowerCase()}/dashboard`);
    } catch {
      setError('Credenciales incorrectas');
    }
  }
  return (/* form JSX */);
}
```

---

### V02 — Dashboard Estudiante
**Ruta:** `/estudiante/dashboard` · **Actor:** A1 · **RF:** RF-02, RF-06

| Componente | Descripción |
|---|---|
| Barra de navegación | Links a: Buscar Aula, Horario, Historial, Mapa, Reportar |
| Buscador rápido | Campo de búsqueda de aula por código |
| Tarjetas resumen | Próxima clase, última consulta, notificaciones |
| Acceso rápido | Botones a las funciones principales |

**Componente React:** `frontend/src/pages/estudiante/Dashboard.jsx`

---

### V03 — Dashboard Docente
**Ruta:** `/docente/dashboard` · **Actor:** A2 · **RF:** RF-02, RF-06

| Componente | Descripción |
|---|---|
| Barra de navegación | Links a: Horario, Mis Aulas, Mapa, Notificaciones |
| Tarjeta horario hoy | Clases del día actual |
| Tarjeta aulas | Aulas asignadas al docente |
| Notificaciones | Últimas notificaciones recibidas |

**Componente React:** `frontend/src/pages/docente/Dashboard.jsx`

---

### V04 — Dashboard Administrador
**Ruta:** `/admin/dashboard` · **Actor:** A3 · **RF:** RF-02, RF-08

| Componente | Descripción |
|---|---|
| Barra de navegación | Links a: Aulas, Usuarios, Asignaciones, Reportes |
| Métricas | Total aulas, usuarios, asignaciones activas, reportes pendientes |
| Accesos rápidos | Botones a gestión de cada entidad |
| Alertas | Reportes pendientes de revisión |

**Componente React:** `frontend/src/pages/admin/Dashboard.jsx`

---

### V05 — Búsqueda de Aula
**Ruta:** `/estudiante/buscar-aula` · **Actor:** A1 · **RF:** RF-03

| Componente | Descripción |
|---|---|
| Campo de búsqueda | Código de aula o nombre |
| Filtros | Tipo de aula, capacidad, estado |
| Resultados | Lista de aulas con código, tipo, estado y ubicación |
| Botón detalle | Redirige a V06 |

**Componente React:** `frontend/src/pages/estudiante/BuscarAula.jsx`
**Endpoint:** `GET /api/aulas?codigo_aula=...&estado=...`

```jsx
import { useState } from 'react';
import axios from 'axios';

export default function BuscarAula() {
  const [q, setQ] = useState('');
  const [aulas, setAulas] = useState([]);
  async function buscar() {
    const { data } = await axios.get('/api/aulas', { params: { codigo_aula: q } });
    setAulas(data);
    await axios.post('/api/consultas', {
      tipo_consulta: data.length ? 'BUSQUEDA_EXITOSA' : 'BUSQUEDA_FALLIDA',
      id_aula: data[0]?.id_aula,
    });
  }
  return (/* lista + botón */);
}
```

---

### V06 — Detalle de Aula
**Ruta:** `/estudiante/aula/:id` · **Actor:** A1 · **RF:** RF-03, RF-11

| Componente | Descripción |
|---|---|
| Ficha del aula | Código, tipo, capacidad, estado, piso, torre |
| Mapa mini | Ubicación del aula en el mapa (react-leaflet) |
| Botón ruta | "Cómo llegar" → redirige a V18 |
| Horario del aula | Asignaciones actuales del aula |

**Componente React:** `frontend/src/pages/estudiante/DetalleAula.jsx`

---

### V07 — Horario Estudiante
**Ruta:** `/estudiante/horario` · **Actor:** A1 · **RF:** RF-04

| Componente | Descripción |
|---|---|
| Tabla semanal | Lunes a Sábado con franjas horarias |
| Celdas | Materia, aula, docente por franja |
| Filtro | Por semana o periodo |
| Exportar | Botón para descargar horario en PDF |

**Componente React:** `frontend/src/pages/estudiante/Horario.jsx`

---

### V08 — Historial de Consultas
**Ruta:** `/estudiante/historial` · **Actor:** A1 · **RF:** RF-05

| Componente | Descripción |
|---|---|
| Tabla de historial | Fecha, aula consultada, resultado |
| Filtro por fecha | Selector de rango de fechas |
| Paginación | 10 registros por página |
| Indicador | Ícono de resultado (✅ EXITOSA / ❌ FALLIDA) |

**Componente React:** `frontend/src/pages/estudiante/Historial.jsx`

---

### V09 — Horario Docente
**Ruta:** `/docente/horario` · **Actor:** A2 · **RF:** RF-06

| Componente | Descripción |
|---|---|
| Tabla semanal | Lunes a Sábado con franjas horarias |
| Celdas | Materia, aula, carrera por franja |
| Filtro | Por periodo académico |
| Vista compacta | Resumen del día actual |

**Componente React:** `frontend/src/pages/docente/Horario.jsx`

---

### V10 — Aulas Asignadas Docente
**Ruta:** `/docente/aulas` · **Actor:** A2 · **RF:** RF-07

| Componente | Descripción |
|---|---|
| Lista de aulas | Código, piso, torre, capacidad, estado |
| Mapa mini | Ubicación de cada aula |
| Filtro | Por día de la semana |
| Botón detalle | Ver información completa del aula |

**Componente React:** `frontend/src/pages/docente/Aulas.jsx`

---

### V11 — Gestión de Aulas
**Ruta:** `/admin/aulas` · **Actor:** A3 · **RF:** RF-08

| Componente | Descripción |
|---|---|
| Tabla de aulas | Código, tipo, capacidad, estado, piso, torre |
| Botón crear | Redirige a V12 |
| Botón editar | Formulario inline de edición |
| Botón eliminar | Confirmación antes de eliminar |
| Filtros | Por estado, tipo, torre |
| Cambio de estado | Dropdown para cambiar estado del aula |

**Componente React:** `frontend/src/pages/admin/GestionAulas.jsx`

---

### V12 — Formulario Aula
**Ruta:** `/admin/aulas/nueva` · **Actor:** A3 · **RF:** RF-08

| Componente | Descripción |
|---|---|
| Campo código | Código único del aula |
| Select piso | Selector de piso (carga torres y pisos) |
| Campo capacidad | Número entero |
| Select tipo | Salón, Laboratorio, Auditorio, etc. |
| Select estado | DISPONIBLE, OCUPADA, MANTENIMIENTO |
| Coordenadas | Latitud y longitud para ubicación |
| Botón guardar | Valida y persiste |

**Componente React:** `frontend/src/pages/admin/FormAula.jsx`

---

### V13 — Gestión de Usuarios
**Ruta:** `/admin/usuarios` · **Actor:** A3 · **RF:** RF-09

| Componente | Descripción |
|---|---|
| Tabla de usuarios | Correo, rol, nombre, estado |
| Filtro por rol | Estudiante, Docente, Administrador |
| Botón crear | Redirige a V14 |
| Botón editar | Formulario de edición |
| Botón bloquear/desbloquear | Cambia estado del usuario |

**Componente React:** `frontend/src/pages/admin/GestionUsuarios.jsx`

---

### V14 — Formulario Usuario
**Ruta:** `/admin/usuarios/nuevo` · **Actor:** A3 · **RF:** RF-09

| Componente | Descripción |
|---|---|
| Campo correo | Email único |
| Campo contraseña | Con confirmación |
| Select rol | Estudiante, Docente, Administrador |
| Campos adicionales | Según rol seleccionado (nombre, código, carrera, etc.) |
| Botón guardar | Valida y persiste |

**Componente React:** `frontend/src/pages/admin/FormUsuario.jsx`

---

### V15 — Gestión de Asignaciones
**Ruta:** `/admin/asignaciones` · **Actor:** A3 · **RF:** RF-10

| Componente | Descripción |
|---|---|
| Tabla de asignaciones | Docente, materia, aula, horario, periodo |
| Filtros | Por periodo, docente, aula |
| Botón crear | Redirige a V16 |
| Botón editar | Formulario de edición |
| Botón cancelar | Cambia estado a CANCELADA |

**Componente React:** `frontend/src/pages/admin/GestionAsignaciones.jsx`

---

### V16 — Formulario Asignación
**Ruta:** `/admin/asignaciones/nueva` · **Actor:** A3 · **RF:** RF-10

| Componente | Descripción |
|---|---|
| Select docente | Lista de docentes activos |
| Select materia | Lista de materias |
| Select aula | Lista de aulas disponibles |
| Select horario | Día y franja horaria |
| Campo periodo | Ej: 2025-1 |
| Validación | Alerta si hay solapamiento de aula/horario |
| Botón guardar | Valida y persiste |

**Componente React:** `frontend/src/pages/admin/FormAsignacion.jsx`

---

### V17 — Mapa Interactivo
**Ruta:** `/mapa` · **Actor:** A1, A2 · **RF:** RF-11

| Componente | Descripción |
|---|---|
| Mapa react-leaflet | Mapa del campus con marcadores de aulas |
| Marcadores | Un marcador por aula con popup informativo |
| Popup | Código, tipo, estado, piso, torre |
| Buscador | Campo para buscar aula en el mapa |
| Botón ruta | "Cómo llegar" desde el popup |

**Componente React:** `frontend/src/pages/Mapa.jsx`
**Endpoint:** `GET /api/ubicaciones` (incluye `Aula`)

```jsx
import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';
import { useEffect, useState } from 'react';
import axios from 'axios';

export default function Mapa() {
  const [ubicaciones, setUbicaciones] = useState([]);
  useEffect(() => { axios.get('/api/ubicaciones').then((r) => setUbicaciones(r.data)); }, []);
  return (
    <MapContainer center={[6.244, -75.575]} zoom={18}>
      <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
      {ubicaciones.map((u) => (
        <Marker key={u.id_ubicacion} position={[u.coordenada_y, u.coordenada_x]}>
          <Popup>{u.aula?.codigo_aula} — {u.aula?.estado}</Popup>
        </Marker>
      ))}
    </MapContainer>
  );
}
```

---

### V18 — Ruta a Aula
**Ruta:** `/mapa/ruta/:id` · **Actor:** A1 · **RF:** RF-12

| Componente | Descripción |
|---|---|
| Mapa react-leaflet | Mapa con ruta trazada |
| Punto origen | Ubicación actual del usuario |
| Punto destino | Aula seleccionada |
| Línea de ruta | Ruta calculada entre origen y destino |
| Información | Distancia estimada y tiempo a pie |

**Componente React:** `frontend/src/pages/Ruta.jsx`
**Endpoint:** `POST /api/rutas`

---

### V19 — Notificaciones
**Ruta:** `/notificaciones` · **Actor:** A1, A2, A3 · **RF:** RF-14

| Componente | Descripción |
|---|---|
| Lista de notificaciones | Título, mensaje, fecha, estado |
| Indicador | Badge con cantidad de no leídas |
| Botón leer | Marca como LEIDA |
| Botón eliminar | Marca como ELIMINADA |
| Filtro | Por estado (ENVIADA, LEIDA) |

**Componente React:** `frontend/src/pages/Notificaciones.jsx`

---

### V20 — Reporte de Fallo
**Ruta:** `/estudiante/reportar` · **Actor:** A1 · **RF:** RF-15

| Componente | Descripción |
|---|---|
| Select aula | Lista de aulas del campus |
| Campo descripción | Textarea para describir el fallo |
| Botón enviar | Crea reporte con estado Abierto |
| Confirmación | Mensaje de éxito tras enviar |

**Componente React:** `frontend/src/pages/estudiante/ReportarFallo.jsx`
**Endpoint:** `POST /api/reportes-soporte`

---

### V21 — Gestión de Reportes
**Ruta:** `/admin/reportes` · **Actor:** A3 · **RF:** RF-16

| Componente | Descripción |
|---|---|
| Tabla de reportes | Estudiante, aula, descripción, fecha, estado |
| Filtro por estado | Abierto, EN_REVISION, Resuelto |
| Botón revisar | Cambia estado a EN_REVISION |
| Botón resolver | Cambia estado a Resuelto |
| Notificación automática | Notifica al estudiante al resolver |

**Componente React:** `frontend/src/pages/admin/GestionReportes.jsx`

---

## Cobertura de RF por Vista

| RF | Vistas que lo cubren | Actores | Estado |
|----|----------------------|---------|--------|
| RF-01 Autenticación | V01 | A1, A2, A3 | ✅ |
| RF-02 Control acceso | V02, V03, V04 | A1, A2, A3 | ✅ |
| RF-03 Buscar aula | V05, V06 | A1 | ✅ |
| RF-04 Horario estudiante | V07 | A1 | ✅ |
| RF-05 Historial | V08 | A1 | ✅ |
| RF-06 Horario docente | V03, V09 | A2 | ✅ |
| RF-07 Aulas docente | V10 | A2 | ✅ |
| RF-08 Gestionar aulas | V11, V12 | A3 | ✅ |
| RF-09 Gestionar usuarios | V13, V14 | A3 | ✅ |
| RF-10 Asignaciones | V15, V16 | A3 | ✅ |
| RF-11 Mapa interactivo | V06, V17 | A1, A2 | ✅ |
| RF-12 Calcular ruta | V18 | A1 | ✅ |
| RF-13 Registrar consulta | V05 (automático) | A1 | ✅ |
| RF-14 Notificaciones | V19 | A1, A2, A3 | ✅ |
| RF-15 Reportar fallo | V20 | A1 | ✅ |
| RF-16 Gestionar reportes | V21 | A3 | ✅ |

**Cobertura total: 16/16 RF cubiertos — 100% ✅**
