class Ergo.Components.Card
  controller: (attrs) =>
    @[key] = m.prop(value) for own key, value of attrs

  view: =>
    m(".card.#{@card()}", [
      m(".face", [
        m(".symbol", Ergo.SYMBOLS[@card()] || @card())
      ]),
      m(".back")
    ])
