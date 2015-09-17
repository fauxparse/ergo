class Ergo.Components.Game
  controller: =>
    $.when(@loadGame(), @loadPlayer()).then (game_attrs, player_attrs) =>
      m.computation =>
        @game = new Ergo.Game(game_attrs[0])
        @player = new Ergo.Player(player_attrs[0])
        @channel = Ergo.dispatcher.subscribe(@game.id())

  loadGame: ->
    $.getJSON(location.pathname)

  loadPlayer: ->
    $.getJSON(location.pathname + "/player")

  view: =>
    if @player
      m(".playing-area[data-playing-as=\"#{@player?.position()}\"][data-number-of-players=\"#{@game.players().length}\"]", [
        m(".players", @renderPlayers()),
        m(".proof")
      ])

  renderPlayers: =>
    players = @game.players().slice(0)
    players.push(players.shift()) while players[0].id() != @player.id()
    players.map (player) =>
      options = {player: player, game: @game, channel: @channel}
      if player.id() == @player.id()
        m.component(new Ergo.Components.Self, options)
      else
        m.component(new Ergo.Components.Player, options)

$ -> $(".play-game").each -> m.mount(this, new Ergo.Components.Game)
