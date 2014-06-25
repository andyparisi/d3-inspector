heroes = require('./controllers/heroes')

module.exports = (app, router) ->
  router.get('/', (req, res) -> res.render('index'))

  app.route('/api/heroes')
    .get((req, res) ->
      heroes.index(req, res)
    )

    .post((req, res) ->
      heroes.add(req, res)
    )

  app.route('/api/heroes/:id')
    .get((req, res) ->
      heroes.get(req, res)
    )

    .put((req, res) ->
      heroes.update(req, res)
    )

    .delete((req, res) ->
      heroes.delete(req, res)
    )