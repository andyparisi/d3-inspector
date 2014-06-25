define (require) ->

  Marionette = require 'marionette'

  RecentHeroesItem = require 'views/recent_heroes_item'


  class RecentHeroesView extends Marionette.CollectionView

    tagName: 'ul'
    className: 'recent-heroes-list'
    itemView: RecentHeroesItem