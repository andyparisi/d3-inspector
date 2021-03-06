// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Router, vent, _ref;
    Backbone = require('backbone');
    vent = require('vent');
    Router = (function(_super) {
      __extends(Router, _super);

      function Router() {
        this.hero = __bind(this.hero, this);
        this.profile = __bind(this.profile, this);
        _ref = Router.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Router.prototype.routes = {
        'profile/:battleTag': 'profile',
        'profile/:battleTag/hero/:heroId': 'hero'
      };

      Router.prototype.profile = function(battleTag) {
        return vent.trigger('hero:load', battleTag);
      };

      Router.prototype.hero = function(battleTag, heroId) {
        return vent.trigger('hero:load', battleTag, heroId);
      };

      return Router;

    })(Backbone.Router);
    return new Router();
  });

}).call(this);
