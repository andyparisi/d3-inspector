define (require) ->

  Backbone = require 'backbone'


  class RecentHeroes extends Backbone.Collection

    url: '/api/heroes'
    comparator: 'battleTag'