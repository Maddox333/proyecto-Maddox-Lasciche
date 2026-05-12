const { Router } = require('express');

function buildCrudRouter(Model, { pkField, include = [] } = {}) {
  const router = Router();
  const pk = pkField || Model.primaryKeyAttribute;

  router.get('/', async (req, res, next) => {
    try {
      const rows = await Model.findAll({ include });
      res.json(rows);
    } catch (err) { next(err); }
  });

  router.get('/:id', async (req, res, next) => {
    try {
      const row = await Model.findByPk(req.params.id, { include });
      if (!row) return res.status(404).json({ error: 'No encontrado' });
      res.json(row);
    } catch (err) { next(err); }
  });

  router.post('/', async (req, res, next) => {
    try {
      const row = await Model.create(req.body);
      res.status(201).json(row);
    } catch (err) { next(err); }
  });

  router.put('/:id', async (req, res, next) => {
    try {
      const row = await Model.findByPk(req.params.id);
      if (!row) return res.status(404).json({ error: 'No encontrado' });
      await row.update(req.body);
      res.json(row);
    } catch (err) { next(err); }
  });

  router.delete('/:id', async (req, res, next) => {
    try {
      const row = await Model.findByPk(req.params.id);
      if (!row) return res.status(404).json({ error: 'No encontrado' });
      await row.destroy();
      res.status(204).end();
    } catch (err) { next(err); }
  });

  return router;
}

module.exports = { buildCrudRouter };
