class Ergo.Player
  constructor: (attrs) ->
    for own key, value of attrs
      this[key] = m.prop(value)
