const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Rol = sequelize.define('rol', {
  id_rol: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nombre_rol: {
    type: DataTypes.STRING(50),
    allowNull: false,
    unique: true,
    validate: {
      isIn: [['Estudiante', 'Docente', 'Administrador']],
    },
  },
  descripcion: { type: DataTypes.STRING(200) },
});

module.exports = Rol;
