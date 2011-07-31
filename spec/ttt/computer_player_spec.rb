require 'spec_helper'
require 'ttt/computer_player'

module TTT
  describe ComputerPlayer do
    
    def self.move_for(configuration, player, possible_boards, description)
      it "takes moves correctly when #{description}" do
        game = Game.new configuration
        computer = ComputerPlayer.new game
        computer.take_turn
        possible_boards.should include game.board
      end
    end
    
    def self.moves_for(scenarios)
      scenarios.each { |scenario| move_for *scenario }
    end
    
    
    context 'always takes a win when it is available' do
      moves_for [ 
        ['110200200', 1, ['111200200']              , 'can win across top'                                     ],
        ['220000110', 1, ['220000111']              , 'can win across bottom and opponent can win across top'  ],
        ['201201000', 1, ['201201001']              , 'can win vertically on RHS opponent can win too'         ],
        ['120120000', 1, ['120120100']              , 'can win vertically on RHS opponent can win too'         ],
        ['102210000', 1, ['102210001']              , 'can win diagonally'                                     ],
        ['120112020', 1, ['120112120', '120112021'] , 'can win in two positions'                               ],
        ['120021001', 2, ['120021021']              , '2nd player and 1st can also win'                        ],
      ]
    end
    
    context "Computer blocks opponent's win" do
      moves_for [ 
        ['120100000', 2, ['120100200']              , 'blocks lhs'                                ],
        ['122110000', 2, ['122110200', '122110002'] , "blocks either of opponent's possible wins" ],
        ['211200000', 1, ['211200100']              , 'blocks when first player'                  ],
      ]
    end

    context 'Finds best moves for likely game states' do
      moves_for [
        ['000000000', 1, ['100000000', '001000000', '000000100', '000000001'] , 'makes best 1st move'                                    ],
        ['120000000', 1, ['120000100', '120010000', '120100000']              , 'makes move that will guarantee win in future'           ],
        ['100000002', 1, ['101000002', '100000102']                           , 'makes move that will guarantee win in future'           ],
        ['100000020', 1, ['100000120', '101000020']                           , 'makes move that will guarantee win in future'           ],
        ['102000000', 1, ['102100000', '102000100', '102000001']              , 'makes move that will guarantee win in future'           ],
        ['102100200', 1, ['102110200']                                        , 'makes move that will guarantee win next turn'           ],
        ['100020000', 1, ['110020000', '100120000']                           , 'makes move with highest probability of win in future'   ],
        ['100000000', 2, ['100020000']                                        , 'makes move with lowest probability of losing in future' ],
      ]
    end
  end
end
