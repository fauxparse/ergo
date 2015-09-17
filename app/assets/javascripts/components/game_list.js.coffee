class Ergo.GameListComponent
  controller: =>
    @games = m.prop([])
    @channel = Ergo.dispatcher.subscribe("_games")
    @channel.bind("create", @gameCreated)
    @channel.bind("update", @gameUpdated)
    $.getJSON("/games")
      .done (data) =>
        m.computation =>
          games = (new Ergo.Game(attrs) for attrs in data)
          @index = {}
          @index[game.id()] = game for game in games
          @games(games)

  gameCreated: (attrs) =>
    m.computation =>
      game = new Ergo.Game(attrs)
      @index[game.id()] = game
      @games().push(game)

  gameUpdated: (attrs) =>
    m.computation =>
      @index[attrs.id]?.update(attrs)

  view: =>
    m("ul.games", (@renderGame(game) for game in @games()))

  renderGame: (game) ->
    url = "/games/#{game.id()}"
    players = (@renderPlayer(player) for player in game.players())
    if players.length < 4
      players.push(
        m("li.join", [
          m("a[href=\"#{url}/players\"][data-method=\"post\"]", [
            m("i.material-icons", "add")
          ])
        ])
      )

    m("li.game[data-id=\"#{game.id()}\"]", [
      m("a.name[href=\"#{url}\"]", game.name()),
      m("ol.players", players)
    ])

  renderPlayer: (player) ->
    m("li.player[data-id=\"#{player.id()}\"]", [
      m("img[src=\"#{player.avatar()}\"]")
    ])

$ ->
  $(".game-list").each -> m.mount(this, new Ergo.GameListComponent)
