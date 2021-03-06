module TTT
  class Game
    
    DEFAULT_BOARD = '0'*9
    attr_writer :board
    
    def initialize(board=DEFAULT_BOARD)
      self.board = board.dup
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
      winner || board.split(//).all? { |char| char == '1' || char == '2' }
    end
    
    def status(player_number)
      return nil unless over?
      (winner == player_number) ? :wins  :
                         winner ? :loses :
                                  :ties
    end
    
    def tie?
      over? && !winner
    end
    
    def winner
      return if winning_positions.empty?
      self[winning_positions.first]
    end
    
    def available_moves
      return [] if over?
      to_return = []
      board.split(//).each_with_index do |char, index| 
        to_return << index.next if char != '1' && char != '2'
      end
      to_return
    end
    
    def pristine_mark(position)
      marked = self.class.new board.dup
      marked.mark position
      marked
    end
    
    def winning_states(&block)
      self.class.winning_states(&block)
    end
    
    def winning_positions
      winning_states do |pos1, pos2, pos3|
        next unless board[pos1, 1] == board[pos2, 1]
        next unless board[pos1, 1] == board[pos3, 1]
        next unless board[pos1, 1] =~ /^(1|2)$/
        return [pos1+1, pos2+1, pos3+1]
      end
      []
    end
    
    def [](position)
      player = board[position-1, 1].to_i
      return player if player == 1 || player == 2
    end
    
  end
end



module TTT
  class << Game
    def congruent?(board1, board2)
      each_congruent(board2).any? { |congruent| board1 == congruent }
    end
    
    def each_congruent(board)
      return to_enum(:each_congruent, board) unless block_given?
      each_rotation(board)               { |congruent| yield congruent }
      each_rotation(reflect_board board) { |congruent| yield congruent }
    end
    
    def reflect_board(board)
      board = board.dup
      board[0..2], board[6..8] = board[6..8], board[0..2]
      board
    end
    
    def each_rotation(board)
      return to_enum(:each_rotation, board) unless block_given?
      board = board.dup
      4.times do
        yield board.dup
        board = rotate_board(board)
      end
    end
    
    def rotate_board(board)
      board = board.dup
      board[0], board[1], board[2], board[3], board[5], board[6], board[7], board[8] =
      board[6], board[3], board[0], board[7], board[1], board[8], board[5], board[2]
      board
    end
    
    def winning_states
      yield 0, 1, 2
      yield 3, 4, 5
      yield 6, 7, 8
      yield 0, 3, 6
      yield 1, 4, 7
      yield 2, 5, 8
      yield 0, 4, 8
      yield 2, 4, 6
    end
  end
end
