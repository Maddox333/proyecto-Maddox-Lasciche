const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Consulta = sequelize.define('consulta', {
  id_consulta: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  fecha_consulta: { type: DataTypes.DATE, allowNull: false, defaultValue: DataTypes.NOW },
  tipo_consulta: { type: DataTypes.STRING(50), allowNull: false },
  id_estudiante: { type: DataTypes.INTEGER, allowNull: false },
  id_aula: { type: DataTypes.INTEGER, allowNull: false },
});

module.exports = Consulta;
