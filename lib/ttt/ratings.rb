module TTT
  
  # Not used actively in the program
  # Instead, it is used to precalculate the ratings below
  class Rating

    attr_accessor :game, :parent, :children

    def initialize(game_or_board='000000000', parent=nil)
      game_or_board = Game.new game_or_board unless game_or_board.is_a? Game
      self.game = game_or_board
      self.parent = parent
    end

    def to_s
      game.board :ttt
    end

    def children
      @children ||= begin
        children = {}
        game.available_moves.each do |move|
          children[move] = self.class.new game.pristine_mark(move), self
        end
        children
      end
    end

    def leaf?
      children.empty?
    end

    def rating_for(player_number)
      if leaf?
        return 0  if game.tie?
        return 1  if game.winner == player_number
        return -1
      else
        ratings = children.map { |_, child| child.rating_for player_number }
        crnt_player = game.turn
        if crnt_player == player_number
          return  1 if ratings.any? { |rating| rating ==  1 }   # if my turn, and I can move to a win, then I win
          return -1 if ratings.all? { |rating| rating == -1 }   # if my turn, and all moves are losses, then I lose
          ratings.reject! { |rating| rating == -1 }
          return ratings.inject(:+).to_f / ratings.size         # otherwise, rating is the average of non-losing moves (I will never make a losing move)
        else
          return -1 if ratings.any? { |rating| rating == -1 }   # if his turn, and he can win, then I lose
          return  1 if ratings.all? { |rating| rating ==  1 }   # if his turn, and all his moves lead to wins for me, then I win
          return ratings.inject(:+).to_f / ratings.size         # otherwise, rating is the average of possible move scores
        end
      end
    end

  end
  
end
