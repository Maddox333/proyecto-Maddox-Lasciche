const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Ubicacion = sequelize.define('ubicacion', {
  id_ubicacion: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  coordenada_x: { type: DataTypes.DECIMAL(10, 6), allowNull: false },
  coordenada_y: { type: DataTypes.DECIMAL(10, 6), allowNull: false },
  referencia: { type: DataTypes.STRING(200) },
  id_aula: { type: DataTypes.INTEGER, allowNull: false, unique: true },
});

module.exports = Ubicacion;
