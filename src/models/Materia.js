const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Materia = sequelize.define('materia', {
  id_materia: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nombre_materia: { type: DataTypes.STRING(150), allowNull: false },
  codigo_materia: { type: DataTypes.STRING(20), allowNull: false, unique: true },
  creditos: { type: DataTypes.INTEGER, allowNull: false },
  id_carrera: { type: DataTypes.INTEGER, allowNull: false },
});

module.exports = Materia;
