const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Asignacion = sequelize.define('asignacion', {
  id_asignacion: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  periodo: { type: DataTypes.STRING(20), allowNull: false },
  materia: { type: DataTypes.STRING(100), allowNull: false },
  estado: {
    type: DataTypes.STRING(15),
    allowNull: false,
    defaultValue: 'ACTIVA',
    validate: { isIn: [['ACTIVA', 'INACTIVA', 'CANCELADA']] },
  },
  id_docente: { type: DataTypes.INTEGER, allowNull: false },
  id_aula: { type: DataTypes.INTEGER, allowNull: false },
  id_horario: { type: DataTypes.INTEGER, allowNull: false },
});

module.exports = Asignacion;
