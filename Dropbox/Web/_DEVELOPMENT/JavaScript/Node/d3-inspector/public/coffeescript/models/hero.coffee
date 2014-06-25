define (require) ->

  Backbone = require 'backbone'
  

  class Hero extends Backbone.Model

    initialize: (@options) =>
      @battleTag = @options.battleTag.replace('#', '-')

      # Grab the hero data from B.Net
      @setUrl(@options)


    setUrl: =>
      @url = "http://us.battle.net/api/d3/profile/#{@battleTag}/hero/#{@options.heroId}"


    logHero: =>
      # Fix the class name
      @set('class', @get('class').replace('-', ' '))

      # If saving, use the API URL instead of trying to save to B.Net
      @url = "/api/heroes"

      data =
        battleTag: @battleTag
        paragonLevel: @get('paragonLevel')
        heroId: @get('id')
        name: @get('name')
        level: @get('level')
        class: @get('class')

      # Save it
      $.ajax(
        url: @url
        type: "POST"
        contentType: "application/json"
        dataType: "json"
        data: JSON.stringify(data)
      )

      # Change the URL back
      @setUrl(@options)