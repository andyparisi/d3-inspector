mongoose = require('mongoose')
models = require('../models/hero')
Hero = mongoose.model('Hero')


module.exports =

  index: (req, res) ->
    Hero.find().exec((err, heroes) ->
      if err then res.render('error', {status: 500})
      else if not heroes.length then res.send('No records found')
      else res.jsonp(heroes)
    )


  get: (req, res) ->  
    Hero.find(
      _id: req.params.id
    ).exec((err, hero) ->
      if err then res.render('error', {status: 500})
      else if not hero.length then res.send('No record found')
      else res.jsonp(hero)
    )


  add: (req, res) ->
    # Check to see if this hero is already logged
    Hero.find({ heroId: req.body.heroId }, (err, results) ->
      if results.length is 0
        # Log the hero
        hero = new Hero(req.body)
        hero.save((err) ->
          if err then res.jsonp('Error: ' + err)
          else res.jsonp(hero)
        )
      else
        # If the hero is already logged, send it back
        res.jsonp(results[0])
    )


  update: (req, res) ->
    Hero.findByIdAndUpdate(req.params.id, req.body, (err, hero) ->
      if err then res.send('Error: ' + err)
      else res.jsonp(hero)
    )


  delete: (req, res) ->
    Hero.findByIdAndRemove(req.params.id, (err, hero) ->
      if err then res.send('Error: ' + err)
      else res.jsonp(hero)
    )