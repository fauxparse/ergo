class CreateGame
  attr_reader :game

  def initialize(owner = nil)
    @owner = owner
  end

  def call
    @game = Game.create!
    JoinGame.new(@game, @owner).call if @owner.present?
    signal_game_creation
    true
  end

  private

  def signal_game_creation
    data = ActiveModel::SerializableResource.new(@game).as_json
    WebsocketRails[:_games].trigger(:create, data)
  end
end
