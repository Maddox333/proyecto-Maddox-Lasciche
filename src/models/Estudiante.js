const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Estudiante = sequelize.define('estudiante', {
  id_estudiante: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nombre: { type: DataTypes.STRING(100), allowNull: false },
  codigo_estudiantil: { type: DataTypes.STRING(20), allowNull: false, unique: true },
  semestre: { type: DataTypes.INTEGER, allowNull: false },
  id_usuario: { type: DataTypes.INTEGER, allowNull: false, unique: true },
  id_carrera: { type: DataTypes.INTEGER, allowNull: false },
});

module.exports = Estudiante;
