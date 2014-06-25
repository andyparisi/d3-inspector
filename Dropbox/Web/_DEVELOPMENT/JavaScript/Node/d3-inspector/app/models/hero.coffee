mongoose = require('mongoose')
Schema = mongoose.Schema

# Hero schema
Hero = new Schema({
    heroId: Number
    battleTag: String
    name: String
    class: String
    level: Number
    paragonLevel: Number
  }, {
    collection: 'heroes'
  }
)

mongoose.model('Hero', Hero)