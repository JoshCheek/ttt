module TTT
  class Game
    
    DEFAULT_BOARD = '0'*9
    attr_writer :board
    
    def initialize(board=DEFAULT_BOARD)
      self.board = board
    end
    
    def turn
      board.scan('1').size - board.scan('2').size + 1
    end
    
    def mark(position)
      board[position-1] = turn.to_s
    end
    
    def board(style=nil)
      return @board unless style
      "  %s | %s | %s  \n----|---|----\n  %s | %s | %s  \n----|---|----\n  %s | %s | %s  " % @board.split('')
    end
  end
end