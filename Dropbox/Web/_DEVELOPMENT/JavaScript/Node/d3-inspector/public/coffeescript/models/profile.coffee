define (require) ->

  Backbone = require 'backbone'
  

  class Profile extends Backbone.Model

    initialize: (options) =>
      if options? then @url = "http://us.battle.net/api/d3/profile/#{options.battleTag}/"


    setStrings: =>
      # Fix the class names
      for hero in @get('heroes')
        @get('heroes')[_i].uiClass = hero.class.replace('-', ' ')

