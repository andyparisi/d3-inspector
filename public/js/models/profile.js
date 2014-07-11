// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Profile;
    Backbone = require('backbone');
    return Profile = (function(_super) {
      __extends(Profile, _super);

      function Profile() {
        this.setStrings = __bind(this.setStrings, this);
        this.initialize = __bind(this.initialize, this);
        return Profile.__super__.constructor.apply(this, arguments);
      }

      Profile.prototype.initialize = function(options) {
        if (options != null) {
          return this.url = "http://us.battle.net/api/d3/profile/" + options.battleTag + "/";
        }
      };

      Profile.prototype.setStrings = function() {
        var hero, index, _i, _len, _ref, _results;
        _ref = this.get('heroes');
        _results = [];
        for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
          hero = _ref[index];
          _results.push(this.get('heroes')[index].uiClass = hero["class"].replace('-', ' '));
        }
        return _results;
      };

      return Profile;

    })(Backbone.Model);
  });

}).call(this);
