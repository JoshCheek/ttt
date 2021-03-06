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
      it { should_not be_over }
      context 'and player1 wins' do
        before { game.mark 7 }
        subject { game }
        its(:board) { should == '120120100' }
        it { should be_over }
        it { should_not be_a_tie }
        its(:turn)  { should be nil }
        specify('player1 should be the winner') { subject.status(1).should be :wins }
        specify('player2 should be the loser')  { subject.status(2).should be :loses }
      end
    end
    
    context 'when player2 can win' do
      let(:game) { Game.new '121120000' }
      it { should_not be_over }
      context 'and player2 wins' do
        before { game.mark 8 }
        subject { game }
        it { should be_over }
        it { should_not be_a_tie }
        its(:board) { should == '121120020' }
        its(:turn)  { should be nil }
        specify('player1 should be the loser')  { subject.status(1).should be :loses }
        specify('player2 should be the winner') { subject.status(2).should be :wins }
      end
    end
    
    context 'when the game can end in a tie' do
      let(:game) { Game.new '121221012' }
      it { should_not be_over }
      context 'and the game ends in a tie' do
        before { game.mark 7 }
        subject { game }
        it { should be_over }
        it { should be_a_tie }
        its(:board) { should == '121221112' }
        its(:turn)  { should be nil }
        specify('player1 should tie') { subject.status(1).should be :ties }
        specify('player2 should tie') { subject.status(2).should be :ties }
      end
    end
    
    describe 'winning states' do
      [ ['111000000', 1],
        ['000111000', 1],
        ['000000111', 1],
        ['222000000', 2],
        ['000222000', 2],
        ['000000222', 2],
        ['100100100', 1],
        ['010010010', 1],
        ['001001001', 1],
        ['200200200', 2],
        ['020020020', 2],
        ['002002002', 2],
        ['100010001', 1],
        ['001010100', 1],
        ['200020002', 2],
        ['002020200', 2], ].each do |configuration, winner|
        context configuration do
          subject { Game.new configuration }
          it { should be_over }
          it { should_not be_a_tie }
          its(:winner) { should be winner }
          specify { subject.status(winner).should be :wins }
        end
      end
    end
    
    describe 'non winning states' do
      [ '000000000',
        '100000000',
        '100020000',
        '101020000',
        '121020000',
        '121020010',
        '121220010',
        '121221010',
        '121221012', ].each do |configuration|
        context configuration do
          subject { Game.new configuration }
          it { should_not be_over }
          it { should_not be_a_tie }
          its(:winner) { should be nil }
        end
      end
      context "121221112, a tied state" do
        subject { Game.new '121221112' }
        it { should be_over }
        it { should be_a_tie }
        its(:winner) { should be nil }
        specify("status(1) should be :ties") { subject.status(1).should be :ties }
        specify("status(2) should be :ties") { subject.status(2).should be :ties }
      end
    end
    
    describe '#available_moves' do
      { '000000000' => [1,2,3,4,5,6,7,8,9],
        '100000000' => [  2,3,4,5,6,7,8,9],
        '100020000' => [  2,3,4,  6,7,8,9],
        '101020000' => [  2,  4,  6,7,8,9],
        '121020000' => [      4,  6,7,8,9],
        '121020010' => [      4,  6,7,  9],
        '121220010' => [          6,7,  9],
        '121221010' => [            7,  9],
        '121221210' => [                9],
        '121221211' => [                 ],
      }.each do |board, available_moves|
        specify "#{board} should be able to move to #{available_moves.inspect}" do
          Game.new(board).available_moves.should == available_moves
        end
      end
      specify "It doesn't show available moves when a game is over" do
        Game.new('111000000').available_moves.should be_empty
      end
    end
    
    describe '#winning_positions' do
      [ ['111220000', [1, 2, 3]],
        ['220111000', [4, 5, 6]],
        ['220000111', [7, 8, 9]],
        ['120120100', [1, 4, 7]],
        ['210210010', [2, 5, 8]],
        ['201201001', [3, 6, 9]],
        ['120210001', [1, 5, 9]],
        ['021210100', [3, 5, 7]],
        ['021210100', [3, 5, 7]],
        ['211210200', [1, 4, 7]],
      ].each do |board, positions|
        it "Knows which positions won" do
          Game.new(board).winning_positions.should == positions
        end
      end
    end
    
    describe '#pristine_mark' do
      let(:game) { Game.new '000000000' }
      subject { game.pristine_mark 1 }
      it { should be_an_instance_of Game }
      its(:board) { should == '100000000' }
      it 'leaves the original in its current condition' do
        subject
        game.board.should == '000000000'
      end
    end
    
    describe '.congruent?' do
      [ %w[100000000 001000000 000000100 000000001],
        %w[120000000 100200000],
        %w[100020000 001020000 000020100 000020001],
        %w[120000001 100200001],
        %w[100020100 000020101 001020001 101020000],
      ].each do |boards|
        specify "knows #{boards.inspect} are all congruent" do
          boards.each do |board1|
            boards.each { |board2| TTT::Game.should be_congruent(board1, board2) }
          end
        end
      end
      
      [ %w[100000000 010000000 000010000 120000000],
        %w[120000000 102000000 100020000 100000002],
        %w[110020000 101020000 100020001],
      ].each do |boards|
        specify "knows #{boards.inspect} are not congruent" do
          boards.each do |board1|
            boards.each do |board2| 
              next if board1 == board2
              TTT::Game.should_not be_congruent(board1, board2)
            end
          end
        end
      end
    end
    
    describe '.reflect_board' do
      specify 'abcdefghi should reflect to ghidefabc' do
        Game.reflect_board('abcdefghi').should == 'ghidefabc'
      end
      specify 'it should not mutate the original board' do
        board = 'abcdefghi'
        Game.reflect_board board
        board.should == 'abcdefghi'
      end
    end
    
    describe '.rotate_board' do
      specify 'abcdefghi should rotate to gdahebifc' do
        Game.rotate_board('abcdefghi').should == 'gdahebifc'
      end
      specify 'it should not mutate the original board' do
        board = 'abcdefghi'
        Game.rotate_board board
        board.should == 'abcdefghi'
      end
    end
    
    describe '.each_rotation' do
      let(:rotations) { %w[abcdefghi gdahebifc ihgfedcba cfibehadg] }
      subject { Game.each_rotation rotations.first }
      context 'when not passed a block' do
        it { should be_an_instance_of enumerator }
        its(:to_a) { should == rotations }
      end
      context 'when passed a block' do
        it 'yields each rotation' do
          boards = []
          Game.each_rotation rotations.first do |rotation|
            boards << rotation
          end
          boards.should == rotations
        end
      end
      it "isn't impacted by mutations" do
        Game.each_rotation(rotations.first).with_index do |rotation, index|
          rotation.should == rotations[index]
          rotation[2..5] = 'xxxx'
          rotations.first.should == 'abcdefghi'
        end
      end
    end
    
    describe '.each_congruent' do
      let(:congruents) { %w[abcdefghi gdahebifc ihgfedcba cfibehadg ghidefabc adgbehcfi cbafedihg ifchebgda ] }
      context 'when not passed a block' do
        subject { Game.each_congruent congruents.first }
        it { should be_an_instance_of enumerator }
        its(:to_a) { should == congruents }
      end
      context 'when passed a block' do
        it 'should yield each congruent board' do
          boards = []
          Game.each_congruent congruents.first do |congruent|
            boards << congruent
          end
          boards.should == congruents
        end
      end
      it "isn't impacted by mutations" do
        Game.each_congruent(congruents.first).with_index do |congruent, index|
          congruent.should == congruents[index]
          congruent[2..5] = 'xxxx'
          congruents.first.should == "abcdefghi"
        end
      end
    end
    
  end
end
