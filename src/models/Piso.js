const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Piso = sequelize.define('piso', {
  id_piso: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  numero_piso: { type: DataTypes.INTEGER, allowNull: false },
  descripcion: { type: DataTypes.STRING(200) },
  id_torre: { type: DataTypes.INTEGER, allowNull: false },
});

module.exports = Piso;
