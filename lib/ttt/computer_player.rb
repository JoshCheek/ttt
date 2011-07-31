module TTT
  class ComputerPlayer
    
    attr_accessor :game
    
    def initialize(game)
      self.game = game
    end
    
    def take_turn
      game.mark best_move
    end
    
    def best_move
      possible_moves.max_by { |move, rating| rating }.first
    end
    
  end
end
