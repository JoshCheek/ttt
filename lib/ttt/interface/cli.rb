module TTT
  module Interface
    class CLI
      Interface.register 'cli', self
      
      def play
        puts "Welcome to Tic Tac Toe"
      end
    end
  end
end
