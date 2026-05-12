const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Torre = sequelize.define('torre', {
  id_torre: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nombre_torre: { type: DataTypes.STRING(100), allowNull: false },
  descripcion: { type: DataTypes.STRING(200) },
});

module.exports = Torre;
