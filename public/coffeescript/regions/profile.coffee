define (require) ->
  
  Marionette = require 'marionette'
  vent = require 'vent'
  Router = require 'router'

  Profile = require 'models/profile'

  # Views
  ProfileView = require 'views/profile'


  class ProfileRegion extends Marionette.Region

    el: '#profile'


    initialize: (options) =>
      # Load a hero
      @listenTo(vent, 'hero:load', (battleTag, heroId) =>
        if battleTag? and heroId? then @fetchProfile(battleTag, heroId)
        else if not heroId
          @fetchProfile(battleTag)
          route = "profile/#{battleTag.toLowerCase().replace('#', '-')}"
          Router.navigate(route); 
      )

      profile = new Profile()
      @profileView = new ProfileView({ model: profile, region: @ })
      @show(@profileView)


    fetchProfile: (battleTag, heroId) =>
      profile = new Profile({ battleTag: battleTag })

      # Show the loading indicator
      vent.trigger('loading')

      # Get the user's profile from Battle.net
      profile.fetch(
        dataType: 'jsonp'
        success: (model, res) =>
          # If BattleTag not found, alert the user
          if res.code is 'NOTFOUND'
            vent.trigger('loading')
            return @handleError()

          # Show everything once the profile is loaded
          profile.setStrings()
          @profileView = new ProfileView({ model: profile, region: @ })
          @show(@profileView) 
          @profileView.$('.heroes').removeClass('is-hidden')

          # If heroId param is present, load that hero
          if heroId? then @profileView.$(".heroes [data-id='#{heroId}']").click()

          # Hide the indicator
          vent.trigger('loading')

        error: (model, res) =>
          @handleError(res)
      )


    handleError: (res) =>
      if res then console.log(res)
      else alert('Battle.net Error: BattleTag not found')