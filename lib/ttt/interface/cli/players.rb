require 'ttt/computer_player'

module TTT
  module Interface
    class CLI
      
      class Player
        attr_accessor :game, :cli
        def initialize(game, cli)
          self.game = game
        end
      end
      
      
      class ComputerPlayer < Player
        attr_accessor :computer
        def initialize(*args)
          super
          self.computer = TTT::ComputerPlayer.new game
        end
        def take_turn
          computer.take_turn
        end
      end
      
      
      class HumanPlayer <Player
        def take_turn
          raise 'not implemented'
        end
      end

      
    end
  end
end
