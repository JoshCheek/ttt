require 'ttt/interface/cli/players'
require 'ttt/interface/cli/views'

module TTT
  module Interface
    class CLI
      Interface.register 'cli', self
      
      X = 'X'
      O = 'O'
      
      attr_accessor :game, :filein, :fileout, :fileerr, :player1, :player2, :turn
      
      def initialize(options={})
        self.filein  = options.fetch :filein,  $stdin
        self.fileout = options.fetch :fileout, $stdout
        self.fileerr = options.fetch :fileerr, $stderr
        self.turn    = 0
      end
      
      def play
        fileout.puts "Welcome to Tic Tac Toe"
        fileout.flush
        create_game
        create_player1
        create_player2
        until game.over?
          take_current_turn
          display_board
        end
        display_results
      end
      
      def display_results
        display_board
        if game.tie?
          puts "The game ended in a tie."
        else
          puts "Player #{game.winner} won the game."
        end
        puts "Play again soon :)"
      end
      
      def take_current_turn
        current_player.take_turn
        self.turn += 1
      end
      
      def current_player
        turn.even? ? player1 : player2
      end
      
      def create_game
        self.game = Game.new
      end
      
      def create_player1
        self.player1 = create_player X, 'first'
      end
      
      def create_player2
        self.player2 = create_player O, 'second'
      end
      
      def create_player(letter, position)
        type = prompt "#{letter} will go #{position}, would you like #{letter} to be a human or a computer? (h/c) ", :validate => /^[hc]$/i
        if type =~ /c/i
          ComputerPlayer.new game, self, letter
        else
          HumanPlayer.new game, self, letter
        end
      end
      
      def prompt(message, validation={})
        validation[:validate] ||= //
        fileout.print message
        input = filein.gets
        until input =~ validation[:validate]
          fileout.puts "Invalid, input."
          fileout.print message
          input = filein.gets
        end
        input
      end
      
      def display_board
        Views.new(self).display_board
      end
      
      def board
        game.board
      end
    end
  end
end
