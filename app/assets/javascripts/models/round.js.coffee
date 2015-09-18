class Ergo.Models.Round
  constructor: (attrs) ->
    for own key, value of attrs
      this[key] = m.prop(value)
