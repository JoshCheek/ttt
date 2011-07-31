task :environment do  
  $:.unshift File.expand_path('../lib', __FILE__)
  require 'ttt'
end

task :simple_cli => :environment do
  game = TTT::Game.new
  until game.over?
    puts game.board(:ttt)
    game.mark $stdin.gets.to_i
  end
  puts "The game is over.", (game.tie? ? "No one wins" : "Player #{game.winner} wins.")
end

task :show => :environment do
  puts TTT::Game.new(ENV['board']).board(:ttt)
end

task :console do
  sh 'pry -I lib -r ttt'
end

task :cuke do
  sh 'cucumber'
end

task :spec do
  sh 'rspec spec --colour'
end
