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
    
    Scenarios: Computer always takes a win when it is available
      | configuration | player | possible boards     | description                                            |
      | 110200200     | 1      | 111200200           | can win across top                                     |
      | 220000110     | 1      | 220000111           | can win across bottom and opponent can win across top  |
      | 201201000     | 1      | 201201001           | can win vertically on RHS opponent can win too         |
      | 120120000     | 1      | 120120100           | can win vertically on RHS opponent can win too         |
      | 102210000     | 1      | 102210001           | can win diagonally                                     |
      | 120112020     | 1      | 120112120 120112021 | can win in two positions                               |
      | 120021001     | 2      | 120021021           | takes win when 2nd player and 1st can also win         |
    
    Scenarios: Computer blocks opponent's win
      | configuration | player | possible boards     | description                                            |
      | 120100000     | 2      | 120100200           | blocks lhs                                             |
      | 122110000     | 2      | 122110200 122110002 | blocks either of opponent's possible wins              |
      | 211200000     | 1      | 211200100           | blocks when first player                               |

    Scenarios: Finds best moves for likely game states
      | configuration | player | possible boards                          | description                                            |
      | 000000000     | 1      | 100000000 001000000 000000100 000000001  | makes best 1st move                                    |
      | 120000000     | 1      | 120000100 120010000 120100000            | makes move that will guarantee win in future           |
      | 100000002     | 1      | 101000002 100000102                      | makes move that will guarantee win in future           |
      | 100000020     | 1      | 100000120 101000020 100010020            | makes move that will guarantee win in future           |
      | 102000000     | 1      | 102100000 102000100 102000001            | makes move that will guarantee win in future           |
      | 102100200     | 1      | 102110200                                | makes move that will guarantee win next turn           |
      | 100020000     | 1      | 110020000 100120000                      | makes move with highest probability of win in future   |
      | 100000000     | 2      | 100020000                                | makes move with lowest probability of losing in future |
  
  Scenario: Plays correctly for current player
    Given I create a game with "000000000"
    And I have a computer player
    Then the computer will play for 1
    Then the computer will play for 2
