class Ergo.Components.Badge
  controller: (attrs) =>
    @player = m.prop(attrs.player)

  view: =>
    icon = @player().ready() && "check" || "schedule"
    m(".badge", [
      m("img[src=\"#{@player().avatar()}\"]"),
      m(".name", @player().name()),
      m(".icon", m("i.material-icons", icon))
    ])
