define (require) ->

  Backbone = require 'backbone'
  

  class Item extends Backbone.Model

    initialize: (@options) =>
      @url = "http://us.battle.net/api/d3/data/#{@options.itemTooltip}"


    setStrings: =>
      # Check for armor
      if @get('armor')
        @set({
          'uiValue': @get('armor').max
          'uiValueType': 'Armor'
        })

      # Check for non-weapon slots
      switch @options.itemSlot
        when 'leftFinger' then slot = 'Finger'
        when 'rightFinger' then slot = 'Finger'
        when 'offHand' then slot = 'Off-Hand'
        else slot = @options.itemSlot

      # Check for weapons
      if @get('dps')
        @set({
          'uiValue': @get('dps').max.toFixed(1)
          'uiValueType': 'Damage Per Second'
          'uiAPS': @get('attacksPerSecond').max.toFixed(2)
        })

        # Slot values for weapons
        if @get('type').twoHanded then slot = '2-Hand' else slot = '1-Hand'

      # Set block chance, if any
      if @get('blockChance')
        @set('uiBlockChance', "#{(@get('blockChance').max * 100).toFixed(1)}%")

      # Set block amount, if any
      if @get('attributesRaw')?.Block_Amount_Item_Min
        min = @get('attributesRaw').Block_Amount_Item_Min.max.toFixed(0)
        max = +@get('attributesRaw').Block_Amount_Item_Min.max.toFixed(0) + +@get('attributesRaw').Block_Amount_Item_Delta.max.toFixed(0)
        blockAmount = min + "-" + max

        @set('uiBlockAmount', blockAmount)

      # Set the slot
      @set('uiSlot', slot)

      # Attributes
      if @get('attributes')?.primary then @set('uiAttrPrimary', @span(@get('attributes').primary, 'text'))
      if @get('attributes')?.secondary then @set('uiAttrSecondary', @span(@get('attributes').secondary, 'text'))
      if @get('attributes')?.passive then @set('uiAttrPassive', @span(@get('attributes').passive, 'text'))

      # Gems
      if @get('gems')?
        gems = []

        for gem in @get('gems')
          # Use a primary attribute by default, otherwise use a secondary attribute
          if gem.attributes.primary[0]? then text = gem.attributes.primary[0].text
          else if gem.attributes.secondary[0]? then text = gem.attributes.secondary[0].text

          gem = 
            name: gem.item.name
            icon: gem.item.icon
            text: text
            attrs: gem.attributesRaw

          gems.push(gem)

        @set('uiGems', gems)


    span: (source, prop) =>
      attrs = []

      for attr in source
        attr[prop] = attr[prop].replace(/\.(?!\d)/, '').replace(/[{+}0-9\.?{%}]+/g, (str) ->
          return "<span>#{str}</span>"
        )
        attrs.push(attr)

      return attrs