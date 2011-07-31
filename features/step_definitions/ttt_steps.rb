When /^I create a new game$/ do
  @game = TTT::Game.new
end

Then /^the game board is "([^"]*)"$/ do |board|
  @game.board.should == board
end

Then /^it is player(\d+)s turn$/ do |player_number|
  @game.turn.should == player_number.to_i
end

When /^I create a game with "([^"]*)"$/ do |configuration|
  @game = TTT::Game.new configuration
end

When /^I mark position (\d+)$/ do |position|
  @game.mark position.to_i
end
