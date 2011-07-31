Feature: Computer player

  In order to hone my tic-tac-toe skills
  As a player
  I want an unbeatable computer opponent
  
  The following scenarios should cover every possible board by considering at least
  one board from every possible congruence class of boards. (ie if two game boards
  are congruent, such as the two below, which can be made the same by rotating or
  mirroring, then they are equivalent, and we will only consider one of them.) This
  is because there are 9! = 362880 possible game boards.
  
  Example of congruent boards:
  
   1 |   |        |   | 1 
  ---|---|---  ---|---|---
     |   |        |   |   
  ---|---|---  ---|---|---
     |   |        |   |   
  

  Scenario Outline: Computer's moves
    When I create a game with "<configuration>"
    And a computer player as player <player>
    Then it is player<player>s turn
    And the computer moves to one of the following: <possible boards>
    
    Scenarios:
      | configuration | player | possible boards                          |
      | 000000000     | 1      | 100000000 001000000 000000100 000000001  |
      | 120000000     | 1      | 120000100 120010000                      |
      | 122000100     | 1      | 122100100                                |
      | 120020100     | 1      | 120020100                                |
