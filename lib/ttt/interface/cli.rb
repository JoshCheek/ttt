module TTT
  module Interface
    class CLI
      Interface.register 'cli', self
      
      def play
        puts "playing"
      end
    end
  end
end
