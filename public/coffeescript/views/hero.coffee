define (require) ->
  
  Marionette = require 'marionette'

  Template = require 'hbs!templates/hero'


  class HeroView extends Marionette.ItemView

    template: Template
    className: 'hero-detail'
    templateHelpers: {}
    

    initialize: (options) =>
      @templateHelpers.items = []
      for item, value of @model.get('items')
        value['key'] = item
        @templateHelpers.items.push(value)