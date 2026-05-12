const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Docente = sequelize.define('docente', {
  id_docente: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nombre: { type: DataTypes.STRING(100), allowNull: false },
  correo: {
    type: DataTypes.STRING(100),
    allowNull: false,
    unique: true,
    validate: { isEmail: true },
  },
  departamento: { type: DataTypes.STRING(100) },
  id_usuario: { type: DataTypes.INTEGER, allowNull: false, unique: true },
});

module.exports = Docente;
