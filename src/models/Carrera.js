const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Carrera = sequelize.define('carrera', {
  id_carrera: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nombre_carrera: { type: DataTypes.STRING(150), allowNull: false },
  facultad: { type: DataTypes.STRING(150), allowNull: false },
  duracion_semestres: { type: DataTypes.INTEGER, allowNull: false },
});

module.exports = Carrera;
