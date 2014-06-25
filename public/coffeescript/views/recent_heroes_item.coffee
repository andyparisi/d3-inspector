define (require) ->

  Marionette = require 'marionette'
  template = require 'hbs!templates/recent_hero_item'


  class RecentHeroItemView extends Marionette.ItemView

    tagName: 'li'
    className: 'recent-heroes-item'
    template: template


    initialize: (options) =>
      @templateHelpers =
        battleTagURL: @model.get('battleTag').toLowerCase()