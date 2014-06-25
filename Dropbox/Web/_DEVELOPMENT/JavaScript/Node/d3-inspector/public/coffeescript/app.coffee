define (require) ->

  Marionette = require 'marionette'
  Router = require 'router'

  # Views
  ProfileRegion = require 'regions/profile'


  class App extends Marionette.Application

    initialize: =>
      @listenTo(@, "initialize:after", @appSetup)
      @start()


    appSetup: =>
      @addRegions({
        profile: new ProfileRegion()
      })

      # Start the Router
      Backbone.history.start()

  return new App()
