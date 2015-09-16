Feature: Play the example game from the rules
  As a player
  I want to play an example game of Ergo
  So that I can pick up the rules

  Scenario: Example game
    Given a 3-player game
    And Player 1 draws an A and a Parenthesis
    When Player 1 plays an A at position 1 of premise 1
    And Player 1 discards a Parenthesis
    And Player 1 ends their turn
    Then the proof shows "A"

    Given Player 2 draws an Or and a B
    When Player 2 plays an Or at position 2 of premise 1
    And Player 2 plays a B at position 3 of premise 1
    And Player 2 ends their turn
    Then the proof shows "A∨B"

    Given Player 3 draws a B and a Not
    When Player 3 plays a Not at position 1 of premise 2
    And Player 3 plays a B at position 2 of premise 2
    And Player 3 ends their turn
    Then the proof shows "A∨B,~B"

    Given Player 1 draws a C and a Not
    When Player 1 plays a Not at position 1 of premise 3
    And Player 1 plays a C at position 2 of premise 3
    And Player 1 ends their turn
    Then the proof shows "A∨B,~B,~C"

    Given Player 2 draws a C and a Then
    When Player 2 plays a Then at position 3 of premise 2
    And Player 2 plays a C at position 4 of premise 2
    And Player 2 ends their turn
    Then the proof shows "A∨B,~B⊃C,~C"

    Given Player 3 draws a Parenthesis and a Parenthesis
    When Player 3 plays a Parenthesis at position 1 of premise 3
    And Player 3 plays a Parenthesis at position 4 of premise 3, rotated 180 degrees
    And Player 3 ends their turn
    Then the proof shows "A∨B,~B⊃C,(~C)"

    Given Player 1 draws a Fallacy and an A
    When Player 1 plays a Fallacy on Player 2
    And Player 1 discards an A
    And Player 1 ends their turn
    Then the proof shows "A∨B,~B⊃C,(~C)"
    And there is a Fallacy in front of Player 2

    Given Player 2 draws an A and a B
    When Player 2 discards an A
    And Player 2 discards a B
    And Player 2 ends their turn
    Then the proof shows "A∨B,~B⊃C,(~C)"
    And there is a fallacy in front of Player 2

    Given Player 3 draws a Not and a D
    When Player 3 plays a Not at position 1 of premise 3
    And Player 3 plays a D at position 1 of premise 4
    And Player 3 ends their turn
    Then the proof shows "A∨B,~B⊃C,~(~C),D"
    And there is a fallacy in front of Player 2

    Given Player 1 draws a Tabula Rasa and an Ergo
    When Player 1 plays a Tabula Rasa on position 3 of premise 3
    And Player 1 plays an Ergo
    And Player 1 ends their turn
    Then the proof shows "A∨B,~B⊃C,~(C),D"
    And the round is over
    And Player 1 has 0 points
    And Player 2 has 12 points
    And Player 3 has 0 points
