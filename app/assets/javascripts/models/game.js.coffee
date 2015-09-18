class Ergo.Models.Game
  constructor: (attrs) ->
    @id = m.prop(attrs.id)
    @players(attrs.players)
    @round = m.prop(attrs.round)

  name: =>
    @id().split("-").join(" ")

  update: (attrs) =>
    for own key, value of attrs
      this[key](value)

  players: (players) ->
    if players?
      @_players = (new Ergo.Models.Player(player) for player in players)
    @_players ||= []

  ready: ->
    return true if @round()
    return false for player in @players() when !player.ready()
    true
