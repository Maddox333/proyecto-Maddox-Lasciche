const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Horario = sequelize.define('horario', {
  id_horario: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  dia_semana: {
    type: DataTypes.STRING(15),
    allowNull: false,
    validate: { isIn: [['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado']] },
  },
  hora_inicio: { type: DataTypes.TIME, allowNull: false },
  hora_fin: { type: DataTypes.TIME, allowNull: false },
});

module.exports = Horario;
