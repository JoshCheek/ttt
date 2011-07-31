task :environment do  
  $:.unshift File.expand_path('../lib', __FILE__)
  require 'ttt'
end

desc 'A simple CLI to the lib'
task :simple_cli => :environment do
  game = TTT::Game.new
  until game.over?
    puts game.board(:ttt)
    game.mark $stdin.gets.to_i
  end
  puts "The game is over.", (game.tie? ? "No one wins" : "Player #{game.winner} wins.")
end

desc 'Show a 101020000 formatted board in tic-tac-toe format'
task :show => :environment do
  puts TTT::Game.new(ENV['board']).board(:ttt)
end

desc 'Open a pry console with the app loaded'
task :console do
  sh 'pry -I lib -r ttt'
end

desc 'Run Cucumber against the features'
task :cuke do
  sh 'cucumber'
end

desc 'run RSpec against the specification'
task :spec do
  sh 'rspec spec --colour'
end
