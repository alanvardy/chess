require 'board'

describe Board do
  before do
    allow($stdout).to receive(:write)
  end

  let(:board) { board ||= Board.new }

  describe 'when initialized' do
    context 'it first' do
      it 'creates an error array' do
        expect(board.errors).to be_an_instance_of(Array)
      end
    end
    it 'creates the board' do
      expect(board.board).to eq([[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                 [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']])
    end
  end

  describe '#add_pieces' do
    pending 'todo'
  end

  describe '#display' do
    pending 'todo'
  end

  describe '#horizontal_line' do
    pending 'todo'
  end

  describe '#select_square' do
    pending 'todo'
  end

  describe '#input_coordinates' do
    pending 'todo'
  end

  describe '#convert' do
    pending 'todo'
  end

  describe '#identify' do
    pending 'todo'
  end

  describe '#start' do
    pending 'todo'
  end

  describe '#create_players' do
    pending 'todo'
  end

  describe '#game' do
    pending 'todo'
  end

  describe '#change_player' do
    pending 'todo'
  end

  describe '#move' do
  end

  describe '#valid_move?' do
    pending 'todo'
  end

  describe '#clear_screen' do
    pending 'todo'
  end
end
