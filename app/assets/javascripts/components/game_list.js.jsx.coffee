@GameList = React.createClass
  getInitialState: ->
    { games: [] }

  componentDidMount: ->
    @channel = dispatcher.subscribe("_games")

  render: ->
    gameLinks = @renderGameLinks()
    return `(
      <ul className="games-list">
        {gameLinks}
      </ul>
    )`

  renderGameLinks: ->
    @state.games.map (game, index) ->
      return `(
        <li key={game.id}><a href="/games/{game.id}">Game</a></li>
      )`

$ ->
  $(".game-list").each ->
    React.render(React.createElement(GameList), this)
