Feature: Mark board

  In order to play the game
  As a player (or, more probably, an interface translating a player's desire)
  I want to mark the board

  Scenario: Marking an empty board
    Given I create a new game
    When I mark position 1
    Then the game board is "100000000"

  Scenario: Marking a board when it is player1s turn
    Given I create a game with "120000000"
    Then it is player1s turn
    When I mark position 4
    Then the game board is "120100000"
    And it is player2s turn
  
  Scenario: Marking a board when it is player2s turn
    Given I create a game with "120100000"
    Then it is player2s turn
    When I mark position 7
    Then the game board is "120100200"
    And it is player1s turn
