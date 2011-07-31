task :simple_cli do
  $:.unshift File.expand_path('../lib', __FILE__)
  require 'ttt'
  game = TTT::Game.new
  until game.over?
    puts game.board(:ttt)
    game.mark $stdin.gets.to_i
  end
  puts "The game is over.", (game.tie? ? "No one wins" : "Player #{game.winner} wins.")
end

task :cuke do
  sh 'cucumber'
end

task :spec do
  sh 'rspec spec --colour'
end
