const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const ReporteSoporte = sequelize.define('reporte_soporte', {
  id_reporte: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  tipo_fallo: { type: DataTypes.STRING(100), allowNull: false },
  descripcion: { type: DataTypes.TEXT, allowNull: false },
  estado: { type: DataTypes.STRING(50), allowNull: false, defaultValue: 'Abierto' },
  fecha_reporte: { type: DataTypes.DATE, allowNull: false, defaultValue: DataTypes.NOW },
  fecha_resolucion: { type: DataTypes.DATE },
  id_estudiante: { type: DataTypes.INTEGER, allowNull: false },
});

module.exports = ReporteSoporte;
