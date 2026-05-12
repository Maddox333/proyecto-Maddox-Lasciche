const { Router } = require('express');
const { buildCrudRouter } = require('../utils/crudFactory');
const m = require('../models');

const router = Router();

// ── Tablas maestras ────────────────────────────────────────────
router.use('/roles', buildCrudRouter(m.Rol));
router.use('/carreras', buildCrudRouter(m.Carrera));
router.use('/torres', buildCrudRouter(m.Torre));
router.use('/horarios', buildCrudRouter(m.Horario));

// ── Usuarios y perfiles ────────────────────────────────────────
router.use(
  '/usuarios',
  buildCrudRouter(m.Usuario, {
    include: [{ model: m.Rol }],
  })
);

router.use(
  '/estudiantes',
  buildCrudRouter(m.Estudiante, {
    include: [{ model: m.Usuario }, { model: m.Carrera }],
  })
);

router.use(
  '/docentes',
  buildCrudRouter(m.Docente, {
    include: [{ model: m.Usuario }],
  })
);

router.use(
  '/administradores',
  buildCrudRouter(m.Administrador, {
    include: [{ model: m.Usuario }],
  })
);

// ── Académico ──────────────────────────────────────────────────
router.use(
  '/materias',
  buildCrudRouter(m.Materia, {
    include: [{ model: m.Carrera }],
  })
);

// ── Campus ─────────────────────────────────────────────────────
router.use(
  '/pisos',
  buildCrudRouter(m.Piso, {
    include: [{ model: m.Torre }],
  })
);

router.use(
  '/aulas',
  buildCrudRouter(m.Aula, {
    include: [{ model: m.Piso }],
  })
);

router.use(
  '/ubicaciones',
  buildCrudRouter(m.Ubicacion, {
    include: [{ model: m.Aula }],
  })
);

// ── Asignación de clases ───────────────────────────────────────
router.use(
  '/asignaciones',
  buildCrudRouter(m.Asignacion, {
    include: [{ model: m.Docente }, { model: m.Aula }, { model: m.Horario }],
  })
);

// ── Navegación y consultas ─────────────────────────────────────
router.use(
  '/rutas',
  buildCrudRouter(m.Ruta, {
    include: [
      { model: m.Estudiante },
      { model: m.Aula, as: 'aula_origen' },
      { model: m.Aula, as: 'aula_destino' },
    ],
  })
);

router.use(
  '/consultas',
  buildCrudRouter(m.Consulta, {
    include: [{ model: m.Estudiante }, { model: m.Aula }],
  })
);

router.use(
  '/historiales',
  buildCrudRouter(m.Historial, {
    include: [{ model: m.Estudiante }, { model: m.Consulta }],
  })
);

router.use(
  '/notificaciones',
  buildCrudRouter(m.Notificacion, {
    include: [{ model: m.Usuario }],
  })
);

router.use(
  '/reportes-soporte',
  buildCrudRouter(m.ReporteSoporte, {
    include: [{ model: m.Estudiante }],
  })
);

module.exports = router;
