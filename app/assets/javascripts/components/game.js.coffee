class Ergo.Components.Game
  controller: =>
    @game = m.prop()
    @player = m.prop()
    $.when(@loadGame(), @loadPlayer()).then (game_attrs, player_attrs) =>
      m.computation =>
        @game(new Ergo.Models.Game(game_attrs[0]))
        @player(new Ergo.Models.Player(player_attrs[0]))
        @channel = Ergo.dispatcher.subscribe(@game().id())
        @channel.bind("joined", @playerJoined)
        @channel.bind("round", @startRound)

  loadGame: ->
    $.getJSON(location.pathname)

  loadPlayer: ->
    $.getJSON(location.pathname + "/player")

  playerJoined: (attrs) =>
    m.computation =>
      @game().players().push(new Ergo.Models.Player(attrs))

  startRound: (attrs) =>
    console.log "start round: ", attrs
    m.computation =>
      @game().round(new Ergo.Models.Round(attrs))

  view: =>
    if @player()
      m(".playing-area[data-playing-as=\"#{@player().position()}\"][data-number-of-players=\"#{@game().players().length}\"]", [
        m(".players", @renderPlayers()),
        m(".proof"),
        m.component(new Ergo.Components.GameStatus, game: @game())
      ])

  renderPlayers: =>
    players = @game().players().slice(0)
    players.push(players.shift()) while players[0].id() != @player().id()
    players.map (player) =>
      options = { player: player, game: @game(), channel: @channel }
      if player.id() == @player().id()
        m.component(new Ergo.Components.Self, options)
      else
        m.component(new Ergo.Components.Player, options)

$ -> $(".play-game").each -> m.mount(this, new Ergo.Components.Game)
