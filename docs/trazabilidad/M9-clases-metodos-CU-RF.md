# M9 — Matriz de Trazabilidad: Clases, Métodos y Requisitos Funcionales

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz relaciona las clases del diagrama de clases con sus métodos
y los Requisitos Funcionales (RF) que cada método satisface, verificando
que toda la lógica de negocio está cubierta por la implementación.

Los ejemplos de implementación usan **Sequelize 6 sobre Node.js + Express**
y consumen los modelos definidos en `src/models/`.

---

## Clases del Sistema

| # | Clase | Módulo (backend) | Responsabilidad |
|---|---|---|---|
| CL1 | UsuarioService | autenticacion | Gestión de autenticación y sesiones |
| CL2 | RolService | autenticacion | Control de acceso por rol |
| CL3 | EstudianteService | usuarios | Gestión del perfil de estudiante |
| CL4 | DocenteService | usuarios | Gestión del perfil de docente |
| CL5 | AdministradorService | usuarios | Gestión del perfil de administrador |
| CL6 | AulaService | infraestructura | Gestión de aulas |
| CL7 | MapaService | mapa | Mapa interactivo y rutas |
| CL8 | ConsultaService | consultas | Historial de consultas |
| CL9 | AsignacionService | academico | Gestión de asignaciones |
| CL10 | NotificacionService | notificaciones | Envío de notificaciones |
| CL11 | SoporteService | soporte | Gestión de reportes |

---

## Matriz Principal

| Clase | Métodos | RF Cubiertos |
|---|---|---|
| CL1 — UsuarioService | login(), logout(), cambiarPassword() | RF-01 |
| CL2 — RolService | verificarRol(), asignarRol(), obtenerPermisos() | RF-02 |
| CL3 — EstudianteService | registrar(), actualizar(), obtenerHorario(), buscarAula() | RF-03, RF-04, RF-05 |
| CL4 — DocenteService | registrar(), actualizar(), obtenerHorario(), obtenerAulas() | RF-06, RF-07 |
| CL5 — AdministradorService | gestionarUsuarios(), gestionarAulas(), gestionarAsignaciones() | RF-08, RF-09, RF-10 |
| CL6 — AulaService | crear(), actualizar(), eliminar(), cambiarEstado(), buscar() | RF-08, RF-11 |
| CL7 — MapaService | mostrarMapa(), calcularRuta(), obtenerUbicacion() | RF-11, RF-12 |
| CL8 — ConsultaService | registrarConsulta(), obtenerHistorial(), filtrar() | RF-05, RF-13 |
| CL9 — AsignacionService | crear(), actualizar(), eliminar(), validarSolapamiento() | RF-10 |
| CL10 — NotificacionService | enviar(), marcarLeida(), eliminar(), listar() | RF-14 |
| CL11 — SoporteService | reportar(), actualizarEstado(), listarReportes() | RF-15, RF-16 |

---

## Detalle por Clase

### CL1 — UsuarioService
| Método | Descripción | RF | RN |
|---|---|---|---|
| `login(correo, password)` | Autentica al usuario verificando credenciales (bcrypt) | RF-01 | RN-15 |
| `logout(req)` | Invalida el JWT del usuario | RF-01 | — |
| `cambiarPassword(usuario, nueva)` | Actualiza la contraseña (rehash automático en hook) | RF-01 | RN-15 |

**Implementación (Sequelize + JWT):**
```js
const jwt = require('jsonwebtoken');
const { Usuario } = require('../models');

class UsuarioService {
  async login(correo, password) {
    const usuario = await Usuario.findOne({ where: { correo, activo: true } });
    if (!usuario) return null;
    const ok = await usuario.verificarContrasena(password);
    if (!ok) return null;
    return jwt.sign({ id: usuario.id_usuario, id_rol: usuario.id_rol }, process.env.JWT_SECRET);
  }

  async cambiarPassword(usuario, nueva) {
    usuario.contrasena = nueva; // el hook beforeUpdate re-hashea con bcryptjs
    await usuario.save();
  }
}
```

---

### CL2 — RolService
| Método | Descripción | RF | RN |
|---|---|---|---|
| `verificarRol(usuario, rol)` | Verifica si el usuario tiene el rol indicado | RF-02 | RN-01 |
| `asignarRol(usuario, rol)` | Asigna un rol a un usuario | RF-02 | RN-01 |
| `obtenerPermisos(rol)` | Retorna los permisos del rol | RF-02 | RN-01 |

**Implementación:**
```js
const PERMISOS = {
  Estudiante:    ['ver_mapa', 'buscar_aula', 'ver_horario'],
  Docente:       ['ver_horario', 'ver_aulas'],
  Administrador: ['gestionar_todo'],
};

class RolService {
  async verificarRol(usuario, nombreRol) {
    const rol = await usuario.getRol();
    return rol?.nombre_rol === nombreRol;
  }
  async asignarRol(usuario, rol) {
    usuario.id_rol = rol.id_rol;
    await usuario.save();
  }
  obtenerPermisos(rol) {
    return PERMISOS[rol.nombre_rol] ?? [];
  }
}
```

---

### CL3 — EstudianteService
| Método | Descripción | RF | RN |
|---|---|---|---|
| `registrar(datos)` | Crea un nuevo perfil de estudiante | RF-09 | RN-02 |
| `actualizar(estudiante, datos)` | Actualiza datos del estudiante | RF-09 | RN-02 |
| `obtenerHorario(estudiante)` | Retorna el horario del estudiante | RF-04 | RN-02 |
| `buscarAula(codigo)` | Busca un aula por código | RF-03 | RN-08 |
| `obtenerHistorial(estudiante)` | Retorna el historial de consultas | RF-05 | RN-09 |

**Implementación (Sequelize):**
```js
const { Op } = require('sequelize');
const { Asignacion, Materia, Aula, Horario, Consulta } = require('../models');

class EstudianteService {
  async obtenerHorario(estudiante) {
    return Asignacion.findAll({
      include: [
        { model: Materia, where: { id_carrera: estudiante.id_carrera } },
        { model: Aula },
        { model: Horario },
      ],
    });
  }

  async buscarAula(codigo) {
    return Aula.findOne({
      where: { codigo_aula: codigo, estado: { [Op.in]: ['DISPONIBLE', 'OCUPADA'] } },
    });
  }

  async obtenerHistorial(estudiante) {
    return Consulta.findAll({
      where: { id_estudiante: estudiante.id_estudiante },
      order: [['fecha_consulta', 'DESC']],
    });
  }
}
```

---

### CL4 — DocenteService
| Método | Descripción | RF | RN |
|---|---|---|---|
| `registrar(datos)` | Crea un nuevo perfil de docente | RF-09 | — |
| `actualizar(docente, datos)` | Actualiza datos del docente | RF-09 | — |
| `obtenerHorario(docente)` | Retorna el horario del docente | RF-06 | RN-12 |
| `obtenerAulas(docente)` | Retorna las aulas asignadas al docente | RF-07 | RN-12 |

**Implementación:**
```js
const { Asignacion, Aula, Materia, Horario } = require('../models');

class DocenteService {
  async obtenerHorario(docente) {
    return Asignacion.findAll({
      where: { id_docente: docente.id_docente },
      include: [{ model: Materia }, { model: Aula }, { model: Horario }],
    });
  }

  async obtenerAulas(docente) {
    return Aula.findAll({
      include: [{ model: Asignacion, where: { id_docente: docente.id_docente }, required: true }],
    });
  }
}
```

---

### CL5 — AdministradorService
| Método | Descripción | RF | RN |
|---|---|---|---|
| `gestionarUsuarios(accion, datos)` | CRUD completo de usuarios | RF-09 | RN-13 |
| `gestionarAulas(accion, datos)` | CRUD completo de aulas | RF-08 | RN-13 |
| `gestionarAsignaciones(accion, datos)` | CRUD completo de asignaciones | RF-10 | RN-13 |

**Implementación:**
```js
const { Usuario, Aula } = require('../models');

class AdministradorService {
  async gestionarUsuarios(accion, datos) {
    if (accion === 'crear')      return Usuario.create(datos);
    if (accion === 'actualizar') return Usuario.update(datos, { where: { id_usuario: datos.id } });
    if (accion === 'eliminar')   return Usuario.destroy({ where: { id_usuario: datos.id } });
  }

  async gestionarAulas(accion, datos) {
    if (accion === 'crear')      return Aula.create(datos);
    if (accion === 'actualizar') return Aula.update(datos, { where: { id_aula: datos.id } });
    if (accion === 'eliminar')   return Aula.destroy({ where: { id_aula: datos.id } });
  }
}
```

---

### CL6 — AulaService
| Método | Descripción | RF | RN |
|---|---|---|---|
| `crear(datos)` | Crea un nuevo aula | RF-08 | RN-05 |
| `actualizar(aula, datos)` | Actualiza datos del aula | RF-08 | RN-05 |
| `eliminar(aula)` | Elimina un aula | RF-08 | — |
| `cambiarEstado(aula, estado)` | Cambia el estado del aula | RF-08 | RN-07 |
| `buscar(filtros)` | Busca aulas por filtros | RF-03 | RN-08 |

**Implementación:**
```js
const { Op } = require('sequelize');
const { Aula } = require('../models');

class AulaService {
  async buscar(filtros) {
    const where = {};
    if (filtros.tipo)      where.tipo_aula = filtros.tipo;
    if (filtros.capacidad) where.capacidad = { [Op.gte]: filtros.capacidad };
    if (filtros.estado)    where.estado    = filtros.estado;
    return Aula.findAll({ where });
  }

  async cambiarEstado(aula, nuevoEstado) {
    aula.estado = nuevoEstado;
    await aula.save();
  }
}
```

---

### CL7 — MapaService
| Método | Descripción | RF | RN |
|---|---|---|---|
| `mostrarMapa()` | Devuelve metadatos del mapa (torres/pisos/aulas) | RF-11 | — |
| `calcularRuta(origen, destino)` | Calcula la ruta entre dos puntos | RF-12 | RN-14 |
| `obtenerUbicacion(aula)` | Retorna las coordenadas del aula | RF-11 | RN-14 |

**Implementación:**
```js
const { Ubicacion, Ruta } = require('../models');

class MapaService {
  async obtenerUbicacion(idAula) {
    return Ubicacion.findOne({ where: { id_aula: idAula } });
  }

  async calcularRuta(idEstudiante, idOrigen, idDestino) {
    const origen  = await Ubicacion.findOne({ where: { id_aula: idOrigen } });
    const destino = await Ubicacion.findOne({ where: { id_aula: idDestino } });
    const dx = destino.coordenada_x - origen.coordenada_x;
    const dy = destino.coordenada_y - origen.coordenada_y;
    const distancia = Math.sqrt(dx * dx + dy * dy);

    return Ruta.create({
      distancia_metros: distancia,
      tiempo_minutos:   Math.ceil(distancia / 80),
      id_estudiante:    idEstudiante,
      id_aula_origen:   idOrigen,
      id_aula_destino:  idDestino,
    });
  }
}
```

---

### CL8 — ConsultaService
| Método | Descripción | RF | RN |
|---|---|---|---|
| `registrarConsulta(estudiante, aula)` | Registra automáticamente una consulta | RF-13 | RN-09 |
| `obtenerHistorial(estudiante)` | Retorna el historial del estudiante | RF-05 | RN-09 |
| `filtrar(estudiante, fecha)` | Filtra el historial por fecha | RF-05 | — |

**Implementación:**
```js
const { Op } = require('sequelize');
const { Consulta, Historial } = require('../models');

class ConsultaService {
  async registrarConsulta(idEstudiante, idAula, tipo = 'BUSQUEDA_AULA') {
    const consulta = await Consulta.create({
      id_estudiante: idEstudiante, id_aula: idAula, tipo_consulta: tipo,
    });
    await Historial.create({ id_estudiante: idEstudiante, id_consulta: consulta.id_consulta });
    return consulta;
  }

  async obtenerHistorial(idEstudiante) {
    return Consulta.findAll({
      where: { id_estudiante: idEstudiante },
      order: [['fecha_consulta', 'DESC']],
    });
  }

  async filtrar(idEstudiante, fecha) {
    const inicio = new Date(`${fecha}T00:00:00`);
    const fin    = new Date(`${fecha}T23:59:59`);
    return Consulta.findAll({
      where: { id_estudiante: idEstudiante, fecha_consulta: { [Op.between]: [inicio, fin] } },
    });
  }
}
```

---

### CL9 — AsignacionService
| Método | Descripción | RF | RN |
|---|---|---|---|
| `crear(datos)` | Crea una nueva asignación | RF-10 | RN-06 |
| `actualizar(asignacion, datos)` | Actualiza una asignación | RF-10 | RN-06 |
| `eliminar(asignacion)` | Elimina una asignación | RF-10 | — |
| `validarSolapamiento(aula, horario, periodo)` | Verifica que no haya solapamiento | RF-10 | RN-07 |

**Implementación:**
```js
const { Op } = require('sequelize');
const { Asignacion } = require('../models');

class AsignacionService {
  async validarSolapamiento(idAula, idHorario, periodo, excluirId = null) {
    const where = { id_aula: idAula, id_horario: idHorario, periodo };
    if (excluirId) where.id_asignacion = { [Op.ne]: excluirId };
    return (await Asignacion.count({ where })) > 0;
  }

  async crear(datos) {
    if (await this.validarSolapamiento(datos.id_aula, datos.id_horario, datos.periodo)) {
      throw new Error('Solapamiento detectado en aula y horario.');
    }
    return Asignacion.create(datos);
  }
}
```

---

### CL10 — NotificacionService
| Método | Descripción | RF | RN |
|---|---|---|---|
| `enviar(usuario, titulo, mensaje)` | Envía una notificación | RF-14 | RN-10 |
| `marcarLeida(notificacion)` | Marca la notificación como leída | RF-14 | — |
| `eliminar(notificacion)` | Marca como ELIMINADA (soft delete) | RF-14 | — |
| `listar(usuario)` | Lista las notificaciones del usuario | RF-14 | — |

**Implementación:**
```js
const { Op } = require('sequelize');
const { Notificacion } = require('../models');

class NotificacionService {
  enviar(idUsuario, titulo, mensaje) {
    return Notificacion.create({ id_usuario: idUsuario, titulo, mensaje, estado: 'ENVIADA' });
  }

  async marcarLeida(notificacion) {
    notificacion.estado = 'LEIDA';
    await notificacion.save();
  }

  listar(idUsuario) {
    return Notificacion.findAll({
      where: { id_usuario: idUsuario, estado: { [Op.ne]: 'ELIMINADA' } },
      order: [['fecha_envio', 'DESC']],
    });
  }
}
```

---

### CL11 — SoporteService
| Método | Descripción | RF | RN |
|---|---|---|---|
| `reportar(estudiante, tipoFallo, descripcion)` | Crea un reporte de soporte | RF-15 | RN-11 |
| `actualizarEstado(reporte, estado)` | Actualiza el estado del reporte | RF-16 | RN-11 |
| `listarReportes(filtros)` | Lista reportes con filtros | RF-16 | RN-11 |

**Implementación:**
```js
const { ReporteSoporte } = require('../models');

class SoporteService {
  reportar(idEstudiante, tipoFallo, descripcion) {
    return ReporteSoporte.create({
      id_estudiante: idEstudiante,
      tipo_fallo:    tipoFallo,
      descripcion,
      estado:        'Abierto',
    });
  }

  async actualizarEstado(reporte, nuevoEstado) {
    reporte.estado = nuevoEstado;
    if (nuevoEstado === 'Resuelto') reporte.fecha_resolucion = new Date();
    await reporte.save();
  }

  listarReportes(filtros = {}) {
    const where = {};
    if (filtros.estado) where.estado = filtros.estado;
    return ReporteSoporte.findAll({ where, order: [['fecha_reporte', 'DESC']] });
  }
}
```
