define (require) ->
  
  Marionette = require 'marionette'

  template = require 'hbs!templates/loading'


  class LoadingView extends Marionette.ItemView

    template: template

    initialize: (options) =>      