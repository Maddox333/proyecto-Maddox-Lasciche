const sequelize = require('../config/database');

const Rol = require('./Rol');
const Usuario = require('./Usuario');
const Carrera = require('./Carrera');
const Estudiante = require('./Estudiante');
const Administrador = require('./Administrador');
const Docente = require('./Docente');
const Materia = require('./Materia');
const Torre = require('./Torre');
const Piso = require('./Piso');
const Aula = require('./Aula');
const Ubicacion = require('./Ubicacion');
const Horario = require('./Horario');
const Asignacion = require('./Asignacion');
const Ruta = require('./Ruta');
const Consulta = require('./Consulta');
const Historial = require('./Historial');
const Notificacion = require('./Notificacion');
const ReporteSoporte = require('./ReporteSoporte');

// USUARIO ── ROL
Rol.hasMany(Usuario, { foreignKey: 'id_rol' });
Usuario.belongsTo(Rol, { foreignKey: 'id_rol' });

// ESTUDIANTE ── USUARIO / CARRERA
Usuario.hasOne(Estudiante, { foreignKey: 'id_usuario', onDelete: 'CASCADE' });
Estudiante.belongsTo(Usuario, { foreignKey: 'id_usuario' });

Carrera.hasMany(Estudiante, { foreignKey: 'id_carrera' });
Estudiante.belongsTo(Carrera, { foreignKey: 'id_carrera' });

// ADMINISTRADOR ── USUARIO
Usuario.hasOne(Administrador, { foreignKey: 'id_usuario', onDelete: 'CASCADE' });
Administrador.belongsTo(Usuario, { foreignKey: 'id_usuario' });

// DOCENTE ── USUARIO
Usuario.hasOne(Docente, { foreignKey: 'id_usuario', onDelete: 'CASCADE' });
Docente.belongsTo(Usuario, { foreignKey: 'id_usuario' });

// MATERIA ── CARRERA
Carrera.hasMany(Materia, { foreignKey: 'id_carrera' });
Materia.belongsTo(Carrera, { foreignKey: 'id_carrera' });

// PISO ── TORRE
Torre.hasMany(Piso, { foreignKey: 'id_torre', onDelete: 'CASCADE' });
Piso.belongsTo(Torre, { foreignKey: 'id_torre' });

// AULA ── PISO
Piso.hasMany(Aula, { foreignKey: 'id_piso', onDelete: 'CASCADE' });
Aula.belongsTo(Piso, { foreignKey: 'id_piso' });

// UBICACION ── AULA
Aula.hasOne(Ubicacion, { foreignKey: 'id_aula', onDelete: 'CASCADE' });
Ubicacion.belongsTo(Aula, { foreignKey: 'id_aula' });

// ASIGNACION ── DOCENTE / AULA / HORARIO
Docente.hasMany(Asignacion, { foreignKey: 'id_docente' });
Asignacion.belongsTo(Docente, { foreignKey: 'id_docente' });

Aula.hasMany(Asignacion, { foreignKey: 'id_aula' });
Asignacion.belongsTo(Aula, { foreignKey: 'id_aula' });

Horario.hasMany(Asignacion, { foreignKey: 'id_horario' });
Asignacion.belongsTo(Horario, { foreignKey: 'id_horario' });

// RUTA ── ESTUDIANTE / AULA (origen y destino)
Estudiante.hasMany(Ruta, { foreignKey: 'id_estudiante' });
Ruta.belongsTo(Estudiante, { foreignKey: 'id_estudiante' });

Aula.hasMany(Ruta, { foreignKey: 'id_aula_origen', as: 'rutas_como_origen' });
Ruta.belongsTo(Aula, { foreignKey: 'id_aula_origen', as: 'aula_origen' });

Aula.hasMany(Ruta, { foreignKey: 'id_aula_destino', as: 'rutas_como_destino' });
Ruta.belongsTo(Aula, { foreignKey: 'id_aula_destino', as: 'aula_destino' });

// CONSULTA ── ESTUDIANTE / AULA
Estudiante.hasMany(Consulta, { foreignKey: 'id_estudiante' });
Consulta.belongsTo(Estudiante, { foreignKey: 'id_estudiante' });

Aula.hasMany(Consulta, { foreignKey: 'id_aula' });
Consulta.belongsTo(Aula, { foreignKey: 'id_aula' });

// HISTORIAL ── ESTUDIANTE / CONSULTA
Estudiante.hasMany(Historial, { foreignKey: 'id_estudiante' });
Historial.belongsTo(Estudiante, { foreignKey: 'id_estudiante' });

Consulta.hasMany(Historial, { foreignKey: 'id_consulta', onDelete: 'CASCADE' });
Historial.belongsTo(Consulta, { foreignKey: 'id_consulta' });

// NOTIFICACION ── USUARIO
Usuario.hasMany(Notificacion, { foreignKey: 'id_usuario', onDelete: 'CASCADE' });
Notificacion.belongsTo(Usuario, { foreignKey: 'id_usuario' });

// REPORTE_SOPORTE ── ESTUDIANTE
Estudiante.hasMany(ReporteSoporte, { foreignKey: 'id_estudiante' });
ReporteSoporte.belongsTo(Estudiante, { foreignKey: 'id_estudiante' });

module.exports = {
  sequelize,
  Rol,
  Usuario,
  Carrera,
  Estudiante,
  Administrador,
  Docente,
  Materia,
  Torre,
  Piso,
  Aula,
  Ubicacion,
  Horario,
  Asignacion,
  Ruta,
  Consulta,
  Historial,
  Notificacion,
  ReporteSoporte,
};
