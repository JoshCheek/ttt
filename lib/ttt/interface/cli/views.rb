require 'ttt/interface/cli/players'
require 'ttt/interface/cli/views'

module TTT
  module Interface
    class CLI
      class Views
        
        attr_accessor :cli
      
        def initialize(cli)
          self.cli = cli
        end
      
        def method_missing(meth, *args, &block)
          super unless cli.respond_to? meth
          cli.send meth, *args, &block
        end
      
        def display_board
          fileout.puts game.board(:ttt)
          fileout.puts
        end
        
      end      
    end
  end
end
