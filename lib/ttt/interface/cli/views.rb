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
          send "line#{line}_for", num
        end
        
        def line0_for(square)
          if forward_diagonal_winner?(square)
            "\\    "
          elsif backward_diagonal_winner?(square)
            "    /"
          elsif vertical_winner? square
            "  |  "
          else
            "     "
          end
        end
        
        def line1_for(square)
          if horizontal_winner? square
            "--%s--"
          else
            "  %s  "
          end % char_for(square)
        end
        
        def line2_for(square)
          if forward_diagonal_winner?(square)
            "    \\"
          elsif backward_diagonal_winner?(square)
            "/    "
          elsif vertical_winner? square
            "  |  "
          else
            "     "
          end
        end
        
        def winner?(square)
          game.over? && !game.tie? && game.winning_positions.include?(square)
        end
        
        def forward_diagonal_winner?(square)
          return false unless winner? square
          [[1, 5], [5, 9], [9, 5]].any? do |s1, s2|
            square == s1 && winner?(s2)
          end
        end
        
        def backward_diagonal_winner?(square)
          return false unless winner? square
          [[3, 5], [5, 7], [7, 5]].any? do |s1, s2|
            square == s1 && winner?(s2)
          end
        end
        
        def vertical_winner?(square)
          return false unless winner? square
          winner? (square + 2) % 9 + 1
        end
        
        def horizontal_winner?(square)
          return false unless winner? square
          winner?(square+1) || winner?(square-1)
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
