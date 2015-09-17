class UpdatePlayer
  def initialize(game, player, params)
    @game = game
    @player = player
    @params = params
  end

  def call
    if @params.key?(:ready)
      setReadyState(@params.delete(:ready))
    end
  end

  private

  def setReadyState(ready)
    @player.update!(ready: ready)
    @game.channel.trigger(:ready, @player.id => @player.ready)
  end
end
