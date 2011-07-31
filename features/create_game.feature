Feature: Create game

  TTT is the core lib that underlies an interface, where the interface allows users to play the game.
  
  In order to allow users to play the game
  An interface must be able to create a game in various states.

  A board can be represented as a string of 9 digits, where a 0 indicates that neither player has moved
  into that position, a 1 indicates that player1 has moved there, and a 2 indicates that player2 has moved there.
  The digits correspond to the board in the following manner:
  
  abcdefghi
  
   a | b | c 
  ---|---|---
   d | e | f 
  ---|---|---
   g | h | i 
  
  So the game board "001002100" would look like this (let "x" represent player 1 and "o" represent player2):

     |   | x 
  ---|---|---
     |   | o 
  ---|---|---
   x |   |   


  Scenario: Create a new game
    When I create a new game
    Then the game board is "000000000"
    And it is player1s turn
  
  Scenario Outline: Create an existing game
    When I create a game with "<configuration>"
    Then the game board is "<configuration>"
    And it is player<player>s turn
    
    Scenarios: Player1s turn
      | configuration | player |
      | 000000000     | 1      |
      | 120000000     | 1      |
      | 120120000     | 1      |
      | 120120021     | 1      |
      | 000010002     | 1      |
      | 120221112     | 1      |
    
    Scenarios: Player2s turn
      | configuration | player |
      | 100000000     | 2      |
      | 012100000     | 2      |
      | 001112200     | 2      |
      | 100200100     | 2      |
      | 120221110     | 2      |
    