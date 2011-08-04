require 'ttt/interface/cli/players'
require 'ttt/interface/cli/views'

module TTT
  module Interface
    class Limelight
      Interface.register 'limelight', self
      
      def initialize(*args)
      end
      
      def play
        system "limelight", "open", "#{File.dirname(__FILE__)}/limelight"
      end
      
    end
  end
end
