define (require) ->

  Backbone = require 'backbone'
  vent = require 'vent'


  class Router extends Backbone.Router

    routes:
      'profile/:battleTag': 'profile'
      'profile/:battleTag/hero/:heroId': 'hero'


    profile: (battleTag) =>
      vent.trigger('hero:load', battleTag)


    hero: (battleTag, heroId) =>
      vent.trigger('hero:load', battleTag, heroId)

  return new Router()