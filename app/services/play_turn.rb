class PlayTurn
  include ActiveModel::Validations

  attr_reader :turn, :round

  delegate :player, to: :turn

  def initialize(round, turn)
    @round = round
    @turn = turn
  end

  def call
    round.with_lock do
      clean_slate
      apply_actions
      valid? && round.save && maybe_end_round
    end
  end

  private

  def clean_slate
    round.hands.reload
    round.premises.reload
    round.effect_cards.reload
    round.turns << turn
  end

  def apply_actions
    actions.each(&:apply)
  end

  def actions
    @turn.moves.map do |move|
      Actions.from_move(round, player, move)
    end
  end

  def maybe_end_round
    EndRound.new(round).call if round_should_end?
    true
  end

  def round_should_end?
    round.finished? || round.cards_remaining.zero?
  end
end
