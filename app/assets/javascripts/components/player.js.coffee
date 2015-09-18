class Ergo.Components.Player
  controller: (options) =>
    for own key, value of options
      this[key] = m.prop(value)
    @channel().bind("ready", @updateReadiness)

  updateReadiness: (data) =>
    m.computation =>
      @player().ready(data[@player().id()]) if data[@player().id()]?

  view: =>
    m(".player[data-id=\"#{@player().id()}\"]",
      m.component(new Ergo.Components.Badge, player: @player()),
      @game().ready() && @hand()
    )

  hand: =>
    m.component(new Ergo.Components.Hand, player: @player(), hand: @game().round().hands[@player().id()], self: false)
