require('dotenv').config();
const express = require('express');
const cors = require('cors');
const morgan = require('morgan');

const { sequelize } = require('./models');
const apiRouter = require('./routes');
const errorHandler = require('./middleware/errorHandler');

const app = express();

app.use(cors());
app.use(express.json());
app.use(morgan('dev'));

app.get('/', (req, res) => {
  res.json({
    nombre: 'SIGAU Backend',
    descripcion: 'Sistema de Información y Gestión Académica Universitaria — Módulo Mapa Interactivo y Navegación de Aulas',
    version: '0.1.0',
    endpoints: '/api',
  });
});

app.get('/api/health', async (req, res) => {
  try {
    await sequelize.authenticate();
    res.json({ status: 'ok', db: 'connected' });
  } catch (err) {
    res.status(503).json({ status: 'error', db: 'disconnected', mensaje: err.message });
  }
});

app.use('/api', apiRouter);

app.use((req, res) => res.status(404).json({ error: 'Ruta no encontrada' }));
app.use(errorHandler);

const PORT = Number(process.env.PORT) || 3000;

(async () => {
  try {
    await sequelize.authenticate();
    console.log('[db] Conexión a PostgreSQL establecida');
  } catch (err) {
    console.error('[db] No fue posible conectar:', err.message);
  }
  app.listen(PORT, () => {
    console.log(`[api] Escuchando en http://localhost:${PORT}`);
  });
})();
