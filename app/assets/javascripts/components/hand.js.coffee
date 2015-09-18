class Ergo.Components.Hand
  controller: (attrs) =>
    @[key] = m.prop(value) for own key, value of attrs

  view: =>
    m(".hand",
      (m.component(new Ergo.Components.Card, {card}) for card in @hand().cards)
    )
