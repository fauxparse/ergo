class CreateGame
  attr_reader :game

  def call
    @game = Game.create!
    true
  end
end
