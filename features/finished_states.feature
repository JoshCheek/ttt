Feature: Finished states

  In order to finish the game, the library must know what a finished state is.
  A finished state is a state that either has no available moves left, or where
  a player has won the game. A player has won the game if they have marked
  three consecutive spaces in a horizontal, vertical, or diagonal direction.
  
  Scenario: No winner, no available moves left
    Given a tie game
    Then the game is over
  
  Scenario Outline: Three marks in a row
    When I create a game with "<configuration>"
    Then the game is over
    And player<winner> wins
    
    Scenarios: Horizontal win
      | configuration | winner |
      | 111000000     | 1      |
      | 000111000     | 1      |
      | 000000111     | 1      |
      | 222000000     | 2      |
      | 000222000     | 2      |
      | 000000222     | 2      |

    Scenarios: Vertical win
      | configuration | winner |
      | 100100100     | 1      |
      | 010010010     | 1      |
      | 001001001     | 1      |
      | 200200200     | 2      |
      | 020020020     | 2      |
      | 002002002     | 2      |
    
    Scenarios: Diagonal win
      | configuration | winner |
      | 100010001     | 1      |
      | 001010100     | 1      |
      | 200020002     | 2      |
      | 002020200     | 2      |
