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

  
  # Calculated with the above code in the rake task script:ratings
  RATINGS = {
    "000000000"=>{1=>0.9678112139917696, 2=>0.7774838330393885},
    "100000000"=>{1=>0.9884052579365079, 2=>0.8714285714285716},
    "120000000"=>{1=>1, 2=>-1},
    "121000000"=>{1=>0.9027777777777777, 2=>0.8666666666666668},
    "121200000"=>{1=>1, 2=>-1},
    "121210000"=>{1=>1, 2=>-1},
    "121212000"=>{1=>1, 2=>-1},
    "121212100"=>{1=>1, 2=>-1},
    "121212010"=>{1=>1, 2=>-1},
    "121212210"=>{1=>1, 2=>-1},
    "121212211"=>{1=>1, 2=>-1},
    "121210200"=>{1=>1, 2=>-1},
    "121211200"=>{1=>0.5, 2=>0.0},
    "121211220"=>{1=>1, 2=>-1},
    "121211221"=>{1=>1, 2=>-1},
    "121211202"=>{1=>0.0, 2=>0.0},
    "121211212"=>{1=>0, 2=>0},
    "121210210"=>{1=>0.5, 2=>0.0},
    "121210212"=>{1=>0.0, 2=>0.0},
    "121210201"=>{1=>1, 2=>-1},
    "121210020"=>{1=>1, 2=>-1},
    "121211020"=>{1=>1, 2=>-1},
    "121211022"=>{1=>1, 2=>-1},
    "121210021"=>{1=>1, 2=>-1},
    "121210002"=>{1=>1, 2=>-1},
    "121211002"=>{1=>0.5, 2=>0.0},
    "121210102"=>{1=>1, 2=>-1},
    "121210012"=>{1=>0.5, 2=>0.0},
    "121201000"=>{1=>0.8333333333333334, 2=>0.0},
    "121221000"=>{1=>1, 2=>-1},
    "121221100"=>{1=>-1, 2=>1},
    "121221120"=>{1=>-1, 2=>1},
    "121221102"=>{1=>0.0, 2=>0.0},
    "121221112"=>{1=>0, 2=>0},
    "121221010"=>{1=>0.5, 2=>0.0},
    "121221210"=>{1=>1, 2=>-1},
    "121221211"=>{1=>1, 2=>-1},
    "121221012"=>{1=>0.0, 2=>0.0},
    "121221001"=>{1=>1, 2=>-1},
    "121201200"=>{1=>1, 2=>-1},
    "121201210"=>{1=>0.5, 2=>0.0},
    "121201212"=>{1=>0.0, 2=>0.0},
    "121201201"=>{1=>1, 2=>-1},
    "121201020"=>{1=>1, 2=>-1},
    "121201120"=>{1=>-1, 2=>1},
    "121201122"=>{1=>1, 2=>-1},
    "121201021"=>{1=>1, 2=>-1},
    "121201002"=>{1=>0.3333333333333333, 2=>0.0},
    "121201102"=>{1=>0.5, 2=>0.0},
    "121201012"=>{1=>0.0, 2=>0.0},
    "121200100"=>{1=>-1, 2=>1},
    "121220100"=>{1=>-1, 2=>1},
    "121220101"=>{1=>-1, 2=>1},
    "121222101"=>{1=>-1, 2=>1},
    "121202100"=>{1=>1, 2=>-1},
    "121202101"=>{1=>-1, 2=>1},
    "121202121"=>{1=>1, 2=>-1},
    "121212121"=>{1=>1, 2=>-1},
    "121200102"=>{1=>1, 2=>-1},
    "121200010"=>{1=>0.7083333333333334, 2=>0.3333333333333333},
    "121220010"=>{1=>0.5, 2=>0.6666666666666666},
    "121220011"=>{1=>-1, 2=>1},
    "121220211"=>{1=>1, 2=>-1},
    "121202010"=>{1=>1, 2=>-1},
    "121200210"=>{1=>1, 2=>-1},
    "121200211"=>{1=>1, 2=>-1},
    "121200012"=>{1=>0.3333333333333333, 2=>0.0},
    "121200001"=>{1=>1, 2=>-1},
    "121220001"=>{1=>1, 2=>-1},
    "121200201"=>{1=>1, 2=>-1},
    "121200021"=>{1=>1, 2=>-1},
    "121020000"=>{1=>0.41666666666666663, 2=>0.8666666666666668},
    "121120000"=>{1=>-1, 2=>1},
    "121120200"=>{1=>0.0, 2=>0.6666666666666666},
    "121121200"=>{1=>-1, 2=>1},
    "121121220"=>{1=>-1, 2=>1},
    "121121202"=>{1=>0.0, 2=>0.0},
    "121121212"=>{1=>0, 2=>0},
    "121120210"=>{1=>0.0, 2=>0.0},
    "121120212"=>{1=>0.0, 2=>0.0},
    "121120201"=>{1=>-1, 2=>1},
    "121120221"=>{1=>-1, 2=>1},
    "121120020"=>{1=>-1, 2=>1},
    "121120002"=>{1=>1, 2=>-1},
    "121120102"=>{1=>1, 2=>-1},
    "121120012"=>{1=>0.5, 2=>0.0},
    "121020100"=>{1=>-1, 2=>1},
    "121020120"=>{1=>-1, 2=>1},
    "121020102"=>{1=>1, 2=>-1},
    "121020112"=>{1=>0.5, 2=>0.0},
    "121020010"=>{1=>0.41666666666666663, 2=>0.3333333333333333},
    "121020210"=>{1=>0.3333333333333333, 2=>0.0},
    "121000200"=>{1=>1, 2=>-1},
    "121100200"=>{1=>-1, 2=>1},
    "121100220"=>{1=>-1, 2=>1},
    "121110220"=>{1=>-1, 2=>1},
    "121110222"=>{1=>-1, 2=>1},
    "121101220"=>{1=>-1, 2=>1},
    "121101222"=>{1=>-1, 2=>1},
    "121100221"=>{1=>-1, 2=>1},
    "121100202"=>{1=>0.0, 2=>0.6666666666666666},
    "121110202"=>{1=>-1, 2=>1},
    "121101202"=>{1=>-1, 2=>1},
    "121100212"=>{1=>0.0, 2=>0.0},
    "121010200"=>{1=>0.75, 2=>0.6666666666666666},
    "121010220"=>{1=>1, 2=>-1},
    "121011220"=>{1=>-1, 2=>1},
    "121010221"=>{1=>1, 2=>-1},
    "121010202"=>{1=>0.0, 2=>0.6666666666666666},
    "121010212"=>{1=>0.0, 2=>0.0},
    "121001200"=>{1=>0.75, 2=>0.6666666666666666},
    "121001220"=>{1=>1, 2=>-1},
    "121001221"=>{1=>1, 2=>-1},
    "121000210"=>{1=>0.41666666666666663, 2=>0.0},
    "121000212"=>{1=>0.0, 2=>0.0},
    "121000201"=>{1=>1, 2=>-1},
    "121000221"=>{1=>1, 2=>-1},
    "121000020"=>{1=>1, 2=>-1},
    "121100020"=>{1=>-1, 2=>1},
    "121010020"=>{1=>1, 2=>-1},
    "121000120"=>{1=>-1, 2=>1},
    "120100000"=>{1=>1, 2=>-1},
    "122100000"=>{1=>1, 2=>-1},
    "122110000"=>{1=>1, 2=>-1},
    "122112000"=>{1=>1, 2=>-1},
    "122112100"=>{1=>1, 2=>-1},
    "122112010"=>{1=>-1, 2=>1},
    "122112210"=>{1=>1, 2=>-1},
    "122112211"=>{1=>1, 2=>-1},
    "122112012"=>{1=>-1, 2=>1},
    "122112001"=>{1=>1, 2=>-1},
    "122110200"=>{1=>1, 2=>-1},
    "122111200"=>{1=>1, 2=>-1},
    "122110210"=>{1=>1, 2=>-1},
    "122110212"=>{1=>1, 2=>-1},
    "122111212"=>{1=>1, 2=>-1},
    "122110201"=>{1=>1, 2=>-1},
    "122110020"=>{1=>1, 2=>-1},
    "122111020"=>{1=>1, 2=>-1},
    "122110120"=>{1=>1, 2=>-1},
    "122110021"=>{1=>1, 2=>-1},
    "122110002"=>{1=>1, 2=>-1},
    "122111002"=>{1=>1, 2=>-1},
    "122110102"=>{1=>1, 2=>-1},
    "122110012"=>{1=>-1, 2=>1},
    "122101000"=>{1=>1, 2=>-1},
    "122121000"=>{1=>1, 2=>-1},
    "122121100"=>{1=>1, 2=>-1},
    "122121010"=>{1=>-1, 2=>1},
    "122121210"=>{1=>-1, 2=>1},
    "122121012"=>{1=>1, 2=>-1},
    "122121112"=>{1=>1, 2=>-1},
    "122121001"=>{1=>-1, 2=>1},
    "122121201"=>{1=>-1, 2=>1},
    "122121021"=>{1=>-1, 2=>1},
    "122101200"=>{1=>1, 2=>-1},
    "122101210"=>{1=>-1, 2=>1},
    "122101212"=>{1=>1, 2=>-1},
    "122101201"=>{1=>-1, 2=>1},
    "122101221"=>{1=>1, 2=>-1},
    "122111221"=>{1=>1, 2=>-1},
    "122101020"=>{1=>1, 2=>-1},
    "122101120"=>{1=>1, 2=>-1},
    "122101021"=>{1=>-1, 2=>1},
    "122101002"=>{1=>1, 2=>-1},
    "122101102"=>{1=>1, 2=>-1},
    "122101012"=>{1=>1, 2=>-1},
    "122100100"=>{1=>1, 2=>-1},
    "122100010"=>{1=>1, 2=>-1},
    "122120010"=>{1=>1, 2=>-1},
    "122120110"=>{1=>1, 2=>-1},
    "122120011"=>{1=>-1, 2=>1},
    "122122011"=>{1=>1, 2=>-1},
    "122122111"=>{1=>1, 2=>-1},
    "122120211"=>{1=>-1, 2=>1},
    "122102010"=>{1=>1, 2=>-1},
    "122102110"=>{1=>1, 2=>-1},
    "122102011"=>{1=>1, 2=>-1},
    "122102211"=>{1=>1, 2=>-1},
    "122100210"=>{1=>1, 2=>-1},
    "122100211"=>{1=>-1, 2=>1},
    "122100012"=>{1=>1, 2=>-1},
    "122100112"=>{1=>1, 2=>-1},
    "122100001"=>{1=>1, 2=>-1},
    "122120001"=>{1=>1, 2=>-1},
    "122120101"=>{1=>1, 2=>-1},
    "122102001"=>{1=>1, 2=>-1},
    "122102101"=>{1=>1, 2=>-1},
    "122100201"=>{1=>1, 2=>-1},
    "122100021"=>{1=>1, 2=>-1},
    "120120000"=>{1=>1, 2=>-1},
    "120121000"=>{1=>-1, 2=>1},
    "120121200"=>{1=>-1, 2=>1},
    "120121210"=>{1=>-1, 2=>1},
    "120121212"=>{1=>0.0, 2=>0.0},
    "120121201"=>{1=>-1, 2=>1},
    "120121020"=>{1=>-1, 2=>1},
    "120121002"=>{1=>1, 2=>-1},
    "120121102"=>{1=>1, 2=>-1},
    "120121012"=>{1=>0.5, 2=>0.0},
    "120120100"=>{1=>1, 2=>-1},
    "120120010"=>{1=>0.75, 2=>0.6666666666666666},
    "120122010"=>{1=>1, 2=>-1},
    "120122110"=>{1=>1, 2=>-1},
    "120122011"=>{1=>0.5, 2=>0.0},
    "120122211"=>{1=>0.0, 2=>0.0},
    "120120210"=>{1=>0.0, 2=>0.6666666666666666},
    "120120211"=>{1=>-1, 2=>1},
    "120120012"=>{1=>1, 2=>-1},
    "120120112"=>{1=>1, 2=>-1},
    "120120001"=>{1=>-1, 2=>1},
    "120122001"=>{1=>1, 2=>-1},
    "120122101"=>{1=>1, 2=>-1},
    "120120201"=>{1=>-1, 2=>1},
    "120120021"=>{1=>-1, 2=>1},
    "120102000"=>{1=>1, 2=>-1},
    "120112000"=>{1=>1, 2=>-1},
    "120112200"=>{1=>1, 2=>-1},
    "120112210"=>{1=>0.5, 2=>0.0},
    "120112212"=>{1=>0.0, 2=>0.0},
    "120112201"=>{1=>1, 2=>-1},
    "120112020"=>{1=>1, 2=>-1},
    "120112120"=>{1=>1, 2=>-1},
    "120112021"=>{1=>1, 2=>-1},
    "120112002"=>{1=>1, 2=>-1},
    "120112102"=>{1=>1, 2=>-1},
    "120112012"=>{1=>-1, 2=>1},
    "120102100"=>{1=>1, 2=>-1},
    "120102010"=>{1=>0.8333333333333334, 2=>0.0},
    "120102210"=>{1=>0.3333333333333333, 2=>0.0},
    "120102211"=>{1=>0.5, 2=>0.0},
    "120102012"=>{1=>1, 2=>-1},
    "120102112"=>{1=>1, 2=>-1},
    "120102001"=>{1=>1, 2=>-1},
    "120102201"=>{1=>1, 2=>-1},
    "120102021"=>{1=>1, 2=>-1},
    "120100200"=>{1=>1, 2=>-1},
    "120110200"=>{1=>1, 2=>-1},
    "120110220"=>{1=>1, 2=>-1},
    "120111220"=>{1=>1, 2=>-1},
    "120110221"=>{1=>1, 2=>-1},
    "120110202"=>{1=>1, 2=>-1},
    "120111202"=>{1=>1, 2=>-1},
    "120110212"=>{1=>0.5, 2=>0.0},
    "120101200"=>{1=>-1, 2=>1},
    "120101220"=>{1=>1, 2=>-1},
    "120101202"=>{1=>1, 2=>-1},
    "120101212"=>{1=>0.5, 2=>0.0},
    "120100210"=>{1=>0.41666666666666663, 2=>0.2222222222222222},
    "120100212"=>{1=>0.3333333333333333, 2=>0.0},
    "120100201"=>{1=>-1, 2=>1},
    "120100221"=>{1=>1, 2=>-1},
    "120100020"=>{1=>1, 2=>-1},
    "120110020"=>{1=>1, 2=>-1},
    "120110022"=>{1=>1, 2=>-1},
    "120111022"=>{1=>1, 2=>-1},
    "120101020"=>{1=>-1, 2=>1},
    "120101022"=>{1=>1, 2=>-1},
    "120100120"=>{1=>1, 2=>-1},
    "120100021"=>{1=>-1, 2=>1},
    "120100002"=>{1=>1, 2=>-1},
    "120110002"=>{1=>1, 2=>-1},
    "120101002"=>{1=>1, 2=>-1},
    "120100102"=>{1=>1, 2=>-1},
    "120100012"=>{1=>0.8333333333333334, 2=>0.0},
    "120010000"=>{1=>1, 2=>-1},
    "122010000"=>{1=>1, 2=>-1},
    "122011000"=>{1=>1, 2=>-1},
    "122211000"=>{1=>1, 2=>-1},
    "122211010"=>{1=>0.5, 2=>0.0},
    "122211210"=>{1=>1, 2=>-1},
    "122211211"=>{1=>1, 2=>-1},
    "122211012"=>{1=>0.0, 2=>0.0},
    "122211001"=>{1=>1, 2=>-1},
    "122011200"=>{1=>1, 2=>-1},
    "122011210"=>{1=>1, 2=>-1},
    "122011212"=>{1=>1, 2=>-1},
    "122011201"=>{1=>1, 2=>-1},
    "122011020"=>{1=>1, 2=>-1},
    "122011120"=>{1=>1, 2=>-1},
    "122011122"=>{1=>1, 2=>-1},
    "122111122"=>{1=>1, 2=>-1},
    "122011002"=>{1=>1, 2=>-1},
    "122011102"=>{1=>0.5, 2=>0.0},
    "122011012"=>{1=>0.5, 2=>0.0},
    "122010100"=>{1=>1, 2=>-1},
    "122012100"=>{1=>1, 2=>-1},
    "122012110"=>{1=>-1, 2=>1},
    "122012112"=>{1=>-1, 2=>1},
    "122012101"=>{1=>1, 2=>-1},
    "122010120"=>{1=>1, 2=>-1},
    "122010102"=>{1=>1, 2=>-1},
    "122010112"=>{1=>-1, 2=>1},
    "122010010"=>{1=>0.875, 2=>0.6666666666666666},
    "122210010"=>{1=>1, 2=>-1},
    "122210011"=>{1=>1, 2=>-1},
    "122012010"=>{1=>1, 2=>-1},
    "122010210"=>{1=>1, 2=>-1},
    "122010211"=>{1=>1, 2=>-1},
    "122010012"=>{1=>0.5, 2=>0.6666666666666666},
    "122010001"=>{1=>1, 2=>-1},
    "120210000"=>{1=>1, 2=>-1},
    "120211000"=>{1=>0.8333333333333334, 2=>0.0},
    "120211020"=>{1=>1, 2=>-1},
    "120211002"=>{1=>0.3333333333333333, 2=>0.0},
    "120211012"=>{1=>0.0, 2=>0.0},
    "120210001"=>{1=>1, 2=>-1},
    "120012000"=>{1=>1, 2=>-1},
    "120012100"=>{1=>1, 2=>-1},
    "120012120"=>{1=>1, 2=>-1},
    "120012102"=>{1=>1, 2=>-1},
    "120012112"=>{1=>-1, 2=>1},
    "120012010"=>{1=>0.875, 2=>0.6666666666666666},
    "120012210"=>{1=>1, 2=>-1},
    "120012012"=>{1=>0.5, 2=>0.6666666666666666},
    "120012001"=>{1=>1, 2=>-1},
    "120010200"=>{1=>1, 2=>-1},
    "120011200"=>{1=>1, 2=>-1},
    "120011220"=>{1=>1, 2=>-1},
    "120011202"=>{1=>1, 2=>-1},
    "120011212"=>{1=>0.5, 2=>0.0},
    "120010210"=>{1=>0.8333333333333334, 2=>0.0},
    "120010212"=>{1=>0.3333333333333333, 2=>0.0},
    "120010201"=>{1=>1, 2=>-1},
    "120010020"=>{1=>1, 2=>-1},
    "120011020"=>{1=>1, 2=>-1},
    "120011022"=>{1=>1, 2=>-1},
    "120010120"=>{1=>1, 2=>-1},
    "120010021"=>{1=>1, 2=>-1},
    "120010002"=>{1=>1, 2=>-1},
    "120011002"=>{1=>0.8333333333333333, 2=>0.0},
    "120010102"=>{1=>1, 2=>-1},
    "120010012"=>{1=>0.41666666666666663, 2=>0.3333333333333333},
    "120001000"=>{1=>0.951388888888889, 2=>0.8666666666666668},
    "122001000"=>{1=>1, 2=>-1},
    "122001100"=>{1=>1, 2=>-1},
    "122021100"=>{1=>1, 2=>-1},
    "122021110"=>{1=>1, 2=>-1},
    "122021112"=>{1=>1, 2=>-1},
    "122021101"=>{1=>-1, 2=>1},
    "122001120"=>{1=>1, 2=>-1},
    "122001102"=>{1=>1, 2=>-1},
    "122001112"=>{1=>0.5, 2=>0.0},
    "122001010"=>{1=>1, 2=>-1},
    "122201010"=>{1=>1, 2=>-1},
    "122201011"=>{1=>1, 2=>-1},
    "122221011"=>{1=>1, 2=>-1},
    "122201211"=>{1=>1, 2=>-1},
    "122021010"=>{1=>1, 2=>-1},
    "122021011"=>{1=>-1, 2=>1},
    "122021211"=>{1=>-1, 2=>1},
    "122001210"=>{1=>1, 2=>-1},
    "122001211"=>{1=>-1, 2=>1},
    "122001012"=>{1=>1, 2=>-1},
    "122001001"=>{1=>-1, 2=>1},
    "122201001"=>{1=>1, 2=>-1},
    "122021001"=>{1=>-1, 2=>1},
    "122001201"=>{1=>1, 2=>-1},
    "120201000"=>{1=>1, 2=>-1},
    "120201010"=>{1=>0.75, 2=>0.0},
    "120221010"=>{1=>1, 2=>-1},
    "120221011"=>{1=>1, 2=>-1},
    "120201012"=>{1=>0.0, 2=>0.0},
    "120201001"=>{1=>1, 2=>-1},
    "120221001"=>{1=>1, 2=>-1},
    "120201201"=>{1=>1, 2=>-1},
    "120021000"=>{1=>0.7083333333333334, 2=>0.8666666666666668},
    "120021100"=>{1=>-1, 2=>1},
    "120021120"=>{1=>-1, 2=>1},
    "120021102"=>{1=>1, 2=>-1},
    "120021112"=>{1=>0.5, 2=>0.0},
    "120021010"=>{1=>0.7083333333333334, 2=>0.3333333333333333},
    "120021210"=>{1=>0.5, 2=>0.6666666666666666},
    "120021211"=>{1=>-1, 2=>1},
    "120021012"=>{1=>0.3333333333333333, 2=>0.0},
    "120021001"=>{1=>-1, 2=>1},
    "120021201"=>{1=>1, 2=>-1},
    "120001200"=>{1=>1, 2=>-1},
    "120001210"=>{1=>0.7083333333333334, 2=>0.3333333333333333},
    "120001212"=>{1=>0.3333333333333333, 2=>0.0},
    "120001201"=>{1=>1, 2=>-1},
    "120001020"=>{1=>1, 2=>-1},
    "120001120"=>{1=>-1, 2=>1},
    "120001002"=>{1=>1, 2=>-1},
    "120001102"=>{1=>0.8333333333333333, 2=>0.0},
    "120001012"=>{1=>0.41666666666666663, 2=>0.0},
    "120000100"=>{1=>1, 2=>-1},
    "122000100"=>{1=>1, 2=>-1},
    "122000110"=>{1=>1, 2=>-1},
    "122020110"=>{1=>1, 2=>-1},
    "122020111"=>{1=>1, 2=>-1},
    "122002110"=>{1=>1, 2=>-1},
    "122000112"=>{1=>1, 2=>-1},
    "122000101"=>{1=>1, 2=>-1},
    "122020101"=>{1=>1, 2=>-1},
    "122002101"=>{1=>1, 2=>-1},
    "120020100"=>{1=>1, 2=>-1},
    "120020110"=>{1=>1, 2=>-1},
    "120022110"=>{1=>1, 2=>-1},
    "120020112"=>{1=>1, 2=>-1},
    "120020101"=>{1=>-1, 2=>1},
    "120022101"=>{1=>1, 2=>-1},
    "120002100"=>{1=>1, 2=>-1},
    "120002110"=>{1=>1, 2=>-1},
    "120002112"=>{1=>1, 2=>-1},
    "120002101"=>{1=>1, 2=>-1},
    "120000120"=>{1=>1, 2=>-1},
    "120000102"=>{1=>1, 2=>-1},
    "120000112"=>{1=>0.8333333333333333, 2=>0.0},
    "120000010"=>{1=>0.8722222222222222, 2=>0.15555555555555556},
    "122000010"=>{1=>1, 2=>-1},
    "122000011"=>{1=>1, 2=>-1},
    "122020011"=>{1=>1, 2=>-1},
    "122000211"=>{1=>1, 2=>-1},
    "120020010"=>{1=>1, 2=>-1},
    "120020011"=>{1=>0.875, 2=>0.6666666666666666},
    "120020211"=>{1=>0.5, 2=>0.6666666666666666},
    "120002010"=>{1=>1, 2=>-1},
    "120000210"=>{1=>0.65, 2=>0.24444444444444446},
    "120000211"=>{1=>0.875, 2=>0.6666666666666666},
    "120000012"=>{1=>0.5833333333333333, 2=>0.06666666666666667},
    "120000001"=>{1=>0.9791666666666666, 2=>0.9333333333333333},
    "122000001"=>{1=>1, 2=>-1},
    "120200001"=>{1=>1, 2=>-1},
    "120020001"=>{1=>0.875, 2=>0.9333333333333333},
    "120002001"=>{1=>1, 2=>-1},
    "120000201"=>{1=>1, 2=>-1},
    "120000021"=>{1=>1, 2=>-1},
    "102000000"=>{1=>1, 2=>-1},
    "112000000"=>{1=>-1, 2=>1},
    "112020000"=>{1=>0.75, 2=>0.9333333333333332},
    "112120000"=>{1=>-1, 2=>1},
    "112122000"=>{1=>1, 2=>-1},
    "112122100"=>{1=>1, 2=>-1},
    "112122010"=>{1=>-1, 2=>1},
    "112122210"=>{1=>-1, 2=>1},
    "112122012"=>{1=>-1, 2=>1},
    "112120200"=>{1=>-1, 2=>1},
    "112120020"=>{1=>1, 2=>-1},
    "112121020"=>{1=>-1, 2=>1},
    "112121022"=>{1=>1, 2=>-1},
    "112120002"=>{1=>1, 2=>-1},
    "112121002"=>{1=>-1, 2=>1},
    "112121202"=>{1=>-1, 2=>1},
    "112120102"=>{1=>1, 2=>-1},
    "112120012"=>{1=>-1, 2=>1},
    "112021000"=>{1=>-1, 2=>1},
    "112021200"=>{1=>-1, 2=>1},
    "112021020"=>{1=>0.5, 2=>0.6666666666666666},
    "112021002"=>{1=>0.5, 2=>0.6666666666666666},
    "112021102"=>{1=>0.5, 2=>0.0},
    "112021012"=>{1=>-1, 2=>1},
    "112021212"=>{1=>-1, 2=>1},
    "112020100"=>{1=>0.75, 2=>0.6666666666666666},
    "112022100"=>{1=>1, 2=>-1},
    "112022110"=>{1=>-1, 2=>1},
    "112022112"=>{1=>-1, 2=>1},
    "112020102"=>{1=>1, 2=>-1},
    "112020112"=>{1=>-1, 2=>1},
    "112020010"=>{1=>-1, 2=>1},
    "112022010"=>{1=>-1, 2=>1},
    "112020210"=>{1=>-1, 2=>1},
    "112020012"=>{1=>-1, 2=>1},
    "112020001"=>{1=>-1, 2=>1},
    "112020201"=>{1=>-1, 2=>1},
    "112002000"=>{1=>-1, 2=>1},
    "112102000"=>{1=>-1, 2=>1},
    "112102200"=>{1=>-1, 2=>1},
    "112112200"=>{1=>-1, 2=>1},
    "112112220"=>{1=>1, 2=>-1},
    "112112202"=>{1=>-1, 2=>1},
    "112102210"=>{1=>-1, 2=>1},
    "112102212"=>{1=>-1, 2=>1},
    "112102020"=>{1=>1, 2=>-1},
    "112112020"=>{1=>-1, 2=>1},
    "112112022"=>{1=>-1, 2=>1},
    "112102002"=>{1=>-1, 2=>1},
    "112012000"=>{1=>-1, 2=>1},
    "112012200"=>{1=>1, 2=>-1},
    "112012210"=>{1=>1, 2=>-1},
    "112012020"=>{1=>1, 2=>-1},
    "112012002"=>{1=>-1, 2=>1},
    "112002100"=>{1=>-1, 2=>1},
    "112002102"=>{1=>-1, 2=>1},
    "112002010"=>{1=>-1, 2=>1},
    "112002210"=>{1=>1, 2=>-1},
    "112002012"=>{1=>-1, 2=>1},
    "112000200"=>{1=>1, 2=>-1},
    "112100200"=>{1=>-1, 2=>1},
    "112100202"=>{1=>-1, 2=>1},
    "112110202"=>{1=>-1, 2=>1},
    "112101202"=>{1=>-1, 2=>1},
    "112010200"=>{1=>1, 2=>-1},
    "112010220"=>{1=>1, 2=>-1},
    "112011220"=>{1=>-1, 2=>1},
    "112011222"=>{1=>-1, 2=>1},
    "112010202"=>{1=>1, 2=>-1},
    "112011202"=>{1=>-1, 2=>1},
    "112010212"=>{1=>1, 2=>-1},
    "112001200"=>{1=>-1, 2=>1},
    "112001220"=>{1=>-1, 2=>1},
    "112001202"=>{1=>-1, 2=>1},
    "112001212"=>{1=>-1, 2=>1},
    "112000210"=>{1=>-1, 2=>1},
    "112000212"=>{1=>1, 2=>-1},
    "112000201"=>{1=>-1, 2=>1},
    "112000020"=>{1=>0.8541666666666666, 2=>0.7333333333333333},
    "112100020"=>{1=>-1, 2=>1},
    "112100022"=>{1=>1, 2=>-1},
    "112110022"=>{1=>-1, 2=>1},
    "112101022"=>{1=>-1, 2=>1},
    "112010020"=>{1=>-1, 2=>1},
    "112010022"=>{1=>-1, 2=>1},
    "112011022"=>{1=>-1, 2=>1},
    "112001020"=>{1=>-1, 2=>1},
    "112001022"=>{1=>0.5, 2=>0.6666666666666666},
    "112000002"=>{1=>-1, 2=>1},
    "112100002"=>{1=>-1, 2=>1},
    "112010002"=>{1=>-1, 2=>1},
    "112001002"=>{1=>-1, 2=>1},
    "112000102"=>{1=>-1, 2=>1},
    "112000012"=>{1=>-1, 2=>1},
    "102100000"=>{1=>1, 2=>-1},
    "102120000"=>{1=>1, 2=>-1},
    "102121000"=>{1=>-1, 2=>1},
    "102121020"=>{1=>1, 2=>-1},
    "102121002"=>{1=>1, 2=>-1},
    "102121102"=>{1=>1, 2=>-1},
    "102121012"=>{1=>-1, 2=>1},
    "102120100"=>{1=>1, 2=>-1},
    "102120010"=>{1=>-1, 2=>1},
    "102122010"=>{1=>1, 2=>-1},
    "102122110"=>{1=>1, 2=>-1},
    "102120012"=>{1=>1, 2=>-1},
    "102120001"=>{1=>-1, 2=>1},
    "102102000"=>{1=>1, 2=>-1},
    "102112000"=>{1=>-1, 2=>1},
    "102112020"=>{1=>1, 2=>-1},
    "102112002"=>{1=>-1, 2=>1},
    "102102100"=>{1=>1, 2=>-1},
    "102102010"=>{1=>-1, 2=>1},
    "102102012"=>{1=>-1, 2=>1},
    "102100020"=>{1=>1, 2=>-1},
    "102110020"=>{1=>1, 2=>-1},
    "102110022"=>{1=>1, 2=>-1},
    "102111022"=>{1=>1, 2=>-1},
    "102101020"=>{1=>1, 2=>-1},
    "102101022"=>{1=>1, 2=>-1},
    "102100002"=>{1=>1, 2=>-1},
    "102110002"=>{1=>-1, 2=>1},
    "102101002"=>{1=>1, 2=>-1},
    "102100102"=>{1=>1, 2=>-1},
    "102100012"=>{1=>-1, 2=>1},
    "102010000"=>{1=>0.9722222222222222, 2=>0.8},
    "102012000"=>{1=>1, 2=>-1},
    "102012100"=>{1=>-1, 2=>1},
    "102012102"=>{1=>-1, 2=>1},
    "102012010"=>{1=>-1, 2=>1},
    "102012210"=>{1=>1, 2=>-1},
    "102012012"=>{1=>-1, 2=>1},
    "102010200"=>{1=>1, 2=>-1},
    "102011200"=>{1=>1, 2=>-1},
    "102011202"=>{1=>1, 2=>-1},
    "102011212"=>{1=>1, 2=>-1},
    "102010201"=>{1=>1, 2=>-1},
    "102010020"=>{1=>1, 2=>-1},
    "102011020"=>{1=>1, 2=>-1},
    "102011022"=>{1=>1, 2=>-1},
    "102010002"=>{1=>0.8333333333333333, 2=>0.8},
    "102011002"=>{1=>0.8333333333333333, 2=>0.0},
    "102010102"=>{1=>-1, 2=>1},
    "102010012"=>{1=>-1, 2=>1},
    "102001000"=>{1=>0.9138888888888889, 2=>0.5222222222222223},
    "102021000"=>{1=>0.8333333333333333, 2=>0.8},
    "102021100"=>{1=>0.8333333333333333, 2=>0.0},
    "102021102"=>{1=>1, 2=>-1},
    "102021010"=>{1=>-1, 2=>1},
    "102021210"=>{1=>-1, 2=>1},
    "102021012"=>{1=>0.5, 2=>0.6666666666666666},
    "102001200"=>{1=>1, 2=>-1},
    "102001210"=>{1=>-1, 2=>1},
    "102001212"=>{1=>1, 2=>-1},
    "102001020"=>{1=>1, 2=>-1},
    "102001002"=>{1=>1, 2=>-1},
    "102001102"=>{1=>0.75, 2=>0.0},
    "102001012"=>{1=>0.7083333333333333, 2=>0.3333333333333333},
    "102000100"=>{1=>1, 2=>-1},
    "102020100"=>{1=>1, 2=>-1},
    "102020110"=>{1=>1, 2=>-1},
    "102022110"=>{1=>1, 2=>-1},
    "102020101"=>{1=>1, 2=>-1},
    "102002100"=>{1=>1, 2=>-1},
    "102002110"=>{1=>-1, 2=>1},
    "102000102"=>{1=>1, 2=>-1},
    "102000010"=>{1=>0.9513888888888888, 2=>0.8666666666666668},
    "102020010"=>{1=>1, 2=>-1},
    "102002010"=>{1=>1, 2=>-1},
    "102000012"=>{1=>0.7083333333333333, 2=>0.8666666666666668},
    "102000001"=>{1=>1, 2=>-1},
    "102020001"=>{1=>1, 2=>-1},
    "102000201"=>{1=>1, 2=>-1},
    "100020000"=>{1=>0.9072420634920635, 2=>0.8714285714285716},
    "110020000"=>{1=>0.9583333333333334, 2=>0.9333333333333332},
    "110022000"=>{1=>1, 2=>-1},
    "110122000"=>{1=>1, 2=>-1},
    "110122020"=>{1=>1, 2=>-1},
    "110122002"=>{1=>1, 2=>-1},
    "110122012"=>{1=>-1, 2=>1},
    "110022100"=>{1=>-1, 2=>1},
    "110022010"=>{1=>-1, 2=>1},
    "110022012"=>{1=>1, 2=>-1},
    "110020020"=>{1=>1, 2=>-1},
    "111020020"=>{1=>1, 2=>-1},
    "110021020"=>{1=>0.875, 2=>0.6666666666666666},
    "110021022"=>{1=>1, 2=>-1},
    "110020002"=>{1=>1, 2=>-1},
    "110120002"=>{1=>1, 2=>-1},
    "110021002"=>{1=>0.875, 2=>0.6666666666666666},
    "110020012"=>{1=>-1, 2=>1},
    "101020000"=>{1=>0.9027777777777777, 2=>0.8666666666666668},
    "101020020"=>{1=>1, 2=>-1},
    "100021000"=>{1=>0.8559027777777777, 2=>0.7833333333333333},
    "100021020"=>{1=>0.875, 2=>0.9333333333333332},
    "100021002"=>{1=>0.71875, 2=>0.5333333333333333},
    "100021012"=>{1=>0.41666666666666663, 2=>0.3333333333333333},
    "100020001"=>{1=>0.9166666666666666, 2=>0.9333333333333332},
    "100002000"=>{1=>1, 2=>-1},
    "110002000"=>{1=>-1, 2=>1},
    "110002020"=>{1=>1, 2=>-1},
    "110102020"=>{1=>1, 2=>-1},
    "110102022"=>{1=>1, 2=>-1},
    "110112022"=>{1=>-1, 2=>1},
    "110012020"=>{1=>1, 2=>-1},
    "110012022"=>{1=>1, 2=>-1},
    "110002002"=>{1=>1, 2=>-1},
    "110102002"=>{1=>-1, 2=>1},
    "110012002"=>{1=>-1, 2=>1},
    "110002012"=>{1=>-1, 2=>1},
    "100102000"=>{1=>0.9756944444444443, 2=>0.7333333333333333},
    "100102002"=>{1=>1, 2=>-1},
    "100112002"=>{1=>-1, 2=>1},
    "100102012"=>{1=>-1, 2=>1},
    "100012000"=>{1=>1, 2=>-1},
    "100012020"=>{1=>1, 2=>-1},
    "100012002"=>{1=>1, 2=>-1},
    "100012012"=>{1=>-1, 2=>1},
    "100002100"=>{1=>1, 2=>-1},
    "100002010"=>{1=>0.9791666666666666, 2=>0.9333333333333332},
    "100002012"=>{1=>1, 2=>-1},
    "100000002"=>{1=>1, 2=>-1},
    "110000002"=>{1=>-1, 2=>1},
    "100010002"=>{1=>0.9444444444444443, 2=>0.8},
    "100001002"=>{1=>0.8350694444444443, 2=>0.4888888888888889},
    "010000000"=>{1=>0.9434482473544974, 2=>0.696957671957672},
    "210000000"=>{1=>0.8717013888888888, 2=>0.7074074074074074},
    "210100000"=>{1=>0.78125, 2=>0.5407407407407407},
    "212100000"=>{1=>1, 2=>-1},
    "212110000"=>{1=>1, 2=>-1},
    "212112000"=>{1=>1, 2=>-1},
    "212112010"=>{1=>1, 2=>-1},
    "212110200"=>{1=>1, 2=>-1},
    "212111200"=>{1=>1, 2=>-1},
    "212110020"=>{1=>1, 2=>-1},
    "212111020"=>{1=>1, 2=>-1},
    "212110002"=>{1=>1, 2=>-1},
    "212110012"=>{1=>1, 2=>-1},
    "212101000"=>{1=>-1, 2=>1},
    "212121000"=>{1=>-1, 2=>1},
    "212121010"=>{1=>-1, 2=>1},
    "212121210"=>{1=>-1, 2=>1},
    "212101200"=>{1=>1, 2=>-1},
    "212101210"=>{1=>-1, 2=>1},
    "212101212"=>{1=>1, 2=>-1},
    "212111212"=>{1=>1, 2=>-1},
    "212101020"=>{1=>1, 2=>-1},
    "212100010"=>{1=>-1, 2=>1},
    "212120010"=>{1=>-1, 2=>1},
    "212102010"=>{1=>1, 2=>-1},
    "212100012"=>{1=>1, 2=>-1},
    "210120000"=>{1=>0.41666666666666663, 2=>0.8666666666666666},
    "210121000"=>{1=>-1, 2=>1},
    "210121020"=>{1=>0.5, 2=>0.6666666666666666},
    "210121002"=>{1=>-1, 2=>1},
    "210102000"=>{1=>0.6354166666666666, 2=>0.37777777777777777},
    "210112000"=>{1=>0.8333333333333334, 2=>0.0},
    "210112020"=>{1=>0.3333333333333333, 2=>0.0},
    "210112002"=>{1=>1, 2=>-1},
    "210112012"=>{1=>1, 2=>-1},
    "210102010"=>{1=>0.875, 2=>0.6666666666666666},
    "210102012"=>{1=>1, 2=>-1},
    "210100002"=>{1=>1, 2=>-1},
    "210110002"=>{1=>1, 2=>-1},
    "210101002"=>{1=>-1, 2=>1},
    "210010000"=>{1=>0.9565972222222222, 2=>0.39999999999999997},
    "212010000"=>{1=>1, 2=>-1},
    "212010010"=>{1=>1, 2=>-1},
    "210210000"=>{1=>1, 2=>-1},
    "210211000"=>{1=>-1, 2=>1},
    "210211200"=>{1=>-1, 2=>1},
    "210211020"=>{1=>0.5, 2=>0.6666666666666666},
    "210211002"=>{1=>1, 2=>-1},
    "210210010"=>{1=>1, 2=>-1},
    "210012000"=>{1=>1, 2=>-1},
    "210012010"=>{1=>1, 2=>-1},
    "210010200"=>{1=>1, 2=>-1},
    "210011200"=>{1=>-1, 2=>1},
    "210011220"=>{1=>1, 2=>-1},
    "210011202"=>{1=>1, 2=>-1},
    "210010210"=>{1=>1, 2=>-1},
    "210010020"=>{1=>0.7395833333333333, 2=>0.39999999999999997},
    "210011020"=>{1=>0.875, 2=>0.6666666666666666},
    "210010002"=>{1=>1, 2=>-1},
    "210011002"=>{1=>1, 2=>-1},
    "210010012"=>{1=>1, 2=>-1},
    "210001000"=>{1=>-1, 2=>1},
    "210201000"=>{1=>1, 2=>-1},
    "210201010"=>{1=>-1, 2=>1},
    "210221010"=>{1=>-1, 2=>1},
    "210201210"=>{1=>-1, 2=>1},
    "210021000"=>{1=>0.875, 2=>0.9333333333333333},
    "210021010"=>{1=>-1, 2=>1},
    "210021210"=>{1=>-1, 2=>1},
    "210001200"=>{1=>-1, 2=>1},
    "210001210"=>{1=>-1, 2=>1},
    "210001020"=>{1=>0.8229166666666665, 2=>0.5333333333333333},
    "210001002"=>{1=>1, 2=>-1},
    "210000010"=>{1=>-1, 2=>1},
    "212000010"=>{1=>1, 2=>-1},
    "210200010"=>{1=>1, 2=>-1},
    "210020010"=>{1=>-1, 2=>1},
    "210002010"=>{1=>1, 2=>-1},
    "210000210"=>{1=>1, 2=>-1},
    "210000012"=>{1=>1, 2=>-1},
    "010200000"=>{1=>1, 2=>-1},
    "010210000"=>{1=>1, 2=>-1},
    "010212000"=>{1=>1, 2=>-1},
    "010212010"=>{1=>1, 2=>-1},
    "010210200"=>{1=>1, 2=>-1},
    "010211200"=>{1=>-1, 2=>1},
    "010211220"=>{1=>-1, 2=>1},
    "010210020"=>{1=>1, 2=>-1},
    "010211020"=>{1=>-1, 2=>1},
    "010210002"=>{1=>1, 2=>-1},
    "010201000"=>{1=>0.9097222222222222, 2=>0.45555555555555555},
    "010221000"=>{1=>1, 2=>-1},
    "010221010"=>{1=>-1, 2=>1},
    "010201200"=>{1=>1, 2=>-1},
    "010201020"=>{1=>1, 2=>-1},
    "010200010"=>{1=>-1, 2=>1},
    "010220010"=>{1=>-1, 2=>1},
    "010202010"=>{1=>1, 2=>-1},
    "010020000"=>{1=>0.8917824074074074, 2=>0.8936507936507937},
    "010120000"=>{1=>0.861111111111111, 2=>0.911111111111111},
    "010120002"=>{1=>1, 2=>-1},
    "010020010"=>{1=>-1, 2=>1},
    "010000200"=>{1=>1, 2=>-1},
    "010010200"=>{1=>0.9791666666666666, 2=>0.9333333333333333},
    "010010220"=>{1=>0.875, 2=>0.9333333333333333},
    "010010202"=>{1=>1, 2=>-1},
    "010001200"=>{1=>-1, 2=>1},
    "010000020"=>{1=>0.9124007936507935, 2=>0.4793650793650793},
    "010010020"=>{1=>0.8715277777777777, 2=>0.6666666666666667},
    "000010000"=>{1=>0.9828869047619047, 2=>0.7238095238095238},
    "200010000"=>{1=>0.9657738095238095, 2=>0.7238095238095238},
    "020010000"=>{1=>1, 2=>-1}
  }
  
  
  RATINGS.default_proc = lambda do |boards, board|
    
    # Handle congruent boards
    Game.each_congruent board do |congruent_board|
      return boards[congruent_board] if boards.has_key? congruent_board
    end
    
    # This shouldn't ever happen, but if it does,
    # We know what to do anyway, so do it rather than blowing up
    tree = Rating.new board
    boards[board] = {
      1 => tree.rating_for(1),
      2 => tree.rating_for(2),
    }
  end
  
end