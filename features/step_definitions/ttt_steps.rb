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
  @game.over?.should == !not_over
end

Then /^player(\d+) (wins|loses|ties)$/ do |player, status|
  @game.status(player.to_i).should == status.to_sym
end
