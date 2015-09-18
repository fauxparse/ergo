class Ergo.Components.GameStatus
  controller: (attrs) =>
    @game = attrs.game

  view: =>
    m(".game-status", @messages())

  messages: =>
    if @game.players().length < 2
      m(".message.waiting", "Waiting for players…")
