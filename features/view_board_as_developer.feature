Feature: View board as developer

  In order to be able to do exploratory testing
  As a developer
  I want to be able to view the board in standard tic-tac-toe format
  
  Scenario: View board in tic-tac-toe format
    Given I create a game with "abcdefghi"
    Then board(:ttt) will be "  a | b | c  \n----|---|----\n  d | e | f  \n----|---|----\n  g | h | i  "
  
  Scenario: Viewing a board with spaces no one has moved into
  Given I create a game with "120000000"
  Then board(:ttt) will be "  1 | 2 |    \n----|---|----\n    |   |    \n----|---|----\n    |   |    "
