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
          fileout.print row(0) << horizontal_separator <<
                        row(1) << horizontal_separator <<
                        row(2) << "\n\n"
        end
        
        def row(n)
          n *= 3
          line(n) << line(n+1) << line(n+2)
        end
        
        def line(n)
          offset, col = (n/3)*3, (n%3)
          square(offset+1, col) << vertical_separator <<
          square(offset+2, col) << vertical_separator <<
          square(offset+3, col) << "\n"
        end
        
        def horizontal_separator
          "-----|-----|-----\n"
        end
        
        def vertical_separator
          "|"
        end
        
        def square(num, line)
          if line == 0
            "     "
          elsif line == 1
            "  %s  " % char_for(num)
          elsif
            line == 2
            "     "
          end
        end
        
        def char_for(position)
          case game[position]
          when nil
            ' '
          when 1
            player1.marker
          when 2
            player2.marker
          end
        end
        
      end      
    end
  end
end
