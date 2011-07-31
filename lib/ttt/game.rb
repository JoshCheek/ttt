module TTT
  class Game
    
    DEFAULT_BOARD = '0'*9
    attr_writer :board
    
    def initialize(board=DEFAULT_BOARD)
      self.board = board
    end
    
    def turn
      return if over?
      board.scan('1').size - board.scan('2').size + 1
    end
    
    def mark(position)
      board[position-1] = turn.to_s
    end
    
    def board(style=nil)
      return @board unless style
      "  %s | %s | %s  \n----|---|----\n  %s | %s | %s  \n----|---|----\n  %s | %s | %s  " % @board.gsub('0', ' ').split('')
    end
    
    def over?
      winner || board.each_char.all? { |char| char == '1' || char == '2' }
    end
    
    def status(player_number)
      return nil unless over?
      (winner == player_number) ? :wins  :
                         winner ? :loses :
                                  :ties
    end
    
    def winner
      [ [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6],
      ].each do |pos1, pos2, pos3|
        next unless board[pos1] == board[pos2]
        next unless board[pos1] == board[pos3]
        next unless board[pos1] =~ /^(1|2)$/
        return board[pos1].to_i
      end
      nil
    end
    
  end
end