Given(/^a (\d+)-player game$/) do |n|
  @game = FactoryGirl.create(:game)
  n.to_i.times do
    AddPlayer.new(@game).call
  end
  step "Player 1 is the first player"
  step "a new round starts"
end

Given(/^the board shows "(.*)" from the previous turn$/) do |state|
  step "a 3-player game"
  @round.premises = state.split(",").map.with_index do |row, position|
    played_cards = row.chars.map.with_index do |c, i|
      played_card_from_display_char(c, i)
    end
    Premise.new(played_cards: played_cards, position: position)
  end
  @round.save
end

Given(/^Player (\d+) is the first player$/) do |player|
  allow(@game).to receive(:starting_player_number)
    .and_return(player.to_i - 1)
end

Then(/^it is Player (\d+)’s turn$/) do |player|
  allow(@round).to receive(:active_player)
    .and_return(@round.players[player.to_i - 1])
  begin_turn = BeginTurn.new(@round)
  begin_turn.call
  @turn = begin_turn.turn
end

Given(/^a new round starts$/) do
  service = CreateRound.new(@game)
  service.call
  @round = service.round
  @game.players.each do |player|
    expect(hand_for(player).cards.size).to eq Hand::SIZE
  end
end

Given(/^Player (\d+) draws an? (.*) and an? (.*)$/) do |player, *cards|
  step "it is Player #{player}’s turn"
  hand = hand_for(player_number(player))
  service = DrawCards.new(hand, cards.length)
  cards = cards.map { |card| card_named(card) }
  allow(service).to receive(:cards).and_return(cards)
  service.call
  expect(hand.cards_array[-cards.length, cards.length])
    .to eq(cards.map(&:to_sym).map(&:to_s))
end

When(/^Player (\d+) plays an? (.*) at position (\d+) of premise (\d+)(?:, rotated (\d+) degrees)?$/) do |player, card, position, premise, rotation|
  options = {
    premise: premise.to_i - 1,
    position: position.to_i - 1,
    rotation: rotation && (rotation.to_i / 90) || 0
  }
  insert_card(player, card, options)
end

When(/^Player (\d+) discards an? (.*)$/) do |player, card|
  discard(player, card)
end

When(/^Player (\d+) plays a tabula rasa on position (\d+) of premise (\d+)$/) do |player, position, premise|
  options = {
    premise: premise.to_i - 1,
    position: position.to_i - 1
  }
  play_card(player, :tabula_rasa, options)
end

When(/^Player (\d+) plays a fallacy on Player (\d+)$/) do |player, target|
  options = {
    player_id: player_number(player).id,
    target_id: player_number(target).id
  }
  play_card(player, :fallacy, options)
end

When(/^Player (\d+) plays an ergo$/) do |player|
  play_card(player, :ergo)
end

When(/^Player (\d+) ends their turn$/) do |player|
  expect(@turn).to be_present
  expect(@turn.player).to eq(player_number(player))
  service = PlayTurn.new(@round, @turn)
  service.call
  @turn = nil
end

Then(/^the proof shows "(.*?)"$/) do |string|
  proof = ProofPresenter.new(@round)
  expect(proof.to_s).to eq(string)
end

Then(/^the round is over$/) do
  expect(@round).to be_finished
end

Then(/^Player (\d+) has (\d+) points$/) do |player, score|
  expect(player_number(player).score).to eq score.to_i
end
