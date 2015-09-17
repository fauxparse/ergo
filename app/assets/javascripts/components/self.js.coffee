class Ergo.Components.Self
  controller: (options) =>
    for own key, value of options
      this[key] = m.prop(value)

  view: =>
    m(".player[data-id=\"#{@player().id()}\"]",
      m.component(new Ergo.Components.Badge, player: @player())
      @readyButton()
    )

  readyButton: =>
    ready = @player().ready() && "Ready" || "Not ready"
    m("button[rel=\"ready\"]", { onclick: @toggleReadiness }, ready)

  toggleReadiness: =>
    @player().ready(!@player().ready())
    m.request
      url: "#{location.pathname}/player"
      method: "PUT"
      data: { ready: @player().ready() }
