require 'spec_helper'
require 'ttt/ratings'

module TTT
  
  rate = lambda do |board, player|
    Rating.new(board).rating_for(player)
  end
  
  describe Rating do
    it 'rates as 1 if a board is a guaranteed win' do
      rate['110220000', 1].should == 1
    end
    
    it 'rates as -1 if a board can lead to a loss' do
      rate['110220100', 1].should == -1
    end
    
    it 'rates as 0 if a board leads to a guaranteed tie' do
      rate['112221100', 1].should == 0
    end
        
    it 'will rate a board for both player1 and player2' do
      rate['110220000', 1].should == 1
      rate['110220000', 2].should == -1
    end

    it 'rates player1 and player2 the same if board is guaranteed to tie' do
      rate['112221100', 1].should == rate['112221100', 2]
    end
    
    context "when it doesn't have a guaranteed win" do
      specify "ratings have relative merit such that a move with more opportunities to win will be rated higher" do
        better, worse = '121001200', '121100200'
        rate[better, 1].should be > rate[worse, 1]
        rate[better, 1].should_not == 1
        rate[worse, 1].should_not == 1
      end
    end
  end
  
  describe RATINGS do
    it "holds the calculated values of Rating so we don't need to calculate in real time" do
      %w[121020010 121020210 121000200 121100200 121100220].each do |board|
        RATINGS[board].should == { 1 => rate[board, 1], 2 => rate[board, 2] }
      end
    end
    
    it 'knows ratings for congruent boards' do
      topleft  = RATINGS['100000000']
      topright = RATINGS['001000000']
      botleft  = RATINGS['000000100']
      botright = RATINGS['000000001']
      topleft.should == topright
      topleft.should == botleft
      topleft.should == botright
    end
    
    describe "if for some reason it doesn't know the rating" do
      let(:board)         { '121001200' }
      let(:cached_value)  { RATINGS[board] }
      let(:empty_ratings) { r = RATINGS.dup; r.clear; r }
      it "will calculate the boards" do
        empty_ratings[board].should == cached_value
      end
      it 'will add the board to the RATINGS cache' do
        empty_ratings.size.should be 0
        empty_ratings[board]
        empty_ratings.size.should be 1
        empty_ratings[board]
        empty_ratings.size.should be 1
      end
    end
  end
end