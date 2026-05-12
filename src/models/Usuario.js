const { DataTypes } = require('sequelize');
const bcrypt = require('bcryptjs');
const sequelize = require('../config/database');

const Usuario = sequelize.define('usuarios', {
  id_usuario: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  correo: {
    type: DataTypes.STRING(100),
    allowNull: false,
    unique: true,
    validate: { isEmail: true },
  },
  contrasena: { type: DataTypes.STRING(255), allowNull: false },
  fecha_registro: { type: DataTypes.DATEONLY, allowNull: false, defaultValue: DataTypes.NOW },
  activo: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: true },
  id_rol: { type: DataTypes.INTEGER, allowNull: false },
});

const hashIfNeeded = async (user) => {
  if (user.changed('contrasena')) {
    const rounds = Number(process.env.BCRYPT_SALT_ROUNDS) || 12;
    user.contrasena = await bcrypt.hash(user.contrasena, rounds);
  }
};

Usuario.beforeCreate(hashIfNeeded);
Usuario.beforeUpdate(hashIfNeeded);

Usuario.prototype.verificarContrasena = function (plain) {
  return bcrypt.compare(plain, this.contrasena);
};

Usuario.prototype.toJSON = function () {
  const values = { ...this.get() };
  delete values.contrasena;
  return values;
};

module.exports = Usuario;
