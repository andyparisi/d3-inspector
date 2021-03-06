// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Hero, HeroView, Item, ItemView, Items, LoadingView, Marionette, ProfileView, RecentHeroes, RecentHeroesView, Router, Template, vent, _ref;
    Marionette = require('marionette');
    Template = require('hbs!templates/profile');
    Router = require('router');
    vent = require('vent');
    Item = require('models/item');
    Hero = require('models/hero');
    Items = require('collections/items');
    RecentHeroes = require('collections/recent_heroes');
    HeroView = require('views/hero');
    ItemView = require('views/item');
    LoadingView = require('views/loading');
    RecentHeroesView = require('views/recent_heroes');
    return ProfileView = (function(_super) {
      __extends(ProfileView, _super);

      function ProfileView() {
        this.hideTooltip = __bind(this.hideTooltip, this);
        this.showTooltip = __bind(this.showTooltip, this);
        this.loadItem = __bind(this.loadItem, this);
        this.hideRecents = __bind(this.hideRecents, this);
        this.showRecents = __bind(this.showRecents, this);
        this.loadRecents = __bind(this.loadRecents, this);
        this.profileSearch = __bind(this.profileSearch, this);
        this.toggleLoading = __bind(this.toggleLoading, this);
        this.loadHero = __bind(this.loadHero, this);
        this.onShow = __bind(this.onShow, this);
        this.initialize = __bind(this.initialize, this);
        _ref = ProfileView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ProfileView.prototype.template = Template;

      ProfileView.prototype.className = 'profile';

      ProfileView.prototype.regions = {
        'heroes': '.heroes',
        'paperdoll': '.paperdoll',
        'tooltip': '.tooltip',
        'recentHeroList': '.recent-heroes-data'
      };

      ProfileView.prototype.events = {
        'click .heroes button': 'loadHero',
        'keypress .search-input': 'profileSearch',
        'click .search-input': 'showRecents',
        'mouseleave .recent-heroes': 'hideRecents',
        'mouseenter .hero-gear div': 'loadItem',
        'mouseleave .hero-gear div': 'hideTooltip',
        'mouseleave .paperdoll': 'hideTooltip'
      };

      ProfileView.prototype.ui = {
        buttons: '.heroes button',
        recentHeroes: '.recent-heroes',
        loading: '.loading'
      };

      ProfileView.prototype.initialize = function(options) {
        this.region = options.region;
        this.items = new Items();
        this.loadRecents();
        return this.listenTo(vent, {
          'loading': this.toggleLoading
        });
      };

      ProfileView.prototype.onShow = function() {
        return this.toggleLoading();
      };

      ProfileView.prototype.loadHero = function(e) {
        var hero, route,
          _this = this;
        hero = new Hero({
          battleTag: this.model.get('battleTag'),
          heroId: $(e.currentTarget).attr('data-id')
        });
        route = "profile/" + (this.model.get('battleTag').toLowerCase().replace('#', '-')) + "/hero/" + ($(e.currentTarget).attr('data-id'));
        Router.navigate(route);
        this.toggleLoading();
        this.ui.buttons.removeClass('is-selected');
        $(e.currentTarget).addClass('is-selected');
        return hero.fetch({
          dataType: 'jsonp',
          success: function(col, res) {
            _this.paperdoll.show(new HeroView({
              model: hero
            }));
            _this.paperdoll.$el.removeClass('is-hidden');
            hero.logHero();
            return _this.toggleLoading();
          }
        });
      };

      ProfileView.prototype.toggleLoading = function() {
        return this.ui.loading.toggleClass('is-hidden');
      };

      ProfileView.prototype.profileSearch = function(e) {
        var profile;
        if (e.which === 13) {
          profile = $(e.currentTarget).val().replace('#', '-');
          return vent.trigger('hero:load', profile);
        }
      };

      ProfileView.prototype.loadRecents = function() {
        var recentHeroes,
          _this = this;
        recentHeroes = new RecentHeroes();
        return recentHeroes.fetch({
          success: function(res) {
            if (res) {
              _this.recentResults = true;
            }
            return _this.recentHeroList.show(new RecentHeroesView({
              collection: recentHeroes
            }));
          }
        });
      };

      ProfileView.prototype.showRecents = function() {
        this.loadRecents();
        if (this.recentResults) {
          return this.ui.recentHeroes.addClass('is-loaded');
        }
      };

      ProfileView.prototype.hideRecents = function() {
        return this.ui.recentHeroes.removeClass('is-loaded');
      };

      ProfileView.prototype.loadItem = function(e) {
        var cachedItem, item, slot, tooltip,
          _this = this;
        tooltip = $(e.currentTarget).attr('data-tooltip');
        slot = $(e.currentTarget).attr('data-slot');
        item = new Item({
          itemTooltip: tooltip,
          itemSlot: slot
        });
        if (tooltip) {
          cachedItem = this.items.findWhere({
            tooltipParams: tooltip
          });
          if (cachedItem) {
            this.tooltip.show(new ItemView({
              model: cachedItem
            }));
            return this.showTooltip(e);
          }
          this.toggleLoading();
          return item.fetch({
            dataType: 'jsonp',
            success: function(col, res) {
              item.setStrings();
              _this.items.add(item);
              _this.tooltip.show(new ItemView({
                model: item
              }));
              _this.toggleLoading();
              return _this.showTooltip(e);
            }
          });
        }
      };

      ProfileView.prototype.showTooltip = function(e) {
        var height, offset, scrollTop, topPos, width;
        offset = $(e.currentTarget).offset();
        width = $(e.currentTarget).width();
        height = $(e.currentTarget).height();
        scrollTop = $(window).scrollTop();
        topPos = offset.top - this.tooltip.$el.height() - 17;
        if (topPos < 0) {
          topPos = 0;
        }
        if (topPos < scrollTop) {
          topPos = scrollTop;
        }
        return this.tooltip.$el.css({
          top: topPos,
          left: offset.left + width + 5
        }).removeClass('is-hidden');
      };

      ProfileView.prototype.hideTooltip = function() {
        if (this.tooltip.$el) {
          return this.tooltip.$el.addClass('is-hidden');
        }
      };

      return ProfileView;

    })(Marionette.Layout);
  });

}).call(this);
