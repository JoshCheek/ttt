Feature: Finish game

  In order to allow for actual gameplay
  As a player
  I can win, lose, and tie

  Scenario: Player1 wins  
    Given I create a game with "120120000"
    Then the game is not over
    When I mark position 7
    Then the game board is "120120100"
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

  Scenario Outline: I can ask which positions won
    Given I create a game with "<configuration>"
    When I ask what positions won
    Then it tells me [<p1>, <p2>, <p3>]
    
    Scenarios:
      | configuration | p1 | p2 | p3 |
      | 111220000     | 1  | 2  | 3  |
      | 220111000     | 4  | 5  | 6  |
      | 220000111     | 7  | 8  | 9  |
      | 120120100     | 1  | 4  | 7  |
      | 210210010     | 2  | 5  | 8  |
      | 201201001     | 3  | 6  | 9  |
      | 120210001     | 1  | 5  | 9  |
      | 021210100     | 3  | 5  | 7  |
      | 021210100     | 3  | 5  | 7  |
      | 211210200     | 1  | 4  | 7  |
