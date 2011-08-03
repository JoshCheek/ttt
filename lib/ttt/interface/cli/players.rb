require 'ttt/computer_player'
require 'forwardable'

module TTT
  module Interface
    class CLI
        
            
      class Player
        attr_accessor :game, :cli
        
        extend Forwardable
        def_delegators :cli, :fileout, :filein, :fileerr, :prompt
        
        def initialize(game, cli)
          self.game = game
          self.cli = cli
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
          fileout.puts "The nine squares consecutively map to a number. "\
            "Topleft starts at 1, topright continues with 3, and bottomright ends with 9."
          move = prompt "Where would you like to move? (#{list_available_moves}) ", :validate => available_moves_regex
          game.mark move.to_i
        end
        
        def list_available_moves
          game.available_moves.join(', ')
        end
        
        def available_moves_regex
          moves = game.available_moves
          /^[#{moves.join}]$/
        end
      end

      
    end
  end
end
