require 'ttt/ratings'

module TTT
  class ComputerPlayer
        
    attr_accessor :game
    
    def initialize(game)
      self.game = game
    end
    
    def player_number
      game.turn
    end
    
    def take_turn
      game.mark best_move
    end
    
    def best_move
      return imperative_move if imperative_move?  # allow to customize certain situations
      move, rating, game = moves_by_rating.first  # otherwise go by rating
      move
    end
    
    def moves_by_rating
      return to_enum(:moves_by_rating) unless block_given?
      moves = []
      game.available_moves.each do |move|
        new_game = game.pristine_mark move
        moves << [ move, rate(new_game), new_game ]
      end
      moves.sort_by! { |move, rating, new_game| -rating } # highest rating first
      moves.each     { |move, rating, new_game| yield move, rating, new_game }
    end
    
    def rate(game)
      RATINGS[game.board][player_number]
    end
    
    # allows us to override ratings in cases where they make the robot look stupid
    def imperative_move
      # if we can win *this turn*, then take it because
      # it rates winning next turn the same as winning in 3 turns
      game.available_moves.each do |move|
        new_game = game.pristine_mark move
        return move if new_game.over? && new_game.winner == player_number
      end
      
      # if we can block the opponent from winning *this turn*, then take it, because
      # it rates losing this turn the same as losing in 3 turns
      if moves_by_rating.all? { |move, rating, game| rating == -1 }
        Game.winning_states do |position1, position2, position3|
          a, b, c = board[position1-1].to_i, board[position2-1].to_i, board[position3-1].to_i
          if a + b + c == opponent_number * 2
            return a.zero? ? position1 : b.zero? ? position2 : position3
          end
        end
      end
    end
    
    def imperative_move?
      !!imperative_move
    end
    
    def board
      game.board
    end
    
    def opponent_number
      player_number == 1 ? 2 : 1
    end
  end
end
