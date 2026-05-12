const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Notificacion = sequelize.define('notificacion', {
  id_notificacion: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  titulo: { type: DataTypes.STRING(100), allowNull: false },
  mensaje: { type: DataTypes.TEXT, allowNull: false },
  fecha_envio: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
  estado: {
    type: DataTypes.STRING(15),
    allowNull: false,
    defaultValue: 'ENVIADA',
    validate: { isIn: [['ENVIADA', 'LEIDA', 'ELIMINADA']] },
  },
  id_usuario: { type: DataTypes.INTEGER, allowNull: false },
});

module.exports = Notificacion;
