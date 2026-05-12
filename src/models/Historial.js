const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Historial = sequelize.define('historial', {
  id_historial: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  fecha_registro: { type: DataTypes.DATE, allowNull: false, defaultValue: DataTypes.NOW },
  id_estudiante: { type: DataTypes.INTEGER, allowNull: false },
  id_consulta: { type: DataTypes.INTEGER, allowNull: false },
});

module.exports = Historial;
