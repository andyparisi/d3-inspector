define (require) ->
  
  Marionette = require 'marionette'

  Template = require 'hbs!templates/profile'
  Router = require 'router'
  vent = require 'vent'

  # Models
  Item = require 'models/item'
  Hero = require 'models/hero'

  # Collections
  Items = require 'collections/items'
  RecentHeroes = require 'collections/recent_heroes'

  # Views
  HeroView = require 'views/hero'
  ItemView = require 'views/item'
  LoadingView = require 'views/loading'
  RecentHeroesView = require 'views/recent_heroes'


  class ProfileView extends Marionette.Layout

    template: Template
    className: 'profile'

    regions:
      'heroes': '.heroes'
      'paperdoll': '.paperdoll'
      'tooltip': '.tooltip'
      'recentHeroList': '.recent-heroes-data'

    events:
      'click .heroes button': 'loadHero'
      'keypress .search-input': 'profileSearch'
      'click .search-input': 'showRecents'
      'mouseleave .recent-heroes': 'hideRecents'
      'mouseenter .hero-gear div': 'loadItem'
      'mouseleave .hero-gear div': 'hideTooltip'
      'mouseleave .paperdoll': 'hideTooltip'

    ui:
      buttons: '.heroes button'
      recentHeroes: '.recent-heroes'
      loading: '.loading'


    initialize: (options) =>
      @region = options.region
      @items = new Items()
      @loadRecents()

      # Listen for the loading indicator
      @listenTo(vent, 
        'loading': @toggleLoading
      )


    onShow: =>
      @toggleLoading()


    loadHero: (e) =>
      hero = new Hero(
        battleTag: @model.get('battleTag')
        heroId: $(e.currentTarget).attr('data-id')
      )

      # Router
      route = "profile/#{@model.get('battleTag').toLowerCase().replace('#', '-')}/hero/#{$(e.currentTarget).attr('data-id')}"
      Router.navigate(route); 

      # Show the loading indicator
      @toggleLoading()

      # Select the button
      @ui.buttons.removeClass('is-selected')
      $(e.currentTarget).addClass('is-selected')

      hero.fetch(
        dataType: 'jsonp'
        success: (col, res) =>
          # Show the paper doll for the hero
          @paperdoll.show(new HeroView({ model: hero }))
          @paperdoll.$el.removeClass('is-hidden')

          # Log the hero
          hero.logHero()

          # Hide the indicator
          @toggleLoading()
      )


    toggleLoading: =>
      @ui.loading.toggleClass('is-hidden')


    profileSearch: (e) =>
      if e.which is 13
        profile = $(e.currentTarget).val().replace('#', '-')
        vent.trigger('hero:load', profile)


    loadRecents: =>
      recentHeroes = new RecentHeroes()
      recentHeroes.fetch(
        success: (res) =>
          if res then @recentResults = true
          @recentHeroList.show(new RecentHeroesView({ collection: recentHeroes}))
      )
      

    showRecents: =>
      @loadRecents()

      # If recent results, show the list
      if @recentResults then @ui.recentHeroes.addClass('is-loaded')


    hideRecents: =>
      @ui.recentHeroes.removeClass('is-loaded')


    loadItem: (e) =>
      tooltip = $(e.currentTarget).attr('data-tooltip')
      slot = $(e.currentTarget).attr('data-slot')
      item = new Item({ itemTooltip: tooltip, itemSlot: slot })

      if tooltip
        # Check the cache, use that item if it exists
        cachedItem = @items.findWhere({ tooltipParams: tooltip })
        if cachedItem 
          @tooltip.show(new ItemView({ model: cachedItem }))
          
          # Show the tooltip
          return @showTooltip(e)

        # Show the loading indicator
        @toggleLoading()

        # Fetch if not cached
        item.fetch(
          dataType: 'jsonp'
          success: (col, res) =>
            item.setStrings()

            # Cache the item
            @items.add(item)

            # Load the item tooltip
            @tooltip.show(new ItemView({ model: item }))

            # Hide the indicator
            @toggleLoading()

            # Show the tooltip
            @showTooltip(e)
        )


    showTooltip: (e) =>
      # Show the tooltip
      offset = $(e.currentTarget).offset()
      width = $(e.currentTarget).width()
      height = $(e.currentTarget).height()
      scrollTop = $(window).scrollTop()

      # Calculate the top position
      topPos = offset.top - @tooltip.$el.height() - 17
      if topPos < 0 then topPos = 0
      if topPos < scrollTop then topPos = scrollTop

      @tooltip.$el.css({ 
        top: topPos
        left: offset.left + width + 5
      }).removeClass('is-hidden')


    hideTooltip: =>
      if @tooltip.$el
        @tooltip.$el.addClass('is-hidden')