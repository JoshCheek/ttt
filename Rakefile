require 'bundler/bouncer'

# load the lib
task :environment do  
  $:.unshift File.expand_path('../lib', __FILE__)
  require 'ttt'
  require 'ttt/computer_player'
end



# commonly invoked interfaces
desc 'Open a pry console with the app loaded'
task :console do
  sh 'pry -I lib -r ttt -r ttt/computer_player'
end

desc 'Run Cucumber against the features'
task :cuke do
  sh 'cucumber'
end

desc 'run RSpec against the specification'
task :spec do
  sh 'rspec spec --colour'
end
task :rspec => :spec # synonym



# handle gem construction
require "rubygems/package_task"
spec = Gem::Specification.new do |s|
  # informatoin
  s.name              = "ttt"
  s.version           = "1.0.0"
  s.summary           = "Tic Tac Toe lib + binary"
  s.description       = "TTT is a Tic Tac Toe lib, as well as a CLI and GUI to play it."
  s.author            = "Joshua J Cheek"
  s.email             = "josh.cheek@gmail.com"
  s.homepage          = "https://github.com/JoshCheek/ttt"

  # additional files
  s.files             = %w(Gemfile Gemfile.lock MIT-License.md Rakefile Readme.md) + Dir.glob("{bin,spec,features,lib}/**/*")
  s.executables       = FileList["bin/**"].map { |f| File.basename(f) }
  s.require_paths     = ["lib"]

  # dependencies
  s.add_development_dependency "bundler-bouncer" , "~> 0.1.2"
  s.add_development_dependency "rspec"           , "~> 2.6.0"
  s.add_development_dependency "cucumber"        , "~> 1.0.2"
  s.add_development_dependency "pry"             , "~> 0.9.3"
  s.add_development_dependency "rake"            , "~> 0.9.2"
end

task :package => :gemspec
Gem::PackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Build the gemspec file #{spec.name}.gemspec"
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end





# Various command line utilities constructed while building the gem
namespace :script do
    
  # cache the boards b/c computing them takes a long time
  # these were generated with the compute_congruent task below
  def self.all_boards_cached
    %w[
      000000000 100000000 120000000 121000000 121200000 121210000 121212000 121212100 121212010 121212210
      121212211 121210200 121211200 121211220 121211221 121211202 121211212 121210210 121210212 121210201
      121210020 121211020 121211022 121210021 121210002 121211002 121210102 121210012 121201000 121221000
      121221100 121221120 121221102 121221112 121221010 121221210 121221211 121221012 121221001 121201200
      121201210 121201212 121201201 121201020 121201120 121201122 121201021 121201002 121201102 121201012
      121200100 121220100 121220101 121222101 121202100 121202101 121202121 121212121 121200102 121200010
      121220010 121220011 121220211 121202010 121200210 121200211 121200012 121200001 121220001 121200201
      121200021 121020000 121120000 121120200 121121200 121121220 121121202 121121212 121120210 121120212
      121120201 121120221 121120020 121120002 121120102 121120012 121020100 121020120 121020102 121020112
      121020010 121020210 121000200 121100200 121100220 121110220 121110222 121101220 121101222 121100221
      121100202 121110202 121101202 121100212 121010200 121010220 121011220 121010221 121010202 121010212
      121001200 121001220 121001221 121000210 121000212 121000201 121000221 121000020 121100020 121010020
      121000120 120100000 122100000 122110000 122112000 122112100 122112010 122112210 122112211 122112012
      122112001 122110200 122111200 122110210 122110212 122111212 122110201 122110020 122111020 122110120
      122110021 122110002 122111002 122110102 122110012 122101000 122121000 122121100 122121010 122121210
      122121012 122121112 122121001 122121201 122121021 122101200 122101210 122101212 122101201 122101221
      122111221 122101020 122101120 122101021 122101002 122101102 122101012 122100100 122100010 122120010
      122120110 122120011 122122011 122122111 122120211 122102010 122102110 122102011 122102211 122100210
      122100211 122100012 122100112 122100001 122120001 122120101 122102001 122102101 122100201 122100021
      120120000 120121000 120121200 120121210 120121212 120121201 120121020 120121002 120121102 120121012
      120120100 120120010 120122010 120122110 120122011 120122211 120120210 120120211 120120012 120120112
      120120001 120122001 120122101 120120201 120120021 120102000 120112000 120112200 120112210 120112212
      120112201 120112020 120112120 120112021 120112002 120112102 120112012 120102100 120102010 120102210
      120102211 120102012 120102112 120102001 120102201 120102021 120100200 120110200 120110220 120111220
      120110221 120110202 120111202 120110212 120101200 120101220 120101202 120101212 120100210 120100212
      120100201 120100221 120100020 120110020 120110022 120111022 120101020 120101022 120100120 120100021
      120100002 120110002 120101002 120100102 120100012 120010000 122010000 122011000 122211000 122211010
      122211210 122211211 122211012 122211001 122011200 122011210 122011212 122011201 122011020 122011120
      122011122 122111122 122011002 122011102 122011012 122010100 122012100 122012110 122012112 122012101
      122010120 122010102 122010112 122010010 122210010 122210011 122012010 122010210 122010211 122010012
      122010001 120210000 120211000 120211020 120211002 120211012 120210001 120012000 120012100 120012120
      120012102 120012112 120012010 120012210 120012012 120012001 120010200 120011200 120011220 120011202
      120011212 120010210 120010212 120010201 120010020 120011020 120011022 120010120 120010021 120010002
      120011002 120010102 120010012 120001000 122001000 122001100 122021100 122021110 122021112 122021101
      122001120 122001102 122001112 122001010 122201010 122201011 122221011 122201211 122021010 122021011
      122021211 122001210 122001211 122001012 122001001 122201001 122021001 122001201 120201000 120201010
      120221010 120221011 120201012 120201001 120221001 120201201 120021000 120021100 120021120 120021102
      120021112 120021010 120021210 120021211 120021012 120021001 120021201 120001200 120001210 120001212
      120001201 120001020 120001120 120001002 120001102 120001012 120000100 122000100 122000110 122020110
      122020111 122002110 122000112 122000101 122020101 122002101 120020100 120020110 120022110 120020112
      120020101 120022101 120002100 120002110 120002112 120002101 120000120 120000102 120000112 120000010
      122000010 122000011 122020011 122000211 120020010 120020011 120020211 120002010 120000210 120000211
      120000012 120000001 122000001 120200001 120020001 120002001 120000201 120000021 102000000 112000000
      112020000 112120000 112122000 112122100 112122010 112122210 112122012 112120200 112120020 112121020
      112121022 112120002 112121002 112121202 112120102 112120012 112021000 112021200 112021020 112021002
      112021102 112021012 112021212 112020100 112022100 112022110 112022112 112020102 112020112 112020010
      112022010 112020210 112020012 112020001 112020201 112002000 112102000 112102200 112112200 112112220
      112112202 112102210 112102212 112102020 112112020 112112022 112102002 112012000 112012200 112012210
      112012020 112012002 112002100 112002102 112002010 112002210 112002012 112000200 112100200 112100202
      112110202 112101202 112010200 112010220 112011220 112011222 112010202 112011202 112010212 112001200
      112001220 112001202 112001212 112000210 112000212 112000201 112000020 112100020 112100022 112110022
      112101022 112010020 112010022 112011022 112001020 112001022 112000002 112100002 112010002 112001002
      112000102 112000012 102100000 102120000 102121000 102121020 102121002 102121102 102121012 102120100
      102120010 102122010 102122110 102120012 102120001 102102000 102112000 102112020 102112002 102102100
      102102010 102102012 102100020 102110020 102110022 102111022 102101020 102101022 102100002 102110002
      102101002 102100102 102100012 102010000 102012000 102012100 102012102 102012010 102012210 102012012
      102010200 102011200 102011202 102011212 102010201 102010020 102011020 102011022 102010002 102011002
      102010102 102010012 102001000 102021000 102021100 102021102 102021010 102021210 102021012 102001200
      102001210 102001212 102001020 102001002 102001102 102001012 102000100 102020100 102020110 102022110
      102020101 102002100 102002110 102000102 102000010 102020010 102002010 102000012 102000001 102020001
      102000201 100020000 110020000 110022000 110122000 110122020 110122002 110122012 110022100 110022010
      110022012 110020020 111020020 110021020 110021022 110020002 110120002 110021002 110020012 101020000
      101020020 100021000 100021020 100021002 100021012 100020001 100002000 110002000 110002020 110102020
      110102022 110112022 110012020 110012022 110002002 110102002 110012002 110002012 100102000 100102002
      100112002 100102012 100012000 100012020 100012002 100012012 100002100 100002010 100002012 100000002
      110000002 100010002 100001002 010000000 210000000 210100000 212100000 212110000 212112000 212112010
      212110200 212111200 212110020 212111020 212110002 212110012 212101000 212121000 212121010 212121210
      212101200 212101210 212101212 212111212 212101020 212100010 212120010 212102010 212100012 210120000
      210121000 210121020 210121002 210102000 210112000 210112020 210112002 210112012 210102010 210102012
      210100002 210110002 210101002 210010000 212010000 212010010 210210000 210211000 210211200 210211020
      210211002 210210010 210012000 210012010 210010200 210011200 210011220 210011202 210010210 210010020
      210011020 210010002 210011002 210010012 210001000 210201000 210201010 210221010 210201210 210021000
      210021010 210021210 210001200 210001210 210001020 210001002 210000010 212000010 210200010 210020010
      210002010 210000210 210000012 010200000 010210000 010212000 010212010 010210200 010211200 010211220
      010210020 010211020 010210002 010201000 010221000 010221010 010201200 010201020 010200010 010220010
      010202010 010020000 010120000 010120002 010020010 010000200 010010200 010010220 010010202 010001200
      010000020 010010020 000010000 200010000 020010000
    ]
  end
  

  desc 'Lists the congruent boards (from cache)'
  task :congruent => :environment do
    all_boards_cached.each { |board| puts board }
  end
  
  
  desc 'Computes all congruent boards (takes a while)'
  task :compute_congruent => :environment do
    def self.all_boards(game=TTT::Game.new, boards=[])
      return if boards.any? { |prev_board| TTT::Game.congruent? prev_board, game.board }
      boards << game.board 
      game.available_moves.each do |position|
        next_game = game.pristine_mark position
        all_boards next_game, boards
      end
      boards
    end
    all_boards.each { |board| puts board }
  end
    
  
  desc 'Show a 9-digit formatted board in tic-tac-toe format'
  task :show => :environment do
    raise 'pass argument board=000000000' unless ENV['board']
    puts TTT::Game.new(ENV['board']).board(:ttt)
  end
  
  
  desc 'An ultra-simple CLI to play the game'
  task :play => :environment do
    game = TTT::Game.new ENV['board'] || '000000000'
    comp = TTT::ComputerPlayer.new(game)
    until game.over?
      comp.take_turn
      puts game.board(:ttt)
      break if game.over?
      game.mark $stdin.gets.to_i
    end
    puts "The game is over.", (game.tie? ? "No one wins" : "Player #{game.winner} wins.")
  end
  
  
  desc 'Computes some stats that were listed on Wikipedia to ensure numbers are correct'
  task :stats => :environment do
    boards = all_boards_cached.select { |board| TTT::Game.new(board).over? }                                    # according to http://en.wikipedia.org/wiki/Tic-tac-toe
    puts "#{all_boards_cached.size} unique boards (congruent classes)"                                          # no expectation, size is 765
    puts "#{boards.size} unique end states"                                                                     # expect 138 (true)
    puts "#{boards.select { |board| TTT::Game.new(board).winner == 1 }.size} unique ways for player 1 to win"   # expect 91  (true)
    puts "#{boards.select { |board| TTT::Game.new(board).winner == 2 }.size} unique ways for player 2 to win"   # expect 44  (true)
    puts "#{boards.select { |board| TTT::Game.new(board).tie?        }.size} unique ways to tie"                # expect 3   (true)
  end
  
  
  desc 'Computes ratings for each board for each player'
  task :ratings => :environment do
    require 'pp'
    boards = {}
    all_boards_cached.each do |board|
      tree = TTT::Rating.new board
      boards[board] = {
        1 => tree.rating_for(1),
        2 => tree.rating_for(2),
      }
    end
    pp boards
  end
  
  
  desc 'CLI to explore the game tree'
  task :explore => :environment do
    module TTT
      class Game
        # overwrite how board(:ttt) displays so that we can get something condensed enough to display
        # many on the same line (colour allows us to distinguish the boardspace without using any
        # more characters than are required to display the markings themselves)
        def board(format=nil)
          return @board unless format
          @board.gsub(/[^12]/, ' ').scan(/.../).map { |line| "\e[44m#{line}\e[0m" }.join("\n")
        end
      end
    end
        
    module TTT
      class ExploreTree
        
        attr_accessor :tree
        
        def initialize
          self.tree = TTT::Rating.new
        end
        
        def explore!
          loop do
            display_adjacent commands, tree
            print '> '
            handle_command $stdin.gets
          end
        end
        
        def display_adjacent(*displayables)
          line_sets = []
          queues = displayables.map { |displayable| displayable.to_s.split "\n" }
          until queues.all?(&:empty?)
            line_sets << [] # add a set for current line
            queues.each { |queue| line_sets.last << queue.shift unless queue.empty? }
          end
          puts line_sets.map { |set| set.join ' ' }.join("\n")
        end
        
        def commands
          "------------------\n"\
          "|    COMMANDS    |\n"\
          "|----------------|\n"\
          "| move position  |\n"\
          "| show [depth]   |\n"\
          "| back           |\n"\
          "| rate player    |\n"\
          "| exit           |\n"\
          "------------------\n"
        end
        
        def handle_command(command)
          args = command.split
          command = args.shift
          send command, *args if command
        rescue => e
          puts "Invalid command (#{e.message})"
        end
                
        def move(n)
          self.tree = tree.children[n.to_i] || raise("No child at #{n.inspect}")
        end
        
        def colour_if_complete(tree)
          return tree.to_s unless tree.game.over?
          tree.to_s.split("\n").map { |line| "\e[33;1m#{line}\e[0m" }.join("\n")
        end
        
        def show(depth=1)
          crnt = [tree]
          (depth.to_i-1).times do
            crnt = crnt.map { |node| node.children.values }.flatten # descend to next depth
          end
          display_adjacent(*crnt.map(&method(:colour_if_complete)))
        end
        
        def back
          self.tree = tree.parent || raise("Can't go back, this is where we started")
        end
        
        def rate(player_number)
          puts tree.rating_for(player_number.to_i)
        end
        
        def exit
          Kernel.exit
        end
      end
    end
    
    TTT::ExploreTree.new.explore!
  end
  
end


