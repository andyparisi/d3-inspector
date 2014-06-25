define (require) ->
  
  Marionette = require 'marionette'

  Template = require 'hbs!templates/item'


  class ItemView extends Marionette.ItemView

    template: Template
    className: 'item-detail'


    initialize: (options) =>
      