class TurnValidator < ActiveModel::Validator
  def validate(turn)
    check_number_of_moves(turn.errors, turn)
    check_hand_size(turn.errors, turn.hand)
    check_proof(turn.errors, turn.round)
  end

  private

  def check_number_of_moves(errors, turn)
    wrong_number_of_moves(errors) unless turn.moves.length == 2
  end

  def check_hand_size(errors, hand)
    hand_size = hand.cards.compact.length
    too_many_cards_in_hand(errors, hand.player) unless hand_size <= Hand::SIZE
  end

  def wrong_number_of_moves(errors)
    errors.add(:base, :wrong_number_of_moves)
  end

  def too_many_cards_in_hand(errors, player)
    errors.add(:base, :too_many_cards_in_hand, player: player.position + 1)
  end

  def check_proof(errors, round)
    round.premises.sort_by(&:position).each do |premise|
      begin
        string = PremisePresenter.new(premise).to_s
        Logic::Solver.new([string])
      rescue RLTK::NotInLanguage
        errors.add(:base, :malformed_premise, premise: premise.position + 1)
      end
    end
  end
end
