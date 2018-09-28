require 'spec_helper'
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
    # it 'creates 32 pieces' do
    #   expect(board).to receive(:board).exactly(32).times
    #   board.add_pieces
    # end
  end

  describe '#display' do
    pending 'todo'
    # it 'prints errors' do
    #   expect(board.row_number).to eq(%w[1 2 3 4 5 6 7 8])
    #   board.display
    # end
  end

  describe '#horizontal_line' do
    pending 'todo'
  end

  describe '#select_square' do
    before do
      board.instance_variable_set(:@player_turn, Player.new('Test', 'black'))
      board.add_pieces
    end
    it 'calls input_coordinates' do
      expect(board).to receive(:input_coordinates).and_return(nil)
      board.select_square
    end

    it 'returns if y is nil' do
      allow(board).to receive(:input_coordinates).and_return(nil)
      expect(board).not_to receive(:identify)
      board.select_square
    end
    context 'when piece color matches player color' do
      it 'calls #identify' do
        allow(board).to receive(:input_coordinates).and_return([0, 0])
        expect(board).to receive(:identify).with(0, 0)
        board.select_square
      end
    end
    context 'when piece color doesn\'t match players' do
      it 'doesn\'t call #identify' do
        allow(board).to receive(:input_coordinates).and_return([7, 7], nil)
        expect(board).not_to receive(:identify)
        board.select_square
      end

      it 'calls input_coordinates again' do
        expect(board).to receive(:input_coordinates).twice.and_return([7, 7], nil)
        board.select_square
      end
    end
  end

  describe '#input_coordinates' do
    pending 'todo'
  end

  describe '#convert' do
    context 'when given valid input' do
      it 'returns 2 valid integers' do
        expect(board.convert('b3')).to eq([2, 1])
      end
    end
  end

  describe '#identify' do
    pending 'todo'
  end

  describe '#start' do
    it 'calls #add_pieces' do
      expect(board).to receive(:add_pieces)
      allow(board).to receive(:create_players)
      allow(board).to receive(:game)
      board.start
    end
    it 'calls #create_players' do
      allow(board).to receive(:add_pieces)
      expect(board).to receive(:create_players)
      allow(board).to receive(:game)
      board.start
    end
    it 'calls #game' do
      allow(board).to receive(:add_pieces)
      allow(board).to receive(:create_players)
      expect(board).to receive(:game)
      board.start
    end
  end

  describe '#create_players' do
    pending 'todo'
  end

  describe '#game' do
    context 'until won? is false' do
      it 'loops twice' do
        expect(board).to receive(:won?).twice.and_return(false, true)
        allow(board).to receive(:display)
        allow(board).to receive(:select_square)
        allow(board).to receive(:clear_screen)
        allow(board).to receive(:move)
        allow(board).to receive(:change_player)
        board.game
      end
    end
  end

  describe '#change_player' do
    context 'when white players turn' do
      it 'sets turn to black players' do
        board.instance_variable_set(:@player_turn, "1")
        board.instance_variable_set(:@white_player, "1")
        board.instance_variable_set(:@black_player, "2")
        board.change_player
        expect(board.player_turn).to eq("2")
      end
    end
    context 'when not white players turn' do
      it 'sets turn to white players' do
        board.instance_variable_set(:@player_turn, "3")
        board.instance_variable_set(:@white_player, "1")
        board.instance_variable_set(:@black_player, "2")
        board.change_player
        expect(board.player_turn).to eq("1")
      end
    end
  end

  describe '#move' do
    context 'when @selected_piece is nil' do
      it 'creates an error' do
        board.instance_variable_set(:@selected_piece, nil)
        board.move
        expect(board.errors.length).to eq(1)
      end

      it 'doesn\'t call input coordinates' do
        expect(board).to_not receive(:input_coordinates)
        board.instance_variable_set(:@selected_piece, nil)
        board.move
      end
    end
    context 'when @selected_piece is " "' do
      it 'creates an error' do
        board.instance_variable_set(:@selected_piece, " ")
        board.move
        expect(board.errors.length).to eq(1)
      end

      it 'doesn\'t call input coordinates' do
        expect(board).to_not receive(:input_coordinates)
        board.instance_variable_set(:@selected_piece, " ")
        board.move
      end
    end
    context 'when a piece is selected' do
      it 'calls input_coordinates' do
        
      end

      context 'if move is valid' do
        it 'calls move_piece' do

        end
      end
      context 'if move is not valid' do
        it 'sets @selected_piece to nil' do

        end

        it 'sets @selected_coordinates to nil' do

        end
      end
    end
  end

  describe '#valid_move?' do
    pending 'todo'
  end
end
