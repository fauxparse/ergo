class Ergo.Components.Badge
  controller: (attrs) =>
    @player = m.prop(attrs.player)

  view: =>
    m(".badge.#{@player().ready() && "ready" || "waiting"}", [
      m("img[src=\"#{@player().avatar()}\"]"),
      m(".name", @player().name()),
      m(".icon", @player().goal())
    ])
