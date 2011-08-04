$: << File.expand_path('../../../../..', __FILE__)
require 'ttt'
require 'ttt/computer_player'

module Square
  
  def casted
    Square.register self
  end
  
  def position
    id[/\d/].to_i
  end
    
  def mouse_clicked(event)
    Square.clicked(position)
  end
  
  def mark(player)
    if player == 1
      self.text = 'X'
      self.style.text_color = :red
    else
      self.text = 'O'
      self.style.text_color = :blue
    end
  end
  
  def unmark
    self.text = String.new
  end
  
  def marked?
    !text.empty?
  end
  
  def game_over
    self.style.text_color = :gray
  end
  
  def mark_winner
    self.style.text_color = :green
  end
end
    


class << Square
  
  def reset
    @game = @current_turn = nil
    squares.each_value { |square| square.unmark }
  end
  
  def game
    @game ||= TTT::Game.new
  end
  
  def current_turn
    @current_turn ||= 1
  end

  def advance_turn
    @current_turn = (@current_turn % 2) + 1
  end
  
  def squares
    @squares ||= {}
  end
  
  def register(square)
    squares[square.position] = square
  end
  
  def clicked(position)
    return unless can_click? position
    mark position
    computer_takes_turn
  end
  
  def computer_takes_turn
    position = TTT::ComputerPlayer.new(game).best_move
    return unless can_click? position
    mark position
  end
  
  def can_click?(position)
    squares[position] && !squares[position].marked? && !game.over?
  end
    
  def mark(position)
    game.mark position
    squares[position].mark current_turn
    advance_turn
    check_for_end_of_game
  end
  
  def check_for_end_of_game
    if game.over?
      squares.each_value { |square| square.game_over }
      game.winning_positions.each { |position| squares[position].mark_winner }
    end
  end
end

