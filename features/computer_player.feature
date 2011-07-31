Feature: Computer player

  In order to hone my tic-tac-toe skills
  As a player
  I want an unbeatable computer opponent
  
  The following scenarios should cover a sampling of possible boards. As there are
  765 possible game possible congruence classes of boards, I won't attempt to cover
  them all, but will verify that the computer plays optimally in a number of common
  situations (two game boards are in a congruence class, such as the two below, 
  if one can be turned into the other by rotating or mirroring).
  
  For a list of all congruent states, there are some rake tasks which compute them
  and explore some of their properties.
  
  Example of congruent boards (rotate the left board 90 degrees to get the right board):
  
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
