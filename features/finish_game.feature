Feature: Finish game

  In order to allow for actual gameplay
  As a player
  I can win, lose, and tie

  Scenario: Player1 wins  
    Given I create a game with "120120000"
    Then the game is not over
    When I mark position 7
    Then the game board is "120100100"
    And the game is over
    And player1 wins
    And player2 loses
    And it is no one's turn
  
  Scenario: Player2 wins  
    Given I create a game with "121120000"
    Then the game is not over
    When I mark position 8
    Then the game board is "121120020"
    And the game is over
    And player2 wins
    And player1 loses
    And it is no one's turn

  Scenario: The players tie
    Given I create a game with "121221012"
    Then the game is not over
    When I mark position 7
    Then the game board is "121221112"
    And the game is over
    And player1 ties
    And player2 ties
    And it is no one's turn
  