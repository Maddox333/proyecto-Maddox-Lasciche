const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Aula = sequelize.define('aula', {
  id_aula: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  codigo_aula: { type: DataTypes.STRING(20), allowNull: false, unique: true },
  capacidad: { type: DataTypes.INTEGER, allowNull: false },
  tipo_aula: { type: DataTypes.STRING(50) },
  estado: {
    type: DataTypes.STRING(20),
    allowNull: false,
    defaultValue: 'DISPONIBLE',
    validate: { isIn: [['DISPONIBLE', 'OCUPADA', 'MANTENIMIENTO']] },
  },
  id_piso: { type: DataTypes.INTEGER, allowNull: false },
});

module.exports = Aula;
