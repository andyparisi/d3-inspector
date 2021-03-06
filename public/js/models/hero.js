// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Hero, _ref;
    Backbone = require('backbone');
    return Hero = (function(_super) {
      __extends(Hero, _super);

      function Hero() {
        this.logHero = __bind(this.logHero, this);
        this.setUrl = __bind(this.setUrl, this);
        this.initialize = __bind(this.initialize, this);
        _ref = Hero.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Hero.prototype.initialize = function(options) {
        this.options = options;
        this.battleTag = this.options.battleTag.replace('#', '-');
        return this.setUrl(this.options);
      };

      Hero.prototype.setUrl = function() {
        return this.url = "http://us.battle.net/api/d3/profile/" + this.battleTag + "/hero/" + this.options.heroId;
      };

      Hero.prototype.logHero = function() {
        var data;
        this.set('class', this.get('class').replace('-', ' '));
        this.url = "/api/heroes";
        data = {
          battleTag: this.battleTag,
          paragonLevel: this.get('paragonLevel'),
          heroId: this.get('id'),
          name: this.get('name'),
          level: this.get('level'),
          "class": this.get('class')
        };
        $.ajax({
          url: this.url,
          type: "POST",
          contentType: "application/json",
          dataType: "json",
          data: JSON.stringify(data)
        });
        return this.setUrl(this.options);
      };

      return Hero;

    })(Backbone.Model);
  });

}).call(this);
