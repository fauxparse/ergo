class Ergo.Game
  constructor: (attrs) ->
    @id = m.prop(attrs.id)
    @players(attrs.players)

  name: =>
    @id().split("-").join(" ")

  update: (attrs) =>
    for own key, value of attrs
      this[key](value)

  players: (players) ->
    if players?
      @_players = (new Ergo.Player(player) for player in players)
    @_players ||= []
