const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Ruta = sequelize.define('ruta', {
  id_ruta: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  distancia_metros: { type: DataTypes.DECIMAL(8, 2) },
  tiempo_minutos: { type: DataTypes.INTEGER },
  fecha_consulta: { type: DataTypes.DATE, allowNull: false, defaultValue: DataTypes.NOW },
  id_estudiante: { type: DataTypes.INTEGER, allowNull: false },
  id_aula_origen: { type: DataTypes.INTEGER, allowNull: false },
  id_aula_destino: { type: DataTypes.INTEGER, allowNull: false },
});

module.exports = Ruta;
