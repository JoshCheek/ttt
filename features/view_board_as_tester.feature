Feature: View board as tester

  In order to verify game state
  As a tester
  I want to view the board as a simple string
  
  Scenario: View board in string format
    Given I create a game with "abcdefghi"
    Then the game board is "abcdefghi"
