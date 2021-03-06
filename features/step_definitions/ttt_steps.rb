When /^I create a new game$/ do
  @game = TTT::Game.new
end

Then /^the game board is "([^"]*)"$/ do |board|
  @game.board.should == board
end

Then /^it is (player(\d+)s|no one's) turn$/ do |turn, player_number|
  if player_number
    @game.turn.should == player_number.to_i
  else
    @game.turn.should be_nil
  end
end

When /^I ask what positions won$/ do
  @winning_positions = @game.winning_positions
end

Then /^it tells me \[(\d+), (\d+), (\d+)\]$/ do |p1, p2, p3|
  @winning_positions.sort.should == [p1, p2, p3].map(&:to_i).sort
end


When /^I create a game with "([^"]*)"$/ do |configuration|
  @game = TTT::Game.new configuration
end

When /^I mark position (\d+)$/ do |position|
  @game.mark position.to_i
end

Then /^board\(:ttt\) will be "([^"]*)"$/ do |board|
  @game.board(:ttt).should == board.gsub('\\n', "\n")
end

Then /^the game is (not )?over$/ do |not_over|
  if not_over
    @game.should_not be_over
  else
    @game.should be_over
  end
end

When /^I ask who is at position (\d+), it returns (\w+)$/ do |position, player|
  player = player.to_i
  player = nil if player.zero?
  @game[position.to_i].should == player
end

Then /^player(\d+) (wins|loses|ties)$/ do |player, status|
  @game.status(player.to_i).should == status.to_sym
end

Given /^a tie game$/ do
  @game = TTT::Game.new '121221112'
end

When /^a computer player as player (\d+)$/ do |current_turn|
  @game.turn.should == current_turn.to_i
end

Then /^the computer moves to one of the following: ((?:\d+ ?)+)$/ do |possible_boards|
  @computer = TTT::ComputerPlayer.new @game
  @computer.take_turn
  possible_boards.split.should include @game.board
end

Given /^I have a computer player$/ do
  @computer = TTT::ComputerPlayer.new @game
end

Then /^the computer will play for (\d+)$/ do |player_number|
  player_number = player_number.to_i
  @game.turn.should == player_number
  @computer.player_number.should == player_number
  @computer.take_turn
  @game.turn.should_not == player_number
  @computer.player_number.should_not == player_number.to_i
end

