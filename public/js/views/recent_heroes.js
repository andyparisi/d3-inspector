// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Marionette, RecentHeroesItem, RecentHeroesView, _ref;
    Marionette = require('marionette');
    RecentHeroesItem = require('views/recent_heroes_item');
    return RecentHeroesView = (function(_super) {
      __extends(RecentHeroesView, _super);

      function RecentHeroesView() {
        _ref = RecentHeroesView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      RecentHeroesView.prototype.tagName = 'ul';

      RecentHeroesView.prototype.className = 'recent-heroes-list';

      RecentHeroesView.prototype.itemView = RecentHeroesItem;

      return RecentHeroesView;

    })(Marionette.CollectionView);
  });

}).call(this);
