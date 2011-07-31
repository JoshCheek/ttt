module TTT
  class Game
    
    DEFAULT_BOARD = '0'*9
    attr_accessor :board
    
    def initialize(board=DEFAULT_BOARD)
      self.board = board
    end
    
    def turn
      board.scan('1').size - board.scan('2').size + 1
    end
    
    def mark(position)
      board[position-1] = turn.to_s
    end
  end
end