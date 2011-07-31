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
    end
  end
end
