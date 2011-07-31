require 'spec_helper'

module TTT
  describe Game do
    it 'has no moves when created without an argument' do
      Game.new.board.should == '0'*9
    end
    
    context 'when it is created with an unfinished board' do
      context 'with an equal number of 1s and 2s' do
        let(:board) { '120000000' }
        subject { Game.new board }
        its(:board) { should == board }
        its(:turn) { should == 1 }
        it 'marks the board with the current players number' do
          subject.mark(4)
          subject.board.should == '120100000'
        end
      end
      context 'with more 1s than 2s' do
        let(:board) { '120100000' }
        subject { Game.new board }
        its(:board) { should == board }
        its(:turn) { should == 2 }
        it 'marks the board with the current players number' do
          subject.mark(7)
          subject.board.should == '120100200'
        end
      end
    end
    
    describe 'board(:ttt)' do
      it 'renders the board in tic-tac-toe format' do
        @game = Game.new 'abcdefghi'
        @game.board(:ttt).should == "  a | b | c  \n----|---|----\n  d | e | f  \n----|---|----\n  g | h | i  "
      end
      it 'renders empty spaces with spaces' do
        @game = Game.new '120000000'
        @game.board(:ttt).should == "  1 | 2 |    \n----|---|----\n    |   |    \n----|---|----\n    |   |    "
      end
    end
    
    context 'when player1 can win' do
      let(:game) { Game.new '120120000' }
      pending
      # its(:over?) { should be true }
      # context 'and player1 wins' do
      #   before { game.mark 7 }
      #   its(:board) { should == '120120100' }
      #   its(:over?) { should be false }
      #   its(:turn)  { should be nil }
      #   specify('player1 should be the winner') { subject.status(1).should be :wins }
      #   specify('player2 should be the loser')  { subject.status(2).should be :loses }
      # end
    end
  end
end
