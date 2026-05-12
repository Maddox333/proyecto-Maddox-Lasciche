const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Administrador = sequelize.define('administrador', {
  id_admin: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nombre: { type: DataTypes.STRING(100), allowNull: false },
  cargo: { type: DataTypes.STRING(100) },
  id_usuario: { type: DataTypes.INTEGER, allowNull: false, unique: true },
});

module.exports = Administrador;
