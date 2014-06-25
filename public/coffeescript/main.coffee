require.config
  baseUrl: '/js'

  paths:
    jquery: 'lib/jquery/dist/jquery'
    underscore: 'lib/underscore/underscore'
    backbone: 'lib/backbone/backbone'
    marionette: 'lib/backbone.marionette/lib/backbone.marionette'
    handlebars: 'lib/handlebars/handlebars'
    hbs: 'lib/hbs/hbs'
    moment: 'lib/moment/moment'

  shim:
    underscore:
      exports: '_'

    backbone:
      deps: ['jquery', 'underscore']
      exports: 'Backbone'

    marionette:
      deps: ['backbone']
      exports: 'Marionette'

    handlebars:
      exports: 'Handlebars'


define (require) ->
  app = require 'app'
  app.initialize()